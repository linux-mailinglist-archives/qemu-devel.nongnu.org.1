Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC4281F671
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 10:45:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rImu6-00089g-7i; Thu, 28 Dec 2023 04:42:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rImu1-00088Z-UK; Thu, 28 Dec 2023 04:42:10 -0500
Received: from mail-am6eur05on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2612::701]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rImty-0008Gn-LH; Thu, 28 Dec 2023 04:42:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SwPhEB/DmgXXvBGRuCU3nR4qufY9eWablslPk7vrRBIBZ34OVYM/PIE5t3Hic0d3K8u0CLTBLTXu4FqozEc4Arf+Gl91hlRRmlH4N/9Gq/ApWe/5I81jm9DmvCUr/RlCibwxxloNPmU3wp4qwepd63o+ak1B0u3qc3Kwj3SQPnxOZAF4gYziFtFkPQTDAKLrs2rEpJcdHfiSkIKRbDd6y+UjNlScU6d3lc5beu3YjVFH8LH62DR8uiiE0Z4A7naxDsJa5CIFh7QdlzghtQf2jTQanFkKPoJzhI1UEYMgvEH6M5DBjSFgyD8yBv9i0H6bwDAfaLABC91DR/81Qbu4WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXO8ScENoFKWHNVwNMhYTBjNx87409obryISg/lbAE8=;
 b=frOm7QreJ/hE20yfsUvzKGGisHDRKom3IOZr6qydQy20Yiz/MhiFr3WPj2zo26TlF+UnrUd9NCHmORPtH17T+iKBGFS0d03HR/3gcmjn9PID4DP3QRuMvR1MdThZFSQqLZAs/wwXN8JFMucP2TE64Um9/jeWg14fFUSyGEVJB09kE2Nj3yAPhHH/6oUhhVfgK1Z6C8YfWi1dk4kt9vulSl2ZL1+/wACKWw7jIq9o54LzT8ZM5/pmvH5A3d2rgbXcz/CIhFjckg+xn4wEYmH5/NgMjj4lm63emQzjXgc7HrQwnVQiM1FtBvxRe/+hL9hBABoKRIoIa6lYXd5dmwdoUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXO8ScENoFKWHNVwNMhYTBjNx87409obryISg/lbAE8=;
 b=Jh8Zb/aJLZFg2dIpZofFJI4vYhA1UH8nVrIVFXksarJvpYlUVuC3JNlCeO64LdiC76XMkFOa9eFOQJT2O/7GjrzsHSfQWrfJxuK1dqg1OqkAN6Dj4z1NxZq0AP9/M68kkuJwBy+vUpbZReFO7VZ0fsVY94CXAXZ71c5e2f51fnIwOQYBSNw2SZeRFB7ao7V8KJ1a38i2eKacFYPEj44qBskcG88vgYMJHICRLtte26z0T7bpk5FeQxETf5M02Ucsevx5UrXtr3Kr8mKLgN0ALs9+8t8FOSHbEctyBvw3YRq0vXrRTvUS4KiEpwPVJImY99UKKMS2CJziLRPlgPtnhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by PA4PR08MB6064.eurprd08.prod.outlook.com
 (2603:10a6:102:e2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 09:42:01 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 09:42:01 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH 04/21] parallels: Limit search in parallels_mark_used to the
 last marked claster
Date: Thu, 28 Dec 2023 10:41:36 +0100
Message-Id: <20231228094153.370291-4-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231228094153.370291-1-alexander.ivanov@virtuozzo.com>
References: <20231228094153.370291-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR08CA0003.eurprd08.prod.outlook.com
 (2603:10a6:803:104::16) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|PA4PR08MB6064:EE_
X-MS-Office365-Filtering-Correlation-Id: 76cb5399-76d9-4aa8-5e36-08dc07893de0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: skmKiNOCrSgrorQObA/Ez9ltc8/WWud//2zmKyP147Ch4x36rIdiFR0MEAhkz32vxAYyO0yFSoNCn7/qPK5VXZ/nVR7rd+RxUdXtIV567m/O49/5pqUZRqfHN8m8BShRQSeCZNuX4wyPtX9DNLz2btILQj5ZwNNhAAQMeOLpSlZEGR1ZXfuMqej6nRFgQLCJWhBe6VKuon1dyEH+r6xbhspYXW1w5SmUX1zKfoicH6ueABMUzLqAOe5sfprH0f28DZ9LOntLcBKyTHccpFtzFzMu5kiEmuTUFHa4y4LkPJNLZuI/3SGgA7C3kzupWROyMoXsExERM8dPHHgCn9kve2v37IeMBfuMYsVT1GATYEaAkf9vSaI75C/Mbd92tu9hS+yhlPWcpYqFKm2qw3eDXpg3Hka7mXMhsjIxDCFevaAvakhu9M6vcNy5Uq/lBAy5EaYxHBRIYDJhau95WueuGaFh6R/ls4GoHDHWMAm//hocCHzwj26mYfsjahSpNg7NzU8voPO0DOTl0YyDU4hzbVJmprmxln2ODO7He4CPWk5JbyUywjsaqfwvu4M84vQAkRHMyh0XlsRf+bfYReLSadutugZZw8/wUfzZ6tpJa3C6HFAffZIaDALb5iofX5ip
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39840400004)(396003)(346002)(136003)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66556008)(66476007)(66946007)(6916009)(6486002)(4326008)(44832011)(316002)(36756003)(8936002)(2616005)(26005)(1076003)(83380400001)(478600001)(6512007)(6506007)(6666004)(52116002)(8676002)(5660300002)(2906002)(41300700001)(38350700005)(38100700002)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xj442kW5CENX59xqKc7oaCHTX5ghhK7HTIWxM5FETf76IjiATWcIs9Pt6B7t?=
 =?us-ascii?Q?IYm1Lc5C2jduyZ5d6DQaF+NV73JiCSRMOty0e5dl3fp6va0f8IEbes438A8m?=
 =?us-ascii?Q?nZ9dhIPvJ95VmnOB8iGu7Lc5EFKDUlc7f2IP9We5gtSEXPbNcXIP2c0Gf0IQ?=
 =?us-ascii?Q?UK7AHNgm9FGee/SEwK8WSZ4YWNtORqWF9lJljuZ4jTyJUMIDqGyxebe21Rfa?=
 =?us-ascii?Q?ztct/H9byxBHDc0B7AR85olnNtGgKUp9jPOYvANtRm8bl/PZDhLyLK8J3IGW?=
 =?us-ascii?Q?CfOUQUxTElHB9NVfZqO5Ue9N4PAIWGmzUX505kqbXJA2sMcIGcDtGu6ApJib?=
 =?us-ascii?Q?FZgh8R8IxLxRitlXTgn0CxSyl2V3nKnUWTXGay2j+Qen1sYoOfATacMDMlkM?=
 =?us-ascii?Q?hWQyg0pGpApJ+9wdMJahq0uBjzjUbMu/d9/hASwp/fQjrDaOYr62vl/6Nm3l?=
 =?us-ascii?Q?4rADFKJflycgrrI0bSyUEOPCz3StGcHC7y2O+7kWFMPu+kP6w7nlvD642Y1e?=
 =?us-ascii?Q?qEx/qHOZ/F3MNAwlRP8MgFXbcfORZGCgrsIRDr7yK2NHRfNe/BYHL2KJKlSJ?=
 =?us-ascii?Q?rhg720Thzm0v0AptD8eXnhSnKpGoqezsT76ZM5lngvcf2m6HNjRkzbZ1FPl4?=
 =?us-ascii?Q?Lv1//drE8ridgJEvfGOLjHfHTAIOkGZG0bY76Yyegg+CbuqYBAiPV4b9NG5a?=
 =?us-ascii?Q?1YWa5qvljfXj95SyjkoHHGHP1sDcpYqTCKFoXEXEaniauSAG2fnhluKFsQus?=
 =?us-ascii?Q?z9JxAddrw9Saysg0DCof/J9l3lAFG05k9+CkCZGGP8cYeDqDBC9NnTID2z8W?=
 =?us-ascii?Q?nrBh6v49iztu4cItKOUYTEiZ7/gT7yScmMnZggJDpX9wrS6vWUSPKg4DmGfT?=
 =?us-ascii?Q?2XLBQx1hQ/iTCBSGl+02y4Ej2UsDjN9tXEmy8a5mjESXmna8XchNj4XVrQKl?=
 =?us-ascii?Q?NQyR283DKKF+IBjrvjos9oRWyEuudm3aWRY3wb927Tb1d+XSRKYmbT+ZAOok?=
 =?us-ascii?Q?GyYkQkbuhJXxF0n1p9jegudlRgYtF9KvxeLgN1py4/TksFbwNpOUYZ+PAMYQ?=
 =?us-ascii?Q?VmFDjmoWr/+Ac1MIPa5aSQ4TTfmvSabdTdSdOPBSt7LHKNT5j/zE4IpIf6ZN?=
 =?us-ascii?Q?71HehpdmqjD+rkm+670CPaWGV/eBEml07aFQIzP00o+WYyh6ds0+mYiUKTEY?=
 =?us-ascii?Q?NfH4wL3sm7zxvuWeeols50yEJtFKycJ8tDG4iONqqGc1LqTJ/RcWQFi+eyd1?=
 =?us-ascii?Q?GAh0/o8lz9/Dwo/UyhEM2b5JJutqWd+E0ttkta7K2hdzNQlctZOd33hxO5Z8?=
 =?us-ascii?Q?U3Ot9jtmC04kcGt+V3fxJqI+bpqOEBCGUO/ImtogqEp9FR/c1rnfYmdRS2on?=
 =?us-ascii?Q?G1/C586MkB13xwNpYsacgUktfETElwe1zF1Hzs18hzNX+cVkg2cXDM43y7PI?=
 =?us-ascii?Q?doTM8lODzCyAxPQBjkjMAoJopoYIzew/KjH6T/xe1W8I3m9eVL0tdCAEkP/K?=
 =?us-ascii?Q?N1p3SQxe+HM+Kgtq7EtCn4UJRfax94soxs+R4+MgoLiR3RDqYeOv6Ji8m42i?=
 =?us-ascii?Q?UNQopdXXbF1tnb4+w54Yq0u8qiFCjtVNvle74SEgWMlOZTQyDIObskVOfPZY?=
 =?us-ascii?Q?mqpAHg+J0dcK33CQqdCXEgA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76cb5399-76d9-4aa8-5e36-08dc07893de0
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 09:42:01.0962 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qwPsotWPjEupbVhUkhD+E6dwVG4D16EIU67lSr+BBZF/eee5SjalDCGRCgGSpP+yiQ0sS/kuQMx5EMYnI8vi85WvuTCcUVMUUiPBt1lSc8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6064
Received-SPF: pass client-ip=2a01:111:f403:2612::701;
 envelope-from=alexander.ivanov@virtuozzo.com;
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

There is no necessity to search to the end of the bitmap. Limit the search
area as cluster_index + count.

Add cluster_end variable to avoid its calculation in a few places.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index ae524f1820..4470519656 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -182,13 +182,14 @@ int parallels_mark_used(BlockDriverState *bs, unsigned long *bitmap,
                         uint32_t bitmap_size, int64_t off, uint32_t count)
 {
     BDRVParallelsState *s = bs->opaque;
-    uint32_t cluster_index = host_cluster_index(s, off);
+    uint32_t cluster_end, cluster_index = host_cluster_index(s, off);
     unsigned long next_used;
-    if (cluster_index + count > bitmap_size) {
+    cluster_end = cluster_index + count;
+    if (cluster_end > bitmap_size) {
         return -E2BIG;
     }
-    next_used = find_next_bit(bitmap, bitmap_size, cluster_index);
-    if (next_used < cluster_index + count) {
+    next_used = find_next_bit(bitmap, cluster_end, cluster_index);
+    if (next_used < cluster_end) {
         return -EBUSY;
     }
     bitmap_set(bitmap, cluster_index, count);
-- 
2.40.1


