Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EDE70AE7C
	for <lists+qemu-devel@lfdr.de>; Sun, 21 May 2023 17:19:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0kpU-00086Z-1a; Sun, 21 May 2023 11:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q0kpR-00085s-Qe
 for qemu-devel@nongnu.org; Sun, 21 May 2023 11:18:37 -0400
Received: from mail-bn7nam10on20603.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::603]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q0kpP-0000Bh-MN
 for qemu-devel@nongnu.org; Sun, 21 May 2023 11:18:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7QLuwOu9C3RRtOwEB8cLveEIhHTiZZGuupVBP2o4p6Xn1t+abRqC5P9j4sPeihHdjiCtqYCK7aubLslPuipCm964eU+F4bO8DNZ7a3RBoFpimyhfOCWv/xIQrRwOhgI0ue4RDj8m8XCTHcwkF6SKKL23L1n8wdYA9sB4h9Ib/cADFCXHn8JbNzxEwDcaU7QMDCS2r9lGZDJgcMnGfgZN/Eu6ahmLsK8CXuIFcyh63C3rHRCKmtskj01MZW03GowYH9Y7+pw+uk55GHQndpDFiY7NC5O5s5vMNdUPALIVlnLFPCaXPu0YRsnyiQMuN5IYg062zryicfZSsstO1cIfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkm+jgXxlmHFtLLzLKY4CfVYNzvWfRmaZgd+4KiuPvo=;
 b=MvMe1NaD0oJsua7Cfh9LmQDZ/ezeGsocol4ysqk0XTFBWFLMwLqvC8HCUBlvkjv3bUHb6vmwI000MoofE60eoQF8X+1SQIsF+/HaM2nFfKHzBhOeil7WzwJilscwtowConAar/ovLPaZ95jTLz0MihmPrssIv+LizHaIERRVJo2UpXwrckp72SVCqJBnOO82tpLK7JJCrIhvKQzT71MOm2TB7rEzNXa1jrbHjOESy9wou/na2rZY51QzswSG712p0iKMhEDi+0UiNSPbZoDArcqmU+9Z80exhj7Zc4RYtfmHRuiIGKSZir0GyC6UuITJZ9MNRCa6YUtPLGNIHdCcZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkm+jgXxlmHFtLLzLKY4CfVYNzvWfRmaZgd+4KiuPvo=;
 b=RpmHSP9UwTSZpsXzp6e3EpC087UsYBfnNMVgqinjAPpWhPwns+yviRO2kGVvdJV2vWjCmUuIMnVdJYmomijSp0esJHGDmtU4w9s5lLBujZEiA4qXTxfTQqr9cCR1xIQJXB+H3HQ5u7+gSrOgTKkzcq10KUl/OCL9jqIzn/q20N3bkWLutqupOZp6ljhCNyw7BKX4rNs+69Ts/ZQks88koxoPK40A9Fn4IKpAWkH5K+2hfgfpCnJDE7odPMcGo8d4ZgW7iH6PCuLNvb19D5xULg04Az9Ca5WOBKowor1P/7/hnfZdSNu7MGXhiPKhC8WVi1CFTJmFXglyvkGgP/lQbg==
Received: from DS7PR03CA0345.namprd03.prod.outlook.com (2603:10b6:8:55::29) by
 PH7PR12MB5736.namprd12.prod.outlook.com (2603:10b6:510:1e3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27; Sun, 21 May
 2023 15:18:32 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::93) by DS7PR03CA0345.outlook.office365.com
 (2603:10b6:8:55::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27 via Frontend
 Transport; Sun, 21 May 2023 15:18:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.27 via Frontend Transport; Sun, 21 May 2023 15:18:31 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 21 May 2023
 08:18:20 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 21 May
 2023 08:18:20 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Sun, 21 May
 2023 08:18:15 -0700
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
Subject: [PATCH v3 1/7] migration: Add switchover ack capability
Date: Sun, 21 May 2023 18:18:02 +0300
Message-ID: <20230521151808.24804-2-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230521151808.24804-1-avihaih@nvidia.com>
References: <20230521151808.24804-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT063:EE_|PH7PR12MB5736:EE_
X-MS-Office365-Filtering-Correlation-Id: f9733fa4-873a-49ce-d57f-08db5a0ea35a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZOZyB1GFTasy9f4jnWJSqDyVOlWKoZ15oIsURSp9tnwT2WwhcYMFKk5obdqbMGOIUg7OGXZHj/qpaFSDAgP81opYcLWJGlK0NGNnVMyZk3Cpcl3AAk2eOJAaLh4ybhKor4H3coJMVbg16n8yH4jLlHVaRF8jYMRdfA9cRseQIz+jIEEbq1qHeT0cfH52sJU5hT41TUAIp1nwH1DEqGAZNrPNURZDsrkLbhBP1DyT19mUz0Qv5199zQPzBqmkbduRSAPvqhPxT47ws5teiulZYHwB583h/iexECZOlwWkY68eMitiadPVOCneFqF4yiIUN8kREpsndozCBx46fXaIp1jIRAT/Wu97YzgJzCQwZmaePJNbf13fuWAfKD2JYQNAiRwv+zhrqXO57bZtcQXmVmeg4yFi6B6yFAdYaYQkvKDskm7Xcn5RXnXoEbsdZywzxuiyY1CxEFpkzllsFEa+2kVhH2m2dG190b0x5nP73kKqIptwLDcYFyhMUoCeNSXQOL9f7mqQKxxa1Xx9zzfzsCY5WRvbo33mIQTzQuQpweT1n6kuXfds8MRCBaTwLcEH5n3Jz/K6ql0arV+NXIfTcpctx0LZfffs7GcNOdipbx6GApuE23oDnUYkqgMeolEkYd19EnjOXYBK7AecM7y0lZPnf/EcscplakCDpM3w90JNVu95Ov4boIB1brE+2zhDiqC7+jA0txDMURI6cQvU7jwQcmbM3IaQAdnnTRovI/AT2uZcc2vT3NgoDJFf50MU
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(316002)(54906003)(4326008)(6916009)(7636003)(70206006)(70586007)(82740400003)(356005)(41300700001)(7696005)(82310400005)(6666004)(478600001)(86362001)(8676002)(40460700003)(5660300002)(8936002)(186003)(40480700001)(7416002)(1076003)(26005)(36756003)(336012)(426003)(36860700001)(83380400001)(2616005)(2906002)(47076005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2023 15:18:31.8332 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9733fa4-873a-49ce-d57f-08db5a0ea35a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5736
Received-SPF: softfail client-ip=2a01:111:f400:7e8a::603;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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
migration users. For example, loading the data of a VFIO device in the
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


