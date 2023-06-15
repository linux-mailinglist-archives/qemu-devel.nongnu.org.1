Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2127323ED
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 01:54:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9wmE-0002Xf-Lu; Thu, 15 Jun 2023 19:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1q9wm7-0002TT-8a
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 19:53:11 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1q9wm5-0003qN-Ac
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 19:53:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D530F613E2;
 Thu, 15 Jun 2023 23:53:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0A9C433CA;
 Thu, 15 Jun 2023 23:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1686873188;
 bh=StE9EQZ/cbvXv90I/dH/Pb6J0YEc6PobNdBqFEVZB70=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=X7SWjgyl19oC0SZwz2iz7bHlBpwEN0SxJQZGP2y6XNCrJXb/s4REhcf3/Mz3UBSfI
 uhbfYa5tEGhm5xXCYHqo0F6gXjpxuJgRHVP8SWQlXvCfY8X0tx4D7AJUSjiUtD8SUr
 1ID0XLhDCrAaOAlsmRPeyP/ANdPCM2QLtJR/N17uhS3K2cQwZj0Yn5Cle5QV5X1X/k
 uXYJLWMlB9v2LlviW/lasRvLfA6BNxsCzCuA+/OAy8hHgI0mVvO7HdAs5My8dwZdIG
 kdD16EdP/DTiMSEdVu0G6j5toCkCPMHnIdYLxlRax6F8FBKo36+C6CN3uc7Eqrnppy
 FaVgO8Cpvcl9A==
From: Stefano Stabellini <sstabellini@kernel.org>
To: peter.maydell@linaro.org,
	richard.henderson@linaro.org
Cc: sstabellini@kernel.org, qemu-devel@nongnu.org, vikram.garhwal@amd.com,
 Paul Durrant <paul@xen.org>
Subject: [PULL v5 07/11] hw/xen/xen-hvm-common: Use g_new and error_report
Date: Thu, 15 Jun 2023 16:52:50 -0700
Message-Id: <20230615235254.1366267-7-sstabellini@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <alpine.DEB.2.22.394.2306151649350.897208@ubuntu-linux-20-04-desktop>
References: <alpine.DEB.2.22.394.2306151649350.897208@ubuntu-linux-20-04-desktop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=sstabellini@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Vikram Garhwal <vikram.garhwal@amd.com>

Replace g_malloc with g_new and perror with error_report.

Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Reviewed-by: Paul Durrant <paul@xen.org>
---
 hw/xen/xen-hvm-common.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index cb82f4b83d..42339c96bd 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -33,7 +33,7 @@ void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size, MemoryRegion *mr,
     trace_xen_ram_alloc(ram_addr, size);
 
     nr_pfn = size >> TARGET_PAGE_BITS;
-    pfn_list = g_malloc(sizeof (*pfn_list) * nr_pfn);
+    pfn_list = g_new(xen_pfn_t, nr_pfn);
 
     for (i = 0; i < nr_pfn; i++) {
         pfn_list[i] = (ram_addr >> TARGET_PAGE_BITS) + i;
@@ -730,7 +730,7 @@ void destroy_hvm_domain(bool reboot)
             return;
         }
         if (errno != ENOTTY /* old Xen */) {
-            perror("xendevicemodel_shutdown failed");
+            error_report("xendevicemodel_shutdown failed with error %d", errno);
         }
         /* well, try the old thing then */
     }
@@ -784,7 +784,7 @@ static void xen_do_ioreq_register(XenIOState *state,
     }
 
     /* Note: cpus is empty at this point in init */
-    state->cpu_by_vcpu_id = g_malloc0(max_cpus * sizeof(CPUState *));
+    state->cpu_by_vcpu_id = g_new0(CPUState *, max_cpus);
 
     rc = xen_set_ioreq_server_state(xen_domid, state->ioservid, true);
     if (rc < 0) {
@@ -793,7 +793,7 @@ static void xen_do_ioreq_register(XenIOState *state,
         goto err;
     }
 
-    state->ioreq_local_port = g_malloc0(max_cpus * sizeof (evtchn_port_t));
+    state->ioreq_local_port = g_new0(evtchn_port_t, max_cpus);
 
     /* FIXME: how about if we overflow the page here? */
     for (i = 0; i < max_cpus; i++) {
@@ -850,13 +850,13 @@ void xen_register_ioreq(XenIOState *state, unsigned int max_cpus,
 
     state->xce_handle = qemu_xen_evtchn_open();
     if (state->xce_handle == NULL) {
-        perror("xen: event channel open");
+        error_report("xen: event channel open failed with error %d", errno);
         goto err;
     }
 
     state->xenstore = xs_daemon_open();
     if (state->xenstore == NULL) {
-        perror("xen: xenstore open");
+        error_report("xen: xenstore open failed with error %d", errno);
         goto err;
     }
 
-- 
2.25.1


