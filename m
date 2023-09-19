Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CB37A61BF
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 13:54:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiZIQ-0006mo-Jy; Tue, 19 Sep 2023 07:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qiZIO-0006m0-Dc; Tue, 19 Sep 2023 07:53:36 -0400
Received: from mail-vi1eur05on20711.outbound.protection.outlook.com
 ([2a01:111:f400:7d00::711]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qiZIL-0006l1-Ce; Tue, 19 Sep 2023 07:53:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVLH13f0O4zBIq8TwaXH8TursAUt80zZaPphqM+48gebIS5SfPQp50JyYwG+5RBXRKLwfSNkZsgH241drTM8Zjvr2LmMeLxeqqAaywBn4gso8iu5Xb5hOtTInpRBBQxD9Cuo5ZPmu6IUWLCgokc2+D8bmARFLxEjVWwON7lZQejZC5GJKaEWJRko4+4YL0gie9aZwTfq//YhaC6zRlEft7KMhIXg5lrnP78kW72+CHkD66dJH5aSXuRlHVlihhGMJvaYi1StfD/pSsk+kyu7l3hHVkpeLy8z297MUWBZH9JcGU8lU+bOxMp7rFMwg8/R/4RoP5yb6hPW/IlJpwRh/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/6hTGJ3sFnSL3x6aY2v89auXKS08HJRJPsZ0qXvLZI=;
 b=UKQnWhTLsGsmeWyHvjshQEjO2fWlPN/x4UW/R5tl6Tgp3037tiJnrRNI3YTV+l9WiQXZXNDJ2aMMUdWBlk6bldm6U//0DCRxDACOQgZ/ddF1zC3IoNlx5PL4E5lO5x3PJKQydp4gsEm3AWp22JBIumjtEvSpwoL8zp3g5Hgnf7JNlxgfPxeab+cHNgOGtFujvJrxN5ANkX46HBoTv4Iso0C90ucoXwTv47jRnONpKu4O2DpjyWmtN4cTqwfjWOR5jqmzECaOGD57pemSXDlmbvzIcWnl6+pV6tqM4+lZGimJ2iovjjjiFepbdHfof0juqcJVqQMdviq2HOk9vM88vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/6hTGJ3sFnSL3x6aY2v89auXKS08HJRJPsZ0qXvLZI=;
 b=x2a2D0NuBg/Ro1yI9eczkBnCI88ww1UtWn7+qqeVHYwq/qjv/G6R6K9y85idoomtAXqw3GAdY1rHAHnGKqocD54wEoAo2QjJeN5g3TTonFM7potbR+x8MerG2mHov+gxIq5TvJVvkx2oPXmZIwbERIqYLA2os7WbWH1CDKV9UyhGVmfrOlEQefVv9fRakjvRuEfkdl97p6dEBrorrlnaGnGLHHuv1p6q4usa80qKFB3kBgoH4AucriN1IJOEZ2BjJrxT6JMoYErfjfG87PPXix3H5zuBApBXr2o9W0gd7H0v/vBG/i8XZmidm96Dk4R11eZkC9pLwiR+ehx92xFomw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AS8PR08MB6568.eurprd08.prod.outlook.com (2603:10a6:20b:338::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 19 Sep
 2023 11:53:28 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::8ba1:5878:7574:628f]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::8ba1:5878:7574:628f%4]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 11:53:28 +0000
Message-ID: <50eeb71d-b6a1-eb7b-db5c-98a2aff8df08@virtuozzo.com>
Date: Tue, 19 Sep 2023 13:53:26 +0200
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
X-ClientProxiedBy: VI1PR04CA0115.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::13) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|AS8PR08MB6568:EE_
X-MS-Office365-Filtering-Correlation-Id: f629f338-0d5f-4401-573a-08dbb90709ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U8f9+z0/GZ8ruqyFEeAIeI3iDxXcJKC4CVwNd0gpKmkCF7TR6B3Gc0/eRFJ/vN8/D7g1bE+n/RPXFvykbMwPBaPTzWw0g96TrJPpShNGjuaIwLVF8TQuChARWaVwLPk6uYVMk42THfI5NbfvbImjPIiVEJREWy0da74OqNxV7twKGgy7uLVcHKLDg5ozxYh7dweDF+tKjYnD3RDEaM6tUoo6ZLN0rCH548vSkP88fAG5BdFuU8sDAD+r7cYIfB9At9YzSsMKB+GzkFB1vippLpf0PlGrTsTb+2xufSlA3AzpE4PWsawRhKJ5rYMXSI3DcnfKzd95W+P2UrpIYkIbwDGF23FJerjxpn1GQUgCPQZNXATYDRz+0nLygJMw9mZZr6HfGae18oHaM6CHIC5IvDRGf6bHTt4gy56sxXW+m31I6VmGXYyTofucmZLywiyjtrWjTrxx0jySCstwn2sNVrQ2Ig373gsut48x6uSw+TRCltqSqZle642GET8LVgct0bgvayZUNOzJInsbf/D+v1LNAfmz/s/lUZmsZ4psZZgwtWE3t4eDKjHcM0Tac951p+qIIl0m3ua9ViXKjhRd8AIMKhLmgRfJRR9E3FKzHjpXWlqS4WhLvVcH4XgnXssi7fXWAC7p3TyQJHkcFDVzKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39850400004)(346002)(376002)(136003)(396003)(1800799009)(186009)(451199024)(2906002)(66899024)(5660300002)(83380400001)(6512007)(26005)(2616005)(41300700001)(316002)(66476007)(54906003)(8936002)(8676002)(66556008)(4326008)(66946007)(6486002)(53546011)(478600001)(6506007)(86362001)(31696002)(38100700002)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEU5amdaMm9IcjVJZTZGVTZzdHlnWkNOeUxKbzFTUmtvWExNdm8xbkV2Q3pw?=
 =?utf-8?B?bXVoczYreWkxRityRHRRdTlqVnJXQytKM0REREpkUFZ5b2grUW9qMEhjWkVs?=
 =?utf-8?B?Z2hKZ2JLL3E5QmZNS21NZnNiNmRVb2NYSW9IaE8vZUdlT01iV1Z1b2c5UXlO?=
 =?utf-8?B?VDlUV25tL0krQVFoTFk5TDBzdUltSG96NVpaVm5sV2gvMDErWDN6bldWQ0Uz?=
 =?utf-8?B?MXR5UE5xVUVOUjZYb0NEYmgwVDVjUFpoUm9xUnFQOFV1bkN6WWF1SStJVDRZ?=
 =?utf-8?B?TGJhMndHVW9ydlkrZVBJRklKUlkxQUxldlAxOVZWYUN2UytyL3FMMEhRd1ZK?=
 =?utf-8?B?TXVYZGJQR2hreU1uYUlkbWRKNWR1djFteUt1eEwyRFY0V0FCM3NsZG8waWVD?=
 =?utf-8?B?QzBDZmFnejRBL1czVmlpa1J0UnNoMlYwWDlJK09oYmh3cGh1R3dZZ2pXWFBx?=
 =?utf-8?B?OGVCZGczVjBKeG1TNmJBNkV5eXJVVFdrMFNCV2hlOHVtY3RQTjRFZU9NZ3Qx?=
 =?utf-8?B?VzlSWmppSXBzN0VheWtaWFpqc1lnbmo3U1ZRWjJWWEZBQ2hkMTZRdDU2dHdM?=
 =?utf-8?B?cEttVUpTaEVSckw5YUdseDFneEhWbmxPblNVcmVoRERMVVVJbWs1ZGNnQVNi?=
 =?utf-8?B?a2Q3TEJoWHRBSHpwamFaV3AxL29SaHBMTFNUbjJ3TUNGNUtCTS9vL0xTYmQ4?=
 =?utf-8?B?cU54bmhscy80Tkp0Z1B4ZHp3T1drTElLT0xQZEl2aklwaU1DaGtvMDNkSjlo?=
 =?utf-8?B?SnFmN3NkaEMreitaNks1SDlHYUl3bHZjZFVHUnBxb0RFSElzNmxHTlVqVnZI?=
 =?utf-8?B?c2txMjdIWE95QjRUWFd1OGNmSXEzTE1jZEkxQjgvRFVObGl5RDM0R2NzVTF4?=
 =?utf-8?B?cmQ2dXJZUHl6MlVlTTVMV2JVdlJGOEU2WlNlNE8rNlBqamdoTFFORURIdkpN?=
 =?utf-8?B?VWtPV3lheEtneXF0SHhybFRNdWk5ZEYrZDl3elZuVndoVHVFUE80cWpGa2xi?=
 =?utf-8?B?TWJFTExwSHoxSkx1eXZkYW9aZGdZNUQyVFdFSUZzMUtEMXdITFNzd0pjbXJ2?=
 =?utf-8?B?dVdDZ291cTZ2VUR6eS9vZGd4dXM4eXFOS2pJVFlJWjRKbkZYcVUvSzJhY2Iy?=
 =?utf-8?B?SE1WZnR0UVNjU05VOVBtQi9wYVNOc1orRlMzT3U0VUNwTzVGM1VVQmVEbmxn?=
 =?utf-8?B?cDJ3YUpNeTc1NlgrSDRNTzBGTHB5NmMxUTdhUW5scEY2YWFRekZ4bGNneFJX?=
 =?utf-8?B?R3JRRnVRZlNyTWZ0d2YrSGJGM05iMWlvQno5ZEQ1VFNTNXh0bUJsQ1hEc2dq?=
 =?utf-8?B?YUM2V0taNkF6Y0RreW5EN054UUcvZERqM0UvRzVRYW9GQmVJMVNRdWdGa2RK?=
 =?utf-8?B?TDB6REE1cTdOSkM4R2NlaEJwakVBZys5K2JFWkJSZ0dpcVNkMTUwNmJrcE9N?=
 =?utf-8?B?QnpGU3phN05YQ0d0SHl5QmVaRGVMMGVNTUJqUS92SFVSUERKMkgzN3lBVVZx?=
 =?utf-8?B?bVlMbE1oVStpL0hmcE1XYUlTRXNUTWhZeFdjSUVjVStUcmgwVFBkS3d1VGh2?=
 =?utf-8?B?OEZEZnNIRDVkRDNwOTM0dHNva0xlM0twV2xsMkNxdGlZK0Zha3BpQndsdXNK?=
 =?utf-8?B?MWk3TkttWHZzeUN4TVlKRmZ1QmF0dFZuVjBGWWgxK0FpUC9Qekt1YzJGUVFM?=
 =?utf-8?B?WUFVcWFtWUJYSFJrc296dlZaTml4NWN2WW54SiswSVFIMkkweWJ2NENnUjky?=
 =?utf-8?B?NXpLck12OXlvem9DWnR4clM4STN4SzBRbURmcGNPYVVpN1dpeUZZZ0d3R3RB?=
 =?utf-8?B?N0NITWhuUEtkME1qcGJwTEczaTlhM2E1Z2JuQW5LQTg2eTdid2RIc2RNOGhm?=
 =?utf-8?B?UEhRU3AxanRpOWtNbC9majJiQzBXZFY2Y0VhKzZsbTVGRTZ0UkpEM1dDUEFH?=
 =?utf-8?B?Q2g0VFF0WTdZTzRoZXpSaGlJcjd5Z0lxUEZWSjdnRnBzMCtiWG1rdmlYcCt6?=
 =?utf-8?B?SWNTbXNWQ0RqZjgwOE5VU1daalI3SFdTRWN5QzVxdjk1c09nemI3S1JZdG0w?=
 =?utf-8?B?QjRWcGxncTFYWFR5cll3NjBIMnp4QkRZRzB3QzRXdGJiRElVWk1JNlYyZ1R5?=
 =?utf-8?Q?H2Tv2KpbGakjgRXmuNol6xb4x?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f629f338-0d5f-4401-573a-08dbb90709ce
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 11:53:28.7522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pbdrPEZhsL/ttsE1ETBvA+4xgix0gSYWKqy9UWA/rVeDMgvQVjh4dLiJxHacqB/0m7TAAiX0i6RjyuonbUd8zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6568
Received-SPF: pass client-ip=2a01:111:f400:7d00::711;
 envelope-from=den@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

