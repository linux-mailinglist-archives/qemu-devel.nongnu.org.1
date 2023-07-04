Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 901807472E2
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 15:40:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGgFv-0005gE-WC; Tue, 04 Jul 2023 09:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qGgFq-0005fq-2M
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 09:39:42 -0400
Received: from mail-bn7nam10on20619.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::619]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qGgFn-0003qB-R0
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 09:39:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/4U1N8k5uSnqw1zpG19BrnE3i4l7LZfLMkGgUepmCPSXp4EsXxncajh2Z8NkTwyGQvBUooAYUJ2rCCV6ZzrCR//bwV0k+smlrQlKyXxRUmqOnejWxCcHsqPt7/BLPgDfRjVVUSNH9cD32RtMrA1YexoJEhMafUMWN8JshXTZngFiYeIniMhBk7QT1mrcadd8M4lBJsWPJ2/UIaRl17PsjDbjjWdGycXWSgEfiQ2X01gzMpaOP+xC7edwN3LSRmfoX41v8Wgo/1pEaN32v24eBaZKtQGk01gar0BG61+EmEwUV6UdhjzVPtGwiHvgViRlle59/W5CpFF5PXTctsa+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAw89e6ET/Betzxbq94t63q0lnbtN3eGbAUsgH5fDI8=;
 b=P0l/nMtaCWg+7e4wtxvviAtaLyv1l+xV7tNQdJ5D+UDldlE6yXDUXIvKAmoGHFTT65c1RKwnquQbgAqfHkW7sSQ8SdBmDNBWP2IIOVtlRIYRzSabqrgnZYMaG8rBJA2E33GBObsMuK/eH4J03nN62vFE09z413ATBxwzmz+PMrjnYvEGhuxgZHI9Xm7jUQUVWkfOKo2467SA5BArueqTmYS3Ohbwe2pOvjX0YuMbEYqnBJ5rHXtZjcGkimPkJXIo0RxXwbsMHfMmnrLI5M9MmSilpEzvOoiwiWGVVw3sjxHoosDY7ZrC7KOhvDs0ODv7Kg4r3cyzFMBsKYLvN23TCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAw89e6ET/Betzxbq94t63q0lnbtN3eGbAUsgH5fDI8=;
 b=a5XChNIz0LQ9t6w8bDnFFrRyi42tGiGndPPo3Qve08AEw596NbvEme2Yi0fO7On1WJVRMHEg6Z3ZoTZE1+hZNs7BQlMWwTa0muXihWcydA1yeI+AjNYbBqN6zxA/JU1xUiITO3/o3IL4i++4cc7RlSjagmOE3yw7GN23/uqKLXS52ELvo3g02RdG9Xbkrm6IbnBR68LNhZY+qEJS3v4EdzuQDTOX+h1LQaYSvm7nr54enX4TfZing27S2UPgGkjtjnWGmiR4XiQhOaLKBHw5VG2+8HJneEtCAX1v3YNvqAV2QDfIIopScaelwICKFvNxEVngYAgXo3DoP+nX/Gqiwg==
Received: from BN9P223CA0030.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::35)
 by PH7PR12MB6881.namprd12.prod.outlook.com (2603:10b6:510:1b7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 13:39:35 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::d) by BN9P223CA0030.outlook.office365.com
 (2603:10b6:408:10b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.31 via Frontend
 Transport; Tue, 4 Jul 2023 13:39:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.44 via Frontend Transport; Tue, 4 Jul 2023 13:39:34 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 4 Jul 2023
 06:39:30 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 4 Jul 2023 06:39:29 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport;
 Tue, 4 Jul 2023 06:39:28 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH v2] vfio: Fix null pointer dereference bug in
 vfio_bars_finalize()
Date: Tue, 4 Jul 2023 16:39:27 +0300
Message-ID: <20230704133927.24677-1-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT034:EE_|PH7PR12MB6881:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ba24b16-4f60-4eb7-9c6a-08db7c941ac0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qhBoJXSSRnxNxnYCFT8NQktztlA+i2C//oL/tIRHTuN9PIs6Gwt6ivc+ZlUVYMAUnFlrRnH9c8NHOPqZaj4PtCtF56gx7Qqqp9rMG4ySBQukEY0WU/sv3Oh/f0TB+6QmKCjQN/B6RRo6q82BurKWa6z+lQmp8AWgZ3bXdCWs+oyF/xFLf9w/VVtVkD7g6wikVcXqCu+y85T8kMTxlyEMUbmzNvfiPXTuQ0iglmNUadgkcKE7IHNcLT1pprcNB3aflSmi7Kz8D2hR8il4p8AAvPXNocpQ/sfx/vZvYTAl6DbjTQ91+4zjx6JyxQVLJw/nrdKkrxFA9RqGbx+PCNN6OFa5/YwTPD2ZsKECEjvlbT3WgbYrOW+zAuZhtMrKUb9tiRys1jgD8ckeKuTFBCkRszdEg/bCS3kTOCf5iO6WpONz/c0jPNdxXg/Eq2HsbEK6ev+VM3SoHk9O03qRLO4PRHQLhGv24UQWeAaKNCXo14qPStHMJWajDM/rHQTiMEmZUrOs+lxmmFipBM7PdHOsd4E5vdJJQq5MRMRQ9g+AS5n6jrzUptcAc+z+9v9Z4t9KXtXzFRojPtJKw1I65KScF+yRh8iDrhUXSdJ3uE2h5coNEOE+aZLDsN9I5kjH3pWG9iPUDVgb4lnvVX9TXKsIqdp6q8/s2dO8opNgWBfkOI8VCP4seQAum9u+IpZVbRE/ZQuRighSCkd8kWq3Fk0EcMt48TbaQpy8HuaBC7jM8h8pYvmATbg33YxuKjx/3FCn
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199021)(36840700001)(46966006)(40470700004)(186003)(7696005)(107886003)(478600001)(26005)(5660300002)(47076005)(36756003)(2906002)(2616005)(86362001)(83380400001)(336012)(82310400005)(426003)(82740400003)(36860700001)(70586007)(4326008)(7636003)(70206006)(316002)(8936002)(54906003)(6916009)(41300700001)(356005)(8676002)(40480700001)(40460700003)(1076003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 13:39:34.6860 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba24b16-4f60-4eb7-9c6a-08db7c941ac0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6881
Received-SPF: softfail client-ip=2a01:111:f400:7e8a::619;
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

vfio_realize() has the following flow:
1. vfio_bars_prepare() -- sets VFIOBAR->size.
2. msix_early_setup().
3. vfio_bars_register() -- allocates VFIOBAR->mr.

After vfio_bars_prepare() is called msix_early_setup() can fail. If it
does fail, vfio_bars_register() is never called and VFIOBAR->mr is not
allocated.

In this case, vfio_bars_finalize() is called as part of the error flow
to free the bars' resources. However, vfio_bars_finalize() calls
object_unparent() for VFIOBAR->mr after checking only VFIOBAR->size, and
thus we get a null pointer dereference.

Fix it by checking VFIOBAR->mr in vfio_bars_finalize().

Fixes: 89d5202edc50 ("vfio/pci: Allow relocating MSI-X MMIO")
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---

 Changes from v1:
 * Assert VFIOBAR->size and set VFIOBAR->mr to NULL to make the code
   more accurate. (Philippe)
 * Small reword in the last paragraph of the commit message.

 hw/vfio/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index ab6645ba60..bc98791cbb 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1752,9 +1752,11 @@ static void vfio_bars_finalize(VFIOPCIDevice *vdev)
 
         vfio_bar_quirk_finalize(vdev, i);
         vfio_region_finalize(&bar->region);
-        if (bar->size) {
+        if (bar->mr) {
+            assert(bar->size);
             object_unparent(OBJECT(bar->mr));
             g_free(bar->mr);
+            bar->mr = NULL;
         }
     }
 
-- 
2.26.3


