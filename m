Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7879BB4A94
	for <lists+qemu-devel@lfdr.de>; Thu, 02 Oct 2025 19:22:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Mvx-0001J6-NC; Thu, 02 Oct 2025 13:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4MvZ-00013K-Oi
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:17:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4MvK-0005rx-4i
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759425411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tqd9O5AQky0sLIn5qZcKGhaIrugOu6vFCL6MK14dFVs=;
 b=Vak6sK93CLsb0yb8xVDHwOQ14KFyc8XoSz+XuU90381jOi4Q5ivJeDTcmWxuN6RY/Meevv
 mx1sYjshxvq0luz3RbwKAGou6G7tSEw1Ww9eDM1kjLdHNYsPOL8coH8203V3rJ+SuA+qxf
 8ICI8Uw5SLQJvQ+uWQUyekXgEWSdV08=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-RU8kk4NxMLWHwHQrEaOeDA-1; Thu, 02 Oct 2025 13:16:49 -0400
X-MC-Unique: RU8kk4NxMLWHwHQrEaOeDA-1
X-Mimecast-MFC-AGG-ID: RU8kk4NxMLWHwHQrEaOeDA_1759425408
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-6381b5dd829so377033a12.3
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 10:16:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759425407; x=1760030207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tqd9O5AQky0sLIn5qZcKGhaIrugOu6vFCL6MK14dFVs=;
 b=cX653+LXvNCfs+JcdvLrbd3nbftuxeVIL8OS2cI33aUVDEt9a49QWYOyub/L1wYqUc
 c5qtTdM/4BJVttZW5yujnSJ3UH6pSvzd0Q/TXLfbrCF6SOO9SxUGNCqgLoJiPhKxgRsk
 2FQtEVkjlZPd2ln6lleC33HJI+nIZQvYigm1m1bB8es+WLm74UKOcqByTb2SOQzc8cnc
 WXvVSUIyRG/NNUfSz4+m3yVcA/irP9VkS+NPp93hCLnB7BZztxPYWNUd95tIZtADu9Vs
 gqICATT9bbAmxCvs7zPUbvI0lD3htylF6cncD20rcQd4C7nbAbUO0P0/pKBCDFmDqTRH
 Rp2w==
X-Gm-Message-State: AOJu0YxDjGhiKBJknMJ9dF4Ye/A2tS1jbKf4I/gyzNjr7ZUmc8Rs50AD
 y48iI+E1OghKaJfTxcxJ29XE1ezCvunO62KTlX0k5OzNPw9xt4wELDNZXxtcyBsYwmKPyawJcoS
 wv3+rZLvSCJ1VDX60JuXsXy05AkbZjMfLgQSVkXubL97UKYCLSy8D0HGzwCQnBH2qIjyXXaRqy+
 Ut7OVcv8ip7UnNdtXwAbj8ystiIaVpS2Yqowhcdlml
X-Gm-Gg: ASbGncv94Sb+hlOYtkLX6LdHcXtL+ozFnX1Ui5S8Gtf3n9l9dp3koL+pMV+a8ZyLGV8
 qkHiOj34YVvkIo8drS9QR0sH2zcPJS46BuukKWEJiei818dOUdFiSK5T4MsixHZ34mhWldHjlGL
 +S8gyb5G9gf7LTaY/WWLqAymj57pownQjK/FArbHova+TygxKIiqIya5gCA1F69ci13iVeHm0o4
 h49vJDDAw4cKx7Bd/5KFZnJf4MpXg8l3wlIOKC5Vgid5eOYoSmNFNIiy+SqP6bze3HTmsbwMgIa
 wFTDKOPw/9RYfH9Z6Mi5wvd4sDZhu/MLRLgWraMxitRRA1h+sCxcXsDZ4L5E7yHW2GyoZYiCNxN
 hw1LsXGbIYgwqtTIARJzpJc1PD9QNBdnYf1hL9Srnf/iju7Nf
X-Received: by 2002:a17:907:86a2:b0:b3d:4ab4:ea2f with SMTP id
 a640c23a62f3a-b49c1a6be6fmr33500166b.19.1759425407252; 
 Thu, 02 Oct 2025 10:16:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUgJJLWT8FyykModOvcV87t/A+l4uTVUONIyDwaTEGQgu1U2ryFl8S9iA8PmPu9hiG6KpqIg==
X-Received: by 2002:a17:907:86a2:b0:b3d:4ab4:ea2f with SMTP id
 a640c23a62f3a-b49c1a6be6fmr33494566b.19.1759425406668; 
 Thu, 02 Oct 2025 10:16:46 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.91.106])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b4865a7c660sm237096266b.22.2025.10.02.10.16.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 10:16:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, magnus.kulke@linux.microsoft.com, wei.liu@kernel.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PATCH 23/27] accel/mshv: Handle overlapping mem mappings
Date: Thu,  2 Oct 2025 19:15:32 +0200
Message-ID: <20251002171536.1460049-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002171536.1460049-1-pbonzini@redhat.com>
References: <20251002171536.1460049-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

QEMU maps certain regions into the guest multiple times, as seen in the
trace below. Currently the MSHV kernel driver will reject those
mappings. To workaround this, a record is kept (a static global list of
"slots", inspired by what the HVF accelerator has implemented). An
overlapping region is not registered at the hypervisor, and marked as
mapped=false. If there is an UNMAPPED_GPA exit, we can look for a slot
that is unmapped and would cover the GPA. In this case we map out the
conflicting slot and map in the requested region.

mshv_set_phys_mem       add=1 name=pc.bios
mshv_map_memory      => u_a=7ffff4e00000 gpa=00fffc0000 size=00040000
mshv_set_phys_mem       add=1 name=ioapic
mshv_set_phys_mem       add=1 name=hpet
mshv_set_phys_mem       add=0 name=pc.ram
mshv_unmap_memory       u_a=7fff67e00000 gpa=0000000000 size=80000000
mshv_set_phys_mem       add=1 name=pc.ram
mshv_map_memory         u_a=7fff67e00000 gpa=0000000000 size=000c0000
mshv_set_phys_mem       add=1 name=pc.rom
mshv_map_memory         u_a=7ffff4c00000 gpa=00000c0000 size=00020000
mshv_set_phys_mem       add=1 name=pc.bios
mshv_remap_attempt   => u_a=7ffff4e20000 gpa=00000e0000 size=00020000

The mapping table is guarded by a mutex for concurrent modification and
RCU mechanisms for concurrent reads. Writes occur rarely, but we'll have
to verify whether an unmapped region exist for each UNMAPPED_GPA exit,
which happens frequently.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20250916164847.77883-24-magnuskulke@linux.microsoft.com
[Fix format strings for trace-events; mshv.h/mshv_int.h split. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/mshv_int.h   |  22 +-
 accel/mshv/mem.c            | 406 +++++++++++++++++++++++++++++++++---
 accel/mshv/mshv-all.c       |   2 +
 target/i386/mshv/mshv-cpu.c |  43 ++++
 accel/mshv/trace-events     |   5 +
 5 files changed, 448 insertions(+), 30 deletions(-)

diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index b29d39911db..6350c69e9d3 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -16,6 +16,8 @@
 
 #define MSHV_MSR_ENTRIES_COUNT 64
 
+#define MSHV_MAX_MEM_SLOTS 32
+
 typedef struct hyperv_message hv_message;
 
 struct AccelCPUState {
@@ -33,6 +35,12 @@ typedef struct MshvAddressSpace {
     AddressSpace *as;
 } MshvAddressSpace;
 
+typedef struct MshvMemorySlotManager {
+    size_t n_slots;
+    GList *slots;
+    QemuMutex mutex;
+} MshvMemorySlotManager;
+
 struct MshvState {
     AccelState parent_obj;
     int vm;
@@ -41,6 +49,7 @@ struct MshvState {
     int nr_as;
     MshvAddressSpace *as;
     int fd;
+    MshvMemorySlotManager msm;
 };
 
 typedef struct MshvMsiControl {
@@ -71,6 +80,12 @@ typedef enum MshvVmExit {
     MshvVmExitSpecial  = 2,
 } MshvVmExit;
 
+typedef enum MshvRemapResult {
+    MshvRemapOk = 0,
+    MshvRemapNoMapping = 1,
+    MshvRemapNoOverlap = 2,
+} MshvRemapResult;
+
 void mshv_init_mmio_emu(void);
 int mshv_create_vcpu(int vm_fd, uint8_t vp_index, int *cpu_fd);
 void mshv_remove_vcpu(int vm_fd, int cpu_fd);
@@ -94,19 +109,22 @@ int mshv_hvcall(int fd, const struct mshv_root_hvcall *args);
 #endif
 
 /* memory */
-typedef struct MshvMemoryRegion {
+typedef struct MshvMemorySlot {
     uint64_t guest_phys_addr;
     uint64_t memory_size;
     uint64_t userspace_addr;
     bool readonly;
-} MshvMemoryRegion;
+    bool mapped;
+} MshvMemorySlot;
 
+MshvRemapResult mshv_remap_overlap_region(int vm_fd, uint64_t gpa);
 int mshv_guest_mem_read(uint64_t gpa, uint8_t *data, uintptr_t size,
                         bool is_secure_mode, bool instruction_fetch);
 int mshv_guest_mem_write(uint64_t gpa, const uint8_t *data, uintptr_t size,
                          bool is_secure_mode);
 void mshv_set_phys_mem(MshvMemoryListener *mml, MemoryRegionSection *section,
                        bool add);
+void mshv_init_memory_slot_manager(MshvState *mshv_state);
 
 /* msr */
 typedef struct MshvMsrEntry {
diff --git a/accel/mshv/mem.c b/accel/mshv/mem.c
index e55c38d4db9..0e2164af3ee 100644
--- a/accel/mshv/mem.c
+++ b/accel/mshv/mem.c
@@ -11,7 +11,9 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/lockable.h"
 #include "qemu/error-report.h"
+#include "qemu/rcu.h"
 #include "linux/mshv.h"
 #include "system/address-spaces.h"
 #include "system/mshv.h"
@@ -20,6 +22,137 @@
 #include <sys/ioctl.h>
 #include "trace.h"
 
+typedef struct SlotsRCUReclaim {
+    struct rcu_head rcu;
+    GList *old_head;
+    MshvMemorySlot *removed_slot;
+} SlotsRCUReclaim;
+
+static void rcu_reclaim_slotlist(struct rcu_head *rcu)
+{
+    SlotsRCUReclaim *r = container_of(rcu, SlotsRCUReclaim, rcu);
+    g_list_free(r->old_head);
+    g_free(r->removed_slot);
+    g_free(r);
+}
+
+static void publish_slots(GList *new_head, GList *old_head,
+                          MshvMemorySlot *removed_slot)
+{
+    MshvMemorySlotManager *manager = &mshv_state->msm;
+
+    assert(manager);
+    qatomic_store_release(&manager->slots, new_head);
+
+    SlotsRCUReclaim *r = g_new(SlotsRCUReclaim, 1);
+    r->old_head = old_head;
+    r->removed_slot = removed_slot;
+
+    call_rcu1(&r->rcu, rcu_reclaim_slotlist);
+}
+
+/* Needs to be called with mshv_state->msm.mutex held */
+static int remove_slot(MshvMemorySlot *slot)
+{
+    GList *old_head, *new_head;
+    MshvMemorySlotManager *manager = &mshv_state->msm;
+
+    assert(manager);
+    old_head = qatomic_load_acquire(&manager->slots);
+
+    if (!g_list_find(old_head, slot)) {
+        error_report("slot requested for removal not found");
+        return -1;
+    }
+
+    new_head = g_list_copy(old_head);
+    new_head = g_list_remove(new_head, slot);
+    manager->n_slots--;
+
+    publish_slots(new_head, old_head, slot);
+
+    return 0;
+}
+
+/* Needs to be called with mshv_state->msm.mutex held */
+static MshvMemorySlot *append_slot(uint64_t gpa, uint64_t userspace_addr,
+                                   uint64_t size, bool readonly)
+{
+    GList *old_head, *new_head;
+    MshvMemorySlot *slot;
+    MshvMemorySlotManager *manager = &mshv_state->msm;
+
+    assert(manager);
+
+    old_head = qatomic_load_acquire(&manager->slots);
+
+    if (manager->n_slots >= MSHV_MAX_MEM_SLOTS) {
+        error_report("no free memory slots available");
+        return NULL;
+    }
+
+    slot = g_new0(MshvMemorySlot, 1);
+    slot->guest_phys_addr = gpa;
+    slot->userspace_addr = userspace_addr;
+    slot->memory_size = size;
+    slot->readonly = readonly;
+
+    new_head = g_list_copy(old_head);
+    new_head = g_list_append(new_head, slot);
+    manager->n_slots++;
+
+    publish_slots(new_head, old_head, NULL);
+
+    return slot;
+}
+
+static int slot_overlaps(const MshvMemorySlot *slot1,
+                         const MshvMemorySlot *slot2)
+{
+    uint64_t start_1 = slot1->userspace_addr,
+             start_2 = slot2->userspace_addr;
+    size_t len_1 = slot1->memory_size,
+           len_2 = slot2->memory_size;
+
+    if (slot1 == slot2) {
+        return -1;
+    }
+
+    return ranges_overlap(start_1, len_1, start_2, len_2) ?  0 : -1;
+}
+
+static bool is_mapped(MshvMemorySlot *slot)
+{
+    /* Subsequent reads of mapped field see a fully-initialized slot */
+    return qatomic_load_acquire(&slot->mapped);
+}
+
+/*
+ * Find slot that is:
+ * - overlapping in userspace
+ * - currently mapped in the guest
+ *
+ * Needs to be called with mshv_state->msm.mutex or RCU read lock held.
+ */
+static MshvMemorySlot *find_overlap_mem_slot(GList *head, MshvMemorySlot *slot)
+{
+    GList *found;
+    MshvMemorySlot *overlap_slot;
+
+    found = g_list_find_custom(head, slot, (GCompareFunc) slot_overlaps);
+
+    if (!found) {
+        return NULL;
+    }
+
+    overlap_slot = found->data;
+    if (!overlap_slot || !is_mapped(overlap_slot)) {
+        return NULL;
+    }
+
+    return overlap_slot;
+}
+
 static int set_guest_memory(int vm_fd,
                             const struct mshv_user_mem_region *region)
 {
@@ -27,38 +160,169 @@ static int set_guest_memory(int vm_fd,
 
     ret = ioctl(vm_fd, MSHV_SET_GUEST_MEMORY, region);
     if (ret < 0) {
-        error_report("failed to set guest memory");
-        return -errno;
+        error_report("failed to set guest memory: %s", strerror(errno));
+        return -1;
     }
 
     return 0;
 }
 
-static int map_or_unmap(int vm_fd, const MshvMemoryRegion *mr, bool map)
+static int map_or_unmap(int vm_fd, const MshvMemorySlot *slot, bool map)
 {
     struct mshv_user_mem_region region = {0};
 
-    region.guest_pfn = mr->guest_phys_addr >> MSHV_PAGE_SHIFT;
-    region.size = mr->memory_size;
-    region.userspace_addr = mr->userspace_addr;
+    region.guest_pfn = slot->guest_phys_addr >> MSHV_PAGE_SHIFT;
+    region.size = slot->memory_size;
+    region.userspace_addr = slot->userspace_addr;
 
     if (!map) {
         region.flags |= (1 << MSHV_SET_MEM_BIT_UNMAP);
-        trace_mshv_unmap_memory(mr->userspace_addr, mr->guest_phys_addr,
-                                mr->memory_size);
+        trace_mshv_unmap_memory(slot->userspace_addr, slot->guest_phys_addr,
+                                slot->memory_size);
         return set_guest_memory(vm_fd, &region);
     }
 
     region.flags = BIT(MSHV_SET_MEM_BIT_EXECUTABLE);
-    if (!mr->readonly) {
+    if (!slot->readonly) {
         region.flags |= BIT(MSHV_SET_MEM_BIT_WRITABLE);
     }
 
-    trace_mshv_map_memory(mr->userspace_addr, mr->guest_phys_addr,
-                          mr->memory_size);
+    trace_mshv_map_memory(slot->userspace_addr, slot->guest_phys_addr,
+                          slot->memory_size);
     return set_guest_memory(vm_fd, &region);
 }
 
+static int slot_matches_region(const MshvMemorySlot *slot1,
+                               const MshvMemorySlot *slot2)
+{
+    return (slot1->guest_phys_addr == slot2->guest_phys_addr &&
+            slot1->userspace_addr  == slot2->userspace_addr &&
+            slot1->memory_size     == slot2->memory_size) ? 0 : -1;
+}
+
+/* Needs to be called with mshv_state->msm.mutex held */
+static MshvMemorySlot *find_mem_slot_by_region(uint64_t gpa, uint64_t size,
+                                               uint64_t userspace_addr)
+{
+    MshvMemorySlot ref_slot = {
+        .guest_phys_addr = gpa,
+        .userspace_addr  = userspace_addr,
+        .memory_size     = size,
+    };
+    GList *found;
+    MshvMemorySlotManager *manager = &mshv_state->msm;
+
+    assert(manager);
+    found = g_list_find_custom(manager->slots, &ref_slot,
+                               (GCompareFunc) slot_matches_region);
+
+    return found ? found->data : NULL;
+}
+
+static int slot_covers_gpa(const MshvMemorySlot *slot, uint64_t *gpa_p)
+{
+    uint64_t gpa_offset, gpa = *gpa_p;
+
+    gpa_offset = gpa - slot->guest_phys_addr;
+    return (slot->guest_phys_addr <= gpa && gpa_offset < slot->memory_size)
+        ? 0 : -1;
+}
+
+/* Needs to be called with mshv_state->msm.mutex or RCU read lock held */
+static MshvMemorySlot *find_mem_slot_by_gpa(GList *head, uint64_t gpa)
+{
+    GList *found;
+    MshvMemorySlot *slot;
+
+    trace_mshv_find_slot_by_gpa(gpa);
+
+    found = g_list_find_custom(head, &gpa, (GCompareFunc) slot_covers_gpa);
+    if (found) {
+        slot = found->data;
+        trace_mshv_found_slot(slot->userspace_addr, slot->guest_phys_addr,
+                              slot->memory_size);
+        return slot;
+    }
+
+    return NULL;
+}
+
+/* Needs to be called with mshv_state->msm.mutex held */
+static void set_mapped(MshvMemorySlot *slot, bool mapped)
+{
+    /* prior writes to mapped field becomes visible before readers see slot */
+    qatomic_store_release(&slot->mapped, mapped);
+}
+
+MshvRemapResult mshv_remap_overlap_region(int vm_fd, uint64_t gpa)
+{
+    MshvMemorySlot *gpa_slot, *overlap_slot;
+    GList *head;
+    int ret;
+    MshvMemorySlotManager *manager = &mshv_state->msm;
+
+    /* fast path, called often by unmapped_gpa vm exit */
+    WITH_RCU_READ_LOCK_GUARD() {
+        assert(manager);
+        head = qatomic_load_acquire(&manager->slots);
+        /* return early if no slot is found */
+        gpa_slot = find_mem_slot_by_gpa(head, gpa);
+        if (gpa_slot == NULL) {
+            return MshvRemapNoMapping;
+        }
+
+        /* return early if no overlapping slot is found */
+        overlap_slot = find_overlap_mem_slot(head, gpa_slot);
+        if (overlap_slot == NULL) {
+            return MshvRemapNoOverlap;
+        }
+    }
+
+    /*
+     * We'll modify the mapping list, so we need to upgrade to mutex and
+     * recheck.
+     */
+    assert(manager);
+    QEMU_LOCK_GUARD(&manager->mutex);
+
+    /* return early if no slot is found */
+    gpa_slot = find_mem_slot_by_gpa(manager->slots, gpa);
+    if (gpa_slot == NULL) {
+        return MshvRemapNoMapping;
+    }
+
+    /* return early if no overlapping slot is found */
+    overlap_slot = find_overlap_mem_slot(manager->slots, gpa_slot);
+    if (overlap_slot == NULL) {
+        return MshvRemapNoOverlap;
+    }
+
+    /* unmap overlapping slot */
+    ret = map_or_unmap(vm_fd, overlap_slot, false);
+    if (ret < 0) {
+        error_report("failed to unmap overlap region");
+        abort();
+    }
+    set_mapped(overlap_slot, false);
+    warn_report("mapped out userspace_addr=0x%016lx gpa=0x%010lx size=0x%lx",
+                overlap_slot->userspace_addr,
+                overlap_slot->guest_phys_addr,
+                overlap_slot->memory_size);
+
+    /* map region for gpa */
+    ret = map_or_unmap(vm_fd, gpa_slot, true);
+    if (ret < 0) {
+        error_report("failed to map new region");
+        abort();
+    }
+    set_mapped(gpa_slot, true);
+    warn_report("mapped in  userspace_addr=0x%016lx gpa=0x%010lx size=0x%lx",
+                gpa_slot->userspace_addr, gpa_slot->guest_phys_addr,
+                gpa_slot->memory_size);
+
+    return MshvRemapOk;
+}
+
 static int handle_unmapped_mmio_region_read(uint64_t gpa, uint64_t size,
                                             uint8_t *data)
 {
@@ -124,20 +388,97 @@ int mshv_guest_mem_write(uint64_t gpa, const uint8_t *data, uintptr_t size,
     return -1;
 }
 
-static int set_memory(const MshvMemoryRegion *mshv_mr, bool add)
+static int tracked_unmap(int vm_fd, uint64_t gpa, uint64_t size,
+                        uint64_t userspace_addr)
 {
-    int ret = 0;
+    int ret;
+    MshvMemorySlot *slot;
+    MshvMemorySlotManager *manager = &mshv_state->msm;
 
-    if (!mshv_mr) {
-        error_report("Invalid mshv_mr");
+    assert(manager);
+
+    QEMU_LOCK_GUARD(&manager->mutex);
+
+    slot = find_mem_slot_by_region(gpa, size, userspace_addr);
+    if (!slot) {
+        trace_mshv_skip_unset_mem(userspace_addr, gpa, size);
+        /* no work to do */
+        return 0;
+    }
+
+    if (!is_mapped(slot)) {
+        /* remove slot, no need to unmap */
+        return remove_slot(slot);
+    }
+
+    ret = map_or_unmap(vm_fd, slot, false);
+    if (ret < 0) {
+        error_report("failed to unmap memory region");
+        return ret;
+    }
+    return remove_slot(slot);
+}
+
+static int tracked_map(int vm_fd, uint64_t gpa, uint64_t size, bool readonly,
+                       uint64_t userspace_addr)
+{
+    MshvMemorySlot *slot, *overlap_slot;
+    int ret;
+    MshvMemorySlotManager *manager = &mshv_state->msm;
+
+    assert(manager);
+
+    QEMU_LOCK_GUARD(&manager->mutex);
+
+    slot = find_mem_slot_by_region(gpa, size, userspace_addr);
+    if (slot) {
+        error_report("memory region already mapped at gpa=0x%lx, "
+                     "userspace_addr=0x%lx, size=0x%lx",
+                     slot->guest_phys_addr, slot->userspace_addr,
+                     slot->memory_size);
         return -1;
     }
 
-    trace_mshv_set_memory(add, mshv_mr->guest_phys_addr,
-                          mshv_mr->memory_size,
-                          mshv_mr->userspace_addr, mshv_mr->readonly,
-                          ret);
-    return map_or_unmap(mshv_state->vm, mshv_mr, add);
+    slot = append_slot(gpa, userspace_addr, size, readonly);
+
+    overlap_slot = find_overlap_mem_slot(manager->slots, slot);
+    if (overlap_slot) {
+        trace_mshv_remap_attempt(slot->userspace_addr,
+                                 slot->guest_phys_addr,
+                                 slot->memory_size);
+        warn_report("attempt to map region [0x%lx-0x%lx], while "
+                    "[0x%lx-0x%lx] is already mapped in the guest",
+                    userspace_addr, userspace_addr + size - 1,
+                    overlap_slot->userspace_addr,
+                    overlap_slot->userspace_addr +
+                    overlap_slot->memory_size - 1);
+
+        /* do not register mem slot in hv, but record for later swap-in */
+        set_mapped(slot, false);
+
+        return 0;
+    }
+
+    ret = map_or_unmap(vm_fd, slot, true);
+    if (ret < 0) {
+        error_report("failed to map memory region");
+        return -1;
+    }
+    set_mapped(slot, true);
+
+    return 0;
+}
+
+static int set_memory(uint64_t gpa, uint64_t size, bool readonly,
+                      uint64_t userspace_addr, bool add)
+{
+    int vm_fd = mshv_state->vm;
+
+    if (add) {
+        return tracked_map(vm_fd, gpa, size, readonly, userspace_addr);
+    }
+
+    return tracked_unmap(vm_fd, gpa, size, userspace_addr);
 }
 
 /*
@@ -173,7 +514,9 @@ void mshv_set_phys_mem(MshvMemoryListener *mml, MemoryRegionSection *section,
     bool writable = !area->readonly && !area->rom_device;
     hwaddr start_addr, mr_offset, size;
     void *ram;
-    MshvMemoryRegion mshv_mr = {0};
+
+    size = align_section(section, &start_addr);
+    trace_mshv_set_phys_mem(add, section->mr->name, start_addr);
 
     size = align_section(section, &start_addr);
     trace_mshv_set_phys_mem(add, section->mr->name, start_addr);
@@ -200,14 +543,21 @@ void mshv_set_phys_mem(MshvMemoryListener *mml, MemoryRegionSection *section,
 
     ram = memory_region_get_ram_ptr(area) + mr_offset;
 
-    mshv_mr.guest_phys_addr = start_addr;
-    mshv_mr.memory_size = size;
-    mshv_mr.readonly = !writable;
-    mshv_mr.userspace_addr = (uint64_t)ram;
-
-    ret = set_memory(&mshv_mr, add);
+    ret = set_memory(start_addr, size, !writable, (uint64_t)ram, add);
     if (ret < 0) {
-        error_report("Failed to set memory region");
+        error_report("failed to set memory region");
         abort();
     }
 }
+
+void mshv_init_memory_slot_manager(MshvState *mshv_state)
+{
+    MshvMemorySlotManager *manager;
+
+    assert(mshv_state);
+    manager = &mshv_state->msm;
+
+    manager->n_slots = 0;
+    manager->slots = NULL;
+    qemu_mutex_init(&manager->mutex);
+}
diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index fa1f8f35bdb..5edfcbad9d2 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -437,6 +437,8 @@ static int mshv_init(AccelState *as, MachineState *ms)
 
     mshv_init_msicontrol();
 
+    mshv_init_memory_slot_manager(s);
+
     ret = create_vm(mshv_fd, &vm_fd);
     if (ret < 0) {
         close(mshv_fd);
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 7edc032cea3..de87142bffc 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -1170,6 +1170,43 @@ static int handle_mmio(CPUState *cpu, const struct hyperv_message *msg,
     return 0;
 }
 
+static int handle_unmapped_mem(int vm_fd, CPUState *cpu,
+                               const struct hyperv_message *msg,
+                               MshvVmExit *exit_reason)
+{
+    struct hv_x64_memory_intercept_message info = { 0 };
+    uint64_t gpa;
+    int ret;
+    enum MshvRemapResult remap_result;
+
+    ret = set_memory_info(msg, &info);
+    if (ret < 0) {
+        error_report("failed to convert message to memory info");
+        return -1;
+    }
+
+    gpa = info.guest_physical_address;
+
+    /* attempt to remap the region, in case of overlapping userspace mappings */
+    remap_result = mshv_remap_overlap_region(vm_fd, gpa);
+    *exit_reason = MshvVmExitIgnore;
+
+    switch (remap_result) {
+    case MshvRemapNoMapping:
+        /* if we didn't find a mapping, it is probably mmio */
+        return handle_mmio(cpu, msg, exit_reason);
+    case MshvRemapOk:
+        break;
+    case MshvRemapNoOverlap:
+        /* This should not happen, but we are forgiving it */
+        warn_report("found no overlap for unmapped region");
+        *exit_reason = MshvVmExitSpecial;
+        break;
+    }
+
+    return 0;
+}
+
 static int set_ioport_info(const struct hyperv_message *msg,
                            hv_x64_io_port_intercept_message *info)
 {
@@ -1507,6 +1544,12 @@ int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit)
     case HVMSG_UNRECOVERABLE_EXCEPTION:
         return MshvVmExitShutdown;
     case HVMSG_UNMAPPED_GPA:
+        ret = handle_unmapped_mem(vm_fd, cpu, msg, &exit_reason);
+        if (ret < 0) {
+            error_report("failed to handle unmapped memory");
+            return -1;
+        }
+        return exit_reason;
     case HVMSG_GPA_INTERCEPT:
         ret = handle_mmio(cpu, msg, &exit_reason);
         if (ret < 0) {
diff --git a/accel/mshv/trace-events b/accel/mshv/trace-events
index a4dffeb24a3..af2655216a5 100644
--- a/accel/mshv/trace-events
+++ b/accel/mshv/trace-events
@@ -26,3 +26,8 @@ mshv_map_memory(uint64_t userspace_addr, uint64_t gpa, uint64_t size) "\tu_a=0x%
 mshv_unmap_memory(uint64_t userspace_addr, uint64_t gpa, uint64_t size) "\tu_a=0x%" PRIx64 " gpa=0x%010" PRIx64 " size=0x%08" PRIx64
 mshv_set_phys_mem(bool add, const char *name, uint64_t gpa) "\tadd=%d name=%s gpa=0x%010" PRIx64
 mshv_handle_mmio(uint64_t gva, uint64_t gpa, uint64_t size, uint8_t access_type) "\tgva=0x%" PRIx64 " gpa=0x%010" PRIx64 " size=0x%" PRIx64 " access_type=%d"
+
+mshv_found_slot(uint64_t userspace_addr, uint64_t gpa, uint64_t size) "\tu_a=0x%" PRIx64 " gpa=0x%010" PRIx64 " size=0x%08" PRIx64
+mshv_skip_unset_mem(uint64_t userspace_addr, uint64_t gpa, uint64_t size) "\tu_a=0x%" PRIx64 " gpa=0x%010" PRIx64 " size=0x%08" PRIx64
+mshv_remap_attempt(uint64_t userspace_addr, uint64_t gpa, uint64_t size) "\tu_a=0x%" PRIx64 " gpa=0x%010" PRIx64 " size=0x%08" PRIx64
+mshv_find_slot_by_gpa(uint64_t gpa) "\tgpa=0x%010" PRIx64
-- 
2.51.0


