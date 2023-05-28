Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0987139E5
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 16:09:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3H3n-0001Ak-3D; Sun, 28 May 2023 10:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q3H3l-0001AD-AP
 for qemu-devel@nongnu.org; Sun, 28 May 2023 10:07:49 -0400
Received: from mail-dm6nam11on2062b.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::62b]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q3H3g-0002pd-5I
 for qemu-devel@nongnu.org; Sun, 28 May 2023 10:07:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkpQTjRM/p1PbRhxsBynPXPGD6b0MjkbFsat+xJA7jPVAEGsBIOW9f3xUd1m2e1VT+RdHVMfLRypFKKnG5yycJKjpX1uCO8Di5pUL6bRBBd4ZxZRjFGiYu9eqGBFjI8OalvhxnsNR+F1Gc9C5pNH/uXUoSFQSsNPuJkXx1//+MnQnzjonUEh96O8B0hCBY8TQ99ChtNmdZHjcKYPSx+ncUW+H2mNUbj4o7lzhg1SUkxYacGbvySkpUl1VLZY3m5IQIQ0VMg4mXutuJZzTj88vZK5WWpI8BnkK+rDIEio0mmtwzjB7QPWDdmdX4PNfzk0ARbnJAKx6ke+kaTcNhyLrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7H9QvzqlZgXyvH+qr47sSSBnIU/d+2AJPqrxvWX8qg=;
 b=gh46ZbWhB6WVEbuwoXinD/Byux2jnRe4lHv7pso4MOk+fuZhPJEfTFvwN9bCEgpwntP8sftf/a0l+myGpOKuDuu3oWevvr2VYH15ZHC7DcgGsyQJTHV6HpbBPjD3s0/r+sJX9eN3ZKSqOZzrgZukqe35c8txc49n+LmHNgY2kLFiUCryECO8GJawY1xQODe0sebWwtwq4PXWF4hTtJc0GeV+cxfPcpL1IVn8TSjzF4aftXLPNPuVhuOGwkQ+08Bt+z9oOUysp8WJS6apXly5EfXMOdM3LmyJb1YPeqgdrDOj9qdHfLrA2Lksb3EOwYClQLN+Lunumv/9B+3KSLzNHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7H9QvzqlZgXyvH+qr47sSSBnIU/d+2AJPqrxvWX8qg=;
 b=R7y+Kx8gCewXT9IcyHI6hYxyAqBLyU7/UnLILWyjiQ6hVWhXg5NmupApLw2P6n0p/8+CqSsvkt5yawXhHTiStjjgCU3SZGDOPjbTJBuopZRedIXWwrVO7DObulkM+hUOdGf1HB7yKGFDuUQiDhGKRcGC2OzP4SgU7BjDNdtp2E6DARVbR639uev5yVrK9tD74vhhxVdrDc1RSnSkjK/4wkBG6y157pTBwPfYwrp+eKvkLNWeLzCzBHb+wtduPlf3xPnfJJGqK+yt2QvPpjfXsJ8zbBEr2Zw45rV+fsZKDJN87JyZS6mux+EX05jeLnOAZ2/5gPOi2Y2rLPHULk60pQ==
Received: from DM6PR06CA0039.namprd06.prod.outlook.com (2603:10b6:5:54::16) by
 CH3PR12MB8511.namprd12.prod.outlook.com (2603:10b6:610:15c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Sun, 28 May
 2023 14:07:39 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::8d) by DM6PR06CA0039.outlook.office365.com
 (2603:10b6:5:54::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22 via Frontend
 Transport; Sun, 28 May 2023 14:07:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.18 via Frontend Transport; Sun, 28 May 2023 14:07:39 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 28 May 2023
 07:07:34 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 28 May
 2023 07:07:33 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Sun, 28 May
 2023 07:07:28 -0700
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
Subject: [PATCH v4 6/9] vfio/migration: Store VFIO migration flags in
 VFIOMigration
Date: Sun, 28 May 2023 17:06:49 +0300
Message-ID: <20230528140652.8693-7-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230528140652.8693-1-avihaih@nvidia.com>
References: <20230528140652.8693-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT036:EE_|CH3PR12MB8511:EE_
X-MS-Office365-Filtering-Correlation-Id: 72b4e3d9-3de4-4cde-c042-08db5f84e567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l8B8SOxR2HnkuJk3SGCH7FJRnNpSNRUNoKU5qG5lLBeQLiZVrT7pBJqpsG9JMOgLojmKc18uSIlsjq0C79HPPquZndIrHdVnzazNAEIsxlZ0nGppp5ZxPdaijSUNcrk+nV1v8s7KTXb/tJlF0BDxV6u8Is2hpspC0yr2vm0O40YlVzzxYDWNUBcS2rQtwcdOrE4JR/wnUuUbleEvPBppOhxoVd49eGR1d45L3AnSZsNPLBT8Za++ewp6l8k7OfrQ0Wy7+mwO6W5V21BplsHetTZSXtSu1wT9wJ4xxFWIfKvVAgktsz9N/hFWaUdROOZ0s3C9AiymeXO+Rl1tj9cM/BdlecJvUelLeY2ZwFgWkT+r9z8DNe2nwKSoqVrYC+yO5Ec3hwR6wyUHF8x30CYWX9ew/YWAWbsuirDry+zm6j1OHFQ83dQm4xSnYyQFKwQMzjnbdrwCJL1PumFjoPKG1RWXS0/2rXZIgxZ07H9kPakSQPEDSzwQZo+QKCv5MnRfobFzxMDYO/6Qm3w0AomwtkMnWH/ya8iOpD3J7DYwZAfMnN59FlDfey3D2uW9UqCqW+voPELmIkySZn7Dk7x4MsSJl4SU2RDHrthekREjM/RRClqI8+FMewSIaK8rQrV49qihJN1El4JNQWUiTTk+W4Tn42+bMQQVIMWefNJOi0HxEQ/5mpalIwuAs6qd6cpAvfnU3XbmiJnTBTHAOsnx6+ClOstWCR54Alh3mzbHCSpMU/dHp3XGkLRZLiDs7jxs
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199021)(46966006)(36840700001)(40470700004)(54906003)(478600001)(40460700003)(5660300002)(8676002)(8936002)(7416002)(36756003)(2906002)(86362001)(82310400005)(70206006)(70586007)(4326008)(6916009)(82740400003)(356005)(316002)(7636003)(40480700001)(41300700001)(186003)(36860700001)(1076003)(26005)(47076005)(7696005)(426003)(6666004)(336012)(2616005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2023 14:07:39.0754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b4e3d9-3de4-4cde-c042-08db5f84e567
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8511
Received-SPF: softfail client-ip=2a01:111:f400:7eaa::62b;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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

VFIO migration flags are queried once in vfio_migration_init(). Store
them in VFIOMigration so they can be used later to check the device's
migration capabilities without re-querying them.

This will be used in the next patch to check if the device supports
precopy migration.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 include/hw/vfio/vfio-common.h | 1 +
 hw/vfio/migration.c           | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index eed244f25f..5f29dab839 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -66,6 +66,7 @@ typedef struct VFIOMigration {
     int data_fd;
     void *data_buffer;
     size_t data_buffer_size;
+    uint64_t mig_flags;
 } VFIOMigration;
 
 typedef struct VFIOAddressSpace {
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 235978fd68..8d33414379 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -603,6 +603,7 @@ static int vfio_migration_init(VFIODevice *vbasedev)
     migration->vbasedev = vbasedev;
     migration->device_state = VFIO_DEVICE_STATE_RUNNING;
     migration->data_fd = -1;
+    migration->mig_flags = mig_flags;
 
     vbasedev->dirty_pages_supported = vfio_dma_logging_supported(vbasedev);
 
-- 
2.26.3


