Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 259D7738E44
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 20:12:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC2JJ-0006PH-In; Wed, 21 Jun 2023 14:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qC2JB-0006O6-JE; Wed, 21 Jun 2023 14:12:00 -0400
Received: from mail-vi1eur05on20727.outbound.protection.outlook.com
 ([2a01:111:f400:7d00::727]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qC2J7-0001Ki-8t; Wed, 21 Jun 2023 14:11:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zbk/zmJMr3rosZD5xfSje9R6KP343CpevVqFcpefqbNs1TGi/8vujXKcINfwNl3zBROlk4y+WMK0xqhnFv9to6KI+jVEStFwnZGoZdOb+ZQTnGP+STReqx5RSsL2Xa4USPuTwv6OT5yMm73sf9XET0Y6cVsX0+2nD/Y7Ln7q3hOEsxih4FLugLJgh9LTQafK4pvJCpVnHqwZsg/qdD57u6TPiNP5bMYrVvBv3nwmB8CD009bpHno14Ka8I55Oh41aQkP9kTzrDg3ManSQTZLa5M0k4azNlmN3zCsVMS2Wrjlb0zuow55GkOgkXVneXo71u/14qVsZnXKMCJIDyMJlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtfJuZJSG1MeoqF+fbk1oD5VyvRhAYIFiW5m8KlK4ZU=;
 b=f+BXFxYNhq7T9YMOg9xcMuOoxsdkOH+dYCBTna0d4L/frQWtztzu+msPS93wA3Gl2Q7JTQ89WTLWNKDeHhZfmp0H886755xHhzC3R0EL6U7HX6ZBxHtdllV0Gulne5Tz57otmjOnhx91kSZyxfRpqBTJ0ptNHze42ApXxaqaC6K6WeAF8Xd+X6STM06R59e8AGgoHu4rgW3riYGbqMjo5OegtdTCHwDENGmUA40+oVQ3G5/gyLVqLPK8ETGlAhPotrU1PAmHf7SB8cAfNMdy8NFxf//AcBNqGzyk5hBsiFqgK5IW8IULYGw1ESip/WWGpvwx3Fqgc3jvSLRVQBVd/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtfJuZJSG1MeoqF+fbk1oD5VyvRhAYIFiW5m8KlK4ZU=;
 b=gXknKi7/CO6dvnYh73ev2dHu+WSXQjnMRqYlPOJVpvlmlhF+qCpLZ+ktl6Mj1SZsTwUzsvVvUmeSyRMXejCSTULThyRNuvfvhqPKtq/rz0mX3mlEKxg9z8O0kLHhdTM4DKu2gkz9IUPHGxU+GwSWiF0LaWVM/rESsUTYiU+YRu5PyJqpZr6ahfrz0oRNG3rM/gty6OHxQlgP+lG0Kjm2mOAoZptornZ4VWSjPAMtCSo+hJKLxEpy6gTUUQb4dv5fDIjgMjJ9UFPOaZpVBGSXt10LbXmtMal7DdM6hTh8NF9GzD/+kJLJDwast3LfvKO6GPIm5VKXOrzK4OcLXNLGZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com (2603:10a6:205:e::33)
 by PAVPR08MB9555.eurprd08.prod.outlook.com (2603:10a6:102:312::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Wed, 21 Jun
 2023 18:11:46 +0000
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::c9c4:b136:a31a:bc35]) by AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::c9c4:b136:a31a:bc35%4]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 18:11:46 +0000
Message-ID: <6561b29d-7e2f-ce11-e6f3-6e8cdbf2964a@virtuozzo.com>
Date: Wed, 21 Jun 2023 21:12:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/3] block: add BDRV_BLOCK_COMPRESSED flag for
 bdrv_block_status()
Content-Language: en-US
To: "Denis V. Lunev" <den@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com
References: <20230607152627.468786-1-andrey.drobyshev@virtuozzo.com>
 <20230607152627.468786-2-andrey.drobyshev@virtuozzo.com>
 <75b5d7aa-fd86-c06a-4633-26567e044b38@virtuozzo.com>
 <548c3c54-0641-5cb4-c421-b2e8d10c55b9@virtuozzo.com>
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <548c3c54-0641-5cb4-c421-b2e8d10c55b9@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::16) To AM4PR08MB2932.eurprd08.prod.outlook.com
 (2603:10a6:205:e::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PR08MB2932:EE_|PAVPR08MB9555:EE_
X-MS-Office365-Filtering-Correlation-Id: 258a609f-8d2a-4c1d-a0c1-08db7282f960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4NqL78zw8rwXZrpTXlq8dZNg3OitDOr5kb+QvBDazvW+CDWI5IDlvubdhJQC8WCJbzF2U1s67IcbaEKBWTISxUybK5+xw92j2+lc3as+hN5SCH4N7vwFOYFvelu+175TdeVInP/DhDBt/0Ysepa+FUa1tpxTO/Hw9By0iLih6GYKVYgX43unB8qy8FUBLLEMz5k9e8UbrWcJXaJZVnJdcePxCdvpyzXlZa8vOzZ6nMLRLlTMWGr9Xxyxcro1BfLzBs4Wi5aZ+qwqQbfYxdw5Toks53sIeESDCSvo5cPoQffKzM9mVbsPFvsFmJvjvIIqgp/qiwssGZwxPsRUyYAZOboaSxPrzS1+n4bBgkooHjW8ofOEWJMfBg0EuAjedw3fL3YjTzpmTsEUMBcWAH8gZD3lDbfjIs9HYEuVcqwRfegjgTgEAKcU5W7faGHAxhHCgbwM7dkarRsNNvyOn7Y5qmq+8mxJGTWRfE4xlnHTFwVIviSTcqgRKmL4fmuFdIOqkycrUVzkDZ79luS3x6xAJDSkiRY2aIoAEG4AZqgGpjGvLsgB9SMgFnsMa6Z3YfCJAJrnUyi/BxkgFSv3WU2RLfcGzC9MtuAE+gyOCwCCiUnD1SVEV5F3f8OiN9a8uY6GTYAbTZIx+NHppNcI7ruNAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM4PR08MB2932.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39850400004)(366004)(346002)(136003)(451199021)(41300700001)(8936002)(8676002)(5660300002)(44832011)(2906002)(36756003)(31696002)(86362001)(6666004)(478600001)(6486002)(83380400001)(186003)(53546011)(26005)(6512007)(6506007)(31686004)(2616005)(4326008)(66476007)(66556008)(66946007)(316002)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkpXcmc1cEM0aUdTT0hsS0FWWWcvT1JIT1NrRVgzSzhlbkRrUlFyWkFJdzZw?=
 =?utf-8?B?aXpkRmZKSU53YXFBQUNyb3RrVkJtNnpPSUtQdjRWQ3Y2cGlBSXFVVXJmaHRi?=
 =?utf-8?B?anlXMVQvejBleXM4TVJzaE5YeXowRkpoU2pscGtzbjlTMGZJcWIrZjNqOURF?=
 =?utf-8?B?c3dnc0lRaVVLbnpGbGdKSExaZ2hDcHk2bGVlVlJ2ckswMjlsNUg4TEd0bnNF?=
 =?utf-8?B?Y2pBdGFEY0ZDdGYrbUdKd0trUVNYNUsxVXJseXZGeEdHdTNWdDRmdlg2VkxE?=
 =?utf-8?B?aGY2UGdXVFF0aVh6UGxnWkFyd2F6NTQ5bXNFN2xtVHFuV2hsTGlBT29IYWQx?=
 =?utf-8?B?VURPVUk4YjlTTkhmWWRpanNrY24vVDlvM0FYNHlieGQyR0Y3L2RCVU9ad1Ns?=
 =?utf-8?B?MkMrVU5XM0lFaWp0ZDlCNGhDbWVIZDFyZm9KZitTaEluWVVGWThDR1FhYmgz?=
 =?utf-8?B?TGh4N2J2TkgxZ09VTW4vOWJIZ2Y5S3I3YkZUOEViWlZrWUE2RS9PYXd2TVdG?=
 =?utf-8?B?bk1pSDVneTJOUnFTYkZ3dEZ4Y0hiaC8xcUpDMkpFU1lrMk5URnpOMkt1R0kr?=
 =?utf-8?B?TTVMZUNxSUFrSWlzUkh3a09uZDJyUXRpSG9EcUdSOVhvbmlZdmhCaXRJWnJu?=
 =?utf-8?B?SGsxWEQ5Wi9aSmlmVmM3RVBBQ0prdFVCbXhzVi82S1lGM21uTjBSMTBKeWRV?=
 =?utf-8?B?ZUdDdXJRQU90VDFzRXlRczhraVdWUFJyVVp0d1pGTlRsV3NCaXVIaEFObHZQ?=
 =?utf-8?B?ak1IblVwVXBEaVVQSmJ1TEJEMTNTWnVERXJtRHVIN3p6eFB1TWRrbVk2ZWNm?=
 =?utf-8?B?R1Z5VC9OUm5KejhmbWprWlJXNjJQMzFNcm9Ca0crYnZZWGZma21iRURLYVZU?=
 =?utf-8?B?Y1BRTnVRREdYZ3hLYjhCZmxWZXNteisrZDUvUFdKNkZBaE9MdnVQUEVjMWNx?=
 =?utf-8?B?eDRZYTRjMmNhazhjSHk4ckdxd28wb3JEbUFGR2FNL0oyZHgzNHFneTNhbVJC?=
 =?utf-8?B?YkwyMnByaTk2L2w4SWh3cmZudWNCK0xLSE1jTGpPeHZxM2ViVTVsUEQxOEFq?=
 =?utf-8?B?YUoxeGR4aTF1ZGtqWkl1MlR5RlQyNVhpTXhkUkw1QWtHQUg2TFJIR242RkFy?=
 =?utf-8?B?YlNlTXlmb0s5ZUlCc0VPRytxK3QwYmlvMVpDN3VjWFU5L2lJY1A3RG1WcGo0?=
 =?utf-8?B?THgxQXcvSis1SkdsSXp2WktZM2pjejJpTE4zUjIrOE9XSkJ1RllwTFpRRk55?=
 =?utf-8?B?YWF1WUNmdDhQb29IQWVZTlR2ZTUzc2JnREREM2hId1ZOQ0FnY1RIZGhmSG05?=
 =?utf-8?B?TTNZZ3piK0RPVlhObHFKM0VrL0RGZkJ0a1ByeW5jWVlVbThYdDc2Um5lK1hx?=
 =?utf-8?B?akx2b295RjVKQ2liUkduaU5NYmRzUkxON2N1WnlJOHdTNjVGK3VYeEpDY0Js?=
 =?utf-8?B?bXIwaGQzTFZQVlV5cDZHeXB6STVrempVMGJkaXlTQzVGVTRNYjZlWllUWWFT?=
 =?utf-8?B?OThtclNGWlh5WnRwTmx1SStidEY3YnU2cVJ0cVVFcVVQQXFUOG5INFdQU2Rw?=
 =?utf-8?B?TTlEZ29kMmYycDVYRW5MTUJQcVZmY0lVczBiRk56U2dZb2xTWUZvQ3lDbTF3?=
 =?utf-8?B?TVhaUDNmbFBvRlNiTFk0OFlKdER1YVQ0SVd5UDQxNHVDZlNwdWl0Wng1WTU2?=
 =?utf-8?B?Q3hGenFYNDR4SWpwQk9pcHFDTWhsTitua0FCSmg1anljRmpGMUw2My84R0dz?=
 =?utf-8?B?dG45aWNNY20wcmdJZ3NXTmtpREYvbmJkOUR4RFFEK0RaTHlPZ09YZTBkdzQ4?=
 =?utf-8?B?YXNLZ01ZdzZZK0xKNTdsNDdzZlFNdmxtYkJ6WTlndll2Lzh3ejBnT0dGSVNv?=
 =?utf-8?B?VGYzampFOExXWTBUUGRPSE50WlBhWXNnei9WSVlrWDJLWWhSc1VWOGdnWEp1?=
 =?utf-8?B?aXViSDVzZGo0eG9qWEFoblY4RnBKbHVTcGRxODV3TUdZSnhQNVYrcmZFUnJp?=
 =?utf-8?B?bjNNbmVBM3pxVXJnUjUxOUlaL2UxL0dLVzlIWUZLTkRUYWkwRmNpaUJEY05j?=
 =?utf-8?B?YUYvaTdCTkZFeDN1QXoyb2UzY2NKZ254WS9VSVFoR2xORmlkNjdQLzFzS2ww?=
 =?utf-8?B?UHFXYjBmUEhmejlwZnhlVFBKTklKK2R4cjRJR2d0Y0N3TENkQitCdzBEQTZ3?=
 =?utf-8?Q?/f5UKfwMQEWfsI1ZDhKpU4Y=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 258a609f-8d2a-4c1d-a0c1-08db7282f960
X-MS-Exchange-CrossTenant-AuthSource: AM4PR08MB2932.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 18:11:45.9916 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H2CpBcI3PQaa0KbTi0jbqMNBGR69naRGigQjyiW8X8JtqnC/hQN1jfuI1szg9fLlJ6YI+sVBtkN04iQcZ964am16Z7nPMPzLWgiyIfEwyOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9555
Received-SPF: pass client-ip=2a01:111:f400:7d00::727;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 6/21/23 20:46, Denis V. Lunev wrote:
> On 6/21/23 19:08, Denis V. Lunev wrote:
>> On 6/7/23 17:26, Andrey Drobyshev wrote:
>>> Functions qcow2_get_host_offset(), get_cluster_offset() explicitly
>>> report compressed cluster types when data is compressed. However, this
>>> information is never passed further.  Let's make use of it by adding new
>>> BDRV_BLOCK_COMPRESSED flag for bdrv_block_status(), so that caller may
>>> know that the data range is compressed.  In particular, we're going to
>>> use this flag to tweak "qemu-img map" output.
>>>
>>> This new flag is only being utilized by qcow and qcow2 formats, as only
>>> these two support compression.
>>>
>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>> ---
>>>   block/qcow.c                 | 5 ++++-
>>>   block/qcow2.c                | 3 +++
>>>   include/block/block-common.h | 3 +++
>>>   3 files changed, 10 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/block/qcow.c b/block/qcow.c
>>> index 3644bbf5cb..8416bcc2c3 100644
>>> --- a/block/qcow.c
>>> +++ b/block/qcow.c
>>> @@ -549,7 +549,10 @@ qcow_co_block_status(BlockDriverState *bs, bool
>>> want_zero,
>>>       if (!cluster_offset) {
>>>           return 0;
>>>       }
>>> -    if ((cluster_offset & QCOW_OFLAG_COMPRESSED) || s->crypto) {
>>> +    if (cluster_offset & QCOW_OFLAG_COMPRESSED) {
>>> +        return BDRV_BLOCK_DATA | BDRV_BLOCK_COMPRESSED;
>>> +    }
>>> +    if (s->crypto) {
>>>           return BDRV_BLOCK_DATA;
>>>       }
>>>       *map = cluster_offset | index_in_cluster;
>>> diff --git a/block/qcow2.c b/block/qcow2.c
>>> index e23edd48c2..8e01adc610 100644
>>> --- a/block/qcow2.c
>>> +++ b/block/qcow2.c
>>> @@ -2162,6 +2162,9 @@ qcow2_co_block_status(BlockDriverState *bs,
>>> bool want_zero, int64_t offset,
>>>       {
>>>           status |= BDRV_BLOCK_RECURSE;
>>>       }
>>> +    if (type == QCOW2_SUBCLUSTER_COMPRESSED) {
>>> +        status |= BDRV_BLOCK_COMPRESSED;
>>> +    }
>>>       return status;
>>>   }
>>>   diff --git a/include/block/block-common.h
>>> b/include/block/block-common.h
>>> index e15395f2cb..f7a4e7d4db 100644
>>> --- a/include/block/block-common.h
>>> +++ b/include/block/block-common.h
>>> @@ -282,6 +282,8 @@ typedef enum {
>>>    *                       layer rather than any backing, set by
>>> block layer
>>>    * BDRV_BLOCK_EOF: the returned pnum covers through end of file for
>>> this
>>>    *                 layer, set by block layer
>>> + * BDRV_BLOCK_COMPRESSED: the underlying data is compressed; only
>>> valid for
>>> + *                        the formats supporting compression: qcow,
>>> qcow2
>>>    *
>>>    * Internal flags:
>>>    * BDRV_BLOCK_RAW: for use by passthrough drivers, such as raw, to
>>> request
>>> @@ -317,6 +319,7 @@ typedef enum {
>>>   #define BDRV_BLOCK_ALLOCATED    0x10
>>>   #define BDRV_BLOCK_EOF          0x20
>>>   #define BDRV_BLOCK_RECURSE      0x40
>>> +#define BDRV_BLOCK_COMPRESSED   0x80
>>>     typedef QTAILQ_HEAD(BlockReopenQueue, BlockReopenQueueEntry)
>>> BlockReopenQueue;
>> Reviewed-by: Denis V. Lunev <den@openvz.org>
> Looking into the second patch I have found that I was a too fast here :)
> 
> The comment is misleading and the patch is incomplete.
> 
> static inline bool TSA_NO_TSA block_driver_can_compress(BlockDriver *drv)
> {
>     return drv->bdrv_co_pwritev_compressed ||
>            drv->bdrv_co_pwritev_compressed_part;
> }
> 
> which means that
> 
>    1    257  block/copy-on-read.c <<GLOBAL>>
>              .bdrv_co_pwritev_compressed = cor_co_pwritev_compressed,
>    2   1199  block/qcow.c <<GLOBAL>>
>              .bdrv_co_pwritev_compressed = qcow_co_pwritev_compressed,
>    3    255  block/throttle.c <<GLOBAL>>
>              .bdrv_co_pwritev_compressed = throttle_co_pwritev_compressed,
>    4   3108  block/vmdk.c <<GLOBAL>>
>              .bdrv_co_pwritev_compressed = vmdk_co_pwritev_compressed,
>   1   6121  block/qcow2.c <<GLOBAL>>
> .bdrv_co_pwritev_compressed_part...cow2_co_pwritev_compressed_part,
> 
> We have missed at least VMDK images.

Thanks, my bad I didn't check that more thoroughly, I was mainly looking
in the docs when making this conclusion.

man qemu-img:
> Only the formats qcow and qcow2 support  compression.  The  com‐
> pression  is  read-only. It means that if a compressed sector is
> rewritten, then it is rewritten as uncompressed data.

Apparently man pages got a bit outdated on this.

