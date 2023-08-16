Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B00C77DAF1
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 09:09:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWAeP-0007aE-OY; Wed, 16 Aug 2023 03:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qWAeL-0007YK-9v; Wed, 16 Aug 2023 03:09:01 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qWAeI-0004de-A7; Wed, 16 Aug 2023 03:09:00 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6889288a31fso105609b3a.1; 
 Wed, 16 Aug 2023 00:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692169736; x=1692774536;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5Z774aEGAXt2ABHGh4Bp0a2kifeg42fp9F7VLDTZyWo=;
 b=Tn1VBC6zAv1yFL5boMKFPxYGDJ2C9773+mf9SiUnqSX0vd8hJfUGc7ZKkE0HqNcqbl
 uq9aYaRaviO/esnRvUsErNQi+JiRHWHpLrvy63Y1UvlcOQWnyhSuFYH+3JraUzHUE4VL
 cW0sa80jYPsySZw7Ue1cNazaKIabyQ+ZD4IyG/4OI0tTtbue58qLNrqHYfo+5S2L9oSm
 2TplJqD8Brbv6CBw6lZ/fmn6B/gMzK4lXtrm9DRHW1x7iaji29VRkByNzKtiDJ4vsD6l
 rDnR3pAqr91VkgdfY5QwKAogc691dGHTAs4v8e9fQBGq+fQ6CfvyZv7JNp0KberZO8ob
 PIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692169736; x=1692774536;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5Z774aEGAXt2ABHGh4Bp0a2kifeg42fp9F7VLDTZyWo=;
 b=d7NJeOyfbLbh34lR+xaHDtlj9NY/W6VQnJKugsTY3DlK4mvRUYLnUPFGaFYI5vBAiv
 E5trOhsChXKYQuw8wR5iTUPg85cIqNrb2o9aBapW2QnZzNpFvo/aD7WxX5er28VuHwGr
 jUmBHR7t7Yly0Slla2bv1q+/VrU8npCPsQJzCXjI2773okmLFFs/GvXu87Yh7Kf/E3LE
 j3qgSEHmUXHkBiSPijHyiOrsjOys1Q8iEIA82PEzN4I+mao8WIfCHhs/aWBQC1yR8NCk
 NuKoUvX2fJuc7kuV6HQ7nfTO2SSYQ6nX90O0RLy5igu/YVK2apEcUE5jtJeuRYoVad8n
 T1EA==
X-Gm-Message-State: AOJu0Yx6QltDeJLuL5/Ouj7OIKj3SqffpxDXIO3hQMBSNLVaqZYtQoGi
 hDqzVeorh7zYT6SOzAxZmdHpxzPrQ6TfdUj9WaI=
X-Google-Smtp-Source: AGHT+IHewfP6gZSegTjGX+XAsdFA7wT2xoohlzqrSPpPni53HQaDCdfzMA7xklElj2OZStuxZ29K6g==
X-Received: by 2002:a05:6a00:1ca2:b0:668:8ad5:778f with SMTP id
 y34-20020a056a001ca200b006688ad5778fmr4518552pfw.17.1692169735393; 
 Wed, 16 Aug 2023 00:08:55 -0700 (PDT)
Received: from fedlinux.. ([106.84.130.68]) by smtp.gmail.com with ESMTPSA id
 bm17-20020a056a00321100b00640ddad2e0dsm10421065pfb.47.2023.08.16.00.08.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 00:08:54 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Klaus Jensen <its@irrelevant.dk>,
 Markus Armbruster <armbru@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 dlemoal@kernel.org, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, hare@suse.de,
 Kevin Wolf <kwolf@redhat.com>, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, dmitry.fomichev@wdc.com,
 Sam Li <faithilikerun@gmail.com>
Subject: [RFC 4/5] hw/nvme: refactor zone append writes using block layer APIs
Date: Wed, 16 Aug 2023 15:08:41 +0800
Message-Id: <20230816070842.5423-1-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=faithilikerun@gmail.com; helo=mail-pf1-x42e.google.com
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

Signed-off-by: Sam Li <faithilikerun@gmail.com>
---
 block/block-backend.c             |   8 ++
 block/qcow2.c                     |   7 +-
 hw/nvme/ctrl.c                    | 195 ++++++++++++++++++++++--------
 include/sysemu/block-backend-io.h |   1 +
 include/sysemu/dma.h              |   3 +
 softmmu/dma-helpers.c             |  17 +++
 6 files changed, 181 insertions(+), 50 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 9c95ae0267..2aafb4cee3 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2426,6 +2426,14 @@ uint32_t blk_get_nr_zones(BlockBackend *blk)
     return bs ? bs->bl.nr_zones : 0;
 }
 
+uint32_t blk_get_write_granularity(BlockBackend *blk)
+{
+    BlockDriverState *bs = blk_bs(blk);
+    IO_CODE();
+
+    return bs ? bs->bl.write_granularity : 0;
+}
+
 uint8_t *blk_get_zone_extension(BlockBackend *blk) {
     BlockDriverState * bs = blk_bs(blk);
     IO_CODE();
diff --git a/block/qcow2.c b/block/qcow2.c
index 41549dd68b..5a038792f1 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2198,7 +2198,7 @@ static void qcow2_refresh_limits(BlockDriverState *bs, Error **errp)
     bs->bl.max_active_zones = s->zoned_header.max_active_zones;
     bs->bl.max_open_zones = s->zoned_header.max_open_zones;
     bs->bl.zone_size = s->zoned_header.zone_size;
-    bs->bl.write_granularity = BDRV_SECTOR_SIZE;
+    bs->bl.write_granularity = 4096; /* physical block size */
 }
 
 static int qcow2_reopen_prepare(BDRVReopenState *state,
@@ -4915,6 +4915,11 @@ qcow2_co_zone_append(BlockDriverState *bs, int64_t *offset, QEMUIOVector *qiov,
     qemu_co_mutex_lock(&s->wps->colock);
     uint64_t wp = s->wps->wp[index];
     uint64_t wp_i = qcow2_get_wp(wp);
+    printf("qcow2 offset 0x%lx\n", *offset);
+    printf("checking wp[%ld]: 0b%lb\n", *offset / bs->bl.zone_size, wp);
+    for (int i = 0; i < bs->bl.nr_zones; i++) {
+        printf("Listing wp[%d]: 0b%lb\n", i, s->wps->wp[i]);
+    }
     ret = qcow2_co_pwritev_part(bs, wp_i, len, qiov, 0, 0);
     if (ret == 0) {
         *offset = wp_i;
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 8d4c08dc4c..3932b516ed 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -1740,6 +1740,95 @@ static void nvme_misc_cb(void *opaque, int ret)
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
@@ -3067,6 +3156,9 @@ static uint16_t nvme_do_write(NvmeCtrl *n, NvmeRequest *req, bool append,
     uint64_t mapped_size = data_size;
     uint64_t data_offset;
     BlockBackend *blk = ns->blkconf.blk;
+    BlockZoneWps *wps = blk_get_zone_wps(blk);
+    uint32_t zone_size = blk_get_zone_size(blk);
+    uint32_t zone_idx;
     uint16_t status;
 
     if (nvme_ns_ext(ns)) {
@@ -3097,42 +3189,47 @@ static uint16_t nvme_do_write(NvmeCtrl *n, NvmeRequest *req, bool append,
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
 
@@ -3152,9 +3249,21 @@ static uint16_t nvme_do_write(NvmeCtrl *n, NvmeRequest *req, bool append,
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
@@ -3178,24 +3287,7 @@ static inline uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
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
@@ -3333,6 +3425,11 @@ static uint16_t nvme_zone_mgmt_send(NvmeCtrl *n, NvmeRequest *req)
     NvmeNamespace *ns = req->ns;
     NvmeZoneMgmtAIOCB *iocb;
     uint64_t slba = 0;
+    uint64_t offset;
+    BlockBackend *blk = ns->blkconf.blk;
+    uint32_t zone_size = blk_get_zone_size(blk);
+    uint64_t size = zone_size * blk_get_nr_zones(blk);
+    int64_t len;
     uint32_t zone_idx = 0;
     uint16_t status;
     uint8_t action = cmd->zsa;
diff --git a/include/sysemu/block-backend-io.h b/include/sysemu/block-backend-io.h
index f69aa1094a..fcbdd93dea 100644
--- a/include/sysemu/block-backend-io.h
+++ b/include/sysemu/block-backend-io.h
@@ -109,6 +109,7 @@ uint32_t blk_get_max_append_sectors(BlockBackend *blk);
 uint32_t blk_get_nr_zones(BlockBackend *blk);
 uint8_t *blk_get_zone_extension(BlockBackend *blk);
 uint32_t blk_get_zd_ext_size(BlockBackend *blk);
+uint32_t blk_get_write_granularity(BlockBackend *blk);
 BlockZoneWps *blk_get_zone_wps(BlockBackend *blk);
 
 void blk_io_plug(void);
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
diff --git a/softmmu/dma-helpers.c b/softmmu/dma-helpers.c
index 2463964805..88bc13264b 100644
--- a/softmmu/dma-helpers.c
+++ b/softmmu/dma-helpers.c
@@ -282,6 +282,23 @@ BlockAIOCB *dma_blk_write(BlockBackend *blk,
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


