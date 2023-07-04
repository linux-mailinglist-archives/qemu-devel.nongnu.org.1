Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B4A746B88
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 10:08:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGb3m-0006mT-8O; Tue, 04 Jul 2023 04:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qGb3k-0006lw-Db
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:06:52 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qGb3h-0000vm-TZ
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:06:52 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-66869feb7d1so2695492b3a.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 01:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688458008; x=1691050008; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HFNNCtPqWtjxwt+qHGQAYUqPKlbWW72Qgk4NOXVFZYs=;
 b=eTaoSz2JvUQBoObqpxPhXdllw0/5dtohOVJgEYDXlmPmVinyMJJ6FCRDHaPJwiBWom
 y+ERZPfp4ATyBLKp7kG8BJyrZ3n4HKPWj/GfZcWG0XnLWoVm7xMKOP4nSX23fbLjsfQE
 J6+cQkqDWdHdqdAy1sCqDrsRVln/6m5FhaN6mlUpzfgY5q3olxs4vL0yL1Yhw0+gYpyk
 kOoUe2VVKagDNMJ0gTlA3szD8tE62mPfwsHR5ZYs5gjwodGFvqsDcwemYlgySMlwnr7H
 o+1H7psjPle4d4fZ/ur70nZCFGM6AaNbZ+JtfymairvpDx7vl+tb5AmBfzJe4I1Yg1LI
 DcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688458008; x=1691050008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HFNNCtPqWtjxwt+qHGQAYUqPKlbWW72Qgk4NOXVFZYs=;
 b=iAUHhUpCWgSZAclyNxJQahgg0HcnozkuwVf/bIXMt4TVqvN/lFKi2JzC276sxnbX/H
 IAb4xeTEaRZtsPRowIsiYFbXze0y2/PR/xKEmdvtsPByqm3GmfrL/e8TekyN+LdNdWna
 RCuQSeNwXdc6KjW7jEErwjbRmONX8P0nOUKeC/sZgzhhMkChG0vUzDRIWTvU69bujBDI
 RzbDaZd6cq9CWQf9d8geulBvyG92z1nC366EnrTWlcJD8QfHos5U3ZNducEJyUrfve1k
 tlnIgf45Jb+FnwRdx++TUy+do0ER3z6Ldk4MqAYe5dLzr5qWzAPbsT3YJ/mqdXmgA4+V
 A1fA==
X-Gm-Message-State: ABy/qLbg6Ec1Bz93Td+KDsT8zbVSRKUe3epUAufvXCvwmxbXzaqE71RF
 lAXXdxQsJnM+qa0oySzzh/BCVf+YGYw7H6HVDwafdQ==
X-Google-Smtp-Source: APBJJlGtzmlW93GdkFzk6DhoIma8WvJ/stKAWNA4/HrG7+vMFWpI8sy868TGWeoWVvH3cxmMVzeLVQ==
X-Received: by 2002:a05:6a00:1910:b0:668:7744:10f5 with SMTP id
 y16-20020a056a00191000b00668774410f5mr13299584pfi.10.1688458008534; 
 Tue, 04 Jul 2023 01:06:48 -0700 (PDT)
Received: from mnissler.ba.rivosinc.com ([66.220.2.162])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b00662c4ca18ebsm15113101pfm.128.2023.07.04.01.06.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 01:06:48 -0700 (PDT)
From: Mattias Nissler <mnissler@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 stefanha@redhat.com, David Hildenbrand <david@redhat.com>,
 john.levon@nutanix.com, Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH 3/3] vfio-user: Message-based DMA support
Date: Tue,  4 Jul 2023 01:06:27 -0700
Message-Id: <20230704080628.852525-4-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230704080628.852525-1-mnissler@rivosinc.com>
References: <20230704080628.852525-1-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=mnissler@rivosinc.com; helo=mail-pf1-x436.google.com
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

Wire up support for DMA for the case where the vfio-user client does not
provide mmap()-able file descriptors, but DMA requests must be performed
via the VFIO-user protocol. This installs an indirect memory region,
which already works for pci_dma_{read,write}, and pci_dma_map works
thanks to the existing DMA bounce buffering support.

Note that while simple scenarios work with this patch, there's a known
race condition in libvfio-user that will mess up the communication
channel: https://github.com/nutanix/libvfio-user/issues/279 I intend to
contribute a fix for this problem, see discussion on the github issue
for more details.

Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
---
 hw/remote/vfio-user-obj.c | 62 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 55 insertions(+), 7 deletions(-)

diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
index 8b10c32a3c..9799580c77 100644
--- a/hw/remote/vfio-user-obj.c
+++ b/hw/remote/vfio-user-obj.c
@@ -300,6 +300,53 @@ static ssize_t vfu_object_cfg_access(vfu_ctx_t *vfu_ctx, char * const buf,
     return count;
 }
 
+static MemTxResult vfu_dma_read(void *opaque, hwaddr addr, uint64_t *val,
+                                unsigned size, MemTxAttrs attrs)
+{
+    MemoryRegion *region = opaque;
+    VfuObject *o = VFU_OBJECT(region->owner);
+
+    dma_sg_t *sg = alloca(dma_sg_size());
+    vfu_dma_addr_t vfu_addr = (vfu_dma_addr_t)(region->addr + addr);
+    if (vfu_addr_to_sgl(o->vfu_ctx, vfu_addr, size, sg, 1, PROT_READ) < 0 ||
+        vfu_sgl_read(o->vfu_ctx, sg, 1, val) != 0) {
+        return MEMTX_ERROR;
+    }
+
+    return MEMTX_OK;
+}
+
+static MemTxResult vfu_dma_write(void *opaque, hwaddr addr, uint64_t val,
+                                 unsigned size, MemTxAttrs attrs)
+{
+    MemoryRegion *region = opaque;
+    VfuObject *o = VFU_OBJECT(region->owner);
+
+    dma_sg_t *sg = alloca(dma_sg_size());
+    vfu_dma_addr_t vfu_addr = (vfu_dma_addr_t)(region->addr + addr);
+    if (vfu_addr_to_sgl(o->vfu_ctx, vfu_addr, size, sg, 1, PROT_WRITE) < 0 ||
+        vfu_sgl_write(o->vfu_ctx, sg, 1, &val) != 0)  {
+        return MEMTX_ERROR;
+    }
+
+    return MEMTX_OK;
+}
+
+static const MemoryRegionOps vfu_dma_ops = {
+    .read_with_attrs = vfu_dma_read,
+    .write_with_attrs = vfu_dma_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
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
@@ -308,17 +355,18 @@ static void dma_register(vfu_ctx_t *vfu_ctx, vfu_dma_info_t *info)
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
+        memory_region_init_io(subregion, OBJECT(o), &vfu_dma_ops, subregion,
+                              name, iov->iov_len);
+    }
 
     dma_as = pci_device_iommu_address_space(o->pci_dev);
 
-- 
2.34.1


