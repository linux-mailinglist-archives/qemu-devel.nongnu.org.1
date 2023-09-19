Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BB67A6898
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 18:09:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qidHY-0001q6-Rp; Tue, 19 Sep 2023 12:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qidHL-0001nI-TP
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 12:08:50 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qidHH-0004gQ-B9
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 12:08:46 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1c39f2b4f5aso43101335ad.0
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 09:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695139722; x=1695744522;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j1FqEkxaSEL5MqdpoIkOol7amYA4OW0zeDlDVPlJ1D4=;
 b=Hbi9+1OOYOSRfXoQto+ObB0DEBgw+lpMwqk9ZhKgxMA5VxB3Hl8nTwlhcPD+7NHYN2
 szwo3uqjU1mARm4KEQpmkFjQR+OQW1ijgTbu2ZKk6z2qiqqX3qlxpcO1uRWpOZJPXLuJ
 1eil/YLd8v0HqXMug7ZjKZjbnbjtbIIByvsrGt21g6LUKIKTvx0eIoJyRjb2Xh2mgHV1
 Ou1h5LewmrVYjSnYLmyhuj2B4kT5QFIRJ5pzi5LxbRM1Xj35y9c5YUe1J0EqejdDd0G4
 oS308s3r1/PqpwHBGXkGLeXFw2j/wqB2fjnPsa3n7dUsF9Nc/6NsK30nYEuRwloqiUGU
 RsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695139722; x=1695744522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j1FqEkxaSEL5MqdpoIkOol7amYA4OW0zeDlDVPlJ1D4=;
 b=AmmoWf/ZHSwNJLVx0k2tpEv1fMN+hZPaNJW3sjJRDwyCWKhCxIMNrOi8Ety4KOynAg
 IPNly6oEGdN23S+C0b8zQUM3LGb+gNj+2++jMhJUAmb2w5oFpV9U4ScBvpgLOMB6w+ZT
 ziN/bKo7bvtI3PWMoLYDev0hOraVpbMbeHWl80wzrKz04CRSLBP1XKH/FZnWj6oQYptX
 KR/eVde/aZv3mRGbgQsx470bdgTTyc1jIQuChvFs9ZYhx7Ho2voShHswd2vByTwvgrfW
 6O123ZCgt8i5Q5JOmqcQ62q3IWXh/w1NRghVjGoMqXXqRDIrXQ2ednWfj2SJx0eTaOie
 7m9Q==
X-Gm-Message-State: AOJu0YwB24H62ro6b+pPVOUm+Q4HceDo8o4QkXf7UyZinLgcE86jY/Or
 EGU36/U6sa4OhDWKqdirNPjqkHRwf9JlBgiLXMw=
X-Google-Smtp-Source: AGHT+IHUB+xrEidOcoC1d//ybSqdubMC4y88z8ZiG++g8Zoebe/t3AiIl+WUC8rranXb/z1ZLQ5jHA==
X-Received: by 2002:a17:903:1c8:b0:1c3:9544:cf63 with SMTP id
 e8-20020a17090301c800b001c39544cf63mr14665188plh.23.1695139721580; 
 Tue, 19 Sep 2023 09:08:41 -0700 (PDT)
Received: from mnissler.ba.rivosinc.com ([66.220.2.162])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a170902d34900b001b8a1a25e6asm8086308plk.128.2023.09.19.09.08.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 09:08:41 -0700 (PDT)
From: Mattias Nissler <mnissler@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: john.levon@nutanix.com, stefanha@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH v4 1/5] softmmu: Per-AddressSpace bounce buffering
Date: Tue, 19 Sep 2023 09:08:09 -0700
Message-Id: <20230919160814.3343727-2-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919160814.3343727-1-mnissler@rivosinc.com>
References: <20230919160814.3343727-1-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=mnissler@rivosinc.com; helo=mail-pl1-x631.google.com
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
 softmmu/memory.c          |   7 +++
 softmmu/physmem.c         | 103 ++++++++++++++++----------------------
 5 files changed, 94 insertions(+), 67 deletions(-)

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
index 7d9494ce70..ffa37fc327 100644
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
@@ -3112,6 +3115,10 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
 
 static void do_address_space_destroy(AddressSpace *as)
 {
+    assert(!qatomic_read(&as->bounce.in_use));
+    assert(QLIST_EMPTY(&as->map_client_list));
+    qemu_mutex_destroy(&as->map_client_list_lock);
+
     assert(QTAILQ_EMPTY(&as->listeners));
 
     flatview_unref(as->current_map);
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


