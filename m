Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EE9729F7A
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 18:00:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7c8i-0000VR-1s; Fri, 09 Jun 2023 09:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1q7c8T-0000LM-Ie; Fri, 09 Jun 2023 09:26:42 -0400
Received: from mail-db3eur04on2138.outbound.protection.outlook.com
 ([40.107.6.138] helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1q7c8Q-0001Ql-1J; Fri, 09 Jun 2023 09:26:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2T6WUb9LJfa9PeP8B1Riu6MqS+o2ryy0CTJHjpmRCNu3cqOHAsTc50alkcDevk9dcT4ilqUt3lQrQyPl8UErO9OluGD8wSQRkz6fnNuE7tbOJ3KfA7f+hxMRh5fvxJqVt9e19mCobcKP+Ds1BRJGYr2fLcbqytjvjugvlLFMxvfO7fUzHGcXvYrAT6N/EQ1BvgZhnWgE5kRSK5rqaPWppRH5MT16ML/9McLusmQAdu/SFig/dm8lWb7ZKeby9zojq8oEJJN5AGDe/5e2FbEksTi58nBcxdQr5+Vj5sCdibSq9UrUhiuQqf5UGZMXl3jBU2A67NIrLp50CVyn1dGHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFGIXINJf1Rbnt5xbsfDvNkPHjenwd2FawnhRXw+tTw=;
 b=eIjWlg7yDFxp/7rU4TM7zlNDLQEZGWSjrXgtP4e2vQuJs4lQdnkyxcAoM0ivrHH3JNqyMYuDfXmvBtRMTXHkrtkB5iAAU4nDnI3l1tZ/3aWDJuFdcLzlpgpzkarsSVzrFBmOa9EKE7Qlo8wY6kGzARTOerehtYXokEWOPvMHFcxE4PRrkjjn/SJ5y+xi09mIsYW3UVloSDcaa2WT2y01Emw4YnWxOVtyiEzdwfSD5+IgkGuzq2XykNNOz3VCgwzF4eNbQBDUIcgERecdkiC1CDhd6jfJnRQgFoHZLBG4BxnVbWEt+5rTJrsGqyWiWqBM0c6C0wgYsjCyn/1o8i0BmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFGIXINJf1Rbnt5xbsfDvNkPHjenwd2FawnhRXw+tTw=;
 b=HeIEa17Vfrr1MNeN82e41v42VCZd97gmI96Yi7XysajsoHdcSrDeQMm2MvB//iv4qmmmAXDmPrTGgXBac5GhWJbXXot8Rqt+P/M1ZiULivGW90neJlbFJJ9iCGp3NA8aTlr9SwmqbrDHjTlvzk4jl2+N5DAS1h94AwL9vCyVBMW2d83yPdiMWrbdSkIBLlT7CUdeRUoqBpZNppBI5KhOMvifMG5RGbjUmypXZtreJhRqatFHahKqIclJ33efsXTrX18rYtLiMDUHiRqwdE+fNqWRpJslWmiRk6il5fj+3Be6c1V2FXnKdPi3BNP9KEERIVB35+ilcsaI8GeW0LqzjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by AS4PR08MB7630.eurprd08.prod.outlook.com (2603:10a6:20b:4cd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Fri, 9 Jun
 2023 13:21:21 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243%6]) with mapi id 15.20.6477.016; Fri, 9 Jun 2023
 13:21:20 +0000
Message-ID: <e22757a4-9853-9044-3a3f-6d8f0e486bb3@virtuozzo.com>
Date: Fri, 9 Jun 2023 15:21:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 5/5] parallels: Image repairing in parallels_open()
Content-Language: en-US
To: Hanna Czenczek <hreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com
References: <20230529151503.34006-1-alexander.ivanov@virtuozzo.com>
 <20230529151503.34006-6-alexander.ivanov@virtuozzo.com>
 <32385c08-0c72-bf53-d5bb-5fa13dce7089@redhat.com>
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <32385c08-0c72-bf53-d5bb-5fa13dce7089@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0133.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::26) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|AS4PR08MB7630:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cd18a68-66f3-44be-cdd5-08db68ec6a40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X9P8KvZ4Kk1tgDkQCQKERH7Axilg5doLbcAGWx+KDooBhwaKBcjmomgGV3KSp4ojW+bPBGBlsVrYaNig6iF86Dz8uhjOeum2xPS1QjgknVyMFMeOz3v2iLpaCzlhumVXhQpgJWEfwshFGrRWz0f7dlvENJxYtZG+ioM+q30m8t8LA5H8R2P16D+XPJXiXK6giDImL+kT1Fr6F2+KMqrVL5IB6p2c7VfXgXgDWdfe98v9pGoTFA68KFdYoIA1lHV/w2UdHleRdk1zCusIc1VhPL2KKbWQMSUIFu/biINOgGDE/huQsKzWIG2zj7V71gEaOBOY6Gzxbf+o7KK4vz0QU6EsiOCAp9U7WWc3lvkY7UbXCUJmK7/Ejv78MvTd+43BlscnYS96ZoZGLR6uJnla/d1cjVyT2B8U5FvZuxmdaYps4yYZDL32Y5pd1Be/pIAiUgh5cI1r4CMe+4mxT10aHXWBOzNdq1YcXNzt4HJCYEPB96W/KgAZP48YjhvvakIJCF/LVPjuD/+u4WtwKv2jVrAigHaJP3QgkkB0+tXyF0DgWrKYYYfxaWGQMIdcOpOmxrGDYhJsUKM2LLrQS0zHjy+jFea4YhzJPNQ/eWxYMDSPs90uqukz4bMMjJcRK/7gsb1b6GJwHmDFmm1OmY4la+UkG9g3uGo8Y99c63PuX9XpDtSAVP9eb4+FauA5exeX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39850400004)(346002)(396003)(136003)(366004)(376002)(451199021)(2906002)(36756003)(31696002)(86362001)(8936002)(38350700002)(38100700002)(41300700001)(5660300002)(478600001)(8676002)(316002)(44832011)(26005)(4326008)(66556008)(66946007)(31686004)(66476007)(83380400001)(6506007)(2616005)(53546011)(6512007)(186003)(52116002)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUE5SGt4bDJYUkFqeU5aTjh4UTk2em0rTERocEZ3MVE0WTA0aGdyMTdEKzRG?=
 =?utf-8?B?OUtTR1lOTnNyK0p4RHVkVzhzNmRNVGloMElLem5Dd2xURStpWUVVLzdTcXpw?=
 =?utf-8?B?dVFPbzVZMlZLcTcxRjNoVHJsaGFlaTVTaTM0dXl6aGpOUWY5cnZaZytKVTlR?=
 =?utf-8?B?YURtNmljQWFDNkRXV3pQbklPdmphMk1sNlVBTGdqSjVRU2UwcktSNVNoMnJ1?=
 =?utf-8?B?dVd2SzFMcUFFZlBPbjNSbk1scnQ0WHMrN2NqZERGOUJrZmZUWkw4L0htelEy?=
 =?utf-8?B?NkZtUXhZSUtkdEpiRUc4bFVHQWk0STRDU3FPM2g1N0dFcEZ6SmpvMi9Eb1BK?=
 =?utf-8?B?cXQzVVgzNWFVbnBnd1hOd1hLV2RCMXpDVzhOYjFpZmFkUjZMck5xNGRGb290?=
 =?utf-8?B?LzVIR1poQUhqV2NQYy9rQ21GVmdSbTE4TUpQREUweVZYdFJLRnUwUis5bkgy?=
 =?utf-8?B?L3B3SFFqaDFuYVN5NDBLZ0ZGUmp3eW9qNnFJbmhuNlI4TCt2RVMrNFQxUVE5?=
 =?utf-8?B?UVQ3d0R2YkRhWWc2MThJdEs3SzlXNVJSaE5FQm5DNEVXdjhOSG1JZ0ZjNFJm?=
 =?utf-8?B?dXpxN3ViZ3BuRlRYcEZUNktCU2FSdEUxQ1BHcnkwSXJiRFRHS0IrU3BIYUwx?=
 =?utf-8?B?MWRDZUJNQVEvREdLeTVCT0xBUWJscmZBMnlFcmZKRE1Qak1qR1BWNDZIclNK?=
 =?utf-8?B?MWRhcU52T0UrVUZiOXpsZ0IxaERyNSs3azZ2MysyR1oyUWRuVGhvYkZJc3hk?=
 =?utf-8?B?dXpoZjZBdkJOYWxQRitEQ3JnM2JteTJ6cE05bVliYkNMdHppRS9YdXZuU1ND?=
 =?utf-8?B?b3l3Z1YvT0QydHlrcXFNL25nZUo5ZmQ3UHE3ZnNWdzRRUlFrSytvWmZORzUx?=
 =?utf-8?B?NGhtTnF5UGhxbVdFMERHN0VrR0JRbU9RdVZodjdQQk1OOXlUQUZqbWk3K1BZ?=
 =?utf-8?B?cTV0dG91aGJTZXh0UkdCeEZ1YUNiSzNYOElsUjBmMEU3aFkrOXk4dXkwR3F5?=
 =?utf-8?B?RWljdlZjME91QTR3N1NoeTA3aXZRTE94ajhISkhaZWZmQmh0ZUJXZ1R5L3Uz?=
 =?utf-8?B?VjhmbWdYc1J1TFhDcCtiOWREM2tMUDBWUk5xMGcyRUMwYU5RTncwSFgvc3Jv?=
 =?utf-8?B?TWQxcEJaL09obTlLQW9OM1VSUDlxWjI3WlNiYmdQdHhjUjNnNDMzaGRSMTlD?=
 =?utf-8?B?akFZYjE0a1JmZlZLcXBTU1FtVHNSM3FiVFpHNkI3SnR0TmpqOXVPUmYvUURn?=
 =?utf-8?B?cm9sYzhiRGRIZXJ5OHRVdWtYTXdQZ29TYzdEd3U5U1IrcHBVYmUvdGpaMWlx?=
 =?utf-8?B?ZUhpeU0wSCtGZU1qNEY3aFVhdUhHSkJTUmh3Q2svanpEVHNVM2luMU5QRXBt?=
 =?utf-8?B?N1BlTUZGQWo2emdOVG9WU3N4cGZ1SEttaGlEY1l4NDZTL1ZQc3k2VEVKazVL?=
 =?utf-8?B?WmdZN05xQUNxMFNsZDFUYWNqbjZuVWgyTk50Ty9VTWxqMWhod0R0eXhUMHBJ?=
 =?utf-8?B?bHZ2aEpKTmtwL3BKL1pkZVVWczRrdzhNQXpUTG5nVThGN2k2NlpaUlo3ellI?=
 =?utf-8?B?aVZFQ2VWa1lOelJMSVd4V3I4ZGJMY1JsTW5FYWJHTkpSYUt3QUtYdmkyM01P?=
 =?utf-8?B?R1R3S2hzRy9MSy96enlQOFNjbnRQM1JwSzhlbjYvRzFrQUVlUjFVaUJhNnJm?=
 =?utf-8?B?MkMyQUhtWVJBMnluUEZDYzRxeWdrNGhJWGVHbDJidm9lSXJoUTgxL3JaWlBI?=
 =?utf-8?B?WTFvNVJ6am40KzdzWEZOeFVwWW1qTml6TXBVdlhaSEppeVk1a1haR05qQ05N?=
 =?utf-8?B?MkZia1dCK2xVaEJQNlh1OUx1VjhtZ0ZYKzdYWldjV2Y0TG91clhtUFAyMExi?=
 =?utf-8?B?cElvWDZUZHQrTW5wWDFXbVJvd2J3M3VqQi9zTnc0bmVnblIrNEdhZTVwbFQ3?=
 =?utf-8?B?cHdzeWRyeFNJOWJraFBSdzM4TEg5U1Nlc2NtU3ZCRElyeG43d25Vbjc1ZEhI?=
 =?utf-8?B?VjNNZmJoemp2eWlFN1hsOG0weEM5Y1RRR2ZxVDVjR2ZIR2cyaGF5NmsvVVF4?=
 =?utf-8?B?QXAyYlRlQXFqT1FPSzBEdzRMQnJpSmIvaWduMU12eUJ6LzNVWEt4a0wxWGps?=
 =?utf-8?B?RHYrTi8zS093TTJWcm1jbVpLZ3NUU2ZHUFArOW9DczQyNjlGcituWCtCVG4y?=
 =?utf-8?Q?8iZ/s4Pz5XN68fwc4LwKh3s=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd18a68-66f3-44be-cdd5-08db68ec6a40
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 13:21:20.8740 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jer+g1kHNSCA8pQe1fD6JqkqkZhiHI2NGAvj0bU+KGLsNc5p6cqjf+lfsSo6dW7bwlHBSfUuoeOmQAD5OSjn206TrkIYKV45TSzCKjzb/7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7630
Received-SPF: pass client-ip=40.107.6.138;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 6/2/23 16:59, Hanna Czenczek wrote:
> On 29.05.23 17:15, Alexander Ivanov wrote:
>> Repair an image at opening if the image is unclean or out-of-image
>> corruption was detected.
>>
>> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
>> ---
>>   block/parallels.c | 65 +++++++++++++++++++++++++----------------------
>>   1 file changed, 35 insertions(+), 30 deletions(-)
>>
>> diff --git a/block/parallels.c b/block/parallels.c
>> index d64e8007d5..7bbd5cb112 100644
>> --- a/block/parallels.c
>> +++ b/block/parallels.c
>
> [...]
>
>> @@ -1130,6 +1101,40 @@ static int parallels_open(BlockDriverState 
>> *bs, QDict *options, int flags,
>>           goto fail;
>>       }
>>       qemu_co_mutex_init(&s->lock);
>> +
>> +    if (le32_to_cpu(ph.inuse) == HEADER_INUSE_MAGIC) {
>> +        s->header_unclean = true;
>> +    }
>> +
>> +    for (i = 0; i < s->bat_size; i++) {
>> +        sector = bat2sect(s, i);
>> +        if (sector + s->tracks > s->data_end) {
>> +            s->data_end = sector + s->tracks;
>> +        }
>> +    }
>> +
>> +    /*
>> +     * We don't repair the image here if it's opened for checks. 
>> Also we don't
>> +     * want to change inactive images and can't change readonly images.
>> +     */
>> +    if ((flags & (BDRV_O_CHECK | BDRV_O_INACTIVE)) || !(flags & 
>> BDRV_O_RDWR)) {
>> +        return 0;
>> +    }
>> +
>> +    /*
>> +     * Repair the image if it's dirty or
>> +     * out-of-image corruption was detected.
>> +     */
>> +    if (s->data_end > file_nb_sectors || s->header_unclean) {
>> +        BdrvCheckResult res;
>> +        ret = bdrv_check(bs, &res, BDRV_FIX_ERRORS | BDRV_FIX_LEAKS);
>> +        if (ret < 0) {
>
> Should we also verify that res->corruptions == res->corruptions_fixed 
> && res->check_errors == 0?
If ret == 0 there must be res->check_errors == 0 and res->corruptions == 
res->corruptions_fixed.
>
>> + error_free(s->migration_blocker);
>
> I’d move this clean-up to a new error path below, then we could even 
> reuse that where migrate_add_blocker() fails.
Is this guaranteed that s->migration_blocker is NULL at the function 
parallels_open() beginning? If so it could be easy to move the clean-up,
otherwise it could lead to code complication.
>
> Anyway, not wrong as-is, just suggestion, so:
>
> Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
>
>> +            error_setg_errno(errp, -ret, "Could not repair corrupted 
>> image");
>> +            goto fail;
>> +        }
>> +    }
>> +
>>       return 0;
>>     fail_format:
>

-- 
Best regards,
Alexander Ivanov


