Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8097323E8
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 01:53:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9wm4-0002Sr-Lb; Thu, 15 Jun 2023 19:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1q9wm1-0002ST-Og
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 19:53:05 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1q9wlz-0003qN-Qu
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 19:53:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E80686128D;
 Thu, 15 Jun 2023 23:53:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE2EC433C8;
 Thu, 15 Jun 2023 23:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1686873182;
 bh=3ENhtJ7g55eokR1t2sQz3Yw99RyKv2wX7MV3C+fMgzI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KuCJwHtLqrYFG+NMXC5H/HP+WK9F5cXKKCsF9Knbra25GxqaF6KcUlbE1f9Fv1Aol
 TVGxqehZZf/vlBeUpQmvI5/CdFGpaIavx2LfxR0ctJvMbhKC3FCkVEAciXEtvBM/Ba
 juoQ1nyXrPFCMnljQjHvEUTRrPXxhDbglF3vk3FQA6sdSK9qWdMzpqjPdEWhrPgia4
 iourdA/NUtq1fYnvrOOgUl+iS+0JGhMhIunnB3KRy/F3b3J0pH80FoQWEKPY+YtPUj
 ZsSfFvF1iAnDDfoXHJURT59gZWpPw9WyoWePZv++euV0NqrWPubxUqIVmOfCalY1bs
 G1neODWpDVlvg==
From: Stefano Stabellini <sstabellini@kernel.org>
To: peter.maydell@linaro.org,
	richard.henderson@linaro.org
Cc: sstabellini@kernel.org, qemu-devel@nongnu.org, vikram.garhwal@amd.com,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL v5 03/11] hw/i386/xen/xen-hvm: move x86-specific fields out of
 XenIOState
Date: Thu, 15 Jun 2023 16:52:46 -0700
Message-Id: <20230615235254.1366267-3-sstabellini@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <alpine.DEB.2.22.394.2306151649350.897208@ubuntu-linux-20-04-desktop>
References: <alpine.DEB.2.22.394.2306151649350.897208@ubuntu-linux-20-04-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Stefano Stabellini <stefano.stabellini@amd.com>

In preparation to moving most of xen-hvm code to an arch-neutral location, move:
- shared_vmport_page
- log_for_dirtybit
- dirty_bitmap
- suspend
- wakeup

out of XenIOState struct as these are only used on x86, especially the ones
related to dirty logging.
Updated XenIOState can be used for both aarch64 and x86.

Also, remove free_phys_offset as it was unused.

Signed-off-by: Stefano Stabellini <stefano.stabellini@amd.com>
Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
Reviewed-by: Paul Durrant <paul@xen.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/i386/xen/xen-hvm.c | 58 ++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 31 deletions(-)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 7a7764240e..01bf947f1c 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -74,6 +74,7 @@ struct shared_vmport_iopage {
 };
 typedef struct shared_vmport_iopage shared_vmport_iopage_t;
 #endif
+static shared_vmport_iopage_t *shared_vmport_page;
 
 static inline uint32_t xen_vcpu_eport(shared_iopage_t *shared_page, int i)
 {
@@ -96,6 +97,11 @@ typedef struct XenPhysmap {
 } XenPhysmap;
 
 static QLIST_HEAD(, XenPhysmap) xen_physmap;
+static const XenPhysmap *log_for_dirtybit;
+/* Buffer used by xen_sync_dirty_bitmap */
+static unsigned long *dirty_bitmap;
+static Notifier suspend;
+static Notifier wakeup;
 
 typedef struct XenPciDevice {
     PCIDevice *pci_dev;
@@ -106,7 +112,6 @@ typedef struct XenPciDevice {
 typedef struct XenIOState {
     ioservid_t ioservid;
     shared_iopage_t *shared_page;
-    shared_vmport_iopage_t *shared_vmport_page;
     buffered_iopage_t *buffered_io_page;
     xenforeignmemory_resource_handle *fres;
     QEMUTimer *buffered_io_timer;
@@ -126,14 +131,8 @@ typedef struct XenIOState {
     MemoryListener io_listener;
     QLIST_HEAD(, XenPciDevice) dev_list;
     DeviceListener device_listener;
-    hwaddr free_phys_offset;
-    const XenPhysmap *log_for_dirtybit;
-    /* Buffer used by xen_sync_dirty_bitmap */
-    unsigned long *dirty_bitmap;
 
     Notifier exit;
-    Notifier suspend;
-    Notifier wakeup;
 } XenIOState;
 
 /* Xen specific function for piix pci */
@@ -463,10 +462,10 @@ static int xen_remove_from_physmap(XenIOState *state,
     }
 
     QLIST_REMOVE(physmap, list);
-    if (state->log_for_dirtybit == physmap) {
-        state->log_for_dirtybit = NULL;
-        g_free(state->dirty_bitmap);
-        state->dirty_bitmap = NULL;
+    if (log_for_dirtybit == physmap) {
+        log_for_dirtybit = NULL;
+        g_free(dirty_bitmap);
+        dirty_bitmap = NULL;
     }
     g_free(physmap);
 
@@ -627,16 +626,16 @@ static void xen_sync_dirty_bitmap(XenIOState *state,
         return;
     }
 
-    if (state->log_for_dirtybit == NULL) {
-        state->log_for_dirtybit = physmap;
-        state->dirty_bitmap = g_new(unsigned long, bitmap_size);
-    } else if (state->log_for_dirtybit != physmap) {
+    if (log_for_dirtybit == NULL) {
+        log_for_dirtybit = physmap;
+        dirty_bitmap = g_new(unsigned long, bitmap_size);
+    } else if (log_for_dirtybit != physmap) {
         /* Only one range for dirty bitmap can be tracked. */
         return;
     }
 
     rc = xen_track_dirty_vram(xen_domid, start_addr >> TARGET_PAGE_BITS,
-                              npages, state->dirty_bitmap);
+                              npages, dirty_bitmap);
     if (rc < 0) {
 #ifndef ENODATA
 #define ENODATA  ENOENT
@@ -651,7 +650,7 @@ static void xen_sync_dirty_bitmap(XenIOState *state,
     }
 
     for (i = 0; i < bitmap_size; i++) {
-        unsigned long map = state->dirty_bitmap[i];
+        unsigned long map = dirty_bitmap[i];
         while (map != 0) {
             j = ctzl(map);
             map &= ~(1ul << j);
@@ -677,12 +676,10 @@ static void xen_log_start(MemoryListener *listener,
 static void xen_log_stop(MemoryListener *listener, MemoryRegionSection *section,
                          int old, int new)
 {
-    XenIOState *state = container_of(listener, XenIOState, memory_listener);
-
     if (old & ~new & (1 << DIRTY_MEMORY_VGA)) {
-        state->log_for_dirtybit = NULL;
-        g_free(state->dirty_bitmap);
-        state->dirty_bitmap = NULL;
+        log_for_dirtybit = NULL;
+        g_free(dirty_bitmap);
+        dirty_bitmap = NULL;
         /* Disable dirty bit tracking */
         xen_track_dirty_vram(xen_domid, 0, 0, NULL);
     }
@@ -1022,9 +1019,9 @@ static void handle_vmport_ioreq(XenIOState *state, ioreq_t *req)
 {
     vmware_regs_t *vmport_regs;
 
-    assert(state->shared_vmport_page);
+    assert(shared_vmport_page);
     vmport_regs =
-        &state->shared_vmport_page->vcpu_vmport_regs[state->send_vcpu];
+        &shared_vmport_page->vcpu_vmport_regs[state->send_vcpu];
     QEMU_BUILD_BUG_ON(sizeof(*req) < sizeof(*vmport_regs));
 
     current_cpu = state->cpu_by_vcpu_id[state->send_vcpu];
@@ -1472,7 +1469,6 @@ void xen_hvm_init_pc(PCMachineState *pcms, MemoryRegion **ram_memory)
 
     state->memory_listener = xen_memory_listener;
     memory_listener_register(&state->memory_listener, &address_space_memory);
-    state->log_for_dirtybit = NULL;
 
     state->io_listener = xen_io_listener;
     memory_listener_register(&state->io_listener, &address_space_io);
@@ -1487,19 +1483,19 @@ void xen_hvm_init_pc(PCMachineState *pcms, MemoryRegion **ram_memory)
     QLIST_INIT(&xen_physmap);
     xen_read_physmap(state);
 
-    state->suspend.notify = xen_suspend_notifier;
-    qemu_register_suspend_notifier(&state->suspend);
+    suspend.notify = xen_suspend_notifier;
+    qemu_register_suspend_notifier(&suspend);
 
-    state->wakeup.notify = xen_wakeup_notifier;
-    qemu_register_wakeup_notifier(&state->wakeup);
+    wakeup.notify = xen_wakeup_notifier;
+    qemu_register_wakeup_notifier(&wakeup);
 
     rc = xen_get_vmport_regs_pfn(xen_xc, xen_domid, &ioreq_pfn);
     if (!rc) {
         DPRINTF("shared vmport page at pfn %lx\n", ioreq_pfn);
-        state->shared_vmport_page =
+        shared_vmport_page =
             xenforeignmemory_map(xen_fmem, xen_domid, PROT_READ|PROT_WRITE,
                                  1, &ioreq_pfn, NULL);
-        if (state->shared_vmport_page == NULL) {
+        if (shared_vmport_page == NULL) {
             error_report("map shared vmport IO page returned error %d handle=%p",
                          errno, xen_xc);
             goto err;
-- 
2.25.1


