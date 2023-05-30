Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F9F716514
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 16:51:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q40fg-0006TR-3q; Tue, 30 May 2023 10:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q40fF-0004iS-IC
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:49:33 -0400
Received: from mail-mw2nam12on20627.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::627]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q40fB-0007wH-OD
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:49:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8IvR4ebtSvMR8HuqHvww44hNxi1LzdKt3cvLBH7W7fSB0sjg0lCq1+154z/3Fn/IHcY2ISV39gT97GbUK9dEL1pWj1WeRZmtm30TkCxDPmWVXmyl+3n+2Gq2g2p/NraWeDlx0/YvyiqUDvohFYUiAUwEBZwT6cGAFmpPgDoWZzpYUcbKRxxGGBfy2ah/HYXlxXr5MJLtLkHt4/PXHAdJeFGR4JI1DGOZ+lpqvaxdbC0zsIS8LNVGFyPIzzLXSblFSjxsRK9n8cj3rS3Sge4KOJM3asxsD4+uli7Ggvg9kee7eEnvoMb6rbeGrWzJCJEU6RGOVN7s+jT7HM8m5ba8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8EMmkAUj7UEj6LiCM3s48xo/zMKo4/HfkUMdq2oR8I=;
 b=VVu+3e4vzO9jm1mQ7C7R6VLZF4DPRhZS0cxF7Gg1rr3/jB+m9ZmArAoNI3FcbYyUiLJ//nMU3hPn4YDVXmzp+zVPP+E/+A102M/QsJudtZXlA+5JW/VLTA7kklf2n8UpCpe5DY30cLsld/m5SVehtlExEOcHjLiIRU6hS6e0Umy+1f+4T3i8VLq9ts6a9w4S5JNCMancvPSN35kcFiGBUEEOrRTsc6EJ4T/Tjz36t4Efr17EtJOtG1VpHvIccI6wUo9eVDkSFbZDqop8Gq5xJHP19p965enRYeW6x5MHDcQrkT/Pc/4VY/A66OLkLHoE/lM24RXeTLLPp3ukMgiT6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8EMmkAUj7UEj6LiCM3s48xo/zMKo4/HfkUMdq2oR8I=;
 b=NiUTITLYBzd7LR+DBkJXCLcyUy2W54V/jZI6CtHRCyC8aebtivXPPuxylEMOQCGjKVQURQEjg34gDdFdmTF0ev2CukbcGxrESj8XcBa9fQrrL00ajK6NuPfseUDp7cHQkhSjmz3qvIMUHG3QUK6u17voNYc//b4LMN5Pz2zH109WWRR6zzQQnETsM0XZmtUza2r3+7mykeWX1JIazyN7aH1YzS27Nz9BJ8EDrgoITug0Boj40Vo+3leHCKYa/APpoimM5w1LtJEFgUN/U1Hfi9Sq74eFXS/jjMk+8ZkvMOmjsbq0hVNPo3hAky8tX8a2FjrMbNX3+PDnjchK9MFHwQ==
Received: from BN0PR04CA0107.namprd04.prod.outlook.com (2603:10b6:408:ec::22)
 by CYYPR12MB9015.namprd12.prod.outlook.com (2603:10b6:930:c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 14:49:25 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::26) by BN0PR04CA0107.outlook.office365.com
 (2603:10b6:408:ec::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Tue, 30 May 2023 14:49:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.22 via Frontend Transport; Tue, 30 May 2023 14:49:25 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 30 May 2023
 07:49:12 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 30 May
 2023 07:49:12 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Tue, 30 May
 2023 07:49:07 -0700
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
Subject: [PATCH v5 8/9] vfio/migration: Add x-allow-pre-copy VFIO device
 property
Date: Tue, 30 May 2023 17:48:20 +0300
Message-ID: <20230530144821.1557-9-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230530144821.1557-1-avihaih@nvidia.com>
References: <20230530144821.1557-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT050:EE_|CYYPR12MB9015:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ecb00e1-423b-4018-edc9-08db611d1017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uFv70Q1+tEZFOkDyXRfHM+rYzNg2SswIHzTCtqTYoWAlIs5uDFIz+ul7dcZbTPgr3ccr/qL0XqOKIi2MQUx5QqxpE1qnXh8c+rPZVrtUNpdpqHUfMD0zk53yyFMl8oNS5zPLjgEyPGqdjGNZ3vU49HIhkpVGSlPLIg31XMnpmfNfqq7RhvzNDJplAxqGm3zIdHNxUC2OK3woifBsDmJUph9haa7b7sDmRYRfGtg37+55XnQcrPpTN2qrECbYNl3nGUfycBG7QQorBCuBl6u/WHlAQBXYThinUw5NwS8raWOKNVzJjRxpxok/SIFsaARE0qM2kTk7ZsaQhSdbQCrbu+iK2bHMBJeMCSGNn+h1liM3IN3oIL4mHp58/ZZMlIugNI22uZEcTOz7D00WWOLaYXhIxARchKAPRBd1xp3BfTre7MdVnwYya7dG8hWVo36XIBdbqswHG4/TtLi5xDgjeQMZNTmuLxaE5jZHOoFx0VcRijo3NEVxBEGg0zmhYNL9OWVi0pNtl0ULHMkIVGlbonCC5aoQzXnDfi0Cc9Be1HoWr3kY3UmqMj6TlwN0goTvhyHKLeMleItxgQlWtEBX9Ec3GZe0ld+Cidwsl+J1z414rm1Z3ebGNVE8e2hdmVjgYQK4L82fKGU6HK+zq2dmSklURXKMJu9h9WBT1Fn/tpRoYYf7LexgUZEdOaSfow/fz+x8RxwCylwTMtrruhIYmygYpwWLDr5zUF6ybpynLDKBFWHod/J9k9quaANIJcLA
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199021)(36840700001)(46966006)(40470700004)(54906003)(478600001)(40460700003)(8936002)(7416002)(5660300002)(8676002)(2906002)(86362001)(82310400005)(6916009)(70206006)(70586007)(82740400003)(4326008)(356005)(7636003)(316002)(40480700001)(36756003)(41300700001)(186003)(36860700001)(66574015)(1076003)(26005)(47076005)(7696005)(336012)(426003)(6666004)(83380400001)(2616005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 14:49:25.3131 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ecb00e1-423b-4018-edc9-08db611d1017
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9015
Received-SPF: softfail client-ip=2a01:111:f400:fe5a::627;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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

Add a new VFIO device property x-allow-pre-copy to keep migration
compatibility to/from older QEMU versions that don't have VFIO pre-copy
support.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h | 1 +
 hw/core/machine.c             | 1 +
 hw/vfio/migration.c           | 3 ++-
 hw/vfio/pci.c                 | 2 ++
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 1db901c194..a53ecbe2e0 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -146,6 +146,7 @@ typedef struct VFIODevice {
     VFIOMigration *migration;
     Error *migration_blocker;
     OnOffAuto pre_copy_dirty_page_tracking;
+    bool allow_pre_copy;
     bool dirty_pages_supported;
     bool dirty_tracking;
 } VFIODevice;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 1000406211..64ac3fe38e 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -41,6 +41,7 @@
 
 GlobalProperty hw_compat_8_0[] = {
     { "migration", "multifd-flush-after-each-section", "on"},
+    { "vfio-pci", "x-allow-pre-copy", "false" },
 };
 const size_t hw_compat_8_0_len = G_N_ELEMENTS(hw_compat_8_0);
 
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index d8f6a22ae1..cb6923ed3f 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -323,7 +323,8 @@ static bool vfio_precopy_supported(VFIODevice *vbasedev)
 {
     VFIOMigration *migration = vbasedev->migration;
 
-    return migration->mig_flags & VFIO_MIGRATION_PRE_COPY;
+    return vbasedev->allow_pre_copy &&
+           migration->mig_flags & VFIO_MIGRATION_PRE_COPY;
 }
 
 /* ---------------------------------------------------------------------- */
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 73874a94de..c69813af7f 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3335,6 +3335,8 @@ static Property vfio_pci_dev_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO("x-pre-copy-dirty-page-tracking", VFIOPCIDevice,
                             vbasedev.pre_copy_dirty_page_tracking,
                             ON_OFF_AUTO_ON),
+    DEFINE_PROP_BOOL("x-allow-pre-copy", VFIOPCIDevice,
+                     vbasedev.allow_pre_copy, true),
     DEFINE_PROP_ON_OFF_AUTO("display", VFIOPCIDevice,
                             display, ON_OFF_AUTO_OFF),
     DEFINE_PROP_UINT32("xres", VFIOPCIDevice, display_xres, 0),
-- 
2.26.3


