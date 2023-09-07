Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9A07972B4
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:12:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEgT-00033S-9E; Thu, 07 Sep 2023 09:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qeEgQ-00032h-Dz
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:04:30 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qeEgN-00083J-Db
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:04:30 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-53fbf2c42bfso787131a12.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694091866; x=1694696666;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=47aPbA5pxaDOWep6DbmY6koMczW36VjR0/UwUNqiflo=;
 b=mIsDudvvnBdd/fWsI3In/QxXjXtF6vAcC+0HXi5dOoIxNAicIJKuG2tPSF7wcQ4kSW
 iY/dGK28HQWZkYl/orYciXBuPiZRM6EJAXrd/tkvJpxFeqSC40M13AtDYqaSHPONec7L
 NQ7Fb5DBspqsO9pzAooYbEsfbpomgwRFYjARmpgrimyyFgQU27MfxEehRiXz2dg7o8Ca
 77rhiGFAnPZLLUM1XaNLZO+1erSofDevQGj+qyU+WjYzN30Aki8h2nmeXjQ9Zu4pqT2D
 jtLjA0Wknczk2LzAnrwI1GZ0c5axhM22+aDCH2Ykh6RjBizipQycbobKZlpqbxpW1SoG
 0tDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091866; x=1694696666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=47aPbA5pxaDOWep6DbmY6koMczW36VjR0/UwUNqiflo=;
 b=dSNIkhgRI9FWWp7Q3+ztiH/QeucPER851Cg6bGQscilIv/rulkGFbjN66OyMrw7AP7
 Q2YpJQ6Eb9+KrZcA97MFoNypz/DMKXZd49It7mm29OxAnkooXx9GmWIgDtj6xDbyRXu6
 Y2pTCORbwzjZInJeaCI9ZFGwekymfbOfGugbJqy4bkQnPwiTUS0C9p4tgZkWQDZezdQo
 uQCzlBo5W4CmKPaKnKWSgwZQ+myUDPR8kaHi/Mw4p4dHVHj0fYaZEDSKZi4lOUkUJTDf
 dhNZBxm3hyr0kHZqNjrrUaUZpTU6xKG+5qaxMEpuDc8EMHCZehEGjM5OvRvi+PmOkwYx
 Jz/g==
X-Gm-Message-State: AOJu0Yw1tHOqopWDrPNo1mtlCbxahI06EPDbvub3P9zC+ejOOYjN6z4g
 qu5BGcWoh4K11C3bHQgV9EkCgto9pc3WfUqKjB+3Vw==
X-Google-Smtp-Source: AGHT+IH899vsTVJzsaiHAuEy+C18gDxE8Jmlx5eKR9dnzbPbVp8UmCID1tnWI3rqWDZJKYHmG+XW2Q==
X-Received: by 2002:a17:90a:8d14:b0:268:b64b:f684 with SMTP id
 c20-20020a17090a8d1400b00268b64bf684mr18034190pjo.33.1694091865935; 
 Thu, 07 Sep 2023 06:04:25 -0700 (PDT)
Received: from mnissler.ba.rivosinc.com ([66.220.2.162])
 by smtp.gmail.com with ESMTPSA id
 g24-20020a170902fe1800b001b0358848b0sm12821913plj.161.2023.09.07.06.04.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:04:25 -0700 (PDT)
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
Subject: [PATCH v3 4/5] vfio-user: Message-based DMA support
Date: Thu,  7 Sep 2023 06:04:09 -0700
Message-Id: <20230907130410.498935-5-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907130410.498935-1-mnissler@rivosinc.com>
References: <20230907130410.498935-1-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=mnissler@rivosinc.com; helo=mail-pg1-x52b.google.com
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


