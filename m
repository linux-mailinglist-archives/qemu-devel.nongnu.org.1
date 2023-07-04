Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD507746B82
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 10:07:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGb3n-0006nC-TQ; Tue, 04 Jul 2023 04:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qGb3m-0006mz-4U
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:06:54 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qGb3g-0000sN-H9
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:06:53 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-666e64e97e2so2716277b3a.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 01:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688458007; x=1691050007; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gQ690QrMYdqdPeWSwhBzqou+wm7X9S8MDsUYTaTIvYY=;
 b=LwdnSD8EynBFBd/Q7iRdMxtbRk0YykA3puw+U3Ngj4LmWtkuawzQlKPyv9aLJrTTR/
 T1U2KHSuJEHP9NESrYmSvknRMwc0/ev8Y+zdkMQWNllaKPaLbs5KMbAdibxlCQVOpLMP
 luXmux2lrlErRWcj1bBhjNjmfmd0PoC8UInZ1sZI5R5iDmb42LwaHpLvgLQrWKK98+2u
 3VA2Ugi1wwpTKyySleWEojVgczeGzD/psiefFY8wkVd1r0MQfsMy7/X22L6uDO+LV8lH
 93c88EsLtz/qa0tKMPJkfl3itFcGLnv1Qmf7CjKMEteNh3b3TNkS6YFp1iS0kB63ttgo
 bbpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688458007; x=1691050007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gQ690QrMYdqdPeWSwhBzqou+wm7X9S8MDsUYTaTIvYY=;
 b=ZFivwvgxs/wN6Pld0Ysuxo+7tFPMA7fQMM/GpgMKqFBBzbgFPiEX42HbfuXpW6AdPy
 5O5uG0peGVl4roY7QXMcdnL8morHswCl6MTNPVycbO2kBJQPCSIu+cZEpa331EStHLfe
 GXj/qwj46rgDlRjgd+pALID5jEH8HbLPDcWpFeR72O6nbxLdk6TyIcl7mAYZsc1uVVNq
 BVEWAVWuZdEQebJxWrH/Bai5a0ocevhwYer2vFoikw5W4VcFJsHsE0StVvnyaE7KDbQP
 KN6tG1K7HCgjyNiWhyFF0hfZIgt+fq2rRP0+rmVp4kvDl1nbRmvby+9UH4hIumpMO269
 JR5Q==
X-Gm-Message-State: ABy/qLZu11ymUtpvIp3GZiv1/bkDL9udIT+PZDFmRqZQAxOopMf0Vcn6
 kMrwYKCUa/xRRWdnhdPZc3+L4M84QJon4hpeyZ4=
X-Google-Smtp-Source: APBJJlFuFRFsA9QE3oilriDfAesYiBkU4Ve/gyqnZHn8gphzu0EZtN0GU2qNiYdZP3CnbKeXoOV/+A==
X-Received: by 2002:a05:6a00:2389:b0:668:681f:ca98 with SMTP id
 f9-20020a056a00238900b00668681fca98mr14549431pfc.27.1688458006794; 
 Tue, 04 Jul 2023 01:06:46 -0700 (PDT)
Received: from mnissler.ba.rivosinc.com ([66.220.2.162])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b00662c4ca18ebsm15113101pfm.128.2023.07.04.01.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 01:06:46 -0700 (PDT)
From: Mattias Nissler <mnissler@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 stefanha@redhat.com, David Hildenbrand <david@redhat.com>,
 john.levon@nutanix.com, Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH 1/3] softmmu: Support concurrent bounce buffers
Date: Tue,  4 Jul 2023 01:06:25 -0700
Message-Id: <20230704080628.852525-2-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230704080628.852525-1-mnissler@rivosinc.com>
References: <20230704080628.852525-1-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=mnissler@rivosinc.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

It is not uncommon for device models to request mapping of several DMA
regions at the same time. An example is igb (and probably other net
devices as well) when a packet is spread across multiple descriptors.

In order to support this when indirect DMA is used, as is the case when
running the device model in a vfio-server process without mmap()-ed DMA,
this change allocates DMA bounce buffers dynamically instead of
supporting only a single buffer.

Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
---
 softmmu/physmem.c | 74 ++++++++++++++++++++++-------------------------
 1 file changed, 35 insertions(+), 39 deletions(-)

diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index bda475a719..56130b5a1d 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -2904,13 +2904,11 @@ void cpu_flush_icache_range(hwaddr start, hwaddr len)
 
 typedef struct {
     MemoryRegion *mr;
-    void *buffer;
     hwaddr addr;
-    hwaddr len;
-    bool in_use;
+    uint8_t buffer[];
 } BounceBuffer;
 
-static BounceBuffer bounce;
+static size_t bounce_buffers_in_use;
 
 typedef struct MapClient {
     QEMUBH *bh;
@@ -2947,7 +2945,7 @@ void cpu_register_map_client(QEMUBH *bh)
     QLIST_INSERT_HEAD(&map_client_list, client, link);
     /* Write map_client_list before reading in_use.  */
     smp_mb();
-    if (!qatomic_read(&bounce.in_use)) {
+    if (qatomic_read(&bounce_buffers_in_use)) {
         cpu_notify_map_clients_locked();
     }
     qemu_mutex_unlock(&map_client_list_lock);
@@ -3076,31 +3074,24 @@ void *address_space_map(AddressSpace *as,
     RCU_READ_LOCK_GUARD();
     fv = address_space_to_flatview(as);
     mr = flatview_translate(fv, addr, &xlat, &l, is_write, attrs);
+    memory_region_ref(mr);
 
     if (!memory_access_is_direct(mr, is_write)) {
-        if (qatomic_xchg(&bounce.in_use, true)) {
-            *plen = 0;
-            return NULL;
-        }
-        /* Avoid unbounded allocations */
-        l = MIN(l, TARGET_PAGE_SIZE);
-        bounce.buffer = qemu_memalign(TARGET_PAGE_SIZE, l);
-        bounce.addr = addr;
-        bounce.len = l;
-
-        memory_region_ref(mr);
-        bounce.mr = mr;
+        qatomic_inc_fetch(&bounce_buffers_in_use);
+
+        BounceBuffer *bounce = g_malloc(l + sizeof(BounceBuffer));
+        bounce->addr = addr;
+        bounce->mr = mr;
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
@@ -3114,31 +3105,36 @@ void *address_space_map(AddressSpace *as,
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
+            address_space_write(as, bounce->addr, MEMTXATTRS_UNSPECIFIED,
+                                bounce->buffer, access_len);
         }
-        if (xen_enabled()) {
-            xen_invalidate_map_cache_entry(buffer);
+        memory_region_unref(bounce->mr);
+        g_free(bounce);
+
+        if (qatomic_dec_fetch(&bounce_buffers_in_use) == 1) {
+            cpu_notify_map_clients();
         }
-        memory_region_unref(mr);
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
-- 
2.34.1


