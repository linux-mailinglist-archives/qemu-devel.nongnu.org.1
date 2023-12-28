Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFCF81F6BC
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 11:14:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rInNj-0005Ez-60; Thu, 28 Dec 2023 05:12:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rInNh-0005ED-6v; Thu, 28 Dec 2023 05:12:49 -0500
Received: from mail-vi1eur05on20707.outbound.protection.outlook.com
 ([2a01:111:f400:7d00::707]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rInNf-0000Sp-FM; Thu, 28 Dec 2023 05:12:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/Hn+NpNtkGXloiu9Uy/4Xs/mK/CMNb79nG2USHMyqvvZmtbeyOd8gSpBkFbWMWwwHGUS01vJiFeaDtcfM4azhead8qg0IB7pkP3kiYHL7AuzOkOwTohxucMdo4Ohn09muH0GNhgPKWhWex5vUTHyw+A0SQ+onAgd9sDf1WkKomqTC9aqqvrOpxA2AE8ovHJb7gZ0bJTqCXmZS1qjH1Ib23lPG7UaFWnLQ0f0vOTx0foS4ShmRLZt8fzLKF/MFl/WqG4WUH4i/n7Hw0IuC54QTLno41fb3ELksvcPtdJzZ/u2Zp0wn14cpakV6GRBhJtaPpER+8F0OEfrqIals9VOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Ybdm1b87ax8poHtLaHTutvSOVPI/E5jFnw1X6Kdkaw=;
 b=EeyEZyO5LJRH36Og9SE7hhedSv++LJGjFkj/3ueQdvjBi5BXyEaPR63ptGeVU0Ked2b0kJquqoUSigOC0ECUxsxtojbbjDUzToJIY8NPMGcpaQDSa/KmAJGhio+PkoNrd2FgplKfjMsTvpJ+/2qv00U/xTic9uSowj18LZm3LPBfEC4WKkwJ8RKlBebQu48k3mO7rtEHLTmZ2Jz4nx9ogqqM+HcWBBv27BNDlB4Z8HLArNI/AZBGWLBuIbbvlXt7wOPOBy9T76aWjPrUS5K9BQgqp/pt+mufXi6r+9Xstg6c7Gm4Xu4PqDafqlnv7i4MlwWH/XeupgZu9A27b4YQug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Ybdm1b87ax8poHtLaHTutvSOVPI/E5jFnw1X6Kdkaw=;
 b=RcQ1oI+v+OGlOlH1aMPcGK6u9rMReQaLPVlHxSAZT2D3fOfwYOaULYf1QMT4GY9gNLiFVwJDwbm9L1cveQVJufQ9h+JB33Y0Xus7nid6kjEnAw8CePCJn0sZ76F7PoTVrXixDlfL4JDGbb2BRjxKpkBZTO7BWsw5BV+yIKekRXK135rjQTi4UL2166Le6ZFLVmvb/tMMxIAWBvz3bYd2UXiQezN0p204f1DJioSfy/Yqmd+UWN79dY3DA7KLaZ+mVIKEJE5clRfyiRpHiCrL/H5ZQXD5PrIYTSafgw56UUKKrQ5smCd4yvNd4yE/T9thVCmYmCjXAC239K/UzX/Uag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by PA4PR08MB7459.eurprd08.prod.outlook.com
 (2603:10a6:102:2a6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19; Thu, 28 Dec
 2023 10:12:39 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 10:12:39 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v4 00/21] parallels: Add full dirty bitmap support
Date: Thu, 28 Dec 2023 11:12:11 +0100
Message-Id: <20231228101232.372142-1-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::8) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|PA4PR08MB7459:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e82bd3a-af78-4ca0-29de-08dc078d857d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MzGkNcagcH9TmrXlyU5THDyFOQKVr8bvQJqrnyB6LCC/Ig7jql5yJVAqVR1+kEEfssW9nkNy1e9JUgTjO4KmTRfLxO6nC8Q+loDmJPEtjzN3KKlunGDM8ONFz8wI9nMc52dVC3gbUSj8OfI+nPhHAZI/IWMdu1WiNgvuJu3y3CnhS+Tmvx5zQTPW5drL9XBQZ3qg12hEe6cr+fYQUoQ/oX/XLV98WNkaba2kOMQD3dVeOZzBHA7AxRtiLz3zo4G2sJGACsR1d33zAAwNJjUtBtzhIedEf56XbgEAXM96FwEivvVxiQgRVDkpUoPVvCx/nurMaiybCK4rm9qgkE68NTssFE9UBZZVNSGMvFVTE8ZtVvuSSG5DhdKFpRdZhGni6KxLlupJuscqMdU2c235ccBJFtpQw+TeIu/hT+Jw0HQAFcJ1RBYeemnPyik0SAVOofjvWAVkymbFHvrP23Dj1X5GPMxsdyMAlhMVBZEi2bO7BAllHwKe8YqMad9Km8e9ZaGOSHHOgqgwT+V44oZ6QpuOrAacOpcN1NVrxmctrqY0tSxZ7OdnbM3t1RhS+XV3a4Qwx/WURyngRO4XhFgAsLULLxGyFQFIpq0G+4kMCTv/3/XE7cC0xp9xJX9laNk0sGaTlxV7oikRQmlWsfi+USfzptBXPSp1+aa8OFUSj8Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(396003)(346002)(39850400004)(366004)(230273577357003)(230173577357003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2616005)(26005)(1076003)(6666004)(6512007)(52116002)(6506007)(83380400001)(6916009)(478600001)(4326008)(8936002)(8676002)(966005)(5660300002)(44832011)(6486002)(66556008)(66476007)(66946007)(316002)(38100700002)(86362001)(41300700001)(38350700005)(36756003)(2906002)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jNIc2hYSJc7G6IwA4vnZFC6yFts4EJXNjk9RJjo0ccgN0V6cm4NZ9CaBmB/D?=
 =?us-ascii?Q?jzLEtFqfVfllpfRyYC6ol076YmV/EH9pOI5ZqhK5XnqObdn+rto7cr4ise1z?=
 =?us-ascii?Q?5vFE698LJc7uPob/8Wq9VIQTPKNiQUHXMQ8JAsmxzIrRyOK+iUR027SGdgZ4?=
 =?us-ascii?Q?pYZImqxGMwG/Tj5YxelwDY6nd2ElbhxxxSukL9kqj1fC0FsT+eLPVd55qb/7?=
 =?us-ascii?Q?pSdXoJsUFdNkUZHtv8u28Df53jKtJctxuCTMBDvjL7UHjwD52zyvBzLYSvM5?=
 =?us-ascii?Q?Rasy0ximR92No23t1Y5k3LqD5Q/6uHQxe01F0H9cN2z9Sdm9tIDlKTxCcFXy?=
 =?us-ascii?Q?9EAUk7SQeI8NOECgSfasHtKSGM1RSCQX7y353gOSvN9RW+cwME/cqgtzBuMs?=
 =?us-ascii?Q?FHPxPCPXVQCnTal0Jut5QCHwjSTXwrTIuZ+kdcnhm+COqdP8tWweqmmMNxyF?=
 =?us-ascii?Q?7WlZJLtSwVGUnzi000xzRqQFgzIGnD63vS6lp4yz8Bb/Z+BzqImWdGPe9RVS?=
 =?us-ascii?Q?zQdNUoqUOLE+5Eg9moxLH1iOScJOowXbF4cWeyF5DUBWvcaTRsRhkmfdNu9l?=
 =?us-ascii?Q?jTvyQ2Eu4CPwaUG3bRxsSJYDb+9ys9DIrR4F1zs1igR6CBmBJhybbdrCee4o?=
 =?us-ascii?Q?J79Mv+HccS1/gbzRJ2MNR+NGtXuKrSNlQgfLsWG83oDnAGPOBkpz7Tesio68?=
 =?us-ascii?Q?Kdo3aAfGGpPdSRtCvcSsI4QjsJs0ISuNpMWyB7p+QekMGh8YDSpWpDQTCaOf?=
 =?us-ascii?Q?VlA6UKRQDlSxLrXWmHYBy1XvVy8OxsE/fq8nydt/6eYVDEafDaaEZc/rdpjC?=
 =?us-ascii?Q?aQq3++nMJlQfaq/CcVcGQotCvaAW3IR5q5BVxBuYPC++LI2odiV92hkoWOrz?=
 =?us-ascii?Q?pBUikMgE4ToEqWjGCbIL8v8X4sgOgMXVmEkSRhD6VjGpst6rOJup63C65zGG?=
 =?us-ascii?Q?gPSXQN2/XzjQIM0CFxHgYyZHd5zpimz7nidz5bYFfh2Ld2ZKacv8ZGBGMyZW?=
 =?us-ascii?Q?zUsib5efvPI4FX+wnvRI3TSljEo0BlZ7pcwRLgyWF5fmx8lEvZcJ3MPxv4jx?=
 =?us-ascii?Q?UOm68sLouVqsipA2+koULN22aI5WwN0t4nCt5EAP5/OBmOQPY8dwWnFWN6I4?=
 =?us-ascii?Q?P1m3iwntHJLcKlIsxml3Cq9eZLLn7UG8MjofaROkB7JzlAeA8SP2g4VDx7r7?=
 =?us-ascii?Q?n+1sV0x3LFLxmq+Lbes0LHlBktKjTVsmpo+6kEDOsxlglrtYC4jVrQgTizEU?=
 =?us-ascii?Q?J8nzD1fC0ENCXca9kTuJkIpyRfaB/NHuUXwiR4h/vWC3HihFVlMzLK3zOSu5?=
 =?us-ascii?Q?r7JqI5PJLL8A+g5HPIHFXhvsQEJ9CFiaRgg/GiwjXEybRYG+Pri0UcDzCnTo?=
 =?us-ascii?Q?OcPTvInF9pMbMZWA6UYZNPA+VxgrUuFpDhdf+8RTmA+zKvPmVY9TvSseTGhy?=
 =?us-ascii?Q?pHSRhZ1IA5/iGvkKXuzJ7ojn/aNAJetWyhDcIH2X4zcSDdsVzVwuwtY8OQC7?=
 =?us-ascii?Q?DnvH7wexWgK7s2LA7WQY/3k99/URILk3YwZq36rPDhPZFcTwtV7HWPKQ2aEY?=
 =?us-ascii?Q?k3GG6i8oXukGGmUQ+xgsdv9oTFWW+I83MHc0FGD/83HeLys4PfrruFBcwIZb?=
 =?us-ascii?Q?ViPmsnv7BGPkd26GcdIrExE=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e82bd3a-af78-4ca0-29de-08dc078d857d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 10:12:39.2438 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ava1YfLRrHU3Js64pA6AbL77b9wM1dopkZvkXo5GHMB5a83ZHGBNqmtBPeO4FRdDojEPTUx6iRciE2ianH5cLYb2qG5dSBIMim7Mq05Jfpw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7459
Received-SPF: pass client-ip=2a01:111:f400:7d00::707;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Parallels format driver:
* make some preparation
* add dirty bitmap saving
* make dirty bitmap RW
* fix broken checks
* refactor leak check
* add parallels format support to several tests

You could find these patches in my repo:
https://github.com/AlexanderIvanov-Virtuozzo/qemu/tree/parallels-v4

v4:
4: A new patch with limitation of search in parallels_mark_used.
5: Previously 4. Search is limited to (cluster_index + count).
6: Previously 5. Added GRAPH_RDLOCK annotation, added a note in the commit
   message.
11: Previously 10. Added GRAPH_RDLOCK annotation.
16-18: Added GRAPH_RDLOCK annotations.

v3:
1: Fixed the order of g_free() and s->used_bmap = NULL.
3,4: Made mark_used() a global function before mark_unused() addition. In
     this way we can avoid compilation warnings.
5-9: Patches shifted.
11: Added GRAPH_RDLOCK annotation to parallels_inactivate(). Guard
    parallels_close() with GRAPH_RDLOCK_GUARD_MAINLOOP().
12-21: Patches shifted.

v2:
1: New patch to fix double free error.
4: Fixed clusters leaks.
15: Fixed (end_off != s->used_bmap_size) handling in parallels_truncate_unused_clusters().
16,17: Changed the sequence of the patches - in this way we have correct leaks check.

Alexander Ivanov (21):
  parallels: Set s->used_bmap to NULL in parallels_free_used_bitmap()
  parallels: Move inactivation code to a separate function
  parallels: Make mark_used() a global function
  parallels: Limit search in parallels_mark_used to the last marked
    claster
  parallels: Add parallels_mark_unused() helper
  parallels: Move host clusters allocation to a separate function
  parallels: Set data_end value in parallels_check_leak()
  parallels: Recreate used bitmap in parallels_check_leak()
  parallels: Add a note about used bitmap in parallels_check_duplicate()
  parallels: Create used bitmap even if checks needed
  parallels: Add dirty bitmaps saving
  parallels: Let image extensions work in RW mode
  parallels: Handle L1 entries equal to one
  parallels: Make a loaded dirty bitmap persistent
  parallels: Reverse a conditional in parallels_check_leak() to reduce
    indents
  parallels: Truncate images on the last used cluster
  parallels: Check unused clusters in parallels_check_leak()
  parallels: Remove unnecessary data_end field
  tests: Add parallels images support to test 165
  tests: Turned on 256, 299, 304 and block-status-cache for parallels
    format
  tests: Add parallels format support to image-fleecing

 block/parallels-ext.c                       | 183 +++++++++-
 block/parallels.c                           | 371 ++++++++++++--------
 block/parallels.h                           |  14 +-
 tests/qemu-iotests/165                      |  40 ++-
 tests/qemu-iotests/256                      |   2 +-
 tests/qemu-iotests/299                      |   2 +-
 tests/qemu-iotests/304                      |   2 +-
 tests/qemu-iotests/tests/block-status-cache |   2 +-
 tests/qemu-iotests/tests/image-fleecing     |  13 +-
 9 files changed, 453 insertions(+), 176 deletions(-)

-- 
2.40.1


