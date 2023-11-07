Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B34667E4A82
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 22:21:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0TVG-0002lX-LT; Tue, 07 Nov 2023 16:20:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1r0TVE-0002lO-Ks
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 16:20:52 -0500
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1r0TVC-0003tE-Nw
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 16:20:52 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id C5426CE0FAA;
 Tue,  7 Nov 2023 21:20:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E7EC433C7;
 Tue,  7 Nov 2023 21:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1699392046;
 bh=69eW2RusrhA7ek77sLaWTrb3wjFCENvxmO6mpbHjVow=;
 h=Date:From:To:cc:Subject:From;
 b=GnTDu19g5UEh7kpfo4AIDAGOJjUY1zYHLpUdYhmgfZOdluiZuXTTGX8nnA2N3Ck2r
 1muvcC0x8B8TedFFApGg2E/bG3rJ2+cJuu/Mf/3SGKK94bAG8R0OsiaRPIG1PNC2G2
 nE6+GRnFGgLtbfJxwqU/SgJVcnyL5+cf4dpdsqqUMNhpb4WRIs8VYHHV1XK/N7F8QO
 +sSMoCqNJK92M7DEO3Dm5UUZpoBmrNgCdRZPPsoTQzQCf9a67kRL+FSTJI51ccvJdF
 MmrxUzNh8m6fRkT+C9Z/LpZRdrR3aJxqVGAQsnaGrMsI1FOjQZufPYi8Ihz9fu5SIZ
 nbvbXizFXnwoQ==
Date: Tue, 7 Nov 2023 13:20:43 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: qemu-devel@nongnu.org
cc: stefanha@redhat.com, peter.maydell@linaro.org, sstabellini@kernel.org, 
 vikram.garhwal@amd.com
Subject: [PULL 1/1] Xen: Fix xen_set_irq() and xendevicemodel_set_irq_level()
Message-ID: <alpine.DEB.2.22.394.2311071319530.3478774@ubuntu-linux-20-04-desktop>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=sstabellini@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Remove '=' from 'if CONFIG_XEN_CTRL_INTERFACE_VERSION <= 41500'.
Because xendevicemodel_set_irq_level() was introduced in 4.15 version.

Also, update xendevicemodel_set_irq_level() to return -1 for older versions.

Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/arm/xen_arm.c            | 4 +++-
 include/hw/xen/xen_native.h | 4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
index f83b983ec5..a5631529d0 100644
--- a/hw/arm/xen_arm.c
+++ b/hw/arm/xen_arm.c
@@ -75,7 +75,9 @@ static MemoryRegion ram_lo, ram_hi;
 
 static void xen_set_irq(void *opaque, int irq, int level)
 {
-    xendevicemodel_set_irq_level(xen_dmod, xen_domid, irq, level);
+    if (xendevicemodel_set_irq_level(xen_dmod, xen_domid, irq, level)) {
+        error_report("xendevicemodel_set_irq_level failed");
+    }
 }
 
 static void xen_create_virtio_mmio_devices(XenArmState *xam)
diff --git a/include/hw/xen/xen_native.h b/include/hw/xen/xen_native.h
index 5d2718261f..6f09c48823 100644
--- a/include/hw/xen/xen_native.h
+++ b/include/hw/xen/xen_native.h
@@ -523,12 +523,12 @@ static inline int xen_set_ioreq_server_state(domid_t dom,
                                                  enable);
 }
 
-#if CONFIG_XEN_CTRL_INTERFACE_VERSION <= 41500
+#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 41500
 static inline int xendevicemodel_set_irq_level(xendevicemodel_handle *dmod,
                                                domid_t domid, uint32_t irq,
                                                unsigned int level)
 {
-    return 0;
+    return -1;
 }
 #endif
 
-- 
2.25.1


