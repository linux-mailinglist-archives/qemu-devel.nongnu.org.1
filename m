Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF067139E6
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 16:09:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3H4O-0001d3-L4; Sun, 28 May 2023 10:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q3H44-0001Il-Lc
 for qemu-devel@nongnu.org; Sun, 28 May 2023 10:08:09 -0400
Received: from mail-bn7nam10on20619.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::619]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q3H3y-0002wJ-TY
 for qemu-devel@nongnu.org; Sun, 28 May 2023 10:08:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fn6K3boMIgN2JR/nQ/ezsHd1S3d1ZlSdFC5R3TAAZzAv5tvzjM3Ar0T4iCytEZ/ehf5HV4QLRwqFt0v7ehSFfi6MwXddZ0+ba1ciIfqyCbEkuXdvFpSBdhE+I3q+jbz0y5Em1uso5c9xo7sMi+L2hRDiK5ewiSHC/k1qEdlrHgptre7RsRSVzMQigu1rc6HBHVjg3OzjLARr4Xlnecy+xEoJRlG9VsltdTyh//+3trISieg2up4lzaYPpViZ57Jyg/Xn8O23iWFCsmMjRWmiTKgaA0QFXV9hHFRCbO3ciGPQHMf0Nz0zsJOPNP5qzWfs75sGVQstxazOH+7xTxF2Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHdntD8SC22jVdDGSRrKgMekG2xM3FktyGu0X/9Z254=;
 b=W5Nayu0ws1H2PY5AK6BZdXPWm2iGoQ0naDPGMd5IkQckBL5gfm34rz4slSql3yPVttX4pBp6rUkeC/bYDFHmeAkoBNfo/sJlibJZkaqpvyjFVC6KKX46XhiG7f3/nHzGf/Rk92tm0CxEFl0HgLgD3EfCSJsVa73RSv7mGUIQsAFPjRTr5+xD2QFofRGP6+kWd+8fyjah9Syo8AsUO/QznHkTMATR7QYfb9EtWQulsG48mni+y/ubhRwE26XoNU2v8B+v/Kd/T1Vki/znvpNty2sEnMJCSFCdow8k+2kqJB6fh5tWgZmBqYRg2FYd5BVYcvZ3hgRlZEEdCBRYNQL+IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHdntD8SC22jVdDGSRrKgMekG2xM3FktyGu0X/9Z254=;
 b=Br3v+WxJ3mEu46taVasGxUPY1+rbE6RnqiU2h5nfylpjW/MgErNPvVnoiZvZpBm5Q12LbARz3kz/LdvNk7pmtb6HuJzA9zPoK1Nhg1R2YB5QiChTxRXBA+Kg3kn3Hx+GUi6mPVFlmisvU0jl648alJ9GV1f+pkmHQ1qvawJeOSuds1dnfK62uuLfiLhEItUcnhuUvzCbRh13byGs7c8zjC/ao0Jhcuh6tZuJLgG0rJdh1GQiLBnYNDSOyyxFH7GvFgNInkvydbQ2cRKrU/JdJiA07REl4HjOLZD042kzl9sajikslQqaN30OgT6DEn5ugn6dhVc39A6gOWjdLlOT0Q==
Received: from DS7PR03CA0313.namprd03.prod.outlook.com (2603:10b6:8:2b::18) by
 SA1PR12MB7443.namprd12.prod.outlook.com (2603:10b6:806:2b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.21; Sun, 28 May
 2023 14:07:58 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::b0) by DS7PR03CA0313.outlook.office365.com
 (2603:10b6:8:2b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.21 via Frontend
 Transport; Sun, 28 May 2023 14:07:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.18 via Frontend Transport; Sun, 28 May 2023 14:07:57 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 28 May 2023
 07:07:46 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 28 May
 2023 07:07:45 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Sun, 28 May
 2023 07:07:40 -0700
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
Subject: [PATCH v4 8/9] vfio/migration: Add x-allow-pre-copy VFIO device
 property
Date: Sun, 28 May 2023 17:06:51 +0300
Message-ID: <20230528140652.8693-9-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230528140652.8693-1-avihaih@nvidia.com>
References: <20230528140652.8693-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT032:EE_|SA1PR12MB7443:EE_
X-MS-Office365-Filtering-Correlation-Id: fd0fa19a-d9b6-436e-68a7-08db5f84f09e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x2wDpvKPFlS9nILw0rv+sf972UIrBcIDEUXHlRFbZ2qd8DyUpEwIkXZuLm+hBUe8aIgfCc7m+wH4KGGgWQB67V/FqG5Dy5d7NawJ4Zmu75aGJ/sGt4t600ykD+Y4roPgXXUGl/HVlzm5rm8B1fKpKLc3LbXqC6LEhBIWjlDHrn1hiu4ixhu1sHIy5ThDaC+bVV9bk2WWQkxUzwVDvUklN071x6aHN3RNYW49l8nBkFTsfI6ukcK8ExVY5Z0/hED46nobB4Qudrk7rkzwM3ubqOEmy+sNxspaZKHASENojna9TcrfHhB045WxJ7Be58XkteDh9TysHeajlaURwJ/quLFJA0Pg30DOpzD/LbtRvQ9YHkNO1mlHySFmP0NXehhbJqA6fDvfuna5CqC+f6BIQ1TzpwUtI4dJzS80QzJ4Qdpb39Ged7g7j6AsfHePZa8HGd5tFEit0abri7HU3CKlnrHoQqIKNX3yc4AcOr19PsyFzaRfjRYmHKpg1MgWG5ArQoIMglroL8kkFTUb7ICfCPdrFJwf+7gyk1AkOInA5gbxR2/Ocn9FdLjsYzPCaK1Cy5p9YCfWNlelulL3WGYpyg29jyr0zGt4dDOjQrX7ChthiXRcYXI5e18ivTyWayjWZLqEF9Z3av6+HNP+4BvE2ectbO381FY7eBbtSMZskrom+Y24HEe2dGsPbxVVOBkQOcrFFy2lXOjVo/9ix867ZeaEfatf0KbYTRIgWOji1YMIwir5okzLz46rfdjhJ7jG
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199021)(46966006)(36840700001)(40470700004)(86362001)(36756003)(4326008)(40480700001)(82310400005)(186003)(8676002)(8936002)(41300700001)(1076003)(26005)(426003)(336012)(47076005)(83380400001)(7416002)(2616005)(5660300002)(54906003)(478600001)(70586007)(6916009)(70206006)(316002)(7696005)(6666004)(356005)(7636003)(82740400003)(36860700001)(2906002)(40460700003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2023 14:07:57.8886 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd0fa19a-d9b6-436e-68a7-08db5f84f09e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7443
Received-SPF: softfail client-ip=2a01:111:f400:7e8a::619;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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

Add a new VFIO device property x-allow-pre-copy to keep migration
compatibility to/from older QEMU versions that don't have VFIO pre-copy
support.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
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


