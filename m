Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 184727AF4A2
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 22:03:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlEGx-0003kh-E8; Tue, 26 Sep 2023 16:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qlEGs-0003ic-62; Tue, 26 Sep 2023 16:03:02 -0400
Received: from mail-am7eur03on20717.outbound.protection.outlook.com
 ([2a01:111:f400:7eaf::717]
 helo=EUR03-AM7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qlEGp-0006oS-Hk; Tue, 26 Sep 2023 16:03:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNudDhBbUmZLORDnywjkwaeVu9sE9sXfi/WJhZQ06V3oGxi/kkt+FXVbe10ijt/Efuiau4LtOXsYrgjpI0levi1pJk8Fz4H+2YcGFD5Wg/BRji5q2OmgzXzTBPOJhSvafEi0GxJH8Wj863yVFm1uaBFfnlVeUitsDYCuBULA/RNQxJbSWTl7R4Je6G7U/Z0JkjmQKvS48AOBAaydOKXPINc/VR593LE4nMRAkBh9w43LNZEwJOjq8tquKHupQbj/a2ulBvD7vWazJRhvt4pVMOfSe8Ceh+K5e3YGzn7txuT+HGpms+jJFc/sJypbvD3gku9fsRvm0nfL3kaeiu2qCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=goXBu67oCe42m2ZqGhuolK3TIoy4SS7EijvVa4o5b1Q=;
 b=mLDnM+m6bZ6MtyC6b/wWYQN/48kAzNdgV5jxqO4MYo73gkLHWVJNbIsJcB/lRHQZf5nin0SvZbDzANglRANSjr2tQg+Oc+U0TdeZkfBvkzSGPEjHKISucxSqpO5uKiqSIbdZ+XUTorKDmYPeqz3ZP2Nkp240OoYND0qkRZFO1x5pc4b/ow8TdpEF1+0o2rfNmgCrWo4gL5fWET0upHe3r7COjZxabr86pt1sAoYffXCxDleCO8hB5VhJXIH4YKS8P1obQCZL6uEfaps8WYkl5e+K4zX7/lpbkB9ikYpE6xQi5gwnurB/tcPECtXfCw8xpjvQvc2k7VQYFxoeXlU+1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=goXBu67oCe42m2ZqGhuolK3TIoy4SS7EijvVa4o5b1Q=;
 b=lB+XzuF76nAIY64XF1NwJrNozb6PBKXr4LaJ0dF+5PxMuOiVK2JWz4kVpQThrtr0+uJixTNz7wZAm3RYadV4VMLqC+wRertTNoomz1dINGch3JDv1LGZY2UYuW2KwQ07NV0YvtjnS4LOoQbRpVqHZ+c/DB478cVgPC2uv1uLt+mWRfw+rzScgCH//JHaXOGvA2MqY/PbXYhQcbz1SgruJhqV36nRRgN0Dz/9ZKE4KcdON7rJ82ab6yDvpumXAxqR01s2gwIsHcPGyr/uN089ZzhuGtN8vll0dRP0qOVYHnWO21yZlFGkfGgaDFwNQ+dougLvYl4qFivjYehTLfrSPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by DB9PR08MB7699.eurprd08.prod.outlook.com (2603:10a6:10:392::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 20:02:53 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::8ba1:5878:7574:628f]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::8ba1:5878:7574:628f%5]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 20:02:53 +0000
Message-ID: <50c169fb-134d-7b20-eb58-53df71295877@virtuozzo.com>
Date: Tue, 26 Sep 2023 22:02:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/1] block: improve alignment detection and fix 271 test
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Cc: Nir Soffer <nirsof@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Alberto Garcia <berto@igalia.com>
References: <20230907215326.367847-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20230907215326.367847-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0247.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::20) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|DB9PR08MB7699:EE_
X-MS-Office365-Filtering-Correlation-Id: bd6ef77d-7c99-4fd1-7f1c-08dbbecb91c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4GDJJoOiWHZacQLC3xtyA/xnq5ap74SdEm9eiBLKG8CRFSRzg44tyfkToex9YFrMlixVwPb6TDZnBtHIyq09jKpdaq0uxdLRJ5ye+9YXNxKe+mrS0nhyWAAFw+HwYEtW+v9hc5G5VtzdDRphnFKyV+LvJ9tZh0i7Vfi5EBg24Kaz5yys9KSlVTziuHITX5OLoTdVCbEkL4Hn4KjK/OBxJL80F2rECFpRdjFUPzU7s/00h+rP4EpERnIqA6t930wXyS0q8EFTBWPPX2aFT0in8vzIGoprNvq/jIicGkI5UV3Bj6KklAxgyZNLddz8T4VrVfr65aVv0lEHqVQRHqQcKokfleO0h6dG404t84r1fKIeIAQOTWl0k9qCvf2G2XrzAQX21OxUDtA1DWyIThNbJf7u1Bbn9pXWo5vbmcASBIf8eYmvTUh7PtabkXopUWTCCuz1fHff0wfdnMSV/9x9oThUGeCg9zjrfIgyMAT111Nnek8aE3KtgV7ZxjamZM8CoDz9vn61hBRUgGqUh9FV5/rSJ0iox55q/Nhq0z35TM5avIEqM4PnhXLuBokWeotVFuzdCdG/2ljp/ViKLdPRcOXkxJi4U8qok8VnC771QSRawaImkjiW+sq0KlUsUrDaZGS9P41FyCrdfzSdE9u/VA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(346002)(376002)(396003)(39850400004)(230922051799003)(186009)(451199024)(1800799009)(38100700002)(36756003)(86362001)(31696002)(31686004)(2906002)(53546011)(66476007)(2616005)(5660300002)(41300700001)(316002)(66556008)(54906003)(66946007)(478600001)(6486002)(6506007)(6666004)(6512007)(83380400001)(66899024)(4326008)(8676002)(8936002)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHY2V1dTbGF2YmlYMzNjVXNSZEhoaGlmZEhJYUJXeGZYL1ptam4vWjNlL2Jy?=
 =?utf-8?B?emU0TFI2YlU5RTMwMXA5MWJybUxxYkRFeEpTNWlvTm5NdVpkeDgwcUZ0OXU4?=
 =?utf-8?B?OE96cmRkOXd0QTB0YzlTRDdXRVh0TkRKWUVsa044UmZKWmhrTTRrdm5jNHU2?=
 =?utf-8?B?eTkzYXNiR1VxTmFoT3BlRkdGWXJSdXk4WUJFN2dTRWQvbWJlNHF6Y3RXM0VC?=
 =?utf-8?B?WkRmSXUvMVVERDViRm52NC9lNmpYY3g0aGlTcUhxUG5pZCtzRi95dmQwTjY3?=
 =?utf-8?B?ZElIUUQ3TUVDM3pvNjIyUnZBb3JiV2VkdGcyNnk0bndkcWZ6akdXQytsQ1hZ?=
 =?utf-8?B?NFhOTWZrSURaaGlQc2RIUUsyQlZkV1dmTzNnTEpBN1JpMHJtZmlhK09oUXJp?=
 =?utf-8?B?c004eHNUdUdPVS9GNVRNM3pJL2U0SGxJM0ZyY0Rwa1dkdkVpZlQ4L0YvY1Jp?=
 =?utf-8?B?Vnk3VExkc1kzNmtReUJnczJIYUFrdEMyZzFXV2lCaXF2ZmNxR0Flc1gwTnBr?=
 =?utf-8?B?aGNHbWlVcnpKK2YwcFVCeUZzQ2tSTnFnOVgycjBFTXlzWm1iWDFLNUg2aktv?=
 =?utf-8?B?dW1JSDdKQUdkM1dlVUZIUUQzSzlKVkxwNXo0aFgvWVU2Tm9jN0l6SldOeVFM?=
 =?utf-8?B?S2ROU2k4TEpFSTN0dDFpbnpSbDlzcFluMzNrelRjWFQ3YlJ6TVp3V2VTdFFN?=
 =?utf-8?B?WlBDSGlOcnI2WjJwMSt1T2hwZDBQYlJaMnN3dXpnUzZ6VnZIOFNoMmwrQVpq?=
 =?utf-8?B?UkxFR1pFcnd2ckg2SXp3UXZuL28yU0RJR0t6aEdVYmU4V3lQdDFqb3BjTmJo?=
 =?utf-8?B?VHVqbEZIS0k5TVR6OHBxbkx6aDcxaFhSVTNYQTYzNXRiQjRBcVBKbXR6bkNZ?=
 =?utf-8?B?cVBEekU1Z1YzM0g4ZU5BekxYWTEveDRPSjFKWGorVXhKVnhmbG8zcGV6RThn?=
 =?utf-8?B?VWphZ2lTRTkrbTBCRkE2QzI1dnlMcUwwRWttMkY2VFhHdTUzRFRTaXRDeFZt?=
 =?utf-8?B?M3h2NkNzUDY2bHJPUUpDMHdNc3lRZlNvamR6Y2ppbU04MTEyTmJDeXY2R2sr?=
 =?utf-8?B?V1NXblBNeUNTMk9QeDlkbEt3cktxRDRvVm8ydndRK3NxYncwbU52YkVTTFQ2?=
 =?utf-8?B?K0QwTEI5a2VSVmFOeWVHRmY5a1QvdkVFSGpNczNkcm14STVvYWpvSU1KTzFj?=
 =?utf-8?B?RWhSdXJQZXZJOUx1NmNiUmFUbEJkQm5BNGhJV2RyYXNMbm16MVYvYlR1STRw?=
 =?utf-8?B?eXgwUjZSN1NjUStCL01YNExGYXpvNWl5d1Vtc3lXREZSc3RxVHhhdGh5Nmxk?=
 =?utf-8?B?MDdJZm9JeTFtS2QzczU5Q0xTQXBRaUZHNFhlSWIzSHljSTJOSUV3amo0RVYw?=
 =?utf-8?B?QUZncGdwU1FUZW1RRERxRWtGNlphWUFkbU16U0xtbzhNVlErVWtnZXhRWWR0?=
 =?utf-8?B?K2JiL29ua0RtZlNlZlZOZWQ2RGg3elZMUnUvdk5lemVpTWNtQVRyOU5TRG9D?=
 =?utf-8?B?VmxBNmNHRUVsYnVEVjhBMmJabnVQK05UL0VxVjhyVTJWOG94YUNVamN4dHlK?=
 =?utf-8?B?dXI2eDNad1pKb1lzbExBeUQ1S1h5Z2FSNUdhbzBROUs2c1Z0d1ZvTUlhaHNP?=
 =?utf-8?B?S1RxcmZtUllIdngvWko2OWFMUHNoVjEwVWpLNFAvVGFGYXE0dms5OEhpY3Bm?=
 =?utf-8?B?OFdLUGx4ZjhLSSsyTnQ5NGJNYktIMTVVQytPU3p5VklIeloydlJmNlNlR1pX?=
 =?utf-8?B?d0R3RUVkTnJaM0hlV3FpMTdFaytmSmIraERBajVlQVlzN1pyNFh6WXZUL21z?=
 =?utf-8?B?VVA0Mi8rL0IvMVkwUFlQSnRYU0djNnFUNThFanhwS3JScU5hWERRYlVQbUZL?=
 =?utf-8?B?MDM5RytneHo3blU0Qjk1ZTRkdWRTa1ZFcXFPWDFvUnljcWtRRlh0cDlPaERU?=
 =?utf-8?B?K0xlUXFXVGpvMm95c2k2eFJvZ0U0YjNMMlZzY3pQUE5IN3ZseVJSOFFoSlFU?=
 =?utf-8?B?R0Y4OTVGOEN4SHAvOXhHbDE3TTI3c0lmaTNkWHp3cW11M2VOVUhFZnFzelMw?=
 =?utf-8?B?cmpSYTZXV3NUS21RSkFkcjJ2OGdnUGZTUnNZdngxNGNBS1c2QTJDWmVJSzVk?=
 =?utf-8?Q?uwuZSDy8uPlAByE9cj+H7joNK?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6ef77d-7c99-4fd1-7f1c-08dbbecb91c7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 20:02:53.7950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2CqD8KGRdkNj2e+gNwY5n0RsX04zWQ0VKaXUzukTcH6RWdJzVB3cbHlF9ugXNazOt6sPVDLSj2Wuj2Fs6imo2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7699
Received-SPF: pass client-ip=2a01:111:f400:7eaf::717;
 envelope-from=den@virtuozzo.com;
 helo=EUR03-AM7-obe.outbound.protection.outlook.com
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

On 9/7/23 23:53, Denis V. Lunev wrote:
> Unfortunately 271 IO test is broken if started in non-cached mode.
>
> Commits
>      commit a6b257a08e3d72219f03e461a52152672fec0612
>      Author: Nir Soffer <nirsof@gmail.com>
>      Date:   Tue Aug 13 21:21:03 2019 +0300
>      file-posix: Handle undetectable alignment
> and
>      commit 9c60a5d1978e6dcf85c0e01b50e6f7f54ca09104
>      Author: Kevin Wolf <kwolf@redhat.com>
>      Date:   Thu Jul 16 16:26:00 2020 +0200
>      block: Require aligned image size to avoid assertion failure
> have interesting side effect if used togather.
>
> If the image size is not multiple of 4k and that image falls under
> original constraints of Nil's patch, the image can not be opened
> due to the check in the bdrv_check_perm().
>
> The patch tries to satisfy the requirements of bdrv_check_perm()
> inside raw_probe_alignment(). This is at my opinion better that just
> disallowing to run that test in non-cached mode. The operation is legal
> by itself.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Nir Soffer <nirsof@gmail.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> CC: Alberto Garcia <berto@igalia.com>
> ---
>   block/file-posix.c | 17 +++++++++++++++--
>   1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/block/file-posix.c b/block/file-posix.c
> index b16e9c21a1..988cfdc76c 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -447,8 +447,21 @@ static void raw_probe_alignment(BlockDriverState *bs, int fd, Error **errp)
>           for (i = 0; i < ARRAY_SIZE(alignments); i++) {
>               align = alignments[i];
>               if (raw_is_io_aligned(fd, buf, align)) {
> -                /* Fallback to safe value. */
> -                bs->bl.request_alignment = (align != 1) ? align : max_align;
> +                if (align != 1) {
> +                    bs->bl.request_alignment = align;
> +                    break;
> +                }
> +                /*
> +                 * Fallback to safe value. max_align is perfect, but the size of the device must be multiple of
> +                 * the virtual length of the device. In the other case we will get a error in
> +                 * bdrv_node_refresh_perm().
> +                 */
> +                for (align = max_align; align > 1; align /= 2) {
> +                    if ((bs->total_sectors * BDRV_SECTOR_SIZE) % align == 0) {
> +                        break;
> +                    }
> +                }
> +                bs->bl.request_alignment = align;
>                   break;
>               }
>           }
ping v2

