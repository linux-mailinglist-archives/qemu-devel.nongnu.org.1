Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB0F820AB6
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 10:32:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJsA4-0002Mn-G9; Sun, 31 Dec 2023 04:31:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rJsA1-0002LL-GM
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 04:31:09 -0500
Received: from mail-dm6nam12on20623.outbound.protection.outlook.com
 ([2a01:111:f400:fe59::623]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rJs9w-0008Ms-UZ
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 04:31:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cifvy++qw50FzuOG9uWgvxYE5d7TH1E7l/jeYoSrzo/1kXtsGKXtNsdBsANc6tt02Bjwjqz7ORL8W+WeF915yKPOyX19GqmP9Qd8Syx1m9KwuO/wzAJCCl2VNhe6LTbabTnkMEZFGcLUD0yvJ0PAz3gCcBk8OZ/1+jRajvBjA8RJuJ1R6XZlGmfKEHviBkJxwtsojDDqox8Dw3Wcqqoub+19BremMKFr9XgQn0EaYnfNhI0905ydE1mUyr5G5/cLiPLK6sBPRHzTp5UUHtTlMjnBURwNDcTi8/yOuR4DqliOu2XrI7T0XinQF3d1b1PM8OXeQ78+wGMU1NJG3CUgZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWMsZM95l5nlsUbOW9+dmWUpqq9ysd3uV+sBrnEvUyc=;
 b=Mx+9dPHpB1px4L9PpNPgepf5djIOkIgTzVQp4kClOWDrXZW08jw/PWzyX6ax/K8TLJSy58bbNVNswp3BgPG7AaV09GFBoSJfsypt6BqZK9CPDpf0de3js6mdi65blDsjwqaqCCOqJmZDG+80s/CltVgpgUUvKTtz5ur+Mx+n7P/spyhIBsaxAKB3iKHecpxVtNDQCbMouQoS0n1cw15FUsJ0Z3ExSryO3o8kf+wwea50qweMkcSmoev0H7GQ68wJZpX41Wh2Ig/DBHRtt6nVDDI9O51jkuheSSXydztanMK2X+7c5GLME3aceUmRpSk8q2tr0gudcAFkUyxIgue0xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWMsZM95l5nlsUbOW9+dmWUpqq9ysd3uV+sBrnEvUyc=;
 b=Y/+7oHhDKTh6Royj0eodFwDqJDcTKoKeEUwQccHUATZXiOtY0z4/5CCcwAxvF5n+7akNpYuf/+bU95kK0GVf4hPOQhaBF7SwN8HN6knGV5fM4Dx9acJbQJGlA5wHjQuCdEk34ff3UlYZM2AJaVKHRHm34k2ISZxMytmohcpSgePpFko+hLbozdqLsT1s3PnHGW5BL6myil6uFoB77nclgj7mihVi+tw2WWdbYYqwUHjFvIW0uNPytaxr9VMiIKMWBTnq+wdDb8Tp0DBcGtpEH1FUHjGKYANK3OppkY/WkDUeiO9WtqvxCetODjucp7qUAYl1ag6IPSyaDz6ai1NrkA==
Received: from DM6PR07CA0075.namprd07.prod.outlook.com (2603:10b6:5:337::8) by
 LV2PR12MB5775.namprd12.prod.outlook.com (2603:10b6:408:179::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.23; Sun, 31 Dec
 2023 09:31:00 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:337:cafe::8c) by DM6PR07CA0075.outlook.office365.com
 (2603:10b6:5:337::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.18 via Frontend
 Transport; Sun, 31 Dec 2023 09:31:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Sun, 31 Dec 2023 09:31:00 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 31 Dec
 2023 01:30:46 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 31 Dec
 2023 01:30:45 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Sun, 31 Dec
 2023 01:30:43 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Fabiano Rosas" <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>, Li
 Zhijian <lizhijian@fujitsu.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH 10/11] migration: Remove unnecessary usage of local Error
Date: Sun, 31 Dec 2023 11:30:15 +0200
Message-ID: <20231231093016.14204-11-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20231231093016.14204-1-avihaih@nvidia.com>
References: <20231231093016.14204-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|LV2PR12MB5775:EE_
X-MS-Office365-Filtering-Correlation-Id: b5db7a50-a3eb-46b4-8705-08dc09e3338b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sjq8fd82xEnuxcZ79A6Eu1H/NcZxVegB2iNQjdS7GRQbfpfF6lqdzGkYfRlByFyicvQngLak9CvfZnfcdp9+IkrZGoil8YIRrN49JIgp2bVBo+4OdrxG87WjlpAzYQ21PIFbUKZvZmJgAg3atziDoig4HTp+aoYd+c6udKnm44fhO9pmNDoPb62qTe1JaNhN32qomQHBidNXf4cQRlIgbrlElGT96QAIHNNweXAZVpbhxydcNRyvdA1veS018qhPmLmjNkIsqiiGgsKAIuo6V10q4Fzja5Et4/TS5ieQnimVZRxfPTmVNRAEizHcUPYzUvzsNj4yaqaw5E5/22AIdBXgYpH8SVLR2xa/mEq1TcS/pfVz/Mu8OzPgil+vq4To9dZHIg9Oirq7rH74o0LGGzGWbbVFrnIEHR9aCMQAER5P7+PoHoncT/CCR94GgoEU757blzHcKEn7yaat0L3dF4SlreUAicG0LtkaHa3v/UfKTSggHGyv1ZvgQSQNfUCSExvoH1QgFhJN/M1cxc0h16oXK1xV9L50uxDme0C7HglKyeU9YjD3eGEZz+lZxralzKlMRBBvhy8Tps717iBVkMlokgH2B8SplCgkPBSSGnp/8VB+refUfMCtdU7jnSSoAwCmXA8nT+qGS6FJSCD22ihrDsfEZYXA6qBD7bb9sMR32IWq+K19RgIF1s3YgYMv/IuYNfMvfn4dWCqkSKFB3v0XF0KNiFmUpei7TFdPxupPR041SDBuW/emeo8jTI0r
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(82310400011)(186009)(64100799003)(1800799012)(451199024)(46966006)(36840700001)(40480700001)(41300700001)(2906002)(5660300002)(8676002)(4326008)(316002)(6916009)(54906003)(70206006)(70586007)(8936002)(36756003)(86362001)(82740400003)(7636003)(356005)(478600001)(7696005)(6666004)(47076005)(83380400001)(26005)(107886003)(1076003)(426003)(36860700001)(2616005)(336012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2023 09:31:00.5213 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5db7a50-a3eb-46b4-8705-08dc09e3338b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5775
Received-SPF: softfail client-ip=2a01:111:f400:fe59::623;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.667,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

According to Error API, usage of ERRP_GUARD() or a local Error instead
of errp is needed if errp is passed to void functions, where it is later
dereferenced to see if an error occurred.

There are several places in migration.c that use local Error although it
is not needed. Change these places to use errp directly.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/migration.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index b0c3b4c23a..fc7f4fd263 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -830,10 +830,9 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
          * issue is not possible.
          */
         ret = migration_channel_read_peek(ioc, (void *)&channel_magic,
-                                          sizeof(channel_magic), &local_err);
+                                          sizeof(channel_magic), errp);
 
         if (ret != 0) {
-            error_propagate(errp, local_err);
             return;
         }
 
@@ -1825,8 +1824,6 @@ bool migration_is_blocked(Error **errp)
 static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
                             bool resume, Error **errp)
 {
-    Error *local_err = NULL;
-
     if (blk_inc) {
         warn_report("parameter 'inc' is deprecated;"
                     " use blockdev-mirror with NBD instead");
@@ -1896,8 +1893,7 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
                        "current migration capabilities");
             return false;
         }
-        if (!migrate_cap_set(MIGRATION_CAPABILITY_BLOCK, true, &local_err)) {
-            error_propagate(errp, local_err);
+        if (!migrate_cap_set(MIGRATION_CAPABILITY_BLOCK, true, errp)) {
             return false;
         }
         s->must_remove_block_options = true;
-- 
2.26.3


