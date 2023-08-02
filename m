Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9981676C835
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 10:16:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR70o-0006Tm-7g; Wed, 02 Aug 2023 04:15:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qR70m-0006QK-0q
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 04:15:16 -0400
Received: from mail-mw2nam12on20607.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::607]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qR70j-0006OD-NW
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 04:15:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IaJkNIllZTAHRdFy28ZEGI9+v3KOTpSdog2QcobRvG6sHRjBNcjvDCzyCF/aidMqge39Q8GmyGuOlRbSc5YRrT7sj4B8XlKBXFwjT9B0ERvU3qk5My8l8ZFL0HuLWatexcULxGzvoSEsZIlNfHCvutyYlDiocmSpnlnysgp6cNxULbl2H7DVMYvS91RZVJKGc1ArDh5z81rvjJk+23GRdwx7j5z0CMAFvGSgwkVTRdlDQAIVAfuTqTtItXRleMidKOvxAREqdHYYgvYOzYDZfe2JvUJGUMSYvCVZUr/PwFTEo2AZk+Xydawc5CceCaB2zOQYwSFblD4rKXLy7SsdwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Z8KK1OuLXNINh93/PeHpPx0VHhqjtEVVX6bt0/1/gA=;
 b=iL9r5lvTTj+2G5U6VDwAy568Z0ZU2AiBYWcdJ+X871xrmpyN/fWXJwbDgnhUVlDNRZtEhOrSaiTuYSDdHNlSyIZGAZ8fz9MsiBLC5l+2ZOmW4hHj00lPy/AGRxXLuGdB9r2LTWtXStuQZyAIp1wfX+uQNaJB8v+Q37fgorTg+QU2TODHk2LTv2Xb5MbRO+ORUOajsVaT+wW07p/wzXAxnctQGz5mVtNpk6/8VV5wzgizhMbZ0WStTqCjZPPkPbh/s/p6DZ2dc3R45WcAyV/2rIynbHz4JGGWjTa63Nouur3R0m1dKGyJJf47jbvfy0BYYV29sYRjy+pC2wKUeCzu9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Z8KK1OuLXNINh93/PeHpPx0VHhqjtEVVX6bt0/1/gA=;
 b=Fi53GgsqcmSJmQYS8+QSwtokyg9S1sN7q+zT8cV2xZ0/7RHz4BQFa0/D7aNl4UT34upZSJqCJzQKcyvTPUS9rbG7tRzFSxgfhdPDY1N1i6Rt1/Djeu0s+zWhoXbSyf1qfwY5dvzIbp2Kdm5+pOQVm4QYUig1bVL9PkRc5sUG5o2kKjGH2ePP+r3d15mnMQJiQ4EqiuLIUHT34VSbGgHooDQ5Ei0eLEqwGYAHpauvAaixnbVrsL0Ch5Z/+NIXMrBgmrF9MbsncFVpy7UNKu3bOuXmW7Ihv6QEFso7fLKxdI6sLkctbuBsW7DqCDanrMFSGAL4TWN6s/wTFsl/WRq6Fw==
Received: from CY5PR22CA0071.namprd22.prod.outlook.com (2603:10b6:930:80::16)
 by SA1PR12MB6893.namprd12.prod.outlook.com (2603:10b6:806:24c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 08:15:09 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:80:cafe::fb) by CY5PR22CA0071.outlook.office365.com
 (2603:10b6:930:80::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45 via Frontend
 Transport; Wed, 2 Aug 2023 08:15:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 08:15:09 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 01:15:01 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 2 Aug 2023
 01:15:01 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Wed, 2 Aug
 2023 01:14:58 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, Yishai Hadas
 <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb
 <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta
 <targupta@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH for-8.2 v3 2/6] sysemu: Add prepare callback to struct
 VMChangeStateEntry
Date: Wed, 2 Aug 2023 11:14:45 +0300
Message-ID: <20230802081449.2528-3-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230802081449.2528-1-avihaih@nvidia.com>
References: <20230802081449.2528-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|SA1PR12MB6893:EE_
X-MS-Office365-Filtering-Correlation-Id: 53bbc9cd-89b8-4e88-ec9a-08db9330966a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 076ZI2GL2F4C44C5KBZUnTletJ2mYzw1pzniJokX5il5QCCtd0t1ePW5ZgmixouPwKH1Chl076h+6FQmcC2osDCYGgeMvVbd3kw9R85ahqxE8CbiDWuIeSURv/6aJKLk88JdqnyqYqHdNUl1x81bSzkxf2DgJtkyOSiT4V4u4vJ8BkdDrVMN+xiyymXbJMjXlaMTNCuxhxyRrtzsmj1NvnbhYAaz8weKKXTvGG5//w2zmH3Mqc5XZWiyAWWBY+/qZpmIHw/8k7/yVv+e2bA8893I+8U15974kYW87eLDSMdKiY7UyXVrM45dFigoZW2W+Mh8/iVgSalac4xpKoTlW1Z/EikmppIR/brdNxKxvt941mCy7nT3N5RI8EUfQh/QxRILl2+1jbomY+YOtRU7ztf6x4PvsDhCgvLYFARaSLJzxyQOmhrENM2NsWIf/pt48t1SvuH/AkvGc/clplTn5P+09+e4n9xObfBRv0OxxisSyihiBBijFddccfSU3bUJfDzK9V5IZEQSC8r8IKJ/Wxp1A5BZKpKwuK9cEoR2IFlnCRuGuWjTZ+cAj2I3MLxAgNGgpQ0zKv3vIyUED9uftDELLzyoOzAE26xh/TT5GNhkj7MIQzg5OuvYO9Sy4RZtUD8iqfvK2L18tosqF3CLiIaybKtAKmyLEAOcaULLfPgt/erB8H9dOIb/LwN4l6E3vSpCpxNfL4zGEWdpnfPQhUvl5wBlOY3098HKF7w16WVLO4NLk2m+YGBGC9J5YwQqBTAUMuUPfEf8LaSJ+KjckA==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(70206006)(70586007)(86362001)(6916009)(6666004)(7696005)(2906002)(107886003)(4326008)(54906003)(40480700001)(36756003)(40460700003)(478600001)(83380400001)(82740400003)(66574015)(426003)(41300700001)(47076005)(2616005)(7636003)(356005)(5660300002)(36860700001)(8936002)(8676002)(26005)(1076003)(316002)(186003)(336012)(145603002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 08:15:09.3422 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53bbc9cd-89b8-4e88-ec9a-08db9330966a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6893
Received-SPF: softfail client-ip=2a01:111:f400:fe5a::607;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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
Reviewed-by: Cédric Le Goater <clg@redhat.com>
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


