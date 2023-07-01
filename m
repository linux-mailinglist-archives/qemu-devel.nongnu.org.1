Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D82744860
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 12:09:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFXWc-0001XJ-0v; Sat, 01 Jul 2023 06:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qFXWZ-0001WE-SI; Sat, 01 Jul 2023 06:08:15 -0400
Received: from mail-db5eur02on20710.outbound.protection.outlook.com
 ([2a01:111:f400:fe12::710]
 helo=EUR02-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qFXWY-00076b-9k; Sat, 01 Jul 2023 06:08:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2BEDVx9qAx7dgCxW/GAULBkcWYOMeQ7OIGlffl5OdvIeL3LTLUhmG9mAZeXF7fjtUsPY+3hcOU4tNQmsw7vFPUXu5jnNrPeJdO6IGdRSQot6BySXqKSuYJGS5iepoWiBr6uPgkA3YCdF6mn03iH6ftzAU15Wshyg+Hss9JOmnBc7NyZtDl/yvyXXSbCufGstO+rdKqN3L81p/c5Kf8ukcHwJyPKp7gxZs/XBP6AA/7GSMLOhDF04R8l8wIn1Ryqqr059K3E4OLKrkXALNA+YXDYi64VcokqpjeCPUHcrRiBsu5RGGZ5JBTw/dhlVk/vpAl6+SlNXsegh3P9mBOySw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuitORZZ4LNGGm6hXFV0fWfmEBI0ekA6iPZh4b3x1ok=;
 b=cTVN0XDJRFr6WdlU7yICmordTLixTDDNzrKndaEz8G9dTG8aXqZ/zdhvmsFpO2vhvwx44FEExYSyD50Q3fT4Kn9nkeQp7a7QqvvlJX/+FGYH+HKpg0aBn7GOPaM79U+/9KsiTT7Pcz61+0vmCpmN6nylMVKTqbiHsyhcaS9awVmqClRM6aGHYVV4njzPvxrjKGpDemikpWpD4hzCKMubRQrHGGJm+1PpE8ekoctTQPx0LTZy/lx8Mw3CUdgriynxgteb6Q7zEgsK3QUQI3IfJS02/ls6V4Y10CVMAAWBj0N0tJ3XzFfSM6qBtcl+ypqe/yiOqb2wnRIcezO3yK7wWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuitORZZ4LNGGm6hXFV0fWfmEBI0ekA6iPZh4b3x1ok=;
 b=f4u/V/8rGOTm83ZTr+XMRhUniPuwy19TJqmCIH2MLleHEISuRklRG+Un9p+DSCej4DlR0rS1K2i4RimMY/9Mc7Eq4VpL3fftTNldzaH6eyxeHui/dACjCoY//EBvHgxR8I5VcB8SaXclI7+pSlVPFAhctBBFsJ9ps4pP0HMwNpfpDh/Ecmj1zRxz5u8Ecds/YHY7+Km0uVeyToPwaK5GHYsY/kx8jDol4Fo928nroiHser4iLbMPBJwb90TeUjUP7n94KVH+2NMmAW8j2hSygH0RMsGCvW9FKKe9QvYK4lrjPKgCI/CL4JDavcTT0Fh5uqmaII55Uz3a2fyekuqmPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by AS2PR08MB8832.eurprd08.prod.outlook.com (2603:10a6:20b:5e6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Sat, 1 Jul
 2023 10:08:07 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243%7]) with mapi id 15.20.6544.024; Sat, 1 Jul 2023
 10:08:06 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v7 0/8] parallels: Add duplication check, repair at open,
 fix bugs
Date: Sat,  1 Jul 2023 12:07:51 +0200
Message-Id: <20230701100759.261007-1-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR10CA0108.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::37) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|AS2PR08MB8832:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d0a9c4f-a182-490d-054d-08db7a1b10a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sfMnwvtqgAwk6YtAX83e7JIVTgUiP/XijAmFWKZKJPMEiAJ7oM7CfEQEeZZZFu70uSiSjxXHvNI7eq6BllDnv5WCCwAEvVRpK9ghEBl7/3kkn+Jy0DVtPq0LySCdtV6RBee9q0JjGt31Hg6Qj9Xu4wAWuV26v8agLdbiLMHaKWRppKBFdJWKPlnXgUNi15LAfc+QG8YK6m9EkL/hKJfoiPFZxsiOfNy3X+NU4SvBQG0nGQhC/5lR/HJLPbS7Djz6s+6RX9tflRUcVB5ApsNTLuJrK1OO85gms4dGgItTJgly2imuuA5h2sl7CarKs5/lhkqepnx6DZf2/ZeQ1Cfdj1+UT6yYqbOVEY5PjP2KRnOuv41feItgQmFWjghRbg6ka3c9i4rXORpE2J0GcXGslEg/PUHgTI1zS6RxoXIukVCy/0ZJ4/XhcoH370hPp23ys66wTzBjAzsfDaHQttWQxl4/iu/Di0DVe6rYJA11rndSwXdrE46GbLJ2MTN0VUrt2rhxj2aNefbEw/YUyxhTD217Fnnj6oC2DN2SRmm8vIVsIHQUQX6gneTS+ibZ/DnXKlnTQZLbYrtsw9XXAZtPPmgQTbgQJKjGF3faTkMSM94+6FyV8g3lGM6ZJEg9raLH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39850400004)(396003)(366004)(451199021)(26005)(478600001)(1076003)(6666004)(6506007)(6512007)(86362001)(2616005)(186003)(38350700002)(38100700002)(6916009)(66556008)(66946007)(4326008)(66476007)(83380400001)(52116002)(6486002)(316002)(5660300002)(8676002)(8936002)(44832011)(41300700001)(2906002)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8G9jT0joTdCd7n62P7KcSH/gR6SUb1v7OF7M1j3eE0HLcVz/qF1LUvSipuC5?=
 =?us-ascii?Q?rXgcGXCfBKYk4cqwbgYEHh5ivVqCiB6ZAaEl5IMgsSdsrcz+vYdBVkwITkPR?=
 =?us-ascii?Q?1fMMdna6bA9w4Nu/bIfSkQVsKyYf8E4hGDdvokyMOuTl+7BZu5FBO2iB+tgA?=
 =?us-ascii?Q?sCLXpSe67jfievU0ZrVpqUUKNeDErEeUuiSH5CKwjldQyvyPRFb0tXK7rQhf?=
 =?us-ascii?Q?eay7C+NoIJ9TkMpwJSuRZ5rEJE0sotOYZrb50/DkmBZ0WOukWEi/IXBf/TlB?=
 =?us-ascii?Q?gGq+Z1nkByCrlVOIBuP5qreOTPoLGbJztcFWhtSGjdiKpF/V0gTpmHK24WjI?=
 =?us-ascii?Q?bg9eTgPhVI51oEHx3CA5KrGrQ2OhcMqL8a6L7kMuK7Z1/HmMQ0TAYWNeYrWt?=
 =?us-ascii?Q?3TEfBwtVwiERyxUXS7jSIQjK8yu0pMo19CA87A9Kx5bckUyH+TRzrjiMi5Rn?=
 =?us-ascii?Q?JgFmPZjJodb1oaO0NBWWDB7JJtlH/jbko5+Li756vL9BdSgkkBOkmMlpWtW3?=
 =?us-ascii?Q?s9hsmWU3dnl+OWMDICJ2ogNsYHby2uXs+t/oOUCejB5Asrxn4KgL4G4LVG2n?=
 =?us-ascii?Q?7eq3YZkdjjz0RJV0HOpTQRkrcDFxCGxw8UlDrGYClN0Xb7dwNoQyXSPSdms+?=
 =?us-ascii?Q?zeqHwkG1M2zpssPSTgdDCJxOUyxRDSSAbSKc66cJ+TwCxL6mqrd/poxA2TT8?=
 =?us-ascii?Q?rXbJkNXShCStJQAULGAGLyF/Ze+UipZ8I7unkVpfbAaNvK3KLI13GaMPXqAV?=
 =?us-ascii?Q?rxfyUXyWNt4NN5c31txfm9kM7NED6BaSTGC1BrCJ4iiEzmWcbGF1NFDuvIQL?=
 =?us-ascii?Q?YrycLx5tH20h38NDK5iOnmvhn7PVgvOMKbQ4Dq+uxdWukLOGicaHxWlxJS7i?=
 =?us-ascii?Q?Uk9xESQbIGb4c0LB6n9evGtOzm6h5on1oizrFE5Z5Qm9IiXO95+l52hUliXS?=
 =?us-ascii?Q?bP35+qo3i5m/2ZMBprDDB3WXyVVDwP88zpG3/Q4Vy+D0XcGtdKGHxlxBxtH1?=
 =?us-ascii?Q?owGBLkBOKrxdXe4cJyPGth6dEgbGU120VBK4mIdskDM2B0f+AMfzHmgYNCoP?=
 =?us-ascii?Q?z2glhYbfIVkXTDZ+nE9Yxxo9bKxlFHgOsi4eqm16o/8Ni50DH5patIa8M15f?=
 =?us-ascii?Q?fmzoI29KFEO95dZrwiBOSvd0xCqI/SGby80Bc9wowuwX5taXDccDvXIqJRta?=
 =?us-ascii?Q?JTqaPfzw6sWBDu73KY7XI6wNsVhd1E9zn51GK0clKc/QZJep5feesrDFJAMJ?=
 =?us-ascii?Q?OQeNX84/7u9PDdBQk6Yrtl9DP7/w1sgO041Kdi2vO/y8kCeFegxVbhOiaTa+?=
 =?us-ascii?Q?SJR3x7TBUm5vweu2Xp6HAGCJc934D3oSu1LjEXgW5gECfAY+Efclxt7R4Q2n?=
 =?us-ascii?Q?u8rXVUvcUJDCYyJuKfc9dyJ0R/3IgiIntphBaOx32EMMnIhVsgxX4XYOCpq5?=
 =?us-ascii?Q?rwXsvhwoDR86YDIc1ASiKrmPBpMa+NLPNB0YgnlS4DjvStL4APCkE+u2eXY5?=
 =?us-ascii?Q?Q+BBhaxNV3XtKoygt0jGKUbrAM0Wj25SLPZtgQlX818y6nelPsPel7IkA/bD?=
 =?us-ascii?Q?iGWH0WTVXJwsp9aPLChyIRBo7mAg8BZ3efdzS0QfWbyjDS7Dal3vb5CwDO+S?=
 =?us-ascii?Q?YsydAKGMeAr0Q4ocImNZ394=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0a9c4f-a182-490d-054d-08db7a1b10a5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2023 10:08:06.6477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wr6KGFJmKk6epHgCMGm30Eg3pmgfGTydRhhJ3DharTG5NfeYMSOWd1rKgk5fqYTqCTw8lM/0v9Npihmg6NAJCKqLeLUGfyD3ADJiNLO7O00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8832
Received-SPF: pass client-ip=2a01:111:f400:fe12::710;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR02-DB5-obe.outbound.protection.outlook.com
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


Alexander Ivanov (8):
  parallels: Incorrect data end calculation in parallels_open()
  parallels: Check if data_end greater than the file size
  parallels: Add "explicit" argument to parallels_check_leak()
  parallels: Add data_start field to BDRVParallelsState
  parallels: Add checking and repairing duplicate offsets in BAT
  parallels: Image repairing in parallels_open()
  parallels: Use bdrv_co_getlength() in parallels_check_outside_image()
  parallels: Add data_off check

 block/parallels.c | 317 +++++++++++++++++++++++++++++++++++++++-------
 block/parallels.h |   1 +
 2 files changed, 274 insertions(+), 44 deletions(-)

-- 
2.34.1


