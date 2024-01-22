Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB7083719F
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 20:02:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRzXC-0005gX-7P; Mon, 22 Jan 2024 14:00:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1rRzXA-0005fz-CR; Mon, 22 Jan 2024 14:00:36 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1rRzX8-00025H-BX; Mon, 22 Jan 2024 14:00:36 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33934567777so1605617f8f.1; 
 Mon, 22 Jan 2024 11:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705950032; x=1706554832; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mbe8IJdT/146B0yLIjQfTQC3deMWdsDoJBafFhCKv3w=;
 b=kp9NF0gXsYcCBHmo/XemZumEs7ooq0sycUuYlNHe+xFypftokrbLLlL2YaxiIgzqe3
 ixfWSWCupI80HdQOh19Nsz6LaL2dEOzq1T10diF8NB2+UCZaOxb5m3OAzM7vDWTgtO8o
 gWF5md73KvHADrWXFAZZ1L66JV1/cBQDH2Ccrc0PfpXhGTjIOSotUUoaHkgRcvcJPoJU
 2lqDwk+8wvQhfS2gCX3/RdbkNqWtpJLeVQtJrFcgoI5dainTntfhG2II7Z0W/wXfKxy/
 QjaT3t/64EQfnsM34nEFTkRgwDxIr884/P7KdJ8Vr3U/gbitiSZGBH2juA688Mu/zfuQ
 HV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705950032; x=1706554832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mbe8IJdT/146B0yLIjQfTQC3deMWdsDoJBafFhCKv3w=;
 b=B3vHFR3ctrujnmnZQw2XbvD9+52KxfI1SCZNhKo2b9pntrN5o8gqFCU/cjXT4LlBvF
 Ql3Jmfj8LGLaKaOHgnb4PNsqb4VMafAyblDHSx7n5xHkclfhh/DNdjbJYk9ddewKTpxj
 Ijnx5sk+zp2VOuZOM6+gvcgy05k4i05gDaTF6ZhudmZa2aQCwiGwX3p9K4x7xzC12gW8
 y8Q3Cr58ciwOdW/c5Rg6oohRC74rn4JxPAGd00SEVN0JKmTYcDqRrdZ+E7OOzJCz7lgZ
 RyVaDVQpBhWxdD6YzXBDF8iNlFYJpZb6IemmMKfWx7Bhu1phmtENFI5yupcQoPyPjkGr
 qxZw==
X-Gm-Message-State: AOJu0Yz6qtjL1b4PdxLpaz+eRwdtfNjnHIHm58kXpPD460SGmJVWJAT/
 udfF4tR39XV3x1Ke/+ULNOkDPW9DTThsTBvEYmBkx+g32+o1EV9qkWVCAVSl9uA=
X-Google-Smtp-Source: AGHT+IG5LghvUcps8bruBNtCTjQZy3nUnqAJ2aDtzJprHV0a5cs3ubjPP2hBTRSTFUBBoIwhLc+4eA==
X-Received: by 2002:a7b:c4ca:0:b0:40e:545b:80e6 with SMTP id
 g10-20020a7bc4ca000000b0040e545b80e6mr2534498wmk.158.1705950032060; 
 Mon, 22 Jan 2024 11:00:32 -0800 (PST)
Received: from localhost.localdomain ([2a02:2454:367:1500:fa08:d4d:b569:ac2d])
 by smtp.gmail.com with ESMTPSA id
 k3-20020a170906a38300b00a298d735a1bsm13842413ejz.149.2024.01.22.11.00.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 11:00:31 -0800 (PST)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, stefanha@redhat.com,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 dmitry.fomichev@wdc.com, hare@suse.de, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 dlemoal@kernel.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Sam Li <faithilikerun@gmail.com>
Subject: [RFC v3 6/7] hw/nvme: refactor zone append write using block layer
 APIs
Date: Mon, 22 Jan 2024 20:00:12 +0100
Message-Id: <20240122190013.41302-7-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240122190013.41302-1-faithilikerun@gmail.com>
References: <20240122190013.41302-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=faithilikerun@gmail.com; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Sam Li <faithilikerun@gmail.com>
---
 block/qcow2.c        |   2 +-
 hw/nvme/ctrl.c       | 190 ++++++++++++++++++++++++++++++++-----------
 include/sysemu/dma.h |   3 +
 system/dma-helpers.c |  17 ++++
 4 files changed, 162 insertions(+), 50 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 0bb249fa6e..43ee0f47b9 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2395,7 +2395,7 @@ static void qcow2_refresh_limits(BlockDriverState *bs, Error **errp)
     bs->bl.max_open_zones = s->zoned_header.max_open_zones;
     bs->bl.zone_size = s->zoned_header.zone_size;
     bs->bl.zone_capacity = s->zoned_header.zone_capacity;
-    bs->bl.write_granularity = BDRV_SECTOR_SIZE;
+    bs->bl.write_granularity = BDRV_SECTOR_SIZE; /* physical block size */
     bs->bl.zd_extension_size = s->zoned_header.zd_extension_size;
 }
 
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index e31aa52c06..de41d8bac8 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -1726,6 +1726,95 @@ static void nvme_misc_cb(void *opaque, int ret)
     nvme_enqueue_req_completion(nvme_cq(req), req);
 }
 
+typedef struct NvmeZoneCmdAIOCB {
+    NvmeRequest *req;
+    NvmeCmd *cmd;
+    NvmeCtrl *n;
+
+    union {
+        struct {
+          uint32_t partial;
+          unsigned int nr_zones;
+          BlockZoneDescriptor *zones;
+        } zone_report_data;
+        struct {
+          int64_t offset;
+        } zone_append_data;
+    };
+} NvmeZoneCmdAIOCB;
+
+static void nvme_blk_zone_append_complete_cb(void *opaque, int ret)
+{
+    NvmeZoneCmdAIOCB *cb = opaque;
+    NvmeRequest *req = cb->req;
+    int64_t *offset = (int64_t *)&req->cqe;
+
+    if (ret) {
+        nvme_aio_err(req, ret);
+    }
+
+    *offset = nvme_b2l(req->ns, cb->zone_append_data.offset);
+    nvme_enqueue_req_completion(nvme_cq(req), req);
+    g_free(cb);
+}
+
+static inline void nvme_blk_zone_append(BlockBackend *blk, int64_t *offset,
+                                  uint32_t align,
+                                  BlockCompletionFunc *cb,
+                                  NvmeZoneCmdAIOCB *aiocb)
+{
+    NvmeRequest *req = aiocb->req;
+    assert(req->sg.flags & NVME_SG_ALLOC);
+
+    if (req->sg.flags & NVME_SG_DMA) {
+        req->aiocb = dma_blk_zone_append(blk, &req->sg.qsg, (int64_t)offset,
+                                         align, cb, aiocb);
+    } else {
+        req->aiocb = blk_aio_zone_append(blk, offset, &req->sg.iov, 0,
+                                         cb, aiocb);
+    }
+}
+
+static void nvme_zone_append_cb(void *opaque, int ret)
+{
+    NvmeZoneCmdAIOCB *aiocb = opaque;
+    NvmeRequest *req = aiocb->req;
+    NvmeNamespace *ns = req->ns;
+
+    BlockBackend *blk = ns->blkconf.blk;
+
+    trace_pci_nvme_rw_cb(nvme_cid(req), blk_name(blk));
+
+    if (ret) {
+        goto out;
+    }
+
+    if (ns->lbaf.ms) {
+        NvmeRwCmd *rw = (NvmeRwCmd *)&req->cmd;
+        uint32_t nlb = (uint32_t)le16_to_cpu(rw->nlb) + 1;
+        int64_t offset = aiocb->zone_append_data.offset;
+
+        if (nvme_ns_ext(ns) || req->cmd.mptr) {
+            uint16_t status;
+
+            nvme_sg_unmap(&req->sg);
+            status = nvme_map_mdata(nvme_ctrl(req), nlb, req);
+            if (status) {
+                ret = -EFAULT;
+                goto out;
+            }
+
+            return nvme_blk_zone_append(blk, &offset, 1,
+                                        nvme_blk_zone_append_complete_cb,
+                                        aiocb);
+        }
+    }
+
+out:
+    nvme_blk_zone_append_complete_cb(aiocb, ret);
+}
+
+
 void nvme_rw_complete_cb(void *opaque, int ret)
 {
     NvmeRequest *req = opaque;
@@ -3052,6 +3141,9 @@ static uint16_t nvme_do_write(NvmeCtrl *n, NvmeRequest *req, bool append,
     uint64_t mapped_size = data_size;
     uint64_t data_offset;
     BlockBackend *blk = ns->blkconf.blk;
+    BlockZoneWps *wps = blk_get_zone_wps(blk);
+    uint32_t zone_size = blk_get_zone_size(blk);
+    uint32_t zone_idx;
     uint16_t status;
 
     if (nvme_ns_ext(ns)) {
@@ -3082,42 +3174,47 @@ static uint16_t nvme_do_write(NvmeCtrl *n, NvmeRequest *req, bool append,
     }
 
     if (blk_get_zone_model(blk)) {
-        uint32_t zone_size = blk_get_zone_size(blk);
-        uint32_t zone_idx = slba / zone_size;
-        int64_t zone_start = zone_idx * zone_size;
+        assert(wps);
+        if (zone_size) {
+            zone_idx = slba / zone_size;
+            int64_t zone_start = zone_idx * zone_size;
+
+            if (append) {
+                bool piremap = !!(ctrl & NVME_RW_PIREMAP);
+
+                if (n->params.zasl &&
+                    data_size > (uint64_t)
+                    n->page_size << n->params.zasl) {
+                    trace_pci_nvme_err_zasl(data_size);
+                    return NVME_INVALID_FIELD | NVME_DNR;
+                }
 
-        if (append) {
-            bool piremap = !!(ctrl & NVME_RW_PIREMAP);
+                rw->slba = cpu_to_le64(slba);
 
-            if (n->params.zasl &&
-                data_size > (uint64_t)n->page_size << n->params.zasl) {
-                trace_pci_nvme_err_zasl(data_size);
-                return NVME_INVALID_FIELD | NVME_DNR;
-            }
+                switch (NVME_ID_NS_DPS_TYPE(ns->id_ns.dps)) {
+                case NVME_ID_NS_DPS_TYPE_1:
+                    if (!piremap) {
+                        return NVME_INVALID_PROT_INFO | NVME_DNR;
+                    }
 
-            rw->slba = cpu_to_le64(slba);
-            switch (NVME_ID_NS_DPS_TYPE(ns->id_ns.dps)) {
-            case NVME_ID_NS_DPS_TYPE_1:
-                if (!piremap) {
-                    return NVME_INVALID_PROT_INFO | NVME_DNR;
-                }
+                    /* fallthrough */
 
-                /* fallthrough */
+                case NVME_ID_NS_DPS_TYPE_2:
+                    if (piremap) {
+                        uint32_t reftag = le32_to_cpu(rw->reftag);
+                        rw->reftag =
+                            cpu_to_le32(reftag + (slba - zone_start));
+                    }
 
-            case NVME_ID_NS_DPS_TYPE_2:
-                if (piremap) {
-                    uint32_t reftag = le32_to_cpu(rw->reftag);
-                    rw->reftag = cpu_to_le32(reftag + (slba - zone_start));
-                }
+                    break;
 
-                break;
+                case NVME_ID_NS_DPS_TYPE_3:
+                    if (piremap) {
+                        return NVME_INVALID_PROT_INFO | NVME_DNR;
+                    }
 
-            case NVME_ID_NS_DPS_TYPE_3:
-                if (piremap) {
-                    return NVME_INVALID_PROT_INFO | NVME_DNR;
+                    break;
                 }
-
-                break;
             }
         }
 
@@ -3137,9 +3234,21 @@ static uint16_t nvme_do_write(NvmeCtrl *n, NvmeRequest *req, bool append,
             goto invalid;
         }
 
-        block_acct_start(blk_get_stats(blk), &req->acct, data_size,
-                         BLOCK_ACCT_WRITE);
-        nvme_blk_write(blk, data_offset, BDRV_SECTOR_SIZE, nvme_rw_cb, req);
+        if (append) {
+            NvmeZoneCmdAIOCB *cb = g_malloc(sizeof(NvmeZoneCmdAIOCB));
+            cb->req = req;
+            cb->zone_append_data.offset = data_offset;
+
+            block_acct_start(blk_get_stats(blk), &req->acct, data_size,
+                             BLOCK_ACCT_ZONE_APPEND);
+            nvme_blk_zone_append(blk, &cb->zone_append_data.offset,
+                                 blk_get_write_granularity(blk),
+                                 nvme_zone_append_cb, cb);
+        } else {
+            block_acct_start(blk_get_stats(blk), &req->acct, data_size,
+                             BLOCK_ACCT_WRITE);
+            nvme_blk_write(blk, data_offset, BDRV_SECTOR_SIZE, nvme_rw_cb, req);
+        }
     } else {
         req->aiocb = blk_aio_pwrite_zeroes(blk, data_offset, data_size,
                                            BDRV_REQ_MAY_UNMAP, nvme_rw_cb,
@@ -3163,24 +3272,7 @@ static inline uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
     return nvme_do_write(n, req, false, true);
 }
 
-typedef struct NvmeZoneCmdAIOCB {
-    NvmeRequest *req;
-    NvmeCmd *cmd;
-    NvmeCtrl *n;
-
-    union {
-        struct {
-          uint32_t partial;
-          unsigned int nr_zones;
-          BlockZoneDescriptor *zones;
-        } zone_report_data;
-        struct {
-          int64_t offset;
-        } zone_append_data;
-    };
-} NvmeZoneCmdAIOCB;
-
-static inline uint16_t nvme_zone_append(NvmeCtrl *n, NvmeRequest *req)
+static uint16_t nvme_zone_append(NvmeCtrl *n, NvmeRequest *req)
 {
     return nvme_do_write(n, req, true, false);
 }
diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
index a1ac5bc1b5..680e0b5477 100644
--- a/include/sysemu/dma.h
+++ b/include/sysemu/dma.h
@@ -301,6 +301,9 @@ BlockAIOCB *dma_blk_read(BlockBackend *blk,
 BlockAIOCB *dma_blk_write(BlockBackend *blk,
                           QEMUSGList *sg, uint64_t offset, uint32_t align,
                           BlockCompletionFunc *cb, void *opaque);
+BlockAIOCB *dma_blk_zone_append(BlockBackend *blk,
+                          QEMUSGList *sg, int64_t offset, uint32_t align,
+                          void (*cb)(void *opaque, int ret), void *opaque);
 MemTxResult dma_buf_read(void *ptr, dma_addr_t len, dma_addr_t *residual,
                          QEMUSGList *sg, MemTxAttrs attrs);
 MemTxResult dma_buf_write(void *ptr, dma_addr_t len, dma_addr_t *residual,
diff --git a/system/dma-helpers.c b/system/dma-helpers.c
index 9b221cf94e..908aff9bc0 100644
--- a/system/dma-helpers.c
+++ b/system/dma-helpers.c
@@ -274,6 +274,23 @@ BlockAIOCB *dma_blk_write(BlockBackend *blk,
                       DMA_DIRECTION_TO_DEVICE);
 }
 
+static
+BlockAIOCB *dma_blk_zone_append_io_func(int64_t offset, QEMUIOVector *iov,
+                                  BlockCompletionFunc *cb, void *cb_opaque,
+                                  void *opaque)
+{
+    BlockBackend *blk = opaque;
+    return blk_aio_zone_append(blk, (int64_t *)offset, iov, 0, cb, cb_opaque);
+}
+
+BlockAIOCB *dma_blk_zone_append(BlockBackend *blk,
+                          QEMUSGList *sg, int64_t offset, uint32_t align,
+                          void (*cb)(void *opaque, int ret), void *opaque)
+{
+    return dma_blk_io(blk_get_aio_context(blk), sg, offset, align,
+                      dma_blk_zone_append_io_func, blk, cb, opaque,
+                      DMA_DIRECTION_TO_DEVICE);
+}
 
 static MemTxResult dma_buf_rw(void *buf, dma_addr_t len, dma_addr_t *residual,
                               QEMUSGList *sg, DMADirection dir,
-- 
2.40.1


