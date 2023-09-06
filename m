Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7953793FFE
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 17:11:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdu9o-0004OX-6x; Wed, 06 Sep 2023 11:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qdu9k-0004ND-KY
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 11:09:24 -0400
Received: from mail-bn7nam10on20607.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::607]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qdu9h-0003je-Np
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 11:09:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVGvZDEGQrvA+CSM2qZtqb/s4S0QGIL1FSqsdEnYcchKImMQM9jAW3Xk9hLRtUpk71Vvh3XYlmxnWceuTykp29w03Azb534/GKltdKlIxyYqy95zZl9vuK8toHxmdK9x+WLsDq2q0OywSpOq+4cYtFVDfOyijX84IF9GK9zso465EPjm0oA8iDULg6VCCUuCvNgsJF2EO5sThvg9QUPEcANBno1dChHLB6cVKDUkWwhQDhT9HIMKxyK/up5N7Bi2YEXEYE6njLAYaEZk5Sgt+i0hd5ST326a5J3YlxJgAdYrKksjM50gN3qz+v43kHoc0mD/9wwVI5u7Yozjx+q5iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/inR6YLO3dR4ImFqntuajtor9zf3v6RZGrWHBEb4cY=;
 b=kMFyIyC76Pkihs+IUYaI0ksJOrMcjh8wD9Ak/LNxucr54ySukC7JFSlxyjqC9iafqaF9lxMZWN9GHVYFXx9zwbdoMXTUehejyNcBXiF00t5TSM9fOdGzYn7g0+lpyiC68EMFnnIMb+HhohyjCjAVEcKVAcSTp2qUp2zYEEUbiidGMN/9kBnu4EFtHHhdzrbHJjxO+fIIKk4GjOcD5AdGa7+Qa9oo5r7cEJDCpZbS8i4L87bQX2HD7KesM9G0mMZfcAuLuRRnYb2Y05wXY+Xt/pjJKU9WqJ5ZEYBZ96Tb/8MNjR6d2DzoF07fLUWujfNsLTrJ0XtI4caJ4SvZgk/xcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/inR6YLO3dR4ImFqntuajtor9zf3v6RZGrWHBEb4cY=;
 b=V6xeurfV3hYHZ2EbAqdrg9fw+INKtiMoRY+KbmqePxw0mIw7I60NA3rW5xFVkCXvV0wnPqRbJid5863cCrbbIxxWbOGVeNDyM23GsXEPpKxKIhfNBKaCm9+qLkSKeoyi1SJqKyD/qwDCHbxTrvEi+ZCZr0vCMlm5EUR7fls1XRo6zrWUMrzmhYBo4PCoksfQ3bT7mffZITzJn5ISAnUpDazdUz9mZ07tiJ81c7JXtRw4g8hh7GK7hWdVDvoy4lnLJij4hUX0pTYoZwPFgQKTT4CS2TZ7NyL2o1pIaSRfNjcUBMagX1rUD2I/zsIpsq0nkP0gIbQiI5g7tDrhDLYlpw==
Received: from DS7P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::30) by
 SJ2PR12MB8954.namprd12.prod.outlook.com (2603:10b6:a03:541::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.33; Wed, 6 Sep 2023 15:09:17 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:8:2e:cafe::5a) by DS7P222CA0002.outlook.office365.com
 (2603:10b6:8:2e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36 via Frontend
 Transport; Wed, 6 Sep 2023 15:09:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 15:09:17 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 6 Sep 2023
 08:09:07 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 6 Sep 2023
 08:09:07 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Wed, 6 Sep
 2023 08:09:05 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Yanghang Liu <yanghliu@redhat.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH v3 4/6] migration: Add .save_prepare() handler to struct
 SaveVMHandlers
Date: Wed, 6 Sep 2023 18:08:51 +0300
Message-ID: <20230906150853.22176-5-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230906150853.22176-1-avihaih@nvidia.com>
References: <20230906150853.22176-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|SJ2PR12MB8954:EE_
X-MS-Office365-Filtering-Correlation-Id: 8387acc2-48f9-44a1-9ce2-08dbaeeb3d8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JLsF1oWtHv9AacvGsn/okerewOed0qbLWdwu8fjYwvnKmsqwxV0GK45exunkXsDFlaUI7DQ8RYdITzLX0HYBONTj2lFI7GgJesr/3YaWg6nmLMTbklWic2XOA1NaCwO/AD5MHBeUwTXjeZ03wIRxw2zvbqcNeTN1865UaaaQfMXzoHfsLMlIEEnCDeKcQEGjSZHT51+X9H7NHL4hUfMcrxgBLeok6HCslqCw3tJJZEpIfvuEnfY47+CtQbkLaRuw9ycnStH/FwN3lL9GU9382Jg1Dr6lmy01yN6PdQbJPpBZ5ZEYoaXbqokVPlpTaSwxF7oOaA18bCddixVFdrxs9TdZEJJQyx8Sihxo8xpQCTuCfistY0OQKJqTcI/97M0IXAOZpdN6cFrTUWpXBM8kQ3TkV7mVAwYujl12aPw7cUl/UQ7SsRdoW3gOFCeGqEgauwEDFl3R/GEd3xfEt8UN35qiliqe09ifnk+jXDgECSQ3lU/6NXFmTZd0aFhuayUp7a+k726UdB3if/9cLAfwBApFEaBVkpIjA12BbMIrmIPnIHonrz35RDfagaExL8DFViSay5sng8yW/uic8pZjaim2HMz+aVR2pxTvPkgydeVvn+lT1Dl9IwtManf0OAhxSGDe7i6WM81nNRmia4oirmNEOgtw6hlzHdPeZ6Xyn753w1HBncaO79zZ87UW+Wxx8KeEd7X1QGvU3ujaz2NUxsgBs2G2wmbFaueDQLMmS1JkRLREGn+rAtyC/Q1rBWfu+GCMrXeZKbOrbay6F+mHbQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(186009)(82310400011)(451199024)(1800799009)(40470700004)(46966006)(36840700001)(36860700001)(40460700003)(47076005)(2906002)(66574015)(36756003)(86362001)(7636003)(40480700001)(356005)(82740400003)(41300700001)(7696005)(54906003)(107886003)(4326008)(70206006)(8936002)(70586007)(8676002)(2616005)(1076003)(6916009)(6666004)(478600001)(336012)(426003)(316002)(83380400001)(26005)(5660300002)(142923001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 15:09:17.4758 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8387acc2-48f9-44a1-9ce2-08dbaeeb3d8b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8954
Received-SPF: softfail client-ip=2a01:111:f400:7e8a::607;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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

Add a new .save_prepare() handler to struct SaveVMHandlers. This handler
is called early, even before migration starts, and can be used by
devices to perform early checks.

Refactor migrate_init() to be able to return errors and call
.save_prepare() from there.

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/migration/register.h |  5 +++++
 migration/migration.h        |  2 +-
 migration/savevm.h           |  1 +
 migration/migration.c        | 15 +++++++++++++--
 migration/savevm.c           | 29 ++++++++++++++++++++++++++++-
 5 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/include/migration/register.h b/include/migration/register.h
index 90914f32f5..2b12c6adec 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -20,6 +20,11 @@ typedef struct SaveVMHandlers {
     /* This runs inside the iothread lock.  */
     SaveStateHandler *save_state;
 
+    /*
+     * save_prepare is called early, even before migration starts, and can be
+     * used to perform early checks.
+     */
+    int (*save_prepare)(void *opaque, Error **errp);
     void (*save_cleanup)(void *opaque);
     int (*save_live_complete_postcopy)(QEMUFile *f, void *opaque);
     int (*save_live_complete_precopy)(QEMUFile *f, void *opaque);
diff --git a/migration/migration.h b/migration/migration.h
index c5695de214..c390500604 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -472,7 +472,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in);
 bool migration_is_setup_or_active(int state);
 bool migration_is_running(int state);
 
-void migrate_init(MigrationState *s);
+int migrate_init(MigrationState *s, Error **errp);
 bool migration_is_blocked(Error **errp);
 /* True if outgoing migration has entered postcopy phase */
 bool migration_in_postcopy(void);
diff --git a/migration/savevm.h b/migration/savevm.h
index e894bbc143..74669733dd 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -31,6 +31,7 @@
 
 bool qemu_savevm_state_blocked(Error **errp);
 void qemu_savevm_non_migratable_list(strList **reasons);
+int qemu_savevm_state_prepare(Error **errp);
 void qemu_savevm_state_setup(QEMUFile *f);
 bool qemu_savevm_state_guest_unplug_pending(void);
 int qemu_savevm_state_resume_prepare(MigrationState *s);
diff --git a/migration/migration.c b/migration/migration.c
index ce01a3ba6a..d61e572742 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1392,8 +1392,15 @@ bool migration_is_active(MigrationState *s)
             s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
 }
 
-void migrate_init(MigrationState *s)
+int migrate_init(MigrationState *s, Error **errp)
 {
+    int ret;
+
+    ret = qemu_savevm_state_prepare(errp);
+    if (ret) {
+        return ret;
+    }
+
     /*
      * Reinitialise all migration state, except
      * parameters/capabilities that the user set, and
@@ -1432,6 +1439,8 @@ void migrate_init(MigrationState *s)
     memset(&mig_stats, 0, sizeof(mig_stats));
     memset(&compression_counters, 0, sizeof(compression_counters));
     migration_reset_vfio_bytes_transferred();
+
+    return 0;
 }
 
 int migrate_add_blocker_internal(Error *reason, Error **errp)
@@ -1641,7 +1650,9 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
         migrate_set_block_incremental(true);
     }
 
-    migrate_init(s);
+    if (migrate_init(s, errp)) {
+        return false;
+    }
 
     return true;
 }
diff --git a/migration/savevm.c b/migration/savevm.c
index e14efeced0..bb3e99194c 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1233,6 +1233,30 @@ bool qemu_savevm_state_guest_unplug_pending(void)
     return false;
 }
 
+int qemu_savevm_state_prepare(Error **errp)
+{
+    SaveStateEntry *se;
+    int ret;
+
+    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+        if (!se->ops || !se->ops->save_prepare) {
+            continue;
+        }
+        if (se->ops->is_active) {
+            if (!se->ops->is_active(se->opaque)) {
+                continue;
+            }
+        }
+
+        ret = se->ops->save_prepare(se->opaque, errp);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
+    return 0;
+}
+
 void qemu_savevm_state_setup(QEMUFile *f)
 {
     MigrationState *ms = migrate_get_current();
@@ -1619,7 +1643,10 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
         return -EINVAL;
     }
 
-    migrate_init(ms);
+    ret = migrate_init(ms, errp);
+    if (ret) {
+        return ret;
+    }
     ms->to_dst_file = f;
 
     qemu_mutex_unlock_iothread();
-- 
2.26.3


