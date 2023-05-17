Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 222A0706D66
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 17:54:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzJSR-0003Jk-97; Wed, 17 May 2023 11:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1pzJSM-0003Hy-I3
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:52:50 -0400
Received: from mail-mw2nam10on20630.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::630]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1pzJSH-0005uI-E5
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:52:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uxtxs5tF7MMfJ+HrP+bCQEGRNp3JUIpITaAs1vBFzBhToE7S1QTC8omg31uTGfl/gVMhgr2XEVOi06jOS6Tgvvaw3euRXZ1CnKXuaN6zkKX+K0kbHTq5skjm60+Mpo9urs7PuFcfjoTEP5FuYY5D3IwDCGgJWSd8IDT2D0A58c7OZQ4O5r6tMcCxasjygLHA/rG/DNZXKs45XGUMqFfupajzvsV/v0kR+AxUpLejsYM6nNwIioo6tdQ+XCgRFJDHasP/IW///6MVHYUtJ0PDg0AIsA77SfGzOjqZ5vlyKsnAMtXbr+1amaV2XKqdg1d5TnaJT0KHJ50OgDBWiQnlvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4tRTe7RYY+7uBlRj7TjNitjXQVqgxEd/OzzPd7HgqY=;
 b=JtB6dTUlD4ov9ZQgEr763xtWEqyFUmAqeoPC7hGTMkUUAkxq12CggrlnYVP6ZdUFCTwUoc5s2SvrBER700iPqX366bD/Sujb0jmtVN4kAEx7yoX4LpgcXcDc33KbEhFPnWrc5aBXTK05Qf2lHx9eHdos5DqzWFZB+h8R898wl0ZR82gRaxK7Qa4Mia+wFd0pggLPGEV8u4qosY4QYOi4gLQBMjXN1dvTp7BUkJVirXUDknFMxCWlBIvk00itsmwsqrADQdpwZ15f+UC5nAUjVxn2vMUUtwHRNlFnK+AFM0fLPRJcp5k5armBcEA+sJDI0FuoAxWncFDDwZhRph2ayA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4tRTe7RYY+7uBlRj7TjNitjXQVqgxEd/OzzPd7HgqY=;
 b=sDGL6+uLHDrKjCojIoOquEnqGxfwidkNWEIup064iQwgBoAu51yuWofIXibD7psWQlTlA2c241XFIz4adXDUhKyp8DGKLVbv25gTHHMA4H1vluqebrqAIlszY4jyt4OpmNKdD6LZ1WY7Nl5XlwelydBrvtLMpB6gEV4tFPmKxJAYSrhJvdOZbsLZQ7qfn+EZGPfrxEueHpvpO05VGIuQhmkv+7JEeQUo5a86RAfSw/zs0pHD2CwwPEbv7wFm8TvpihWjhByPNk6bKuEOlP9LP02kb/4iue7Y3uOsTv3WMWUZ2r4c7S4cKQCaf0zh55Z7chC/CTMd9IwilIy3v3N/Yw==
Received: from BN9PR03CA0975.namprd03.prod.outlook.com (2603:10b6:408:109::20)
 by CH3PR12MB8482.namprd12.prod.outlook.com (2603:10b6:610:15b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 15:52:40 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::2) by BN9PR03CA0975.outlook.office365.com
 (2603:10b6:408:109::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33 via Frontend
 Transport; Wed, 17 May 2023 15:52:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.18 via Frontend Transport; Wed, 17 May 2023 15:52:40 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 17 May 2023
 08:52:30 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 17 May 2023 08:52:30 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport;
 Wed, 17 May 2023 08:52:25 -0700
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
Subject: [PATCH v2 1/7] migration: Add precopy initial data capability
Date: Wed, 17 May 2023 18:52:13 +0300
Message-ID: <20230517155219.10691-2-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230517155219.10691-1-avihaih@nvidia.com>
References: <20230517155219.10691-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT010:EE_|CH3PR12MB8482:EE_
X-MS-Office365-Filtering-Correlation-Id: b99d900c-19be-41ab-a48f-08db56eebec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hIA6DjKVc47VRUC0sr3BES74hmNSF4TWWTSkCmAr7ftoo/5IrCm58NxIusxL8vULNY0iMr/wxfP2PQPMI0rNjLh0sjslOGNxPWqZwU5u+7s5eWcRVACfttvtrofYOxELqwU4cMUU9Xe9G1oIfI3PgecIXFmEHLwdN9SmJl4dx3Sx0PQb3h+tOYSSNL02WfAsSglCrG7wWiHJQ/LHrnfLBXtd9NKQE91FtpInXnI0M2FJpLoP9jcgKRd/Pcvg84rox63oM4E/J0w/5wx3TgGEaJtP6KCXOsmURP6v+9NW1QvtAVdsIxDvw9PB3rj3TZjkrwZcCjJxxmmsHc1PvwNVVE4r92hjVi8S3/uAx4KeqP7I7vTfJ+coxjEo7Vk8grpB8a2ymVzqqHnQCXokK0Su8n73itxrZhphPPxwUtz531RpU20RN4LF6gPmBJqhjBnjZLxXr5VidgNbHIB55NDkLC3+cIq15ar01FkotMMAZTKC33feb93M/sD2Uv1uhbKw6xzHpUB/wt3SsXHQltIXF9ijBnkKDnlftRm3cqPOqiqVhXOuW4GEbLkoe29ECW637kMWWWZ7Y79pzknoEC8IJLkdmGcYiZeUr5jh3KD4cq5+hh1lK/3WiAtEP7L33Gftyx9yoDqH0OTQ8S+XBjMF3/jic3rM/LYX8CeWuS1NwM1lVzrVLu2mM8Zi6EEi0Dwh38ucjsrNXmPCmqX4XY95mjxQygtXAkytAr6B6NBv8SphTtiaQ51w2HviNkrfKpnY
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199021)(40470700004)(46966006)(36840700001)(7696005)(36756003)(6666004)(2616005)(40480700001)(83380400001)(47076005)(1076003)(36860700001)(26005)(186003)(40460700003)(336012)(426003)(5660300002)(82310400005)(7416002)(7636003)(356005)(82740400003)(54906003)(86362001)(41300700001)(316002)(70206006)(70586007)(8676002)(6916009)(8936002)(478600001)(2906002)(4326008);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 15:52:40.4207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b99d900c-19be-41ab-a48f-08db56eebec8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8482
Received-SPF: softfail client-ip=2a01:111:f400:7e89::630;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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

This patch adds a new capability "precopy initial data" that allows the
source to send initial precopy data and the destination to ACK that this
data has been loaded. Migration will not attempt to stop the source VM
and complete the migration until this ACK is received.

This will allow migration users to send initial precopy data which can
be used to reduce downtime (e.g., by pre-allocating resources), while
making sure that the source will stop the VM and complete the migration
only after this initial precopy data is sent and loaded in the
destination so it will have full effect.

This new capability relies on the return path capability to communicate
from the destination back to the source.

The actual implementation of the capability will be added in the
following patches.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 qapi/migration.json |  9 ++++++++-
 migration/options.h |  1 +
 migration/options.c | 21 +++++++++++++++++++++
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 179af0c4d8..a6c1942064 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -487,6 +487,13 @@
 #     and should not affect the correctness of postcopy migration.
 #     (since 7.1)
 #
+# @precopy-initial-data: If enabled, migration will not attempt to
+#     stop source VM and complete the migration until an ACK is
+#     received from the destination that initial precopy data has been
+#     loaded.  This can improve downtime if there are migration users
+#     that support precopy initial data.  'return-path' capability
+#     must be enabled to use it.  (since 8.1)
+#
 # Features:
 #
 # @unstable: Members @x-colo and @x-ignore-shared are experimental.
@@ -502,7 +509,7 @@
            'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate',
            { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
            'validate-uuid', 'background-snapshot',
-           'zero-copy-send', 'postcopy-preempt'] }
+           'zero-copy-send', 'postcopy-preempt', 'precopy-initial-data'] }
 
 ##
 # @MigrationCapabilityStatus:
diff --git a/migration/options.h b/migration/options.h
index 5cca3326d6..bba70a33bf 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -44,6 +44,7 @@ bool migrate_pause_before_switchover(void);
 bool migrate_postcopy_blocktime(void);
 bool migrate_postcopy_preempt(void);
 bool migrate_postcopy_ram(void);
+bool migrate_precopy_initial_data(void);
 bool migrate_rdma_pin_all(void);
 bool migrate_release_ram(void);
 bool migrate_return_path(void);
diff --git a/migration/options.c b/migration/options.c
index c2a278ee2d..0a31921a7a 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -184,6 +184,8 @@ Property migration_properties[] = {
     DEFINE_PROP_MIG_CAP("x-zero-copy-send",
             MIGRATION_CAPABILITY_ZERO_COPY_SEND),
 #endif
+    DEFINE_PROP_MIG_CAP("x-precopy-initial-data",
+                        MIGRATION_CAPABILITY_PRECOPY_INITIAL_DATA),
 
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -286,6 +288,13 @@ bool migrate_postcopy_ram(void)
     return s->capabilities[MIGRATION_CAPABILITY_POSTCOPY_RAM];
 }
 
+bool migrate_precopy_initial_data(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->capabilities[MIGRATION_CAPABILITY_PRECOPY_INITIAL_DATA];
+}
+
 bool migrate_rdma_pin_all(void)
 {
     MigrationState *s = migrate_get_current();
@@ -546,6 +555,18 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
         }
     }
 
+    if (new_caps[MIGRATION_CAPABILITY_PRECOPY_INITIAL_DATA]) {
+        if (!new_caps[MIGRATION_CAPABILITY_RETURN_PATH]) {
+            error_setg(errp, "Capability 'precopy-initial-data' requires "
+                             "capability 'return-path'");
+            return false;
+        }
+
+        /* Disable this capability until it's implemented */
+        error_setg(errp, "'precopy-initial-data' is not implemented yet");
+        return false;
+    }
+
     return true;
 }
 
-- 
2.26.3


