Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A781D71265A
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 14:13:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2WJj-0007eL-IA; Fri, 26 May 2023 08:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1q2WJH-0006ys-Ln; Fri, 26 May 2023 08:12:47 -0400
Received: from mail-vi1eur05on2072a.outbound.protection.outlook.com
 ([2a01:111:f400:7d00::72a]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1q2WJB-0005xJ-DT; Fri, 26 May 2023 08:12:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEcyHQnNRv7wTBSbu0DakXH+2i5Z1lng+eRA+0ZB/vFKS2pApQKg1vi1WcPafsSxRi376OL19IJ/BXkE0EdztFjmgnZ3eahG+9Gve6ShvEIMXyAoY8EJwt/H4HPtousoL8YZfFGi4MJ1yqMgdtoiaJfvFhFgBxEdxjOi+0UrkLLSWXgOcz/oBQk5dJj7J5DI9mMgNchVOWOUqYokzJtQKhLpqPubYkOEkribpPIiUjyLKKO/NyqPDByIDcrVn4q25JnuEHdLKuD5wgINqtStrWPPy9IEGUMQuOQRDhFm8+DxiGkPMLt0d590X9czsnLAHZePw60t01y5EE+5wd762w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FyyP8FzlW/cG4IGhmyFMe2++Et8pnSPTZ3Q4Hk3PS8=;
 b=ia9B3q1n70BgQcVSzgZIpaI6r3WpIcNSbCsnvjW1tKaadfVN+o+ZnojM9TEUgCJY1xJMqkfl7u8g9Ec9d14jQ5N2QfYwONb6PHdhhswacXOA1yD27HrtyEaAoiiwTvHtOGxH32lcS1rOsTfqsgBvXj2S/RF1rfcjKOUfPD/OfsN1+gf/sfKzsOrvNbPzWuOkK2kcgwZWLWLM8Ckxmgl4WXg/UwL8FJLJuNfvHMnM15/wbiCVLnwpqhh/ITQdEFnMpXOnUxTjsPMsocdedyJCp+y2a0lyWdzRTaIQQyE72MgmWcSID6h64VOoHgCO1+9GBTlvgV5RMh+BubeP/i1Btg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FyyP8FzlW/cG4IGhmyFMe2++Et8pnSPTZ3Q4Hk3PS8=;
 b=No+6lz0BT/vhMzGIfzAEFJEEEiJV8pxSvB2+EnSHG8eGJdQxmjxqaMoMpmj5rANXxvgIVEJUkVhXgcgHd6ukasXFcMOmJFGs3y6pq7p7qXgiWd/ZArk5Wwfzeqar08oFK8xob2RimavtVNtZ08GSjLoQ0+nkxlxcWOB68hkEUCQ/u5k/iI1geEMtbZ9+FxJC0Ln7ZvUslKt+rIjMNTRBkUy1X0U58Ap4mLtsW+KokYX7hT/gsVCTZfYJpXMD2MVNcvXjkPZ46SMdAWARnds8BhqDjSFlGbNSc1zRLxj8ktsJw3fJbxbMCo3O40doP0NYohKYTfJ7kqUO0TF8SWFB3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by DU2PR08MB10262.eurprd08.prod.outlook.com (2603:10a6:10:46e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16; Fri, 26 May
 2023 12:12:24 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::b50f:b94:a801:adaa]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::b50f:b94:a801:adaa%6]) with mapi id 15.20.6433.018; Fri, 26 May 2023
 12:12:24 +0000
Message-ID: <e3c6074b-6cff-33fc-15d3-56cd3b204cd9@virtuozzo.com>
Date: Fri, 26 May 2023 14:12:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] qemu-img: rebase: stop when reaching EOF of old
 backing file
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, shmuel.eiderman@oracle.com
References: <20230525180213.902012-1-andrey.drobyshev@virtuozzo.com>
 <20230525180213.902012-2-andrey.drobyshev@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20230525180213.902012-2-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0090.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::31) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|DU2PR08MB10262:EE_
X-MS-Office365-Filtering-Correlation-Id: 32c74328-9760-4665-54f7-08db5de276d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yzssBOtN8pPnHciMHyjzZDclXvsm+CpMhqpIItGCgpih96Fir4D3r4CI6nkKuczPAsuo59GxPSlOxlGTj928OgjlzqPHWd6ysUVKv57TexnT61D+4N9i35wSkXokxfuhB3IwQ0BGjzK7GcNfldp1vpE6/sVl2oGwyCcIej5h+4Xzm8XRtmYhxy9eRb3FP/qA2XVQq4gw0CG1Y08Lt/zh+sDOCBK8DKqg0QgE+b1hNshMoO7pnXRJXWYw+dDqGgs6aK6DxKbl2txJDEbTD+A9y3Pzsf7t6QrF/qLxqkY5BY9h3++sERTdjzn8gLrKDSIPmqjuUkbr4RSHD2WtLVzyKpnrLqSmxOLpeA3CHxg3HubVs4qchvRCumt/4tHJYmm/WHwYECwRYiWUHkI/B9TZQFr8NO8ruQZDJOMCTq2YJt+iAhApnUIoxT2cHnHW+NT41Luj4ylVxZ9cJ/bWgo+gEm+b/Q0fwcWpatpmIDq51KRjvyGhiLmhu+u5kFhY1bFXac6gXK8h8UBqlZgcEgOiFrHvI0zc57idUxC5Gbg9Ne9t4acEGI6qaYLNHWy7ms9SBTNbJJhYgsHcA6GrBgLOU8Va1zSCb4vq4pO3FRkLi4C8qgyx6fJNX3kABf0qlt192ORcF3+MsI+7BX/2Pbft6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39850400004)(366004)(451199021)(6486002)(41300700001)(26005)(83380400001)(186003)(6512007)(6506007)(2906002)(53546011)(2616005)(31696002)(38100700002)(86362001)(8676002)(5660300002)(36756003)(8936002)(66946007)(66476007)(4326008)(66556008)(31686004)(478600001)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlhiV2xpVWFEdEFoaGNnVjhLaGIrWld5dUFtdG5uT2hFVDUzNG9uUUpwVGpV?=
 =?utf-8?B?cWlNNlRvaDA5R1daT3pLNCtLRldvcXkwSDNyeFFFSFFWb21rVXhUMkNkRVhC?=
 =?utf-8?B?ekVXam1xK3RIdHovNXI3ei9vbTZ6OXBTbENKY0Q2eEdnTUhLajdCL3phcENT?=
 =?utf-8?B?aXFpNTF0bXdmUE5heEY1V3liN1NXYUMrTVZ1OVQ4ZEVHZUhvVldlRmJGdVcw?=
 =?utf-8?B?V3dMVXN6U2xUOFNFTWZwTTZOQlFaNkNOR3I5UktQeEljL1Zqc0dlWWtVV0VF?=
 =?utf-8?B?R1UrYlFpWFRkNTVYaWIzZUxoRVdCTGp2c2k3N2o5WXp5cnU0cVpKSEF0ZVkz?=
 =?utf-8?B?SVZmenYwTk44Zk55V0ZFUUl4UUdablhCUkFtalA3Qm81Z21oTVNKZ3Yzbmwr?=
 =?utf-8?B?V3NkK2Z5dkN3Zi9HSlpMdGl5RVZuMVdHaE5FRGZpc3p2ZEZ0REFWR09GSVlM?=
 =?utf-8?B?dTJtM1FlY0dPTjA1L1k4TUh6SkVYYnNnRU9sTjR1em9xKzJQc0dzaHNpQ0tR?=
 =?utf-8?B?U3VhZ1FiSnNGeHIvU1hXNWxrZktTcGoxWHZOOEV3MGE2eE5OTlZaY2dkTXUv?=
 =?utf-8?B?cGVMTXVYNjVvc3poZ0ZPV3R1MUlJcGtoOU5ZZGg4TklNcHFQaFlIZ084UGFm?=
 =?utf-8?B?Q3czV3JmbHFabi9JbFFsTnlUUHdGN01XL0x5L0hnNWVEVk1QRUViRm9EWGFE?=
 =?utf-8?B?SGcySWdHa2dwUTBPL2M0Rnhub3U4L2I5clRRT2ZyZnZ6SE9BSG84RmlPeXVN?=
 =?utf-8?B?S3BHVHVuZHF6R1RaV21ZSnpVN0dWV1o0ekRCQmlTdkJ1dDk1eVczWEM5MGtk?=
 =?utf-8?B?WklVUlJjTmZyWGFPemoxamlmaW9CUDhuWVBJYVBDRlRrVktTcE56ZDZtVkJR?=
 =?utf-8?B?eFNvYlE1NEd0WjAvcnUxKzZHVjV5UWxUaEcxVVl2WEJmNW02c0RNSDRVS1h1?=
 =?utf-8?B?NDFhQUNEOXlxUW1KUTRYRVlJb0E3UlFVbktWTTNnQ3dvQVpmNXg3aURPQlhU?=
 =?utf-8?B?T2x1dHJjbmJMWGJyUncxTHNVSTdoOHFwaU84VHNaRDhyTEhUS3FRVVY4OTZE?=
 =?utf-8?B?cjFGSGkrZTE5Q3FOL3NtVHJRRjBBR0lXSFBDdkRZRDJBRUJEbDhOT2ZzdnlM?=
 =?utf-8?B?SWlLWXFLWXlDSnpsdG1nbWRlbzhiZmUvK2cwUS9uMG1hRkZaZytUbGdrNDFL?=
 =?utf-8?B?M0JsK2l1cDlMZW0zVVZwR1dvcmJuOUdlQ0YyanE4cmZHQmQwT3cwSEpZU0pp?=
 =?utf-8?B?U014Zy92a1ZldEduV1JvSWVYdFBWM2dTOTU5WVd4ZzRSQWI1akdTQWFUbjZi?=
 =?utf-8?B?aTVSb3U1N2RxWGI5a2lDVlNNdStKTnlrc2duT08rdTIvOVREVzBqeUEyckFr?=
 =?utf-8?B?cW5wMmViL3FQVko0MW55RGJEVU1SejVISkxpcFE1V09oZndsSk1RMUloakZk?=
 =?utf-8?B?YVBDaWtKVGR5Mk5lNmY0ZVJDLzN3ckRyWXA3YXlEVW8rMHM4aVpCaHBud01Y?=
 =?utf-8?B?Rk9oUmY4MTY1K3g3aWRkbm04aDdjSUthbHhMODVVb1JsQUR6YUxtNmFRYjl1?=
 =?utf-8?B?VkZTR28zV1RDb2tQK09VQzN3TE1maEFxZ2Rra2wxanFpNXRabFlObmRrMzJ4?=
 =?utf-8?B?QWVsZkRxMkpHM2l5czh1THpJcVVxQTFtai9uRlQ4S3RWd2tOSGxpSEN0T0dW?=
 =?utf-8?B?eDdPa29nT0dzMGFyUnh5ZkZ5SzZiVmFaSlhiSktwWnhNc1lncVBkRUdXSWl5?=
 =?utf-8?B?VWNFazN3WnJtaklvcm11djhYS2c1NWJablJTNXN2bStwTWV6aFVoUFpOb091?=
 =?utf-8?B?bzJyaTh5VjZWblFjNUlHdmpXTndTNXNLV1pZU0M3YmhpWURLTmwzNkhGdDNV?=
 =?utf-8?B?MEZtU3dNV3NvZkQrZm0wanpJSVJKUFhNdFlsblpZdzlmMm9ITjg2NVorUDJJ?=
 =?utf-8?B?QmJtdVBwazlBU3dBWTEva3ZMS21YZjVuWmR3amVvaWI2VTd2dE1sR0hmTVFv?=
 =?utf-8?B?S01QLzVnL1hBem9FNnYyYjc0c0hyNUxhb1ZzQXAyS2VacGtyMkRnNWFlZU9z?=
 =?utf-8?B?YktZZGxhUVFEVWJuT0UwT0JXc09yeGlyOUtRdk0xalQ4V2lHTjhUdGdmNzh2?=
 =?utf-8?Q?d2ce8kQ0ujCp+QdJa9XYNXsCs?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c74328-9760-4665-54f7-08db5de276d3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 12:12:24.3208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SPMJWsEITXLemFSa0+Jzw7MReK2Qg5PNvDPacrUDSZPaStXf67go3ui/Q1hSdSvvGP7W3bV7nHwY9Xl2c5vGBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10262
Received-SPF: pass client-ip=2a01:111:f400:7d00::72a;
 envelope-from=den@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 5/25/23 20:02, Andrey Drobyshev wrote:
> In case when we're rebasing within one backing chain, and when target image
> is larger than old backing file, bdrv_is_allocated_above() ends up setting
> *pnum = 0.  As a result, target offset isn't getting incremented, and we
> get stuck in an infinite for loop.  Let's detect this case and proceed
> further down the loop body, as the offsets beyond the old backing size need
> to be explicitly zeroed.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   qemu-img.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/qemu-img.c b/qemu-img.c
> index 27f48051b0..78433f3746 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -3801,6 +3801,8 @@ static int img_rebase(int argc, char **argv)
>               }
>   
>               if (prefix_chain_bs) {
> +                uint64_t bytes = n;
> +
>                   /*
>                    * If cluster wasn't changed since prefix_chain, we don't need
>                    * to take action
> @@ -3813,9 +3815,18 @@ static int img_rebase(int argc, char **argv)
>                                    strerror(-ret));
>                       goto out;
>                   }
> -                if (!ret) {
> +                if (!ret && n) {
>                       continue;
>                   }
> +                if (!n) {
> +                    /*
> +                     * If we've reached EOF of the old backing, it means that
> +                     * offsets beyond the old backing size were read as zeroes.
> +                     * Now we will need to explicitly zero the cluster in
> +                     * order to preserve that state after the rebase.
> +                     */
> +                    n = bytes;
> +                }
>               }
>   
>               /*
Revieved-by: Denis V. Lunev <den@openvz.org>

