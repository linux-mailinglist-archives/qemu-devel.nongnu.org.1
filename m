Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C13AC9C2CAE
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Nov 2024 13:12:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9kIe-0003tz-O6; Sat, 09 Nov 2024 07:10:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kHj-0002Qs-O3; Sat, 09 Nov 2024 07:09:48 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kHh-00042J-M8; Sat, 09 Nov 2024 07:09:47 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 02496A15FE;
 Sat,  9 Nov 2024 15:07:08 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id B917F167F8C;
 Sat,  9 Nov 2024 15:08:02 +0300 (MSK)
Received: (nullmailer pid 3295319 invoked by uid 1000);
 Sat, 09 Nov 2024 12:08:01 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Xu <peterx@redhat.com>,
 Zhiyi Guo <zhguo@redhat.com>, David Hildenbrand <david@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.4 22/57] KVM: Dynamic sized kvm memslots array
Date: Sat,  9 Nov 2024 15:07:24 +0300
Message-Id: <20241109120801.3295120-22-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.0.4-20241109150303@cover.tls.msk.ru>
References: <qemu-stable-9.0.4-20241109150303@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Peter Xu <peterx@redhat.com>

Zhiyi reported an infinite loop issue in VFIO use case.  The cause of that
was a separate discussion, however during that I found a regression of
dirty sync slowness when profiling.

Each KVMMemoryListerner maintains an array of kvm memslots.  Currently it's
statically allocated to be the max supported by the kernel.  However after
Linux commit 4fc096a99e ("KVM: Raise the maximum number of user memslots"),
the max supported memslots reported now grows to some number large enough
so that it may not be wise to always statically allocate with the max
reported.

What's worse, QEMU kvm code still walks all the allocated memslots entries
to do any form of lookups.  It can drastically slow down all memslot
operations because each of such loop can run over 32K times on the new
kernels.

Fix this issue by making the memslots to be allocated dynamically.

Here the initial size was set to 16 because it should cover the basic VM
usages, so that the hope is the majority VM use case may not even need to
grow at all (e.g. if one starts a VM with ./qemu-system-x86_64 by default
it'll consume 9 memslots), however not too large to waste memory.

There can also be even better way to address this, but so far this is the
simplest and should be already better even than before we grow the max
supported memslots.  For example, in the case of above issue when VFIO was
attached on a 32GB system, there are only ~10 memslots used.  So it could
be good enough as of now.

In the above VFIO context, measurement shows that the precopy dirty sync
shrinked from ~86ms to ~3ms after this patch applied.  It should also apply
to any KVM enabled VM even without VFIO.

NOTE: we don't have a FIXES tag for this patch because there's no real
commit that regressed this in QEMU. Such behavior existed for a long time,
but only start to be a problem when the kernel reports very large
nr_slots_max value.  However that's pretty common now (the kernel change
was merged in 2021) so we attached cc:stable because we'll want this change
to be backported to stable branches.

Cc: qemu-stable <qemu-stable@nongnu.org>
Reported-by: Zhiyi Guo <zhguo@redhat.com>
Tested-by: Zhiyi Guo <zhguo@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240917163835.194664-2-peterx@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 5504a8126115d173687b37e657312a8ffe29fc0c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: context fixup in accel/kvm/trace-events)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 931f74256e..4d44a63eca 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -69,6 +69,9 @@
 #define KVM_GUESTDBG_BLOCKIRQ 0
 #endif
 
+/* Default num of memslots to be allocated when VM starts */
+#define  KVM_MEMSLOTS_NR_ALLOC_DEFAULT                      16
+
 struct KVMParkedVcpu {
     unsigned long vcpu_id;
     int kvm_fd;
@@ -163,6 +166,57 @@ void kvm_resample_fd_notify(int gsi)
     }
 }
 
+/**
+ * kvm_slots_grow(): Grow the slots[] array in the KVMMemoryListener
+ *
+ * @kml: The KVMMemoryListener* to grow the slots[] array
+ * @nr_slots_new: The new size of slots[] array
+ *
+ * Returns: True if the array grows larger, false otherwise.
+ */
+static bool kvm_slots_grow(KVMMemoryListener *kml, unsigned int nr_slots_new)
+{
+    unsigned int i, cur = kml->nr_slots_allocated;
+    KVMSlot *slots;
+
+    if (nr_slots_new > kvm_state->nr_slots) {
+        nr_slots_new = kvm_state->nr_slots;
+    }
+
+    if (cur >= nr_slots_new) {
+        /* Big enough, no need to grow, or we reached max */
+        return false;
+    }
+
+    if (cur == 0) {
+        slots = g_new0(KVMSlot, nr_slots_new);
+    } else {
+        assert(kml->slots);
+        slots = g_renew(KVMSlot, kml->slots, nr_slots_new);
+        /*
+         * g_renew() doesn't initialize extended buffers, however kvm
+         * memslots require fields to be zero-initialized. E.g. pointers,
+         * memory_size field, etc.
+         */
+        memset(&slots[cur], 0x0, sizeof(slots[0]) * (nr_slots_new - cur));
+    }
+
+    for (i = cur; i < nr_slots_new; i++) {
+        slots[i].slot = i;
+    }
+
+    kml->slots = slots;
+    kml->nr_slots_allocated = nr_slots_new;
+    trace_kvm_slots_grow(cur, nr_slots_new);
+
+    return true;
+}
+
+static bool kvm_slots_double(KVMMemoryListener *kml)
+{
+    return kvm_slots_grow(kml, kml->nr_slots_allocated * 2);
+}
+
 unsigned int kvm_get_max_memslots(void)
 {
     KVMState *s = KVM_STATE(current_accel());
@@ -191,15 +245,26 @@ unsigned int kvm_get_free_memslots(void)
 /* Called with KVMMemoryListener.slots_lock held */
 static KVMSlot *kvm_get_free_slot(KVMMemoryListener *kml)
 {
-    KVMState *s = kvm_state;
+    unsigned int n;
     int i;
 
-    for (i = 0; i < s->nr_slots; i++) {
+    for (i = 0; i < kml->nr_slots_allocated; i++) {
         if (kml->slots[i].memory_size == 0) {
             return &kml->slots[i];
         }
     }
 
+    /*
+     * If no free slots, try to grow first by doubling.  Cache the old size
+     * here to avoid another round of search: if the grow succeeded, it
+     * means slots[] now must have the existing "n" slots occupied,
+     * followed by one or more free slots starting from slots[n].
+     */
+    n = kml->nr_slots_allocated;
+    if (kvm_slots_double(kml)) {
+        return &kml->slots[n];
+    }
+
     return NULL;
 }
 
@@ -220,10 +285,9 @@ static KVMSlot *kvm_lookup_matching_slot(KVMMemoryListener *kml,
                                          hwaddr start_addr,
                                          hwaddr size)
 {
-    KVMState *s = kvm_state;
     int i;
 
-    for (i = 0; i < s->nr_slots; i++) {
+    for (i = 0; i < kml->nr_slots_allocated; i++) {
         KVMSlot *mem = &kml->slots[i];
 
         if (start_addr == mem->start_addr && size == mem->memory_size) {
@@ -265,7 +329,7 @@ int kvm_physical_memory_addr_from_host(KVMState *s, void *ram,
     int i, ret = 0;
 
     kvm_slots_lock();
-    for (i = 0; i < s->nr_slots; i++) {
+    for (i = 0; i < kml->nr_slots_allocated; i++) {
         KVMSlot *mem = &kml->slots[i];
 
         if (ram >= mem->ram && ram < mem->ram + mem->memory_size) {
@@ -997,7 +1061,7 @@ static int kvm_physical_log_clear(KVMMemoryListener *kml,
 
     kvm_slots_lock();
 
-    for (i = 0; i < s->nr_slots; i++) {
+    for (i = 0; i < kml->nr_slots_allocated; i++) {
         mem = &kml->slots[i];
         /* Discard slots that are empty or do not overlap the section */
         if (!mem->memory_size ||
@@ -1602,12 +1666,8 @@ static void kvm_log_sync_global(MemoryListener *l, bool last_stage)
     /* Flush all kernel dirty addresses into KVMSlot dirty bitmap */
     kvm_dirty_ring_flush();
 
-    /*
-     * TODO: make this faster when nr_slots is big while there are
-     * only a few used slots (small VMs).
-     */
     kvm_slots_lock();
-    for (i = 0; i < s->nr_slots; i++) {
+    for (i = 0; i < kml->nr_slots_allocated; i++) {
         mem = &kml->slots[i];
         if (mem->memory_size && mem->flags & KVM_MEM_LOG_DIRTY_PAGES) {
             kvm_slot_sync_dirty_pages(mem);
@@ -1722,12 +1782,9 @@ void kvm_memory_listener_register(KVMState *s, KVMMemoryListener *kml,
 {
     int i;
 
-    kml->slots = g_new0(KVMSlot, s->nr_slots);
     kml->as_id = as_id;
 
-    for (i = 0; i < s->nr_slots; i++) {
-        kml->slots[i].slot = i;
-    }
+    kvm_slots_grow(kml, KVM_MEMSLOTS_NR_ALLOC_DEFAULT);
 
     QSIMPLEQ_INIT(&kml->transaction_add);
     QSIMPLEQ_INIT(&kml->transaction_del);
diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
index a25902597b..f16cd55927 100644
--- a/accel/kvm/trace-events
+++ b/accel/kvm/trace-events
@@ -31,3 +31,4 @@ kvm_cpu_exec(void) ""
 kvm_interrupt_exit_request(void) ""
 kvm_io_window_exit(void) ""
 kvm_run_exit_system_event(int cpu_index, uint32_t event_type) "cpu_index %d, system_even_type %"PRIu32
+kvm_slots_grow(unsigned int old, unsigned int new) "%u -> %u"
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index 882e37e12c..1ca33ea7cc 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -41,6 +41,7 @@ typedef struct KVMMemoryListener {
     MemoryListener listener;
     KVMSlot *slots;
     unsigned int nr_used_slots;
+    unsigned int nr_slots_allocated;
     int as_id;
     QSIMPLEQ_HEAD(, KVMMemoryUpdate) transaction_add;
     QSIMPLEQ_HEAD(, KVMMemoryUpdate) transaction_del;
-- 
2.39.5


