Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D510754DD4
	for <lists+qemu-devel@lfdr.de>; Sun, 16 Jul 2023 10:18:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKwvO-0007mT-N8; Sun, 16 Jul 2023 04:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qKwvN-0007m3-6b
 for qemu-devel@nongnu.org; Sun, 16 Jul 2023 04:16:13 -0400
Received: from mail-bn8nam12on20621.outbound.protection.outlook.com
 ([2a01:111:f400:fe5b::621]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qKwvK-0000pz-HE
 for qemu-devel@nongnu.org; Sun, 16 Jul 2023 04:16:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbwW3h1Fbu4hfXyh7R+WQjODyJh9GGoELl+xLuhp9HaeWcIdQp7qiMkZcN162M94fYlvsUrkzGJZPVr02GhmTmxQWOvvXtcPLNx1qZcsUu3BzPAbydtUY4yFTUx9JXJo3PcpuM8AfKagWCA+FXjNcQdMUfTOmJRhkG+xTei+uIkHw4nmLec5hvYaHVgJCoNeYaafeK1F2yTkOiHktw1CEedFnELdYMH1oA1Cqn7JHHM1x6cJZbEQRiB575Y8Ai0iSUfvC2WPX3Pd5ddQm/zc/PJNnMrMyMcEVTcK8CuuZ6p5LkXKugo+P9obdmjNlkeeaZl9LykXKuP/4HDqyxK0Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+V0SKQ8fVDS0yFd8IkXWJp2BKGL9A+zyu5Gf2BFCNw=;
 b=QE4cyIVkYwcNeeLB3laTyHacJpW1hfAjCHegzV6kZ4v6XsUuzF0NVB/ZeGNJ4VINxm3lgUyoXT1vnKBHJGDlmqosOVCZiOi0e/rCxojVEcKhAwH7LchKqHqTL7fYSe8JBIfdMaXFucO1FaNkGSPflHARiBk8seYsaSYb2zd2d9kXUq+dJ42nb5PpHztAzUdDM20fw3e6EupNs8j+uaUgnDCRuYd8IHDR5u40/GEr4Sot3nebwsflrIOACR+0Y1movT+fvf0kVohVMvTQGyGZG6KGfuErrJDQTFw/TeEueSifXUKaKJOGJp0wmQvSvtzubw6Zh+47xl6ikMSdFAZXmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+V0SKQ8fVDS0yFd8IkXWJp2BKGL9A+zyu5Gf2BFCNw=;
 b=hBH/qMUouTZd5T6oiWn0St7RDMrF5RdMRHjdMVmsZvot0P80waV8rs42ZnzQLa5gHGeiN1FwExMiiqzhfAEPw43KTG8RZ4QJ+hflILXobhuruWSBpk7Ts5PUv+LLpuJBEjR2wK5jTrLQyoYcA+TsAB6sA59hg1qgwAy4XPjjFxUpa/YzGb60iQWNumXIUQf9uCazWedg2LUDMBr9EVCuFeYfCqGAwLmAvisxJkpIU5geBIqSuCGnw4PhHI+0TwEfvFXqLGvCs+Ud1V8NLqVhWjXfwuRVJAAfubQe3/NlZg8T3SP4MnO8Mgp+Px1gVZqg6b/TdHEwjdzXF6CVCBeEGA==
Received: from SJ0PR05CA0034.namprd05.prod.outlook.com (2603:10b6:a03:33f::9)
 by CY8PR12MB8065.namprd12.prod.outlook.com (2603:10b6:930:73::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Sun, 16 Jul
 2023 08:16:06 +0000
Received: from DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:33f:cafe::d2) by SJ0PR05CA0034.outlook.office365.com
 (2603:10b6:a03:33f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.17 via Frontend
 Transport; Sun, 16 Jul 2023 08:16:05 +0000
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
 15.20.6588.31 via Frontend Transport; Sun, 16 Jul 2023 08:16:05 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 16 Jul 2023
 01:15:52 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 16 Jul
 2023 01:15:51 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Sun, 16 Jul
 2023 01:15:48 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, Yishai Hadas
 <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb
 <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta
 <targupta@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH for-8.2 2/6] sysemu: Add pre VM state change callback
Date: Sun, 16 Jul 2023 11:15:37 +0300
Message-ID: <20230716081541.27900-3-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230716081541.27900-1-avihaih@nvidia.com>
References: <20230716081541.27900-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT081:EE_|CY8PR12MB8065:EE_
X-MS-Office365-Filtering-Correlation-Id: 25adde31-60dc-48de-2fef-08db85d4e6e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TXH0hPaeLmVtp2ICh+SY0ee37Ncwbf8tcJaXglumuPDAR1MSZdd+Dkgzas6PZNxNiA/1wwDGmu/DVmmsYlZdiLv2AB5RbyZQDHUue7jgoK18cxVFGBert7yixvxLTC1STD4Ty6/ATb4w44BmZyjoMTz+oZZIMA0vCF1GdwHhRUxDSs6p0M0zwhvb//QgQINBzrk0Za0vdjV2KO1Cj7wDakaDYq/r6J26tSgvWjt+F4PBjuugXfU1JXZr04/nBAWIrXmnIj+Z7JjU/GHWHQPoQniVbr9damlIDuqaShFjwjTNbtHXOs2xj5zglyRGGuC2Pq6mWKKqb95ZA+ganMUup8XpBdVVybs4bGtVlbfP8sxHi3gGjTs69BNiznS/QdZGVKdkH4BgQgX+Bx4R8uX7N6gXGDJF2zhCGrbnazovZUfhOKKr8WurqIYJq1P8sf8xBtFz23pDBigXp133bcObBFkobXVIBorIfVVSo56oFpCllztPgXCvhZDNqF8vbYZD+OuFYSanZPvmQ0RImkcC+SOlbO0rPGUDZbgc1t+ilL+vOomY7i9avotC61jk2VGAh13m/Ell7ifwdFAEWCX+a1/Xgh9hl6Q5MtD+LFaP2CMYyXDxACfczJiHiGakVFkuntvv5cHHsfhU2XsSV4A41DyD8BmFCxQO8FjNEWf4/7BSXVZ8p6q0CSA8swLRs9XsIWxfiFeNUgiKPomDUDMozpGiZUOyKSoAF5hB8g8TqmsYdeeWSwgiLVtjAGcxrh8v
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(2906002)(7636003)(356005)(82740400003)(426003)(47076005)(336012)(83380400001)(2616005)(186003)(107886003)(26005)(1076003)(40480700001)(36860700001)(86362001)(40460700003)(5660300002)(8936002)(36756003)(8676002)(478600001)(7696005)(54906003)(6666004)(316002)(41300700001)(4326008)(70206006)(6916009)(70586007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2023 08:16:05.4769 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25adde31-60dc-48de-2fef-08db85d4e6e4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8065
Received-SPF: softfail client-ip=2a01:111:f400:fe5b::621;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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

Add pre VM state change callback to struct VMChangeStateEntry.

The pre VM state change callback is optional and can be set by the new
function qemu_add_vm_change_state_handler_prio_full() that allows
setting this callback in addition to the main callback.

The pre VM state change callbacks and main callbacks are called in two
separate phases: First all pre VM state change callbacks are called and
only then all main callbacks are called.

The purpose of the new pre VM state change callback is to allow all
devices to run a preliminary task before calling the devices' main
callbacks.

This will facilitate adding P2P support for VFIO migration where all
VFIO devices need to be put in an intermediate P2P quiescent state
before being stopped or started by the main VM state change callback.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 include/sysemu/runstate.h |  4 ++++
 softmmu/runstate.c        | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
index 7beb29c2e2..bb38a4b4bd 100644
--- a/include/sysemu/runstate.h
+++ b/include/sysemu/runstate.h
@@ -16,6 +16,10 @@ VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandler *cb,
                                                      void *opaque);
 VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
         VMChangeStateHandler *cb, void *opaque, int priority);
+VMChangeStateEntry *
+qemu_add_vm_change_state_handler_prio_full(VMChangeStateHandler *cb,
+                                           VMChangeStateHandler *pre_change_cb,
+                                           void *opaque, int priority);
 VMChangeStateEntry *qdev_add_vm_change_state_handler(DeviceState *dev,
                                                      VMChangeStateHandler *cb,
                                                      void *opaque);
diff --git a/softmmu/runstate.c b/softmmu/runstate.c
index f3bd862818..a1f0653899 100644
--- a/softmmu/runstate.c
+++ b/softmmu/runstate.c
@@ -271,6 +271,7 @@ void qemu_system_vmstop_request(RunState state)
 }
 struct VMChangeStateEntry {
     VMChangeStateHandler *cb;
+    VMChangeStateHandler *pre_change_cb;
     void *opaque;
     QTAILQ_ENTRY(VMChangeStateEntry) entries;
     int priority;
@@ -293,12 +294,38 @@ static QTAILQ_HEAD(, VMChangeStateEntry) vm_change_state_head =
  */
 VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
         VMChangeStateHandler *cb, void *opaque, int priority)
+{
+    return qemu_add_vm_change_state_handler_prio_full(cb, NULL, opaque,
+                                                      priority);
+}
+
+/**
+ * qemu_add_vm_change_state_handler_prio_full:
+ * @cb: the main callback to invoke
+ * @pre_change_cb: a callback to invoke before the main callback
+ * @opaque: user data passed to the callbacks
+ * @priority: low priorities execute first when the vm runs and the reverse is
+ *            true when the vm stops
+ *
+ * Register a main callback function and an optional pre VM state change
+ * callback function that are invoked when the vm starts or stops running. The
+ * main callback and the pre VM state change callback are called in two
+ * separate phases: First all pre VM state change callbacks are called and only
+ * then all main callbacks are called.
+ *
+ * Returns: an entry to be freed using qemu_del_vm_change_state_handler()
+ */
+VMChangeStateEntry *
+qemu_add_vm_change_state_handler_prio_full(VMChangeStateHandler *cb,
+                                           VMChangeStateHandler *pre_change_cb,
+                                           void *opaque, int priority)
 {
     VMChangeStateEntry *e;
     VMChangeStateEntry *other;
 
     e = g_malloc0(sizeof(*e));
     e->cb = cb;
+    e->pre_change_cb = pre_change_cb;
     e->opaque = opaque;
     e->priority = priority;
 
@@ -333,10 +360,22 @@ void vm_state_notify(bool running, RunState state)
     trace_vm_state_notify(running, state, RunState_str(state));
 
     if (running) {
+        QTAILQ_FOREACH_SAFE(e, &vm_change_state_head, entries, next) {
+            if (e->pre_change_cb) {
+                e->pre_change_cb(e->opaque, running, state);
+            }
+        }
+
         QTAILQ_FOREACH_SAFE(e, &vm_change_state_head, entries, next) {
             e->cb(e->opaque, running, state);
         }
     } else {
+        QTAILQ_FOREACH_REVERSE_SAFE(e, &vm_change_state_head, entries, next) {
+            if (e->pre_change_cb) {
+                e->pre_change_cb(e->opaque, running, state);
+            }
+        }
+
         QTAILQ_FOREACH_REVERSE_SAFE(e, &vm_change_state_head, entries, next) {
             e->cb(e->opaque, running, state);
         }
-- 
2.26.3


