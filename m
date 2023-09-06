Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C7C794000
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 17:11:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdu9m-0004OA-3n; Wed, 06 Sep 2023 11:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qdu9j-0004Mw-67
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 11:09:23 -0400
Received: from mail-dm3nam02on2062e.outbound.protection.outlook.com
 ([2a01:111:f400:7e83::62e]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qdu9g-0003jc-LE
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 11:09:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=haICKIQxuZYYG4TTDBGQ0H1OxvuXCRCqdJfp0Ykn4tV4GEOEONjZoc3Ly1kPZUjJFcOGJrmtgtIcwbFp1fUXMmsSSYnAoliopiT0vAyOJcPDvZQCQEMVYnKagicfBVFiE4BFBYNls5A9+pNhCZgJYgdicTK1ZvOudnY6JAmT7DUzTFZvcZ5q3SwGtW9RtNvMZ8Uy8M5z3oGJ3X+HuBUlS/b4082o52C0a4AXc2iW8SKt2Ca6WFKYsAYuoKaJiUuNnq7IfS1z0kASpfkxAwJBCwvr/McEglS7HNEQPhukyTI/l8ZDDDEYJebhTpH6vdtCD2BdiD9xUlu6BTWKlJTzJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zujfAcUhmtizPK/ZnZu93fvANGT10YSJxmBJ9X7UFs=;
 b=jAaNt9651HWc9epDujNY81spGDY2iMYb4UeZOpdj4YBcRGAnjm56KPnTLvO4oHp4iZSzQgTG38bUXENaZuS3cJQtpSD9U4zV6oibQLws1RBHHQpuTdEpB/dbCW3yws46nrswfq+5D0SSAkAE8YiamcLRL2gKqz6HoRrVRwjZWIfymn3k6MqU/Ru1Lk6FbW4R+jGV7xKzaJ55aQbobC20zvznxONuD8LTT5Li90copFaXUoRLqV75XBN/tuZIUd67tRD4uU3TEkW7B9Q5kBUGq+TOhpI7nYMeLb1wqOEsxV6ndjo+bN2m1cBx9All7v6c2aRHqobpl2fOY01H/HvNFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zujfAcUhmtizPK/ZnZu93fvANGT10YSJxmBJ9X7UFs=;
 b=HEduFlpSQp29CcbSo3fKP4Er/EkLNcb7zBV+gpuyrSFw/PdInPgXI8Q+km6XS0Z3C0Uf72HLrteYb8xbAgyq/Vf1SLcR5A3Jn/dB81buhE7FAhvKtcU+RN5x51fip9CHFqRFfhgJMnRKiyG8R+8iP4j4SpBJ7Z8JUUazmR+88qVkBG9pF/GxsZfjLdZeRhvznbvTAI1npPOLwQP3VFOXpaREgPEg6ecRHtuvNCpABjZB2GRT+dJY2tzstTCZWzzlXMqnTYlf2LuOP7mP+mE98+iZy47wx7mzzDEjl023Rp4HG4BVPuO4+f3apvfYiL5NPBRF8nZbv+Gox0TCij8nzQ==
Received: from CH2PR03CA0012.namprd03.prod.outlook.com (2603:10b6:610:59::22)
 by CH2PR12MB4972.namprd12.prod.outlook.com (2603:10b6:610:69::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 15:09:16 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::21) by CH2PR03CA0012.outlook.office365.com
 (2603:10b6:610:59::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34 via Frontend
 Transport; Wed, 6 Sep 2023 15:09:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 15:09:16 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 6 Sep 2023
 08:09:05 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 6 Sep 2023
 08:09:04 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Wed, 6 Sep
 2023 08:09:02 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Yanghang Liu <yanghliu@redhat.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH v3 3/6] migration: Move more initializations to migrate_init()
Date: Wed, 6 Sep 2023 18:08:50 +0300
Message-ID: <20230906150853.22176-4-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230906150853.22176-1-avihaih@nvidia.com>
References: <20230906150853.22176-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|CH2PR12MB4972:EE_
X-MS-Office365-Filtering-Correlation-Id: b98e03f7-7cfa-4cd5-e3c7-08dbaeeb3ccb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bH39jUp9IxTOg9Mb0AyNy/Q77ygdxtjLQ8gyK9WXwqum8+bsVzk1w0BM2R02sj5IXvIjQ7ylp10zagHQOZRjtYsmZ/VzYqc9Xeo+T1x631ZllkVMXvSHK3OCRNWXATpKzqR12fz1MVqneqjHBv8YM9D+LjkI3S7kYBi6P+v860AwlzxATL5vBtQiJwsWdJ1zifHhgp0MGri1IivUO2UXLc1eH15aEIBPwVlhJ8xFbDdU4PNBFxoGUNLYYyVS6X4eApIo1vIjEmlZ9NmRvJxYUjJdEbwUvdPekNVtrDMUpnZJvfE0eejX8D2J/2FAC+9dMBadbJhywwn30lpwnMTV9UZ0b8TFMC9iQBp5QMHYJPJVw4SaE3HUlOnCOP66tjdF4qOQ8MGpqcCYFtWaV+yICQDyk5oBstA/Mtx1CEZXxcMbzNOKf5T76ejULhTIW34BkqNE+DHUUX8eYgruM7tkS2miQVuWplg0oKt/CEqwzCwJTwtSw6JJQZsl7iP5qXUl63092xuZbXUtaVfCukDrHkMqMmUy5IJnDkkQL2nfdGfVqB+VFwhfWuj02TxnRKmncmQDqy6n7Eul4Bd5tiTj6uI5mSPvkg/vIf8GGGoC3fOHXNxqsgBl1b3uoFLyyjDPvujAFTdmVggbdBVSdKsEpUI0cPh9SEx4p2iPhA9L2DGGNvMx573eSe4DY6THBHBFIJRwdwcI+4GRNyVzaaPX1XmgQY84ApBw9N8Z9Nqh1uOcNgovJ5y80LwAUf2x2Bvl
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39860400002)(186009)(1800799009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(426003)(26005)(336012)(2906002)(36860700001)(83380400001)(8676002)(8936002)(2616005)(107886003)(7696005)(1076003)(47076005)(86362001)(36756003)(82740400003)(356005)(7636003)(478600001)(5660300002)(6666004)(40460700003)(4326008)(70206006)(70586007)(316002)(6916009)(54906003)(41300700001)(40480700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 15:09:16.1256 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b98e03f7-7cfa-4cd5-e3c7-08dbaeeb3ccb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4972
Received-SPF: softfail client-ip=2a01:111:f400:7e83::62e;
 envelope-from=avihaih@nvidia.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Initialization of mig_stats, compression_counters and VFIO bytes
transferred is hard-coded in migration code path and snapshot code path.

Make the code cleaner by initializing them in migrate_init().

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/migration.c | 14 +++++++-------
 migration/savevm.c    |  3 ---
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 92866a8f49..ce01a3ba6a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1425,6 +1425,13 @@ void migrate_init(MigrationState *s)
     s->iteration_initial_bytes = 0;
     s->threshold_size = 0;
     s->switchover_acked = false;
+    /*
+     * set mig_stats compression_counters memory to zero for a
+     * new migration
+     */
+    memset(&mig_stats, 0, sizeof(mig_stats));
+    memset(&compression_counters, 0, sizeof(compression_counters));
+    migration_reset_vfio_bytes_transferred();
 }
 
 int migrate_add_blocker_internal(Error *reason, Error **errp)
@@ -1635,13 +1642,6 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
     }
 
     migrate_init(s);
-    /*
-     * set mig_stats compression_counters memory to zero for a
-     * new migration
-     */
-    memset(&mig_stats, 0, sizeof(mig_stats));
-    memset(&compression_counters, 0, sizeof(compression_counters));
-    migration_reset_vfio_bytes_transferred();
 
     return true;
 }
diff --git a/migration/savevm.c b/migration/savevm.c
index 5bf8b59a7d..e14efeced0 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1620,9 +1620,6 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
     }
 
     migrate_init(ms);
-    memset(&mig_stats, 0, sizeof(mig_stats));
-    memset(&compression_counters, 0, sizeof(compression_counters));
-    migration_reset_vfio_bytes_transferred();
     ms->to_dst_file = f;
 
     qemu_mutex_unlock_iothread();
-- 
2.26.3


