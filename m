Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED94753A07
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 13:47:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKH9v-0001hV-Fq; Fri, 14 Jul 2023 07:40:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKH9m-00019j-65; Fri, 14 Jul 2023 07:40:18 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKH9k-0004bR-5C; Fri, 14 Jul 2023 07:40:17 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 50B9513DA1;
 Fri, 14 Jul 2023 14:38:58 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 48ABE14BB0;
 Fri, 14 Jul 2023 14:38:42 +0300 (MSK)
Received: (nullmailer pid 1186259 invoked by uid 1000);
 Fri, 14 Jul 2023 11:38:38 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH, trivial 21/29] tree-wide spelling fixes in comments and some
 messages: xen
Date: Fri, 14 Jul 2023 14:38:26 +0300
Message-Id: <20230714113834.1186117-23-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230714113834.1186117-1-mjt@tls.msk.ru>
References: <20230714113834.1186117-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
 include/hw/xen/interface/sched.h               | 2 +-
 include/hw/xen/interface/xen.h                 | 4 ++--
 13 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/hw/xen/xen_pvdev.c b/hw/xen/xen_pvdev.c
index be1504b82c..c5ad71e8dc 100644
--- a/hw/xen/xen_pvdev.c
+++ b/hw/xen/xen_pvdev.c
@@ -91,3 +91,3 @@ char *xenstore_read_str(const char *base, const char *node)
         /* move to qemu-allocated memory to make sure
-         * callers can savely g_free() stuff. */
+         * callers can safely g_free() stuff. */
         ret = g_strdup(str);
diff --git a/include/hw/xen/interface/arch-x86/xen-x86_64.h b/include/hw/xen/interface/arch-x86/xen-x86_64.h
index 40aed14366..eae96f4f67 100644
--- a/include/hw/xen/interface/arch-x86/xen-x86_64.h
+++ b/include/hw/xen/interface/arch-x86/xen-x86_64.h
@@ -108,3 +108,3 @@
  *   RING3 -> RING3 user mode.
- * However RING0 indicates that the guest kernel should return to iteself
+ * However RING0 indicates that the guest kernel should return to itself
  * directly with
diff --git a/include/hw/xen/interface/arch-x86/xen.h b/include/hw/xen/interface/arch-x86/xen.h
index 7acd94c8eb..efa67d1499 100644
--- a/include/hw/xen/interface/arch-x86/xen.h
+++ b/include/hw/xen/interface/arch-x86/xen.h
@@ -141,3 +141,3 @@ typedef unsigned long xen_ulong_t;
  * privilege levels as follows:
- *  Level == 0: Noone may enter
+ *  Level == 0: No one may enter
  *  Level == 1: Kernel may enter
diff --git a/include/hw/xen/interface/event_channel.h b/include/hw/xen/interface/event_channel.h
index 73c9f38ce1..9073d3852f 100644
--- a/include/hw/xen/interface/event_channel.h
+++ b/include/hw/xen/interface/event_channel.h
@@ -321,3 +321,3 @@ typedef struct evtchn_set_priority evtchn_set_priority_t;
  * `
- * Superceded by new event_channel_op() hypercall since 0x00030202.
+ * Superseded by new event_channel_op() hypercall since 0x00030202.
  */
diff --git a/include/hw/xen/interface/grant_table.h b/include/hw/xen/interface/grant_table.h
index 7934d7b718..f8e4398ecd 100644
--- a/include/hw/xen/interface/grant_table.h
+++ b/include/hw/xen/interface/grant_table.h
@@ -626,3 +626,3 @@ DEFINE_XEN_GUEST_HANDLE(gnttab_cache_flush_t);
   *  0 => This map request contains a host virtual address.
-  *  1 => This map request contains the machine addess of the PTE to update.
+  *  1 => This map request contains the machine address of the PTE to update.
   */
diff --git a/include/hw/xen/interface/hvm/hvm_op.h b/include/hw/xen/interface/hvm/hvm_op.h
index 870ec52060..188960da7e 100644
--- a/include/hw/xen/interface/hvm/hvm_op.h
+++ b/include/hw/xen/interface/hvm/hvm_op.h
@@ -356,3 +356,3 @@ struct xen_hvm_altp2m_op {
 #define HVMOP_altp2m_get_p2m_idx          14
-/* Set the "Supress #VE" bit for a range of pages */
+/* Set the "Suppress #VE" bit for a range of pages */
 #define HVMOP_altp2m_set_suppress_ve_multi 15
diff --git a/include/hw/xen/interface/io/blkif.h b/include/hw/xen/interface/io/blkif.h
index 4cdba79aba..507d5170db 100644
--- a/include/hw/xen/interface/io/blkif.h
+++ b/include/hw/xen/interface/io/blkif.h
@@ -61,3 +61,3 @@
  * expressed as fixed sized integer types capable of storing the conversion
- * of a properly formated node string, without loss of information.
+ * of a properly formatted node string, without loss of information.
  *
@@ -260,3 +260,3 @@
  *      NOTE: Because of implementation bugs in some frontends this must be
- *            set to 512, unless the frontend advertizes a non-zero value
+ *            set to 512, unless the frontend advertises a non-zero value
  *            in its "feature-large-sector-size" xenbus node. (See below).
@@ -417,3 +417,3 @@
  *     grants that can be persistently mapped in the frontend driver, but
- *     due to the frontent driver implementation it should never be bigger
+ *     due to the frontend driver implementation it should never be bigger
  *     than RING_SIZE * BLKIF_MAX_SEGMENTS_PER_REQUEST.
diff --git a/include/hw/xen/interface/io/fbif.h b/include/hw/xen/interface/io/fbif.h
index cc25aab32e..098561c55a 100644
--- a/include/hw/xen/interface/io/fbif.h
+++ b/include/hw/xen/interface/io/fbif.h
@@ -91,3 +91,3 @@ union xenfb_out_event
  * those have been requested), then use the update frequency to guide
- * their periodical refreshs.
+ * their periodical refreshes.
  */
diff --git a/include/hw/xen/interface/io/kbdif.h b/include/hw/xen/interface/io/kbdif.h
index a6b01c52c7..6fb73c8004 100644
--- a/include/hw/xen/interface/io/kbdif.h
+++ b/include/hw/xen/interface/io/kbdif.h
@@ -41,3 +41,3 @@
  * expressed as fixed sized integer types capable of storing the conversion
- * of a properly formated node string, without loss of information.
+ * of a properly formatted node string, without loss of information.
  *
diff --git a/include/hw/xen/interface/memory.h b/include/hw/xen/interface/memory.h
index 383a9468c3..b5edabf63c 100644
--- a/include/hw/xen/interface/memory.h
+++ b/include/hw/xen/interface/memory.h
@@ -186,3 +186,3 @@ struct xen_machphys_mfn_list {
      * Pointer to buffer to fill with list of extent starts. If there are
-     * any large discontiguities in the machine address space, 2MB gaps in
+     * any large discontinuities in the machine address space, 2MB gaps in
      * the machphys table will be represented by an MFN base of zero.
diff --git a/include/hw/xen/interface/physdev.h b/include/hw/xen/interface/physdev.h
index d271766ad0..55cd5892ac 100644
--- a/include/hw/xen/interface/physdev.h
+++ b/include/hw/xen/interface/physdev.h
@@ -225,3 +225,3 @@ DEFINE_XEN_GUEST_HANDLE(physdev_manage_pci_ext_t);
 /*
- * Argument to physdev_op_compat() hypercall. Superceded by new physdev_op()
+ * Argument to physdev_op_compat() hypercall. Superseded by new physdev_op()
  * hypercall since 0x00030202.
@@ -351,3 +351,3 @@ DEFINE_XEN_GUEST_HANDLE(physdev_dbgp_op_t);
 /*
- * These all-capitals physdev operation names are superceded by the new names
+ * These all-capitals physdev operation names are superseded by the new names
  * (defined above) since interface version 0x00030202. The guard above was
diff --git a/include/hw/xen/interface/sched.h b/include/hw/xen/interface/sched.h
index 811bd87c82..043900b49a 100644
--- a/include/hw/xen/interface/sched.h
+++ b/include/hw/xen/interface/sched.h
@@ -68,3 +68,3 @@
  * If called with event upcalls masked, this operation will atomically
- * reenable event delivery and check for pending events before blocking the
+ * re-enable event delivery and check for pending events before blocking the
  * VCPU. This avoids a "wakeup waiting" race.
diff --git a/include/hw/xen/interface/xen.h b/include/hw/xen/interface/xen.h
index e373592c33..8c7914bbfb 100644
--- a/include/hw/xen/interface/xen.h
+++ b/include/hw/xen/interface/xen.h
@@ -608,3 +608,3 @@ DEFINE_XEN_GUEST_HANDLE(mmuext_op_t);
 /*
- * DOMID_COW is used as the owner of sharable pages */
+ * DOMID_COW is used as the owner of shareable pages */
 #define DOMID_COW            xen_mk_uint(0x7FF3)
@@ -752,3 +752,3 @@ struct shared_info {
      *     arrange out-of-band to set up a connection (usually by allocating
-     *     an unbound 'listener' port and avertising that via a storage service
+     *     an unbound 'listener' port and advertising that via a storage service
      *     such as xenstore).
-- 
2.39.2


