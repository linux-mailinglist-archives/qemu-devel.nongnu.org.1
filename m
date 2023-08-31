Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C5978EDF1
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:01:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhHd-0005Mw-NR; Thu, 31 Aug 2023 09:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qbhEt-0002lV-JP
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:57:37 -0400
Received: from mail-bn7nam10on20607.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::607]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qbhEo-0005GP-VL
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:57:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2w+bBCv/GGjrPI7HrocA/hHfGcWNHEgFwVLlyXWG/5lxSKrM/X/74nj1uiBINUzj/oo0RUTVkpySvHgblCr6/j5KHHXyLFa3SR/k1Ne02IkhqGsFqrGEN/LmezAFfKRgeuSInf0H5sCncSG89SFk2JyI4ZDiS/Qm3OhOHjgpa5CDMOW86ny9cYjfaAcxPVimL2jvJpVpx8TZQifaBh8wvlo7geZLSMH0SNXGnTLYohEXLVxnnNDt9Yszc1d6997gDqmsJJVReH5TZBPkYFrNvZTlHUOYIwEtEUPfREfH5YHSbAQV2cIkb39ckjXsRCv7Ob6oeHYH2shQLiGiRiVpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+w4eKVNZY3XK7OjkGs7r0f3qa3AFhJNPzBrdsO4ZVg=;
 b=SfAs53n72U/snHdrWnlVTN/xg9PWnvQPB5Dm7zj3/oPHYpKIWY5tESNA0iLMJ8V8iUB4gosCecrAUP3aRzQml2bTgdOXBTYmvnJDl1fcJJvmTSm2qV6GP3QY5aQEyRau0iUFzCkf0YcMHWLOzZK4HqW0WlgxWO8Bw6iOEBTXbbd0rHSERI87E8krsNjdqnBI7Vx54Ay1LdtN/zApsF5K0E9uewa3hSYf5xkz1aMYjfrWuk68S5Yxn7Vcn5RUdKB0dIJ8Dywl7tkWwnxQO6cTZmnmLkybNXeaC7K6MMocLRVruyqrUFbv8vAOcsEOFO1u9OXYDT4IohijwjtWHjnffA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+w4eKVNZY3XK7OjkGs7r0f3qa3AFhJNPzBrdsO4ZVg=;
 b=Eb9yA2KkhRTwmD0REEEJFVzGym76qWytVnA80Q0i1CW8n3ibYJ4dIpXW87osq0NmOn3LZG42MBAa4QIgCEZXL1VUbxtxfOcGZKI/yAaxcDqm4j1tqcwE8Ls7see2Wv3G0ck0e1lx0wGl5SD0FksL6PdqOLr6m0PKFKMKd/sIQ50pZSpZ1Z3DS1puC3uGqejmhZlJSMWyTG+4S6/NdXUf+gWqrlh3dZxICxGbuFawCwVEl8xwQGEuH+hK9w5ZW6THoV5af+9RACCWqoJQ6WmcJF81A+W9rbVPxuAViuM32uBKz6s6q28DxDT79yabpUK/XU+YgtvjYDIeXNhx//j7NA==
Received: from MW4PR03CA0204.namprd03.prod.outlook.com (2603:10b6:303:b8::29)
 by DM6PR12MB5023.namprd12.prod.outlook.com (2603:10b6:5:1b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 12:57:27 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:303:b8:cafe::22) by MW4PR03CA0204.outlook.office365.com
 (2603:10b6:303:b8::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20 via Frontend
 Transport; Thu, 31 Aug 2023 12:57:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.2 via Frontend Transport; Thu, 31 Aug 2023 12:57:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 31 Aug 2023
 05:57:15 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 31 Aug
 2023 05:57:15 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Thu, 31 Aug
 2023 05:57:13 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Yanghang Liu <yanghliu@redhat.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH v2 4/5] vfio/migration: Block VFIO migration with postcopy
 migration
Date: Thu, 31 Aug 2023 15:57:01 +0300
Message-ID: <20230831125702.11263-5-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230831125702.11263-1-avihaih@nvidia.com>
References: <20230831125702.11263-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|DM6PR12MB5023:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d700624-7d72-4ee3-2c99-08dbaa21d41c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q4FllNuK9taq+ViucraJ9XXmS1ICqjr34NzG6o/LG1NKz4ZkH9h0qB6CASb/k2FP2452s1SSRm9xPLnXj4bAeUxQJvjYgxYUdM3QVhRWuhcYVBhgLhwpJ3+yu//glmhWqhYxfML/nzs3lvIWb8gxyeuqOYil5egfFzTxGgxln05nvm1W9C4VCvIgjK0oA1A09hIgQ4/Lzt/X3D4jmFXneyAg00pQhO4Ehic6UgMs8FQkHV6o9eGrUqnzl+qP6CA8pVB4/wIOK6vKRQX0GLlFnUKtrE/gmWTOcXxNmF12ao6Ryfw6JebfDoclQmU+X1IZmPz+ViLhsLWOuJT0PBKzFReKkKoCW1Zqc/jZM2GES4gTR2/krWd4E9wbQyrQwfnLYaVMMeHDVkfjdNImAGdHBI8LbKVsiflbPaJ2yOZHZE41AJYMn7dgB/NF09v74cUrZXbm3bvkHm3xVsZ7wL+BnmPF2Qb19ioV/f+c5r85mjdBSKHQAKDYj8m6JglroZ82Bbb38noMRK7ICD4TwT4vd1G08BbnTgZg1Tse5i2M/YMPODl7a1qVMwutuIWmJHwd6FPxTq4bgIH77qTmDixDkhuYku9Vs6CaBHpaXvlXuS60U0XCOxib1d+yZFhKQ/2qL89oSLyl3M28rN+zFjKxCHl9lixrzbNf0HTFVnInBzat8DtsRXslIAKGawPhJqMpg1QSBIH2A6ORAyxacBFpWsq6D+9Jc9TEytSTe6YXWUmRsEwGcNl3X/8rFFTfnJl2
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(1800799009)(451199024)(82310400011)(186009)(40470700004)(36840700001)(46966006)(36756003)(40460700003)(40480700001)(2616005)(83380400001)(8676002)(86362001)(41300700001)(4326008)(5660300002)(8936002)(6666004)(336012)(7696005)(1076003)(426003)(26005)(36860700001)(107886003)(47076005)(7636003)(478600001)(82740400003)(356005)(6916009)(70586007)(54906003)(70206006)(316002)(2906002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 12:57:27.1222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d700624-7d72-4ee3-2c99-08dbaa21d41c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5023
Received-SPF: softfail client-ip=2a01:111:f400:7e8a::607;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

VFIO migration is not compatible with postcopy migration. A VFIO device
in the destination can't handle page faults for pages that have not been
sent yet.

Doing such migration will cause the VM to crash in the destination:

qemu-system-x86_64: VFIO_MAP_DMA failed: Bad address
qemu-system-x86_64: vfio_dma_map(0x55a28c7659d0, 0xc0000, 0xb000, 0x7f1b11a00000) = -14 (Bad address)
qemu: hardware error: vfio: DMA mapping failed, unable to continue

To prevent this, block VFIO migration with postcopy migration.

Reported-by: Yanghang Liu <yanghliu@redhat.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 hw/vfio/migration.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 71855468fe..20994dc1d6 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -335,6 +335,27 @@ static bool vfio_precopy_supported(VFIODevice *vbasedev)
 
 /* ---------------------------------------------------------------------- */
 
+static int vfio_save_prepare(void *opaque, Error **errp)
+{
+    VFIODevice *vbasedev = opaque;
+
+    /*
+     * Snapshot doesn't use postcopy, so allow snapshot even if postcopy is on.
+     */
+    if (runstate_check(RUN_STATE_SAVE_VM)) {
+        return 0;
+    }
+
+    if (migrate_postcopy_ram()) {
+        error_setg(
+            errp, "%s: VFIO migration is not supported with postcopy migration",
+            vbasedev->name);
+        return -EOPNOTSUPP;
+    }
+
+    return 0;
+}
+
 static int vfio_save_setup(QEMUFile *f, void *opaque)
 {
     VFIODevice *vbasedev = opaque;
@@ -640,6 +661,7 @@ static bool vfio_switchover_ack_needed(void *opaque)
 }
 
 static const SaveVMHandlers savevm_vfio_handlers = {
+    .save_prepare = vfio_save_prepare,
     .save_setup = vfio_save_setup,
     .save_cleanup = vfio_save_cleanup,
     .state_pending_estimate = vfio_state_pending_estimate,
-- 
2.26.3


