Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 962BB7EB4F4
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 17:33:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2wLO-000486-Pf; Tue, 14 Nov 2023 11:32:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2wKy-0003KW-5i
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 11:32:32 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2wKt-0006eG-Uf
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 11:32:25 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9e62f903e88so645816366b.2
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 08:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699979542; x=1700584342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=htjkOQmTZcMenhXqLaaInIEhXImv4mUPxpJWcjUwWD8=;
 b=qXUpAG5U7kUwBh7IMiLEJsYIq5hU3iSNPyp6nnd/GvrOCa+JwebR/jRbvB+C1i6COH
 lhngntDiU+SVMBI5qXxB6MQ9fnGFtPyrZTd1Vv9bN29WF/PYYaFU+H2S30vjNaahQAqZ
 tXdLcXV3bluM5jc9mYWibcXKEq401pZGfXhhUzX4TJb4Gj5XqorNsc520tXs8oiePSW6
 k/YzjHfvd+0zfIEMCkSqrCfribLuBNnTswYAQeV8Yg1YfQ7VXo1elCmNRUf9TkCFHYz5
 fgXmSz71MbLORvFAosRuFr2GuaEhCf7KknGxnkRn52snJmHsiT5K3t0dfWqq0m9jFhge
 vAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699979542; x=1700584342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=htjkOQmTZcMenhXqLaaInIEhXImv4mUPxpJWcjUwWD8=;
 b=vQXgQ/52JAtVpAbitspi7qvrOM+ipuqiSYhcqHKdA8SJxnHxCFFuSMOlmqKBCyMfGS
 i0oedCBHVB8bMIaYpETJB8jxtRzhyN3inQHhWzwfP0sssqFGzF48FEF71GC/Cdbeudtj
 KpuS0FUS3O/4YToyF7rhYCDejJpuZxdRrJYbNgAvyT3tHBBEKOqHaq/14yrvxunE8dp4
 1b9xDcyzD1ET2dqPJypfJszaJdAGZfeGr7tpBieztfyKHLWC+klUwHe9/YFhOLFXWXAH
 W1y9clZlA75dSqu5QOcaFTWQTpr66ELH0Jr3vWdnVSxQYYwYU/6PSLD2MGzQYBIiBdRE
 xK6Q==
X-Gm-Message-State: AOJu0YwRQvKdvA80DlKfVBzTGT2tMvUj3Waq+BWkXJTK1mQ9Kx56P2LB
 Hz/gAengCku+o8zcSxblfteKy9m/iYG3rlgnWRY=
X-Google-Smtp-Source: AGHT+IEJmFgqouqetrQ1cGRifpy+1FzLH8THhoRj/4LtsoCnWeS7Y04NxjXy02qkfonieH2Xog4T5Q==
X-Received: by 2002:a17:906:7943:b0:9d3:e48f:30d3 with SMTP id
 l3-20020a170906794300b009d3e48f30d3mr9901673ejo.31.1699979542369; 
 Tue, 14 Nov 2023 08:32:22 -0800 (PST)
Received: from m1x-phil.lan (cac94-h02-176-184-25-155.dsl.sta.abo.bbox.fr.
 [176.184.25.155]) by smtp.gmail.com with ESMTPSA id
 c26-20020a17090603da00b009adce1c97ccsm5731084eja.53.2023.11.14.08.32.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Nov 2023 08:32:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 David Woodhouse <dwmw@amazon.co.uk>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 9/9] hw/xen/hvm: Inline xen_arch_set_memory()
Date: Tue, 14 Nov 2023 17:31:23 +0100
Message-ID: <20231114163123.74888-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114163123.74888-1-philmd@linaro.org>
References: <20231114163123.74888-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

xen_arch_set_memory() is not arch-specific anymore. Being
called once, inline it in xen_set_memory().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/xen/xen-hvm-common.h |   3 -
 hw/xen/xen-hvm-common.c         | 104 ++++++++++++++++----------------
 2 files changed, 51 insertions(+), 56 deletions(-)

diff --git a/include/hw/xen/xen-hvm-common.h b/include/hw/xen/xen-hvm-common.h
index 536712dc83..a1b8a2783b 100644
--- a/include/hw/xen/xen-hvm-common.h
+++ b/include/hw/xen/xen-hvm-common.h
@@ -99,8 +99,5 @@ void cpu_ioreq_pio(ioreq_t *req);
 
 void xen_read_physmap(XenIOState *state);
 void xen_arch_handle_ioreq(XenIOState *state, ioreq_t *req);
-void xen_arch_set_memory(XenIOState *state,
-                         MemoryRegionSection *section,
-                         bool add);
 
 #endif /* HW_XEN_HVM_COMMON_H */
diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index 50ce45effc..789c6b4b7a 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -426,50 +426,6 @@ void qmp_xen_set_global_dirty_log(bool enable, Error **errp)
     }
 }
 
-void xen_arch_set_memory(XenIOState *state, MemoryRegionSection *section,
-                         bool add)
-{
-    unsigned target_page_bits = qemu_target_page_bits();
-    int page_size = qemu_target_page_size();
-    int page_mask = -page_size;
-    hwaddr start_addr = section->offset_within_address_space;
-    ram_addr_t size = int128_get64(section->size);
-    bool log_dirty = memory_region_is_logging(section->mr, DIRTY_MEMORY_VGA);
-    hvmmem_type_t mem_type;
-
-    if (!memory_region_is_ram(section->mr)) {
-        return;
-    }
-
-    if (log_dirty != add) {
-        return;
-    }
-
-    trace_xen_client_set_memory(start_addr, size, log_dirty);
-
-    start_addr &= page_mask;
-    size = ROUND_UP(size, page_size);
-
-    if (add) {
-        if (!memory_region_is_rom(section->mr)) {
-            xen_add_to_physmap(state, start_addr, size,
-                               section->mr, section->offset_within_region);
-        } else {
-            mem_type = HVMMEM_ram_ro;
-            if (xen_set_mem_type(xen_domid, mem_type,
-                                 start_addr >> target_page_bits,
-                                 size >> target_page_bits)) {
-                DPRINTF("xen_set_mem_type error, addr: "HWADDR_FMT_plx"\n",
-                        start_addr);
-            }
-        }
-    } else {
-        if (xen_remove_from_physmap(state, start_addr, size) < 0) {
-            DPRINTF("physmapping does not exist at "HWADDR_FMT_plx"\n", start_addr);
-        }
-    }
-}
-
 void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size, MemoryRegion *mr,
                    Error **errp)
 {
@@ -512,20 +468,62 @@ static void xen_set_memory(struct MemoryListener *listener,
                            bool add)
 {
     XenIOState *state = container_of(listener, XenIOState, memory_listener);
+    unsigned target_page_bits = qemu_target_page_bits();
+    int page_size = qemu_target_page_size();
+    int page_mask = -page_size;
+    hwaddr start_addr;
+    ram_addr_t size;
+    bool log_dirty;
+    hvmmem_type_t mem_type;
+
 
     if (section->mr == &xen_memory) {
         return;
-    } else {
-        if (add) {
-            xen_map_memory_section(xen_domid, state->ioservid,
-                                   section);
-        } else {
-            xen_unmap_memory_section(xen_domid, state->ioservid,
-                                     section);
-        }
     }
 
-    xen_arch_set_memory(state, section, add);
+    if (add) {
+        xen_map_memory_section(xen_domid, state->ioservid,
+                               section);
+    } else {
+        xen_unmap_memory_section(xen_domid, state->ioservid,
+                                 section);
+    }
+
+    if (!memory_region_is_ram(section->mr)) {
+        return;
+    }
+
+    log_dirty = memory_region_is_logging(section->mr, DIRTY_MEMORY_VGA);
+
+    if (log_dirty != add) {
+        return;
+    }
+
+    start_addr = section->offset_within_address_space;
+    size = int128_get64(section->size);
+    trace_xen_client_set_memory(start_addr, size, log_dirty);
+
+    start_addr &= page_mask;
+    size = ROUND_UP(size, page_size);
+
+    if (add) {
+        if (!memory_region_is_rom(section->mr)) {
+            xen_add_to_physmap(state, start_addr, size,
+                               section->mr, section->offset_within_region);
+        } else {
+            mem_type = HVMMEM_ram_ro;
+            if (xen_set_mem_type(xen_domid, mem_type,
+                                 start_addr >> target_page_bits,
+                                 size >> target_page_bits)) {
+                DPRINTF("xen_set_mem_type error, addr: "HWADDR_FMT_plx"\n",
+                        start_addr);
+            }
+        }
+    } else {
+        if (xen_remove_from_physmap(state, start_addr, size) < 0) {
+            DPRINTF("physmapping does not exist at "HWADDR_FMT_plx"\n", start_addr);
+        }
+    }
 }
 
 void xen_region_add(MemoryListener *listener,
-- 
2.41.0


