Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 153E6831AAC
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 14:36:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQSYV-00012c-Tx; Thu, 18 Jan 2024 08:35:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1rQSYI-000125-V5; Thu, 18 Jan 2024 08:35:27 -0500
Received: from mail-am6eur05on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2612::701]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1rQSYG-0002cA-Bd; Thu, 18 Jan 2024 08:35:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtVVP2kYldvddWZoRd4gRoIoJ7aZ4X+Q0WofB621d/lASBn8wcYLixPjS3sEG4Ky8rTtfCrGucxcm/SIbB192k686zwqxhOG6VJ7kY4BJDR1VubpnE4EIwOP0tpks90KXl6j2ATVWtFz57LtakwVwk7biH1+LnVhjwgQrR9QDnOSwngr8YB5Bqrnqb2savxiAN3sXkAX8DyCuoawRx0kdBycfsRVCvz6J9/q/MkQAa818VnjshPu8eohgsJHZx/MhGOhqP2EaV9eJGgItGZic/nHAnZFk09HW3jGOnk49X4hUjHLsRwrbuI1/RAQrYLuhvhiylslEHGWEvJXAjecWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILUGTxBKVSFM660500OwSw0nE1J507Px4nTs29wAQdE=;
 b=Ke3hrRX51WuoheYNcO+UNT4T+7i6tTiy6z3RwyWllj1zYRD1AxGtUFO7hYFjEn4iVG8O9uq7Z0E+UtxCuNirEM4k4lDVC1wN92she9xhgslieqU2eTJQhynCuYcXEHqtaXFRBUHRQfGh+ETnGc3yDZi+b2prboggIQeVHtbI7uxnmEaXHQ4JzS7rs6d/m28fdmupgHDH/n2ZxPQtlNQar2DJaWTTbuG0bj8l9eKPOu6ZlN2G6/KCq36vMpvW8momqMGJQcqLl7/rYIMoig76z3zYvAeJlShpnJpfWC0MqHx+4MHKnIbu8ALaDiHlPzl4tlb+WD+OleLffM/WBFSS3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILUGTxBKVSFM660500OwSw0nE1J507Px4nTs29wAQdE=;
 b=WNPQJQCH+oxBK7kVBGQm/GgEYdtyX0PflDnO3PscscvWy2NEj/8uHmh1CqCzZnKB8/t3r4XCX+QFoyHrULtoQe6NeEOzV5PJItYdpAEW0xpJUU3O8GIvJN0E7+YJGAJffiLDg/5xHzLlmgbBeNlRQ0KICnXQaCFUGpn+nvXJMVbdMHRv+XqWQyYNW/lqR8wDDdTzO9Lk7FMzpKKEwFhMBFkFrVe6jetdiHLSnJs9bkd3dJIalcsFEokNUj7AMXfvf/CIt2cuwK4aomIylu26NIF+jl+Q3b20qDMv2HdGxZ7w7PXJkhzHy/mk/NIJemL6hFzNvSNtwK5US8/k0SOEAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AS4PR08MB7830.eurprd08.prod.outlook.com (2603:10a6:20b:51a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 13:35:21 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::305c:3923:7c79:ddfa]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::305c:3923:7c79:ddfa%4]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 13:35:21 +0000
Content-Type: multipart/mixed; boundary="------------6OylAR0kJL5YEqnIZ0JIKRFe"
Message-ID: <db49ac10-8b4a-4ae2-95fe-7ad73fd64469@virtuozzo.com>
Date: Thu, 18 Jan 2024 14:35:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/21] parallels: Let image extensions work in RW mode
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com
References: <20231228101232.372142-1-alexander.ivanov@virtuozzo.com>
 <20231228101232.372142-13-alexander.ivanov@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20231228101232.372142-13-alexander.ivanov@virtuozzo.com>
X-ClientProxiedBy: VI1P195CA0091.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::44) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|AS4PR08MB7830:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f8b9bb0-2f2a-4b29-02b4-08dc182a511b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bZxpGxmf29JAm9b102KBsEXUO7X7Xr8MUuKPN40iy1pMdOXifEnNiQhMQSeJh5zctAy7sdhz8j1SaQyF1zKmXrTrfPOBx8fxR8ZxqSg/Hgwh7fIGloMEAT56P/lZcQJvfcPGedR5yZbraCJf0s7EXE+Qv8iYcdMxZGdyMw3Sr8MuQJobgGJr3S7aXFWrZzLKmXj+rXO9xEf1EPgpnOZO+k5uHdA/+ko1DtvmtgqOy7h+NFxRLBjAarL6hh9R5DAfLyClltGuyG8VA39vgxxiVuL/j07OHfYhQlYmyiksOJ1KVTGA1siiNHZHwVHj/+b9rVCPJJuMmuEWeISlMfEqnyNsLidb9lfTm3HWbQTCqkrfPBg7Pn4WPQEDDzOo3dJV+L9I4OQ9kURcm7OJQ2p8gDszUDLhKFzL9pgs04pwE5ZgJJFQG795bExRendFNWHp9OCa8s3Z5FFSqfUFb/0ciCFA1BuRNmV7CZ2vNWxcRh+gIv3MQ4j0QnFO3LqcA1NIlmiA3bbj//2UVWMytZpXCg+qzZ3QadUoWJSqquUcdve447Tw4cbo3MyGV7zrEDENpBNyQD3+bAb89cokuBUpELB9SBI14eduQBYWNdj/ljj2M1gs/mMgAlqtd17MGvrRsqUxH43IeLvO2f+P8YMS6uStBsVkAuQ93pLkGqUgx65vDJlIEIo2RY/uPTN1f72J
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(396003)(136003)(39840400004)(376002)(230173577357003)(230273577357003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(36756003)(31696002)(41300700001)(86362001)(38100700002)(2906002)(33964004)(66556008)(66476007)(6506007)(316002)(6512007)(53546011)(6486002)(8936002)(66946007)(5660300002)(8676002)(83380400001)(235185007)(478600001)(4326008)(2616005)(26005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWZ2Y1hXcmlGcHdWTVVCVXlXQVV0VWNKTFk0bEZyamxyQkdFY0R0dEFHazI5?=
 =?utf-8?B?eEYvQU9KclFaZDFSMGpVY1VFRXFuWkpxUFdDRmt3OXgrQm9oeUU4SjNMcFNj?=
 =?utf-8?B?dGRDUVlKcXRvTjV4VXlaY1dNNllTS09wUzlDbWlMQnRoWmphWFZyWU9IM0to?=
 =?utf-8?B?NUgrN1laTUJ3aGF0Z0s2NVdyeHJIZ2JGcm00RUdoZWtROHZYY08ySTZvK3pT?=
 =?utf-8?B?YlNqUTVQUCs0anFpMVhDM3g0eDB1cEZXcFdKcFhDemkyMUF1OEFNVU5lR2x0?=
 =?utf-8?B?SUhZOXBTbDFiSEZFbXRXWjBvNUpOQXBlb3B2b24rdUVSdzIwa2hWbHpEK1FI?=
 =?utf-8?B?dHJod1VkZ1pacGxGRVNSQlMzTGd0MXBONUpQakc1em0zcEVpSnJMNlF4czV5?=
 =?utf-8?B?QjNtS3hhcmk1ZnFpMDd6UEhUd1ZHekJ4TDg5V25EQURYSWRxL1hrMm5QbGhV?=
 =?utf-8?B?SUVTcDNQNWlTaWtxcFpQSHQ1UnlSVURoTUJLSHhkQWI5aVRqTWNkaVQxakNC?=
 =?utf-8?B?UGFWRmFXWFFGcUxZYldQWm9qelBmM3FLSk1HWERPVmUva3psNjVhUkZuamZr?=
 =?utf-8?B?SVpnWEp3LzMwV0hoNEVPUm9qSzgvUCtjQWZIOXF4SmJUSlJDcnNJS0xJZTBD?=
 =?utf-8?B?MW1Yb25TZ0VHRkZvOU1UTVBUMDhPbEhCK2tNRHUrL1Z1dHdMOWdQdUdSZWxM?=
 =?utf-8?B?MnlIRDVNdWZnTXJaOWExOVkvZExudGMvb09TbTZvYVFSSE5jcGphS2svZ05C?=
 =?utf-8?B?bElRSWVwbFdTelFCUzVPME9UaFdtalIxeTRaWjV2aEkvLytDVElnT1BrWEdx?=
 =?utf-8?B?Nk5LZVRYM0tqaU0reGNGMzVhT3p6R25iVGtFV2RjbFgxNUlQRmFrUWltdXlJ?=
 =?utf-8?B?bk1wMUtuTWZZME91ZFFsRTltY3pRYktLb0gyNnZ4SnRHQXlxY3k4Z3FPekZH?=
 =?utf-8?B?ZHlLWUxheEhhcVpEcXlEakhrODdWY0I4eGtJYVJ2OGVkU2pzcFBCUjBmMTlZ?=
 =?utf-8?B?bTRGa2ozSzFONHFQTXh4cEwyOHR2UUhMYTBBRUhEbVd4eDBwQUpJaGtEbzBE?=
 =?utf-8?B?anRaNnRoczlLV2RnYWpMK3BjbWg2Qmg0WlUra0w1QzU3bFpwSUtzZlY1TCtt?=
 =?utf-8?B?U1BvVW56VjljaDh4NTM0azUxQTZSQ1N0azAyVzFDZXp5S2dOOWNUbDJhMzY4?=
 =?utf-8?B?K2RPU1hIV1JwSG1KbE1TZ3JWZEhZRmpFRHNUc3RnbHkvWk84eXNTTnVJcFM3?=
 =?utf-8?B?Rk5rUndtbHRVcGY2Y1IwUUdmdjY2NFM3UUU1aW45YkY3N2cyWUtHQnM2VGx4?=
 =?utf-8?B?SWdmdHRzSGhEbG1GT2NWbHMzVjRXK3k4OEh0czFwZW1EZGJpTFZOU1ZpOTRV?=
 =?utf-8?B?ZWhTMVVFeXpuZ095bHNkZjB1cjdCa2MyQTM3TXA0akJRYW9vV2tCWlpwSnF3?=
 =?utf-8?B?WEVxdGFWbTZsVnJjbkl2cTRMUW5ZNW96RWl6N0kwL0tRZDZvdEJjajMvcWpB?=
 =?utf-8?B?Uyt4aW13NXJxMkk5U0poUVdveTNKaUkxSFI5eThtMmdzZnN3S0Y1UEhaS3Bk?=
 =?utf-8?B?OXlHQU5Bc1BqbzNtNDczVTI1TWdSRzA1b0VOMW1CK1czaHZpaWt2SzlxMUhB?=
 =?utf-8?B?bnpBcFpwOGxVL2dDcUF0VE81K3c4QnVVM2M0bi9oeWxmZ2MwVVlQV3A2VGsy?=
 =?utf-8?B?dXVWNVE5MFJNeDhTSStWb2wwY1QrajFtUzhKTHBmWEVHemJDOXZkSW1XT1BO?=
 =?utf-8?B?MGVyWHBRL0FFaElTbEpuYWZOTm9xOHBOeWlYSFovUVRjcnlMYld0NWRSRnR1?=
 =?utf-8?B?TGw4alZyclljdXBXakw1TEM3dTVwRFE4anN5ZzdDYWh4ZDBSeVhSOHlQa2Yz?=
 =?utf-8?B?aERENzRBaGhseUN6anBTZ1BsZHhnSG5NWWpCM2sxRFAzbUthdGo0T3poc0Rk?=
 =?utf-8?B?R1V5dWFjWXJ6OFExS3g1dlgrTXZhS04yLzh3Y0pQVWxiOStNUlVaTjgzTjFo?=
 =?utf-8?B?endnNWIxaXRTTC80TDZCK2xBMkZPNEVVMHBNbTBsVThEZU5md2RJYkI3dVg5?=
 =?utf-8?B?eFMxOWVKL2J6VHNqcno4Rk5zcHpCSytMQndLRU1zN1FaRnpLUS9UOWRKZlRT?=
 =?utf-8?Q?lkMDiJZo6OLZkl/Ee8dmJpdei?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8b9bb0-2f2a-4b29-02b4-08dc182a511b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 13:35:20.9287 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pQ15g7A42D7F4cRM0GOEGKdA1evbXvUq6A9ht6NK66OfswbaZSDY4xOUK7ttTiqDJ+mCL8yXwAl33l/sIYnaeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7830
Received-SPF: pass client-ip=2a01:111:f403:2612::701;
 envelope-from=den@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

--------------6OylAR0kJL5YEqnIZ0JIKRFe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/28/23 11:12, Alexander Ivanov wrote:
> Now we support extensions saving and can let to work with them in
> read-write mode.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>   block/parallels-ext.c |  4 ----
>   block/parallels.c     | 17 ++++-------------
>   2 files changed, 4 insertions(+), 17 deletions(-)
>
> diff --git a/block/parallels-ext.c b/block/parallels-ext.c
> index c83d1ea393..195b01b109 100644
> --- a/block/parallels-ext.c
> +++ b/block/parallels-ext.c
> @@ -175,10 +175,6 @@ parallels_load_bitmap(BlockDriverState *bs, uint8_t *data, size_t data_size,
>           return NULL;
>       }
>   
> -    /* We support format extension only for RO parallels images. */
> -    assert(!(bs->open_flags & BDRV_O_RDWR));
> -    bdrv_dirty_bitmap_set_readonly(bitmap, true);
> -
>       return bitmap;
>   }
>   
> diff --git a/block/parallels.c b/block/parallels.c
> index a49922c6a7..d5d87984cf 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -1374,19 +1374,10 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>       }
>   
>       if (ph.ext_off) {
> -        if (flags & BDRV_O_RDWR) {
> -            /*
> -             * It's unsafe to open image RW if there is an extension (as we
> -             * don't support it). But parallels driver in QEMU historically
> -             * ignores the extension, so print warning and don't care.
> -             */
> -            warn_report("Format Extension ignored in RW mode");
> -        } else {
> -            ret = parallels_read_format_extension(
> -                    bs, le64_to_cpu(ph.ext_off) << BDRV_SECTOR_BITS, errp);
> -            if (ret < 0) {
> -                goto fail;
> -            }
> +        ret = parallels_read_format_extension(
> +                bs, le64_to_cpu(ph.ext_off) << BDRV_SECTOR_BITS, errp);
> +        if (ret < 0) {
> +            goto fail;
>           }
>       }
>   
something like attached should be taken into the account.
Though the destiny of cluster with old
extension offset requires some thinking.

I would say that it could be marked as used on read.
Anyway, this requires at least detailed thinking.
--------------6OylAR0kJL5YEqnIZ0JIKRFe
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-parallels-drop-dirty-bitmap-data-if-the-image-was-no.patch"
Content-Disposition: attachment;
 filename*0="0001-parallels-drop-dirty-bitmap-data-if-the-image-was-no.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAyZjcwMTY2ZWY2NDAzMDQ3MjZkNWRmY2VlM2U5MDZiMGJhMTY3NmRkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiRGVuaXMgVi4gTHVuZXYiIDxkZW5Ab3BlbnZ6Lm9yZz4KRGF0
ZTogVGh1LCAxOCBKYW4gMjAyNCAxMzoyOTo1NiArMDEwMApTdWJqZWN0OiBbUEFUQ0ggMS8xXSBw
YXJhbGxlbHM6IGRyb3AgZGlydHkgYml0bWFwIGRhdGEgaWYgdGhlIGltYWdlIHdhcyBub3QKIHBy
b3Blcmx5IGNsb3NlZAoKVGhpcyBkYXRhIGlzIG9ic29sZXRlLgoKVGhlIGFwcHJvYWNoIGlzIGV4
YWN0bHkgdGhlIHNhbWUgbGlrZSB3ZSB1c2Ugd2l0aCBRQ09XMi4KClNpZ25lZC1vZmYtYnk6IERl
bmlzIFYuIEx1bmV2IDxkZW5Ab3BlbnZ6Lm9yZz4KLS0tCiBibG9jay9wYXJhbGxlbHMtZXh0LmMg
fCA4ICsrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0
IGEvYmxvY2svcGFyYWxsZWxzLWV4dC5jIGIvYmxvY2svcGFyYWxsZWxzLWV4dC5jCmluZGV4IGM4
M2QxZWEzOTMuLjU0ZThiYjY2YTYgMTAwNjQ0Ci0tLSBhL2Jsb2NrL3BhcmFsbGVscy1leHQuYwor
KysgYi9ibG9jay9wYXJhbGxlbHMtZXh0LmMKQEAgLTI1NSw2ICsyNTUsMTQgQEAgcGFyYWxsZWxz
X3BhcnNlX2Zvcm1hdF9leHRlbnNpb24oQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIHVpbnQ4X3QgKmV4
dF9jbHVzdGVyLAogICAgICAgICAgICAgcmV0dXJuIDA7CiAKICAgICAgICAgY2FzZSBQQVJBTExF
TFNfRElSVFlfQklUTUFQX0ZFQVRVUkVfTUFHSUM6CisgICAgICAgICAgICBpZiAocy0+aGVhZGVy
X3VuY2xlYW4pIHsKKyAgICAgICAgICAgICAgICAvKgorICAgICAgICAgICAgICAgICAqIFRoZSBp
bWFnZSB3YXMgbm90IGNsb3NlZCBjb3JyZWN0bHkgYW5kIHRodXMgZGlydHkgYml0bWFwCisgICAg
ICAgICAgICAgICAgICogZGF0YSBpbnNpZGUgdGhlIGltYWdlIGlzIGNvbnNpZGVyZWQgYXMgaW5j
b3JyZWN0IGFuZCB0aHVzCisgICAgICAgICAgICAgICAgICogaXQgc2hvdWxkIGJlIGRyb3BwZXIs
IGV4YWN0bHkgbGlrZSB3ZSBkbyBmb3IgUUNPVzIuCisgICAgICAgICAgICAgICAgICovCisgICAg
ICAgICAgICAgICAgYnJlYWs7CisgICAgICAgICAgICB9CiAgICAgICAgICAgICBiaXRtYXAgPSBw
YXJhbGxlbHNfbG9hZF9iaXRtYXAoYnMsIHBvcywgZmguZGF0YV9zaXplLCBlcnJwKTsKICAgICAg
ICAgICAgIGlmICghYml0bWFwKSB7CiAgICAgICAgICAgICAgICAgZ290byBmYWlsOwotLSAKMi4z
NC4xCgo=

--------------6OylAR0kJL5YEqnIZ0JIKRFe--

