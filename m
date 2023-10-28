Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFE27DA6F0
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 14:25:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwiMs-0006SA-Ss; Sat, 28 Oct 2023 08:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qwiMq-0006Pt-Bb; Sat, 28 Oct 2023 08:24:40 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qwiMo-0006mm-G8; Sat, 28 Oct 2023 08:24:40 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9c603e2354fso601583366b.1; 
 Sat, 28 Oct 2023 05:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698495876; x=1699100676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/GoSWYHVdJxtZMHJ3DaJORKAAQ1OsmJR2yJLwNoj76I=;
 b=Os35jh3vSGYS+W3icYzpWjuC54e2nb/8PddHFPhst+Nwk4JJsFyEYESmGu3MXh2IHG
 /YLKAy3g0tigPeUZNrxouKqOmwwNhBnCQ77XrSmt630gmhBGZNlEqD3FWc9a7VKzMXVR
 glM49MD4Wu6LdB5QH7JPwQNI0ZwzLMIP74wKwLh4OBcsCBeRHtDGLHTwKSGQZdDfwjTi
 UsQ7ifrWCDWYj1TZbxGRqKRDi/t1tqrVr4xpdp4+6Pa6TJXrrw2unMkYcvlfQzu+oDeY
 yjQYmGrM42x/qFaptdsSkZ+B04NEb86um0IjBfkRO1iOAVxxlfrg2V8l4AgFS5S2hlKW
 tEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698495876; x=1699100676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/GoSWYHVdJxtZMHJ3DaJORKAAQ1OsmJR2yJLwNoj76I=;
 b=gql46KPm8Ut+HdzmqMqLYNLQVfeXV/GP7MZb8WfsyFjmXXA3XpX801EMfQgdAHA5wg
 UZ9/pCIDsCVj8gb8e7IrUzrWycNDm8pZFjonwCRB7LQyQhMlCCVC3YqUqQ5I8FXVGs2j
 ZpLm+2bhwttY56fb3gG7Hb5OStEkvw1OqqaC58oHmJGqEl9JgIcAu1Xlo946xLASm9Au
 GkGIJPBUbV5LOZvGA6JVb2jV5hOYb5cjpXFoqAsg3oBLSAi4fA1kIMvzQZAkLDsN8mkc
 oyCSBl5sif37dxcSz90hUe4x0V/n0JxDlYiFttewfT8Es/dm4vHuuAvcCDuK/7aEDIZv
 0iow==
X-Gm-Message-State: AOJu0YwFbQny0miT72dG2aVnK0kV4kbuzwYlDKhxpW3/mUhbg4KYlVbU
 LlyIrXXyp6KsJLnlB7urw6r+sheWdF0=
X-Google-Smtp-Source: AGHT+IFpJnCcmIPAyCQS5J2XnD3aUcaurKWq0yz3/LzmMZfo46oKmGit8kNjPYmVG55aNlOz3MjOAA==
X-Received: by 2002:a17:907:94d1:b0:9ae:699d:8a31 with SMTP id
 dn17-20020a17090794d100b009ae699d8a31mr4595836ejc.33.1698495875718; 
 Sat, 28 Oct 2023 05:24:35 -0700 (PDT)
Received: from archlinux.. (dynamic-089-012-044-170.89.12.pool.telefonica.de.
 [89.12.44.170]) by smtp.gmail.com with ESMTPSA id
 a13-20020a170906190d00b009ae3d711fd9sm2706687eje.69.2023.10.28.05.24.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 05:24:35 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 6/6] system/memory: Trace names of MemoryRegions rather than
 host pointers
Date: Sat, 28 Oct 2023 14:24:15 +0200
Message-ID: <20231028122415.14869-7-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231028122415.14869-1-shentey@gmail.com>
References: <20231028122415.14869-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Tracing the host pointer of the accessed MemoryRegion seems to be a debug
feature for developing QEMU itself. When analyzing guest behavior by comparing
traces, these pointers generate a lot of noise since the pointers differ between
QEMU invocations, making this task harder than it needs to be. Moreover, the
pointers seem to be redundant to the names already assigned to MemoryRegions.

Remove the pointers from the traces and trace the names where missing. When
developing QEMU, developers could just add the host pointer tracing for
themselves.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 docs/devel/tracing.rst |  4 ++--
 system/memory.c        | 26 ++++++++++++++++----------
 system/trace-events    | 12 ++++++------
 3 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/docs/devel/tracing.rst b/docs/devel/tracing.rst
index d288480db1..8c31d5f76e 100644
--- a/docs/devel/tracing.rst
+++ b/docs/devel/tracing.rst
@@ -18,8 +18,8 @@ events::
 
     $ qemu --trace "memory_region_ops_*" ...
     ...
-    719585@1608130130.441188:memory_region_ops_read cpu 0 mr 0x562fdfbb3820 addr 0x3cc value 0x67 size 1
-    719585@1608130130.441190:memory_region_ops_write cpu 0 mr 0x562fdfbd2f00 addr 0x3d4 value 0x70e size 2
+    719585@1608130130.441188:memory_region_ops_read cpu 0 addr 0x3cc value 0x67 size 1
+    719585@1608130130.441190:memory_region_ops_write cpu 0 addr 0x3d4 value 0x70e size 2
 
 This output comes from the "log" trace backend that is enabled by default when
 ``./configure --enable-trace-backends=BACKENDS`` was not explicitly specified.
diff --git a/system/memory.c b/system/memory.c
index 4928f2525d..076a992b74 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -444,10 +444,11 @@ static MemTxResult  memory_region_read_accessor(MemoryRegion *mr,
 
     tmp = mr->ops->read(mr->opaque, addr, size);
     if (mr->subpage) {
-        trace_memory_region_subpage_read(get_cpu_index(), mr, addr, tmp, size);
+        trace_memory_region_subpage_read(get_cpu_index(), addr, tmp, size,
+                                         memory_region_name(mr));
     } else if (trace_event_get_state_backends(TRACE_MEMORY_REGION_OPS_READ)) {
         hwaddr abs_addr = memory_region_to_absolute_addr(mr, addr);
-        trace_memory_region_ops_read(get_cpu_index(), mr, abs_addr, tmp, size,
+        trace_memory_region_ops_read(get_cpu_index(), abs_addr, tmp, size,
                                      memory_region_name(mr));
     }
     memory_region_shift_read_access(value, shift, mask, tmp);
@@ -467,10 +468,11 @@ static MemTxResult memory_region_read_with_attrs_accessor(MemoryRegion *mr,
 
     r = mr->ops->read_with_attrs(mr->opaque, addr, &tmp, size, attrs);
     if (mr->subpage) {
-        trace_memory_region_subpage_read(get_cpu_index(), mr, addr, tmp, size);
+        trace_memory_region_subpage_read(get_cpu_index(), addr, tmp, size,
+                                         memory_region_name(mr));
     } else if (trace_event_get_state_backends(TRACE_MEMORY_REGION_OPS_READ)) {
         hwaddr abs_addr = memory_region_to_absolute_addr(mr, addr);
-        trace_memory_region_ops_read(get_cpu_index(), mr, abs_addr, tmp, size,
+        trace_memory_region_ops_read(get_cpu_index(), abs_addr, tmp, size,
                                      memory_region_name(mr));
     }
     memory_region_shift_read_access(value, shift, mask, tmp);
@@ -488,10 +490,11 @@ static MemTxResult memory_region_write_accessor(MemoryRegion *mr,
     uint64_t tmp = memory_region_shift_write_access(value, shift, mask);
 
     if (mr->subpage) {
-        trace_memory_region_subpage_write(get_cpu_index(), mr, addr, tmp, size);
+        trace_memory_region_subpage_write(get_cpu_index(), addr, tmp, size,
+                                          memory_region_name(mr));
     } else if (trace_event_get_state_backends(TRACE_MEMORY_REGION_OPS_WRITE)) {
         hwaddr abs_addr = memory_region_to_absolute_addr(mr, addr);
-        trace_memory_region_ops_write(get_cpu_index(), mr, abs_addr, tmp, size,
+        trace_memory_region_ops_write(get_cpu_index(), abs_addr, tmp, size,
                                       memory_region_name(mr));
     }
     mr->ops->write(mr->opaque, addr, tmp, size);
@@ -509,10 +512,11 @@ static MemTxResult memory_region_write_with_attrs_accessor(MemoryRegion *mr,
     uint64_t tmp = memory_region_shift_write_access(value, shift, mask);
 
     if (mr->subpage) {
-        trace_memory_region_subpage_write(get_cpu_index(), mr, addr, tmp, size);
+        trace_memory_region_subpage_write(get_cpu_index(), addr, tmp, size,
+                                          memory_region_name(mr));
     } else if (trace_event_get_state_backends(TRACE_MEMORY_REGION_OPS_WRITE)) {
         hwaddr abs_addr = memory_region_to_absolute_addr(mr, addr);
-        trace_memory_region_ops_write(get_cpu_index(), mr, abs_addr, tmp, size,
+        trace_memory_region_ops_write(get_cpu_index(), abs_addr, tmp, size,
                                       memory_region_name(mr));
     }
     return mr->ops->write_with_attrs(mr->opaque, addr, tmp, size, attrs);
@@ -1356,7 +1360,8 @@ static uint64_t memory_region_ram_device_read(void *opaque,
         break;
     }
 
-    trace_memory_region_ram_device_read(get_cpu_index(), mr, addr, data, size);
+    trace_memory_region_ram_device_read(get_cpu_index(), addr, data, size,
+                                        memory_region_name(mr));
 
     return data;
 }
@@ -1366,7 +1371,8 @@ static void memory_region_ram_device_write(void *opaque, hwaddr addr,
 {
     MemoryRegion *mr = opaque;
 
-    trace_memory_region_ram_device_write(get_cpu_index(), mr, addr, data, size);
+    trace_memory_region_ram_device_write(get_cpu_index(), addr, data, size,
+                                         memory_region_name(mr));
 
     switch (size) {
     case 1:
diff --git a/system/trace-events b/system/trace-events
index 69c9044151..21f1c005e0 100644
--- a/system/trace-events
+++ b/system/trace-events
@@ -9,12 +9,12 @@ cpu_in(unsigned int addr, char size, unsigned int val) "addr 0x%x(%c) value %u"
 cpu_out(unsigned int addr, char size, unsigned int val) "addr 0x%x(%c) value %u"
 
 # memory.c
-memory_region_ops_read(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size, const char *name) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u name '%s'"
-memory_region_ops_write(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size, const char *name) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u name '%s'"
-memory_region_subpage_read(int cpu_index, void *mr, uint64_t offset, uint64_t value, unsigned size) "cpu %d mr %p offset 0x%"PRIx64" value 0x%"PRIx64" size %u"
-memory_region_subpage_write(int cpu_index, void *mr, uint64_t offset, uint64_t value, unsigned size) "cpu %d mr %p offset 0x%"PRIx64" value 0x%"PRIx64" size %u"
-memory_region_ram_device_read(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
-memory_region_ram_device_write(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
+memory_region_ops_read(int cpu_index, uint64_t addr, uint64_t value, unsigned size, const char *name) "cpu %d addr 0x%"PRIx64" value 0x%"PRIx64" size %u name '%s'"
+memory_region_ops_write(int cpu_index, uint64_t addr, uint64_t value, unsigned size, const char *name) "cpu %d addr 0x%"PRIx64" value 0x%"PRIx64" size %u name '%s'"
+memory_region_subpage_read(int cpu_index, uint64_t offset, uint64_t value, unsigned size, const char *name) "cpu %d offset 0x%"PRIx64" value 0x%"PRIx64" size %u name '%s'"
+memory_region_subpage_write(int cpu_index, uint64_t offset, uint64_t value, unsigned size, const char *name) "cpu %d offset 0x%"PRIx64" value 0x%"PRIx64" size %u name '%s'"
+memory_region_ram_device_read(int cpu_index, uint64_t addr, uint64_t value, unsigned size, const char *name) "cpu %d addr 0x%"PRIx64" value 0x%"PRIx64" size %u name '%s'"
+memory_region_ram_device_write(int cpu_index, uint64_t addr, uint64_t value, unsigned size, const char *name) "cpu %d addr 0x%"PRIx64" value 0x%"PRIx64" size %u name '%s'"
 memory_region_sync_dirty(const char *mr, const char *listener, int global) "mr '%s' listener '%s' synced (global=%d)"
 flatview_new(void *view, void *root) "%p (root %p)"
 flatview_destroy(void *view, void *root) "%p (root %p)"
-- 
2.42.0


