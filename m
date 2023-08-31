Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9892278EE23
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:09:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhHx-0007QC-PV; Thu, 31 Aug 2023 09:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qbhEt-0002lT-GR
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:57:37 -0400
Received: from mail-mw2nam12on20627.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::627]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qbhEm-0005F8-ME
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:57:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmQCTrgrB7LXaCsnSanaUq6swmP6AJFSgxU5NcgA2+RBrwh7G91kUd78ggji4bRBz9Nuj/73qGIkAXvGvuJJfG4ldEGX6xWsmSfh0SkuVh/xuruoqJ9Un3hlrbMeVo5o8J7zCw5gyDtE/dpaYR2aEnNYPZ8m6GCF6Hr7mm3a4qwGf0V2kuhY7UUGhOU1EZSIFEi8J8Qjk+0/toBy71aGoJXRf0Gar3/IT/duP8f5kUefhFH0wdIsBPXAvSyHQSvsWPOD7K43nYTz7jtFepFmhFIiYc4ENiFD0wvXwFhZZWYQzUSIZ4vGc9D1X9ZOYwltGfqIOZGFqDcjSHm5dAVgkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Ldz+kjyX5eCV58RPUVlmaZFVKCK91xCjZqK9I1y1jo=;
 b=OlEJ5DDTjxoE7IS6tQTu8rLxqEzt+XdeIP4qrD+A7LXYCZVv7UzO4shtv3g/cHY7LoGnT6efRt7o5AzyhZwsmjXeiKg0mtSd3stU7kHXAFmi6ODZlvU9/QiO8p/GLaXWKJZx/lFVb/aQsewgP4jnXTD5oSrHQLgEaKysj2cLjtilBS2QrG5VwNGkcxUT3AzIFfZ57Cka58lmy2jJzJ9Um+LBkpqIfx66X3BB9e/QSYMu4Cg7cMvlgmpVBmDH1rFdG1dG4aBO/dZ9kBVTZEpo6UwoHaa4qG0zLpxiIfWrgv2/BjzWGtcmz5H0al4GH+SG0dzCLG1lgUCub1zOqdEHQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ldz+kjyX5eCV58RPUVlmaZFVKCK91xCjZqK9I1y1jo=;
 b=KfNAOJLoT4z35yh8dXCF5gGeTtqlmfc8V7i9bA6i7VTukiVMpU0xTl2Q02pfInKuSfWEBcSXTYwS2GSv4Dc2mIAZxVXToweSmmhiNl1bCGqEO7CFC8Jj9AC6zQhLtgkAcUYLopn0fmTUMbs3UeuMs+sOVauH9zwWIqMT8arBkjyUagkyL7qAW2vIVaMmV0HN68+Ju6Oo8O1LRy7xxk4zTRbnc8nizASWrCahlrWpe1yVKFWXYFTmHL0u/+XOG94gH/fjFl65QgpYVNv8codavOxc7Ejo6kBZLIUlJNwAzBBSWeHJOVdAE5dI1l4jr3QiAHw8SmTFo4oIEqbqH73oWg==
Received: from MW4PR04CA0112.namprd04.prod.outlook.com (2603:10b6:303:83::27)
 by DM4PR12MB8452.namprd12.prod.outlook.com (2603:10b6:8:184::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18; Thu, 31 Aug
 2023 12:57:24 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:303:83:cafe::98) by MW4PR04CA0112.outlook.office365.com
 (2603:10b6:303:83::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22 via Frontend
 Transport; Thu, 31 Aug 2023 12:57:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.2 via Frontend Transport; Thu, 31 Aug 2023 12:57:24 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 31 Aug 2023
 05:57:13 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 31 Aug
 2023 05:57:12 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Thu, 31 Aug
 2023 05:57:10 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Yanghang Liu <yanghliu@redhat.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH v2 3/5] migration: Add .save_prepare() handler to struct
 SaveVMHandlers
Date: Thu, 31 Aug 2023 15:57:00 +0300
Message-ID: <20230831125702.11263-4-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230831125702.11263-1-avihaih@nvidia.com>
References: <20230831125702.11263-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|DM4PR12MB8452:EE_
X-MS-Office365-Filtering-Correlation-Id: b08c8a93-b841-4d8c-ede2-08dbaa21d29a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MSGJg8OAMxdqse7TcBnVCd4FxjmD6Jbvqdd8TAgy2EDOYkzSj/MqtFFV0w3Y4m4CpxDfo94C7Iq8eV/eP7YUaKka4DYfP9XbIClOdoDlIjCh+hXGLPu0f31aOvZ21XoE1Ay3drraFbRCu3ronw2wLA77ZZ2srNt2pgsUWCAcpwt748UeAmBzKUoaZ4Mhu0aAZuzTSwyiGLl3kTQ7VLhZAV+WTU6zz8rCp4/jUzkRo5FVBpCgu4Df6VshH471+tRskuveaDHynoYiwvHiDWDzOUJyISksHkiTbD2CG1KiR+Svwo3m8abvolrQh+fxFeVqBfCAze7UabyjysrEclT5DI5+q3SSRGEfoCs0YyCfqUNb3fFbi1zbCVyB4U59vTLsI+Ay6MsypYJngNAdD39fApf10mVrWqJO5xUp0kbV/tGJgD5aC25vuZzFS22Rc/8IiMVYnBi3uqQE3z+jcnn+mvDIm5OSV7Ow5IpeTsDoSD/2Q7PupulKYWL01Y2DfMQfcphSBRAsTs9hB2DdzzppbAsR3yjwMe62Z04OEWbPESqpDhZXBvp0Oo+bMv0jXWgEZBK4bGqQ6MvQUqsoq4FPSVOjBkrYet7boEjpnKZweYvpNFNLwthVp01hHNFrit4Rp4rtw80XLRCYKOePWFOfQNozO0mE5ZiRLlhPD1fezwaivoP7jlauC87yP+XR1MiSQOt41Pd2kWw8auKJ7SB6/lF+uK2l4BVBRlGExbeAHAvWiJPzPYlMWcOrtKx75/PGGCU8UDduiMQ3gzrB+0gtBg==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199024)(82310400011)(1800799009)(186009)(46966006)(36840700001)(40470700004)(40460700003)(41300700001)(316002)(8676002)(4326008)(426003)(336012)(2616005)(2906002)(47076005)(86362001)(107886003)(5660300002)(83380400001)(36756003)(1076003)(26005)(36860700001)(6916009)(40480700001)(8936002)(6666004)(82740400003)(7636003)(356005)(7696005)(54906003)(478600001)(70586007)(70206006)(142923001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 12:57:24.6131 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b08c8a93-b841-4d8c-ede2-08dbaa21d29a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8452
Received-SPF: softfail client-ip=2a01:111:f400:fe5a::627;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 include/migration/register.h |  5 +++++
 migration/savevm.h           |  1 +
 migration/migration.c        |  4 ++++
 migration/savevm.c           | 29 +++++++++++++++++++++++++++++
 4 files changed, 39 insertions(+)

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
index 92866a8f49..914783f07b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1634,6 +1634,10 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
         migrate_set_block_incremental(true);
     }
 
+    if (qemu_savevm_state_prepare(errp)) {
+        return false;
+    }
+
     migrate_init(s);
     /*
      * set mig_stats compression_counters memory to zero for a
diff --git a/migration/savevm.c b/migration/savevm.c
index 5bf8b59a7d..818510ec57 100644
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
@@ -1619,6 +1643,11 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
         return -EINVAL;
     }
 
+    ret = qemu_savevm_state_prepare(errp);
+    if (ret) {
+        return ret;
+    }
+
     migrate_init(ms);
     memset(&mig_stats, 0, sizeof(mig_stats));
     memset(&compression_counters, 0, sizeof(compression_counters));
-- 
2.26.3


