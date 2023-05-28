Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4F97139DF
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 16:08:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3H3P-00011Y-3L; Sun, 28 May 2023 10:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q3H3M-00011B-Ji
 for qemu-devel@nongnu.org; Sun, 28 May 2023 10:07:24 -0400
Received: from mail-mw2nam12on20602.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::602]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q3H3J-0002f4-Aj
 for qemu-devel@nongnu.org; Sun, 28 May 2023 10:07:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XN/jFZBz72/X/VboUeXDrJNRtpjIupePCxcCH8B3D0Kf2EgeSWRlwTQOp5Jt6e53Bu/X4/AbzJ3kVreXpCiuCOxjw33gIU8zmCkpFoXQw8ydpeAOGumfDd4qikpy48Ia61BAByW9BPF7pn9NSDzrxLvjJzb+unSMV0TSDTe4ifQp4r95Sf3sI9nFuvx0WN4KgZgIsuFaG71uP7suSAXsJZ0kYYDRoN2TSeu6obo4t6uY3O5d7yxIzdRdrmHv7AQ1w35xbKy2sn6eF1ptNMiqLlNJfq1c3cHvmHzg9QEJJYRw84N1sHZsHR4W+p/X26iWoC7iERCraRXUg47No4Od+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/fR/Eo4iI9NOC9O6X9QzwGE4haTxTYTv6T53TiKDIk=;
 b=Iw/4Q9Ctt/LofBlwKy/jIB19IGTbnCXlK1z4+yLVT82M8nsRoTkt67nN2ivvNry7gp2tUqObRRBgJOJN2v43iECSlnZsF53dAwDlQkI5QVTI3CuJfzDUh0o52kdp8f1+YxFtfB0MPe+4p66x+LiJPg9ps5IOuMQEaSALhu8Puw65Q2DidRMIoY1ugxMptYGbglqe7kVPMYSMM3MVWeNC8S2+dZT4CP33JhLOuteUP23I9KrWfyeNyCgQKOPT9HMUc9eutwo5X7/THt2P1LSsqwY2h5JM+ziC3rhoZw2KImWF0kJTjUJHaR4ds4kL83En2sGcg4kDnK3qw+HuZE76dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/fR/Eo4iI9NOC9O6X9QzwGE4haTxTYTv6T53TiKDIk=;
 b=DOml+CBudnzMHzmaISajOURgsaCVAOSLJPeSkxRLBgmgdzhGpJwbe3PHNFgksrckRzOkcPmEcp7vpq0T8K6YS/eHDMHU30jBpNyFSO1mB2bKlGRjUcpo9NPgPaNNV6FoV8yOSVwY+O3Uv18KIqE+TnatNHzambny9hWXiCuZweWMIIIbk5oUIxVIpROsqI4NwBUUDaXIBxrUzSyyy6WhTY3qLhYKVj8L2LFRSHTU0yskOYK84q2FfJtjW/CrjBEyqmfKpKKaJcFeefDcKp0KWGjFBw2lmH/IFoJGws7+rFxzsVugk6P3IaSFKmowadSJXNGXy5Xw5c4V1XrNZQyxPA==
Received: from BN9PR03CA0708.namprd03.prod.outlook.com (2603:10b6:408:ef::23)
 by MW4PR12MB7118.namprd12.prod.outlook.com (2603:10b6:303:213::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.21; Sun, 28 May
 2023 14:07:15 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ef:cafe::62) by BN9PR03CA0708.outlook.office365.com
 (2603:10b6:408:ef::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.21 via Frontend
 Transport; Sun, 28 May 2023 14:07:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.18 via Frontend Transport; Sun, 28 May 2023 14:07:15 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 28 May 2023
 07:07:05 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 28 May
 2023 07:07:04 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Sun, 28 May
 2023 07:06:59 -0700
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
Subject: [PATCH v4 1/9] migration: Add switchover ack capability
Date: Sun, 28 May 2023 17:06:44 +0300
Message-ID: <20230528140652.8693-2-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230528140652.8693-1-avihaih@nvidia.com>
References: <20230528140652.8693-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT045:EE_|MW4PR12MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: b6378db4-bbcc-46f0-5600-08db5f84d74f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KIQ9QwNbyf/bU8+KgoiPDzfT/cX/DAQAkQ86Mv82SYCmp+QiIJpAIEHbjGwmQQwuC8pdUgLAo/48T/CHqMBm8S0In2rPQgkfad0r4zhVlTiVMEWH8Z3yWTfRH0QXL5qQPh9fGTFQWX5me2rO4QMJFTKbZn1OCSl9jxheDEFJTT+rOY29tiaejHnKs8YFScHM2jK4JyxnF/3R/ykoOsgM600QBbcd6CjpU8dCDuHt3WjmWzbLr2uSLboHzGlrDwUXxLGjsmMLmjmi2qz7yjWmfMRKCX7NQOpYh49c4d252ixCxTLeMHVMsbvQ6Jk7zKI+vKTxL/cuB/XqD/hQYnPgXlI2fKy/7UjafuQI138bLCwoLuSGZynmOUHLyKEVnIdRKNG6z64gmi4EXqbcFyoKFJTvh9VAVH8wmREzmBdDY7+HMJ0b+utY/7xEyOBqjzVOzoqyR0Wb6W311crk60tvjeDiUh11tMt/MtfJiC6/i7gfum1g0e+SJajuQLmT1Km+68MZAV0I2gWvr6tHRDTVlaejji131J/FXaJ8CJTaRrADLV8pe1SerNg0zIvDIK6yvmNKALkx5gxMLhWlKBTe+MGuxqNLCq2mbV0EQ8nzlsbKUkA+vWdUlXumiT6XyBgQ8MpKsWsXWn7RQ6ivZlsp6jA9AtxOFe+YQsN1DAgs3q1Opdm0fJP4QnRQC2FltIjbc/RJxcSy5zsSwfASrJz5iXUKEI06SghcyUGp5CrSx2JlImg+iU+LzgFVTEBpv4z6
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199021)(40470700004)(36840700001)(46966006)(54906003)(478600001)(40460700003)(5660300002)(8936002)(8676002)(7416002)(36756003)(86362001)(2906002)(82310400005)(70206006)(70586007)(4326008)(356005)(6916009)(82740400003)(316002)(7636003)(40480700001)(186003)(41300700001)(2616005)(426003)(336012)(1076003)(26005)(47076005)(36860700001)(7696005)(6666004)(83380400001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2023 14:07:15.3804 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6378db4-bbcc-46f0-5600-08db5f84d74f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7118
Received-SPF: softfail client-ip=2a01:111:f400:fe5a::602;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.164,
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


