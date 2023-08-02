Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 751FA76C833
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 10:16:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR70y-0006xR-Ej; Wed, 02 Aug 2023 04:15:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qR70w-0006sr-1M
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 04:15:26 -0400
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f400:7eae::601]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qR70u-0006QD-7y
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 04:15:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FIDM4vCf4eypeubZ0pCemDC384CbBQr4ZT8jSUOCeaORN69sX7/eR28oemYcafEq/1dz9tHkTEbaakmjlDs7k3rxpo2tchOUch2SfpRrPSD4YCZFKIPYqczwmLkBsSziwSqby/sJu0DAAzEFuITbzMFnJXFpa9DaKy/6iRFHsWKiE9DVPM2u6e2iu8qEJYQaV5/IxaX05BfVA3jKTtyHWGhRSd9piNwoGYoHfvqlyg328G4uqffJKHU18Kbvj+6eAnt3wZMth8E5dJsumZ7fzQSZ5o72vk6tpfcX7zpe8/mUnXzlah5EF09RrFEuQA/J2SesA6UJ5uWGeEpoi07HZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WoQMIf0erWd9Xi61xbdWyd5xQ2K+Na/DWwzAYf3pLJA=;
 b=jjEblKXZRAoetn5wlEiRzhuDvi351m12kHfKBRmHlflqKIhc/1wnznJenazjqnG1a5DY9uR4R69cul3Sa6YwzbJ+gnCFCXaA3t53IqNKGO+66KrknVcMX5dByTUb6qNGiiEynOf/IN0BnD18I1P0hfaOMdUKzVR4330c2KEHg6hAe5Ml8W1wlqhcsY/APIA9kFD0CqjpEx+fGDi4xK5K0uNj+M1L4x/I8sKnYsbT46+BTSRuPlRrezR5XwFYi4v3yKJBSIrcVFVRFzX5ycuVTVJbt/3z6X9ncb/UOTZJi+GnzIZqEYyzgXRJOcpEIl3gIBS2l4krfpHyxTHx1nfjow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoQMIf0erWd9Xi61xbdWyd5xQ2K+Na/DWwzAYf3pLJA=;
 b=ZSLBsVY0WrKS3fAPbxO+4NlIKRj6uBR0fYIE3B7q6LCd+O5SHyD26T/2n7O/u13HODKeTcFEVG+etO26LAn/9x4UPfkz1qFfj4hUsc0T+kdrC31JaRa17E47QN1XqcaEyx6gfQCOPyhiKcgA/IgQvjX0q4k+dZyfanYKu49LoUgbwpYnFgqvX5n5ohTr/TAP9m2LMaaQwcOQbKG2+qmd/v1f66bifF4iVqsq2+hbXbr0qBCbfG7TCWD18XHkPoSWHBI0lElxSoWHCAO+RqsHul7Q/n+ME4qdxrPDm+IOQDgQ4wyEkIP+Gdlo/73I0h2RZ2+8+p1GXgRoO4zmgS1sXg==
Received: from MW4PR03CA0306.namprd03.prod.outlook.com (2603:10b6:303:dd::11)
 by MW5PR12MB5683.namprd12.prod.outlook.com (2603:10b6:303:1a0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 08:15:19 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:303:dd:cafe::3b) by MW4PR03CA0306.outlook.office365.com
 (2603:10b6:303:dd::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45 via Frontend
 Transport; Wed, 2 Aug 2023 08:15:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 08:15:18 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 01:15:04 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 2 Aug 2023
 01:15:04 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Wed, 2 Aug
 2023 01:15:01 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, Yishai Hadas
 <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb
 <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta
 <targupta@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH for-8.2 v3 3/6] qdev: Add
 qdev_add_vm_change_state_handler_full()
Date: Wed, 2 Aug 2023 11:14:46 +0300
Message-ID: <20230802081449.2528-4-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230802081449.2528-1-avihaih@nvidia.com>
References: <20230802081449.2528-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|MW5PR12MB5683:EE_
X-MS-Office365-Filtering-Correlation-Id: b35e5df8-d470-44d1-a10f-08db93309c15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZBOWZxy1uQDeA0cDKCD9tv9dmdArB+F9gDWOA/USXCOk0W2xliaBXOajzPZ1PXQGgybKtUS+9+8877lhm+RcsKU7jCO+kkncVNDQ+Yk3v3Bm+YHNgbagJ27mKf9DJm5ZX++SaJ8RRYl/5/I8gMLCe0T2xju+kqrVPsmBsrZQOwh53n6jMsPbPzEVS2GkpIQq5OmI0rOqzdPNJdaua8W3/bhdMNDp7Max107QXMQ/BdItmB4AlAtcYMoVR7l3ts1E4Lc6aL+1195bqZiIpP5WTSdLC2RRbgq+OK/4DNVfcFhlC5HYHiR/2woRrpLkzTzhhnYkobQQFcbvqHsXFhAHyWPgexWUjw/tqrkukofJAZTYHTojCyTru35mxTviFRf4MfErT0Vvuk4gAQ0CiJiAUWwXoP2w9qiXezxiHCWUHMW/RBKK0rrxgacpIZwY0mFyMukoQwCmVT8Ec8uqmHqQUUURH69IlkvJAYLE/Zi4sSYjeiHMiNEcigp5T3hG9vtAW/Xi75hTBPrbrCQyr3/imwAKgrGB9iQre9L/ioYh51yEtmdU9qy1aLgsP5W2+MHPayT0vn74dorA54Oe1/uCekGSRDCSplUn9g2Y+NEA5DdOxfIgdqUQ1yBpAwu8GIe2C4YQbiq1HdmOHB8iaJXiqhm92/1yb0MZABiIn5T3hmckTbr2147iqDcxWe//4Idy6RTF3Kd6XcRG2Z3Q8vz5DoJIJvhe2q2qNUps2KDx4QmIFf1mNy/ocI4HeJwcyucw
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(66574015)(8936002)(8676002)(426003)(47076005)(41300700001)(107886003)(2906002)(5660300002)(83380400001)(36860700001)(40460700003)(2616005)(40480700001)(336012)(186003)(86362001)(7636003)(478600001)(54906003)(316002)(356005)(26005)(1076003)(7696005)(70586007)(70206006)(6666004)(82740400003)(4326008)(6916009)(36756003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 08:15:18.7714 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b35e5df8-d470-44d1-a10f-08db93309c15
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5683
Received-SPF: softfail client-ip=2a01:111:f400:7eae::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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

Add qdev_add_vm_change_state_handler_full() variant that allows setting
a prepare callback in addition to the main callback.

This will facilitate adding P2P support for VFIO migration in the
following patches.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/sysemu/runstate.h         |  3 +++
 hw/core/vm-change-state-handler.c | 14 +++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
index 764a0fc6a4..08afb97695 100644
--- a/include/sysemu/runstate.h
+++ b/include/sysemu/runstate.h
@@ -23,6 +23,9 @@ qemu_add_vm_change_state_handler_prio_full(VMChangeStateHandler *cb,
 VMChangeStateEntry *qdev_add_vm_change_state_handler(DeviceState *dev,
                                                      VMChangeStateHandler *cb,
                                                      void *opaque);
+VMChangeStateEntry *qdev_add_vm_change_state_handler_full(
+    DeviceState *dev, VMChangeStateHandler *cb,
+    VMChangeStateHandler *prepare_cb, void *opaque);
 void qemu_del_vm_change_state_handler(VMChangeStateEntry *e);
 /**
  * vm_state_notify: Notify the state of the VM
diff --git a/hw/core/vm-change-state-handler.c b/hw/core/vm-change-state-handler.c
index 1f3630986d..8e2639224e 100644
--- a/hw/core/vm-change-state-handler.c
+++ b/hw/core/vm-change-state-handler.c
@@ -55,8 +55,20 @@ static int qdev_get_dev_tree_depth(DeviceState *dev)
 VMChangeStateEntry *qdev_add_vm_change_state_handler(DeviceState *dev,
                                                      VMChangeStateHandler *cb,
                                                      void *opaque)
+{
+    return qdev_add_vm_change_state_handler_full(dev, cb, NULL, opaque);
+}
+
+/*
+ * Exactly like qdev_add_vm_change_state_handler() but passes a prepare_cb
+ * argument too.
+ */
+VMChangeStateEntry *qdev_add_vm_change_state_handler_full(
+    DeviceState *dev, VMChangeStateHandler *cb,
+    VMChangeStateHandler *prepare_cb, void *opaque)
 {
     int depth = qdev_get_dev_tree_depth(dev);
 
-    return qemu_add_vm_change_state_handler_prio(cb, opaque, depth);
+    return qemu_add_vm_change_state_handler_prio_full(cb, prepare_cb, opaque,
+                                                      depth);
 }
-- 
2.26.3


