Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FE372B254
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 16:46:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8MJt-0003L4-BO; Sun, 11 Jun 2023 10:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1q8MJi-0003H1-7z; Sun, 11 Jun 2023 10:45:23 -0400
Received: from mail-am0eur02on20716.outbound.protection.outlook.com
 ([2a01:111:f400:fe13::716]
 helo=EUR02-AM0-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1q8MJg-00055a-3f; Sun, 11 Jun 2023 10:45:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a40mpTMAVO1E9LDZY5IGTklRCIe2lnFlIR8MeAZ+DyERqjVhBRDtIxbyQalW+jSrYpX+lljiAN1moxUcVmG59z71ewJJ3U8k2Qv1oRJMpSymKyJSpvEwP2rsKlXefMCgcDlgr7YNX8Myf4F8VnfiJdR9cKwkjkp/kq8PmPHthAIpHYo6h14ohW4c4PpxOAL2Tswg2TcQPuIGxoPVd9kWvCeMO+4bOJFgWWKnoIf+hxI6QlNKpCFgnzk3vMqqowgLFBZmLbRU96dbDCr0bsemPOMVCVrf4m7FevuCAlFX1KixtUsKVG8IaDWEFYq6h8eH3VDBT+Jy9iaR7omSAKvjhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykxbBfdO7+Sup0DFDwXa1TdE1T2zfk/rPrx2Lj9mCKY=;
 b=RKk3/tIf7eSeDugVgzEiyVroFmPbb4Cgt+5pbwoMDwOnEFrXTcrx0zDrQ1qOLNhSZfNU+JwJZFsYYZhBSeOuyOtYuvQ7XMsY6dxazdhakSLU5ZM0LmlqRamvvGr4ALsknhcATU+PMFVcoEufGzyAb9dW3Ejd6pMMHCMzL7rnSLc0L1CglLanuUY2zAqq+xUiYdaTfZprBRKg+SQ+KWELBTXdyFcUtHS91KBYdHqK/aZh4+suGp6oYdWSjRbp57FOOwl+3Bz+i1o7M9dB9gGq/OdtVC9MCJqG/6oweokhlnMQvfb8JDlRIa6rYLR+vMspBowA9FqWAzvJULyAVGwjzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykxbBfdO7+Sup0DFDwXa1TdE1T2zfk/rPrx2Lj9mCKY=;
 b=Kw7HhV0llI30rIo+ata4WYPg9EmV42/vNp1mNgCdyaspxN1jykhoDv6yRZFaUr7PfUw53jpZmAS5FVpxoTXLryf2qnn8Ugc4LkIp1LO0Q1XcWcEHPkd78Wh/Vwxx0ylvs/xGkeAOj+Ib+gbxZLnqNtEUTq1bZhNF9cLGkw9nVYwoOB0hNznm72UO5zMeo1LpS9hiB1Jq78FFKHhvXb/cs/YZn58pV5UZWA300tWkBRXdUVgvhEl8YVHTW+BGPWimvtDqcEiWU/lnf7nXzmBOocMbTQLB3owkKuvjUYCquVjDA5e3FdseIFdGQjZgNT1GW19EUD39Y0OPyqeGf3Nh0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by GV1PR08MB8425.eurprd08.prod.outlook.com (2603:10a6:150:a7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Sun, 11 Jun
 2023 14:45:07 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243%6]) with mapi id 15.20.6477.028; Sun, 11 Jun 2023
 14:45:07 +0000
Message-ID: <22c486bb-dda1-7da1-d958-f6bcce2dff5f@virtuozzo.com>
Date: Sun, 11 Jun 2023 16:45:04 +0200
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
 <e22757a4-9853-9044-3a3f-6d8f0e486bb3@virtuozzo.com>
 <fd771f6f-8f5f-cb2f-a20c-da0f149a06a6@redhat.com>
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <fd771f6f-8f5f-cb2f-a20c-da0f149a06a6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR08CA0162.eurprd08.prod.outlook.com
 (2603:10a6:800:d1::16) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|GV1PR08MB8425:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f3a5f37-ac5f-4696-2e0a-08db6a8a7308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gHFulU4JpdQFyU8wKFEvO9Uw4hWdUv+MmgRUxquzA6sdxM8iTz8O3tanZA49ZDQ1JTLlYkzZqJ2OGiIPDlwPjIa8QMgZRBGc7CQQEREvNtC2eyjwUTe7korxUXLhqKa4JDlJiHhIovgHTj864LfN4Vw6R4db3YFWWZ/sjZDXol7Kto1WE3iOvoD4cjjP8M/JuthmklA7tWzYLHJBnn2RSQBlY6xmTNWO+aehLGO1wEwk74Hgn3j55gvwHxP9vYXXeK2wiEXqIQQ+WPy1ADfs2Ti8+zUHJk+uIH7FO6ih+Z8aZ9A71hZS/9s9kdlHVeBY+3J+W2qcj3iVqDd7Mrs68vLr5aZ+yXK5C9wJv4t53655/U+DvJ4OZ4JE7wi0aP6/Qo2rzyzjArVgBGLPS1syiKhAF7paEMdJmEMr5WMvXOI1eUe9t+NbgHwhEpae01FtirjfEFFhCKyHtqJ3sbPku1w9IR3m6G+K2snM7ew74u0ffXFWU4sZGWZqgJKbCwdkNE+MKP+kZqg+AAXN4B2Y+juoxzAmnlnfocRxB3gSBLA6XBUSo71qI+ylu0WJ6GEqa5VlN6h3HqaiSylr2A53rERtZHy8+R6iyjx1yiqtzXHxLATU2QeHC6qpok7YJNEkoUf9Ylh9cv9YsbjPp9dzvJiC0MpHJKY1m/Zgy+e8JLD/qeDYzQvV0K80u/Ry+9ix
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39840400004)(366004)(451199021)(316002)(44832011)(41300700001)(2906002)(66556008)(66946007)(5660300002)(31686004)(8936002)(8676002)(4326008)(66476007)(478600001)(6486002)(52116002)(36756003)(6666004)(6506007)(26005)(53546011)(2616005)(31696002)(6512007)(83380400001)(86362001)(186003)(38100700002)(38350700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVJuRzI1Nm9BMDBmbXFPcnRyUDZob1pjcGZpQk1ISk40MUdhUURJZWRCKzRP?=
 =?utf-8?B?UDZtWm1yN1hOQWYzTU4ydmV2OFljazFmdy9PNFlKRUtUbTU0SDlBSjdMSDg4?=
 =?utf-8?B?REV1R1pMUWQwbm9YcURuSmk5TjlDSEZYVm5Yd3N0QWo5R0hjN1huK2ZpREgr?=
 =?utf-8?B?UCtBYVBZWEdyaVM2dCtqK0JXRzJ5MHFPSHRYTS9tckxtcCtjU2V4YWFKbCtI?=
 =?utf-8?B?S01KaEpLd3c3VUIyY3pIR09EenlYMnltOTY4dE16OFY3QlFtSnZ5SVVDTDlh?=
 =?utf-8?B?a3g3Y25XTEY0MWIwcnd2ZmIzTjFsRlFobXN0Y1UvNUFTY1h3eVFaYzIzMDlk?=
 =?utf-8?B?WTdpMHdRSnFPR0FzZTdkQ2hCVGdvc2EySmovMW14ZGw5OVRkeGNydmpKT1Z0?=
 =?utf-8?B?YUZ2NkhxUjg5VjRPck9PN2FHSWtCanBrMmdJKzB5cDFicDZXbVoyMW45UVFR?=
 =?utf-8?B?dlRhV2RuUUNMQjNuVDF5UHUyeW4wRUpYeGQ2OXRTMTZ0dEtPTGJuQTRaOXo3?=
 =?utf-8?B?RWhwb1ZlM3JJNUNJVlU3dlcyMjUvZzJNOVY4UGxoZ2xpQTUzKzVwbnhHS0Y3?=
 =?utf-8?B?aGIySDVkTmxyMkpDWG83c3Bra2dUNWNISDAveE9hSmVJWHZBTGpSdkxGQ2tF?=
 =?utf-8?B?K1RGWXBoeWlyaUNGSDRiMVdIZFdsbGloSmhSM3E5MUpna2JvclBqMlZ1OXdr?=
 =?utf-8?B?VDk0WkpZS3QrLzhXY0J6UDZ2SGttU2E2WStja1pITzNBdkJjSFF5NmpTMm96?=
 =?utf-8?B?c1YvQzdEYWVoMHNkZm1MV3k2ZHJHZEtjcXVkRi9xMUgrZ2V3Rk1UUWxsS0dp?=
 =?utf-8?B?MVRPaExxR0F2bE1rQUdBZzcvaGhiNWtjZFBKQkFabnBQYTFtRjU3YSt1Z0dY?=
 =?utf-8?B?TWZndFdmNGZBanB2YkFVSEg5N2JFU0xPdWJCc1VZTWRMVU81a2xLNFdJR210?=
 =?utf-8?B?T0VZRjh6V2prR1NJeXNhZ04rSytRdHNyR3FicUQ2VmM2UGc0clpFVmFYanov?=
 =?utf-8?B?N3haQlFOZ0RxYVVJRjA2dFBZN0lCVEh2TlFMb0lGa1RMdS9YYnEzQUVGczlu?=
 =?utf-8?B?U3pRV3poWiticlg4VVh6LzdNdVFSZnQwMEpKZngrK01HUVB3RXRweVovTGFj?=
 =?utf-8?B?NXdFZ1NsTjZteGNYemQwS2crS0toTHc5a3NxU2tRK1I4dnFxU1hVcmdsTzNP?=
 =?utf-8?B?ODN2THZHRUtidzI1UUYwYi92VVlGTHZXSTY1L1d1ZVloMXhCVmxqdktlYTc4?=
 =?utf-8?B?eUFlM1JNS3psNWJGZDIxMHoxVW9LRHI0VHRaaHM3aVkvS08xWTcrYXRWR1hN?=
 =?utf-8?B?a25EbVlTb1UzUlFnejQ5NnRCQTkwaHZiVFI3YUJnOVBzY0RYLzV6dkRZMjJE?=
 =?utf-8?B?M2JaTDFTaHpxM0RaRHZpeDFLVk1ueWYvNklNWm5pZEhnZ0tOV09SVGJLcjdi?=
 =?utf-8?B?NXBiYk05bStUTTR4YlphbnZLd0xtcTNwZzVNY0tuRURlYkUzOTREcU56VGhu?=
 =?utf-8?B?a3NnbDNxOEtTNWtneWRmWXo5MmFLaEd1aEhiQ2I4NklBb2wxV2VwVHJDcjUy?=
 =?utf-8?B?UnpMQmFkNkNkRm1aZGFXS3RYWHNDemlJVC9MZ1FCRklEMVZoNlRMZENQRUpz?=
 =?utf-8?B?ZWJ3VXkrekZhaXordTErQ2ptVk1yNXZHWkhhUSs3UGVvbFFuMnVvQ3p1WkJQ?=
 =?utf-8?B?R1JPQnN4RjBnZzZLR2F1WnI5aDBKeWljWklvTThLZlhxbXg0dHlKejFmc0VN?=
 =?utf-8?B?U0xGcHdiSFNvV2xENk9FelBKWll0c0c1dmQ5TXVFOVZod1BiTk9wbUpEL3JL?=
 =?utf-8?B?QzlJTjF1cGRHNmx0L1M3M1dSVGpCdXMzZ3RyOCt1Mlk4WTdsTHR2UXpXa3Zq?=
 =?utf-8?B?NEpRWElSRFJ1TXFwTVFrQjhHRmV5dHcydmtVanhDcmJDb3hGSm5MZlZvN1pk?=
 =?utf-8?B?UFVsdHJkY2V0R09hL1JiUUZPWGU2c1FoRS9nVCtXZEowMTJVbzBscTBvZzJh?=
 =?utf-8?B?eGF0ckx2QU4weUVkemEzTlB0NWtPYzk0R0F5eW5NZzAxdHhhWTllVnA1eUo1?=
 =?utf-8?B?M1JBYm9rbk9oR1BiR1lFYThISi9zTnZHaUJsMUMwa0xtQkl3aXUrV1hVNkh3?=
 =?utf-8?B?NWY2ZWd6NDA0c0gwQ0FGWW15bHc3aitESVo3aXNhYnFsWmpzRm1LNHc3NVNx?=
 =?utf-8?B?Y0E9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f3a5f37-ac5f-4696-2e0a-08db6a8a7308
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2023 14:45:07.2326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RRpYZqyGROUr4pcAfh/VHRqvKAL8DdJdxNF9HW5x8RMkRmc4n0eyZQnf56+vQ6CgX/BUGAgQsS6N0GmqRP4Mjm2PJxsLB5zxPkQNErpBIbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8425
Received-SPF: pass client-ip=2a01:111:f400:fe13::716;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR02-AM0-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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



On 6/9/23 15:41, Hanna Czenczek wrote:
> On 09.06.23 15:21, Alexander Ivanov wrote:
>>
>>
>> On 6/2/23 16:59, Hanna Czenczek wrote:
>>> On 29.05.23 17:15, Alexander Ivanov wrote:
>>>> Repair an image at opening if the image is unclean or out-of-image
>>>> corruption was detected.
>>>>
>>>> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
>>>> ---
>>>>   block/parallels.c | 65 
>>>> +++++++++++++++++++++++++----------------------
>>>>   1 file changed, 35 insertions(+), 30 deletions(-)
>>>>
>>>> diff --git a/block/parallels.c b/block/parallels.c
>>>> index d64e8007d5..7bbd5cb112 100644
>>>> --- a/block/parallels.c
>>>> +++ b/block/parallels.c
>>>
>>> [...]
>>>
>>>> @@ -1130,6 +1101,40 @@ static int parallels_open(BlockDriverState 
>>>> *bs, QDict *options, int flags,
>>>>           goto fail;
>>>>       }
>>>>       qemu_co_mutex_init(&s->lock);
>>>> +
>>>> +    if (le32_to_cpu(ph.inuse) == HEADER_INUSE_MAGIC) {
>>>> +        s->header_unclean = true;
>>>> +    }
>>>> +
>>>> +    for (i = 0; i < s->bat_size; i++) {
>>>> +        sector = bat2sect(s, i);
>>>> +        if (sector + s->tracks > s->data_end) {
>>>> +            s->data_end = sector + s->tracks;
>>>> +        }
>>>> +    }
>>>> +
>>>> +    /*
>>>> +     * We don't repair the image here if it's opened for checks. 
>>>> Also we don't
>>>> +     * want to change inactive images and can't change readonly 
>>>> images.
>>>> +     */
>>>> +    if ((flags & (BDRV_O_CHECK | BDRV_O_INACTIVE)) || !(flags & 
>>>> BDRV_O_RDWR)) {
>>>> +        return 0;
>>>> +    }
>>>> +
>>>> +    /*
>>>> +     * Repair the image if it's dirty or
>>>> +     * out-of-image corruption was detected.
>>>> +     */
>>>> +    if (s->data_end > file_nb_sectors || s->header_unclean) {
>>>> +        BdrvCheckResult res;
>>>> +        ret = bdrv_check(bs, &res, BDRV_FIX_ERRORS | BDRV_FIX_LEAKS);
>>>> +        if (ret < 0) {
>>>
>>> Should we also verify that res->corruptions == 
>>> res->corruptions_fixed && res->check_errors == 0?
>> If ret == 0 there must be res->check_errors == 0 and res->corruptions 
>> == res->corruptions_fixed.
>
> OK.
>
>>>
>>>> + error_free(s->migration_blocker);
>>>
>>> I’d move this clean-up to a new error path below, then we could even 
>>> reuse that where migrate_add_blocker() fails.
>> Is this guaranteed that s->migration_blocker is NULL at the function 
>> parallels_open() beginning? If so it could be easy to move the clean-up,
>> otherwise it could lead to code complication.
>
> Three answers here:
>
> First, I just realized that we probably need to undo the 
> migrate_add_blocker() call, too, i.e. call migrate_del_blocker() here.
>
> Second, I’m pretty sure that s->migration_blocker must be NULL before 
> the error_setg(&s->migration_blocker) call, because error_setg() 
> asserts that the *errp passed to it is NULL.
>
> Third, I meant to add a new path e.g.:
>
> ```
> fail_blocker:
>     error_free(s->migration_blocker);
> fail_format:
> [...]
> ```
>
> And then use `goto fail_blocker;` here and in the 
> migrate_add_blocker() error path, so it shouldn’t really matter 
> whether s->migration_blocker is NULL before the error_setg() call.  
> But then again, I think the probably necessary migrate_del_blocker() 
> call complicates things further.
>
> Hanna
Do we need to run the rest part of the parallels_close() code?

     if ((bs->open_flags & BDRV_O_RDWR) && !(bs->open_flags & 
BDRV_O_INACTIVE)) {
         s->header->inuse = 0;
         parallels_update_header(bs);

         /* errors are ignored, so we might as well pass exact=true */
         bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS, true,
                       PREALLOC_MODE_OFF, 0, NULL);
     }

     g_free(s->bat_dirty_bmap);

If so, maybe it would be better to call parallels_close()?

>>>
>>> Anyway, not wrong as-is, just suggestion, so:
>>>
>>> Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
>>>
>>>> +            error_setg_errno(errp, -ret, "Could not repair 
>>>> corrupted image");
>>>> +            goto fail;
>>>> +        }
>>>> +    }
>>>> +
>>>>       return 0;
>>>>     fail_format:
>>>
>>
>

-- 
Best regards,
Alexander Ivanov


