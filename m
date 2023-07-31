Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0A6769315
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 12:27:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQQ6x-0000jl-0e; Mon, 31 Jul 2023 06:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qQQ6C-0000bq-MJ
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 06:26:01 -0400
Received: from mail-bn1nam02on20619.outbound.protection.outlook.com
 ([2a01:111:f400:7eb2::619]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qQQ6A-0006vI-09
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 06:25:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQCV+lmU0b/Qs45e7oi0jnQzSBPE1rBrhIo7XjT5j0zSZkMOOK7R7HSUxgfTKhrCG4baDPZOOviy+5kcSw3gxsdZtpsloYt0oLAXad+IvBcoUj9cVrzzLdEsjv5sjPur26flwWRCHxihRRmtARYxg4wbOI+A4hKfr2PunP+U4Xms5z33jZrRKV1/fBLSvtXkrAAKdYGD5lmocp3SBrjoESXv6rf0Kqz8DrWQXixC+ulQ9EweLKNy4vt0NLtV43ca8uP6al39vwQ/jwDpEx71VjDDpPLh15PQpFIie5NExJmVQdIgvodWiXEAgwfy72HfF/uu6lgMyuizKXfEpCPj0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YT1gngx+aTS2pITpXaQrIffDHCnwVm1bxDuI3JT6Vnc=;
 b=FI6L/3d/bTGuxL8rMubHHW5l41S3Oq3AbJTP1uFt7f2zIQLNAM2qc2d8rN8cnHqWW1fDtQtCRd5HxM08VCDI3CTh+DKJoN14Hfr4P9Os/d96fMSN9UAzbGg78x3krPK021eWyAD/xrhrexwjY6OeHGd1Ygp/3woN/jeQeZBMs98M6AWAbdKdUMk+8XKVDjdWKaXA5DUr/VdSDdHSyg4Kw3UU9onlRgAJ35zujSifExZaUJ2EnAZfc/p5e8HDHP3ieJXXqYCAQIQL1zvJBrkn3uay8m+8aEhqbIX2dXuF0xZyM6KC5sxVx+8r8JH0W78RCk7jrvshKRj6ZEPH5C8qrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YT1gngx+aTS2pITpXaQrIffDHCnwVm1bxDuI3JT6Vnc=;
 b=lI/4eW/8W9z+vFlJWwKSXtqKu6RxhXIOek42Gioqd35sXPdjvBUh+lS9xLg3pRo9oQPK4KnjHBPyX5XGFUWNGTvwM7XA7A7sCvBPPbSah96xm9OmNsYx/5H/MJIUygOSCtqFfAMSAVvEPZ0cAFZsd91BAEbd3D9Cc0P8G7aes72TGGMN4NUY7T8guxIQkp1op5zCH4gEk/kuEz5GWMKdeEjhTzUPbOBthVm6xQ5QlJgnHck4c8m82wIhmA++9+gCfGwgDvaJ9h1JFnzAZbbHw6XIznuMq0up2ty4gA3Wrc3wQzFcOCgO+L3YnvjOxLoXAZrNJfEajA3/7beTokcQ0Q==
Received: from MW4PR04CA0302.namprd04.prod.outlook.com (2603:10b6:303:82::7)
 by SA0PR12MB4559.namprd12.prod.outlook.com (2603:10b6:806:9e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 10:25:53 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::65) by MW4PR04CA0302.outlook.office365.com
 (2603:10b6:303:82::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43 via Frontend
 Transport; Mon, 31 Jul 2023 10:25:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.43 via Frontend Transport; Mon, 31 Jul 2023 10:25:52 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 31 Jul 2023
 03:25:36 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 31 Jul
 2023 03:25:35 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Mon, 31 Jul
 2023 03:25:32 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, Yishai Hadas
 <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb
 <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta
 <targupta@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH for-8.2 v2 3/6] qdev: Add
 qdev_add_vm_change_state_handler_full()
Date: Mon, 31 Jul 2023 13:25:18 +0300
Message-ID: <20230731102521.15335-4-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230731102521.15335-1-avihaih@nvidia.com>
References: <20230731102521.15335-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT010:EE_|SA0PR12MB4559:EE_
X-MS-Office365-Filtering-Correlation-Id: 2008ea74-9a60-4223-7afd-08db91b084a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sPLrRpS+CaNyim/cPQ7Yln6wYc0JvRVTRofZS584n7tKcmG73zuXa41qaOnCgUwu37f2huHl93s3/fbeYNCUTQrbdgHflAZky6JVqkHGrCISEDbAF5TZbUiSJFPFxTuJ+xo/WOKSRo6TGugkl3AXXTH3+98XL5Dv7inJs8Wz6MdMH+gmD72EVyoSYEb5H9tPiuZ8JJmkhJzP3QcRmWtRW3GpvXBgH7W87ZR2bidDrFrND3IPApRL02oxeYLNkKJoBiST1CSI9AQ5ivdNR8pBGe9zsj40i1oS0mC/kwezpa1Sg4KeD5shcFOBnD1QFE6oAduFcKG6diHA6u4O2WtJYgdVwUQqLQGMbAygUjFNo6SJa9DJMk4FbQ/ImpZ4FwjHCbldHttiPGAHOxg6M8VKEKYcr/0EnhCRHUhwjO+3XzAp8Oz/MsFTwxDJsQFATtd9q2sND1XjHd/ZTXHoKyvtQynoAKhZO08q5Hi7WHCozsq/U38lsCyat3P36Od1XTItwKwCnLD2oRMN2loXIe1QqSZF60nZp/g8sLQtLvOByuhTa+/dkbC12BtR2kvWkXFmhyh/QJokaa55ngMML1M3g4HSn1IPfTzjnY0sIkTIAcALTPm+QuZ5TzLyBkjuY192d+pnf4AJRUDGtkUAKpjFY9jiJ+Z3ezIGEuB0VJp/FQq2srC+P4GdgMYFY46jUQ50taVzYUlhrFL/f38F99QPsNT+JAO8PuYF2Rok5mI+BrjxAUa3Q71yYFm8rl2WV9B6
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(82740400003)(356005)(7636003)(40480700001)(86362001)(40460700003)(36756003)(6666004)(478600001)(7696005)(2616005)(107886003)(186003)(336012)(26005)(1076003)(8936002)(8676002)(5660300002)(70586007)(70206006)(54906003)(2906002)(41300700001)(6916009)(4326008)(316002)(36860700001)(83380400001)(426003)(47076005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 10:25:52.7138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2008ea74-9a60-4223-7afd-08db91b084a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4559
Received-SPF: softfail client-ip=2a01:111:f400:7eb2::619;
 envelope-from=avihaih@nvidia.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
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


