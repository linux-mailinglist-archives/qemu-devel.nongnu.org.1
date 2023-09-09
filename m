Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B670C799842
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 15:02:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qexZz-0006Ro-VO; Sat, 09 Sep 2023 09:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexZx-0006Qb-H0; Sat, 09 Sep 2023 09:00:49 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexZu-0002Bw-HS; Sat, 09 Sep 2023 09:00:49 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 11C8D20595;
 Sat,  9 Sep 2023 16:01:15 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id D953226DFC;
 Sat,  9 Sep 2023 16:00:23 +0300 (MSK)
Received: (nullmailer pid 353078 invoked by uid 1000);
 Sat, 09 Sep 2023 13:00:22 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.5 08/43] hw/nvme: fix compliance issue wrt. iosqes/iocqes
Date: Sat,  9 Sep 2023 15:59:34 +0300
Message-Id: <20230909130020.352951-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.5-20230909155813@cover.tls.msk.ru>
References: <qemu-stable-8.0.5-20230909155813@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Klaus Jensen <k.jensen@samsung.com>

As of prior to this patch, the controller checks the value of CC.IOCQES
and CC.IOSQES prior to enabling the controller. As reported by Ben in
GitLab issue #1691, this is not spec compliant. The controller should
only check these values when queues are created.

This patch moves these checks to nvme_create_cq(). We do not need to
check it in nvme_create_sq() since that will error out if the completion
queue is not already created.

Also, since the controller exclusively supports SQEs of size 64 bytes
and CQEs of size 16 bytes, hard code that.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1691
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
(cherry picked from commit 6a33f2e920ec0b489a77200888e3692664077f2d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 5830048804..353e9e71db 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -1504,7 +1504,7 @@ static void nvme_post_cqes(void *opaque)
         req->cqe.status = cpu_to_le16((req->status << 1) | cq->phase);
         req->cqe.sq_id = cpu_to_le16(sq->sqid);
         req->cqe.sq_head = cpu_to_le16(sq->head);
-        addr = cq->dma_addr + cq->tail * n->cqe_size;
+        addr = cq->dma_addr + (cq->tail << NVME_CQES);
         ret = pci_dma_write(PCI_DEVICE(n), addr, (void *)&req->cqe,
                             sizeof(req->cqe));
         if (ret) {
@@ -5270,10 +5270,18 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeRequest *req)
     uint16_t qsize = le16_to_cpu(c->qsize);
     uint16_t qflags = le16_to_cpu(c->cq_flags);
     uint64_t prp1 = le64_to_cpu(c->prp1);
+    uint32_t cc = ldq_le_p(&n->bar.cc);
+    uint8_t iocqes = NVME_CC_IOCQES(cc);
+    uint8_t iosqes = NVME_CC_IOSQES(cc);
 
     trace_pci_nvme_create_cq(prp1, cqid, vector, qsize, qflags,
                              NVME_CQ_FLAGS_IEN(qflags) != 0);
 
+    if (iosqes != NVME_SQES || iocqes != NVME_CQES) {
+        trace_pci_nvme_err_invalid_create_cq_entry_size(iosqes, iocqes);
+        return NVME_MAX_QSIZE_EXCEEDED | NVME_DNR;
+    }
+
     if (unlikely(!cqid || cqid > n->conf_ioqpairs || n->cq[cqid] != NULL)) {
         trace_pci_nvme_err_invalid_create_cq_cqid(cqid);
         return NVME_INVALID_QID | NVME_DNR;
@@ -6979,7 +6987,7 @@ static void nvme_process_sq(void *opaque)
     }
 
     while (!(nvme_sq_empty(sq) || QTAILQ_EMPTY(&sq->req_list))) {
-        addr = sq->dma_addr + sq->head * n->sqe_size;
+        addr = sq->dma_addr + (sq->head << NVME_SQES);
         if (nvme_addr_read(n, addr, (void *)&cmd, sizeof(cmd))) {
             trace_pci_nvme_err_addr_read(addr);
             trace_pci_nvme_err_cfs();
@@ -7206,34 +7214,6 @@ static int nvme_start_ctrl(NvmeCtrl *n)
                     NVME_CAP_MPSMAX(cap));
         return -1;
     }
-    if (unlikely(NVME_CC_IOCQES(cc) <
-                 NVME_CTRL_CQES_MIN(n->id_ctrl.cqes))) {
-        trace_pci_nvme_err_startfail_cqent_too_small(
-                    NVME_CC_IOCQES(cc),
-                    NVME_CTRL_CQES_MIN(cap));
-        return -1;
-    }
-    if (unlikely(NVME_CC_IOCQES(cc) >
-                 NVME_CTRL_CQES_MAX(n->id_ctrl.cqes))) {
-        trace_pci_nvme_err_startfail_cqent_too_large(
-                    NVME_CC_IOCQES(cc),
-                    NVME_CTRL_CQES_MAX(cap));
-        return -1;
-    }
-    if (unlikely(NVME_CC_IOSQES(cc) <
-                 NVME_CTRL_SQES_MIN(n->id_ctrl.sqes))) {
-        trace_pci_nvme_err_startfail_sqent_too_small(
-                    NVME_CC_IOSQES(cc),
-                    NVME_CTRL_SQES_MIN(cap));
-        return -1;
-    }
-    if (unlikely(NVME_CC_IOSQES(cc) >
-                 NVME_CTRL_SQES_MAX(n->id_ctrl.sqes))) {
-        trace_pci_nvme_err_startfail_sqent_too_large(
-                    NVME_CC_IOSQES(cc),
-                    NVME_CTRL_SQES_MAX(cap));
-        return -1;
-    }
     if (unlikely(!NVME_AQA_ASQS(aqa))) {
         trace_pci_nvme_err_startfail_asqent_sz_zero();
         return -1;
@@ -7246,8 +7226,6 @@ static int nvme_start_ctrl(NvmeCtrl *n)
     n->page_bits = page_bits;
     n->page_size = page_size;
     n->max_prp_ents = n->page_size / sizeof(uint64_t);
-    n->cqe_size = 1 << NVME_CC_IOCQES(cc);
-    n->sqe_size = 1 << NVME_CC_IOSQES(cc);
     nvme_init_cq(&n->admin_cq, n, acq, 0, 0, NVME_AQA_ACQS(aqa) + 1, 1);
     nvme_init_sq(&n->admin_sq, n, asq, 0, 0, NVME_AQA_ASQS(aqa) + 1);
 
@@ -8219,8 +8197,8 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->wctemp = cpu_to_le16(NVME_TEMPERATURE_WARNING);
     id->cctemp = cpu_to_le16(NVME_TEMPERATURE_CRITICAL);
 
-    id->sqes = (0x6 << 4) | 0x6;
-    id->cqes = (0x4 << 4) | 0x4;
+    id->sqes = (NVME_SQES << 4) | NVME_SQES;
+    id->cqes = (NVME_CQES << 4) | NVME_CQES;
     id->nn = cpu_to_le32(NVME_MAX_NAMESPACES);
     id->oncs = cpu_to_le16(NVME_ONCS_WRITE_ZEROES | NVME_ONCS_TIMESTAMP |
                            NVME_ONCS_FEATURES | NVME_ONCS_DSM |
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 209e8f5b4c..5f2ae7b28b 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -30,6 +30,13 @@
 #define NVME_FDP_MAX_EVENTS 63
 #define NVME_FDP_MAXPIDS 128
 
+/*
+ * The controller only supports Submission and Completion Queue Entry Sizes of
+ * 64 and 16 bytes respectively.
+ */
+#define NVME_SQES 6
+#define NVME_CQES 4
+
 QEMU_BUILD_BUG_ON(NVME_MAX_NAMESPACES > NVME_NSID_BROADCAST - 1);
 
 typedef struct NvmeCtrl NvmeCtrl;
@@ -530,8 +537,6 @@ typedef struct NvmeCtrl {
     uint32_t    page_size;
     uint16_t    page_bits;
     uint16_t    max_prp_ents;
-    uint16_t    cqe_size;
-    uint16_t    sqe_size;
     uint32_t    max_q_ents;
     uint8_t     outstanding_aers;
     uint32_t    irq_status;
diff --git a/hw/nvme/trace-events b/hw/nvme/trace-events
index 7f7837e1a2..75083e992d 100644
--- a/hw/nvme/trace-events
+++ b/hw/nvme/trace-events
@@ -168,6 +168,7 @@ pci_nvme_err_invalid_create_cq_size(uint16_t size) "failed creating completion q
 pci_nvme_err_invalid_create_cq_addr(uint64_t addr) "failed creating completion queue, addr=0x%"PRIx64""
 pci_nvme_err_invalid_create_cq_vector(uint16_t vector) "failed creating completion queue, vector=%"PRIu16""
 pci_nvme_err_invalid_create_cq_qflags(uint16_t qflags) "failed creating completion queue, qflags=%"PRIu16""
+pci_nvme_err_invalid_create_cq_entry_size(uint8_t iosqes, uint8_t iocqes) "iosqes %"PRIu8" iocqes %"PRIu8""
 pci_nvme_err_invalid_identify_cns(uint16_t cns) "identify, invalid cns=0x%"PRIx16""
 pci_nvme_err_invalid_getfeat(int dw10) "invalid get features, dw10=0x%"PRIx32""
 pci_nvme_err_invalid_setfeat(uint32_t dw10) "invalid set features, dw10=0x%"PRIx32""
-- 
2.39.2


