const functions = require("firebase-functions");
const admin=require("firebase-admin");
admin.initializeApp();
const database = admin.firestore();


exports.sendNotification = functions.pubsub.schedule('* * * * *').onRun(async (context) => {
    //check whether notification should be sent
    //send it if yes

    const query = await database.collection("jadwal")
        .where("jadwal", '<=', admin.firestore.Timestamp.now())
        .where("status", "==", false).get();

    query.forEach(async snapshot => {
        sendNotification(snapshot.data().token);
        await database.collection('jadwal').doc(snapshot.id).update({
            'status':true
        });
    });

    function sendNotification(androidNotificationToken) {
        let title = "Waktunya Minum Obat!";
        let body = "Jangan lupa untuk minum obat, batas konsumsi obat adalah 2 Jam!";

        const message = {
            notification: { title: title, body: body },
            token: androidNotificationToken,
            data: { click_action: 'FLUTTER_NOTIFICATION_CLICK' }
        };

        admin.messaging().send(message).then(response => {
            return console.log("Successful Message Sent");
        }).catch(error => {
            return console.log("Error Sending Message");
        });
    }
    return console.log('End Of Function');
});

