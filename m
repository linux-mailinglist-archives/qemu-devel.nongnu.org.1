Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BC07460E3
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 18:40:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGMb6-00064i-Ug; Mon, 03 Jul 2023 12:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qGMay-0005zh-IN
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 12:40:12 -0400
Received: from mail-mw2nam10on20627.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::627]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qGMaw-00080T-3K
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 12:40:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFc5vkg2US0CeZfnm/EPYTvZjfajH3jhWgp3jMw5oK1IexOnbo95zpird7HHDDOjleSznTVx4b2cLcSieYoZRiApyXmBP9Zvd6l0r9AtAUh+bwGjgALaCrMu0qb2G4HjmtxGCrcW0dqEF6LD0kEg2CkkpX/o8gr6T7be3MuidExahtD/Qn2C/IpmA/Uyh4AGFpqy366raEVyC9iX0yupW4qoSyGuMmeKs5hq4TMjNv+D/l67sQWkgo9ORzHu3lHiaQy1LZiTPAjLiaY7etpHkSIvGh2zdLqOXOjGkDzH1XXs+o0os0b14DgAWYmEYS3ZmX/FHZu/tzcRZjNPHjri4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akBcfr4mUqbx7cr55zCNcpfb3a4NB39xrrOXNz0MnFU=;
 b=BTXvwRZZiANqQP/B+0FcHXM91ZpBkXxFo0JB36303L/7nGbm/sODG7ABT35G+DR2TJwnV9Iywsh0LR8MB5IDDvWYE+df/KmWuWZ4F4telYhzJIFBCIQq9tHpDxeMNc4bYfkhiMAjyzcXVC0VJ0ogNi/OvLUZftkFQaLPvBKEFmBWrwN7gwQVpOUQwaiag+EYR2eU0HfbI/HpCWAifmgrIRpDZhSwr2QrldzcccH/OKijfxApdrLm52FqHjiefX1eV/GO9UOsrBI+4SYR9N6kwxeOFtQEfrx0fP3DeiPLNwNmGmo7Y/+Hqf4pU7bul0GbflVFb3HnwIyQclYhjGMCsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akBcfr4mUqbx7cr55zCNcpfb3a4NB39xrrOXNz0MnFU=;
 b=HqQrqkK/QyjcDDDXUqeWwYWVsxLYNIvZXn4VPU4zScElhuS27oTnRgeQyrNWkfxtuxn7CBgpxeF1wt1vJdy0P9M5hAoimfxZc6ncx7lTIlnJSIXhyaXKnAWrL+9w/WVFsQ7vXv6bcgjhQnSYjdTr23ONL2lrHG09hv8HFWG4tBsPc/5Nr4n43oWxSMSyND4drniWgcQBlswuxLmNGFK33QzfK16Cugir25v5EQrLGJHQstHL5bs51SGXLgaWdh6KMsfGqa9Nz5W8yrHOzviEz5Z8NpTW5ntPLmfmIk1E8eOQGEy+O27ThzIoy1Ni7XGQF6G+acyHldGttU+Ws/cYOw==
Received: from MW4PR04CA0359.namprd04.prod.outlook.com (2603:10b6:303:8a::34)
 by DS0PR12MB6439.namprd12.prod.outlook.com (2603:10b6:8:c9::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.24; Mon, 3 Jul 2023 16:40:04 +0000
Received: from CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::82) by MW4PR04CA0359.outlook.office365.com
 (2603:10b6:303:8a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.30 via Frontend
 Transport; Mon, 3 Jul 2023 16:40:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT114.mail.protection.outlook.com (10.13.174.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.47 via Frontend Transport; Mon, 3 Jul 2023 16:40:04 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 3 Jul 2023
 09:39:55 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 3 Jul 2023
 09:39:55 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Mon, 3 Jul
 2023 09:39:53 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH] vfio: Fix null pointer dereference bug in vfio_bars_finalize()
Date: Mon, 3 Jul 2023 19:39:53 +0300
Message-ID: <20230703163953.18526-1-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT114:EE_|DS0PR12MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c414500-985c-480c-a680-08db7be42728
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3A1LyT2zz3sbZLFllZd9zLv0IQHauK3e3LB9qTYLguZUyJvC5lN5sFbCzxLl5YWacPrR6h0lj3g8EqF2fdwBnUpun30nYcT7VdfKt1SsiIHmDhaVZxSAgh+DQQUunbIOU8Ah9NfKjUG/so7UOt0+K07sHmuyXRqMMc4i17Ef3j8dLwWGbTeHFze9i9D6Ey5BgUN8SX0OeCn5s+rtFcAXBLicM+3AZmgNl0M6Ya0yERxMxmMso8iv59iOIiz3T5AqXxXSEiG9ZS35M/hlQ4nn9ez2+jr+qrP7bVdGr3Z3azuOyUqyd6glMBgkjwE/eX/WAwP672CF0hhDlUezozERaxkvDWlUppmGRJcn+ZHohwuDMBg7PE78rRqyy2DhzCmOupTikA+pW8kuvGQTzJR2dqvemR0vkG40FsfMuzYmSyHpdGe7TxLEaW62Ezo3R5RyniUORWnqwskQ4h2NvNLoBf8wP9OtF6AskcoQ3fUTZXx0TsmAzAmu+uRTSWNL3FUey8ZuEBXeq/WneUjoecL96GL/aDrc4oGmkc2WKZn4njrsDwH2maAp7BFPRn9+Sj05oW3XMFkF/3fUOCmhRGYatmn1RkEWpPZaes4OZ2k12rhEsn1/myUTPa1wtrbR5rlXEnXF2qRldg0q6jjrp6VSjPXXnF0nuXRl1x0RvKEInqi0oHPry4A7H9jtv6D9/oykkSsJaDcFG/xcguyAONJbAXPbOgEtqqH9qzn4ymhdkwWAyZi2hGaFdOOgAO79QK4X
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199021)(40470700004)(36840700001)(46966006)(336012)(40460700003)(41300700001)(7696005)(82310400005)(2616005)(7636003)(82740400003)(356005)(83380400001)(107886003)(1076003)(26005)(186003)(47076005)(426003)(36860700001)(40480700001)(54906003)(86362001)(478600001)(316002)(2906002)(36756003)(6916009)(4326008)(70206006)(70586007)(8676002)(8936002)(5660300002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 16:40:04.1855 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c414500-985c-480c-a680-08db7be42728
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6439
Received-SPF: softfail client-ip=2a01:111:f400:7e89::627;
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

vfio_realize() has the following flow:
1. vfio_bars_prepare() -- sets VFIOBAR->size.
2. msix_early_setup().
3. vfio_bars_register() -- allocates VFIOBAR->mr.

After vfio_bars_prepare() is called msix_early_setup() can fail. If it
does fail, vfio_bars_register() is never called and VFIOBAR->mr is not
allocated.

In this case, vfio_bars_finalize() is called as part of the error flow
to free the bars' resources. However, vfio_bars_finalize() calls
object_unparent() for VFIOBAR->mr unconditionally and thus we get a null
pointer dereference.

Fix it by checking VFIOBAR->mr in vfio_bars_finalize().

Fixes: 89d5202edc50 ("vfio/pci: Allow relocating MSI-X MMIO")
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 hw/vfio/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index ab6645ba60..95e077082b 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1752,7 +1752,7 @@ static void vfio_bars_finalize(VFIOPCIDevice *vdev)
 
         vfio_bar_quirk_finalize(vdev, i);
         vfio_region_finalize(&bar->region);
-        if (bar->size) {
+        if (bar->size && bar->mr) {
             object_unparent(OBJECT(bar->mr));
             g_free(bar->mr);
         }
-- 
2.26.3


