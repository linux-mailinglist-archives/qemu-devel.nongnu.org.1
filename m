Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB43820B1E
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 11:50:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJtN4-0006ur-3c; Sun, 31 Dec 2023 05:48:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rJtN2-0006ud-Bf
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 05:48:40 -0500
Received: from mail-mw2nam10on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2412::601]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rJtN0-000394-91
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 05:48:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ed+squ7VJ0hbzMQQ9kq2AlkLv54pp8AEbLuBGVFxldudoaBPC8640ue9KFrqvDkA2LBGXBXDOPlUQNVPXjTmqfQ5sJClicl+rk1P5zhj2Vw7Fm3o9f5E/GkVgetSJqz29e7c3bhVnwvCPq7IBpnGiy4+7wCt5AKl30MCPzCCAp3fR+UdCByH9V7tTQNmX9RIRs98JF9GSrn1Eo+Czfnot1DhVgB5U7BPhC81ftnKKeqjZQ0intQIU+no52KW4UpGW7f31+Ea43QI3pOoz4pLCSVQGB1BYrtmJ3Vk1+g6yHi24Y+Pw8LRaA7aLJUFnichujU80k+Q57qUQsNs0l1Mrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TqftJsLj3vimXIypQSJBsI4d4cISc2euat/LxQ7PF9w=;
 b=eCR3OYaq3bPwApF9MxUnXqfhOPOMBRf4VrpBr2UEuD3Ug63rwJ4NZgUxolaYSPbQMGNH+EUz4033BVhhReT8g4gz6tQ9BAWGOZKAGumAq4ngEGtVhARQ5y02lur0VW8hq7ohzZyslEm/WxXmsoD/OFkIcR3Bk2YTgtzx42sDH5DlfvJoafGPd4yAvbJaTkrlnR7gfr4KIWdo42HMHqa0DVUzEwQvoZFE8tEnhHGmpoZZ9eG5vmVdVS7xlu+Qtd/AxKG2zzbQd2dxFeOAXMzqiemvgOqM4kDjRkunrjWP0kXqNsWibRfDJ3TeYP0rcnNBrYnO8BYibO4v/EywOdcqAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqftJsLj3vimXIypQSJBsI4d4cISc2euat/LxQ7PF9w=;
 b=plQhZMwDUyUZsIWasYbQ6j4T9O01GG88H1kyqKSxJW9YQ3hh/UejQnq2yxZZ6v4wO379A9uyPB0ssrrts9RDR5oR5iX0MGIORlsEwh0C+iZCv1rtsr+ebkXhvrZmMefXdom3pKPIDs1bmZDjaZFrumOSxxMWD9Gru9RpWXOYMfUqlX+QWZ2FL6LhAuArGba9A/l4XlsDCzOkMrCNjB53O5lsY0SaPDAYCh9B1Kme0dHKaDiFV61ncTH5z9N6OEwe+wX9czKROuSEEMRKpsO2uz0YUUg8OkBco/xk298mcEk17A0tqlHMgl7roewzJPK3KsiExJlhiejOF7w1wD446A==
Received: from MW2PR16CA0060.namprd16.prod.outlook.com (2603:10b6:907:1::37)
 by IA0PR12MB8906.namprd12.prod.outlook.com (2603:10b6:208:481::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.24; Sun, 31 Dec
 2023 10:48:32 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:907:1:cafe::dc) by MW2PR16CA0060.outlook.office365.com
 (2603:10b6:907:1::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21 via Frontend
 Transport; Sun, 31 Dec 2023 10:48:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Sun, 31 Dec 2023 10:48:32 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 31 Dec
 2023 02:48:21 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 31 Dec
 2023 02:48:20 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Sun, 31 Dec
 2023 02:48:19 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: [PATCH] vfio/migration: Add helper function to set state or reset
 device
Date: Sun, 31 Dec 2023 12:48:18 +0200
Message-ID: <20231231104818.17666-1-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|IA0PR12MB8906:EE_
X-MS-Office365-Filtering-Correlation-Id: dba7fc0d-deee-4de1-eeed-08dc09ee0813
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zNXLunP9RFON225WkqTe0tol8iTJcixMe9jh/kcggpB2Raj7yEkRT3yp9Xn3PE/PXviVFpc7w/K4SZK83E1g7/8VPTiug1trPZPA9Qf9ey5SFrhfDTHDNuRzDBArO/kc/A6z3X3jAGOYukHIn8tvjY671+TSxp+ZlxvQ9S88v+6w2Cpa5wkO9qzhP1dEhXJYNVNOPjuDqF7zCra8KS0dAOvhPPfWwY+pVWrjAL1gqegRfFxAKed7oCO2QITR/LvgJKtlEG3AhsjOk6hBOKS8ccwmArw/TUxs6n22sUSTPa2vp+BfTVCF/wAH5OuHwInxUyMY+5VMSo1ZBbx0Le81sOJPI4bTSuWnscvLZym6KcE1aCvzohmyBkUkzWwDdT9urEcHcXdr4R5nyFczxd47itdJ1TypZJDun4gxw9CJHgJafbxy3OD+ZKg1c4eSMDh7cr/3ssjB+EL0NA1L28fLqhiwDL1jlMhjeR9NNLrPjwRJgkwzBOtrKufmgBWZLKxoRIhtDXjycKcpC9MzYicBjw10PEYNHQEIxwc/41cZbj9uIwq59Bw8yPP0JSwRBssock1VU8/u+k/jxmTlJ54BuIaiEbblJR/DAT4dp/atJTlfqEpHZ2+Vv0PXcOIKo6xG1CPNDxFrw2iYHio1I8jQLKoXDlKbGEgpyFlvctPhcY7meNN9h1HryyOGr3gE3a+FLFoJAav1flnTt9QyOnKuKZzEOUkQcIENJxKNzfaB0dGzF8o5yLT9zQVGvzhlVLeA
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(82310400011)(186009)(64100799003)(451199024)(1800799012)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(41300700001)(2906002)(5660300002)(8676002)(4326008)(316002)(6916009)(54906003)(70206006)(70586007)(8936002)(36756003)(86362001)(82740400003)(7636003)(356005)(478600001)(7696005)(47076005)(36860700001)(83380400001)(107886003)(1076003)(26005)(426003)(336012)(2616005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2023 10:48:32.0752 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dba7fc0d-deee-4de1-eeed-08dc09ee0813
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8906
Received-SPF: softfail client-ip=2a01:111:f403:2412::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.667,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

There are several places where failure in setting the device state leads
to a device reset, which is done by setting ERROR as the recover state.

Add a helper function that sets the device state and resets the device
in case of failure. This will make the code cleaner and remove duplicate
comments.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 hw/vfio/migration.c | 41 +++++++++++++++++------------------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 28d422b39f..70e6b1a709 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -163,6 +163,19 @@ reset_device:
     return ret;
 }
 
+/*
+ * Some device state transitions require resetting the device if they fail.
+ * This function sets the device in new_state and resets the device if that
+ * fails. Reset is done by using ERROR as the recover state.
+ */
+static int
+vfio_migration_set_state_or_reset(VFIODevice *vbasedev,
+                                  enum vfio_device_mig_state new_state)
+{
+    return vfio_migration_set_state(vbasedev, new_state,
+                                    VFIO_DEVICE_STATE_ERROR);
+}
+
 static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
                             uint64_t data_size)
 {
@@ -422,12 +435,7 @@ static void vfio_save_cleanup(void *opaque)
      * after migration has completed, so it won't increase downtime.
      */
     if (migration->device_state == VFIO_DEVICE_STATE_STOP_COPY) {
-        /*
-         * If setting the device in STOP state fails, the device should be
-         * reset. To do so, use ERROR state as a recover state.
-         */
-        vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP,
-                                 VFIO_DEVICE_STATE_ERROR);
+        vfio_migration_set_state_or_reset(vbasedev, VFIO_DEVICE_STATE_STOP);
     }
 
     g_free(migration->data_buffer);
@@ -699,12 +707,7 @@ static void vfio_vmstate_change_prepare(void *opaque, bool running,
                     VFIO_DEVICE_STATE_PRE_COPY_P2P :
                     VFIO_DEVICE_STATE_RUNNING_P2P;
 
-    /*
-     * If setting the device in new_state fails, the device should be reset.
-     * To do so, use ERROR state as a recover state.
-     */
-    ret = vfio_migration_set_state(vbasedev, new_state,
-                                   VFIO_DEVICE_STATE_ERROR);
+    ret = vfio_migration_set_state_or_reset(vbasedev, new_state);
     if (ret) {
         /*
          * Migration should be aborted in this case, but vm_state_notify()
@@ -736,12 +739,7 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
                 VFIO_DEVICE_STATE_STOP;
     }
 
-    /*
-     * If setting the device in new_state fails, the device should be reset.
-     * To do so, use ERROR state as a recover state.
-     */
-    ret = vfio_migration_set_state(vbasedev, new_state,
-                                   VFIO_DEVICE_STATE_ERROR);
+    ret = vfio_migration_set_state_or_reset(vbasedev, new_state);
     if (ret) {
         /*
          * Migration should be aborted in this case, but vm_state_notify()
@@ -770,12 +768,7 @@ static void vfio_migration_state_notifier(Notifier *notifier, void *data)
     case MIGRATION_STATUS_CANCELLING:
     case MIGRATION_STATUS_CANCELLED:
     case MIGRATION_STATUS_FAILED:
-        /*
-         * If setting the device in RUNNING state fails, the device should
-         * be reset. To do so, use ERROR state as a recover state.
-         */
-        vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RUNNING,
-                                 VFIO_DEVICE_STATE_ERROR);
+        vfio_migration_set_state_or_reset(vbasedev, VFIO_DEVICE_STATE_RUNNING);
     }
 }
 
-- 
2.26.3


