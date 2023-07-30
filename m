Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B5F768778
	for <lists+qemu-devel@lfdr.de>; Sun, 30 Jul 2023 21:31:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQC78-00063e-1G; Sun, 30 Jul 2023 15:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qQC70-00061o-SY; Sun, 30 Jul 2023 15:29:54 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qQC6y-0005LL-8R; Sun, 30 Jul 2023 15:29:54 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 393335C00CD;
 Sun, 30 Jul 2023 15:29:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Sun, 30 Jul 2023 15:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to;
 s=fm2; t=1690745390; x=1690831790; bh=/+gm1jpQzmpRwUTZBt0VB+2Fn
 Q5MdX0fUU6p2A3wWKk=; b=fc/L+/dFqjLV/bKTrXRrVYZt76100FDWu2QI5okPx
 ZFgBgfkO4onm5IlSFnMCyWCiYjlBN4X+oMkAsoXnOkIxqejE72fInTg2BPiWHjHD
 SU+ieYtJNb3K3fAwVDAg+WkQ/XoRdRyoWZXz+TyRPF706kXL+2mxQ5j35aUZXUwi
 dsV5PyAlojpEs2CI6g6xx3Mz2GJzP2TxtI3JTa1KxycyTRva+dXO9AWuufsOrw06
 3CKj2oQg85e+OoLmN9WwR2oL8W54CgUMEg2gtw9uT2PInqP5Fd58QPWzhYPI9ZRM
 wcg5efg8i982SaVUGyGBjI3CAZ0VxRyTkHMwuE04OgxJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1690745390; x=1690831790; bh=/+gm1jpQzmpRwUTZBt0VB+2FnQ5MdX0fUU6
 p2A3wWKk=; b=vgaTUslJXy0JYFwrMmC0elPOYnHtI7TaWEO7CGVL1BqldHlNrxt
 rfVYCY5WZlOYWUIj4PgwKr6Dcah/iTVl1G3tirR+mXnsKwCpuN0uPM6Qi9NjVm2x
 tpN/eEE79FPfC9VyShbL0++xajvEdT5j489OO9sbPF4Pam2tbRC756aYmWxyXWT2
 EKeV2Em+qPcVD9LZZHd2e24B2mVnL4Fot3L1/aH02fEgpn24ehLUcXhwC21wnUUF
 Y38xkh5LQW/4Mw0iutUzPJU1pahlC7wWKjgNJ28eQ8i5p8jZJwQxtTHPgYxB/uNN
 h2yMtG8CQllPwGGO4Iky7cjPaiIDSQdjEnQ==
X-ME-Sender: <xms:LbrGZNRjwQPyVQnNmovsuFhznWmQ6EodoVXBatNJU-_DPa1JHQW8fg>
 <xme:LbrGZGwVboAkDtocfkSN4tjUB3avE9J04wqXP-XO5Lpmw_GdKQmtLQtQAyC6DokZh
 N1ToKI0mksKb4PUq9k>
X-ME-Received: <xmr:LbrGZC1_DvW9DAiOpfqQv_k-Ihd-U4ngnsaT71dl-KN9gQHf86Uun3DYzWHnsHbqBaVrgE0uBPY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjedugddufeeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefmlhgr
 uhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrg
 htthgvrhhnpeefvedtueetueduffevgffgtdeftdeuleffhfeigeffkeegfeejfeffteej
 iefhvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:LbrGZFAAzuUkOs032mReUeaHEz8pUaf_vrzM6Eg7NAurU6DYIc7tCA>
 <xmx:LbrGZGjGAdMMrUxL7EeBxXFVEAZXNc2KNqXKkbtPz6aL-ioFfdqhIw>
 <xmx:LbrGZJqGyQg4KIPVnbuy_TODvsI_OjjxIICPf4tAng0_HSOfAirvog>
 <xmx:LrrGZNpzlsqjagdpwRyjeCKVvJktpXZIPm5grRCxDnWvFC99HxE-TQ>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 30 Jul 2023 15:29:47 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Klaus Jensen <k.jensen@samsung.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 1/1] hw/nvme: use stl/ldl pci dma api
Date: Sun, 30 Jul 2023 21:29:43 +0200
Message-ID: <20230730192941.44019-4-its@irrelevant.dk>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230730192941.44019-3-its@irrelevant.dk>
References: <20230730192941.44019-3-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5721; i=k.jensen@samsung.com;
 h=from:subject; bh=Ebi/mRDrEwrtKZH0NvAsifltlcphOQZ96fSma6ur0Wc=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGTGuiU1saQKvJtLr3RXQ3vbRR9Orq8QSTkxz
 ndA62NxK8WuL4kBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJkxrolAAoJEE3hrzFt
 Tw3pnocH+gN7FnM4v2N0SjD4+QK9VLYicFKKRhNDfaEl8ISZ+wcg5lnrrWfzWWo2IiuLKou46Rp
 g0+FMXrUh9VRC2XVXEWKLkHL25lfs6xONnzJZ7PWdH3119/LEogRbEC8VoUySnhfM0CdmpfrPwJ
 d5cectDyrzwFF9ExNCO8APx9h1dKQ/qgCvVyHwyXU8o9mpSEmyLJAdgsfikuRnBRx4253YlxZ37
 WSW4sMacEaSyRk9+Nhe9KAQ+oDzx5VjZkJe7LP/1t6X2WEfT/+5eRvdNnCGVDT0Ich1k5F1hrro
 Uej8zUFYJzPYtSWTlZyH3QdW/h26uoTxDeoIhbFus9+IrG6ptIOxd61S
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.29; envelope-from=its@irrelevant.dk;
 helo=out5-smtp.messagingengine.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
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


