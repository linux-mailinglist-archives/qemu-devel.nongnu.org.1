Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF2D754DD0
	for <lists+qemu-devel@lfdr.de>; Sun, 16 Jul 2023 10:17:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKwvQ-0007o7-7Z; Sun, 16 Jul 2023 04:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qKwvO-0007mR-5X
 for qemu-devel@nongnu.org; Sun, 16 Jul 2023 04:16:14 -0400
Received: from mail-bn7nam10on20615.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::615]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qKwvM-0000qU-FA
 for qemu-devel@nongnu.org; Sun, 16 Jul 2023 04:16:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pj8yLN9jqDQPdM5VWrtX/b16HQ/2kFck3OvSeeNlzlUdXUQgX+gAoqE2HMczDGInTGRXKtoBWQG6HmZlfg2IqKXVF/w2VRMEGoWHygCW5nQcE9GHhAF6rkTz9HLnx8tMsYldRh7h1voqGPqKdoTHLE45nyzWtTGLwELDCnqev0EQFBwmliHtqN3e5mpSeWZg1t382phECvFjb75YQKFMtVM5bT7+ifIs1qNnJBi4xgyBVa6XVuwZAozm7Lc22tnqpty5XPhYsPEknwYdWAGE3pZPpVFFIYKIUgOBStPk5L7+mQjLMN8PoqQbQ8iHtjyij9u9e5NksByGALb32EutOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQ4xoMPymvJ2qudooBrQWQY1m2eDedjxURwAZ7xsNwc=;
 b=MulA6NjU2s15HW023gXH7DK+xSLMbrHCdFf3WKSqRouGmyUOnOJ/m9xdmThaBNcFbAKqDPfYM0DRw/VsGhK+M6L9qI0vd5N1GG70CGaDLUscgv5hGTsbGEEP8AvYp182+5wmJeQpgdusbDp/YcrXogPwgrrVx83/vSg/H/AxapBGn8IrvmiD40/SivpQHVu0LqLTm5LfE7nT4a6oDXIMOqV3o455L0DltzjLggif4RtNX3StC41p5q1zWMVvjQOABdMEbE5YyQyXz2qEv8EVnwO2MRJkiMn0hnWAs2VuELE7NULGTIH6BkrQ+6CRuW3dX5kJv0VquE6fUhSRA6h2Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQ4xoMPymvJ2qudooBrQWQY1m2eDedjxURwAZ7xsNwc=;
 b=oODUkQiaDW0nM2yeUvPHCMvpDNYkBHtVa/pPhFbsQ3iEgd33tTZ1m+qdz9hjE9jO3rMpZG/nnS0gJph18Lf7QsE5lLnlIwfZt2EI1KD4lDR7jDjjyc2l5bR3g+7fG+STq4nwPFZLlggmoSaahAggDvrM2lNAUPuNENmmfakjORSY7cDp7a9Io/VK0NOYbmjTmvhZ1yD6nj2jeiq8GlR2DMYVe6ljOyIQQtClYgykgsbJPRoJGBC4dnrm8hPgmhaoLLLVgIC4VhL7V33mFZiKY5oPZjQlBhfWeS5a7ww61ZRRYxxJp5bROPO4eLANvrFT8SFOgVXoJyyi3dGK9aZhug==
Received: from SJ0PR05CA0047.namprd05.prod.outlook.com (2603:10b6:a03:33f::22)
 by DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Sun, 16 Jul
 2023 08:16:08 +0000
Received: from DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:33f:cafe::f6) by SJ0PR05CA0047.outlook.office365.com
 (2603:10b6:a03:33f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.14 via Frontend
 Transport; Sun, 16 Jul 2023 08:16:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT081.mail.protection.outlook.com (10.13.172.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.31 via Frontend Transport; Sun, 16 Jul 2023 08:16:07 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 16 Jul 2023
 01:15:55 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 16 Jul
 2023 01:15:55 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Sun, 16 Jul
 2023 01:15:52 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, Yishai Hadas
 <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb
 <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta
 <targupta@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH for-8.2 3/6] qdev: Add qdev_add_vm_change_state_handler_full()
Date: Sun, 16 Jul 2023 11:15:38 +0300
Message-ID: <20230716081541.27900-4-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230716081541.27900-1-avihaih@nvidia.com>
References: <20230716081541.27900-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT081:EE_|DM6PR12MB4340:EE_
X-MS-Office365-Filtering-Correlation-Id: 87377c0d-ec34-40f6-69b8-08db85d4e828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qkBmE7W2lQ9YpCd2WGQl9+mZWd28rsI9KelvOP8d1nk5H2zKvdHLor+BVSmnSjvdwyawcz5BkTpbXFBBamRcTgiwlT8ZnUZYBdoCPz9jsvSD7wtWQZIAighdUl6/Lau273zOCyizM2VB9FwpI23DDCm83113EKfHi3iUpIl5e6cgtlwnJe26yRwUOWoVqQCmgGK7dlOIoFTuIE/FuRRMH0Y4zVFC77Rh69F2X4YpUcKEPYszGk4yb9g+sGOsMKC294aWPw5PBZ/f08UQClU7jzsUHO6XNRKRqhM5tt9wEL9Sa+KdbmRrOAQ+/B4L7z+4G8BxXY0rbfNxGX/pomRapKvlN1UH8TAtyWtaG6CJrqf2kGtt6LTP56/sTE5sKH8a5ZV3IoimWkKcuu35wUMO5Tgu/MxuNg/WLN1o/t9CRvW+zNVEbYskADrWQZHbN3xIZI5zjiu4gQgxbIXFrWgKKHy/PxEDk1ru2aaK983w3/9eE9ERj9jOECMQKDDfrzXnK0T5dSzpYu+BhA/0PCWe2cOcUbRHUj9/ySM5+7jyfiipcWI2Ze6wytWGbUuRJai/B7XUBlvN5OzTHFutNSkmOIB8Z7wxsVbyKoVuvZ+H5b/B5PpW8OOZbx+iSA5ryLA2XdWoT+EhuxSnEI036ou5dhyWV1A7JvWF5LLobvOoSw6+PniD0jVtJ5GlbKuxqBpAbGRgF3a+KBgzRhomvwOZnNezga31X/ut6+0o7NFt34Xb6ibVeedndi5IwFFcFmpH
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(2906002)(7636003)(356005)(82740400003)(426003)(47076005)(336012)(83380400001)(2616005)(186003)(107886003)(26005)(1076003)(40480700001)(36860700001)(86362001)(40460700003)(5660300002)(8936002)(36756003)(8676002)(478600001)(7696005)(54906003)(6666004)(316002)(41300700001)(4326008)(70206006)(6916009)(70586007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2023 08:16:07.6018 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87377c0d-ec34-40f6-69b8-08db85d4e828
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4340
Received-SPF: softfail client-ip=2a01:111:f400:7e8a::615;
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

Add qdev_add_vm_change_state_handler_full() variant that allows setting
a pre VM state change callback in addition to the main callback.

This will facilitate adding P2P support for VFIO migration in the
following patches.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 include/sysemu/runstate.h         |  3 +++
 hw/core/vm-change-state-handler.c | 14 +++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
index bb38a4b4bd..ca97b9dfa7 100644
--- a/include/sysemu/runstate.h
+++ b/include/sysemu/runstate.h
@@ -23,6 +23,9 @@ qemu_add_vm_change_state_handler_prio_full(VMChangeStateHandler *cb,
 VMChangeStateEntry *qdev_add_vm_change_state_handler(DeviceState *dev,
                                                      VMChangeStateHandler *cb,
                                                      void *opaque);
+VMChangeStateEntry *qdev_add_vm_change_state_handler_full(
+    DeviceState *dev, VMChangeStateHandler *cb,
+    VMChangeStateHandler *pre_change_cb, void *opaque);
 void qemu_del_vm_change_state_handler(VMChangeStateEntry *e);
 /**
  * vm_state_notify: Notify the state of the VM
diff --git a/hw/core/vm-change-state-handler.c b/hw/core/vm-change-state-handler.c
index 1f3630986d..24f155fb62 100644
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
+ * Exactly like qdev_add_vm_change_state_handler() but passes a pre_change_cb
+ * argument too.
+ */
+VMChangeStateEntry *qdev_add_vm_change_state_handler_full(
+    DeviceState *dev, VMChangeStateHandler *cb,
+    VMChangeStateHandler *pre_change_cb, void *opaque)
 {
     int depth = qdev_get_dev_tree_depth(dev);
 
-    return qemu_add_vm_change_state_handler_prio(cb, opaque, depth);
+    return qemu_add_vm_change_state_handler_prio_full(cb, pre_change_cb, opaque,
+                                                      depth);
 }
-- 
2.26.3


