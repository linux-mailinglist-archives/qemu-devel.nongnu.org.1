Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2BF7B4C8B
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 09:30:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnDNX-0003oy-3g; Mon, 02 Oct 2023 03:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qnDNL-0003oc-KL; Mon, 02 Oct 2023 03:29:56 -0400
Received: from mail-he1eur04on0721.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::721]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qnDNH-0002cf-AR; Mon, 02 Oct 2023 03:29:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPBsZmKJBhVjtblZXw8vV1As0FKDjI4Kh8kNvnzkpQChTYPsd+oRUL8MY/q0keVbZ0BOmf2ELLZA1RK6DgJxVq6MK1hoNfNgdWehYtekUWBj/srQLLN57zEN+X/6w1ZV4rozILIR5TxIh163pO+jbpmr368aae3nSATgh/AL8ufLUvuF9QztjGkWlZLnSwzktGZu1+9S4nPf5fOKRaL2WRnjJt4/9zpAXtqnYkc/nyW4LBr6FFcXKzWW3qdkZQ/fyXUZve8k+sbyU3fxFO5d5zxo0Ujjytb5f2sgueol7i9SIiWgCJ0hBTL4q06jWQ3foYmipEnfg8Ojk7uafEA84Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yRgtENQw3rsk3QVFZE4tFhI66vnYTIbYi5RT4fuILA=;
 b=hnBt/yPSuF1uNLAA5oyIYN48b6xRuzVSZrxIX5JG95xpMNm/R+tXfUyhOi4rpjjt5B07tZL9l/3xpX87lcml7X/HxpO3qiYbYBOwKCS7EHcsaSdj+i62thXHeXd8CLRm3tmXeP12VAZ+Vv4iNaERhZMfK17b3dxaxUeG7kC+D7FPuD0T+U536QmYOPXs5A7yApPKkT/JwIoXrkDsxy0KQb2ff5Fmo1FnsARBo3msHobbVXCwpZQtx0Bctg/cOrjI+s7dDIMhaVr1Gf3usEuxPBjC838nvz+MGkpZd/7euQu52ghU1FQMNIDywXeyJYvp1YN6iYyY2jfFdNc/IQzzRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yRgtENQw3rsk3QVFZE4tFhI66vnYTIbYi5RT4fuILA=;
 b=XlJXc+lseJNxumpYXrJBdoB2Xxke3QTzkLtKC9NSUwGQThjqfmD9BnQ34XD017KocI63kQJ2XPV0pf9k3+SWpcDeH5MFhmI5+90RmCIY1BUKXP2xrwBwvGX1FQp0G5jtp3pBF9djhjWm1WcDHFnwzpGWfNyJBfLpvryRYspGkt6SEDxWWoyjpoVA6l/llH0IFoEBWtZ7+YousFv9emL8O7PxWjYWieVSTZQKe5Zz7/aa4E6A5BNhmDkiRcLGOLKb7PF/Or0lMUYLpyCk/Xwlr6mWCQpESx1vGw2V2HUIKaFFamqEGMv+NdWIGM7haUuZf52DfK74/ySF0l+ntaheEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by DU0PR08MB8662.eurprd08.prod.outlook.com (2603:10a6:10:402::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Mon, 2 Oct
 2023 07:29:44 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::8ba1:5878:7574:628f]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::8ba1:5878:7574:628f%5]) with mapi id 15.20.6838.028; Mon, 2 Oct 2023
 07:29:44 +0000
Message-ID: <b2db853a-f9de-6ab7-5678-92e667c9e828@virtuozzo.com>
Date: Mon, 2 Oct 2023 09:29:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/1] block: improve alignment detection and fix 271 test
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Cc: Nir Soffer <nirsof@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Alberto Garcia <berto@igalia.com>
References: <20230907215326.367847-1-den@openvz.org>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20230907215326.367847-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::41) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|DU0PR08MB8662:EE_
X-MS-Office365-Filtering-Correlation-Id: 71279fc2-24fe-4a6d-a750-08dbc3195936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: brACLHqiOM9raTBP3y0gdzDA2q/nb/Nf76KwrxSRvqk64ZkREU/hjiP8J0BDFprrB6uHkqcqM17k68vXM7nLf/IjnR9aPoW0eJhZzB+5B9TpaF5MRszacGdPZfkBcLBDz7/Xuiu8raPWuJS7wDee6tm7KyZVihiY3IhCM9zim6AX31DmQJPKueLsApZP3zFrEMYIUqjUb8QwaotEi1s4uFLk/N1CsrhEPOemKYiG+nxEkzAwF9323r8nldIHNcdr0bs2uOnLTwALRHOTpWDeb1jN7Y38KcKtO7XDObBxHFPa/dlybeZA/f3Rz+KtP4eskjxNo6RK5YemBaxrUyZxsCHqvVWN/QnUa2YfJc2rvksh1qfIsch574ed+fQ8je3NJnsXVx7YkAGhyq2r55AVzzcFCxyQpWhIW0y2E/shxSeNsF7X8vN8pB41VTClTKUFG3FjbZT6Bbnnmy11xl5gK38Sv9empDOTW+aSyJGVrpHPQIKSrvAtprJP7KddLR/Qs+lQPQtxyIJMOS4xAMGFo9Z9weXLXhokyiVk6pznxjWZtbwsGZuqSJD6PII7c4/jQvyHI1fZLz6Ta1LQPMNDWY6rh+isq3wu2S64bzmD5H+yWhE5y7LDe/OcSsVksuRF5u57spAJ3GG8TGNJE0Fq9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39840400004)(346002)(376002)(366004)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6512007)(26005)(66899024)(2616005)(38100700002)(31696002)(86362001)(36756003)(83380400001)(54906003)(478600001)(66476007)(316002)(31686004)(8936002)(8676002)(4326008)(5660300002)(66556008)(66946007)(6486002)(6506007)(41300700001)(53546011)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1RtdjArd0Q1WjZMcmk2UU4yWnpxd29hSEhwL1pVYTJkdm1tVGtDWmhnQnhj?=
 =?utf-8?B?elg5UmM1a290WnIwMmJ1UWRxWUtMak40RGVSYWx6RDVuR0JqQjBrT29LV3Ji?=
 =?utf-8?B?a3luMUdxeVpwZFFIRHZwYWdXRzl2clA1blZvdEQyK0cwN1RnZHFmV3gxMzdV?=
 =?utf-8?B?SExEQTJYQWRxNzVDTlNhWEYzbVpKdWxGclhBZE80V3hDM2xRRVpLNzF3NWZL?=
 =?utf-8?B?UzN4M09scFVSeUg4QzBQMHBDalUxOGdQb2VWUlpySStRUjFVRU9tNWhtZmVI?=
 =?utf-8?B?aWd1dndVZlo5RkhNdDBiVG1QbzFycStuM2U1YWxUUEswcnp5T1lXNEYyMnJr?=
 =?utf-8?B?TzUxajIzWkV6d01WaU52dGh6Vy83aUQxTkFtTTYxVzJBT2lZbThJdEhXb2xV?=
 =?utf-8?B?Q3V1VGhLdkdPQUFjdDZTYXlOSnBjR29QUzRnQTJMcSs3YkVNTzdkL0tFQjhU?=
 =?utf-8?B?aTRXQVpiMm52Z2JMenRoM1U5UXBheVJRc3FaT0s0R1Z2N09YaWJoSVlsUm8r?=
 =?utf-8?B?MEZhZVZudG5tNDUxRk9TckNpbE5leTNrc3o5bkRwUlNuVFFCcDNOZXJ1UlRB?=
 =?utf-8?B?L1RqVlp6WDlJVDBEWTBOSUdUaXF4SHY4SDdTSFlleUlHUXR2ZnYvdnVndjZJ?=
 =?utf-8?B?VGl5V3BWYWhqNFlNZ1kwSEUraXRHdTlFa1lwSTJGSHc1SDZMV09ETFpRTWdM?=
 =?utf-8?B?MFVUQzZvUWZ0QzhsYnl4aDJ4NkxlK0VrU09oVTk3SjE3VmhQaS9FYTNkQTNM?=
 =?utf-8?B?dDdSZDJQc2UyZmZYYldNS3hSM01QWlVrL2k0UUV0TS9TVXpCdksvUy9ORDll?=
 =?utf-8?B?dktPOEZYemZOdnFmdlJ0VDk1d05JYmFVVVhkbDJQYmNOUTlreWFMcXJZbGdY?=
 =?utf-8?B?LzFEVDg0ZCtGM05wbGNmUzgzUit5TWE3YUwxWjNZdGZ4YVdSZktuYnJ4bTlZ?=
 =?utf-8?B?UngyekVjV1lYL1lrNWZYS1I0eWcra3Vqd3NNbVZYb09neGJyRS9OKzk1aWlG?=
 =?utf-8?B?SnQrdWlpZHdVVjNndjdFNG03Z2kzL2NIOHNwV2NpV2g2YUZkSE9pYUJiOERG?=
 =?utf-8?B?S3ZzUEI4NzlGbVoyb3J4RUlrQzZBTFBLV3BRa0gzUkdrVTFGN0t0NnlMbjhD?=
 =?utf-8?B?TGlqMng4VDNQTm1KaitXa1pTL2Z1VW1BSGpSYnBhcENIV01jRFlIVTRWdnlB?=
 =?utf-8?B?QjJsZlVjcjJ4azViOHpqTW5jV1A1b2ozaFRjMFZ1eWRDT3ZQUk4wcERFQklk?=
 =?utf-8?B?aFZ0b1pPYmxSN0hsejFSbnlHR3VwQlNRSXgyODU5UTd6Yk5ydURyejNWOHM5?=
 =?utf-8?B?aUQvaG5uTjZWSy9NWUVWay9JOGorbDJxbERBc1VnM1JwaUFmcG14MlE5cERU?=
 =?utf-8?B?NnpEdmNEL3U0YjlhTXNKWTd3aWltUldIUDNPRExFMDBSSktBRGJBNWcrb0lB?=
 =?utf-8?B?TkpaVFRUYStxMCtzRWFUTnFKN09sc0lHZ2lpbFVoQi9Zb25ZdW5SRGdCN3U5?=
 =?utf-8?B?REV6VkI4d0tQVEkrRFYxWG1HN3E3RWJ4QUZzNWFCc1JsVitXNHdXOVg3Nlo4?=
 =?utf-8?B?TkdRdXgvN1FlSnBtR3p2UkE5Q1h1VENLNUw1ZVNSTWhrNDhMZjFWVnFuWEpk?=
 =?utf-8?B?YXdwRURhUGd4Z3BjcW9XT0FzWW5NR1BTN1JrVlJ5Rld3V1ZtbjByRlVPd0JL?=
 =?utf-8?B?NC9DMGkzTzJ0UWJGZDhzUFVBZVo0c2ZoN1p1YlpyTmdObDM0RGRsUGthc0Nn?=
 =?utf-8?B?Q1FrcGNHS2s2YkVKam9FYXZtQkNaVDRaY3NWbDZKT2NuRnBqZCtxc1JScjVO?=
 =?utf-8?B?U0FsUy91ZEtTWE1SSVd3L0o3K3c2V2psWDkxWW5tQURVUlQraG1TRzF0L2ox?=
 =?utf-8?B?SGN6U1BQZ0lnbXhFendZdWRnWk42TDBTMGxRb25LZGtUNUpSZnZQWW94TTZL?=
 =?utf-8?B?L2Z2bFdUcVJERXpWZHA5c1VyRldwcGpVSUY2RVZyMUdLSHhpWnFUMDJ6cHAr?=
 =?utf-8?B?UVJ6MDFqQTI2VFdHSU1LclVpR2hiZWxpa3NyMldqOW1teGJLSmhvVUhrbHgz?=
 =?utf-8?B?YVRucUlwOFU0UHorbENkaTZwQVJnTzNqQ0ZaakFUTUVva2o2T3JCQk9BSGh2?=
 =?utf-8?Q?bZnpX+Fj3xFjYdgGrDSfiwBXB?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71279fc2-24fe-4a6d-a750-08dbc3195936
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 07:29:44.3578 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y8rLRAEMkRk16tFK1BRgKWYTPUdK+T+tcBXNMrg4rTIwyTrpAI1Hw6JSZ/UD3PmgbtcNptDl9B7apwpo7oCtTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8662
Received-SPF: pass client-ip=2a01:111:f400:fe0d::721;
 envelope-from=den@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.058,
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
ping v3

