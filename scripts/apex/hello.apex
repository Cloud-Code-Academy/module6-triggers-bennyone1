Account testAccount = new Account(Name = 'Test Account', Industry = 'Banking');
        insert testAccount;

        List<Opportunity> opportunitiesToInsert = new List<Opportunity>();
        for (Integer i = 0; i < 400; i++) {
            Opportunity opp = new Opportunity(
                Name = 'Test Opportunity ' + i,
                CloseDate = Date.today().addDays(i),
                StageName = 'Closed Won',
                Amount = 6000,
                AccountId = testAccount.Id
            );
            opportunitiesToInsert.add(opp);
        }
        insert opportunitiesToInsert;
        delete opportunitiesToInsert;
