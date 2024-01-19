Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54021832D90
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 17:55:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQs9h-0004xw-AQ; Fri, 19 Jan 2024 11:55:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ari@tuxera.com>)
 id 1rQs9f-0004xO-IF; Fri, 19 Jan 2024 11:55:43 -0500
Received: from mail-db3eur04on071b.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::71b]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ari@tuxera.com>)
 id 1rQs9c-0006AY-Sr; Fri, 19 Jan 2024 11:55:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGDUuKU0/z0IpLt1kKYHHXsDlEzZ4jGzXBBBXvAlTdajEttwNN6ayFPSbQQmdAixNrjNTsU9tOaKJ5XYKt943I7EdrmgIPYeVHVidQSjNN26s1kqg91z9n24vYun57Ev9xtWs6wQ5T71D5N3tS6gN13RSM4e627EBjbCd6B6gMJGFU1iI4gDlnhfiKDkOJwJWwJRZGw8tyxnzPvIyJrKBm+yHVdeuRQzsJFcMGDbu2pK+8Tw5jckHtdcEvyUP1+Ab4LqDNp0LRvBR3jga2s2LrJpXgGT5pSVpUWSbZcn85RTjBCIVdKBrROve4qKtjHp8ihEX2ZBV/vdw22q1jsDrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3aa2MeWP8gWxForyCyCN2g4gSSWyYj5gd8AlIhdu02c=;
 b=a+u2TC2CRmHtgIzNuEHOxJB3V1A3ITlMmd5Bsdd3m+P56OjWNh45sYfMYjBT44Sa8+BcdDhKQkxuRUeICv85cg3rPRa3F0fpaZzLOiDSpmTPRp1dsIp+p8Y6BGzFV/I7sKekJA3SDIkBNA6X1E8Hd73PopfsY4unESNh/gRRUXVr4lViT2h/BNlhkvbaCxjp72udNgrvRaaGAZsf7McYeNS1KdrkVjG9ZZqxuK8iJDBjm4q4Va9sinuDvD1Ps/wpkUK1UkxPP6QPaWw/itCJ5JNwkh18IqerrfIaooy5h1OCD3nnRv2ZrZhA2z+DK1BnquYdfqSLiS7oLsTVxQpLtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tuxera.com; dmarc=pass action=none header.from=tuxera.com;
 dkim=pass header.d=tuxera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3aa2MeWP8gWxForyCyCN2g4gSSWyYj5gd8AlIhdu02c=;
 b=Ib1yZC6nH2GFOd5bsj6jxneNhXdMIYBs6Rt/9vEOa+YqwKDDNr5AKJuHSfX8OmXyijuKNvsZFe6nRtYOjCusSEr7E8/eKtpJVV1fTiq51+w0JabLyjsOwDF0l05zHVjQOWQoBae9S0XjQSl5Eki9S41TiDfgNTaElscXZApxG4Y3p6u9fdTl6pZ+N6unEidsXOK3mQTuO7gdMrwZQvIRRi8pv9yteGf/oYAOILG7udiRiYaUPr4mqzrbzHt/b147s2LkmOjs/wAqrPjBU0/UitVbxHkzJ/uqA5fNw8FUWJOyCS/jZ7kpd9hFIoLAPmCBXibVs5sP1UXZMpRFjQ8Nog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tuxera.com;
Received: from DB9PR06MB7818.eurprd06.prod.outlook.com (2603:10a6:10:252::7)
 by VE1PR06MB6894.eurprd06.prod.outlook.com (2603:10a6:800:1aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 16:55:35 +0000
Received: from DB9PR06MB7818.eurprd06.prod.outlook.com
 ([fe80::9e26:58bf:b2c5:4bb5]) by DB9PR06MB7818.eurprd06.prod.outlook.com
 ([fe80::9e26:58bf:b2c5:4bb5%7]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 16:55:34 +0000
Message-ID: <2a910fa3-47b6-af14-af7d-fb49f0a225d4@tuxera.com>
Date: Fri, 19 Jan 2024 18:55:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] block/blklogwrites: Protect mutable driver state with
 a mutex.
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
References: <f1960d8d-352e-4e1b-4d28-7a110e272356@tuxera.com>
 <20240111163238.1346482-1-ari@tuxera.com> <Zal5kCm23APYc68D@redhat.com>
From: Ari Sundholm <ari@tuxera.com>
In-Reply-To: <Zal5kCm23APYc68D@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::15) To DB9PR06MB7818.eurprd06.prod.outlook.com
 (2603:10a6:10:252::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR06MB7818:EE_|VE1PR06MB6894:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d90a60d-0910-413a-dc2e-08dc190f7455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RB25cWdYHEcgPuFltAzQ7LX68MR8Tn5PMVsfiM91dY9sHU0jzaQGRKNcfONnEq8kyJFHGkDhzPrfeJAhTPMBFxmG/HMmP8D8ERklfSSoxX1nDXYGmYUTRiA3TgYpyCKS5Yrs0jCV5AAvBIPBuzF0oa+Kks5pr1wExCiDox6YcmhX8FTy2yGTPQOGL2eVYhRfjNs3MZ6af+b8tN+Rs8gASEyvqb6Mni7Z0jtLE/CcFzr2UMOLBO0oPwhjOXEeHrVTA0jwvs9VSgnfPm3ZD/EdWw2GcUZZ6L5TKTFBYb9S8gjDCop6sssfMbayd2+myqFnyOF/JeyoKFwTGuBzb2Cl9BRJpLJzggQrEJfGn7aBj0Pc5ZDNAww3KtAUtcE9lqejrVgFfSaHWMmlik8UlgT9XzpD13kimfngYG26ztu66utxtHIF/arEKZqnyaqbT4OtvjNzzi2LHfE0TuFFaUuchoBUiBfPMbq0wyCE82kupjWNsp3E2Ku2ErmFnXz0ZKWbyOJXgEA7wgYT5e0mqG4n09tL0VgNgvgq+66j1MGE81rjyByRfdixhirWLoWaFuRYvO8TBkmZbQP/mDFmgyj5Crh3vjXdq2mwKv5uJc2Hmf/kJBONypVI0714IM3bXx6futrU7xzE4k9cP7L9WO21Nw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR06MB7818.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39840400004)(376002)(346002)(136003)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(5660300002)(8936002)(4326008)(8676002)(26005)(31686004)(66556008)(66476007)(31696002)(66946007)(6486002)(53546011)(2906002)(6512007)(316002)(6506007)(86362001)(6916009)(36756003)(478600001)(2616005)(83380400001)(41300700001)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NG0yeTdtOG54dy9hbUZLRjdBWXY3Rk1yNmRreEpIL1ZDK1pIMzVNWnJRaDlt?=
 =?utf-8?B?MGc1ZFhFYzI0WVdnODF5enFtc3lVdnE1SXFQdzRtdjZRMFMwS1JjQXB5UWtt?=
 =?utf-8?B?VEp1ZDVQV3NtLzR0NjlSV0FyWU1wb3VDa05nYzEveE1LelVWek45VUMzbExh?=
 =?utf-8?B?T3N4cHAwZ3IzWVZiR25VZmF4azl2c0Qyd3l5TDVaQ05yWDBkYVIrLzBSSkpi?=
 =?utf-8?B?YWcyUDdSb1JZV3pTK2lzMi9kdkU0YWd6ejRjTXRXaTZBWWFZQmFpMVJST21O?=
 =?utf-8?B?MEJibGcyaUFqYTZPVkFtR2E5bEs5aHRTQVlpV3Z5V1BuWGU1aERTc29QQXVo?=
 =?utf-8?B?SWkwMmcwMFBIcGNob3pUZ05VMUdOS2t0WVpKVmx5RXYrYzZjdlNtMVVJT0xn?=
 =?utf-8?B?c1hoejRnWVBuMmJzOUFVNVo0eFBpMnlaZUExZ0RPdDYvazlwTk9WTWNaVU1a?=
 =?utf-8?B?QnBaakwwNW1FV2NxYzlKVzR5a0FMemNDL2tLTUNVUVlicHVMQ2tMdVpCUDBq?=
 =?utf-8?B?elB0SEI1MlhLUXRIQnAyVVFxc2RvT2hWZTQvRkF2U2NjdXJiYlptZnlEUWFK?=
 =?utf-8?B?Ym0wd2Fld3FYdVp6L2pSVTJYSC9sV29WZVluTW9oMzBnaDhGOGZhcU96eUR3?=
 =?utf-8?B?MndYZzFYRG9vOGNrR2UyalIxb1Q0ampPWFNZTlZ2ZVR4b2J0V0YxOEV0UlJ5?=
 =?utf-8?B?bW1LZWl3YXN5NlA2dGk1QmVWNUtIUmtKKzRXSG9tOGVSVnIyVzBiN0ltempk?=
 =?utf-8?B?NjhQYkphMVEwbW42Q28ydWV5NUVzT09VK2crWjZ5MkJhc1JGYVFHVUVZY2lJ?=
 =?utf-8?B?dVBucTJSUVdiZlIyMjBLSmVCWFVDcFNJSVF4bVNMbkEyMlFvaVVaQ3NHNjE5?=
 =?utf-8?B?N0tqT3VaRm5YbnN4YUwvUFBoc0lFNXpoS2tla3JIS0lETVloTi8rS2hwMitT?=
 =?utf-8?B?WHVrbXNFZVMyS3hLMWJkeWZuNjhhdWtDaUxQR0tsUkpvL1pXS1M3b2hSMGJs?=
 =?utf-8?B?U1IxU25zZ3VSaWIvcHB4cVdRQjNUYklENmZJRjBteHdBdEFqeWw5a0o1aTho?=
 =?utf-8?B?OVJwb3F6TkRDWjlSWmthOHFRV1pGQWdGWVZhMFl3dzZUanJZZ25HSUIydVVW?=
 =?utf-8?B?dWMrVHJtcHZWOTMyMDlQWk81dlNxMTNDbnBSYmdFS251RitaZ1FJdDF1OCs4?=
 =?utf-8?B?YW9BT2E1c3RFZ01idG95d2M4d0NoRkdFOGhHRkFobGlOTzJrUGV5aWQ2VERM?=
 =?utf-8?B?bi82WFlCUEhtV1R4V3duWGp5emJyOWt1N0VwMHgvVkdCRDhseSttTlArRnI2?=
 =?utf-8?B?blgrbW42cDZrRWk4eC9kTUIyY0JneXNva1ZNWjdXTzdrUThwTTd3Sm1UUGpp?=
 =?utf-8?B?SHFUcWRNamZBS0VoZmRVczdOUzYrUGZiS1NwT0IrVUhUMEVmVzlBc0ttcjJL?=
 =?utf-8?B?M0ZSZ0NWM0EvK2lmalhkQi9uVktoV1JCMzlkRUlqcEl5b2NFSWZ5TXJRUUVl?=
 =?utf-8?B?dkhiOXNMMmJ1aDErMFN6ZVp2cVFzSHM1VDROeVNvOWpoNE9STHhzVTRoaksz?=
 =?utf-8?B?bU9jVFlTVGdtZ2QyRWxOR0x2aUtoVStSKzdBYWFVSUl5UVVTOXNoaUIrNkt4?=
 =?utf-8?B?L2F1VmFuWGQwV0grYVNkcCtWUWNvSXlrUDBLYmNoRUwyMTNva2NlcS9xa09Q?=
 =?utf-8?B?WVpWRUFQdE1EcHlodlI3cTFoekxFM3ludHVpTTJxaFVkTWR5KzlTaW5CazBy?=
 =?utf-8?B?ZmRDek9SeXpXMGxnRWdwWDNFMHZuRWdWZnFuVkhxNVRtVVhyODZLeHF4aGpM?=
 =?utf-8?B?ZTh0Sk4zTjY4LzdwYWxDZGQ5MnAxazFJVitrNmI0ZmRqYkVFb1llZWw3a1JS?=
 =?utf-8?B?OHVNbE1lbm1xSG5hc3VOQjRiVmtaVUJwTHJpdW1FYzk2dy9xemxkWUxNQWhj?=
 =?utf-8?B?bXZORXNSOHZyTys4aGZBNkVEc0lxdjl6b2wzMkY4R0dTT0lTa3ZyZUpOUXIr?=
 =?utf-8?B?WTFQWU9UYXQyci9WTHJ4SlBoQnBTYm1aSjMvblRwQWlPdk95N0FPVU0rQ2tS?=
 =?utf-8?B?eDdXWXkrVlpjd3g3dHdzUDN6MllFSXVadUZNK1p6cnFNMlNiNHVObjRGbGF5?=
 =?utf-8?Q?f/oo=3D?=
X-OriginatorOrg: tuxera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d90a60d-0910-413a-dc2e-08dc190f7455
X-MS-Exchange-CrossTenant-AuthSource: DB9PR06MB7818.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 16:55:34.7963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e7fd1de3-6111-47e9-bf5d-4c1ca2ed0b84
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SsX9Gq+ipGA65aFZ3SqLTtwfKZJEOK66TGWlSG1QAm8bXVK/eupzb3hkPfmPb9Wr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR06MB6894
Received-SPF: pass client-ip=2a01:111:f400:fe0c::71b;
 envelope-from=ari@tuxera.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.044,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 1/18/24 21:18, Kevin Wolf wrote:
> Am 11.01.2024 um 17:32 hat Ari Sundholm geschrieben:
>> During the review of a fix for a concurrency issue in blklogwrites,
>> it was found that the driver needs an additional fix when enabling
>> multiqueue, which is a new feature introduced in QEMU 9.0, as the
>> driver state may be read and written by multiple threads at the same
>> time, which was not the case when the driver was originally written.
>>
>> Fix the multi-threaded scenario by introducing a mutex to protect the
>> mutable fields in the driver state, and always having the mutex locked
>> by the current thread when accessing them. Also use the mutex and a
>> condition variable to ensure that the super block is not being written
>> to by multiple threads concurrently.
>>
>> Additionally, add the const qualifier to a few BDRVBlkLogWritesState
>> pointer targets in contexts where the driver state is not written to.
>>
>> Signed-off-by: Ari Sundholm <ari@tuxera.com>
>>
>> v1->v2: Ensure that the super block is not written to concurrently.
>> ---
>>   block/blklogwrites.c | 77 +++++++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 69 insertions(+), 8 deletions(-)
>>
>> diff --git a/block/blklogwrites.c b/block/blklogwrites.c
>> index ba717dab4d..f8bec7c863 100644
>> --- a/block/blklogwrites.c
>> +++ b/block/blklogwrites.c
>> @@ -3,7 +3,7 @@
>>    *
>>    * Copyright (c) 2017 Tuomas Tynkkynen <tuomas@tuxera.com>
>>    * Copyright (c) 2018 Aapo Vienamo <aapo@tuxera.com>
>> - * Copyright (c) 2018 Ari Sundholm <ari@tuxera.com>
>> + * Copyright (c) 2018-2024 Ari Sundholm <ari@tuxera.com>
>>    *
>>    * This work is licensed under the terms of the GNU GPL, version 2 or later.
>>    * See the COPYING file in the top-level directory.
>> @@ -55,9 +55,34 @@ typedef struct {
>>       BdrvChild *log_file;
>>       uint32_t sectorsize;
>>       uint32_t sectorbits;
>> +    uint64_t update_interval;
>> +
>> +    /*
>> +     * The mutable state of the driver, consisting of the current log sector
>> +     * and the number of log entries.
>> +     *
>> +     * May be read and/or written from multiple threads, and the mutex must be
>> +     * held when accessing these fields.
>> +     */
>>       uint64_t cur_log_sector;
>>       uint64_t nr_entries;
>> -    uint64_t update_interval;
>> +    QemuMutex mutex;
>> +
>> +    /*
>> +     * The super block sequence number. Non-zero if a super block update is in
>> +     * progress.
>> +     *
>> +     * The mutex must be held when accessing this field.
>> +     */
>> +    uint64_t super_update_seq;
>> +
>> +    /*
>> +     * A condition variable to wait for and signal finished superblock updates.
>> +     *
>> +     * Used with the mutex to ensure that only one thread be updating the super
>> +     * block at a time.
>> +     */
>> +    QemuCond super_updated;
>>   } BDRVBlkLogWritesState;
>>   
>>   static QemuOptsList runtime_opts = {
>> @@ -169,6 +194,9 @@ static int blk_log_writes_open(BlockDriverState *bs, QDict *options, int flags,
>>           goto fail;
>>       }
>>   
>> +    qemu_mutex_init(&s->mutex);
>> +    qemu_cond_init(&s->super_updated);
>> +
>>       log_append = qemu_opt_get_bool(opts, "log-append", false);
>>   
>>       if (log_append) {
>> @@ -231,6 +259,8 @@ static int blk_log_writes_open(BlockDriverState *bs, QDict *options, int flags,
>>           s->nr_entries = 0;
>>       }
>>   
>> +    s->super_update_seq = 0;
>> +
>>       if (!blk_log_writes_sector_size_valid(log_sector_size)) {
>>           ret = -EINVAL;
>>           error_setg(errp, "Invalid log sector size %"PRIu64, log_sector_size);
>> @@ -255,6 +285,8 @@ fail_log:
>>           bdrv_unref_child(bs, s->log_file);
>>           bdrv_graph_wrunlock();
>>           s->log_file = NULL;
>> +        qemu_cond_destroy(&s->super_updated);
>> +        qemu_mutex_destroy(&s->mutex);
>>       }
>>   fail:
>>       qemu_opts_del(opts);
>> @@ -269,6 +301,8 @@ static void blk_log_writes_close(BlockDriverState *bs)
>>       bdrv_unref_child(bs, s->log_file);
>>       s->log_file = NULL;
>>       bdrv_graph_wrunlock();
>> +    qemu_cond_destroy(&s->super_updated);
>> +    qemu_mutex_destroy(&s->mutex);
>>   }
>>   
>>   static int64_t coroutine_fn GRAPH_RDLOCK
>> @@ -295,7 +329,7 @@ static void blk_log_writes_child_perm(BlockDriverState *bs, BdrvChild *c,
>>   
>>   static void blk_log_writes_refresh_limits(BlockDriverState *bs, Error **errp)
>>   {
>> -    BDRVBlkLogWritesState *s = bs->opaque;
>> +    const BDRVBlkLogWritesState *s = bs->opaque;
>>       bs->bl.request_alignment = s->sectorsize;
>>   }
>>   
>> @@ -338,15 +372,18 @@ blk_log_writes_co_do_log(BlkLogWritesLogReq *lr)
>>        * driver may be modified by other driver operations while waiting for the
>>        * I/O to complete.
>>        */
>> +    qemu_mutex_lock(&s->mutex);
>>       const uint64_t entry_start_sector = s->cur_log_sector;
>>       const uint64_t entry_offset = entry_start_sector << s->sectorbits;
>>       const uint64_t qiov_aligned_size = ROUND_UP(lr->qiov->size, s->sectorsize);
>>       const uint64_t entry_aligned_size = qiov_aligned_size +
>>           ROUND_UP(lr->zero_size, s->sectorsize);
>>       const uint64_t entry_nr_sectors = entry_aligned_size >> s->sectorbits;
>> +    const uint64_t entry_seq = s->nr_entries + 1;
>>   
>> -    s->nr_entries++;
>> +    s->nr_entries = entry_seq;
>>       s->cur_log_sector += entry_nr_sectors;
>> +    qemu_mutex_unlock(&s->mutex);
>>   
>>       /*
>>        * Write the log entry. Note that if this is a "write zeroes" operation,
>> @@ -366,17 +403,34 @@ blk_log_writes_co_do_log(BlkLogWritesLogReq *lr)
>>   
>>       /* Update super block on flush or every update interval */
>>       if (lr->log_ret == 0 && ((lr->entry.flags & LOG_FLUSH_FLAG)
>> -        || (s->nr_entries % s->update_interval == 0)))
>> +        || (entry_seq % s->update_interval == 0)))
>>       {
>>           struct log_write_super super = {
>>               .magic      = cpu_to_le64(WRITE_LOG_MAGIC),
>>               .version    = cpu_to_le64(WRITE_LOG_VERSION),
>> -            .nr_entries = cpu_to_le64(s->nr_entries),
>> +            .nr_entries = const_le64(0),
>>               .sectorsize = cpu_to_le32(s->sectorsize),
>>           };
>> -        void *zeroes = g_malloc0(s->sectorsize - sizeof(super));
>> +        void *zeroes;
>>           QEMUIOVector qiov;
>>   
>> +        /*
>> +         * Wait if a super block update is already in progress.
>> +         * Bail out if a newer update got its turn before us.
>> +         */
>> +        WITH_QEMU_LOCK_GUARD(&s->mutex) {
>> +            while (s->super_update_seq) {
>> +                if (entry_seq < s->super_update_seq) {
>> +                    return;
>> +                }
>> +                qemu_cond_wait(&s->super_updated, &s->mutex);
> 
> This will block, which is exactly what you want if another thread is
> writing the super block.
> 
> However, in a single-threaded case where it's just the previous request
> coroutine that is still writing its super block (i.e. bdrv_co_pwritev()
> below has yielded), this will deadlock because we'll never switch back
> and actually complete the previous super block write.
> 
> So unless I'm missing a reason why this won't happen, I think you need a
> coroutine aware mechanism here. The obvious options would be using a
> CoMutex in the first place and holding it across the I/O operation or
> keeping the cheaper QemuMutex and replacing the condition variable with
> a CoQueue.
> 

Yup. Indeed, you are right. It took me a while to see why. Thanks for 
pointing this out. I had not properly considered the fact that QemuCond 
does not yield on entering a wait in coroutine context.

Posted v3, where the condition variable has been substituted with a 
CoQueue. Hopefully I did it right this time.

If I am reading the CoQueue implementation correctly, this should have 
an additional bonus of fairness among the pending super block updates 
due to the execution order imposed, and it also appears that spurious 
wakeups might not be an issue like they would be with pthread condvars? 
I am not relying on these properties in the v3 patch, though.

Best regards,
Ari Sundholm
ari@tuxera.com

>> +            }
>> +            s->super_update_seq = entry_seq;
>> +            super.nr_entries = cpu_to_le64(s->nr_entries);
>> +        }
>> +
>> +        zeroes = g_malloc0(s->sectorsize - sizeof(super));
>> +
>>           qemu_iovec_init(&qiov, 2);
>>           qemu_iovec_add(&qiov, &super, sizeof(super));
>>           qemu_iovec_add(&qiov, zeroes, s->sectorsize - sizeof(super));
> 
> Kevin
> 


