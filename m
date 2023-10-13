Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3049E7C8299
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 11:55:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrEsA-0001Hv-Nv; Fri, 13 Oct 2023 05:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qrEs8-0001HZ-9v; Fri, 13 Oct 2023 05:54:20 -0400
Received: from mail-he1eur04on072a.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::72a]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qrEs4-0003sP-3Y; Fri, 13 Oct 2023 05:54:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+joKkVTUOAiYHjTzOSv99W8XLp8b8WQgWNwJvc7MG1Wmd4Fa9aR625UxWueivir9aRI9r/saRC71ql/DL6WskWyTyqwBl7m65ZI2NjVt4Q0GXtippiEl7h8914vUxbMqB2dxOv34yH4nEuwo/20ik1a8jAihYlltcMsnsmctr7ikB3+kGvOfFiBQno44PEmT4M4o4VynLkBJKjTDF/TgX0YJp1T27koEpzYHUPaHxKFFafbl5orqmpqbyEFzkv2A/FOOGjSdSbZFXJwV64bPmHwX+9Uo2vCdTSyOgMtV34LQ7oZRIbDA5y83/jKy4T/+SP9TddvLTz2hdRjH0h8AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/6hTGJ3sFnSL3x6aY2v89auXKS08HJRJPsZ0qXvLZI=;
 b=Un4EfH6P8FHGlxyHSklMAFXlHXJydy5H8zk41qM7FfDfEXKiW+rHEbaz35OBSibDDggcL1i/sG5c2F7EUkmglBd4BF97kbW389bj7uHji6/ri9yJR7W+LI8jSaoXMTaTw3w2iF0rg5xpIWMr2n1J6uH3KLGzOboFELcAFkRd8B5xsU6Ll25g3E29PV85BNnQKtX3AlXoReSTRHpEQu7KBiU+ucNicxL539jgJXhzTiavKPJs5WVXS5hxdN5y2FRf1LSM1PMD5t1a2nsiiKMQLkBdfVX9uMQ7RgWD41U7pn4orZ5jguM4UBgOr0CLwE8Fd5ZECtvlSbvgk96nLvatNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/6hTGJ3sFnSL3x6aY2v89auXKS08HJRJPsZ0qXvLZI=;
 b=rizT10KKJgIQ9PByhm3/wr0SCxStWMX4fdzi1eR9ud+VqAje5mutuvXiJ8SHjTQYJtMZ/n8bZhGfhgyvb8+bZ6OZlCEsgDD5O97kksyARoSPT6ZwmHEwtpvFp59Dic3ouo+f/c/27Vfgdt5YzvJb7zcSmmDmOUweVjz0e1HaEDC5eDgcA9WclPcRYyJFUKjrr8kX+8SWu1rZqe6GpceqxE9KmIbXHu0fGyJ3WMVC0fhFsLDJx69eIRN9yMk93drSUwoRBVzRW49+rrp9nJN0BRJXlz9Y05sgDyKJg7u2tgUZ8aYyjoqmV94KR/toud4Xa1tzfddKHDevLAzpJ0Ayag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by PAXPR08MB7575.eurprd08.prod.outlook.com (2603:10a6:102:23d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.41; Fri, 13 Oct
 2023 09:54:09 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::d1ec:5324:a321:be0e]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::d1ec:5324:a321:be0e%4]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 09:54:09 +0000
Message-ID: <a5845b75-941a-4a61-a295-900609635096@virtuozzo.com>
Date: Fri, 13 Oct 2023 11:54:05 +0200
User-Agent: Mozilla Thunderbird
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
X-ClientProxiedBy: VI1PR0902CA0039.eurprd09.prod.outlook.com
 (2603:10a6:802:1::28) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|PAXPR08MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: 5357c737-8d19-49fc-9317-08dbcbd25896
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 20bNhxWXo2PP3XcovoHsjzUuANuhCujjK0UpvlnKIhPPl88k8CjvgQULIsouZ1T2/odPomugSMg6M9bjIzv3McEsEfqi/ErlY4g38ZXnKnkto0nX33UIw8tfRdbI4JW7IMv0EAhshbYCb/9A6jcDZrACFzh4Bt1bCCVgF9FcGaxIjALz2RaDlW50QVOnvI6c1ZkPt+EjgpGLO5uyMlQqrGWrwmmLz3UeZcEAXxdUFEK3SdDWWxkyYm49VGvriVJ0BN7i0E+NUxDJumcwIDMlqLnz4fAPVvAdc2iWgXe4exVgCLUwmv+G51MlVsdn9lu2Td5Uy6Wnk8ck26cquQmHhqdbBSJSQrveTIpb7SyUOkBYIFI3QO+9pySR+bmAkfPhqsVnGrCCNUgy9tG97jy6zQKZGJVpOsdJZ+65lBbeZhwo/D5wRjD45KLXYPbprIxOK21u98C/VVEta+gdAJr0Y3fBReUI3PyxXFgzUpX0Hy3hA8zClo65neY4CnqCBy54ejau6X5523MByw5WzPo65uJw+NeQ52a6tjiqZWeb2gMzOI0uOuxEeWRzNvuFEzIJmseS46XorspFRHVfc7ILcZOq7CA6PvziFzpbPy6r2g6ciNtNILhdL1W5bSK4MShBdfP+pdPBDHO0cwNUFQxkrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(366004)(39850400004)(136003)(346002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(4326008)(26005)(8676002)(66899024)(83380400001)(2906002)(8936002)(38100700002)(86362001)(41300700001)(36756003)(31696002)(5660300002)(478600001)(53546011)(6506007)(6512007)(6666004)(6486002)(2616005)(31686004)(54906003)(66556008)(66476007)(66946007)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVQ1TDllVFYzNTlZZjNYblpjTUpENkRRaDIrbjhZcXo2Sng2T3EwN3kra2lH?=
 =?utf-8?B?Mk9YVzhOT2ROcFNNMmJrb2hpRTd0S2NoaEtyM1phUGpIekllSy9RNUx2ZkQ3?=
 =?utf-8?B?QnFJUVliLzJRTkQyZ29FV0V4Z3JBQkxNbzd0RktQV1cyK29vbzBQaEt6cEI3?=
 =?utf-8?B?dXJwTFRTSzJiUHVtMEFYMGhkakxaL2l4UUVJV0o5UERDb0JzdzFqT0VOQUxp?=
 =?utf-8?B?cFMzQW5zUkRaMlV5L0RvUk9laUtocGp4MVEzWURGT0szWGtKWGlQVGNWdjRL?=
 =?utf-8?B?QUtweElXZDVqRHlqSjRESGI2VFYza1NPYkJUU3JVSE0wazJmVFp0MXh6Ti8z?=
 =?utf-8?B?Smphbk1IdWt4NjI1ZHRneFloL2orQjlhMngrS0UvTGY0VVF5OGxOckt0Mk5S?=
 =?utf-8?B?R0FhSmlyWGRxdTgvVytYZ3RtWHFjWlZaQ0hBU0U0R1M4TC9iZzJWelRnUUQr?=
 =?utf-8?B?SVN5cnVCYTlOOFY3eEdCMTFGZVFkUFFxazJQaVhCYXQ0ellRNHJWMGJ0SlNV?=
 =?utf-8?B?bHd1SnZwQzF4S3BKV0lzRTNPSWk1UmtoY0x4ZURTbmEvbFdvQ2doV2QzYUpn?=
 =?utf-8?B?aWQ1UkRYbm0yTXVDVkgxZmRrd0ZqVkFQTUdnVlFXLzJSWTl6NnpkVmdlcUJa?=
 =?utf-8?B?TnhRUWtLT3kxcUpiTXN1aTJKdUxqd3RjQzJkdVp4VEhrVDFTL2VIZmowVitw?=
 =?utf-8?B?QlA2eUlNYjV6U2F4NXdDRHhucVpaZlEydHdXeFprR3hMejREUjRna3dsY0xX?=
 =?utf-8?B?TXR1S2wzMDRRdVd2NE90YVRhUFNtd2Z4YktCNHN4YTFrM3dJaEZlVE96ek04?=
 =?utf-8?B?Mmo5M2VOSHovczBHT0pid1o3U1JTdUlXOWdDeGhjZ2wrbzFuTWVqbzJBUnFh?=
 =?utf-8?B?WDZ4QnYwVU1GYTk1cHpmL2tha3AySFNQRlVrdW9yS1RmVTM3L1hVZWlha1hU?=
 =?utf-8?B?MVFlb0ZQMGpaT1RZTW5FdFdBZjlTSStvVldGakJ2bEVqQkxoeWJ0Qm1LbnZS?=
 =?utf-8?B?eXJSWTBheTR1amY1ZmVobUZBU2l3MktGbzNyTllBcXBudGpScTVFTGg0eVh4?=
 =?utf-8?B?M3NDOHNpOXpMek03alZGMkFSTmt2SmxxNlovbEIrS3B3UUd1SW1RT3BqUEdi?=
 =?utf-8?B?emE5SE9BcUM3dHV3cWgrelZiUncrMnVTOVJEblFuQzNQTlEvRkJFcDVQbEJw?=
 =?utf-8?B?NzZPM3oyOEtFWGxlVEw1Vk9hckJqMzRjQ3F5NUg0NDBENVpNVEdMdXFGSHk3?=
 =?utf-8?B?NEJ0aVh6VytYUk82M1Nib3VtU0wraGplSHRvUytRYkxGbW9heGxZY242TzR2?=
 =?utf-8?B?bVhPK1g0dWZLMlk2YmJjeGRFeUN6YTFyZzlucmRDMVcxV0hscHVpQXFDa2pS?=
 =?utf-8?B?b3A3dU9GOVE1amlKdDFqb2t3R2EzLzZ6dnNyQjdQdEpEczRWREV0MDBrc0ty?=
 =?utf-8?B?NG9BMy8yQ3VybXdTbUJCMTFIOUdzZytzWkJiWW84SS9iYnpPVXBMOFQzRUl6?=
 =?utf-8?B?anhzRm5SV3JiZFV4TFJSS3I3U3VheTZ3bnV4RndDdGpRQUtOOGJZRnI3S3g5?=
 =?utf-8?B?cU9XTmIzVFNvKzMwQlA2MCt2MGp4UmIvSkFmQlFLT2NaK2dOQ2Fmbm92UzdO?=
 =?utf-8?B?ajIvVmwvSS85TjVpQ3hWbFF6QmlZT0tNazF1RklrOFlHd3Z6c3ZtUktUOFpq?=
 =?utf-8?B?cGVZUGpCaDVXWEt1alFWUEhGdElkc1FtR1dkOHpSM050OCtlTzhKbXdKYnNa?=
 =?utf-8?B?L1VLTWFndTkzcUFFV3ZZakJvVVFnaU1HVVVnTFY0TFQzaXlLM0p4aDlUeW55?=
 =?utf-8?B?WnFWMGdkMmtjZzZEUXkvcmd4YktmWEFPb0JNMG1NeDJtaW9qcWo3cTJVd2F6?=
 =?utf-8?B?b2sxK29yMW5rdDlrVy95b051UEUrTHlzMFIzdjViU1BPYXFiZ1RSeDJHcjZH?=
 =?utf-8?B?N21KeDBLdGRtbFZHZzRRdVQwcVJNUjdYSTZZeFZ5RUxWWWxCNENPak9wcXZE?=
 =?utf-8?B?V3BjM3ZJTWxqSFpiUXFuS0VCM3M4R1pIM0I4NU84VGdTaXZHdmZwWkdDS2hv?=
 =?utf-8?B?YjFta092S1pjTXMrVVJndFh2M1hHdkZUNVRVcFlKczZWUGtCWlU5VStzRldB?=
 =?utf-8?Q?zVkick/gRJ8fDzo6QABcHbAsK?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5357c737-8d19-49fc-9317-08dbcbd25896
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 09:54:09.4206 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YvajCUd0ggnp6EJGkQXx0ioPpdFcTtBuIvo5YivW4v/pwFSXip22wZJb7hnqOE9ikF5Q4s2G/amA5pGCBed6ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7575
Received-SPF: pass client-ip=2a01:111:f400:fe0d::72a;
 envelope-from=den@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
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
ping

