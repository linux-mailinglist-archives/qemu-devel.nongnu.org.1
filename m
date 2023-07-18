Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD7075795B
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 12:36:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLi3G-00009H-Dh; Tue, 18 Jul 2023 06:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qLi39-00005e-AE; Tue, 18 Jul 2023 06:35:24 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qLi35-0008Pp-TZ; Tue, 18 Jul 2023 06:35:23 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id E83E45C00EB;
 Tue, 18 Jul 2023 06:35:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Tue, 18 Jul 2023 06:35:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:sender
 :subject:subject:to:to; s=fm2; t=1689676515; x=1689762915; bh=TG
 DSfLIpAEQULuSW+Zah99oyYcaEYBQVIpO8VZeaHBE=; b=FcVWsgCkn7qln7+8pM
 33RdKO+Vgj5ckU36YzzNBWXsC+KuSWXRTb4G3eMsbkGSeEx93g55o9zOV2bALTSI
 yJMFQzw0yEvvMfxIhkOfkFO8TJ+28zAcNG8/5PIuQDu7VHjF0tOv7neHTZ97Taog
 AgN2Pkmfm3lxVGG4804KL8He2m4A27kqblj3auEEQZlc5wOEIx5+RjEMLmUSTTi1
 zGi4C78P7LaTdQ3eV7iSDLUgA5nQgXMo3JGS9Z2E8gJKngPO9umRnzGBH058OevO
 zRqpwdic7hR0Dh78Elji3TL+lWSMPuKzII69/RtIQRkle54ExHuEtp7MwwMpQfJG
 V/mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1689676515; x=1689762915; bh=TGDSfLIpAEQUL
 uSW+Zah99oyYcaEYBQVIpO8VZeaHBE=; b=X6wRUdSVZ/MYoXLsYNpo8OST7XnuN
 zYDfyrPZSZw43r95L8HEPtVxu9o+wczXpj9P9OqcL1o6WMG4j8m57xD/MBxUyLjv
 xEryAIrDaSrKARq2PFo3EeewRcJWwKNZQrf9M60zFRuCVaMExGfPZKTpCjzHtIqh
 6oNzmt4Z5WH7jk2rtOs8WR1GP82orcfDU28U8bgSxAEGrDHuMrLD5aoRH20t+8dG
 3ysbidP7JotS9e28LXrTRBgIXwQ2bc5sxdH9DQhIilwCdUFwuI7/R0QOEH5annJM
 mige8AKheh2ebct/knbNtaaY9zNmF5QhZm1P6SqlsEEPK1pm9RKcdsIJQ==
X-ME-Sender: <xms:4mq2ZEWaFIDm9gKm-ypM_ulv2l-QvAi-3BfH1kNGrnJ3Ty8ysBCmOQ>
 <xme:4mq2ZInJ8WA8JqLeR24Qs-4xAx0eV6r3pRRD91S_-P8G9aqjWwm2BKrug3UcmBV1N
 P_XgQEiv6hNfROVGVI>
X-ME-Received: <xmr:4mq2ZIY9sBEcd0R1l7Mv8Tsi1F-9j-wYkvMiqRQTVzurr-aa0hfTdol2HWHGV6GORKBO2dk5SnOF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrgeeggddvlecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhsucfl
 vghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtthgvrh
 hnpedtleduhfegleehleeltdejffefjedtleeuvdfgteevffegtedvveekheeiieekteen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehithhsse
 hirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:4mq2ZDUCvA-CYDft0LT3M5W9ejwE6VqHxr0RQnhrJWSra3or43U5kw>
 <xmx:4mq2ZOlSKNg6WFB9UNuMTZYIL6RkLHvktgrRYLRmcJZbF-FxweAaSw>
 <xmx:4mq2ZIc_W0HmX7zoNhZaz_eSHDuJENzATiVTgpMPMMg9lt7WNEe6Xg>
 <xmx:42q2ZMYaISFKgCYRXzfrFz3GP1xS63sUB1BaVkxslo2bmfb4b2QPkg>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Jul 2023 06:35:13 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH] hw/nvme: fix endianness issue for shadow doorbells
Date: Tue, 18 Jul 2023 12:35:12 +0200
Message-ID: <20230718103511.53767-2-its@irrelevant.dk>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4151; i=k.jensen@samsung.com;
 h=from:subject; bh=JLX0T/UUDiTrLEHKzSUkx4ASSjCLvhLDa8u8tkPD5Z0=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGS2at+IwfWnWvd4aK+tOQQHay0gg+2TikFH/
 82Zpkq84KbwOokBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJktmrfAAoJEE3hrzFt
 Tw3p3yUIAJDo/4ckkiKurJNCd5y63jRxMY8h4GAK67YlZnhHcpRqTFqP0uUh6sPj5AsbwgYmQr7
 8Lw//gYSR15v5quuqOITD+FuaLQeXTPwc1yFQWGSfa8AWG9SAcfmlJ+K+Zmiy/l5Pdi5wNPTtbp
 XHouYNVISbrlOOq90/4S/hCCZiWbg2wEnAJamiJJ21VbqgFWW6lvhnMW36GICCXTfvsK7Uw/Pt2
 tFXVoaIiOY+GJc8gKJ4y5g7O+eMtJjFbV8rVVseun21p8e9Z1ZOLGB4nsvvwsDO+QFBQpONOGbU
 qIwQe7vH0Q2NQ2dRNeIvqCy8pBoINWAVXrIV7hU+64tpe390xD+Fa67e
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.29; envelope-from=its@irrelevant.dk;
 helo=out5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

In commit 2fda0726e514 ("hw/nvme: fix missing endian conversions for
doorbell buffers"), we fixed shadow doorbells for big-endian guests
running on little endian hosts. But I did not fix little-endian guests
on big-endian hosts. Fix this.

Solves issue #1765.

Fixes: 3f7fe8de3d49 ("hw/nvme: Implement shadow doorbell buffer support")
Cc: qemu-stable@nongnu.org
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 8e8e870b9a80..dadc2dc7da10 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -6801,6 +6801,7 @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, const NvmeRequest *req)
     PCIDevice *pci = PCI_DEVICE(n);
     uint64_t dbs_addr = le64_to_cpu(req->cmd.dptr.prp1);
     uint64_t eis_addr = le64_to_cpu(req->cmd.dptr.prp2);
+    uint32_t v;
     int i;
 
     /* Address should be page aligned */
@@ -6818,6 +6819,8 @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, const NvmeRequest *req)
         NvmeCQueue *cq = n->cq[i];
 
         if (sq) {
+            v = cpu_to_le32(sq->tail);
+
             /*
              * CAP.DSTRD is 0, so offset of ith sq db_addr is (i<<3)
              * nvme_process_db() uses this hard-coded way to calculate
@@ -6825,7 +6828,7 @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, const NvmeRequest *req)
              */
             sq->db_addr = dbs_addr + (i << 3);
             sq->ei_addr = eis_addr + (i << 3);
-            pci_dma_write(pci, sq->db_addr, &sq->tail, sizeof(sq->tail));
+            pci_dma_write(pci, sq->db_addr, &v, sizeof(sq->tail));
 
             if (n->params.ioeventfd && sq->sqid != 0) {
                 if (!nvme_init_sq_ioeventfd(sq)) {
@@ -6835,10 +6838,12 @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, const NvmeRequest *req)
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
@@ -7587,7 +7592,7 @@ static uint64_t nvme_mmio_read(void *opaque, hwaddr addr, unsigned size)
 static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
 {
     PCIDevice *pci = PCI_DEVICE(n);
-    uint32_t qid;
+    uint32_t qid, v;
 
     if (unlikely(addr & ((1 << 2) - 1))) {
         NVME_GUEST_ERR(pci_nvme_ub_db_wr_misaligned,
@@ -7654,7 +7659,8 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
         start_sqs = nvme_cq_full(cq) ? 1 : 0;
         cq->head = new_head;
         if (!qid && n->dbbuf_enabled) {
-            pci_dma_write(pci, cq->db_addr, &cq->head, sizeof(cq->head));
+            v = cpu_to_le32(cq->head);
+            pci_dma_write(pci, cq->db_addr, &v, sizeof(cq->head));
         }
         if (start_sqs) {
             NvmeSQueue *sq;
@@ -7714,6 +7720,8 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
 
         sq->tail = new_tail;
         if (!qid && n->dbbuf_enabled) {
+            v = cpu_to_le32(sq->tail);
+
             /*
              * The spec states "the host shall also update the controller's
              * corresponding doorbell property to match the value of that entry
@@ -7727,7 +7735,7 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
              * including ones that run on Linux, are not updating Admin Queues,
              * so we can't trust reading it for an appropriate sq tail.
              */
-            pci_dma_write(pci, sq->db_addr, &sq->tail, sizeof(sq->tail));
+            pci_dma_write(pci, sq->db_addr, &v, sizeof(sq->tail));
         }
 
         qemu_bh_schedule(sq->bh);
-- 
2.41.0


