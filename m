Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B08E7850E1
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 08:55:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYhla-0004EV-Dn; Wed, 23 Aug 2023 02:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qYhlY-0004EA-2D
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 02:54:56 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qYhlV-0001IC-RO
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 02:54:55 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 350CF1C40B
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 09:54:22 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id A8F22212AD;
 Wed, 23 Aug 2023 09:54:02 +0300 (MSK)
Received: (nullmailer pid 1919484 invoked by uid 1000);
 Wed, 23 Aug 2023 06:54:00 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 17/24] xen: spelling fixes
Date: Wed, 23 Aug 2023 09:53:28 +0300
Message-Id: <20230823065335.1919380-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230823055155.1917375-1-mjt@tls.msk.ru>
References: <20230823055155.1917375-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/xen/xen_pvdev.c                             | 2 +-
 include/hw/xen/interface/arch-x86/xen-x86_64.h | 2 +-
 include/hw/xen/interface/arch-x86/xen.h        | 2 +-
 include/hw/xen/interface/event_channel.h       | 2 +-
 include/hw/xen/interface/grant_table.h         | 2 +-
 include/hw/xen/interface/hvm/hvm_op.h          | 2 +-
 include/hw/xen/interface/io/blkif.h            | 6 +++---
 include/hw/xen/interface/io/fbif.h             | 2 +-
 include/hw/xen/interface/io/kbdif.h            | 2 +-
 include/hw/xen/interface/memory.h              | 2 +-
 include/hw/xen/interface/physdev.h             | 4 ++--
 include/hw/xen/interface/xen.h                 | 4 ++--
 12 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/hw/xen/xen_pvdev.c b/hw/xen/xen_pvdev.c
index be1504b82c..c5ad71e8dc 100644
--- a/hw/xen/xen_pvdev.c
+++ b/hw/xen/xen_pvdev.c
@@ -90,5 +90,5 @@ char *xenstore_read_str(const char *base, const char *node)
     if (str != NULL) {
         /* move to qemu-allocated memory to make sure
-         * callers can savely g_free() stuff. */
+         * callers can safely g_free() stuff. */
         ret = g_strdup(str);
         free(str);
diff --git a/include/hw/xen/interface/arch-x86/xen-x86_64.h b/include/hw/xen/interface/arch-x86/xen-x86_64.h
index 40aed14366..eae96f4f67 100644
--- a/include/hw/xen/interface/arch-x86/xen-x86_64.h
+++ b/include/hw/xen/interface/arch-x86/xen-x86_64.h
@@ -107,5 +107,5 @@
  *   RING2 -> RING3 kernel mode.
  *   RING3 -> RING3 user mode.
- * However RING0 indicates that the guest kernel should return to iteself
+ * However RING0 indicates that the guest kernel should return to itself
  * directly with
  *      orb   $3,1*8(%rsp)
diff --git a/include/hw/xen/interface/arch-x86/xen.h b/include/hw/xen/interface/arch-x86/xen.h
index 7acd94c8eb..efa67d1499 100644
--- a/include/hw/xen/interface/arch-x86/xen.h
+++ b/include/hw/xen/interface/arch-x86/xen.h
@@ -140,5 +140,5 @@ typedef unsigned long xen_ulong_t;
  * interrupt. On x86/64, since rings 1 and 2 are unavailable, we allocate
  * privilege levels as follows:
- *  Level == 0: Noone may enter
+ *  Level == 0: No one may enter
  *  Level == 1: Kernel may enter
  *  Level == 2: Kernel may enter
diff --git a/include/hw/xen/interface/event_channel.h b/include/hw/xen/interface/event_channel.h
index 73c9f38ce1..9073d3852f 100644
--- a/include/hw/xen/interface/event_channel.h
+++ b/include/hw/xen/interface/event_channel.h
@@ -320,5 +320,5 @@ typedef struct evtchn_set_priority evtchn_set_priority_t;
  * ` HYPERVISOR_event_channel_op_compat(struct evtchn_op *op)
  * `
- * Superceded by new event_channel_op() hypercall since 0x00030202.
+ * Superseded by new event_channel_op() hypercall since 0x00030202.
  */
 struct evtchn_op {
diff --git a/include/hw/xen/interface/grant_table.h b/include/hw/xen/interface/grant_table.h
index 7934d7b718..f8e4398ecd 100644
--- a/include/hw/xen/interface/grant_table.h
+++ b/include/hw/xen/interface/grant_table.h
@@ -625,5 +625,5 @@ DEFINE_XEN_GUEST_HANDLE(gnttab_cache_flush_t);
   * GNTMAP_contains_pte subflag:
   *  0 => This map request contains a host virtual address.
-  *  1 => This map request contains the machine addess of the PTE to update.
+  *  1 => This map request contains the machine address of the PTE to update.
   */
 #define _GNTMAP_contains_pte    (4)
diff --git a/include/hw/xen/interface/hvm/hvm_op.h b/include/hw/xen/interface/hvm/hvm_op.h
index 870ec52060..188960da7e 100644
--- a/include/hw/xen/interface/hvm/hvm_op.h
+++ b/include/hw/xen/interface/hvm/hvm_op.h
@@ -355,5 +355,5 @@ struct xen_hvm_altp2m_op {
 /* Get the active vcpu p2m index */
 #define HVMOP_altp2m_get_p2m_idx          14
-/* Set the "Supress #VE" bit for a range of pages */
+/* Set the "Suppress #VE" bit for a range of pages */
 #define HVMOP_altp2m_set_suppress_ve_multi 15
 /* Set visibility for a given altp2m view */
diff --git a/include/hw/xen/interface/io/blkif.h b/include/hw/xen/interface/io/blkif.h
index 4cdba79aba..507d5170db 100644
--- a/include/hw/xen/interface/io/blkif.h
+++ b/include/hw/xen/interface/io/blkif.h
@@ -60,5 +60,5 @@
  * values are encoded in decimal.  Integer value ranges listed below are
  * expressed as fixed sized integer types capable of storing the conversion
- * of a properly formated node string, without loss of information.
+ * of a properly formatted node string, without loss of information.
  *
  * Any specified default value is in effect if the corresponding XenBus node
@@ -259,5 +259,5 @@
  *
  *      NOTE: Because of implementation bugs in some frontends this must be
- *            set to 512, unless the frontend advertizes a non-zero value
+ *            set to 512, unless the frontend advertises a non-zero value
  *            in its "feature-large-sector-size" xenbus node. (See below).
  *
@@ -416,5 +416,5 @@
  * (9) Linux implementation doesn't have a limit on the maximum number of
  *     grants that can be persistently mapped in the frontend driver, but
- *     due to the frontent driver implementation it should never be bigger
+ *     due to the frontend driver implementation it should never be bigger
  *     than RING_SIZE * BLKIF_MAX_SEGMENTS_PER_REQUEST.
  *(10) The discard-secure property may be present and will be set to 1 if the
diff --git a/include/hw/xen/interface/io/fbif.h b/include/hw/xen/interface/io/fbif.h
index cc25aab32e..098561c55a 100644
--- a/include/hw/xen/interface/io/fbif.h
+++ b/include/hw/xen/interface/io/fbif.h
@@ -90,5 +90,5 @@ union xenfb_out_event
  * refresh the framebuffer (and send an update notification event if
  * those have been requested), then use the update frequency to guide
- * their periodical refreshs.
+ * their periodical refreshes.
  */
 #define XENFB_TYPE_REFRESH_PERIOD 1
diff --git a/include/hw/xen/interface/io/kbdif.h b/include/hw/xen/interface/io/kbdif.h
index a6b01c52c7..6fb73c8004 100644
--- a/include/hw/xen/interface/io/kbdif.h
+++ b/include/hw/xen/interface/io/kbdif.h
@@ -40,5 +40,5 @@
  * values are encoded in decimal. Integer value ranges listed below are
  * expressed as fixed sized integer types capable of storing the conversion
- * of a properly formated node string, without loss of information.
+ * of a properly formatted node string, without loss of information.
  *
  *****************************************************************************
diff --git a/include/hw/xen/interface/memory.h b/include/hw/xen/interface/memory.h
index 383a9468c3..b5edabf63c 100644
--- a/include/hw/xen/interface/memory.h
+++ b/include/hw/xen/interface/memory.h
@@ -185,5 +185,5 @@ struct xen_machphys_mfn_list {
     /*
      * Pointer to buffer to fill with list of extent starts. If there are
-     * any large discontiguities in the machine address space, 2MB gaps in
+     * any large discontinuities in the machine address space, 2MB gaps in
      * the machphys table will be represented by an MFN base of zero.
      */
diff --git a/include/hw/xen/interface/physdev.h b/include/hw/xen/interface/physdev.h
index d271766ad0..55cd5892ac 100644
--- a/include/hw/xen/interface/physdev.h
+++ b/include/hw/xen/interface/physdev.h
@@ -224,5 +224,5 @@ DEFINE_XEN_GUEST_HANDLE(physdev_manage_pci_ext_t);
 
 /*
- * Argument to physdev_op_compat() hypercall. Superceded by new physdev_op()
+ * Argument to physdev_op_compat() hypercall. Superseded by new physdev_op()
  * hypercall since 0x00030202.
  */
@@ -350,5 +350,5 @@ DEFINE_XEN_GUEST_HANDLE(physdev_dbgp_op_t);
 #if __XEN_INTERFACE_VERSION__ < 0x00040600
 /*
- * These all-capitals physdev operation names are superceded by the new names
+ * These all-capitals physdev operation names are superseded by the new names
  * (defined above) since interface version 0x00030202. The guard above was
  * added post-4.5 only though and hence shouldn't check for 0x00030202.
diff --git a/include/hw/xen/interface/xen.h b/include/hw/xen/interface/xen.h
index e373592c33..8c7914bbfb 100644
--- a/include/hw/xen/interface/xen.h
+++ b/include/hw/xen/interface/xen.h
@@ -607,5 +607,5 @@ DEFINE_XEN_GUEST_HANDLE(mmuext_op_t);
 
 /*
- * DOMID_COW is used as the owner of sharable pages */
+ * DOMID_COW is used as the owner of shareable pages */
 #define DOMID_COW            xen_mk_uint(0x7FF3)
 
@@ -751,5 +751,5 @@ struct shared_info {
      *  1. Bi-directional inter- and intra-domain connections. Domains must
      *     arrange out-of-band to set up a connection (usually by allocating
-     *     an unbound 'listener' port and avertising that via a storage service
+     *     an unbound 'listener' port and advertising that via a storage service
      *     such as xenstore).
      *  2. Physical interrupts. A domain with suitable hardware-access
-- 
2.39.2


