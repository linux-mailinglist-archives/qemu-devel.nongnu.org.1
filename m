Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1C3761A86
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 15:50:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOINf-0007i8-E3; Tue, 25 Jul 2023 09:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOING-0005xW-CV; Tue, 25 Jul 2023 09:46:53 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOIND-0001Xb-Bs; Tue, 25 Jul 2023 09:46:49 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C9DF4160FA;
 Tue, 25 Jul 2023 16:45:35 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 715A8194BD;
 Tue, 25 Jul 2023 16:45:33 +0300 (MSK)
Received: (nullmailer pid 3370837 invoked by uid 1000);
 Tue, 25 Jul 2023 13:45:29 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.4 18/31] hw/nvme: fix endianness issue for shadow
 doorbells
Date: Tue, 25 Jul 2023 16:45:03 +0300
Message-Id: <20230725134517.3370706-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.4-20230725164041@cover.tls.msk.ru>
References: <qemu-stable-8.0.4-20230725164041@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Klaus Jensen <k.jensen@samsung.com>

In commit 2fda0726e514 ("hw/nvme: fix missing endian conversions for
doorbell buffers"), we fixed shadow doorbells for big-endian guests
running on little endian hosts. But I did not fix little-endian guests
on big-endian hosts. Fix this.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1765
Fixes: 3f7fe8de3d49 ("hw/nvme: Implement shadow doorbell buffer support")
Cc: qemu-stable@nongnu.org
Reported-by: Thomas Huth <thuth@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
(cherry picked from commit ea3c76f1494d0c75873c3b470e6e048202661ad8)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index ac24eeb5ed..2097fb1310 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -6767,6 +6767,7 @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, const NvmeRequest *req)
     PCIDevice *pci = PCI_DEVICE(n);
     uint64_t dbs_addr = le64_to_cpu(req->cmd.dptr.prp1);
     uint64_t eis_addr = le64_to_cpu(req->cmd.dptr.prp2);
+    uint32_t v;
     int i;
 
     /* Address should be page aligned */
@@ -6784,6 +6785,8 @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, const NvmeRequest *req)
         NvmeCQueue *cq = n->cq[i];
 
         if (sq) {
+            v = cpu_to_le32(sq->tail);
+
             /*
              * CAP.DSTRD is 0, so offset of ith sq db_addr is (i<<3)
              * nvme_process_db() uses this hard-coded way to calculate
@@ -6791,7 +6794,7 @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, const NvmeRequest *req)
              */
             sq->db_addr = dbs_addr + (i << 3);
             sq->ei_addr = eis_addr + (i << 3);
-            pci_dma_write(pci, sq->db_addr, &sq->tail, sizeof(sq->tail));
+            pci_dma_write(pci, sq->db_addr, &v, sizeof(sq->tail));
 
             if (n->params.ioeventfd && sq->sqid != 0) {
                 if (!nvme_init_sq_ioeventfd(sq)) {
@@ -6801,10 +6804,12 @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, const NvmeRequest *req)
         }
 
         if (cq) {
+            v = cpu_to_le32(cq->head);
+
             /* CAP.DSTRD is 0, so offset of ith cq db_addr is (i<<3)+(1<<2) */
             cq->db_addr = dbs_addr + (i << 3) + (1 << 2);
             cq->ei_addr = eis_addr + (i << 3) + (1 << 2);
-            pci_dma_write(pci, cq->db_addr, &cq->head, sizeof(cq->head));
+            pci_dma_write(pci, cq->db_addr, &v, sizeof(cq->head));
 
             if (n->params.ioeventfd && cq->cqid != 0) {
                 if (!nvme_init_cq_ioeventfd(cq)) {
@@ -7555,7 +7560,7 @@ static uint64_t nvme_mmio_read(void *opaque, hwaddr addr, unsigned size)
 static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
 {
     PCIDevice *pci = PCI_DEVICE(n);
-    uint32_t qid;
+    uint32_t qid, v;
 
     if (unlikely(addr & ((1 << 2) - 1))) {
         NVME_GUEST_ERR(pci_nvme_ub_db_wr_misaligned,
@@ -7622,7 +7627,8 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
         start_sqs = nvme_cq_full(cq) ? 1 : 0;
         cq->head = new_head;
         if (!qid && n->dbbuf_enabled) {
-            pci_dma_write(pci, cq->db_addr, &cq->head, sizeof(cq->head));
+            v = cpu_to_le32(cq->head);
+            pci_dma_write(pci, cq->db_addr, &v, sizeof(cq->head));
         }
         if (start_sqs) {
             NvmeSQueue *sq;
@@ -7682,6 +7688,8 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
 
         sq->tail = new_tail;
         if (!qid && n->dbbuf_enabled) {
+            v = cpu_to_le32(sq->tail);
+
             /*
              * The spec states "the host shall also update the controller's
              * corresponding doorbell property to match the value of that entry
@@ -7695,7 +7703,7 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
              * including ones that run on Linux, are not updating Admin Queues,
              * so we can't trust reading it for an appropriate sq tail.
              */
-            pci_dma_write(pci, sq->db_addr, &sq->tail, sizeof(sq->tail));
+            pci_dma_write(pci, sq->db_addr, &v, sizeof(sq->tail));
         }
 
         qemu_bh_schedule(sq->bh);
-- 
2.39.2


