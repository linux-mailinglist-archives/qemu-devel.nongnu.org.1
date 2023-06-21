Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E506738235
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 13:13:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBvlI-0007IN-Aq; Wed, 21 Jun 2023 07:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qBvlE-0007Hk-OM
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:12:30 -0400
Received: from mail-dm6nam10on2061a.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::61a]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qBvlB-0002UO-Iy
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:12:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZHvstqH0yPSTgamn3zMWjZvp+3dCtWdKd4s72O1/qxzlw9X7JE09XaIHvO177fUVhu/nO6JB/8CjzLG5x/YvqXQQlTOhQBlvw0u/s5RCTzKuICh5IGV16Htb2FBK6x3IOydYAz5LxtXCsKnLopOXI0OZojmZI3UhIpyt6Nnq1WbCuE4ctlkwAnaM9ImPAAwSj0mZvZfM5UlvC4+36W0BxGXauQOPXfWr8jLgwVsaaPrS7hDetfNQo9F6KWf7mVVDskwjaG+O+SFm49K6fHyZZDw6F8tEV8hok8LrvgPdH49cPoRiVA0zAADUeuObL7jalOtrAVGMT2WXUnuphtAsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtmNao+Ts2PBgxw4CivpKVU9TEzIOEAaDK3Qsww19p0=;
 b=e7Tn6vh3Z1pVWEw+CWQ5UTZZVK3VvLi9TDw6bvL+OZgLAuGvpAu0Gv/bS8dBnP8v0tHZdTbpMsTdzNnsRNFij09ZspgbmHlNJPZ4DSDm32dXxW6kAIhMm9Jd95pTCXlXgx3z4TEZrrJxlqiOjGzils09l6xug72IjMnbP5UQ+WRIEC0IdzZmnMTuQLtHoDVMSEP0OBncgeqT1CPJn8z9d2MmlcYfdR9kLVKUM01/6V34qg+5u6HvA5ipe7YMZMs7VfUNDmyRhHKvBlrxazmlN+9lB87UfyUoBbIJf4DpWDxZ9ELANiuwXTpKN6d5W0oghS8rSfiPln51t3IlXUq6TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtmNao+Ts2PBgxw4CivpKVU9TEzIOEAaDK3Qsww19p0=;
 b=UoxyxuWECzkGnmVyjAmP/SeThcrI3q+QOeMiZnPL0dU437iV/VvTETJn4jPkcOSCIyp5qg9taDhfNh06Esspo5XUXO51M8slzdmaNJySxd35L9VogH9W2vKNcpXX7yYOEDmHz2zA8R5m+I1STaRqVDiDOP1MjSglsD3fic9BQbLpsrXxSeO+rOMRJBKeVk+/iEBnFEywpFc2nzAglgLBJ4thi5Hn1Pw2lc5fJ36TCRkXuhL+0nGc4FNRTCXjcXI1fXDtCbh3DdmJ0PlEt1WnAC8LqGfGP8FmcewygysueJucQIWQUnl5ClaL1d4pe/V0WBCc2/qHZecK0tU8utLHrg==
Received: from CY5PR19CA0108.namprd19.prod.outlook.com (2603:10b6:930:83::27)
 by MN2PR12MB4271.namprd12.prod.outlook.com (2603:10b6:208:1d7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 11:12:21 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:930:83:cafe::45) by CY5PR19CA0108.outlook.office365.com
 (2603:10b6:930:83::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23 via Frontend
 Transport; Wed, 21 Jun 2023 11:12:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.21 via Frontend Transport; Wed, 21 Jun 2023 11:12:20 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 21 Jun 2023
 04:12:11 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 21 Jun
 2023 04:12:11 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Wed, 21 Jun
 2023 04:12:07 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Yishai Hadas
 <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb
 <maorg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>, Joao Martins
 <joao.m.martins@oracle.com>
Subject: [PATCH v6 1/8] migration: Add switchover ack capability
Date: Wed, 21 Jun 2023 14:11:54 +0300
Message-ID: <20230621111201.29729-2-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230621111201.29729-1-avihaih@nvidia.com>
References: <20230621111201.29729-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|MN2PR12MB4271:EE_
X-MS-Office365-Filtering-Correlation-Id: 83012599-3131-41b1-91de-08db724861f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lI4dtONyois8f2UsnKsN7d4j0dAkNZ/KXKyXP24BdKeTP5872nLGkVlzC4NfVlD1WjMS8DGW0hv2tloL/bMGZUCAsiL5ZbBdyzDVUu/pNKGJTwVYMDO71gd50Lu6ZjxEMqQ3nhbTfaX2s/EGJSiKv4YGhjalYBzxR+HQQIA1XRjz53n0Z0+53RYku+TjkVYvnyPWZEjWwM+8QFPL59IkspoYYjBt8ZJNmTVzQJMY8tZbWeerBqs445iLrzjJnlqma/fv30w/OLQwT16CKopG2fK9YcYQPls0KSzQ9JF/RMwk6Dwcj3rdi/g1Bon0eNnWSIgsr2S3OUZnaTsDzdmi/pa2E8O4L0kCB1z2dfhdYQ+LMv8cWcvB5eodaQpKEJl/yCWOiJN+HJ292ztbgb3h8aLEzXZ5Hlibh2texe+hfZcNmaMAJM5uic1LSoRkY29VNYcZmWYaakpzdqFjSntQvcVo15u3xCF4bKFAJekqdaDEm5ura8b4rrBtkJAgTEDw67lVbc09A1/tGyxkXtZgalDMqfTxviU1dAX1ocxmMIxQauZdwmrn4o4vOn3MjsjZUlbQa2+WrRlPies1kU8X1IQa1UGf8MNHOZWuDNqhwMlokDtL/cjfRcNWSmEz7LvTsNG50FjjYB1TrSagOLtESoy6r2BxuqfEnr13CqtnZpfBjTy1rqClKR3eQ3KMR5SS1z5RyLKEZREg5qkoMavC27cbcEp2jzgfe80j3sAtRij4gTkIIE2bQgG/zw8vCYiJ
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199021)(46966006)(40470700004)(36840700001)(54906003)(478600001)(7696005)(6666004)(70206006)(70586007)(1076003)(26005)(186003)(2906002)(82310400005)(41300700001)(4326008)(316002)(6916009)(7416002)(5660300002)(8936002)(8676002)(7636003)(356005)(82740400003)(40460700003)(86362001)(36756003)(47076005)(83380400001)(2616005)(36860700001)(40480700001)(426003)(336012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 11:12:20.8018 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83012599-3131-41b1-91de-08db724861f0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4271
Received-SPF: softfail client-ip=2a01:111:f400:7e88::61a;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Tested-by: YangHang Liu <yanghliu@redhat.com>
---
 qapi/migration.json | 12 +++++++++++-
 migration/options.h |  1 +
 migration/options.c | 21 +++++++++++++++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 5bb5ab82a0..47dfef0278 100644
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


