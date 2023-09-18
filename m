Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE957A4466
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 10:18:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi9SE-0000FP-AO; Mon, 18 Sep 2023 04:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qi9S1-0000DP-CC; Mon, 18 Sep 2023 04:17:50 -0400
Received: from mail-db8eur05on20721.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::721]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qi9Ry-0001cK-Sn; Mon, 18 Sep 2023 04:17:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDIxP+rwJs1LS+MrbkHqRwpQk/0A/neYlhgTkgCNaWzOjSNtV/1Ny6jLmhz+P/Wr4nOQRVyLMpd7qXfuB1XPqihQGn80mADF992ilSuDARPgNNTbdyzP372vlkBEtIubyFkay51pp+L1iY4+GAhR0auae3ibVfMV5UcgUEWDlp3Oe7SjNZU56EWC0eT7IjixSyjkQ7r53nWtgKbG0sGEyVPsV3IoQcboGNtxvs2kihZfAelVgFFnC7+zkTin6ZqoEVXdOyUMFmgWwj9mIdzp92IVJApVNM8n5wL8bngHz6yGKvdgzO3/lQnF2+Rw3do/hZoy/5xkGsTo5TKwBkwGmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhu2MMT2/Q8EIvOYoo3+YZDd4Hp+Icn1MWXctggdovI=;
 b=UBiPAL9dQ6TMe84MpC8fiPfOc9/znL5s15RiZy4CoS+trr5m4RHyFUdJ4PuLagx0e94ftKTDz3rmMg1WeuE6FfD+JMKg/EKTUj42l7DyZZUYMXf+LRwj7eA+r4tih/XdUWgjvwC5bK7aL25JEeY+CTOpDtScNILVZYCczuN7PXg79h9nik/zn/wPa/DHNzVbSlEjHCUb5R7HA8GyOBAvxOBZtA1PjrY2VNpTrsAbS2mvXMU+YLCRF4Pkrx27ilbMP/GFztXdVkBdOW4AbW6Au+KoRiqz7rB9wi2Sa6U+CjZ/L4DyFEjhi3439y2Hh9m0z+VTMfJgk1HNxbIC2agtxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhu2MMT2/Q8EIvOYoo3+YZDd4Hp+Icn1MWXctggdovI=;
 b=LR22uKln0edi3i5ebyBBmUolkzsfruB+ukXvZ4uzP1+xjnB2rrpCAbxZ9M7NzLT+VPzsfWnMmle0T/8zMdK94cIErzKoxTjnWr3NTMEPNB88mNV6K5opSGdLux4HrrCf/BAbjFUH0gmevR++sHL1ROHcYPLiGJkIN021JEIn6ECwabMWbm1mfRydnxXTgvYnapwQDIzwdjgYx/pigjum3eccpR1BOHBTFwlQej6ZnBuuOm07e56FwQCxyvh5pkoh8FJsicLpalWLnmAoNU1eIcpcgOgCHU43kT94S9H20iD9UPb70mm/vm0XAHGOYdNMDTYy2HEFUWXQdc13tQKJ8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by AS2PR08MB10179.eurprd08.prod.outlook.com (2603:10a6:20b:62e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 08:17:43 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 08:17:43 +0000
Message-ID: <35eb06c3-27e9-6576-5009-615b7f9ad76d@virtuozzo.com>
Date: Mon, 18 Sep 2023 10:17:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 05/21] parallels: return earlier from parallels_open()
 function on error
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, mike.maslenkin@gmail.com
References: <20230915184130.403366-1-den@openvz.org>
 <20230915184130.403366-7-den@openvz.org>
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <20230915184130.403366-7-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0099.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::40) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|AS2PR08MB10179:EE_
X-MS-Office365-Filtering-Correlation-Id: 625784d0-98fc-488f-2c69-08dbb81fbb8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c1HSn7vqriW3DH7TH5tiMKmrxLKAU8b8VsJXCE12FyhiVXMX3A71GZJWDa3WTEllzFYjmoCEfcKssiPf2h2DGd6NqlVplJkC7YAbaMdj6FIrQJF1pqEyG7CvhPnTLeK8f2hl6DGKLp6sh0AWwGF0qTFm73KrC4lJZecwucBIHaRUTR7E2u41jklpSEDFPrTv315/xl453AENMlKOCpqKwsDKAtkJq+9S7Yn/r7aAKlqZrScCC0bf6rR/S1E0lcHNmPHFV55ozxoYx+m5EAadlqSeht1lULUUcq48g1Qv9QnmcZ6RRW247Dlq6CPCzNhNJNJGr1FjnT1+qev41QOnNoh3zT447TGXnM4GUauxfeMJVFa/3dc9RU1Sjpl30b9pKtrWTIbTTA+gTeJklRMIsro6rW25s4ek4YoEhC903a+UgesRdQhrHjVP1mp6VPVRFqogaiXxtYFYk+ek3yx++EhkwkcxzB141iTDEAw6JGQg3AASdmJ4cG+3FLitH5gNuQ86lNgVWYZreLoBUaCy0O/qwfFS9Ggdkg9mY3HkGfmJZTkf13CJ1PCknO3x1btiRSAL0BgLrBU2RSsY6RbAkUFzZqJxpOrzmWDCxBHfEeGi2y0pHahcQ+wG7zuNJLr/i8uT4sPD4RMg56BaSnDJ8oLYNWLNFq+7bfixxG7FG+OZ2pErPFIJrl4DK9WukgiK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(396003)(39850400004)(346002)(376002)(1800799009)(186009)(451199024)(53546011)(52116002)(6666004)(6486002)(6506007)(6512007)(83380400001)(478600001)(26005)(2616005)(2906002)(44832011)(66476007)(66556008)(66946007)(316002)(8676002)(4326008)(5660300002)(8936002)(41300700001)(38350700002)(31696002)(86362001)(36756003)(38100700002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alRlclN0MGphemhKdVpjanJ0OFdqaWNOaWhKV1BZZDlEeVlKbXRaZm5KR3Nr?=
 =?utf-8?B?eEtWL1hHbW5peGpadDdmQVFac0hqZXZBSXZJVWJxZGhYdlpub0cyc2Q2OENK?=
 =?utf-8?B?d012aTMvZDZDUkdiUXh3NDRoakI1REYrZERtZUVvZ1FGb1lPbkpJd3prV09Z?=
 =?utf-8?B?WUk5N2J5bGxGUWFuSVpqNm5DT2w3MC9kbmJNRDdZditrc2g3NXVoVld5eVFB?=
 =?utf-8?B?MFZsQnhMOGhGVHBKMDExREVDTUY1d3h5dFhaT0dNbk0xMTI3eFNMV1Q0aGJ6?=
 =?utf-8?B?ZGFFQXI3NVNKeGU2cGVkbTFRdU5GZjJIOU11TkVYR0htZFBXZ1JYZmVPR0ZB?=
 =?utf-8?B?ZThMcFEwM3VJR0oyVjlwYUxqM29WRWFNMFJTd0todDFOTHA3cEZWK2JkMXhU?=
 =?utf-8?B?UHE3bStYTlN3eE9STmRiZUtBUXYvdFI5eXdBNVNaQ00wR05aajRKSmRsUXE4?=
 =?utf-8?B?Z053cVZqQWg1Smd3MVRJZzR0MWkzTDBtdzFhQjJUamxZV05nMGdPcDZlbEYr?=
 =?utf-8?B?Q2J1RldIa1BjeVdiMFN0ZUl4czlvTFk1aDJkSW9SYjlUNTBNNXF5NGE1OVFt?=
 =?utf-8?B?ajNFb0F6RDdFdmVkOWMxa1dQSlp5YXh1dW1qdEw4TmR1VjJmbWlOQWY2a1RM?=
 =?utf-8?B?bkEybjJOV3BuRHhrVGIrN2Rab0FBbkRRUWJ0K2lldmY2UDJDRjFSUGZWM0Vl?=
 =?utf-8?B?a2VPWHN5cDBPa3lhS0ViamZzMHZUKzBEVDlNNzh3QmNNaWhRNUFjZk9McU9m?=
 =?utf-8?B?QWRLbEpJMVNiNTR4ditJN0llV3g3b2xOa3FuZWk3eG1NSVJtSmp4RHc0dHRW?=
 =?utf-8?B?ZkJQeHFVQ0pqQzFFbDFwOHA5dTlGYzhEQUdSZWJyazkzcHVlNWxWWFVCbFRa?=
 =?utf-8?B?REZsclJTM1IzcUY2b3hvaDkxSE5BdEp0endxK2FpdWp4L3ZLdHYyajNzelpy?=
 =?utf-8?B?YnJSNGpGSlovdlFtYWo5czJYM0ptcHNDOTE4SjhRSEN1SldrUGFST3JPT1Qx?=
 =?utf-8?B?QW5rSk5NcTMwUkxpcGFpZmQ2WHlBRTBVNzUvV2JLU2VXSUhVMVNHcFBQMmtX?=
 =?utf-8?B?MGE3cGlVS3p3L01FNjNZSXRGR29Wa2diMUFZWFBUMm5KcSt5UjVtY2tqZEJW?=
 =?utf-8?B?QUYxcnk5d21EYk9qSldiVTVhYkM4TExYZWF5T3VyYkxkWXJ5MTlmSTEzeHVr?=
 =?utf-8?B?bFRqY29lcmxwS25VTTlYak01MUVWRmo0RjhTaC9FVjg5b3QrNUVsQTRHajQ4?=
 =?utf-8?B?L1RoekpGSy9zdTBOZTJrTGVkUFA0aTN3NXNYOVNDMjdyRTFYREFMeW5ENHVV?=
 =?utf-8?B?M3dlVEc3VnVLVWszOENtU2tiSjlaM3lLSkN0dXZJZkxGTmdUV0NST0dtS0Ew?=
 =?utf-8?B?bjB3cmEzR1BxeEVWekZDRFcvV3l5ZUcxRk0yRE1TRmI0WUo5SVU1dDViR09G?=
 =?utf-8?B?bXlxajlUVEJ3ZGNNdmwrdTRNYkhKc2JEMnJSUFNnY3BtWXlmUzJ0eG1xUkhD?=
 =?utf-8?B?RGo3NWJTWllBUGtkV0doRVNqQmFTY25qNGRJSzd5RnpQeFVHVENBRFhhTWo4?=
 =?utf-8?B?ZVdHT09Idmk1cUs1UExYNEZ1akR1OVdzMkFPbFhrQlBEc1JzRHMxSzBVTlcw?=
 =?utf-8?B?R2F1S3k2YlRKMXJDMlBmbmFvNUYvblJubDltYjlTK3Nkd3d6cS9DWHdPRUdT?=
 =?utf-8?B?V2VieFUzeDJ4ZnpiNTBKM3B2N3VVbDMvZTJWQWFqSXhFZllmaHBFTk9IZEhv?=
 =?utf-8?B?OEQrK1FCZm5HS3ZFL0p0eWc3L2VtVlJxWWdKTjdSNTdHMWo1YWt4b01tT1pa?=
 =?utf-8?B?c2R3ZmtjMkcyS2N5R2ZNV3NJSEt5UkFteFI3OW1leVg4dGVkRllyVHVLN0wx?=
 =?utf-8?B?dmFRMldZdVZ3SmhaUXVmZ2lVUDk5WTVWYUJaVHNjQURnaUlDN1ZxNStDaUtZ?=
 =?utf-8?B?Z1FJTUNvdFc3bVVGVDd6MDNoZzhtYmg2ZFNZSUlsdjNNSTcrZ1pWYWdzNVNv?=
 =?utf-8?B?L054cDhwdTZLejZBcUZObG1MR1FibkEvazFRTGJZZDR3cnFiN2I3a2VSMnZl?=
 =?utf-8?B?eW1xZFl6dGZXRGxzSFZ1UytobkgrRGNrVFF3TzZMQis3MXJsOW1ZaFVNM0Zs?=
 =?utf-8?B?VXhtc3NjdU9hbE9XaS9Cb1lPN1NtRE53VnhEazV0aFFnNllkNEtScEhjd3ZG?=
 =?utf-8?Q?NxunJlbdD2PpNteyhsKfRhw=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 625784d0-98fc-488f-2c69-08dbb81fbb8b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 08:17:43.3972 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JSWcDJsExrjQUJbuzq7vbewNWFFogsl9Faecemp8RmLEH+z4nXbnLgoBz7crBGJXTnLWfxlBj+P28P1gjtix3kH3cc3F3+ewDhdyVeQzU/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10179
Received-SPF: pass client-ip=2a01:111:f400:7e1a::721;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/15/23 20:41, Denis V. Lunev wrote:
> At the beginning of the function we can return immediately until we
> really allocate s->header.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>   block/parallels.c | 14 +++++---------
>   1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 0f127427bf..8f223bfd89 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -1084,7 +1084,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>   
>       ret = bdrv_pread(bs->file, 0, sizeof(ph), &ph, 0);
>       if (ret < 0) {
> -        goto fail;
> +        return ret;
>       }
>   
>       bs->total_sectors = le64_to_cpu(ph.nb_sectors);
> @@ -1104,13 +1104,11 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>       s->tracks = le32_to_cpu(ph.tracks);
>       if (s->tracks == 0) {
>           error_setg(errp, "Invalid image: Zero sectors per track");
> -        ret = -EINVAL;
> -        goto fail;
> +        return -EINVAL;
>       }
>       if (s->tracks > INT32_MAX/513) {
>           error_setg(errp, "Invalid image: Too big cluster");
> -        ret = -EFBIG;
> -        goto fail;
> +        return -EFBIG;
>       }
>       s->prealloc_size = MAX(s->tracks, s->prealloc_size);
>       s->cluster_size = s->tracks << BDRV_SECTOR_BITS;
> @@ -1118,16 +1116,14 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>       s->bat_size = le32_to_cpu(ph.bat_entries);
>       if (s->bat_size > INT_MAX / sizeof(uint32_t)) {
>           error_setg(errp, "Catalog too large");
> -        ret = -EFBIG;
> -        goto fail;
> +        return -EFBIG;
>       }
>   
>       size = bat_entry_off(s->bat_size);
>       s->header_size = ROUND_UP(size, bdrv_opt_mem_align(bs->file->bs));
>       s->header = qemu_try_blockalign(bs->file->bs, s->header_size);
>       if (s->header == NULL) {
> -        ret = -ENOMEM;
> -        goto fail;
> +        return -ENOMEM;
>       }
>   
>       ret = bdrv_pread(bs->file, 0, s->header_size, s->header, 0);

Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

