Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C877972C1
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:14:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEgV-00033x-4p; Thu, 07 Sep 2023 09:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qeEgO-00031r-AR
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:04:28 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qeEgK-00082c-3l
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:04:28 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-26b41112708so712772a91.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694091862; x=1694696662;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9QnPkPrqpN3t/VxpGhAabpkEZqu+enV6J+UoWWwNrfM=;
 b=1214Nxpd6QEpMdRHfvhoIlJtiY9W8DqfyD9tYOQfdOKI3ynZi/nlFoGK+EdvvKDHxv
 Jp2MBSJhNVJwGxQvHZP9ISWOtgFlaUKV5yqgXCx/ojavFKWrSb6+O2Quj3Zrn2kDt0gx
 jgNEQCZUYqwFfAv2DlKthW5pZaDZMdnvFP6Hle2di4hZAT4PbEbDGOkb3txDCYGS6llG
 IxShAJFVYJ3tr1g128giu8AFCzdwGpGn8ZS2OFj/QmXGF1ab3AJxGin0f4plLdRPnhIq
 jVWmpHulF0DT9195OQ4lxdOgYGmmU2Rr1fT1d6+vnLHBpFav/+j9M3EPjnPVXPyAW92v
 GWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091862; x=1694696662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9QnPkPrqpN3t/VxpGhAabpkEZqu+enV6J+UoWWwNrfM=;
 b=R0FJMo5NzQhQ+yBaNY3LXih9FQbTk57nUfBY5elTy26UT4iwNSd6JPcLgJCAmErrl9
 vUw2u49bk7Bi8NDzdeYi2Rm0+v0yUwq00y+Kryiw9vd4n8x0oNj22DENH+7egedtUiAC
 x8n2457yXIvUUz22lBtc+X/0gIZhHf5r2oVjb5Gvv/XJZ/bR4/uUMfSqXYqvV0NTIikl
 NrYZXhHpUqsBdHbWLSH9DQOxZZLYfJsLhN9XqXdRlQDzx61XHIarmxHQSF+DgG8+D1YV
 nrCT/D4mLlyWRcJ28KKIui8u5aMNZri+rq6SgRxL8pvJjo/EZxcvqoVx+jCY3/aUmS9V
 nA0Q==
X-Gm-Message-State: AOJu0YxyJxWXo9u7E6ZiA7XqPSqhopQj9SkG4jRK+txHcVVhYJ12JIhg
 NHg0lJv2Zh7ShYMEdxZn/aHy25CT8Q8tbf604hgMPQ==
X-Google-Smtp-Source: AGHT+IEjsNYiTigcAQx/T0qNJb/Mnzv7qSJe55vdOOBuur55l5hxywDdHx5aXN0ap+MQ0MF6myLR+Q==
X-Received: by 2002:a17:90b:1956:b0:263:9816:fe0f with SMTP id
 nk22-20020a17090b195600b002639816fe0fmr18369674pjb.15.1694091861810; 
 Thu, 07 Sep 2023 06:04:21 -0700 (PDT)
Received: from mnissler.ba.rivosinc.com ([66.220.2.162])
 by smtp.gmail.com with ESMTPSA id
 g24-20020a170902fe1800b001b0358848b0sm12821913plj.161.2023.09.07.06.04.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:04:21 -0700 (PDT)
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
Subject: [PATCH v3 1/5] softmmu: Per-AddressSpace bounce buffering
Date: Thu,  7 Sep 2023 06:04:06 -0700
Message-Id: <20230907130410.498935-2-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907130410.498935-1-mnissler@rivosinc.com>
References: <20230907130410.498935-1-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=mnissler@rivosinc.com; helo=mail-pj1-x1031.google.com
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

Instead of using a single global bounce buffer, give each AddressSpace
its own bounce buffer. The MapClient callback mechanism moves to
AddressSpace accordingly.

This is in preparation for generalizing bounce buffer handling further
to allow multiple bounce buffers, with a total allocation limit
configured per AddressSpace.

Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
---
 include/exec/cpu-common.h |   2 -
 include/exec/memory.h     |  45 ++++++++++++++++-
 softmmu/dma-helpers.c     |   4 +-
 softmmu/memory.c          |   3 ++
 softmmu/physmem.c         | 103 ++++++++++++++++----------------------
 5 files changed, 90 insertions(+), 67 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 41788c0bdd..63463c415d 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -138,8 +138,6 @@ void *cpu_physical_memory_map(hwaddr addr,
                               bool is_write);
 void cpu_physical_memory_unmap(void *buffer, hwaddr len,
                                bool is_write, hwaddr access_len);
-void cpu_register_map_client(QEMUBH *bh);
-void cpu_unregister_map_client(QEMUBH *bh);
 
 bool cpu_physical_memory_is_io(hwaddr phys_addr);
 
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 68284428f8..7d68936157 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1076,6 +1076,19 @@ struct MemoryListener {
     QTAILQ_ENTRY(MemoryListener) link_as;
 };
 
+typedef struct AddressSpaceMapClient {
+    QEMUBH *bh;
+    QLIST_ENTRY(AddressSpaceMapClient) link;
+} AddressSpaceMapClient;
+
+typedef struct {
+    MemoryRegion *mr;
+    void *buffer;
+    hwaddr addr;
+    hwaddr len;
+    bool in_use;
+} BounceBuffer;
+
 /**
  * struct AddressSpace: describes a mapping of addresses to #MemoryRegion objects
  */
@@ -1092,6 +1105,12 @@ struct AddressSpace {
     struct MemoryRegionIoeventfd *ioeventfds;
     QTAILQ_HEAD(, MemoryListener) listeners;
     QTAILQ_ENTRY(AddressSpace) address_spaces_link;
+
+    /* Bounce buffer to use for this address space. */
+    BounceBuffer bounce;
+    /* List of callbacks to invoke when buffers free up */
+    QemuMutex map_client_list_lock;
+    QLIST_HEAD(, AddressSpaceMapClient) map_client_list;
 };
 
 typedef struct AddressSpaceDispatch AddressSpaceDispatch;
@@ -2832,8 +2851,8 @@ bool address_space_access_valid(AddressSpace *as, hwaddr addr, hwaddr len,
  * May return %NULL and set *@plen to zero(0), if resources needed to perform
  * the mapping are exhausted.
  * Use only for reads OR writes - not for read-modify-write operations.
- * Use cpu_register_map_client() to know when retrying the map operation is
- * likely to succeed.
+ * Use address_space_register_map_client() to know when retrying the map
+ * operation is likely to succeed.
  *
  * @as: #AddressSpace to be accessed
  * @addr: address within that address space
@@ -2858,6 +2877,28 @@ void *address_space_map(AddressSpace *as, hwaddr addr,
 void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
                          bool is_write, hwaddr access_len);
 
+/*
+ * address_space_register_map_client: Register a callback to invoke when
+ * resources for address_space_map() are available again.
+ *
+ * address_space_map may fail when there are not enough resources available,
+ * such as when bounce buffer memory would exceed the limit. The callback can
+ * be used to retry the address_space_map operation. Note that the callback
+ * gets automatically removed after firing.
+ *
+ * @as: #AddressSpace to be accessed
+ * @bh: callback to invoke when address_space_map() retry is appropriate
+ */
+void address_space_register_map_client(AddressSpace *as, QEMUBH *bh);
+
+/*
+ * address_space_unregister_map_client: Unregister a callback that has
+ * previously been registered and not fired yet.
+ *
+ * @as: #AddressSpace to be accessed
+ * @bh: callback to unregister
+ */
+void address_space_unregister_map_client(AddressSpace *as, QEMUBH *bh);
 
 /* Internal functions, part of the implementation of address_space_read.  */
 MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
diff --git a/softmmu/dma-helpers.c b/softmmu/dma-helpers.c
index 2463964805..d9fc26c063 100644
--- a/softmmu/dma-helpers.c
+++ b/softmmu/dma-helpers.c
@@ -167,7 +167,7 @@ static void dma_blk_cb(void *opaque, int ret)
     if (dbs->iov.size == 0) {
         trace_dma_map_wait(dbs);
         dbs->bh = aio_bh_new(ctx, reschedule_dma, dbs);
-        cpu_register_map_client(dbs->bh);
+        address_space_register_map_client(dbs->sg->as, dbs->bh);
         goto out;
     }
 
@@ -197,7 +197,7 @@ static void dma_aio_cancel(BlockAIOCB *acb)
     }
 
     if (dbs->bh) {
-        cpu_unregister_map_client(dbs->bh);
+        address_space_unregister_map_client(dbs->sg->as, dbs->bh);
         qemu_bh_delete(dbs->bh);
         dbs->bh = NULL;
     }
diff --git a/softmmu/memory.c b/softmmu/memory.c
index 7d9494ce70..5c9622c3d6 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -3105,6 +3105,9 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
     as->ioeventfds = NULL;
     QTAILQ_INIT(&as->listeners);
     QTAILQ_INSERT_TAIL(&address_spaces, as, address_spaces_link);
+    as->bounce.in_use = false;
+    qemu_mutex_init(&as->map_client_list_lock);
+    QLIST_INIT(&as->map_client_list);
     as->name = g_strdup(name ? name : "anonymous");
     address_space_update_topology(as);
     address_space_update_ioeventfds(as);
diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index 18277ddd67..f40cc564b8 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -2926,55 +2926,37 @@ void cpu_flush_icache_range(hwaddr start, hwaddr len)
                                      NULL, len, FLUSH_CACHE);
 }
 
-typedef struct {
-    MemoryRegion *mr;
-    void *buffer;
-    hwaddr addr;
-    hwaddr len;
-    bool in_use;
-} BounceBuffer;
-
-static BounceBuffer bounce;
-
-typedef struct MapClient {
-    QEMUBH *bh;
-    QLIST_ENTRY(MapClient) link;
-} MapClient;
-
-QemuMutex map_client_list_lock;
-static QLIST_HEAD(, MapClient) map_client_list
-    = QLIST_HEAD_INITIALIZER(map_client_list);
-
-static void cpu_unregister_map_client_do(MapClient *client)
+static void
+address_space_unregister_map_client_do(AddressSpaceMapClient *client)
 {
     QLIST_REMOVE(client, link);
     g_free(client);
 }
 
-static void cpu_notify_map_clients_locked(void)
+static void address_space_notify_map_clients_locked(AddressSpace *as)
 {
-    MapClient *client;
+    AddressSpaceMapClient *client;
 
-    while (!QLIST_EMPTY(&map_client_list)) {
-        client = QLIST_FIRST(&map_client_list);
+    while (!QLIST_EMPTY(&as->map_client_list)) {
+        client = QLIST_FIRST(&as->map_client_list);
         qemu_bh_schedule(client->bh);
-        cpu_unregister_map_client_do(client);
+        address_space_unregister_map_client_do(client);
     }
 }
 
-void cpu_register_map_client(QEMUBH *bh)
+void address_space_register_map_client(AddressSpace *as, QEMUBH *bh)
 {
-    MapClient *client = g_malloc(sizeof(*client));
+    AddressSpaceMapClient *client = g_malloc(sizeof(*client));
 
-    qemu_mutex_lock(&map_client_list_lock);
+    qemu_mutex_lock(&as->map_client_list_lock);
     client->bh = bh;
-    QLIST_INSERT_HEAD(&map_client_list, client, link);
-    /* Write map_client_list before reading in_use.  */
+    QLIST_INSERT_HEAD(&as->map_client_list, client, link);
+    /* Write map_client_list before reading bounce_buffer_size.  */
     smp_mb();
-    if (!qatomic_read(&bounce.in_use)) {
-        cpu_notify_map_clients_locked();
+    if (!qatomic_read(&as->bounce.in_use)) {
+        address_space_notify_map_clients_locked(as);
     }
-    qemu_mutex_unlock(&map_client_list_lock);
+    qemu_mutex_unlock(&as->map_client_list_lock);
 }
 
 void cpu_exec_init_all(void)
@@ -2990,28 +2972,27 @@ void cpu_exec_init_all(void)
     finalize_target_page_bits();
     io_mem_init();
     memory_map_init();
-    qemu_mutex_init(&map_client_list_lock);
 }
 
-void cpu_unregister_map_client(QEMUBH *bh)
+void address_space_unregister_map_client(AddressSpace *as, QEMUBH *bh)
 {
-    MapClient *client;
+    AddressSpaceMapClient *client;
 
-    qemu_mutex_lock(&map_client_list_lock);
-    QLIST_FOREACH(client, &map_client_list, link) {
+    qemu_mutex_lock(&as->map_client_list_lock);
+    QLIST_FOREACH(client, &as->map_client_list, link) {
         if (client->bh == bh) {
-            cpu_unregister_map_client_do(client);
+            address_space_unregister_map_client_do(client);
             break;
         }
     }
-    qemu_mutex_unlock(&map_client_list_lock);
+    qemu_mutex_unlock(&as->map_client_list_lock);
 }
 
-static void cpu_notify_map_clients(void)
+static void address_space_notify_map_clients(AddressSpace *as)
 {
-    qemu_mutex_lock(&map_client_list_lock);
-    cpu_notify_map_clients_locked();
-    qemu_mutex_unlock(&map_client_list_lock);
+    qemu_mutex_lock(&as->map_client_list_lock);
+    address_space_notify_map_clients_locked(as);
+    qemu_mutex_unlock(&as->map_client_list_lock);
 }
 
 static bool flatview_access_valid(FlatView *fv, hwaddr addr, hwaddr len,
@@ -3078,8 +3059,8 @@ flatview_extend_translation(FlatView *fv, hwaddr addr,
  * May map a subset of the requested range, given by and returned in *plen.
  * May return NULL if resources needed to perform the mapping are exhausted.
  * Use only for reads OR writes - not for read-modify-write operations.
- * Use cpu_register_map_client() to know when retrying the map operation is
- * likely to succeed.
+ * Use address_space_register_map_client() to know when retrying the map
+ * operation is likely to succeed.
  */
 void *address_space_map(AddressSpace *as,
                         hwaddr addr,
@@ -3102,25 +3083,25 @@ void *address_space_map(AddressSpace *as,
     mr = flatview_translate(fv, addr, &xlat, &l, is_write, attrs);
 
     if (!memory_access_is_direct(mr, is_write)) {
-        if (qatomic_xchg(&bounce.in_use, true)) {
+        if (qatomic_xchg(&as->bounce.in_use, true)) {
             *plen = 0;
             return NULL;
         }
         /* Avoid unbounded allocations */
         l = MIN(l, TARGET_PAGE_SIZE);
-        bounce.buffer = qemu_memalign(TARGET_PAGE_SIZE, l);
-        bounce.addr = addr;
-        bounce.len = l;
+        as->bounce.buffer = qemu_memalign(TARGET_PAGE_SIZE, l);
+        as->bounce.addr = addr;
+        as->bounce.len = l;
 
         memory_region_ref(mr);
-        bounce.mr = mr;
+        as->bounce.mr = mr;
         if (!is_write) {
             flatview_read(fv, addr, MEMTXATTRS_UNSPECIFIED,
-                               bounce.buffer, l);
+                          as->bounce.buffer, l);
         }
 
         *plen = l;
-        return bounce.buffer;
+        return as->bounce.buffer;
     }
 
 
@@ -3138,7 +3119,7 @@ void *address_space_map(AddressSpace *as,
 void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
                          bool is_write, hwaddr access_len)
 {
-    if (buffer != bounce.buffer) {
+    if (buffer != as->bounce.buffer) {
         MemoryRegion *mr;
         ram_addr_t addr1;
 
@@ -3154,15 +3135,15 @@ void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
         return;
     }
     if (is_write) {
-        address_space_write(as, bounce.addr, MEMTXATTRS_UNSPECIFIED,
-                            bounce.buffer, access_len);
+        address_space_write(as, as->bounce.addr, MEMTXATTRS_UNSPECIFIED,
+                            as->bounce.buffer, access_len);
     }
-    qemu_vfree(bounce.buffer);
-    bounce.buffer = NULL;
-    memory_region_unref(bounce.mr);
+    qemu_vfree(as->bounce.buffer);
+    as->bounce.buffer = NULL;
+    memory_region_unref(as->bounce.mr);
     /* Clear in_use before reading map_client_list.  */
-    qatomic_set_mb(&bounce.in_use, false);
-    cpu_notify_map_clients();
+    qatomic_set_mb(&as->bounce.in_use, false);
+    address_space_notify_map_clients(as);
 }
 
 void *cpu_physical_memory_map(hwaddr addr,
-- 
2.34.1


