Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9EA726700
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 19:17:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6wkT-0008QU-Kq; Wed, 07 Jun 2023 13:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1q6wkP-0008PJ-Vy
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 13:15:02 -0400
Received: from mail-bn1nam02on20614.outbound.protection.outlook.com
 ([2a01:111:f400:7eb2::614]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1q6wkN-0005vJ-Gd
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 13:15:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jAjhGAavfWMI7TbYgXANG2u7Dkm9D+eYjSeNUeaSyoTZjPV9cHtMzHYVCS+zJhKhW5/FOOa22m2ISa/lan9njFZbgM7r6sz84sstbHTlq1CXoD8akMeugh/+d2QqhUSXgg80Kf574KQqiesZdudQtYPXvYwjv8NmX8N4HTMvBmP164BG3dZTJPBJQhqCfCfyRCdiSiZqCLCi6VBb7+r0Qd6SO+4gfebKSu8GbuzCsqmfQ4OQizqRs+RIlkJE/v347ltonePho+h5ZNyXvmlSD1dOglayWP4tE8lEF9dqamAc/lkUDtWJ2Yo8RDx+VBwSGwht8qW92H3GKIwFD0q+2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZW0E+n9RRUnGndVzyavBgx17Uvpm/5a+kbmKjIpu9A4=;
 b=d4BQRnHCrF+UtGRdWO77flCs3u4y5Dx2da37V3jbGH6ZwQ2sGzrcY+ruGdfCvFLMjMvBlMv+q/t8FbiN+N4PYjfATTTHFQqP1G5bIX9tqZm9I6YpO5ZophELNGa8Mg9qjTXSNKNyukxKRLf6qUIUTf9I19X8GgVbcrXg14O3j2RRU0DYje9fGaWpkLojSV2eH6uhUOrqOMAu2y6oa4SaEnRLEO9ZckTvYQAOcbcYi6bwUBcgqPyeKHR5b8WHX2AYF0ZaJwsQ8+thDKTNHaYxK1kPILhk+D6mBRqaOyPSWB8C2y6C9uVcXlzPu2jzK0RDYKUniiFSzwnUmTXNt/gxqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZW0E+n9RRUnGndVzyavBgx17Uvpm/5a+kbmKjIpu9A4=;
 b=13hi/thcGrcsWeAgrNdJeVpYs4BWuhRCL/XZq6r2rolkv9rgAKvq+Xb02cPkB6ZzgXH2TOa4lLfylmC/iycau4zJeS6V824m0VRQOmrjgLbRQImwOaBgLXIu1IS4WVtiCg+OhIwCfAlpg5HMo24jnqQ+X+zsqJvOefyE7VbIECU=
Received: from DM6PR07CA0105.namprd07.prod.outlook.com (2603:10b6:5:330::8) by
 SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 17:14:56 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:5:330:cafe::af) by DM6PR07CA0105.outlook.office365.com
 (2603:10b6:5:330::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Wed, 7 Jun 2023 17:14:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 17:14:55 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 12:14:53 -0500
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 7 Jun 2023 12:14:53 -0500
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <sstabellini@kernel.org>, <vikram.garhwal@amd.com>, Stefano Stabellini
 <stefano.stabellini@amd.com>
Subject: [QEMU][PATCH v7 06/10] hw/xen/xen-hvm-common: skip ioreq creation on
 ioreq registration failure
Date: Wed, 7 Jun 2023 10:04:55 -0700
Message-ID: <20230607170459.14722-7-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230607170459.14722-1-vikram.garhwal@amd.com>
References: <20230607170459.14722-1-vikram.garhwal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|SJ2PR12MB8739:EE_
X-MS-Office365-Filtering-Correlation-Id: 076eba23-d7ca-4392-18eb-08db677ab71f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Opyz7fjPwpLWUXGUUuOBIjmNeo3fQ0VkchHwoRl2SmFWXPaghu7AqJuf7/a1QTL08CCU+m6W3JjDyuvzASEEHjQB3jhQoHlglMnlOM0arHRJN8u1E4/3WmBiq7SatiImaXrC5T7jLdZRZQYOAlaTYsCQeboeG53BX5Yp3qmIp3fvigK9rBTM7ckuUyiUcndoobCmBQJ7j4NahFO76udhd4H1RdTg/U1VuGyyZ2RpOe4yS5EfMdhO51o1qOIPJNnjmNGFkhL4IK0Y1KNH1tdMv8U4RgqGn8mHO9xhwf0jLVniP0MH8YCmym0QaFMYrH+AwKGaH9pyn53nbOo7gN5+1M4oe9H/xko2mvOEZEMICpCxaz3+FO17SGzAR3fDuJ8YakmS+L/Pg3WZaHDYA5gzy4K+khiYT4BTP1a1uJ/gGDH3tyh8ZMI5Wi9dUnYaQoc8/94tYyZXa4GUIQ4WMu4klaCo4GfUxmAvKHdYf6ij+hma/LX/S7e3/pt7JHXM5NSWkKNr5E/5L02AoylfhLtZVxSuB6yeqg3n6Bstz8Xs+0H88MRV44m/8Wf+bAJ18S0VOOO818m2Yt4RD58HaKIegFpuCkeNztFHtP7+HCFLLAnDdw1waY3w0wBgF6gpF4oScf23sj+H8sW7XmE3uJNMy7LyLeVfC5md1PxMUwL9iAVaUjF1V810EXY7tPEWVwhzyAYfYonaydI4Aq6mc/EdKKBUP6JDn0V3xzLx/HmOvoYOKllqlKNxje42vgZ3i7nKbCqE2WY4Y1CjByurrlK/5g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(2906002)(478600001)(47076005)(36860700001)(426003)(1076003)(186003)(82310400005)(83380400001)(2616005)(26005)(86362001)(82740400003)(81166007)(356005)(336012)(36756003)(70206006)(40480700001)(4326008)(6916009)(70586007)(5660300002)(44832011)(8936002)(8676002)(316002)(54906003)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 17:14:55.7902 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 076eba23-d7ca-4392-18eb-08db677ab71f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8739
Received-SPF: softfail client-ip=2a01:111:f400:7eb2::614;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Stefano Stabellini <stefano.stabellini@amd.com>

On ARM it is possible to have a functioning xenpv machine with only the
PV backends and no IOREQ server. If the IOREQ server creation fails continue
to the PV backends initialization.

Also, moved the IOREQ registration and mapping subroutine to new function
xen_do_ioreq_register().

Signed-off-by: Stefano Stabellini <stefano.stabellini@amd.com>
Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Reviewed-by: Paul Durrant <paul@xen.org>
---
 hw/xen/xen-hvm-common.c | 57 +++++++++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 19 deletions(-)

diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index a31b067404..cb82f4b83d 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -764,27 +764,12 @@ void xen_shutdown_fatal_error(const char *fmt, ...)
     qemu_system_shutdown_request(SHUTDOWN_CAUSE_HOST_ERROR);
 }
 
-void xen_register_ioreq(XenIOState *state, unsigned int max_cpus,
-                        MemoryListener xen_memory_listener)
+static void xen_do_ioreq_register(XenIOState *state,
+                                           unsigned int max_cpus,
+                                           MemoryListener xen_memory_listener)
 {
     int i, rc;
 
-    setup_xen_backend_ops();
-
-    state->xce_handle = qemu_xen_evtchn_open();
-    if (state->xce_handle == NULL) {
-        perror("xen: event channel open");
-        goto err;
-    }
-
-    state->xenstore = xs_daemon_open();
-    if (state->xenstore == NULL) {
-        perror("xen: xenstore open");
-        goto err;
-    }
-
-    xen_create_ioreq_server(xen_domid, &state->ioservid);
-
     state->exit.notify = xen_exit_notifier;
     qemu_add_exit_notifier(&state->exit);
 
@@ -849,12 +834,46 @@ void xen_register_ioreq(XenIOState *state, unsigned int max_cpus,
     QLIST_INIT(&state->dev_list);
     device_listener_register(&state->device_listener);
 
+    return;
+
+err:
+    error_report("xen hardware virtual machine initialisation failed");
+    exit(1);
+}
+
+void xen_register_ioreq(XenIOState *state, unsigned int max_cpus,
+                        MemoryListener xen_memory_listener)
+{
+    int rc;
+
+    setup_xen_backend_ops();
+
+    state->xce_handle = qemu_xen_evtchn_open();
+    if (state->xce_handle == NULL) {
+        perror("xen: event channel open");
+        goto err;
+    }
+
+    state->xenstore = xs_daemon_open();
+    if (state->xenstore == NULL) {
+        perror("xen: xenstore open");
+        goto err;
+    }
+
+    rc = xen_create_ioreq_server(xen_domid, &state->ioservid);
+    if (!rc) {
+        xen_do_ioreq_register(state, max_cpus, xen_memory_listener);
+    } else {
+        warn_report("xen: failed to create ioreq server");
+    }
+
     xen_bus_init();
 
     xen_be_init();
 
     return;
+
 err:
-    error_report("xen hardware virtual machine initialisation failed");
+    error_report("xen hardware virtual machine backend registration failed");
     exit(1);
 }
-- 
2.17.1


