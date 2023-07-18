Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBA4757973
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 12:46:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLiCI-0001zX-3v; Tue, 18 Jul 2023 06:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qLiCF-0001z8-Sk; Tue, 18 Jul 2023 06:44:48 -0400
Received: from mail-db3eur04on0703.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::703]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qLiCD-0001xm-Nb; Tue, 18 Jul 2023 06:44:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDIxmt2zc2JLbwFpVxlLDKBGfFAcKpC+I1Yvy499VkpgRIgBr5ECwM4q7UAEFFLSwmInJzbyrm9RRqbOSofZE50AU8QTERy0PVL5OzvCE+uiATT5gpPh5lbB/XrRRw67Sx9dC2HPLjM+PWym4bgpQS8zfhNhZV7X1uCcKYLUj0WKPd+dAlOaoYfocNVFL41rwPu6cDWjFt/EyhIaa+Iab4Z/HC47l7P4qDMcvX72lITD6DewiDraeT8UVtu4S6tFTGZ8PxESJkUIrzgiaCcz1VQqm1ZNs1SadbP5QsP2triJDDfDCTFvGoOH3497U1ZPzmr3C69Rnf9NJKt3QVdFlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSXLTvVmbIzvSoaKyzTiC/qbiA3f72fCep0/b9Olk+M=;
 b=G0kMafiX+50i/Ax9K2ZuuaaNB9umkIDTgBUZ3D2jWlx6oCFJcVRTreqa6rglu8WOhOkCXni1CCdY5/apJF/Jsg1mfdDrHSd7lW9ULIQcCDON81lu0bcmI0nZkeHW/NBIFtHBC6487uUhmrHCN7CqY6G2b+h9bsgtjADWtaCqSyWRWo874SzqPWvBEW/mFAuFbpclPGtjgje6mN1eXrB0IByvIVELIer43R3SLOWbCOFBITAEMtTDPfuY6uTUo4S+IxDfWTZ0NQqluQ7T13CRhYgWmhywsTOkXZvXUb5keUd2NHD0DN73RTLz8OqZIa1CA0ummGYAotuultuadcZhXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSXLTvVmbIzvSoaKyzTiC/qbiA3f72fCep0/b9Olk+M=;
 b=0HnadstLFof6Nc6e8046IzWyqfsQ/poknjQiIxX8npxiiWaOkLnt7fnbwEpfw1VKoW12HFmDA4kfpJrtvWUu9pBAh3WhS/LDQ9OU0151227/bQqwueCzyoorw9n/3IHvzLVV2B+3GFiqV5YzCHJ7T51oRI87psNSuGlqZ6gSrgq35KmOgV+nMTq4DpGzS9fhG+7EOuFzvfObmLhQztscazJ2v1XkZiDvWap9D5LrpGWgIVOEvYgOBnvB0HrX1eADmZwnZmrJ3xaWWmJe0N4/EOIMeclBoMrrxajLtdXh/MLeyvoXT+QOqVudavUb92QyZ/hZjUOFtGuDhzwRNw4nfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by PAWPR08MB9784.eurprd08.prod.outlook.com (2603:10a6:102:2ea::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 10:44:39 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::f4dc:6db6:8d7b:111f]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::f4dc:6db6:8d7b:111f%3]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 10:44:39 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v8 00/10]  parallels: Add duplication check, repair at open,
 fix bugs
Date: Tue, 18 Jul 2023 12:44:22 +0200
Message-Id: <20230718104432.1130469-1-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0202CA0001.eurprd02.prod.outlook.com
 (2603:10a6:803:14::14) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|PAWPR08MB9784:EE_
X-MS-Office365-Filtering-Correlation-Id: 69f11f3b-1e28-438e-03ed-08db877bfc91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hpwIUml8CdchfNFlIhmuNqK0s69d2+y7QFY4tc+F0KmIxIxfeegVUFGQeggPVdDf7GJuky4XjIMSnc8OtwmwuijoGaBuFVW8q+VdhndTsgydIFM44IWSjUgCsr/DbHvwwquHahwMVcTzD8JJzkYSD+JfMHiDxEEeCVYP9qohKQFSdWdMvIiGRy1pDWOj1jRqkiD0up6MjdFVLZVk6jDikiTg3Ft4BzgqvIMBZBzzzEIhsXpk7QjJWQO+dO3fdM3SjtTMzFCocPtivYgD0G4mNObGAQjhVQ808tB8NYHdOppRWtH9m07gQkGOshnRctNGJNn4Pok6qhqhJHmRst2olU5uy0Q+45hEyTb0ELvHVJDyS/Su9+zyiVFNEA3VRGD5fovvnGNJkl91lEV0kvnoAkaXAZdVlnWSi324zHPiplxJ+WsnSrLDybBtQ17KF3Ta3+wSek6hPtW89Wj1FEDPFgiY+Pq3jtwEwujTLFE2hE2k+ma6QnBm/iQ4i7YBgIOhg4htFz5UwmNB9BncWPo2iFUFA4ttb8+h5IMiR89IlnFirfWuireEOK5d4Iq87xC8PcmODsjpOKAZPw+ysCjdSvfEDlOQpKuAn0WGuJWdJsTLG/WgJu+pRyreElM9ZjeA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39850400004)(136003)(346002)(376002)(366004)(451199021)(478600001)(52116002)(6486002)(6666004)(1076003)(83380400001)(2616005)(36756003)(86362001)(2906002)(44832011)(186003)(26005)(6506007)(6512007)(38350700002)(38100700002)(66476007)(4326008)(66946007)(316002)(66556008)(6916009)(41300700001)(5660300002)(8676002)(8936002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D/g89AizITwJaFRgO0rxQ9AAa+Fk3jtihU/sYypcOeUxb/nlkGuF/pZj3VLp?=
 =?us-ascii?Q?2VCWH12tXRZ5h+DYrS129RFog79Pb2jeivVzRPQZBpoatzxRMMgmO3wEw4l/?=
 =?us-ascii?Q?Bp0x/Bfy7YXtEw0T4zHPqPSfHnHrCbNAOqTd9eSlwU2j86Y57I9PwIv7j0Uz?=
 =?us-ascii?Q?p+WMxgPU6FX19NeN4L5pQty2HhN5CFU70PqdO/fR43lMmkRWKZiZuLLMs5Hi?=
 =?us-ascii?Q?llNtgx1yEu2Hika6TA4QI8eoWkeQx/jI1fg0M20QQ1nKEPlb24mTYXfZXOVN?=
 =?us-ascii?Q?UGfc9lJySm2nA5/bMbh0GPV8ix3whM9Z4R+VCkUAIYPk3mDoc4pnu43QkSDl?=
 =?us-ascii?Q?duKjXwgzdvohxmuipbjc48JHfo4x7vVqoxRvgr8mpGQ/GDp5cj7th3U0g0qo?=
 =?us-ascii?Q?kbDMtQwywggCsKSb3I91QeknlyEGCbblZhBm9X1gNCMSTpk47ulPauYD3KBk?=
 =?us-ascii?Q?1igiL5FSH/zOCXzGyq8oLizFDtPcWEi5Zl2rpRLdAtKuFsarpjC7QBG0E5LR?=
 =?us-ascii?Q?fxh5eAhW/NRGs6ubO4jMZAuEr+ZWGphxnAka2tH3mSooT6hg6pV5pMrXq+06?=
 =?us-ascii?Q?cLLHIfVzGCjR0beef9hazFGX2JbJ5C9wa9ckCLvc6xC1ds1NDMz5jIQ+rT6f?=
 =?us-ascii?Q?PnP+MhDeNUVD09vl5dxYcOgBxTs21X8KE7LtYEgRdFtHIt+qLzJN1D2vgn21?=
 =?us-ascii?Q?7IXcD+y5KArj/LwHPn8gtH3EFWiKPyxWCEt2QoTioi8KK5jHuE0WhxIisjEu?=
 =?us-ascii?Q?vRwbKwVo7AjZG3+2m3Qhm4H6VuY7zQad7eW3E/PubhcF9pS78F3jnMoejE9Y?=
 =?us-ascii?Q?3EnVijokIbumRIah7HWRb4tD90sB0XsNyvF8ywybVft4swGixcxH8Wc4bEZx?=
 =?us-ascii?Q?PdNK8KruVHG1Zs/g5Jc+Upr4aHa96ZtsnV0y2L7lj7uGptzsMOsFn87rCBEx?=
 =?us-ascii?Q?zFNLBP29CGWSVIyYipgoMr+4TUeDNBLT+uWxzQ6+tAKFB9CVyNzngVTnpJrK?=
 =?us-ascii?Q?ENh3P21Chv5S6E6M7gkVEeCwabn732imqyLDqd1XnM/76hcNbqEccLXx0qiU?=
 =?us-ascii?Q?c/ZjI/1WF1xlHjzAEQo8j0hNdEehJhVXrb10A7rSWyWAjUdQh29qdiZ/NoxF?=
 =?us-ascii?Q?zX87+t+k7REJZ86PP4yKqTqC4jd+YKW8T9gzcMk9/iJukiqZc7WGLs09G9Wh?=
 =?us-ascii?Q?rjikAEiCUYarIvHUyiqj3zASwunZVpMzVnQYZzPlAeSypIVwLMwGmLjO3G+x?=
 =?us-ascii?Q?DaBlK0Lw/KtnKfxX34h5msPUNwSkA6f5Tl+Yjf8oNg/39b4niLIfaCYTtmN9?=
 =?us-ascii?Q?MujT1UH4z72IunCSCe63NZGoz0zs7FyP9bdVDUCgfFYKTrHgwngsSpVTPf3P?=
 =?us-ascii?Q?IUWLl+ncUVEBfDyg0LA1MRuKSJAKZH0e6DsyPtAXoHeXM4SgDxpmo9QZDAAr?=
 =?us-ascii?Q?CGifoCSi7Q6tEd2wmZdiuNsmO37w/f7zzbdy0TahLs0C0IVT/3SiSHVXQJ2/?=
 =?us-ascii?Q?qpvWyB7RrcYK5Wb/qgC0jX5MK3DK3hjVl2ybQufFzLDHny2CRGTg/l0+YiXh?=
 =?us-ascii?Q?OM36Rvb7Vc1c/NI82Wl8+62xJaP6XTASotzCiPotapxxHsddOo7qov8SWFt/?=
 =?us-ascii?Q?aCC1g7sxxrnV4tBbQtOwAW8=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f11f3b-1e28-438e-03ed-08db877bfc91
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 10:44:39.2410 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sywv+91anhhVY0lpiuu3o3p/FlKlhicG4lqR7C6sGfRGUuStI89OfQBqE4juE/SH/mpA+iO98naw/+akREUEcpZ/LrZNw0wKB7uUvvtqN7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9784
Received-SPF: pass client-ip=2a01:111:f400:fe0c::703;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
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

Fix incorrect data end calculation in parallels_open().

Check if data_end greater than the file size.

Add change_info argument to parallels_check_leak().

Add checking and repairing duplicate offsets in BAT

Image repairing in parallels_open().

v8:
1: New patch. Fixed comments formatting.
2: Fixed a comment line length.
6: Fixed a typo in a label.
9: Patch was splitted to two patches. This patch only adds data_off check.
   Function parallels_test_data_off() was changed to return the correct
   offset in any case.
10: Added data_off repairing to parallels_open(),


v7:
3: Renamed "change_info" argument to "explicit", move info printing under
   explicit condition.
4: Different patch. Add data_start field to BDRVParallelsState for future
   host_cluster_index() function.
5: Prevously was 4th. Used s->data_start instead of s->header->data_off.
   Add bitmap size increasing if file length is not cluster aligned. Revert
   a couple conditions for better readability. Changed sectors calculation
   for better code transparency. Replaced sector variable by host_sector and
   guest_sector. Renamed off to host_off. Moved out_repare_bat: below return
   to get jumps on error path only.
6: Prevously was 5th.
7: New patch. Replace bdrv_getlength() by bdrv_co_getlength() in
   parallels_check_outside_image() because it is used in coroutine context.
8: New patch. Add data_off check.

v6:
2: Different patch. Refused to split image leak handling. Instead there is a
   patch with a data_end check.
3: Different patch. There is a patch with change_info argument.
4: Removed changing fprintf by qemu_log from this patchset. Previously 3rd
   patch became 4th. Replaced qemu_memalign() by qemu_blockalign(). Got
   rid of iovecs, replaced bdrv_co_pwritev() by bdrv_co_pwrite(). Added
   assert(cluster_index < bitmap_size). Now BAT changes are reverted if
   there was an error in the cluster copying process. Simplified a sector
   calculation.
5: Moved header magic check to the appropriate place. Added a
   migrate_del_blocker() call and s->bat_dirty_bmap freeing on error.

v5:
3: Fixed a byteorder bug, fixed zero-length image handling and fixed uint32
   truncation.

v4:
2,5: Rebased.

v3:
2: Added (size >= res->image_end_offset) assert and changed the comment in
   parallels_get_leak_size(). Changed error printing and leaks fixing order.
3: Removed highest_offset() helper, instead image_end_offset field is used.
5: Moved highest_offset() code to parallels_open() - now it is used only in
   this function. Fixed data_end update condition. Fixed a leak of
   s->migration_blocker.

v2:
2: Moved outsude parallels_check_leak() 2 helpers:
   parallels_get_leak_size() and parallels_fix_leak().
   
3: Used highest_offset() helper in parallels_check_leak(). Fixed a typo.
   Added comments. Replaced g_malloc() call by qemu_memalign(). Replaced
   bdrv_pread() call by bdrv_co_pread(). Got rid of keeping bytes and
   sectors in the same variable. Added setting the bitmap of the used
   clusters for a new allocated cluster if it isn't out of the bitmap.
   Moved the leak fix to the end of all the checks. Removed a dependence
   on image format for the duplicate check.
   
4 (old): Merged this patch to the previous.
4 (former 5): Fixed formatting.
5 (former 6): Fixed comments. Added O_INACTIVE check in the condition.
              Replaced inuse detection by header_unclean checking.
              Replaced playing with corutines by bdrv_check() usage.

Alexander Ivanov (10):
  parallels: Fix comments formatting inside parallels driver
  parallels: Incorrect data end calculation in parallels_open()
  parallels: Check if data_end greater than the file size
  parallels: Add "explicit" argument to parallels_check_leak()
  parallels: Add data_start field to BDRVParallelsState
  parallels: Add checking and repairing duplicate offsets in BAT
  parallels: Image repairing in parallels_open()
  parallels: Use bdrv_co_getlength() in parallels_check_outside_image()
  parallels: Add data_off check
  parallels: Add data_off repairing to parallels_open()

 block/parallels.c | 346 +++++++++++++++++++++++++++++++++++++++-------
 block/parallels.h |   1 +
 2 files changed, 299 insertions(+), 48 deletions(-)

-- 
2.34.1


