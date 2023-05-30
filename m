Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4527A7164FF
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 16:49:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q40eu-0002O0-W8; Tue, 30 May 2023 10:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q40ec-00025e-FJ
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:48:55 -0400
Received: from mail-dm6nam11on20617.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::617]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q40eY-0007ns-CG
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:48:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YuJvVbSjc6oZAKfoRNtKTLZkrLLLff2XQcQ3ySKG+8j1tmzdCC144wk5iGKfkWTxZwt29VF32DFq8MG/hM/4Nj5mi9BZR/SXFA8TLUsMXXME2zJbyELQzJyfzGyZoEaM5Ydl92L1fcAEtrsJxXT/HZ6wzbaTjUaY/6IdMiDbOHJAIuTU9XZNEXnyPPXqXGpQSyCSe42e66e4OvoZdeW9mToozhHzkhqygbtd9ekKyRBt9fTMo+6cOpqGAwAb2kz3PaNAz+J0NVWUDpb+WjV7TZw7rIlus1LSTdwUd424Qf6rHkKWcI4so5E+kLI4fkhkLFjuVWh/szebmiqJagXfEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/fR/Eo4iI9NOC9O6X9QzwGE4haTxTYTv6T53TiKDIk=;
 b=f1J5w0DvxRe+hbsm4c5k4zD0CCR9sK5GQGi8pWLzlguO//o60XdtE5Iht7Co+JpBj05QkhjkeSTRb95X5p/CSBjTiQHliPAXZA/Xp1OTP7iFq1IStLUgeSxT+FEsx+IqHdEv3w2u2LeXaqowYqRV6vUlLYxGhUrLmiMl0E+wKyR7SJKHYp9dZfu3sV0x7b0eq8L4d3CAKTcbOhyXA6dXO/3sD19EuCvH2BOGD5Aaq4zE1I67SkmGxpYLvdiFXgbiJOjDvioghUHRucjLuNMENfGT0MWGBp27LPOEhjSBXIR3YF3l9qWqxzH4jVDITnOi6rX00mCsr5tpS3jY2dWx1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/fR/Eo4iI9NOC9O6X9QzwGE4haTxTYTv6T53TiKDIk=;
 b=YTplwNoY3bq4ilFWJO5HOxFElu8nUPG6usRsZ7moScqfTWMz38uzOkyk79GHjyf3Hh0EkhNpHV/K+pCGJ+2c9gEUVwbeftZo+emc+iWTvWulOb/1z7OMfswp4qkbMcjpFH60KfXMChlJIsJAMTRpaCBJdBZADvIOZC076we250IJQQ3SJrRjG6mp8ntWugE2veSihQd+L0lKzvOadDjcsuVGSqb0/+LGomLLE6MhMgqAuqRJX30ho+jYWbOMejoEsnYu/ILdeuGmTFUx5JrnsAKaMhbz+ARLrB05ct8RwSv4ea2MHPBdH87UuSaJTdqIcNx8P4VjSvm6ER83DWy97A==
Received: from MW4PR03CA0063.namprd03.prod.outlook.com (2603:10b6:303:b6::8)
 by MN2PR12MB4438.namprd12.prod.outlook.com (2603:10b6:208:267::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 14:48:46 +0000
Received: from CO1NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::c6) by MW4PR03CA0063.outlook.office365.com
 (2603:10b6:303:b6::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Tue, 30 May 2023 14:48:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT098.mail.protection.outlook.com (10.13.174.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.22 via Frontend Transport; Tue, 30 May 2023 14:48:45 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 30 May 2023
 07:48:33 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 30 May
 2023 07:48:33 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Tue, 30 May
 2023 07:48:28 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, Juan Quintela <quintela@redhat.com>, Peter Xu
 <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Avihai Horon
 <avihaih@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta
 <targupta@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v5 1/9] migration: Add switchover ack capability
Date: Tue, 30 May 2023 17:48:13 +0300
Message-ID: <20230530144821.1557-2-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230530144821.1557-1-avihaih@nvidia.com>
References: <20230530144821.1557-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT098:EE_|MN2PR12MB4438:EE_
X-MS-Office365-Filtering-Correlation-Id: b1a136d4-d791-4250-d51d-08db611cf85e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DZIu9MG9O1gHnt+CmExV9iciE0IzphdHk3n7lyLjldrGQelWJWQv2X/nebDi3l7QFs3DQ8jbZRzroGAx5yco04pEWXDwjqgcFPflu3OPeAlfxJVV9D7WfEU/NzrtuX1H9GwmrUx2TKv1O6J9EhS7lcDOCfKAuiErepOHvh9K/4o5WQFYR+Ln0JhnadYn7LhvMGVAFVTY31dKrsMHuaM5196JX00JsW1/JwGyNhCkFceDCUVeqvaveyXlH+Pk+NbTiT6we+cKxgwjmA7inMhSR+G7jriJzJ1abT5/uvHjbFx6rJlGFoxig86NSarFcVgUjzwbajMCYgqHu9M2xgZChaICY5wK08R7amRQRhfcFG8SlRwA+0pJDEMqc/8Y3MMl3/aCJwtJ0R9Y/ofARcl/PVQqc3eqmNled+7N+acu+r3vYXd/NUPt5C1ob57ft3qo5BMz9lfJ+ViAOjSBSzs5GjfTYInfVTu5ZPqS+qBfzqZ54r4JMOdohmGKdALSa0HGsuZYmL8rNJFpil/OMHndgTKfDFsshOB0oZ9XxllnXB3Uiv5HFUMV4bo7ORNBA7BAKU4lc/lrgLekW4aM4NEVSUAe2dzb+v7EXEBQLkvDUIi1BnsfD5peq7ZXlwK4c5xkBfyjyTD2/XKK3O02FWRc2fK5i00ree8LvTr/DsUGK7vnfg9YM/I7UQ9wdnd1sCtWANVcziZJmQkA67/sxu09rOHO1xq5ZLrx4ZsFZJ39hM4wy4Y9H6i0NlYZBZAwhteC
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199021)(46966006)(40470700004)(36840700001)(186003)(2906002)(2616005)(54906003)(478600001)(426003)(336012)(26005)(1076003)(47076005)(83380400001)(86362001)(40460700003)(36860700001)(7696005)(356005)(7636003)(8936002)(8676002)(82740400003)(41300700001)(40480700001)(70586007)(5660300002)(70206006)(36756003)(6666004)(316002)(82310400005)(7416002)(4326008)(6916009);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 14:48:45.5906 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a136d4-d791-4250-d51d-08db611cf85e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4438
Received-SPF: softfail client-ip=2a01:111:f400:7eaa::617;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
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

Migration downtime estimation is calculated based on bandwidth and
remaining migration data. This assumes that loading of migration data in
the destination takes a negligible amount of time and that downtime
depends only on network speed.

While this may be true for RAM, it's not necessarily true for other
migrated devices. For example, loading the data of a VFIO device in the
destination might require from the device to allocate resources, prepare
internal data structures and so on. These operations can take a
significant amount of time which can increase migration downtime.

This patch adds a new capability "switchover ack" that prevents the
source from stopping the VM and completing the migration until an ACK
is received from the destination that it's OK to do so.

This can be used by migrated devices in various ways to reduce downtime.
For example, a device can send initial precopy metadata to pre-allocate
resources in the destination and use this capability to make sure that
the pre-allocation is completed before the source VM is stopped, so it
will have full effect.

This new capability relies on the return path capability to communicate
from the destination back to the source.

The actual implementation of the capability will be added in the
following patches.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/migration.json | 12 +++++++++++-
 migration/options.h |  1 +
 migration/options.c | 21 +++++++++++++++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 179af0c4d8..061ea512e0 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -487,6 +487,16 @@
 #     and should not affect the correctness of postcopy migration.
 #     (since 7.1)
 #
+# @switchover-ack: If enabled, migration will not stop the source VM
+#     and complete the migration until an ACK is received from the
+#     destination that it's OK to do so.  Exactly when this ACK is
+#     sent depends on the migrated devices that use this feature.
+#     For example, a device can use it to make sure some of its data
+#     is sent and loaded in the destination before doing switchover.
+#     This can reduce downtime if devices that support this capability
+#     are present.  'return-path' capability must be enabled to use
+#     it.  (since 8.1)
+#
 # Features:
 #
 # @unstable: Members @x-colo and @x-ignore-shared are experimental.
@@ -502,7 +512,7 @@
            'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate',
            { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
            'validate-uuid', 'background-snapshot',
-           'zero-copy-send', 'postcopy-preempt'] }
+           'zero-copy-send', 'postcopy-preempt', 'switchover-ack'] }
 
 ##
 # @MigrationCapabilityStatus:
diff --git a/migration/options.h b/migration/options.h
index 45991af3c2..9aaf363322 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -40,6 +40,7 @@ bool migrate_postcopy_ram(void);
 bool migrate_rdma_pin_all(void);
 bool migrate_release_ram(void);
 bool migrate_return_path(void);
+bool migrate_switchover_ack(void);
 bool migrate_validate_uuid(void);
 bool migrate_xbzrle(void);
 bool migrate_zero_blocks(void);
diff --git a/migration/options.c b/migration/options.c
index b62ab30cd5..16007afca6 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -185,6 +185,8 @@ Property migration_properties[] = {
     DEFINE_PROP_MIG_CAP("x-zero-copy-send",
             MIGRATION_CAPABILITY_ZERO_COPY_SEND),
 #endif
+    DEFINE_PROP_MIG_CAP("x-switchover-ack",
+                        MIGRATION_CAPABILITY_SWITCHOVER_ACK),
 
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -308,6 +310,13 @@ bool migrate_return_path(void)
     return s->capabilities[MIGRATION_CAPABILITY_RETURN_PATH];
 }
 
+bool migrate_switchover_ack(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->capabilities[MIGRATION_CAPABILITY_SWITCHOVER_ACK];
+}
+
 bool migrate_validate_uuid(void)
 {
     MigrationState *s = migrate_get_current();
@@ -547,6 +556,18 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
         }
     }
 
+    if (new_caps[MIGRATION_CAPABILITY_SWITCHOVER_ACK]) {
+        if (!new_caps[MIGRATION_CAPABILITY_RETURN_PATH]) {
+            error_setg(errp, "Capability 'switchover-ack' requires capability "
+                             "'return-path'");
+            return false;
+        }
+
+        /* Disable this capability until it's implemented */
+        error_setg(errp, "'switchover-ack' is not implemented yet");
+        return false;
+    }
+
     return true;
 }
 
-- 
2.26.3


