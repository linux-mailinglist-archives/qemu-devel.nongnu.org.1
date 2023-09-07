Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B13867972C3
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:14:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEgR-00032g-K5; Thu, 07 Sep 2023 09:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qeEgO-00031z-NO
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:04:28 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qeEgL-00082v-94
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:04:28 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c09673b006so6804795ad.1
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694091863; x=1694696663;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xJRHB3e+XiZ0mFQkd2Yg/uxiQhgPeUrgKbxzi/S1ze4=;
 b=HOYi0JEDzhl8RLMlylX+TIYQW3ZI2SHkyxbi2U4kvsHh6oCPwt90kPv+FgNd4uEbwe
 FxuEP8JMbx907bapmwpoBjAAUBa1AsoGH2onLtJzCKiLcgfgNH3rbb5l/V1C7jp2mflN
 24WUueihH9STkVw3Kc94dFmgVt8MMj4tPkrhP3KarKiDjay04m8iuVS+NQ/KiCbWayyJ
 jc8tErrFKuA5rBFbCsyOnV+Rxp/Rbwr0iWpaN8BPB+tcspj83+Ju24nw/5ANiE1jepOr
 Q8EoAaeYFPegKl8Gf0v6MYJXyMH9573xb46fk5a2jcbxsbU58G4YKCvT1yldaYnAD6dJ
 BY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091863; x=1694696663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xJRHB3e+XiZ0mFQkd2Yg/uxiQhgPeUrgKbxzi/S1ze4=;
 b=dWAmOfMqYIQVolwojFgRbVniDJp6KDDzHpNzqE+sXwTDlpAjqo7ZhUqKy0V/ua/eao
 jj13pah2QLXHh+0e77BPe2Tb+1kye6SMWp7l7xTx7A6iaZfIG57pBxR2h8aIf7nHP7vf
 kpTxRYaAzfSADLsutpYDgXxQSIScK9jCJ+x0XNwttFRra00XEf3zpvSB7dAB/B+zGUw9
 5HftOl3PlmxiZxS/2Gtl7305wx09tAfvbhV2Z4NW6T+2RTgWO5Kp15NegrOskX2SJh2P
 xAxIYWegi/reLuwSvN3k6B0RkJr4LdRm6jwmbjen3Dqz0t6haK2b3XoQI+SrjWEp9tsp
 iD4A==
X-Gm-Message-State: AOJu0Yx9afwQmyWYYeYs7h2c6/HmH6yHeutlNltg2I2PnVl7kRNHXOdG
 8WQcVEoauUG0RV8vZYgICQK1GWXfOZ7gdLnQ6LifzQ==
X-Google-Smtp-Source: AGHT+IER4Jj9Nx//q4fJoPYD5z0wgvt8oUKtkJZ4q9edsFN3fr5Yx973TI2If17AkhAmP2DRQZ4Y+g==
X-Received: by 2002:a17:903:1109:b0:1bb:d280:5e0b with SMTP id
 n9-20020a170903110900b001bbd2805e0bmr18053409plh.18.1694091863100; 
 Thu, 07 Sep 2023 06:04:23 -0700 (PDT)
Received: from mnissler.ba.rivosinc.com ([66.220.2.162])
 by smtp.gmail.com with ESMTPSA id
 g24-20020a170902fe1800b001b0358848b0sm12821913plj.161.2023.09.07.06.04.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:04:22 -0700 (PDT)
From: Mattias Nissler <mnissler@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: john.levon@nutanix.com, Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jagannathan Raman <jag.raman@oracle.com>, stefanha@redhat.com,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH v3 2/5] softmmu: Support concurrent bounce buffers
Date: Thu,  7 Sep 2023 06:04:07 -0700
Message-Id: <20230907130410.498935-3-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907130410.498935-1-mnissler@rivosinc.com>
References: <20230907130410.498935-1-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=mnissler@rivosinc.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When DMA memory can't be directly accessed, as is the case when
running the device model in a separate process without shareable DMA
file descriptors, bounce buffering is used.

It is not uncommon for device models to request mapping of several DMA
regions at the same time. Examples include:
 * net devices, e.g. when transmitting a packet that is split across
   several TX descriptors (observed with igb)
 * USB host controllers, when handling a packet with multiple data TRBs
   (observed with xhci)

Previously, qemu only provided a single bounce buffer per AddressSpace
and would fail DMA map requests while the buffer was already in use. In
turn, this would cause DMA failures that ultimately manifest as hardware
errors from the guest perspective.

This change allocates DMA bounce buffers dynamically instead of
supporting only a single buffer. Thus, multiple DMA mappings work
correctly also when RAM can't be mmap()-ed.

The total bounce buffer allocation size is limited individually for each
AddressSpace. The default limit is 4096 bytes, matching the previous
maximum buffer size. A new x-max-bounce-buffer-size parameter is
provided to configure the limit for PCI devices.

Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
---
 hw/pci/pci.c                |  8 ++++
 include/exec/memory.h       | 14 ++----
 include/hw/pci/pci_device.h |  3 ++
 softmmu/memory.c            |  3 +-
 softmmu/physmem.c           | 94 +++++++++++++++++++++++++------------
 5 files changed, 80 insertions(+), 42 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 881d774fb6..8c4541b394 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -85,6 +85,8 @@ static Property pci_props[] = {
                     QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
     DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
                     QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
+    DEFINE_PROP_SIZE("x-max-bounce-buffer-size", PCIDevice,
+                     max_bounce_buffer_size, 4096),
     DEFINE_PROP_END_OF_LIST()
 };
 
@@ -1208,6 +1210,8 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
                        "bus master container", UINT64_MAX);
     address_space_init(&pci_dev->bus_master_as,
                        &pci_dev->bus_master_container_region, pci_dev->name);
+    pci_dev->bus_master_as.max_bounce_buffer_size =
+        pci_dev->max_bounce_buffer_size;
 
     if (phase_check(PHASE_MACHINE_READY)) {
         pci_init_bus_master(pci_dev);
@@ -2664,6 +2668,10 @@ static void pci_device_class_init(ObjectClass *klass, void *data)
     k->unrealize = pci_qdev_unrealize;
     k->bus_type = TYPE_PCI_BUS;
     device_class_set_props(k, pci_props);
+    object_class_property_set_description(
+        klass, "x-max-bounce-buffer-size",
+        "Maximum buffer size allocated for bounce buffers used for mapped "
+        "access to indirect DMA memory");
 }
 
 static void pci_device_class_base_init(ObjectClass *klass, void *data)
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 7d68936157..5577542b5e 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1081,14 +1081,6 @@ typedef struct AddressSpaceMapClient {
     QLIST_ENTRY(AddressSpaceMapClient) link;
 } AddressSpaceMapClient;
 
-typedef struct {
-    MemoryRegion *mr;
-    void *buffer;
-    hwaddr addr;
-    hwaddr len;
-    bool in_use;
-} BounceBuffer;
-
 /**
  * struct AddressSpace: describes a mapping of addresses to #MemoryRegion objects
  */
@@ -1106,8 +1098,10 @@ struct AddressSpace {
     QTAILQ_HEAD(, MemoryListener) listeners;
     QTAILQ_ENTRY(AddressSpace) address_spaces_link;
 
-    /* Bounce buffer to use for this address space. */
-    BounceBuffer bounce;
+    /* Maximum DMA bounce buffer size used for indirect memory map requests */
+    uint64_t max_bounce_buffer_size;
+    /* Total size of bounce buffers currently allocated, atomically accessed */
+    uint64_t bounce_buffer_size;
     /* List of callbacks to invoke when buffers free up */
     QemuMutex map_client_list_lock;
     QLIST_HEAD(, AddressSpaceMapClient) map_client_list;
diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index d3dd0f64b2..f4027c5379 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -160,6 +160,9 @@ struct PCIDevice {
     /* ID of standby device in net_failover pair */
     char *failover_pair_id;
     uint32_t acpi_index;
+
+    /* Maximum DMA bounce buffer size used for indirect memory map requests */
+    uint64_t max_bounce_buffer_size;
 };
 
 static inline int pci_intx(PCIDevice *pci_dev)
diff --git a/softmmu/memory.c b/softmmu/memory.c
index 5c9622c3d6..e02799359c 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -3105,7 +3105,8 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
     as->ioeventfds = NULL;
     QTAILQ_INIT(&as->listeners);
     QTAILQ_INSERT_TAIL(&address_spaces, as, address_spaces_link);
-    as->bounce.in_use = false;
+    as->max_bounce_buffer_size = 4096;
+    as->bounce_buffer_size = 0;
     qemu_mutex_init(&as->map_client_list_lock);
     QLIST_INIT(&as->map_client_list);
     as->name = g_strdup(name ? name : "anonymous");
diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index f40cc564b8..e3d1cf5fba 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -2926,6 +2926,20 @@ void cpu_flush_icache_range(hwaddr start, hwaddr len)
                                      NULL, len, FLUSH_CACHE);
 }
 
+/*
+ * A magic value stored in the first 8 bytes of the bounce buffer struct. Used
+ * to detect illegal pointers passed to address_space_unmap.
+ */
+#define BOUNCE_BUFFER_MAGIC 0xb4017ceb4ffe12ed
+
+typedef struct {
+    uint64_t magic;
+    MemoryRegion *mr;
+    hwaddr addr;
+    size_t len;
+    uint8_t buffer[];
+} BounceBuffer;
+
 static void
 address_space_unregister_map_client_do(AddressSpaceMapClient *client)
 {
@@ -2953,7 +2967,7 @@ void address_space_register_map_client(AddressSpace *as, QEMUBH *bh)
     QLIST_INSERT_HEAD(&as->map_client_list, client, link);
     /* Write map_client_list before reading bounce_buffer_size.  */
     smp_mb();
-    if (!qatomic_read(&as->bounce.in_use)) {
+    if (qatomic_read(&as->bounce_buffer_size) < as->max_bounce_buffer_size) {
         address_space_notify_map_clients_locked(as);
     }
     qemu_mutex_unlock(&as->map_client_list_lock);
@@ -3081,31 +3095,36 @@ void *address_space_map(AddressSpace *as,
     RCU_READ_LOCK_GUARD();
     fv = address_space_to_flatview(as);
     mr = flatview_translate(fv, addr, &xlat, &l, is_write, attrs);
+    memory_region_ref(mr);
 
     if (!memory_access_is_direct(mr, is_write)) {
-        if (qatomic_xchg(&as->bounce.in_use, true)) {
+        size_t size = qatomic_add_fetch(&as->bounce_buffer_size, l);
+        if (size > as->max_bounce_buffer_size) {
+            size_t excess = size - as->max_bounce_buffer_size;
+            l -= excess;
+            qatomic_sub(&as->bounce_buffer_size, excess);
+        }
+
+        if (l == 0) {
             *plen = 0;
             return NULL;
         }
-        /* Avoid unbounded allocations */
-        l = MIN(l, TARGET_PAGE_SIZE);
-        as->bounce.buffer = qemu_memalign(TARGET_PAGE_SIZE, l);
-        as->bounce.addr = addr;
-        as->bounce.len = l;
 
-        memory_region_ref(mr);
-        as->bounce.mr = mr;
+        BounceBuffer *bounce = g_malloc0(l + sizeof(BounceBuffer));
+        bounce->magic = BOUNCE_BUFFER_MAGIC;
+        bounce->mr = mr;
+        bounce->addr = addr;
+        bounce->len = l;
+
         if (!is_write) {
             flatview_read(fv, addr, MEMTXATTRS_UNSPECIFIED,
-                          as->bounce.buffer, l);
+                          bounce->buffer, l);
         }
 
         *plen = l;
-        return as->bounce.buffer;
+        return bounce->buffer;
     }
 
-
-    memory_region_ref(mr);
     *plen = flatview_extend_translation(fv, addr, len, mr, xlat,
                                         l, is_write, attrs);
     fuzz_dma_read_cb(addr, *plen, mr);
@@ -3119,31 +3138,44 @@ void *address_space_map(AddressSpace *as,
 void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
                          bool is_write, hwaddr access_len)
 {
-    if (buffer != as->bounce.buffer) {
-        MemoryRegion *mr;
-        ram_addr_t addr1;
+    MemoryRegion *mr;
+    ram_addr_t addr1;
+
+    mr = memory_region_from_host(buffer, &addr1);
+    if (mr == NULL) {
+        BounceBuffer *bounce = container_of(buffer, BounceBuffer, buffer);
+        if (bounce->magic != BOUNCE_BUFFER_MAGIC) {
+            error_report(
+                "Unmap request for %p, which neither corresponds to a memory "
+                "region, nor looks like a bounce buffer, ignoring!",
+                buffer);
+            return;
+        }
 
-        mr = memory_region_from_host(buffer, &addr1);
-        assert(mr != NULL);
         if (is_write) {
-            invalidate_and_set_dirty(mr, addr1, access_len);
+            address_space_write(as, bounce->addr, MEMTXATTRS_UNSPECIFIED,
+                                bounce->buffer, access_len);
         }
-        if (xen_enabled()) {
-            xen_invalidate_map_cache_entry(buffer);
+
+        memory_region_unref(bounce->mr);
+        uint64_t previous_buffer_size =
+            qatomic_fetch_sub(&as->bounce_buffer_size, bounce->len);
+        if (previous_buffer_size == as->max_bounce_buffer_size) {
+            /* Write bounce_buffer_size before reading map_client_list. */
+            smp_mb();
+            address_space_notify_map_clients(as);
         }
-        memory_region_unref(mr);
+        bounce->magic = ~BOUNCE_BUFFER_MAGIC;
+        g_free(bounce);
         return;
     }
+
+    if (xen_enabled()) {
+        xen_invalidate_map_cache_entry(buffer);
+    }
     if (is_write) {
-        address_space_write(as, as->bounce.addr, MEMTXATTRS_UNSPECIFIED,
-                            as->bounce.buffer, access_len);
-    }
-    qemu_vfree(as->bounce.buffer);
-    as->bounce.buffer = NULL;
-    memory_region_unref(as->bounce.mr);
-    /* Clear in_use before reading map_client_list.  */
-    qatomic_set_mb(&as->bounce.in_use, false);
-    address_space_notify_map_clients(as);
+        invalidate_and_set_dirty(mr, addr1, access_len);
+    }
 }
 
 void *cpu_physical_memory_map(hwaddr addr,
-- 
2.34.1


