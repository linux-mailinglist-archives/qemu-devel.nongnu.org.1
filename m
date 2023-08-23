Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5EC785409
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 11:30:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYkBA-00056D-D3; Wed, 23 Aug 2023 05:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qYkB8-0004xy-27
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 05:29:30 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qYkB6-0006YJ-19
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 05:29:29 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68a2bf8d404so2824460b3a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 02:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1692782966; x=1693387766; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hT2FZgX3WdlDwv5kB6R6HuP5QXnrlRh8hxyUD6s8wdQ=;
 b=aQQjvXnnEqhzjkZ/uVjzAdSY4USm2hcxOo435Ywyuy5lZRY1SXGPqRfqIBf6A/h3xL
 y9PQXuuEkTmuBPF64kLqPZ+xTEtRb7J0bl5wwbOBwLmC6parCL+tIb+rIHFjYApclysA
 Fhoo5nfy4PJ5sQ1qM5+0o/ennkfjY5tJx7xUpZ6TiZPm2LiDFNZIRkh4+QGvwvn4yUIw
 1P031os3AdtTDFNniSovSvfHfR+HqSkudV4l/bFBMHproWqwgLvNPNyigAJyrvi+RPCq
 6iV50q1wyHuzReZoBpkcFiuYhu9H3A4ibmbpmkQdWIb3VeLYmLOj4fPkCoJX2FOrXCq1
 Jd+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692782966; x=1693387766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hT2FZgX3WdlDwv5kB6R6HuP5QXnrlRh8hxyUD6s8wdQ=;
 b=aK9qTYav593b4C4aOq/VshVHHj+LAFi9eucRcNLEqAZCgEqKjmnecBFSd+VeTTBpoS
 okaUTK3eDobGGx77A6C7nb08DwuadgAlIt7PxnT+addZWm24hiyjdiEjVzh4fWwjlsal
 CMuEQMHctfdeKyvCs5gYwxzjS6sa5U5hs6b+ATWF+VJyf0aJzyq4Zi9sI1Bw0x4HNz6N
 Eq+SCgU8fSDM9oftAHC/bTs3O4u9hXBOFAe3PpwYFNOXvfPXJ9AZBbA6sldwbKpHQBF/
 esW4zywi+4054+3fy5tjp3j1xtPBYngy17zrq9qiQNmSc5T5Y7nwE2At76jNYetXmrMb
 8kbw==
X-Gm-Message-State: AOJu0Yz/cah1PFSSY49wCuDy1TJE+kVMKROyWOk/6ugpbFi6E06RrsBA
 MVWLi/RONQZkDAopSlGoahJ81eM4jSTYI/85d/c=
X-Google-Smtp-Source: AGHT+IEX9vHsG1AHGqn74XjPqUGd5NCaCv/Yk5nDnNS7w/yri8h2i3drxdONuF5Xn0FhDeo1NwytoQ==
X-Received: by 2002:a05:6a00:cc1:b0:68a:54c6:3aa0 with SMTP id
 b1-20020a056a000cc100b0068a54c63aa0mr7818368pfv.17.1692782966184; 
 Wed, 23 Aug 2023 02:29:26 -0700 (PDT)
Received: from mnissler.ba.rivosinc.com ([66.220.2.162])
 by smtp.gmail.com with ESMTPSA id
 c10-20020aa78c0a000000b006875df4773fsm1169462pfd.163.2023.08.23.02.29.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 02:29:25 -0700 (PDT)
From: Mattias Nissler <mnissler@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: john.levon@nutanix.com, stefanha@redhat.com,
 Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH v2 1/4] softmmu: Support concurrent bounce buffers
Date: Wed, 23 Aug 2023 02:29:02 -0700
Message-Id: <20230823092905.2259418-2-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823092905.2259418-1-mnissler@rivosinc.com>
References: <20230823092905.2259418-1-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=mnissler@rivosinc.com; helo=mail-pf1-x42f.google.com
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

Previously, qemu only provided a single bounce buffer and would fail DMA
map requests while the buffer was already in use. In turn, this would
cause DMA failures that ultimately manifest as hardware errors from the
guest perspective.

This change allocates DMA bounce buffers dynamically instead of
supporting only a single buffer. Thus, multiple DMA mappings work
correctly also when RAM can't be mmap()-ed.

The total bounce buffer allocation size is limited by a new command line
parameter. The default is 4096 bytes to match the previous maximum
buffer size. It is expected that suitable limits will vary quite a bit
in practice depending on device models and workloads.

Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
---
 include/sysemu/sysemu.h |  2 +
 qemu-options.hx         | 27 +++++++++++++
 softmmu/globals.c       |  1 +
 softmmu/physmem.c       | 84 +++++++++++++++++++++++------------------
 softmmu/vl.c            |  6 +++
 5 files changed, 83 insertions(+), 37 deletions(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 25be2a692e..c5dc93cb53 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -61,6 +61,8 @@ extern int nb_option_roms;
 extern const char *prom_envs[MAX_PROM_ENVS];
 extern unsigned int nb_prom_envs;
 
+extern uint64_t max_bounce_buffer_size;
+
 /* serial ports */
 
 /* Return the Chardev for serial port i, or NULL if none */
diff --git a/qemu-options.hx b/qemu-options.hx
index 29b98c3d4c..6071794237 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4959,6 +4959,33 @@ SRST
 ERST
 #endif
 
+DEF("max-bounce-buffer-size", HAS_ARG,
+    QEMU_OPTION_max_bounce_buffer_size,
+    "-max-bounce-buffer-size size\n"
+    "                DMA bounce buffer size limit in bytes (default=4096)\n",
+    QEMU_ARCH_ALL)
+SRST
+``-max-bounce-buffer-size size``
+    Set the limit in bytes for DMA bounce buffer allocations.
+
+    DMA bounce buffers are used when device models request memory-mapped access
+    to memory regions that can't be directly mapped by the qemu process, so the
+    memory must read or written to a temporary local buffer for the device
+    model to work with. This is the case e.g. for I/O memory regions, and when
+    running in multi-process mode without shared access to memory.
+
+    Whether bounce buffering is necessary depends heavily on the device model
+    implementation. Some devices use explicit DMA read and write operations
+    which do not require bounce buffers. Some devices, notably storage, will
+    retry a failed DMA map request after bounce buffer space becomes available
+    again. Most other devices will bail when encountering map request failures,
+    which will typically appear to the guest as a hardware error.
+
+    Suitable bounce buffer size values depend on the workload and guest
+    configuration. A few kilobytes up to a few megabytes are common sizes
+    encountered in practice.
+ERST
+
 DEFHEADING()
 
 DEFHEADING(Generic object creation:)
diff --git a/softmmu/globals.c b/softmmu/globals.c
index e83b5428d1..d3cc010717 100644
--- a/softmmu/globals.c
+++ b/softmmu/globals.c
@@ -54,6 +54,7 @@ const char *prom_envs[MAX_PROM_ENVS];
 uint8_t *boot_splash_filedata;
 int only_migratable; /* turn it off unless user states otherwise */
 int icount_align_option;
+uint64_t max_bounce_buffer_size = 4096;
 
 /* The bytes in qemu_uuid are in the order specified by RFC4122, _not_ in the
  * little-endian "wire format" described in the SMBIOS 2.6 specification.
diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index 3df73542e1..9f0fec0c8e 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -50,6 +50,7 @@
 #include "sysemu/dma.h"
 #include "sysemu/hostmem.h"
 #include "sysemu/hw_accel.h"
+#include "sysemu/sysemu.h"
 #include "sysemu/xen-mapcache.h"
 #include "trace/trace-root.h"
 
@@ -2904,13 +2905,12 @@ void cpu_flush_icache_range(hwaddr start, hwaddr len)
 
 typedef struct {
     MemoryRegion *mr;
-    void *buffer;
     hwaddr addr;
-    hwaddr len;
-    bool in_use;
+    size_t len;
+    uint8_t buffer[];
 } BounceBuffer;
 
-static BounceBuffer bounce;
+static size_t bounce_buffer_size;
 
 typedef struct MapClient {
     QEMUBH *bh;
@@ -2945,9 +2945,9 @@ void cpu_register_map_client(QEMUBH *bh)
     qemu_mutex_lock(&map_client_list_lock);
     client->bh = bh;
     QLIST_INSERT_HEAD(&map_client_list, client, link);
-    /* Write map_client_list before reading in_use.  */
+    /* Write map_client_list before reading bounce_buffer_size.  */
     smp_mb();
-    if (!qatomic_read(&bounce.in_use)) {
+    if (qatomic_read(&bounce_buffer_size) < max_bounce_buffer_size) {
         cpu_notify_map_clients_locked();
     }
     qemu_mutex_unlock(&map_client_list_lock);
@@ -3076,31 +3076,35 @@ void *address_space_map(AddressSpace *as,
     RCU_READ_LOCK_GUARD();
     fv = address_space_to_flatview(as);
     mr = flatview_translate(fv, addr, &xlat, &l, is_write, attrs);
+    memory_region_ref(mr);
 
     if (!memory_access_is_direct(mr, is_write)) {
-        if (qatomic_xchg(&bounce.in_use, true)) {
+        size_t size = qatomic_add_fetch(&bounce_buffer_size, l);
+        if (size > max_bounce_buffer_size) {
+            size_t excess = size - max_bounce_buffer_size;
+            l -= excess;
+            qatomic_sub(&bounce_buffer_size, excess);
+        }
+
+        if (l == 0) {
             *plen = 0;
             return NULL;
         }
-        /* Avoid unbounded allocations */
-        l = MIN(l, TARGET_PAGE_SIZE);
-        bounce.buffer = qemu_memalign(TARGET_PAGE_SIZE, l);
-        bounce.addr = addr;
-        bounce.len = l;
 
-        memory_region_ref(mr);
-        bounce.mr = mr;
+        BounceBuffer *bounce = g_malloc(l + sizeof(BounceBuffer));
+        bounce->mr = mr;
+        bounce->addr = addr;
+        bounce->len = l;
+
         if (!is_write) {
             flatview_read(fv, addr, MEMTXATTRS_UNSPECIFIED,
-                               bounce.buffer, l);
+                          bounce->buffer, l);
         }
 
         *plen = l;
-        return bounce.buffer;
+        return bounce->buffer;
     }
 
-
-    memory_region_ref(mr);
     *plen = flatview_extend_translation(fv, addr, len, mr, xlat,
                                         l, is_write, attrs);
     fuzz_dma_read_cb(addr, *plen, mr);
@@ -3114,31 +3118,37 @@ void *address_space_map(AddressSpace *as,
 void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
                          bool is_write, hwaddr access_len)
 {
-    if (buffer != bounce.buffer) {
-        MemoryRegion *mr;
-        ram_addr_t addr1;
+    MemoryRegion *mr;
+    ram_addr_t addr1;
+
+    mr = memory_region_from_host(buffer, &addr1);
+    if (mr == NULL) {
+        /*
+         * Must be a bounce buffer (unless the caller passed a pointer which
+         * wasn't returned by address_space_map, which is illegal).
+         */
+        BounceBuffer *bounce = container_of(buffer, BounceBuffer, buffer);
 
-        mr = memory_region_from_host(buffer, &addr1);
-        assert(mr != NULL);
         if (is_write) {
-            invalidate_and_set_dirty(mr, addr1, access_len);
-        }
-        if (xen_enabled()) {
-            xen_invalidate_map_cache_entry(buffer);
+            address_space_write(as, bounce->addr, MEMTXATTRS_UNSPECIFIED,
+                                bounce->buffer, access_len);
         }
-        memory_region_unref(mr);
+
+        memory_region_unref(bounce->mr);
+        qatomic_sub(&bounce_buffer_size, bounce->len);
+        /* Write bounce_buffer_size before reading map_client_list. */
+        smp_mb();
+        cpu_notify_map_clients();
+        g_free(bounce);
         return;
     }
+
+    if (xen_enabled()) {
+        xen_invalidate_map_cache_entry(buffer);
+    }
     if (is_write) {
-        address_space_write(as, bounce.addr, MEMTXATTRS_UNSPECIFIED,
-                            bounce.buffer, access_len);
-    }
-    qemu_vfree(bounce.buffer);
-    bounce.buffer = NULL;
-    memory_region_unref(bounce.mr);
-    /* Clear in_use before reading map_client_list.  */
-    qatomic_set_mb(&bounce.in_use, false);
-    cpu_notify_map_clients();
+        invalidate_and_set_dirty(mr, addr1, access_len);
+    }
 }
 
 void *cpu_physical_memory_map(hwaddr addr,
diff --git a/softmmu/vl.c b/softmmu/vl.c
index b0b96f67fa..dbe52f5ea1 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -3469,6 +3469,12 @@ void qemu_init(int argc, char **argv)
                 exit(1);
 #endif
                 break;
+            case QEMU_OPTION_max_bounce_buffer_size:
+                if (qemu_strtosz(optarg, NULL, &max_bounce_buffer_size) < 0) {
+                    error_report("invalid -max-ounce-buffer-size value");
+                    exit(1);
+                }
+                break;
             case QEMU_OPTION_object:
                 object_option_parse(optarg);
                 break;
-- 
2.34.1


