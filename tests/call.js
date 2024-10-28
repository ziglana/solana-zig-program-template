const solanaWeb3 = require('@solana/web3.js');

(async () => {
    const connection = new solanaWeb3.Connection(solanaWeb3.clusterApiUrl('devnet'), 'confirmed');
// 7mfvzEhWnqW1Q1fXry2AuRZ3b1WKfUusT9rmKWSoadYR
    const secretKey = new Uint8Array([66,78,100,72,69,247,86,146,97,123,140,118,83,118,52,209,5,143,226,247,164,150,164,84,235,118,237,0,85,187,156,32,100,151,178,68,194,202,241,132,39,77,242,147,33,199,165,68,15,59,115,18,174,48,96,120,245,23,247,81,57,125,93,22]);

    const payer = solanaWeb3.Keypair.fromSecretKey(secretKey);

    // const airdropSignature = await connection.requestAirdrop(
    //     payer.publicKey,
    //     solanaWeb3.LAMPORTS_PER_SOL,
    // );

    //await connection.confirmTransaction(airdropSignature);

    const programId = new solanaWeb3.PublicKey('CcGtVtXVeQrYXEcbeedDgXYQoFoBiSMvmWRw9PzioXxp');

    const transaction = new solanaWeb3.Transaction().add(
        new solanaWeb3.TransactionInstruction({
            keys: [],
            programId,
            data: Buffer.from([]), // no data in this example
        }),
    );

    await solanaWeb3.sendAndConfirmTransaction(connection, transaction, [payer]);

    console.log('Transaction successful');
})();
