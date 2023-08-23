Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F63785408
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 11:30:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYkBC-0005HI-Cj; Wed, 23 Aug 2023 05:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qYkBA-00058h-1c
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 05:29:32 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qYkB8-0006YY-0r
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 05:29:31 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-68a4bcf8a97so2374505b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 02:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1692782968; x=1693387768; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=47aPbA5pxaDOWep6DbmY6koMczW36VjR0/UwUNqiflo=;
 b=mdWNy2jTcOX5alL0ykaqYEWJOwdSAsENGbfJQIqxUrBCd8EtKc7Est4G95ZQPmhwsl
 Xj+Ygf87BEGWITfAvo4W35EkUpYw51YZYjJKaMf11C8hRNoRGDEz/tGrOvWDxEvO2e7p
 FwjFrRjUBjfH0SeGPMpOnKHnVqSgs6Pa5tGRczGzDglTnYRgDQ3QWL2ENKpIxLrmqz7k
 WBRheiTicuUu9cxoIznoXysdDVSriEJ18St/VvEHYnsTFJGJzY+gWzJkVGd1Vxi6mcoD
 i7qJnZwMJ9b/xOTVoqI6nYih8lHToHr9Of8kZUiH3439Pbd0xx5FM0Wz3IOBVCcz+gx3
 QckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692782968; x=1693387768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=47aPbA5pxaDOWep6DbmY6koMczW36VjR0/UwUNqiflo=;
 b=kjH0VUwibAlx+oIKVi9E3bXZe7DTTr1tW5ZD2xYdrco/8al31owEXQXFMohe+pDKnF
 1YDAsx5XoWEoAywYG7tVLIpSOC+negj0atx4Z6//5UxxyiEO8E/hvuzLrJHaWugfFzCo
 6slss1BHssy83KA1n71srrs1NZiCtCeFVJhaxZeSZ1NmlohHk+rv7k9BhfWIeaIXM+mD
 2qOaWGRMLpm3N056UALoYmylJ2bM6DLmhwizVegEXlnoGCIO/TjQo4ZPWuR3gmAOkXxf
 ib6pvhH6bthUe60bxNVGQICyaDd+oHAkNsXD22sl8/O7iaGGDqQ5RF0iRR36Me0R+giO
 OBkA==
X-Gm-Message-State: AOJu0Yw/jfP92KHYBXrfuzF1QdsiwBGkAbeYEsSICYcmeQ7yWJOGXgNa
 r7vxClqw8xpazAnEecY15wETmeM8mSV5qBSgpOC5Qg==
X-Google-Smtp-Source: AGHT+IEViNGNzLCDjOar7eMbE8FJhayoHKWUOkHnvKaDw8zHjET/gREidt/l3oSNcoreZRwDQBOLhA==
X-Received: by 2002:a05:6a00:1a13:b0:68a:49bc:9be3 with SMTP id
 g19-20020a056a001a1300b0068a49bc9be3mr8784372pfv.29.1692782968461; 
 Wed, 23 Aug 2023 02:29:28 -0700 (PDT)
Received: from mnissler.ba.rivosinc.com ([66.220.2.162])
 by smtp.gmail.com with ESMTPSA id
 c10-20020aa78c0a000000b006875df4773fsm1169462pfd.163.2023.08.23.02.29.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 02:29:28 -0700 (PDT)
From: Mattias Nissler <mnissler@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: john.levon@nutanix.com, stefanha@redhat.com,
 Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH v2 3/4] vfio-user: Message-based DMA support
Date: Wed, 23 Aug 2023 02:29:04 -0700
Message-Id: <20230823092905.2259418-4-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823092905.2259418-1-mnissler@rivosinc.com>
References: <20230823092905.2259418-1-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=mnissler@rivosinc.com; helo=mail-pf1-x436.google.com
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

Wire up support for DMA for the case where the vfio-user client does not
provide mmap()-able file descriptors, but DMA requests must be performed
via the VFIO-user protocol. This installs an indirect memory region,
which already works for pci_dma_{read,write}, and pci_dma_map works
thanks to the existing DMA bounce buffering support.

Note that while simple scenarios work with this patch, there's a known
race condition in libvfio-user that will mess up the communication
channel. See https://github.com/nutanix/libvfio-user/issues/279 for
details as well as a proposed fix.

Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
---
 hw/remote/trace-events    |  2 +
 hw/remote/vfio-user-obj.c | 84 +++++++++++++++++++++++++++++++++++----
 2 files changed, 79 insertions(+), 7 deletions(-)

diff --git a/hw/remote/trace-events b/hw/remote/trace-events
index 0d1b7d56a5..358a68fb34 100644
--- a/hw/remote/trace-events
+++ b/hw/remote/trace-events
@@ -9,6 +9,8 @@ vfu_cfg_read(uint32_t offset, uint32_t val) "vfu: cfg: 0x%x -> 0x%x"
 vfu_cfg_write(uint32_t offset, uint32_t val) "vfu: cfg: 0x%x <- 0x%x"
 vfu_dma_register(uint64_t gpa, size_t len) "vfu: registering GPA 0x%"PRIx64", %zu bytes"
 vfu_dma_unregister(uint64_t gpa) "vfu: unregistering GPA 0x%"PRIx64""
+vfu_dma_read(uint64_t gpa, size_t len) "vfu: DMA read 0x%"PRIx64", %zu bytes"
+vfu_dma_write(uint64_t gpa, size_t len) "vfu: DMA write 0x%"PRIx64", %zu bytes"
 vfu_bar_register(int i, uint64_t addr, uint64_t size) "vfu: BAR %d: addr 0x%"PRIx64" size 0x%"PRIx64""
 vfu_bar_rw_enter(const char *op, uint64_t addr) "vfu: %s request for BAR address 0x%"PRIx64""
 vfu_bar_rw_exit(const char *op, uint64_t addr) "vfu: Finished %s of BAR address 0x%"PRIx64""
diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
index 8b10c32a3c..cee5e615a9 100644
--- a/hw/remote/vfio-user-obj.c
+++ b/hw/remote/vfio-user-obj.c
@@ -300,6 +300,63 @@ static ssize_t vfu_object_cfg_access(vfu_ctx_t *vfu_ctx, char * const buf,
     return count;
 }
 
+static MemTxResult vfu_dma_read(void *opaque, hwaddr addr, uint64_t *val,
+                                unsigned size, MemTxAttrs attrs)
+{
+    MemoryRegion *region = opaque;
+    VfuObject *o = VFU_OBJECT(region->owner);
+    uint8_t buf[sizeof(uint64_t)];
+
+    trace_vfu_dma_read(region->addr + addr, size);
+
+    dma_sg_t *sg = alloca(dma_sg_size());
+    vfu_dma_addr_t vfu_addr = (vfu_dma_addr_t)(region->addr + addr);
+    if (vfu_addr_to_sgl(o->vfu_ctx, vfu_addr, size, sg, 1, PROT_READ) < 0 ||
+        vfu_sgl_read(o->vfu_ctx, sg, 1, buf) != 0) {
+        return MEMTX_ERROR;
+    }
+
+    *val = ldn_he_p(buf, size);
+
+    return MEMTX_OK;
+}
+
+static MemTxResult vfu_dma_write(void *opaque, hwaddr addr, uint64_t val,
+                                 unsigned size, MemTxAttrs attrs)
+{
+    MemoryRegion *region = opaque;
+    VfuObject *o = VFU_OBJECT(region->owner);
+    uint8_t buf[sizeof(uint64_t)];
+
+    trace_vfu_dma_write(region->addr + addr, size);
+
+    stn_he_p(buf, size, val);
+
+    dma_sg_t *sg = alloca(dma_sg_size());
+    vfu_dma_addr_t vfu_addr = (vfu_dma_addr_t)(region->addr + addr);
+    if (vfu_addr_to_sgl(o->vfu_ctx, vfu_addr, size, sg, 1, PROT_WRITE) < 0 ||
+        vfu_sgl_write(o->vfu_ctx, sg, 1, buf) != 0)  {
+        return MEMTX_ERROR;
+    }
+
+    return MEMTX_OK;
+}
+
+static const MemoryRegionOps vfu_dma_ops = {
+    .read_with_attrs = vfu_dma_read,
+    .write_with_attrs = vfu_dma_write,
+    .endianness = DEVICE_HOST_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+        .unaligned = true,
+    },
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+    },
+};
+
 static void dma_register(vfu_ctx_t *vfu_ctx, vfu_dma_info_t *info)
 {
     VfuObject *o = vfu_get_private(vfu_ctx);
@@ -308,17 +365,30 @@ static void dma_register(vfu_ctx_t *vfu_ctx, vfu_dma_info_t *info)
     g_autofree char *name = NULL;
     struct iovec *iov = &info->iova;
 
-    if (!info->vaddr) {
-        return;
-    }
-
     name = g_strdup_printf("mem-%s-%"PRIx64"", o->device,
-                           (uint64_t)info->vaddr);
+                           (uint64_t)iov->iov_base);
 
     subregion = g_new0(MemoryRegion, 1);
 
-    memory_region_init_ram_ptr(subregion, NULL, name,
-                               iov->iov_len, info->vaddr);
+    if (info->vaddr) {
+        memory_region_init_ram_ptr(subregion, OBJECT(o), name,
+                                   iov->iov_len, info->vaddr);
+    } else {
+        /*
+         * Note that I/O regions' MemoryRegionOps handle accesses of at most 8
+         * bytes at a time, and larger accesses are broken down. However,
+         * many/most DMA accesses are larger than 8 bytes and VFIO-user can
+         * handle large DMA accesses just fine, thus this size restriction
+         * unnecessarily hurts performance, in particular given that each
+         * access causes a round trip on the VFIO-user socket.
+         *
+         * TODO: Investigate how to plumb larger accesses through memory
+         * regions, possibly by amending MemoryRegionOps or by creating a new
+         * memory region type.
+         */
+        memory_region_init_io(subregion, OBJECT(o), &vfu_dma_ops, subregion,
+                              name, iov->iov_len);
+    }
 
     dma_as = pci_device_iommu_address_space(o->pci_dev);
 
-- 
2.34.1


