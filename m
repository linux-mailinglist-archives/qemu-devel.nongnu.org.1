Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC4A75AB2A
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 11:44:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMQBG-0000aH-Fc; Thu, 20 Jul 2023 05:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qMQBA-0000Zf-7q; Thu, 20 Jul 2023 05:42:36 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qMQB4-0002kc-Gj; Thu, 20 Jul 2023 05:42:35 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.west.internal (Postfix) with ESMTP id 138EB3201310;
 Thu, 20 Jul 2023 05:42:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Thu, 20 Jul 2023 05:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:sender
 :subject:subject:to:to; s=fm2; t=1689846146; x=1689932546; bh=mB
 3I+pRyVx+I7U7Y6L6VR5zKK9KGW4UTsqhkm/W1XDI=; b=nT/JszPPyrRZrWUm/S
 iz0Uzr6enHWAtV/t6pQXRghWZ7qkJ3mtA7GhXUMyOeXy/JnQTblkYSS0l757yBIF
 Q0PIK7pH/JGoFefShHVBbbX0xZwFFcR8cbwSY8iU55MQGdXKJrvgtirRd22loiiI
 ZZ4lF1s5OBKDRm/EeTzQBpbX+k5qE0S+g/OvvoSfN7E/lKfvL6MZwbJNAuLmmZ2/
 2GerAoOBcHHgN4JkcbTXROZ4J+8DNyf5KVctElH0FzErGUGVsHnDt/K+5hsFpsLn
 Ag47WiUk17DeDK2DvHq1BLvpkh/QBRd5KqkEh6hAMwbC5UmgUDh+aYgAxXTMRbvu
 hRUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1689846146; x=1689932546; bh=mB3I+pRyVx+I7
 U7Y6L6VR5zKK9KGW4UTsqhkm/W1XDI=; b=TbZGtwXO9mJmkRAhNNFsGfKuPWc2s
 COp0/Qq34maQzJdAM+lU4N4xO/ujPT0Jot5ucY8RYx7JHV9kmgECGahC5Rk6dsHB
 rMLrDOkufQT5EtNKndV5vKmbGwJARvy2J+oQDKbp82ZQevIDNs4Rg+EiV2sgVUzR
 n72l/E0tD6zPiSGtUiZSS+4GmVLdb1MSyZNmFH2hHbvhz/sMFyuoQV0sMVlz2K5B
 dDKF4kqx2IbHMV65SWBoIPGqWi/el12umvcy1T76ZyP6UkpG809RS11IPZtExXtz
 Uo+1c/FRWHbIlbQId6TtZYIj74svxk84pW6m4cMfC0GawKGAeDERlpYfA==
X-ME-Sender: <xms:ggG5ZCIPP2RMap93rbYVbrXclEZQx_EytRjG6nqlpkx8o9Z8BOQLJw>
 <xme:ggG5ZKIZwA0Eav6j4EFiZKUwyEJVzDzPSx8wMKALGtzVshd_XSvkJ70JspgYJqfB3
 w6hvA9A3e0W6A-l2dw>
X-ME-Received: <xmr:ggG5ZCvOioaT9p8GG2_2D22HA9Wv2yaV7tN7x8Z_E-k0rympF7RqOKWjgp59GBpQyrpIufL07dsS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedtgddulecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhsucfl
 vghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtthgvrh
 hnpedtleduhfegleehleeltdejffefjedtleeuvdfgteevffegtedvveekheeiieekteen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehithhsse
 hirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:ggG5ZHbW25zKnXttkzXgvngr8IZcHooBUq_ubUeQRWIUHFO4O6_gyA>
 <xmx:ggG5ZJYYVJEbz76zf9kkHP9hq4YUOzaasXPlD7BY3eDHjosAuL7avw>
 <xmx:ggG5ZDDYE672SkIl81HI0WWFo-WtKxbMLZZdJlkFs_pz5QBRJFWIbg>
 <xmx:ggG5ZF5Qy03b4j_TSA7wi9W6fA2sC71feQiGCyJ9ne7PpqYaPzoGew>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Jul 2023 05:42:24 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH] hw/nvme: use stl/ldl pci dma api
Date: Thu, 20 Jul 2023 11:42:24 +0200
Message-ID: <20230720094223.27767-2-its@irrelevant.dk>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5522; i=k.jensen@samsung.com;
 h=from:subject; bh=WaaD+Z6IvozePlwrUH9QCk3pEINhkzCfpoXQTuYTQGs=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGS5AX9fYSbP38UvEsuP1aAZAXBFnlnQGRfyj
 gtE/n38QfelvYkBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJkuQF/AAoJEE3hrzFt
 Tw3pOdEH/jgfmiLbIIDxFc3vMhPdQzGH4PYeO19HB1fIazifrf2u5pPZf5MWANqxJV51T95cKKm
 Qw1G0AfB5dn+oP7q2NuV6yQNReG34dON+jDxBvukEDuAjzVe3PbIhHNA7i1UNtlz5vya8XEW5Mq
 b8AQ5xtktEblh9NHL/nGERmq6TCU/jyd5v+cDzdyJaclA30dAPiNh0WbJuqEhH1Sk6wl/M5+MY1
 p+p7lC6yxV0UzFnHmkeHRbXhy2SDnHQ/+7pEchmPXOU19e9RSjPJgF5UejF7XLLoVNhQVBDEMcP
 xYZR1DpxdybMoZwjcxJqxFLjyOmbQJ/M+9CJOZ9ZJXgIIldOHNwjjKek
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.25; envelope-from=its@irrelevant.dk;
 helo=wout2-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Use the stl/ldl pci dma api for writing/reading doorbells. This removes
the explicit endian conversions.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 42 +++++++++++++-----------------------------
 1 file changed, 13 insertions(+), 29 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index dadc2dc7da10..f2e5a2fa737b 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -1468,20 +1468,16 @@ static inline void nvme_blk_write(BlockBackend *blk, int64_t offset,
 
 static void nvme_update_cq_eventidx(const NvmeCQueue *cq)
 {
-    uint32_t v = cpu_to_le32(cq->head);
-
     trace_pci_nvme_update_cq_eventidx(cq->cqid, cq->head);
 
-    pci_dma_write(PCI_DEVICE(cq->ctrl), cq->ei_addr, &v, sizeof(v));
+    stl_le_pci_dma(PCI_DEVICE(cq->ctrl), cq->ei_addr, cq->head,
+                   MEMTXATTRS_UNSPECIFIED);
 }
 
 static void nvme_update_cq_head(NvmeCQueue *cq)
 {
-    uint32_t v;
-
-    pci_dma_read(PCI_DEVICE(cq->ctrl), cq->db_addr, &v, sizeof(v));
-
-    cq->head = le32_to_cpu(v);
+    ldl_le_pci_dma(PCI_DEVICE(cq->ctrl), cq->db_addr, &cq->head,
+                   MEMTXATTRS_UNSPECIFIED);
 
     trace_pci_nvme_update_cq_head(cq->cqid, cq->head);
 }
@@ -6801,7 +6797,6 @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, const NvmeRequest *req)
     PCIDevice *pci = PCI_DEVICE(n);
     uint64_t dbs_addr = le64_to_cpu(req->cmd.dptr.prp1);
     uint64_t eis_addr = le64_to_cpu(req->cmd.dptr.prp2);
-    uint32_t v;
     int i;
 
     /* Address should be page aligned */
@@ -6819,8 +6814,6 @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, const NvmeRequest *req)
         NvmeCQueue *cq = n->cq[i];
 
         if (sq) {
-            v = cpu_to_le32(sq->tail);
-
             /*
              * CAP.DSTRD is 0, so offset of ith sq db_addr is (i<<3)
              * nvme_process_db() uses this hard-coded way to calculate
@@ -6828,7 +6821,7 @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, const NvmeRequest *req)
              */
             sq->db_addr = dbs_addr + (i << 3);
             sq->ei_addr = eis_addr + (i << 3);
-            pci_dma_write(pci, sq->db_addr, &v, sizeof(sq->tail));
+            stl_le_pci_dma(pci, sq->db_addr, sq->tail, MEMTXATTRS_UNSPECIFIED);
 
             if (n->params.ioeventfd && sq->sqid != 0) {
                 if (!nvme_init_sq_ioeventfd(sq)) {
@@ -6838,12 +6831,10 @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, const NvmeRequest *req)
         }
 
         if (cq) {
-            v = cpu_to_le32(cq->head);
-
             /* CAP.DSTRD is 0, so offset of ith cq db_addr is (i<<3)+(1<<2) */
             cq->db_addr = dbs_addr + (i << 3) + (1 << 2);
             cq->ei_addr = eis_addr + (i << 3) + (1 << 2);
-            pci_dma_write(pci, cq->db_addr, &v, sizeof(cq->head));
+            stl_le_pci_dma(pci, cq->db_addr, cq->head, MEMTXATTRS_UNSPECIFIED);
 
             if (n->params.ioeventfd && cq->cqid != 0) {
                 if (!nvme_init_cq_ioeventfd(cq)) {
@@ -6974,20 +6965,16 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeRequest *req)
 
 static void nvme_update_sq_eventidx(const NvmeSQueue *sq)
 {
-    uint32_t v = cpu_to_le32(sq->tail);
-
     trace_pci_nvme_update_sq_eventidx(sq->sqid, sq->tail);
 
-    pci_dma_write(PCI_DEVICE(sq->ctrl), sq->ei_addr, &v, sizeof(v));
+    stl_le_pci_dma(PCI_DEVICE(sq->ctrl), sq->ei_addr, sq->tail,
+                   MEMTXATTRS_UNSPECIFIED);
 }
 
 static void nvme_update_sq_tail(NvmeSQueue *sq)
 {
-    uint32_t v;
-
-    pci_dma_read(PCI_DEVICE(sq->ctrl), sq->db_addr, &v, sizeof(v));
-
-    sq->tail = le32_to_cpu(v);
+    ldl_le_pci_dma(PCI_DEVICE(sq->ctrl), sq->db_addr, &sq->tail,
+                   MEMTXATTRS_UNSPECIFIED);
 
     trace_pci_nvme_update_sq_tail(sq->sqid, sq->tail);
 }
@@ -7592,7 +7579,7 @@ static uint64_t nvme_mmio_read(void *opaque, hwaddr addr, unsigned size)
 static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
 {
     PCIDevice *pci = PCI_DEVICE(n);
-    uint32_t qid, v;
+    uint32_t qid;
 
     if (unlikely(addr & ((1 << 2) - 1))) {
         NVME_GUEST_ERR(pci_nvme_ub_db_wr_misaligned,
@@ -7659,8 +7646,7 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
         start_sqs = nvme_cq_full(cq) ? 1 : 0;
         cq->head = new_head;
         if (!qid && n->dbbuf_enabled) {
-            v = cpu_to_le32(cq->head);
-            pci_dma_write(pci, cq->db_addr, &v, sizeof(cq->head));
+            stl_le_pci_dma(pci, cq->db_addr, cq->head, MEMTXATTRS_UNSPECIFIED);
         }
         if (start_sqs) {
             NvmeSQueue *sq;
@@ -7720,8 +7706,6 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
 
         sq->tail = new_tail;
         if (!qid && n->dbbuf_enabled) {
-            v = cpu_to_le32(sq->tail);
-
             /*
              * The spec states "the host shall also update the controller's
              * corresponding doorbell property to match the value of that entry
@@ -7735,7 +7719,7 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
              * including ones that run on Linux, are not updating Admin Queues,
              * so we can't trust reading it for an appropriate sq tail.
              */
-            pci_dma_write(pci, sq->db_addr, &v, sizeof(sq->tail));
+            stl_le_pci_dma(pci, sq->db_addr, sq->tail, MEMTXATTRS_UNSPECIFIED);
         }
 
         qemu_bh_schedule(sq->bh);
-- 
2.41.0


