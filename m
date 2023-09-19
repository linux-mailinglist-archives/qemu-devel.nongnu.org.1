Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD277A68BE
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 18:20:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qidRT-0008Cv-E7; Tue, 19 Sep 2023 12:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qidRQ-0008AE-9r; Tue, 19 Sep 2023 12:19:12 -0400
Received: from mail-db3eur04on0720.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::720]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qidRN-0007VT-Jm; Tue, 19 Sep 2023 12:19:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgAaJZTmFybsNphpK8u7HT6Is3lntNWDX7xRZN8IFsykVPK5In/f3doEcBhAPUBbpJNYts6erSOjXQu58KcBMBqLDtMEYbhLzYjRY1XlgfWSj7GIk6tURM1vC9BpOcX7Ab90ybueOE0uhcCMQxe4OI8Evp/4dvud7kyhbQVvDnB2vewsHYze7z3IqEFKQd0rZpaAa4gegON+AXK5j8GYsOMjQdZz5a9CeOLg81c3YGQyA9JUIT+0EX8T17vHX3+YABniUcVnRwtGAVkgTBRbav5J1KujRlqEtABLjxyeYV9Y8SPBNgNOCc4fWqy9sxNulZ0trEIC34/ElOp7b9XnYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvgKIl6x7YlPgcL8HpHQq10n8aS9JeApwbmX1U42opY=;
 b=KNdmBrl7Q2SAwNaJSl5OGAIh8rt2eEMPKveftYux65hH4NnbCEQXKGk8xKfLQXedbvFDniebzV18JrvjV3H5jXIR70jqT8vr0wK62iJI+9NJ+s10jksCT+7jdAssKLMIWPwkuCE6xd1rPxWrDsC0kQgfl/TLk0mGpoS/QeU+/5So1B0GdJgvHuRom9hCei+9CyRPko5lDL4647irZh9sE4tMUewL++3epbHB482x+GIsoigkVBOOPj39a8IlsZy/RQKJrBhJ4nX5liQu8MxlskntYa5xnRmwlTCsrB7LTIAIBS8MlCCRfryE832Y/MDnJHNhYxuqNuGhpPESVWT4DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvgKIl6x7YlPgcL8HpHQq10n8aS9JeApwbmX1U42opY=;
 b=GJtcWAfNr0is/2zGj3Yq5hywJgW3OuRoHFSibhyxp20xe8/BAwIRzrxtYgQMrbMh5BklbQc1Y86uR9HZPsNQ+bCBQ0Cu5Br4ksxa/tBXcAT2GnzeAyGn6e/++T5BKAQM4NSqtrgR2nVKvoziXYY56kmNzNdb3spn6zcJFyTmOCghSdoHUtvZib61gdR24Pa1NHN+vL3H9d9TscZceKOV44yjHMsgP8uF7KncDdP3hqxjQ4aMC3qkwmyW+qaPtI2t5xltH6I2km9z609IztEaKyyvQ9FTJMNUiPN+gPzOks2PwzhfkhIbp+Mp/WDgAfmRkmCc3fSgiYosPY7eg/Do0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0802MB2331.eurprd08.prod.outlook.com (2603:10a6:3:c1::13)
 by DBAPR08MB5589.eurprd08.prod.outlook.com (2603:10a6:10:1a2::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 16:19:03 +0000
Received: from HE1PR0802MB2331.eurprd08.prod.outlook.com
 ([fe80::4190:cf8e:abd7:68c8]) by HE1PR0802MB2331.eurprd08.prod.outlook.com
 ([fe80::4190:cf8e:abd7:68c8%11]) with mapi id 15.20.6792.026; Tue, 19 Sep
 2023 16:19:03 +0000
Message-ID: <a86f35a0-a633-4115-92bf-10c19973beb3@virtuozzo.com>
Date: Tue, 19 Sep 2023 19:21:32 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] qemu-img: rebase: avoid unnecessary COW operations
To: Hanna Czenczek <hreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, eblake@redhat.com,
 den@virtuozzo.com
References: <20230915162016.141771-1-andrey.drobyshev@virtuozzo.com>
 <20230915162016.141771-6-andrey.drobyshev@virtuozzo.com>
 <2ec20eaa-2d56-a5b2-67c2-3798d1910f4b@redhat.com>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <2ec20eaa-2d56-a5b2-67c2-3798d1910f4b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::6) To HE1PR0802MB2331.eurprd08.prod.outlook.com
 (2603:10a6:3:c1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2331:EE_|DBAPR08MB5589:EE_
X-MS-Office365-Filtering-Correlation-Id: 624c06ec-2b73-43be-2309-08dbb92c234b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f+MGaoPIJV879UjOOamP9twdENnGCu8Gutvz8h/PtxB9LA4/5zVTSpNdy2ZnnIM5SpwXjGY7StH2jFEkm1xvMbkAwQBbkKmJpovW2LRHEVjxZODpI5qZ7yYEyQpWVeXZrNOrhbsGtNRO6ciRpc39tIomPwM43lEK/2zRmKMmhgJ8/BRMZNS9rR53QIoIQ7k6AU85dywr6jHPuxKjMcfEOGIOSOFZDJAppvfKye1I7aLi0psp+kn8gOSfLmhM9BcqgZ6xcymqdYhivtUxlJZpdnSf356Y9LSnzbf5WPWuPXs8kPsVisuSeY7QMxcs4OsHlw4iPbO0WnKptorQankOdnz/kA05ZZHDhQ+RCu8XIcvFwd39KxnJTBG+1R0w2mtphG/8IFKY0Nm22SY/2pwlWpYNh2zGYzNrPk62bZVbNBs+BPnky7OGqDiLKxPR0ykCagKi4gmkIqdcom4lI+ndi6fHapXY9SHqIfGqaLkKyK0GWEEpolG5UJ3YP+kyAELQrxpVQPLedQGuA79CmrbNRQQrKO+8DjH0W5YwlXby8q2kvcQtUucuawHrjcNyu2wlYPfq4MG8WcEb+aPiBiuIoA1yK5wUEUpZ9ftjBCjlxQMX3IxGLRAzZ5R3/aOqSXdfNC0QUMqfxebqonLONN+vqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0802MB2331.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(366004)(396003)(39840400004)(136003)(451199024)(1800799009)(186009)(2906002)(44832011)(31686004)(5660300002)(4326008)(8676002)(8936002)(107886003)(26005)(41300700001)(316002)(66476007)(66556008)(66946007)(478600001)(6666004)(36756003)(53546011)(6486002)(6506007)(83380400001)(2616005)(6512007)(38100700002)(86362001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czBmZy81RnJRRnJMSEpEMm9iQ1RZQTU2K1c2U0xLQkx5eHMwWjhNSnFENmxZ?=
 =?utf-8?B?b2FVeTJVSDZmQmZ3K0N4cml1ZHFGU29kN0ZDa1Y1alljZ2VnVEE3cE9FYU1P?=
 =?utf-8?B?ZCtSdjRlOTRuUzBuUUxzbzlrUlp5YjVVeFRNWkk1akMxdko1eTJUcTJLSkpn?=
 =?utf-8?B?OUhTcmpkUEZIc0NFNEdBem12TDNMYmNQQUY4QkJtUVROQWUwM3BmbVNKT3JW?=
 =?utf-8?B?YzRLU0Rtck9STUZ5Z2I4aEsyMnZjYjhwZWpXSUNGYUd5TjgzcFVrVWo0anZa?=
 =?utf-8?B?Zkd2VGplczZUWnF2NldROWpuZGFvdXdtSUZTN25qNEVUUS9wK09KTmxPS2cv?=
 =?utf-8?B?cGtDR0x6MCs0NFdrY1NaWXNqcUhxZjdRTkxCWnNkTU1MOFR6ai9rbWVRYmF2?=
 =?utf-8?B?SWFEbHhpTEwyc3VRYWQ3dkhwcDIvMmo3S2FpV0NaYzM0d2d2RkNaRUQ0SVlV?=
 =?utf-8?B?ZTBxUDgwOS8zcWVXeUw5T1ZBTklLdUZhWlVWekp4S21RNXdFYmM0TTMwTDRm?=
 =?utf-8?B?ZWFZSjAzckIvZEdsSHl0Qm5uRU1XSG5xWUd2ZHc5SnZYOURSaGowc3pHakVQ?=
 =?utf-8?B?TGtyV3RIT1RuR05sZWlMZ1RmQ0R3VnZaUzBOd01WSHcxZjZZcXZFSHZ0MFlL?=
 =?utf-8?B?QzFBMzRzMTJMKzNQUWxQR1ZZTVR5WnpUZ1lTOXh1UVZPYjdpVHBKRGlSczdL?=
 =?utf-8?B?bVF5MlltV1BwTHdnd1NlNkxiTEhObUpDa050MGE5S3FPTnZyMWZZL0RHSDNl?=
 =?utf-8?B?dW1yNjZaNVpEOWZYY3VBWjBmeEdvbWNzUElqRThXSHA1QVVBUUhsbWNPSEl1?=
 =?utf-8?B?aFV4NGNxS0EvN3dDNE90NEtBdmozWkxYa2s5SFVDZWM5SWNjMlBkWHgyYUVj?=
 =?utf-8?B?VkdoZWJ6dk5BZjhqRDFhVWViSDVkTlFYQUk1c0tDZy9CMVFqQ3FIM0ZVckZz?=
 =?utf-8?B?VTMyTzROTDNIbitBRkhlRXlid1IvdXBlb2ZCVFA5SVJrUEFhQTZ4Uktra0tU?=
 =?utf-8?B?dmdvcXo0Wnl1aVNyNXB1L0dIZWxLRVhkZFViNTVzZEJCcnEzdUxRcFFVQnpT?=
 =?utf-8?B?c3RYTkxERXQvVkZTOG1obm5XSXc4NWlOZ0t3SXF5RU9BTkE4R1JYS3JyMUd3?=
 =?utf-8?B?R1ZZM0FETGNEblA1SEtTaDlXaUoxUUtsV0FBeDdJR1VKNlRtRFd6b0tsK1JE?=
 =?utf-8?B?RmhxWXBPRWNrcW9UdVhFZnlQZHFNMC8rc0Zqckw4TzJ3NVRFWUQ1MnB5czVR?=
 =?utf-8?B?QmdtZjZyM3FBclZITEVNY2VJSlM0NnRMK2lxRDlTSVlCTmNkdlluTWFzaDRy?=
 =?utf-8?B?TmlkM0h6MGxjdjdxcjE5c3ZISkdTRUc1WFdMaTFhc3hhUURhcWVXa3hTQ3lq?=
 =?utf-8?B?RXVBa0U5MjN2Qi9CS3poaEJJU0JoVnAySVVUb0hLay9qNk5ISkN5QVhPTURD?=
 =?utf-8?B?ZjI3TzI3NlpsVThSSHd3dGRYU1cyei9odkUzNDBGN3hXWWJKMmJhTDh0dkpS?=
 =?utf-8?B?M25qSmxQK2NXRWh6b0ltcHgxdVd5ZFJVT0hVeFFndlhrL3ZCSis2Qjd1OWFX?=
 =?utf-8?B?MFNibWc0MklBdURQeFlxMjN5aUJjOEFTMGNEM2xBV3pXS2tNRVJwWW5XbXlE?=
 =?utf-8?B?R0srY2JDRVM3UE1MYkF6K0tKcVpkV2hYWFNMN1BveWNPb1pFV2toZ2FkRUhy?=
 =?utf-8?B?aHNhUzFnVS9vamFydTdteWRLLzFtMHRKNkdyNkxocHlXQTh0bnBaWDZoWEc5?=
 =?utf-8?B?aG5VRExNemtDUWpQdGxoN0ppenAzWmVUc0I3VmcrUVp6azdOR3ZUbG9pTlNC?=
 =?utf-8?B?MDY4eEdrMkhZTkk5bnI4N3hvVHNZclZGdkMrd28yY01yMlF4SmhZZmtPUkMy?=
 =?utf-8?B?ZU81VFVjNmxrL1pUc3J6aHRKSGdSSC80TUZCeHBqSFROWmgzOWpPRmVueGJF?=
 =?utf-8?B?K3JlYUkxekc2czRnL0Vtb1hadVVHOXMrQi9TVTExU1lXQkdWdWNOME5LQXZR?=
 =?utf-8?B?aHY2alNxZ1JPSE54R0RFNDRyb25obzdoSUt1R0wvS3RPcDI1c28rSVlqZW9X?=
 =?utf-8?B?WmtGc1FHSEtPcW9RR2EreHpnWGp2Z3A4TDNtSndEdGh5Nm1wU0JYcTF3dk9T?=
 =?utf-8?B?VjFQSVRaZDFxd1pJNWV1bU1lTmQ0MjE4K0c4Znp5WStKUGY4US9yRUk5YzZI?=
 =?utf-8?Q?FXeFaA93T1oSbuhQkhTTB98=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 624c06ec-2b73-43be-2309-08dbb92c234b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2331.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 16:19:02.7240 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /1XFgYqvXxSXcZibAKdzlAWgVFzpNP+CxPzyHf+TY2/Z+vBetcyqky0AnwVSMBj/s0ZYeDOfPjMzsRe8GQXlFCgG6rei8SeME7NmDe16FcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5589
Received-SPF: pass client-ip=2a01:111:f400:fe0c::720;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On 9/19/23 13:46, Hanna Czenczek wrote:
> On 15.09.23 18:20, Andrey Drobyshev wrote:
>> When rebasing an image from one backing file to another, we need to
>> compare data from old and new backings.  If the diff between that data
>> happens to be unaligned to the target cluster size, we might end up
>> doing partial writes, which would lead to copy-on-write and additional
>> IO.
>>
>> Consider the following simple case (virtual_size == cluster_size == 64K):
>>
>> base <-- inc1 <-- inc2
>>
>> qemu-io -c "write -P 0xaa 0 32K" base.qcow2
>> qemu-io -c "write -P 0xcc 32K 32K" base.qcow2
>> qemu-io -c "write -P 0xbb 0 32K" inc1.qcow2
>> qemu-io -c "write -P 0xcc 32K 32K" inc1.qcow2
>> qemu-img rebase -f qcow2 -b base.qcow2 -F qcow2 inc2.qcow2
>>
>> While doing rebase, we'll write a half of the cluster to inc2, and block
>> layer will have to read the 2nd half of the same cluster from the base
>> image
>> inc1 while doing this write operation, although the whole cluster is
>> already
>> read earlier to perform data comparison.
>>
>> In order to avoid these unnecessary IO cycles, let's make sure every
>> write request is aligned to the overlay subcluster boundaries.  Using
>> subcluster size is universal as for the images which don't have them
>> this size equals to the cluster size, so in any case we end up aligning
>> to the smallest unit of allocation.
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>   qemu-img.c | 76 ++++++++++++++++++++++++++++++++++++++++--------------
>>   1 file changed, 56 insertions(+), 20 deletions(-)
> 
> Looks good, I like the changes from v1!  Two minor things:
> 
>> diff --git a/qemu-img.c b/qemu-img.c
>> index fcd31d7b5b..83950af42b 100644
>> --- a/qemu-img.c
>> +++ b/qemu-img.c
> 
> [...]
> 
>> @@ -3844,33 +3861,48 @@ static int img_rebase(int argc, char **argv)
>>                   }
>>               }
>>   +            /*
>> +             * At this point we know that the region [offset; offset
>> + n)
>> +             * is unallocated within the target image.  This region
>> might be
>> +             * unaligned to the target image's (sub)cluster
>> boundaries, as
>> +             * old backing may have smaller clusters (or have
>> subclusters).
>> +             * We extend it to the aligned boundaries to avoid CoW on
>> +             * partial writes in blk_pwrite(),
>> +             */
>> +            n += offset - QEMU_ALIGN_DOWN(offset, write_align);
>> +            offset = QEMU_ALIGN_DOWN(offset, write_align);
>> +            n += QEMU_ALIGN_UP(offset + n, write_align) - (offset + n);
>> +            n = MIN(n, size - offset);
>> +            assert(!bdrv_is_allocated(unfiltered_bs, offset, n,
>> &n_alloc) &&
>> +                   n_alloc == n);
>> +
>> +            /*
>> +             * Much like the with the target image, we'll try to read
>> as much
> 
> s/the with the/with the/
>

Noted.

>> +             * of the old and new backings as we can.
>> +             */
>> +            n_old = MIN(n, MAX(0, old_backing_size - (int64_t) offset));
>> +            if (blk_new_backing) {
>> +                n_new = MIN(n, MAX(0, new_backing_size - (int64_t)
>> offset));
>> +            }
> 
> If we don’t have a check for blk_old_backing (old_backing_size is 0 if
> blk_old_backing is NULL), why do we have a check for blk_new_backing
> (new_backing_size is 0 if blk_new_backing is NULL)?
> 
> (Perhaps because the previous check was `offset >= new_backing_size ||
> !blk_new_backing`, i.e. included exactly such a check – but I don’t
> think it’s necessary, new_backing_size will be 0 if blk_new_backing is
> NULL.)
> 
>> +
>>               /*
>>                * Read old and new backing file and take into
>> consideration that
>>                * backing files may be smaller than the COW image.
>>                */
>> -            if (offset >= old_backing_size) {
>> -                memset(buf_old, 0, n);
>> -                buf_old_is_zero = true;
>> +            memset(buf_old + n_old, 0, n - n_old);
>> +            if (!n_old) {
>> +                old_backing_eof = true;
>>               } else {
>> -                if (offset + n > old_backing_size) {
>> -                    n = old_backing_size - offset;
>> -                }
>> -
>> -                ret = blk_pread(blk_old_backing, offset, n, buf_old, 0);
>> +                ret = blk_pread(blk_old_backing, offset, n_old,
>> buf_old, 0);
>>                   if (ret < 0) {
>>                       error_report("error while reading from old
>> backing file");
>>                       goto out;
>>                   }
>>               }
>>   -            if (offset >= new_backing_size || !blk_new_backing) {
>> -                memset(buf_new, 0, n);
>> -            } else {
>> -                if (offset + n > new_backing_size) {
>> -                    n = new_backing_size - offset;
>> -                }
>> -
>> -                ret = blk_pread(blk_new_backing, offset, n, buf_new, 0);
>> +            memset(buf_new + n_new, 0, n - n_new);
>> +            if (blk_new_backing && n_new) {
> 
> Same as above, I think we can drop the blk_new_backing check, just so
> that both blocks (for old and new) look the same.
> 
> (Also, the memset() already has to trust that n_new is 0 if
> blk_new_backing is NULL, so the check doesn’t make much sense from that
> perspective either, and makes the memset() look wrong.)
>

Good point, thank you.  Looks like we indeed can safely remove these
extra checks.

>> +                ret = blk_pread(blk_new_backing, offset, n_new,
>> buf_new, 0);
>>                   if (ret < 0) {
>>                       error_report("error while reading from new
>> backing file");
>>                       goto out;
> 


