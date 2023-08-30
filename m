Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4BB78D48D
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 11:22:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbHOU-0006xD-EU; Wed, 30 Aug 2023 05:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qbHOR-0006wb-PI
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:21:43 -0400
Received: from mail-dm6nam12on2061b.outbound.protection.outlook.com
 ([2a01:111:f400:fe59::61b]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qbHOO-0006J5-Bg
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:21:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OrEphYW6vsR8BTkh4JGYfVtPuIVRYN+Kz9CxWqpdJjSBOxDq6hB9VqE+CEzrA3hdX8ubuekUl6a/9Ur8ZukuNntqBydwKnwRZj6htX/gXnKlX5TXiM9tMKUNkRzSaCHzUgKZxtTjW2btcBTVc7UOPnXzCt0zDheyvmn8il8zhC7xl/3OZ1f98WZg2nejfr+vw2ixxhUGoJaxN1Tq1KFbiJVAszWNqFDtlItOL5yzYmbz2rF2S3vf+0nSxeVKOPUuarBLl4OUdaxOgx3SC0DDnJ2t0dX/FUg+xFEabnA3JBX8ypGAJB2lFTHgN/orhXT4bakqjCH4iKHgPH3S3oDoeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NrVy3dgnEMwXR5ospBFojhLc4+WUgS0mmBgMy096jQo=;
 b=cAgY8qpvFln7tR+X9tLJenrR7Ipvh7dCcE/gy3pClaKaxbAt4mMzVry7rj91YT3LKZjG/fmKTv/AtsMhB+s/AT3dZJQB4k7qPk84LzDRHaFIGgboT1c9f5lW3BuuPt5+vN9PE0TRFDZz/m/DNKypaUPGbhqi9qav7EB31av80qAFIEDnxHS4i/5uo7Pk80ptbirllgpWSe1zvEswXyJQWOMKUY9LvmiArQclFSz5vD6h0O14LhxaSgYp3k8fymnwUe8aokZp1OjyVViCBmudofyh++Zj34Apmxl6wisNkVUbs9KNeuI0I7l7lo9GMGrmQg+VhMjb/BKGirJdmRgTxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrVy3dgnEMwXR5ospBFojhLc4+WUgS0mmBgMy096jQo=;
 b=ILC3XQ8Y6Y0g3isGTgm9FjRAIJcc10PqfIDWGdRWmCs4ZyvvBnVve5+iWjZpa6IlipQ9JL1xzEA4CwES3FxHZH+EyitN2f0yaA48IoEUJJAAWyVlpjyLRHmyUUqntMFPccfQjK8gbgl2a2QcJSb1SnfxYa5ldc1deHub5FzHYil+p8bmls+AfvpQGEI3M25KvQzqkem2bj3l25XqD3DwS8lGGH2BvrdgzFGpVEm7lqPZ2FXQq9hfuO9Miv0CvjPoZm7dg2w9sJMiMsz3sVtOe/ve5DQd8PsbV5z7uXFqOhajNIJ7zwz8IwuIpcMtVce5WwCax3IQskmKMA9X6vv11g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SA1PR12MB6994.namprd12.prod.outlook.com (2603:10b6:806:24d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18; Wed, 30 Aug
 2023 09:21:36 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::42fd:b1c0:838c:5f96]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::42fd:b1c0:838c:5f96%4]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 09:21:36 +0000
Message-ID: <e3d3b6f8-2877-620e-66eb-6d3a53d65bc6@nvidia.com>
Date: Wed, 30 Aug 2023 12:21:29 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 5/6] vfio/migration: Block VFIO migration with postcopy
 migration
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Yanghang Liu <yanghliu@redhat.com>
References: <20230828151842.11303-1-avihaih@nvidia.com>
 <20230828151842.11303-6-avihaih@nvidia.com> <ZO4GTnuqSORbvePL@x1n>
 <b54f3ca5-9236-84a8-1b1f-9365925fa458@nvidia.com> <ZO44klknC6hpd7mf@x1n>
 <adb00739-3074-dc16-bb24-1e42cbbdd50a@nvidia.com>
 <b900cc98-49fe-219b-4be0-a4b8eb36e1a4@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <b900cc98-49fe-219b-4be0-a4b8eb36e1a4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0202CA0027.eurprd02.prod.outlook.com
 (2603:10a6:803:14::40) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SA1PR12MB6994:EE_
X-MS-Office365-Filtering-Correlation-Id: 37602732-89b2-4848-3ad5-08dba93a820d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KH8WNOjvu19q6mRB5nZnlbdN5dDi/BXQ5MOKgbPUzRr9x0thJBXARo84+VELGMv3g1Hwn/dKHE7HTtKPU3QpfKd9jjDgOKjxxbaI29xRKTypBjOi6m6Q3PH8h8hlkvv+5ka7YfzeAlJ+mXeE4Nbb9o+pte+1srwpdNN0M2SlyeUVp9Bzto2ghgXipIpMOXv1Bm8x8LfCWL3p2rE9VVkIXbPRhTNHZDZ0gDagrdeDaHPQlcTNkEcRpk7W6+KhCkG2CVNLE2JdvCqftioVCsL8MJDyOOBMrTwXKCCXrnomdYa2rpR2iypOcti+IqHReckang7sdkKEUBYBSQvZ1jT8xtthYcSBoGel6KlsPQTdiLrt4WvAg5Z6ZqjYmPUNJFOtIRjh7EcU4e9ZLMcQBQK90JkgccSxU2hbwnDMlzATT1TtIKq04q0N2mXDgDCwC5QCQ1ERA92/yvg3JduPHezyJsK/OY7bgc71/ZRK5tqVCSDNxFnzvpD1OWkdfFVeQ4DcVWsk23IKi6pLn2it9MeUGL7h1+21hjPnsaOvGx29OPmFBlCT9nGWTDDmMbQHicJWF700RpWqONDdrOAHSupfyDrJWFshwoKJ/NS2XJKovvrRaGMFz90mCN8UftrrYvJYzvq1PwX+/d+JTpw5nz9a2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(366004)(376002)(396003)(39860400002)(1800799009)(186009)(451199024)(8936002)(6666004)(110136005)(53546011)(478600001)(31686004)(66556008)(6506007)(66946007)(66476007)(54906003)(6486002)(316002)(38100700002)(41300700001)(6512007)(26005)(5660300002)(8676002)(36756003)(83380400001)(2906002)(31696002)(2616005)(86362001)(66574015)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUR6Q0Z5dnUxbzZkYVRGY3NBb3RrcXFzeDFRYkpZRk1rSDRkWEhxWG1zK20v?=
 =?utf-8?B?aHNpR0xiVzJNdmsvNC9leEhUQlMwVERDV3VjVE1KUHRLaFdMTXR2bG5SdjZo?=
 =?utf-8?B?TmhVN2MrbGcyRS80QUVQY083cXA1OWVTWkFHSTUyY0QrVk5EY25JVlFtbGNo?=
 =?utf-8?B?MmlUdmEwNkNhNzJwTFZUQTZMcGNtZmNaam5VeDRCVWIwdVZLS1RGT1hXZWVI?=
 =?utf-8?B?cFl4MnE1Y3FCYTlIelVwZlh6dFE1dkJGNENSSXhKNTlObGw5Z0xrdGQwbjA0?=
 =?utf-8?B?NUc4Q1UyV0JMUWRXekFlcUdIbDlrWHlsSFkxaldWZUZtRkRxS1Z3aDNoN3gz?=
 =?utf-8?B?OGlOWHliWlJwdFkvZ21IUkNHT0xmTDJ2SkhJbzYrK3BGS1BDMnBYQ0oxaEZW?=
 =?utf-8?B?em4wUGpQMlYvV2t3UTBVZnRwWFdTZGQ4OGR5R0s0aFNlbkRFeHV0TldVV0xG?=
 =?utf-8?B?aWJyTFlnZWhHQmlwQTYyT1RlcUtFeDJiVnRzZnhnb3dMY3lXaEpSU0JiUmE4?=
 =?utf-8?B?QmMzVVNUM0dsVkxqc2hnbFVKaGhXTzFBbWdYUHVuajY4QjVGbkp3K3pTaHh3?=
 =?utf-8?B?bHgzN2VYbTM1RmdxeERhZzBxZWtiVWF0cVM4bTNhdXdhaGFFOFZkNDh2cUxV?=
 =?utf-8?B?MnpZN0VkZ0pUSUdnaVhmQmthb1JMbVJhd0FQZFdFUkxGK0hGSEZBUnVZYXNO?=
 =?utf-8?B?MFlSOEpjU1pYaGlxcG9aZW1uOU5abzdMYmNpbVl3cVZjV0ZvaHI5NVhGNm5m?=
 =?utf-8?B?KzNKTDZVZDdlZ1lYdUYvRTNNZ3NBTndyYW5wRmIzZFpYRUh4SldxbEdOekQ3?=
 =?utf-8?B?bXN6bTFETzBvSTNEVzJsZzVYaTl4N09YQUtTZ29saFE5VEJrOTdyTTR1WEJO?=
 =?utf-8?B?WS9TTFBlR3pHaGtVZ3gwYW5yNFVVNTY2cjU1UWNaYjR4ZWl6SWpCWjhyN0hS?=
 =?utf-8?B?ZWc3dFZJTmt3dCt1ZzlYa2Y5NENvbjNsRW91MVNmREtEUHBzZFZCSFBEVHcr?=
 =?utf-8?B?dGFFbWVhZFpkL0RhVEFRY1N6Zmw2S1RFbUxrOU9lSDBXTFgxUi9PbUlPS29W?=
 =?utf-8?B?RmVweUo0UkhGRXNxakhUTzZWSVYweHZ5SEc5QkM4ZlNWTVFhS3hVQnNHSTRy?=
 =?utf-8?B?ZFJOdmZpSDFlUEhpK3hydGtuaWNZZGNuTGdzWEtLaWlVY0k4SUZHc0Z1UWdY?=
 =?utf-8?B?NnR3eUJ2WnRiY1pBMzdBR2NlalNtN1VwOFAzUi8vSXpVQnBTcnB0NjJsdm5L?=
 =?utf-8?B?Tmh2TE9QYVdlUFVxOU1CM1pyNjhYUHE0NG1rUDZ4NEwyd1JnaFIzR2dCVytO?=
 =?utf-8?B?cWxRMmVERlp0aUM5RjhtTW9EVFhUQ0RCTmtvZlBJdXFmZ1ZlZ1ppSHl4WHFR?=
 =?utf-8?B?Z1YzNFI5REVrRVNDKzRnNjZxYXpXZWhTL0VOYjFZS29DRFNPV2VwZk92UFJN?=
 =?utf-8?B?aFYxUVcxVngxeXlCdk1ObVIrTVN2Q3RKY2YzNlRoNTRPSmx4ekdLdjhGN2Za?=
 =?utf-8?B?NTF3TExLeW5pU3hpcWtEZWcvL2tIa3NBbU1jbXRaaUp3UWE1aWpUME9zV1Bh?=
 =?utf-8?B?WTY0Z08xYi9OY01tREowdW52U2pYVGpoQmdlVDN3RXB4YUtCVHlDNXZDdGdP?=
 =?utf-8?B?S08zWVp3NjN2ZllEbFVWK1N6ZDg4elpITmdabENPaGFLaG1qSE05d3RFazlN?=
 =?utf-8?B?TlRpUzNYak9pYXgyN2VjbmVWcllZS2NlZTFId3ZtZVN3aVZqek10OUViUTJ4?=
 =?utf-8?B?eVY1cVlrdm4xL0hkNXlieWJoZG9sY3JHUUhTOVBUVkhHVVlSQmU2MXhIYjhI?=
 =?utf-8?B?ZXZ4cUpuTG0zVWRzQkdyaDdhUzIrY1VDdzdudys0RTlCMGdGNWtlazVoUm0y?=
 =?utf-8?B?eU9hbTdOMzBIMHhWejAxTlBIRUNDZXljSENuMlVxWlFKK2MzalpUVHkreFM3?=
 =?utf-8?B?Rk8vS0R3NURuVWZyWWhTcTZrQktzOHdJak5idWFLaXJBdTVZb0JSV2swblRo?=
 =?utf-8?B?N0JzUkdBMkhMQXl2UmtGajEyTWN5dTVVc2FibndnMVdHS1VXVDlJUWZyMm9T?=
 =?utf-8?B?Q21jSWFVYlpDVloxQVlTUWdvL1kyU2k5OG9NSGhRZjZNS1JQaEdTOWxvdk5q?=
 =?utf-8?Q?CCyDIxhpQ3w9slptvcaW5kvKj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37602732-89b2-4848-3ad5-08dba93a820d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 09:21:36.0711 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YVO6QEY7ts/YSwQaYkxMd2x8B3WuPMtbN8nKnqjIsOfH1pEojdSyEC7i+i/qlxdsEXycbAxQasA3MZLNWikCAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6994
Received-SPF: softfail client-ip=2a01:111:f400:fe59::61b;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.242, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 30/08/2023 11:37, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> On 8/30/23 09:01, Avihai Horon wrote:
>>
>> On 29/08/2023 21:27, Peter Xu wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Tue, Aug 29, 2023 at 07:20:47PM +0300, Avihai Horon wrote:
>>>> On 29/08/2023 17:53, Peter Xu wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> On Mon, Aug 28, 2023 at 06:18:41PM +0300, Avihai Horon wrote:
>>>>>> diff --git a/migration/options.c b/migration/options.c
>>>>>> index 1d1e1321b0..e201053563 100644
>>>>>> --- a/migration/options.c
>>>>>> +++ b/migration/options.c
>>>>>> @@ -499,6 +499,11 @@ bool migrate_caps_check(bool *old_caps, bool 
>>>>>> *new_caps, Error **errp)
>>>>>>                error_setg(errp, "Postcopy is not yet compatible 
>>>>>> with multifd");
>>>>>>                return false;
>>>>>>            }
>>>>>> +
>>>>>> +        if (migration_vfio_mig_active()) {
>>>>>> +            error_setg(errp, "Postcopy is not compatible with 
>>>>>> VFIO migration");
>>>>>> +            return false;
>>>>>> +        }
>>>>> Hmm.. this will add yet another vfio hard-coded line into 
>>>>> migration/..
>>>>>
>>>>> What will happen if the vfio device is hot plugged after enabling
>>>>> postcopy-ram here?
>>>> In that case a migration blocker will be added.
>>>>
>>>>> Is it possible to do it in a generic way?
>>>> What comes to my mind is to let devices register a handler for a "caps
>>>> change" notification and allow them to object.
>>>> But maybe that's a bit of an overkill.
>>> This one also sounds better than hard-codes to me.
>>>
>>>>> I was thinking the only unified place to do such check is when 
>>>>> migration
>>>>> starts, as long as we switch to SETUP all caps are locked and 
>>>>> doesn't allow
>>>>> any change until it finishes or fails.
>>>>>
>>>>> So, can we do this check inside vfio_save_setup(), allow 
>>>>> vfio_save_setup()
>>>>> to fail the whole migration early?  For example, maybe we should 
>>>>> have an
>>>>> Error** passed in, then if it fails it calls migrate_set_error, so
>>>>> reflected in query-migrate later too.
>>>> Yes, I think this could work and it will simplify things because we 
>>>> could
>>>> also drop the VFIO migration blockers code.
>>>> The downside is that the user will know migration is blocked only 
>>>> when he
>>>> tries to migrate, and migrate_caps_check() will not block setting 
>>>> postcopy
>>>> when a VFIO device is already attached.
>>>> I don't have a strong opinion here, so if it's fine by you and 
>>>> everyone
>>>> else, I could change that to what you suggested.
>>> Failing later would be fine in this case to me; my expectation is VFIO
>>> users should be advanced already anyway (as the whole solution is still
>>> pretty involved comparing to a generic VM migration) and shouldn't 
>>> try to
>>> trigger that at all in real life.  IOW I'd expect this check will be 
>>> there
>>> just for sanity, rather than being relied on to let people be aware 
>>> of it
>>> by the error message.
>>
>> Yes, I agree with you.
>>
>>>
>>> Meanwhile the blocker + caps check is slightly complicated to me to 
>>> guard
>>> both sides.  So I'd vote for failing at the QMP command.  But we can 
>>> wait
>>> and see whether there's other votes.
>>
>> Sure.
>> So I will do the checking in vfio_save_setup(), unless someone else 
>> has a better idea.
>
> Just to recap for my understanding,
>
> vfio_save_setup() would test migrate_postcopy_ram() and update a new
> 'Error *err' parameter of the .save_setup() op which would be taken
> into account in qemu_savevm_state_setup(). Is that correct ?
>
Yes.
But I wonder if it would be simpler to call migrate_set_error() directly 
from vfio_save_setup() instead of adding "Error *err" argument to 
.save_setup() and changing all other users.
What do you prefer?

Thanks.


