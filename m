Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A61769319
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 12:28:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQQ6t-0000gq-Ma; Mon, 31 Jul 2023 06:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qQQ6C-0000bp-M1
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 06:26:01 -0400
Received: from mail-co1nam11on20606.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::606]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qQQ66-0006tv-Cm
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 06:25:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OalwJpgBKcJmwu/6crxleyysZI5wl7Fdl7XibJ59jLHURbf+1mgFpvVdHBp/+sG302xGdEbOBZ0bTng/Wede4mFyjRMTjKd7jusezfnCVG7W0votjAhHUnwGYtffSVNEqfUQUfQ2C9wlPK7v40PwfWySpqhEDqfZZLSt2psno/7ZUcJY6SJFndNFP2tIO0BfqGNI/32+0VF7L839yDCLonDM+mdJuiTh3nnI6YUpHwOYKwSwwU03fDEcaOSBrWSo7ePDwL0Gi02Hl95fi4TtuD183z8dxew6H14quNOwBTuDxlXY7yNY6+emBWzOXm75TR3HPUiRRDE/f+eImrSMBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8k5DOiHAirpYEv9iN5HRTeF1jcAK3qaPnpCUyNvjWI=;
 b=PQ0ntGRNjL53v9KftzW9aRRirpxu67mVY3FKtk5YUOwYgbXLkAGxWwEZgvBlStXTi+SmVks15qqBvwI4Sulc3fw8Z2cthMaM3yb5rb7qk0OYGDHQqsibLY4IQatl40REMVuB7TLMBjQTlh/dtyFH08Gltw85SiH7Ah/SPeCJ+roCYJtuFGAlgUu2Pwb9G+GeiyAeo5DZAjktZj2dPs2IqLKake7r4C2ufQ2KKlyMpT7qFPrzaE9o70Rj4WQauJFa9Sqzu5fHugrEBlJ+pn3JPBcGQ8llouy1gf9JJTLtXFE+v2068fszjn5uhSlpJAVw11ek1CrA10ODpY4v2JBb9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8k5DOiHAirpYEv9iN5HRTeF1jcAK3qaPnpCUyNvjWI=;
 b=kkIsgSA2OJQaW1QidtA1fnyPGr4rA1/XdoY/K9BKpvMLb9tsU/iqpmpCb+G11i8RR2N1599dcMK6yaWT1AeEP56060skjhwoQDlweGX/0ibt5JAZuohpcX99QGDmx+Wznu6wYLPtU94GRu0z4zRbAayioesBXtmg+cOkbwaxNSfWe1D0vhm6vjaPhTpJCE3M1nRHhCurB46r6QG5scSC3tv+hKat/qjg3n36CYyd5PGP/xyc4LccqIfnZNIpYTnAC4s5PfVodvLuh/XJ11/TESIcjX+DgNyYgDXo2QdfYAfAvYFSJnmOMLUEsCojID3Sn6xqQBRm3hziLCLkjoii8w==
Received: from BY5PR17CA0020.namprd17.prod.outlook.com (2603:10b6:a03:1b8::33)
 by MN0PR12MB5739.namprd12.prod.outlook.com (2603:10b6:208:372::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Mon, 31 Jul
 2023 10:25:49 +0000
Received: from DM6NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:1b8:cafe::cb) by BY5PR17CA0020.outlook.office365.com
 (2603:10b6:a03:1b8::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43 via Frontend
 Transport; Mon, 31 Jul 2023 10:25:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT115.mail.protection.outlook.com (10.13.173.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.44 via Frontend Transport; Mon, 31 Jul 2023 10:25:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 31 Jul 2023
 03:25:32 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 31 Jul
 2023 03:25:32 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Mon, 31 Jul
 2023 03:25:29 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, Yishai Hadas
 <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb
 <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta
 <targupta@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH for-8.2 v2 2/6] sysemu: Add prepare callback to struct
 VMChangeStateEntry
Date: Mon, 31 Jul 2023 13:25:17 +0300
Message-ID: <20230731102521.15335-3-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230731102521.15335-1-avihaih@nvidia.com>
References: <20230731102521.15335-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT115:EE_|MN0PR12MB5739:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dcb6c53-c782-449f-015c-08db91b08223
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9T7Ce9407xdLAtm8/Pag8rKrhZVHrhHSb1whIHUnkGnyHNMNRUfFXGdTfLIQo3JjMqUQA33Mi/i+hKcsWU15879qDnRgcXxcIqSxrwS5TJ86fYKsJ0HkJqrr2KbIaIXMJxvdV3M+U9ofatStExHmtHt60bRAHRPOa0MhbCudPbD1jIQ/XQaXNkuDjqiIGtn2BNrJVBOPZ+Cp/aOHOqFLk+1j90Z7EI3Qp38Ul9ZfdlTZn0HJhiYwk4ER/TCQApQarAagWja3ICX/fJ0xeNkn0usZdiVZ8BOHoIYG8NUpS0eifZYvgReSfit5y4r8WvqQATtfU10/9wVqz8jQZ2oYH2+lJkNVFMSyTEe2/TsQZHTl5zXsPlZl4MY+OtzWo8mV6S/ypig6jQky/bItl91QcboyDZjhaqdrk2WM12TZEREKEDJfLi4ZBUcvBt7RwibArg900/UEoh6y9Gm6R/75gd0pq/DISd6cA2im/lwc/AX8085iVZ/loN4TuElTwl0mxRRrkU2QS5AbuFH/lNu4oZH2wNRBSctFObLvEPmJjyVsyISg9oFsrNhSCdWVxth4teRFqqMxTjl/3OktQf6R2Db0Xt8H52j4fqOxAD97zV0fVqANiEJj/PW+RSLnUvH8VmA8KpQNWKom/cfIBLX2iTv/XGIUA+ygZqFoHQCEnqx16RSXDX2CMiEdrNsViU0d2kXXL3XCwoWkb6EMHqAV4RLLy54TvDZOAHMt+ItZNPhNcu2dDGqwUmw5Gxwig/XIA4M12tFU6afWzL+2g+UjdQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(6666004)(7696005)(26005)(1076003)(47076005)(2906002)(186003)(336012)(107886003)(54906003)(478600001)(82740400003)(2616005)(36860700001)(7636003)(356005)(426003)(83380400001)(316002)(70586007)(70206006)(4326008)(6916009)(40460700003)(41300700001)(8676002)(8936002)(5660300002)(40480700001)(36756003)(86362001)(145603002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 10:25:48.5254 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dcb6c53-c782-449f-015c-08db91b08223
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5739
Received-SPF: softfail client-ip=2a01:111:f400:7eab::606;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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

Add prepare callback to struct VMChangeStateEntry.

The prepare callback is optional and can be set by the new function
qemu_add_vm_change_state_handler_prio_full() that allows setting this
callback in addition to the main callback.

The prepare callbacks and main callbacks are called in two separate
phases: First all prepare callbacks are called and only then all main
callbacks are called.

The purpose of the new prepare callback is to allow all devices to run a
preliminary task before calling the devices' main callbacks.

This will facilitate adding P2P support for VFIO migration where all
VFIO devices need to be put in an intermediate P2P quiescent state
before being stopped or started by the main callback.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 include/sysemu/runstate.h |  4 ++++
 softmmu/runstate.c        | 40 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
index 7beb29c2e2..764a0fc6a4 100644
--- a/include/sysemu/runstate.h
+++ b/include/sysemu/runstate.h
@@ -16,6 +16,10 @@ VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandler *cb,
                                                      void *opaque);
 VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
         VMChangeStateHandler *cb, void *opaque, int priority);
+VMChangeStateEntry *
+qemu_add_vm_change_state_handler_prio_full(VMChangeStateHandler *cb,
+                                           VMChangeStateHandler *prepare_cb,
+                                           void *opaque, int priority);
 VMChangeStateEntry *qdev_add_vm_change_state_handler(DeviceState *dev,
                                                      VMChangeStateHandler *cb,
                                                      void *opaque);
diff --git a/softmmu/runstate.c b/softmmu/runstate.c
index f3bd862818..1652ed0439 100644
--- a/softmmu/runstate.c
+++ b/softmmu/runstate.c
@@ -271,6 +271,7 @@ void qemu_system_vmstop_request(RunState state)
 }
 struct VMChangeStateEntry {
     VMChangeStateHandler *cb;
+    VMChangeStateHandler *prepare_cb;
     void *opaque;
     QTAILQ_ENTRY(VMChangeStateEntry) entries;
     int priority;
@@ -293,12 +294,39 @@ static QTAILQ_HEAD(, VMChangeStateEntry) vm_change_state_head =
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
+ * @prepare_cb: a callback to invoke before the main callback
+ * @opaque: user data passed to the callbacks
+ * @priority: low priorities execute first when the vm runs and the reverse is
+ *            true when the vm stops
+ *
+ * Register a main callback function and an optional prepare callback function
+ * that are invoked when the vm starts or stops running. The main callback and
+ * the prepare callback are called in two separate phases: First all prepare
+ * callbacks are called and only then all main callbacks are called. As its
+ * name suggests, the prepare callback can be used to do some preparatory work
+ * before invoking the main callback.
+ *
+ * Returns: an entry to be freed using qemu_del_vm_change_state_handler()
+ */
+VMChangeStateEntry *
+qemu_add_vm_change_state_handler_prio_full(VMChangeStateHandler *cb,
+                                           VMChangeStateHandler *prepare_cb,
+                                           void *opaque, int priority)
 {
     VMChangeStateEntry *e;
     VMChangeStateEntry *other;
 
     e = g_malloc0(sizeof(*e));
     e->cb = cb;
+    e->prepare_cb = prepare_cb;
     e->opaque = opaque;
     e->priority = priority;
 
@@ -333,10 +361,22 @@ void vm_state_notify(bool running, RunState state)
     trace_vm_state_notify(running, state, RunState_str(state));
 
     if (running) {
+        QTAILQ_FOREACH_SAFE(e, &vm_change_state_head, entries, next) {
+            if (e->prepare_cb) {
+                e->prepare_cb(e->opaque, running, state);
+            }
+        }
+
         QTAILQ_FOREACH_SAFE(e, &vm_change_state_head, entries, next) {
             e->cb(e->opaque, running, state);
         }
     } else {
+        QTAILQ_FOREACH_REVERSE_SAFE(e, &vm_change_state_head, entries, next) {
+            if (e->prepare_cb) {
+                e->prepare_cb(e->opaque, running, state);
+            }
+        }
+
         QTAILQ_FOREACH_REVERSE_SAFE(e, &vm_change_state_head, entries, next) {
             e->cb(e->opaque, running, state);
         }
-- 
2.26.3


