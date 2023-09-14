Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 588FC79FACE
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 07:27:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qger0-0001kY-Ku; Thu, 14 Sep 2023 01:25:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ken.Xue@amd.com>) id 1qgbIE-0002T1-LR
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 21:37:18 -0400
Received: from mail-dm6nam10on2049.outbound.protection.outlook.com
 ([40.107.93.49] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ken.Xue@amd.com>) id 1qgbIB-0000t2-TX
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 21:37:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCP+t9BR0KPprzU1Ru1Q7/ulDmNf5IC/i0XjnBZwOuHoU7JBgdaxogZAk8D9GQP8AVVCI0NHEq9zDJVvE+yIL7fIwP9lIn29LMT+rh8o5gaewmnxn4p2Lm3AlhR/HLgxIxoqP9bZrsaGOJHLkPfY9pb9xeCwqOoZhhM6RQrcRF3+j3k4jqpnP32botqEVrzJzaNW1SxDdmx9ZiS4wJi2dsS5toJBi59mCgMwBhv2s/9Px5xzEZ8u7h8r0dQfIpJvLNWqTjpeJVnd8GE2Z8Rbbl8/132KJji86IrageUSEplqwnxHhD/nGedS1yh0xKtBqYswLd94XOEiPBZZApa2uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCGRKqcpmOGY1cAgfMH9c/O0XmB6WDVBhEP7vU/AfgU=;
 b=cUFQMg14ZtTJgN+m2KCbcDyxkjrDAAem3eVRIWaJtHpuPN0l8p2yHovPX97oVWAabnpI7NKwUbsGNkI/7RMhDUbk6PeZSYLzViaFkDHYrNrKpZkZU+Gx6GAMxbkoWjc4nWWusS+E/rtthSZEUXUIr+M5uyBVd8hLAOVQspdGuJ3Izl3C/rSs8JFsIVUI0Q/sX5WYPGN0rJ7Tt2W1ssU5GorTebMEVoEzUy1XfjkazNS7K3mq6C36/O/9DyzZwkYYDBhPRUF1QHgYCmWJJf+zrYFK89r8tbQAJs8libUH7nPSdUzm+RSbyHZ0UVcaSOmzpru4l0I6jKzYpjk/lx9G8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCGRKqcpmOGY1cAgfMH9c/O0XmB6WDVBhEP7vU/AfgU=;
 b=ZIlc5A1yaZTUyMdOfhFx1R7otj3Jn2J4laDArTkbWI6tWY1LwPJ2Y97JJR4Q47YUkUBjrySsNYOycMeVBTULn+qTcm6YFmhSX1/eBHiNusdVMtyfwCwaguduY0LNM+lp2Vr0v87IqRLOZQd9aNabgs1+H4GoRab2HQtT/Xot3xc=
Received: from MW4PR04CA0107.namprd04.prod.outlook.com (2603:10b6:303:83::22)
 by CH0PR12MB5330.namprd12.prod.outlook.com (2603:10b6:610:d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 01:32:08 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::db) by MW4PR04CA0107.outlook.office365.com
 (2603:10b6:303:83::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19 via Frontend
 Transport; Thu, 14 Sep 2023 01:32:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 01:32:08 +0000
Received: from nv14-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Sep
 2023 20:32:04 -0500
From: Ken Xue <Ken.Xue@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pierre-eric.pelloux-prayer@amd.com>, <Hui.Yu@amd.com>, Ken Xue
 <Ken.Xue@amd.com>
Subject: [PATCH] ui: add XBGR8888 and ABGR8888 in drm_format_pixman_map
Date: Thu, 14 Sep 2023 09:31:51 +0800
Message-ID: <20230914013151.805363-1-Ken.Xue@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|CH0PR12MB5330:EE_
X-MS-Office365-Filtering-Correlation-Id: 72d395b0-5081-4834-874e-08dbb4c2692d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ppdeLv7sAvr1db9aElm9b/CCvY3tqzVP467Npkx9fmNifEZy9FeFb0IQWSrvSGFCJLVmS80zgZrDIMBY/x8gtN6RLT4T0ZZTS7Ckb0svruqME4mvO556sd2bDUn25iB7S35M+c6Vjl1HtysIME6l1pwsCpIROCTeFrM3yDzeyELlD/pifBU80RYSwg9IAocPixQv4/5sQ7JLUVwSL6omNswoxJ4Yfp60KbfZfY3SqFHIOLYJRkvs+O5FyMyHfC+ytNUfGnrss6wObWs2Q+9K3GVIXP+yOkR/uEhGaBKkPkhLj3tvCcSCkovq2FvZ0CRf7c05FHNQlEki/MahpsaYPg7W3/3zQMNx+TEPuXNxOv9eDip7DG64Uo/rFGRLZodTCDnipYJWi+m6t7xXXCnT26lX2VRHogUCNbYxrfONJfByZU0mDqyEWTjvuFIu/gvWzeRHxxKXs1UK4Y00LXR+1NNybVIdX5wMTsgEQFLpLlNFF+WUNqXZD4AwKzUOLbuACQZMod5ZmOI8PQ9Xn6dm6q/+Kbm4SVQvY68S9heE3Ml2CIT5b/bc9jsY4IHQ+oEIEKQ4DrT20c90jwdyg2tlORgCLC5KcqLB+At6vBIg1HQRs/GdOxx3a2tkuBwosITcBlBBQDyKRTW/+0ld8d/Lr+8hpcIaqobcCJNSYX1D2PoZC+7dKLkhuItIi5iM74q/KlVzR3XxGqdJwS+pjpnwL+nesKaQTLsCb0DLnrxUsSsp9TIxL+Few7sGLeG0MZyo2p2S3t3qAOYR0Bn3ofcdA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(39860400002)(396003)(376002)(82310400011)(451199024)(1800799009)(186009)(36840700001)(46966006)(40470700004)(8676002)(86362001)(8936002)(4326008)(5660300002)(40480700001)(40460700003)(2906002)(36756003)(6666004)(83380400001)(356005)(426003)(7696005)(81166007)(336012)(82740400003)(16526019)(26005)(2616005)(478600001)(6916009)(70206006)(70586007)(54906003)(47076005)(316002)(36860700001)(41300700001)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 01:32:08.2741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d395b0-5081-4834-874e-08dbb4c2692d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5330
Received-SPF: softfail client-ip=40.107.93.49; envelope-from=Ken.Xue@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 14 Sep 2023 01:25:22 -0400
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

Android uses XBGR8888 and ABGR8888 as default scanout buffer, But qemu
does not support them for qemu_pixman_to_drm_format conversion within
virtio_gpu_create_dmabuf for virtio gpu.

so, add those 2 formats into drm_format_pixman_map.

Signed-off-by: Ken Xue <Ken.Xue@amd.com>
---
 include/ui/qemu-pixman.h | 4 ++++
 ui/qemu-pixman.c         | 4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/ui/qemu-pixman.h b/include/ui/qemu-pixman.h
index 51f870932791..e587c48b1fde 100644
--- a/include/ui/qemu-pixman.h
+++ b/include/ui/qemu-pixman.h
@@ -32,6 +32,8 @@
 # define PIXMAN_LE_r8g8b8     PIXMAN_b8g8r8
 # define PIXMAN_LE_a8r8g8b8   PIXMAN_b8g8r8a8
 # define PIXMAN_LE_x8r8g8b8   PIXMAN_b8g8r8x8
+# define PIXMAN_LE_a8b8g8r8   PIXMAN_r8g8b8a8
+# define PIXMAN_LE_x8b8g8r8   PIXMAN_r8g8b8x8
 #else
 # define PIXMAN_BE_r8g8b8     PIXMAN_b8g8r8
 # define PIXMAN_BE_x8r8g8b8   PIXMAN_b8g8r8x8
@@ -45,6 +47,8 @@
 # define PIXMAN_LE_r8g8b8     PIXMAN_r8g8b8
 # define PIXMAN_LE_a8r8g8b8   PIXMAN_a8r8g8b8
 # define PIXMAN_LE_x8r8g8b8   PIXMAN_x8r8g8b8
+# define PIXMAN_LE_a8b8g8r8   PIXMAN_a8b8g8r8
+# define PIXMAN_LE_x8b8g8r8   PIXMAN_x8b8g8r8
 #endif
 
 #define QEMU_PIXMAN_COLOR(r, g, b)                                               \
diff --git a/ui/qemu-pixman.c b/ui/qemu-pixman.c
index be00a96340d3..b43ec38bf0e9 100644
--- a/ui/qemu-pixman.c
+++ b/ui/qemu-pixman.c
@@ -96,7 +96,9 @@ static const struct {
 } drm_format_pixman_map[] = {
     { DRM_FORMAT_RGB888,   PIXMAN_LE_r8g8b8   },
     { DRM_FORMAT_ARGB8888, PIXMAN_LE_a8r8g8b8 },
-    { DRM_FORMAT_XRGB8888, PIXMAN_LE_x8r8g8b8 }
+    { DRM_FORMAT_XRGB8888, PIXMAN_LE_x8r8g8b8 },
+    { DRM_FORMAT_XBGR8888, PIXMAN_LE_x8b8g8r8 },
+    { DRM_FORMAT_ABGR8888, PIXMAN_LE_a8b8g8r8 },
 };
 
 pixman_format_code_t qemu_drm_format_to_pixman(uint32_t drm_format)

base-commit: 9a8af699677cdf58e92ff43f38ea74bbe9d37ab0
-- 
2.35.1


