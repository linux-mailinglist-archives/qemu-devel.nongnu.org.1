Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7FC737D39
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 10:21:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBt4s-0000GL-45; Wed, 21 Jun 2023 04:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qBt4m-0000EZ-UT; Wed, 21 Jun 2023 04:20:28 -0400
Received: from mail-he1eur04on0711.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::711]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qBt4l-0007BN-2n; Wed, 21 Jun 2023 04:20:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvgNJhvbHwLlGZZ0sPS9W9ZlsEAMU/bl8D58Xh5VlqdCsjVU+plKoYhTc0Au5cXVrTmMLZSySgIJleaEiLWnvQKtUPsUszLUXPNLQoRP9pdaZzPge9+OCbzQwtT/vaIQsrphO/7nxY238TGGUOChpSsqaZVxanEK/oxN69FzMS/r6KQYF5aCG4xpead0vDuqMUaTJ0TBVVG5DLHADJLkIBEiW+HI3ZY8tOARTpotssmj/DvyujwJkNESLMHQ23DHtAly5+otkrLgkt3Nu3HA1qFm+eBEcjNY+966aEQAx/d4DKAm6vS9TVOztfZ0GZue4PAjGVhv1sYUFJ0IPv+a4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ec10C5ppGcYzZ263JAZvYnOlJa6tNwCCzTJY1c5Iww=;
 b=ZCpUgUtOmXQvGIOxhrYwzU5EDZ/eP6WWpB4ejtefaEXvxo7i7DXSsa+LfZ8NIQxXp9yBVOtGsPQbvtf3FpK1G7ET/6dLsUvbLScbZS7qWQSU+XGO1fNN48tCs1wdZhJ5K+G4b5F7Gmr+n6MIh1CDyURkdNqi+TEEaRFYarh2FRkNuv21R06hTjX79rgzZ/YMvM74jzO3bcm5u7CpsAqjiQZaWvSgimgA8eKAhByDqybLLq94y1ASLo8jtcd6/GCR1rDeaVKHW1HP+XxB95vFvHLFn4b5BzsHhkAY+RMyNeiKaS0gZ+fCi5t1E57kwnEa2QCt4GBByV6WRssCAWTvug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ec10C5ppGcYzZ263JAZvYnOlJa6tNwCCzTJY1c5Iww=;
 b=aWxye8rINJ2gHHrwn85shFyxwVEJBX+MG2QLmbt+Hh/O9Ma8UPVqycj6F9uQrR0QCTZWm5eivdkqkNTDNaZLN4aRT0aRSBGeeHf87/BNCBeOUKsbI5Ww7cdF+BDOOU0t11xtmDE/1ej4oZ4stbLe5oRoUfb6B1Zddp+Oh+LqE83hfWK8Z9AEOEX4S1VGlZ54CqxSIgUwvBBLzYGagPaTna9dLzj3tkuzcmjdJaJuI9QH3UOmoOyux9Am40C1xH3pNfi9o2fdd2yAjK21IXYPzWt1JLgnovRW4ZW7IuDo9DDkIvk3+doEGlr+7cFbmjbQfGPJpCe+9loJcgy3EuSWNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by DU0PR08MB8422.eurprd08.prod.outlook.com (2603:10a6:10:406::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 08:20:18 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243%7]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 08:20:18 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v6 0/5] parallels: Add duplication check, repair at open,
 fix bugs
Date: Wed, 21 Jun 2023 10:20:05 +0200
Message-Id: <20230621082010.139195-1-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0165.eurprd08.prod.outlook.com
 (2603:10a6:800:d1::19) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|DU0PR08MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: 643d998f-38c1-4ec1-fe0d-08db72305925
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3W+yptqL3qTZGvQdQO7VFr+W4QxNRQhY5hrXMFx+E7ALW65EPTKUKVNe8YDi5bFaMGqqV3I7DBB3EKXiCjnUxCBjc8/SKUuwes/94HQTiEHWQFcmc0v1GMV3/ep5e3AwQZoFRWGRh1vHm97HcrYTQTUQQeiL3Yd6QkznRKRPsLHUabcyHOU9nmVk9m61hiEZdFWVD9xJ2K+IKaOy3+CffdW8UOZ6Vqn2SLKYDB4V+Z6UZ0ewSeQD7W6aIvtKVxW84ojU80v+sNZ1poZ8Hx7NsTKKMAho89/Bm5aPfVy2EhLDPwGDsTzB3pm2KJ37T5c90NpEMWmGIfdETTetdltElxj/MXka890lNY3oAeB/ZQyKQ/7VlcW0CtMO3CKUsnlaIFbI+KMpqq5eA3svsQ3JxG04DwbjO03dDIYdultwswB28N+sszoDQGfpVHsKX+gENxjkEhxOyPzU2UKp+rdcRkXuWraWuc5/nu8u+TD2n+YU9O2D299JSLeLfGnBUvHp9myFpJ7U7/EikynhffCzPJTAlY7TDW+N8dZV6q8ogQztKkJPgMt7R5RXjjV+MxT/s6ucnJ62bk8vzKo/x16XxFraU7hYeldqQtF1sezIek90Ko97zP+ud/4emHrnfXKm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39850400004)(396003)(366004)(136003)(451199021)(66946007)(44832011)(5660300002)(86362001)(2616005)(8936002)(8676002)(1076003)(26005)(6666004)(186003)(6486002)(36756003)(6512007)(6506007)(52116002)(2906002)(478600001)(83380400001)(38350700002)(4326008)(66556008)(316002)(6916009)(66476007)(38100700002)(41300700001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pQA1LhzJkGF9LpqoCDkZK5XupHVIANya5PR86sGC+XGnJ/Wi3oxAfkugfm9O?=
 =?us-ascii?Q?xCUYRGx2bnD3pQB1Jy9+lMIWi3tIitRyKtYBA3G2Da7tZafC5HC6b9nLkdaY?=
 =?us-ascii?Q?6ZPODEyhxCDmmLOzCZtLDN1/XryxkonS2Uo1tBBte//EmawOS///9gmwOrzY?=
 =?us-ascii?Q?lMT+k8h/u130K4akX+DGiWNk16w8qe/uEp2VnI5UYWCcExxQKja0/uI4VjsW?=
 =?us-ascii?Q?gflGKGwx+Y/BDUUKlJp9cUb1ytO3hwXNfHYGTb4XODVScaBGOZei8IN8yqkV?=
 =?us-ascii?Q?feeseWrlA++1OQi574kuaagIaC6iqLhN6dZIA1s0GtKt2C0EgjRl7tq4f0aF?=
 =?us-ascii?Q?1BLOjVEj/SMIHRQmz17ObU2JVUauwIoJziodHJfqaVqWmq3tbS/EH3M2M4Ib?=
 =?us-ascii?Q?wFInnXURKaps7Za1/Ur4doknbsq5hF+jbr6gJ0U3r4T+om3bV5cPoPdHEa9j?=
 =?us-ascii?Q?2+kwPFdYD6Abr4jUhjQ1boeEleRXFGjxELIxr/hRYjtBo14bX9ZOfwZqI5s/?=
 =?us-ascii?Q?LGnQ26R9L+gVQ7uzgBGVs+zqML4DCh4u0YGaGyWVOG0MCC9bMKml4qCo5mZ8?=
 =?us-ascii?Q?BJcPEHXJ3jqEgRYGlCNXrEAIvpF+H9oh3jn6NEsDsEGHb2gk4/+t7taqDmFZ?=
 =?us-ascii?Q?Tw5ybRTMN73mlluCpZHj6cgCWAONzSPlKVByRB11ZTaIbR1YUJgn6Jhjw6x4?=
 =?us-ascii?Q?WmUiUzqRAEZZfL7V2xRwvvA/tBF0VOxVZrxDUsxVDEYIsigR0Tph+g2QNVv4?=
 =?us-ascii?Q?rPLb8TCKiYgUY4wWB08zkcVdZIMBKEyDMqBE+gR2zgUc5DzHkbFvQgr/o0Tj?=
 =?us-ascii?Q?XTtn/JMpa8TDLAeoYsHuK2ul1zDj27eLOsl0TnljBEd2PTg46SXEyBiaQ3Ne?=
 =?us-ascii?Q?YO25qTNgyLy5TgAWs3HPkrj1DvEqY8dCOZC8bgg8Ky34x9FdkVisiJEaK95K?=
 =?us-ascii?Q?rNvn7DfaT/bk30y7TPBqLQ3g1OjKUg3jcxez+7+WIW9Ph6E+CX/U23RGQ4Kt?=
 =?us-ascii?Q?Yo/xb5Ym427cNmZZW1TRtBb0qLyzMhhnT+yxFHQIlOFX2PTMkJG3fqu+DSF1?=
 =?us-ascii?Q?jQrfdeH8aKINqhxbyMsgjJSaA8gTVFS2VfJaNuOCGwddZly+GG+KJ3n6plxS?=
 =?us-ascii?Q?cza+rgU0mnzDYihxBLH/62lB9OAid3OJGvW1WPqTIcvTY24nafLFmArSBdyb?=
 =?us-ascii?Q?NCzLZ/UndOd8tO8JnZuZbIfMoXqsmgAsO6A9g5BcVaZvoVQZljOiwrXsr168?=
 =?us-ascii?Q?o4o7rb+agGsSIZ4A8EpOAwC4FXm5pmzOXI3mEbKCJXCAT6vP6Mexh+2snuug?=
 =?us-ascii?Q?iHb86B/ABf/vrEHLAMSer5k+oW7QYb+EkZUw1+PR2bNgW+mKLmTDjYAABfC2?=
 =?us-ascii?Q?XAX9wx1KBaPa+OQioUyxr6gvobsNRpJbAyHyzuKYtodeWhrPMsV9DpVw3eJ1?=
 =?us-ascii?Q?KYmhOVcja0Dmw8tO1xZ2876pjLO0RgJwt02Kkf47Vfj+t0ZjOc+ohgjzvUzw?=
 =?us-ascii?Q?sZ4SqK3PXRWkw7Abv6qP1IbcQGe3V/rYw0sSsYz6kQ53Q8og3BaN2vYRgXz1?=
 =?us-ascii?Q?GUo0E7H+/mn/EoOrxB1vQO6bBAyg3uPNE9UpIejo78g65eXh45F22CdzVaSU?=
 =?us-ascii?Q?Wk2QjYN0KcTGhE9zea4Z1Zo=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 643d998f-38c1-4ec1-fe0d-08db72305925
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 08:20:18.3882 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xby4v1dR3FWQjPyd+T4kJKn3eXcBVXzpqkZ810lEPzTohj/oe+WmCCcN/Q5nPOQdQ9v+kRynBW3aOv3s9lB/sB9i2qvXLkt9rvV9PQu6Pbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8422
Received-SPF: pass client-ip=2a01:111:f400:fe0d::711;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
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

Alexander Ivanov (5):
  parallels: Incorrect data end calculation in parallels_open()
  parallels: Check if data_end greater than the file size
  parallels: Add change_info argument to parallels_check_leak()
  parallels: Add checking and repairing duplicate offsets in BAT
  parallels: Image repairing in parallels_open()

 block/parallels.c | 228 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 195 insertions(+), 33 deletions(-)

-- 
2.34.1


