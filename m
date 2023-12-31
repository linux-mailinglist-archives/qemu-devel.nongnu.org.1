Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C20820ABB
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 10:32:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJs9s-0002En-3r; Sun, 31 Dec 2023 04:31:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rJs9i-0002D2-42
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 04:30:50 -0500
Received: from mail-dm6nam11on20631.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::631]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rJs9e-0008LD-BQ
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 04:30:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CynSgTZ5BclloEealOsTV1vWAI3I4/OAA12DrxEFE6Ay4weQxff+o5Mjz1TMLwcufhfXxmqq7rhweWnYyJEWSxiSpttmwt5Av34wRrfwtwMSbV0783Jhfz1lMjr9nC6duiQL+f1chcIGDM8U/T5dczEcrdK+WRIiG6YdN8lKQ8h5JlXtyMu7mWfGyibCp+xj91AIK1A8QH2I0gFqIAIC3oZ/nvOE4DmIPZEq1hcVCOuxYPtHC4xvPLSkpIQeBTCj6ocIGSGo3CUXzII/9wLb8BXGabCQlOtjbuISIYEoDp28+ws8SpzgRgIdmxqXOH6s1rxF8w9g+jCLAK8ZK7AqlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTyLSZjwwhllyNwTgz19z0yMCTy1QGMjAmj7aEhcEqI=;
 b=gIXmGX/wZTm0mJdcpBpOc0hDtoYEXtUWPTwl3INMsKYRK1Xl/VC55bGoj6Utyevc+RHpEvrVwL1MXpo/QL/5GNXBI/q0c075XG6U7kq+UEoV/J9b5V6f/eoV5ajAUwsunvS+56ow5DxttQCbx4I1okasKZQmgJBuqWp995AtwJxoytbo8Yk2GvKNUEQezoTGnkTCg6fXUaLK4CMYSvELuPJwiOPZbzBss+aJFRV5FPQxsQF3olW+JKoNem5uuyZ/LebbZC1k3CGR8B9ezSXrSREns6QzJWpA61RuBxXK7SSF71uAlATpiz/5w2o5Aq23WKXGmopDil4I2kHg7YUgPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTyLSZjwwhllyNwTgz19z0yMCTy1QGMjAmj7aEhcEqI=;
 b=rHGNADbGQ7T0GruljnSbYesmNCUyQ8MEyaFeh7Wu+PYA0p4Qr+P89HRaxUpvzBvvA0ciosalyH30KZs0YSpdLfoZeYGwEDo13fNKxH/kCY4Bumhs84b/z7D8WI+7CpM2jXtLPIVde7coNjGlZSHoMUdO+HBAUQIZWkHOdefj/Yp9mWTDpXqfQEZBvqVOaqppmk3CthL44AKFycvU26lesqQU7SGoMdHsgerZ3IlLav3fNRTT44FzUIq3U1eH8MpAUEPeHiEDx2v2E48bbrMymEZZftRqtF4/+W4JXgJNbM1Eop09QpGlDfJQ+YFJQ0rEIXhp/pVy0ZtFPJmcwArEFw==
Received: from CYZPR19CA0015.namprd19.prod.outlook.com (2603:10b6:930:8e::11)
 by PH8PR12MB6867.namprd12.prod.outlook.com (2603:10b6:510:1ca::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.24; Sun, 31 Dec
 2023 09:30:41 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:930:8e:cafe::75) by CYZPR19CA0015.outlook.office365.com
 (2603:10b6:930:8e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.22 via Frontend
 Transport; Sun, 31 Dec 2023 09:30:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Sun, 31 Dec 2023 09:30:40 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 31 Dec
 2023 01:30:30 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 31 Dec
 2023 01:30:29 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Sun, 31 Dec
 2023 01:30:27 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Fabiano Rosas" <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>, Li
 Zhijian <lizhijian@fujitsu.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH 04/11] migration: Remove errp parameter in
 migration_fd_process_incoming()
Date: Sun, 31 Dec 2023 11:30:09 +0200
Message-ID: <20231231093016.14204-5-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20231231093016.14204-1-avihaih@nvidia.com>
References: <20231231093016.14204-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|PH8PR12MB6867:EE_
X-MS-Office365-Filtering-Correlation-Id: 42edb425-98ed-409e-6e53-08dc09e327c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OB/4/9Tjt+ZJ1DlZjkRGXL4Zef9NZyLS1ivTAYZ7tMop17UUfY+dOJeUc6oShb8AUMkZcbED24Y+jSxCGcm65pT809a/t4zTHHvJkTpgFuBwg6ZyF/ssPI5ZXgDhXHTONZS5EHNUGBvfbJVv6bzlDLyiXPCntmZNskDwak/qozMFXWffCb1VXHJtl5ilQg8OkCnz9Ye9i+Nv8zzCGRuX/l8l3vF1lZE0rw+Z/O1yh7jevLxd/uAWb9n5sjGEcqNftHdta9pYxg8Nj1g9ctjaH2yuu3d69fLPIL7c6k0JeeHDSXA/xX/nk1ZkQM6etI+ZRQRllNq0KbKaJ9Dd2lxTXetw1BALaNQpV/b2ZDwMQrhj5h10lrKtnkeHZ9x9e8ghOT+x6vc007ssMNO8OZAVZRZPcNadsuJsE5auc3kn1QBnHiHaydllvIjuqvvpptLae/6Dh0OddEZAWYTLSkRV5yrJL8WhYSwROAYXmp6KUKoQ1zmNjgn6Jr0kIb/d7D8tie6ikHmxJaX8GOGd5iC8OUyBSZmHYMgwQOQg0JxNu7gf3EuLYvqHIvq799IPZSacgHcqe9h4/P/f2DlTgU/qXcg9pUuQ6g50Hoak3gwdukCgg/GGnjSaKAaxhPGWB0Say1y5nska9Sfl4+Vok3PhRRcNgecPGtAzwX5vf3i6aVoaU2PAFNSz+yc1xuuidYRIhlCKYxUvPdN41kLQ6pekBSi7rAWm9ci6ywYLcJffh/XGXIjEpgugVRS8FhgGwCKt
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(1800799012)(186009)(82310400011)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(7636003)(356005)(82740400003)(36756003)(40460700003)(40480700001)(86362001)(336012)(107886003)(26005)(426003)(1076003)(2616005)(7696005)(6666004)(47076005)(54906003)(4326008)(478600001)(8676002)(316002)(8936002)(36860700001)(6916009)(70586007)(70206006)(83380400001)(41300700001)(5660300002)(2906002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2023 09:30:40.8216 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42edb425-98ed-409e-6e53-08dc09e327c6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6867
Received-SPF: softfail client-ip=2a01:111:f400:7eaa::631;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.667,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Errp parameter in migration_fd_process_incoming() is unused.
Remove it.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/migration.h | 2 +-
 migration/migration.c | 2 +-
 migration/rdma.c      | 6 +-----
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index b3c9288c38..17972dac34 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -474,7 +474,7 @@ struct MigrationState {
 
 void migrate_set_state(int *state, int old_state, int new_state);
 
-void migration_fd_process_incoming(QEMUFile *f, Error **errp);
+void migration_fd_process_incoming(QEMUFile *f);
 void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
 void migration_incoming_process(void);
 
diff --git a/migration/migration.c b/migration/migration.c
index 55d77572d8..732e3dadd9 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -774,7 +774,7 @@ static bool postcopy_try_recover(void)
     return false;
 }
 
-void migration_fd_process_incoming(QEMUFile *f, Error **errp)
+void migration_fd_process_incoming(QEMUFile *f)
 {
     migration_incoming_setup(f);
     if (postcopy_try_recover()) {
diff --git a/migration/rdma.c b/migration/rdma.c
index 04debab5d9..94c0f871f0 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -4035,7 +4035,6 @@ static void rdma_accept_incoming_migration(void *opaque)
 {
     RDMAContext *rdma = opaque;
     QEMUFile *f;
-    Error *local_err = NULL;
 
     trace_qemu_rdma_accept_incoming_migration();
     if (qemu_rdma_accept(rdma) < 0) {
@@ -4057,10 +4056,7 @@ static void rdma_accept_incoming_migration(void *opaque)
     }
 
     rdma->migration_started_on_destination = 1;
-    migration_fd_process_incoming(f, &local_err);
-    if (local_err) {
-        error_reportf_err(local_err, "RDMA ERROR:");
-    }
+    migration_fd_process_incoming(f);
 }
 
 void rdma_start_incoming_migration(InetSocketAddress *host_port,
-- 
2.26.3


