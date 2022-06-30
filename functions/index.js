const functions = require("firebase-functions");
const admin=require("firebase-admin");
admin.initializeApp();
const database = admin.firestore();


exports.sendNotification = functions.pubsub.schedule('* * * * *').onRun(async (context) => {

    const query = await database.collection("jadwal")
        .where("jadwal", '<=', admin.firestore.Timestamp.now())
        .where("status", "==", false).get();
    console.log(query);
    query.forEach(async snapshot => {
        sendNotification(snapshot.data());
        await database.collection('jadwal').doc(snapshot.id).update({
            'status':true
        });
    });

    function sendNotification(data) {
        let androidNotificationToken=data.token
        let title = "Waktunya Minum Obat,"+data.nama;
        let body = "Jangan lupa untuk minum "+data.obat+", batas konsumsi obat adalah 2 Jam!";

        const message = {
            notification: { title: title, body: body },
            token: androidNotificationToken,
            data: { click_action: 'FLUTTER_NOTIFICATION_CLICK',},
        };

        admin.messaging().send(message).then(response => {
            return console.log("Successful Message Sent To "+data.nama);
        }).catch(error => {
            return console.log("Error Sending Message To "+data.nama);
        });
    }
    return console.log('End Of Function');
});

