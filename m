Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E40898328A6
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 12:16:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQmph-0007Zd-Uo; Fri, 19 Jan 2024 06:14:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rQmpa-0007Wt-UR
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:14:40 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rQmpW-0007KM-Hl
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:14:37 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a2d348d213dso58605166b.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 03:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705662872; x=1706267672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oTGa3/BzlzS0hEzKw7dcC9l7LHJA830QpWxPRNzttIo=;
 b=mkXTcDxpxk674ZG+U7my/2AHY/zoYAo17rhaf8g+kVxb6BtVG9OHuadKnW0LwS07j4
 BBV+oq6+UwgS9dTGNgeufH66x6qPZghu3UDmBFVzixAgZ8YftfEpIAFQftTuxBQ2fXr6
 PL1lNQzpa3y5MYWlYQDD4hAM6ByhHcboiPvQkN7SZ7uzfGsipzfSR/e3B+wRJffn0J5Z
 HwMf2mM9xniEP4pCgijCNPHAUsyXBsG6kZDuI3lFP+cG6qSiGOMrEYw4oDvDIyfuLMOX
 q1/guRE0aDYCVT6tcudEoStxaWfpcvS7lCnYN7yZfDP7+zH1jCE8sI11qv7VXA4DbY6i
 3XRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705662872; x=1706267672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oTGa3/BzlzS0hEzKw7dcC9l7LHJA830QpWxPRNzttIo=;
 b=XBDlyq75J7RmZBsQeGXjfC4jG8ITQ0kKvxyU3vtrjoOaUFkDhQyZ4zzTz8lDzThOfs
 hiQgp0dOo2cKRVA5pj1gKsg2YsOCZ2fHT6QAkH84a8khNQ8p8hBkkIogp0UUWRUIkqMy
 jtr+z6H4umrSyKwID68Izytwd3Rl9g7rVL8XYiX9lxe5NWxucfMK/7pt/CJ55rsRAN5o
 jqBjjAOu4A7ydwBDdUvoVMBVk70ZFbkjqQ2UBSAyy48sY6izHR47dQoW/8Nf1XTLGEmo
 Jl62ZRcLDbSnAjUu5sMWTFJ+wIT85WPyS0V35rfhZF8IN6oJ+QxPmfZGObBBBAUyxY/s
 Lbrw==
X-Gm-Message-State: AOJu0Yz8ti7qINWji8ZeGEviMmDQO3iqpwRt1mYTzKb7oMTMMDl7o8KM
 QqDxK30Q6Fy6UXo39JyBRtFiG1UpVYAL56zKRtnuGQmOskQPdDnB7gsVtHZbzuKwVbESZjqtwVh
 jgQA=
X-Google-Smtp-Source: AGHT+IFJwYV2eU0mgnOPZgOYc+m+fobqCq6IhPou4Wj3C9UTsKQtOBkQuJyuSQx6lGanV93fM1UMig==
X-Received: by 2002:a17:906:c30d:b0:a2d:feaa:637f with SMTP id
 s13-20020a170906c30d00b00a2dfeaa637fmr1380599ejz.82.1705662872624; 
 Fri, 19 Jan 2024 03:14:32 -0800 (PST)
Received: from localhost.localdomain (adsl-114.109.242.227.tellas.gr.
 [109.242.227.114]) by smtp.gmail.com with ESMTPSA id
 vq9-20020a170907a4c900b00a2ca97242d5sm9283321ejc.120.2024.01.19.03.14.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 03:14:32 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 4/6] hw/xen/xen-mapcache.c: convert DPRINTF to tracepoints
Date: Fri, 19 Jan 2024 13:14:22 +0200
Message-Id: <c5c74aadadd0da76ed2caabb22e1231d60e0bd85.1705662313.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1705662313.git.manos.pitsidianakis@linaro.org>
References: <cover.1705662313.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Tracing DPRINTFs to stderr might not be desired. A developer that relies
on tracepoints should be able to opt-in to each tracepoint and rely on
QEMU's log redirection, instead of stderr by default.

This commit converts DPRINTFs in this file that are used for tracing
into tracepoints.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/xen/trace-events   | 11 +++++++++
 hw/xen/xen-mapcache.c | 54 +++++++++++++++++++------------------------
 2 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/hw/xen/trace-events b/hw/xen/trace-events
index 67a6c41926..1b748dba09 100644
--- a/hw/xen/trace-events
+++ b/hw/xen/trace-events
@@ -60,3 +60,14 @@ cpu_ioreq_config_write(void *req, uint32_t sbdf, uint32_t reg, uint32_t size, ui
 xen_map_cache(uint64_t phys_addr) "want 0x%"PRIx64
 xen_remap_bucket(uint64_t index) "index 0x%"PRIx64
 xen_map_cache_return(void* ptr) "%p"
+xen_map_cache_init(uint64_t nr_buckets, uint64_t size) "nr_buckets = 0x%lx size %lu"
+xen_replace_cache_entry_dummy(uint64_t old_phys_addr, uint64_t new_phys_addr) "Replacing a dummy mapcache entry for 0x%"PRIx64" with 0x%"PRIx64
+xen_invalidate_map_cache_entry_unlocked_not_found(void *p) "could not find %p"
+xen_invalidate_map_cache_entry_unlocked_found(uint64_t addr, void *p) "   0x%"PRIx64" -> %p is present"
+xen_invalidate_map_cache_entry_unlocked_miss(void *buffer) "Trying to unmap address %p that is not in the mapcache"
+xen_replace_cache_entry_unlocked_could_not_update_entry(uint64_t old_phys_addr) "Unable to update a mapcache entry for 0x%"PRIx64
+xen_ram_addr_from_mapcache_not_found(void *p) "could not find %p"
+xen_ram_addr_from_mapcache_found(uint64_t addr, void *p) "   0x%"PRIx64" -> %p is present"
+xen_ram_addr_from_mapcache_not_in_cache(void *p) "Trying to find address %p that is not in the mapcache"
+xen_replace_cache_entry_unlocked(uint64_t old_phys_addr) "Trying to update an entry for 0x%"PRIx64" that is not in the mapcache"
+xen_invalidate_map_cache(uint64_t paddr_index, void *vaddr_req) "Locked DMA mapping while invalidating mapcache 0x%"PRIx64" -> %p is present"
diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index f7d974677d..336c212376 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -22,16 +22,6 @@
 #include "trace.h"
 
 
-//#define MAPCACHE_DEBUG
-
-#ifdef MAPCACHE_DEBUG
-#  define DPRINTF(fmt, ...) do { \
-    fprintf(stderr, "xen_mapcache: " fmt, ## __VA_ARGS__); \
-} while (0)
-#else
-#  define DPRINTF(fmt, ...) do { } while (0)
-#endif
-
 #if HOST_LONG_BITS == 32
 #  define MCACHE_BUCKET_SHIFT 16
 #  define MCACHE_MAX_SIZE     (1UL<<31) /* 2GB Cap */
@@ -145,8 +135,7 @@ void xen_map_cache_init(phys_offset_to_gaddr_t f, void *opaque)
 
     size = mapcache->nr_buckets * sizeof (MapCacheEntry);
     size = (size + XC_PAGE_SIZE - 1) & ~(XC_PAGE_SIZE - 1);
-    DPRINTF("%s, nr_buckets = %lx size %lu\n", __func__,
-            mapcache->nr_buckets, size);
+    trace_xen_map_cache_init(mapcache->nr_buckets, size);
     mapcache->entry = g_malloc0(size);
 }
 
@@ -286,7 +275,9 @@ tryagain:
         test_bits(address_offset >> XC_PAGE_SHIFT,
                   test_bit_size >> XC_PAGE_SHIFT,
                   mapcache->last_entry->valid_mapping)) {
-        trace_xen_map_cache_return(mapcache->last_entry->vaddr_base + address_offset);
+        trace_xen_map_cache_return(
+            mapcache->last_entry->vaddr_base + address_offset
+        );
         return mapcache->last_entry->vaddr_base + address_offset;
     }
 
@@ -368,7 +359,9 @@ tryagain:
         QTAILQ_INSERT_HEAD(&mapcache->locked_entries, reventry, next);
     }
 
-    trace_xen_map_cache_return(mapcache->last_entry->vaddr_base + address_offset);
+    trace_xen_map_cache_return(
+        mapcache->last_entry->vaddr_base + address_offset
+    );
     return mapcache->last_entry->vaddr_base + address_offset;
 }
 
@@ -402,10 +395,10 @@ ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
         }
     }
     if (!found) {
-        fprintf(stderr, "%s, could not find %p\n", __func__, ptr);
+        trace_xen_ram_addr_from_mapcache_not_found(ptr);
         QTAILQ_FOREACH(reventry, &mapcache->locked_entries, next) {
-            DPRINTF("   "HWADDR_FMT_plx" -> %p is present\n", reventry->paddr_index,
-                    reventry->vaddr_req);
+            trace_xen_ram_addr_from_mapcache_found(reventry->paddr_index,
+                                                   reventry->vaddr_req);
         }
         abort();
         return 0;
@@ -416,7 +409,7 @@ ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
         entry = entry->next;
     }
     if (!entry) {
-        DPRINTF("Trying to find address %p that is not in the mapcache!\n", ptr);
+        trace_xen_ram_addr_from_mapcache_not_in_cache(ptr);
         raddr = 0;
     } else {
         raddr = (reventry->paddr_index << MCACHE_BUCKET_SHIFT) +
@@ -443,9 +436,12 @@ static void xen_invalidate_map_cache_entry_unlocked(uint8_t *buffer)
         }
     }
     if (!found) {
-        DPRINTF("%s, could not find %p\n", __func__, buffer);
+        trace_xen_invalidate_map_cache_entry_unlocked_not_found(buffer);
         QTAILQ_FOREACH(reventry, &mapcache->locked_entries, next) {
-            DPRINTF("   "HWADDR_FMT_plx" -> %p is present\n", reventry->paddr_index, reventry->vaddr_req);
+            trace_xen_invalidate_map_cache_entry_unlocked_found(
+                reventry->paddr_index,
+                reventry->vaddr_req
+            );
         }
         return;
     }
@@ -463,7 +459,7 @@ static void xen_invalidate_map_cache_entry_unlocked(uint8_t *buffer)
         entry = entry->next;
     }
     if (!entry) {
-        DPRINTF("Trying to unmap address %p that is not in the mapcache!\n", buffer);
+        trace_xen_invalidate_map_cache_entry_unlocked_miss(buffer);
         return;
     }
     entry->lock--;
@@ -502,9 +498,8 @@ void xen_invalidate_map_cache(void)
         if (!reventry->dma) {
             continue;
         }
-        fprintf(stderr, "Locked DMA mapping while invalidating mapcache!"
-                " "HWADDR_FMT_plx" -> %p is present\n",
-                reventry->paddr_index, reventry->vaddr_req);
+        trace_xen_invalidate_map_cache(reventry->paddr_index,
+                                       reventry->vaddr_req);
     }
 
     for (i = 0; i < mapcache->nr_buckets; i++) {
@@ -562,24 +557,23 @@ static uint8_t *xen_replace_cache_entry_unlocked(hwaddr old_phys_addr,
         entry = entry->next;
     }
     if (!entry) {
-        DPRINTF("Trying to update an entry for "HWADDR_FMT_plx \
-                "that is not in the mapcache!\n", old_phys_addr);
+        trace_xen_replace_cache_entry_unlocked(old_phys_addr);
         return NULL;
     }
 
     address_index  = new_phys_addr >> MCACHE_BUCKET_SHIFT;
     address_offset = new_phys_addr & (MCACHE_BUCKET_SIZE - 1);
 
-    fprintf(stderr, "Replacing a dummy mapcache entry for "HWADDR_FMT_plx \
-            " with "HWADDR_FMT_plx"\n", old_phys_addr, new_phys_addr);
+    trace_xen_replace_cache_entry_dummy(old_phys_addr, new_phys_addr);
 
     xen_remap_bucket(entry, entry->vaddr_base,
                      cache_size, address_index, false);
     if (!test_bits(address_offset >> XC_PAGE_SHIFT,
                 test_bit_size >> XC_PAGE_SHIFT,
                 entry->valid_mapping)) {
-        DPRINTF("Unable to update a mapcache entry for "HWADDR_FMT_plx"!\n",
-                old_phys_addr);
+        trace_xen_replace_cache_entry_unlocked_could_not_update_entry(
+            old_phys_addr
+        );
         return NULL;
     }
 
-- 
γαῖα πυρί μιχθήτω


