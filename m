Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AADF758F32
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 09:38:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM1jT-000471-1t; Wed, 19 Jul 2023 03:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qM1jP-00045u-Mt; Wed, 19 Jul 2023 03:36:19 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qM1jN-0005Q9-PS; Wed, 19 Jul 2023 03:36:19 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id B1DD13200929;
 Wed, 19 Jul 2023 03:36:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Wed, 19 Jul 2023 03:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to;
 s=fm2; t=1689752174; x=1689838574; bh=0Ey7Xt/fVOaLXgPSQ3lKxpQcW
 1sEfvcbitWvyfP36+Q=; b=DJPBy9JTsCmGJ92JX7r/ov+sUUkEbv4yMqNeo9nph
 IfAGKaRRQc1bGAgRVipVqvBM/UW8G+KPJxLdBD3ThWOEpN0xTQmZu+LqpKjkJY1l
 NOY6aVs24+pR96eIugQbRbyPDGAN/AO4vrkYG29hZCA6rlVMuIZuEmf2YSoF1mtP
 r5HR+xsrYh8h+Qy1gSvuuQ1o4GjQGdUfSmhTMgXeKcRl8GWZraI3lrSQFGaVdktS
 am0hE7WJ/fUETnrp6vNOJBLUZuu7Mpjl8FHpbwxRkdjuo3msW8Cx5xVQhMlCB/z3
 NE3RbWoG0SscyPB81BFEkpq4SKSMKMCtFuSk7q6gplzZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1689752174; x=1689838574; bh=0Ey7Xt/fVOaLXgPSQ3lKxpQcW1sEfvcbitW
 vyfP36+Q=; b=iroPjDq/0+2uL0M9sTPr9ZGC5CJBG1EJOmR3K4sKxY4I7fNE+5Z
 XITqE5Ith6p06Xn+jk7mag+b+HBMEgxI6JFfsLhc5giuM+w1/s5d0HBW9wTRY5oE
 Bt1zvoFwqJdpgOEEyJ+iRmke1Tvf0K8DMpwbbqtnxX54fq7EM3o4wUyR/EJp57N5
 9zZaDoTeHXeb6pc0SVoM/Mbg8bexd7JtguYLaBSA6sqmEyi3umtSjZfog6vsC+Ls
 Jpsh5Xr0Dbc5BChb+4u4bmFHhW5hRyDVhNchGPPKq0BUFGlX2bU+k2aztbN7CZuJ
 7wqGfJF8YxmOFuw/cH7Jq6tQlec4ldcRACA==
X-ME-Sender: <xms:bpK3ZMiRzHuvB8lCEHoCGJBkDRWXPO0BzYdjJO_vg3QaBjcSYAR8Ow>
 <xme:bpK3ZFDeaZ1O9Mjy6kpT30d14EvVCki28qNajg4GbEe_tSr9v1nNFn2nUJqS8as8D
 DR_jUSgLcVb-Oq0MVI>
X-ME-Received: <xmr:bpK3ZEHg72xIk8CwKqqm8ji_1VZ3r5_N-d4D44-xIVMMCJQ6i1a2vhNGOFX4og20irzEHjyeaws8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrgeehgdduvddtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefmlhgr
 uhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrg
 htthgvrhhnpeevvdegieetieejjeejudeljefhkeevjeegveduueekvddvtdfgveeuteeh
 geetveenucffohhmrghinhepghhithhlrggsrdgtohhmnecuvehluhhsthgvrhfuihiivg
 eptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgu
 kh
X-ME-Proxy: <xmx:bpK3ZNRNbESWZ5xnK3Hk3r1XBGFA_Sn4QjFsToPR986mos-VkcpoCA>
 <xmx:bpK3ZJxfvUPBEi3tZuDsZ1lfLq7cDBgxE67nFI-i3xwWL9-swNbNzg>
 <xmx:bpK3ZL55PuhyupRhI7ITDYhGCiwg40gZdaW90PXr4qSgjbSOCzkNsg>
 <xmx:bpK3ZMrOmfkGyrsuYpVJjv-4TsB_refLKL60xMJU7lJyTqeMWtBJJA>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Jul 2023 03:36:12 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 1/1] hw/nvme: fix endianness issue for shadow doorbells
Date: Wed, 19 Jul 2023 09:36:07 +0200
Message-ID: <20230719073605.98222-4-its@irrelevant.dk>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719073605.98222-3-its@irrelevant.dk>
References: <20230719073605.98222-3-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4384; i=k.jensen@samsung.com;
 h=from:subject; bh=9IUIeoiXHPaJVS+2v/ZI0RVKRAKPNwYuUGiTInjaOXc=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGS3kmW8JN4x3g1eSClcVlreehsR7tk8avpuw
 JVG2wSWubKz2okBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJkt5JlAAoJEE3hrzFt
 Tw3pOl0H/imRwH31XdaXNCrn5pzQTWjpc49TGUquZ437Z4XFXSLbDh0drKa8HvU5T0GuSBBB7d5
 EvTAcY42Ni7gm4MU+vKCjxMEgtmy07iKPl1ds6ITOW/vRg1v39ZgsdwTjniXzZ2U46gr3K7eV6C
 RdeD5M/GlSBn/YN9WB1915M1rXjELM1VtW1b0HQZRFVG2R+6JBGy0Bifzz3pwK/U1g88zCw/rVn
 3/EDmTWvFtIvVk3B72iYzZ++44xS37duxWD5OcDr25Mvy+RAfFGlwyh01pSHpMBEKBwCrZyySoq
 YQxm2cw1sFZw0qULoAbxnXIQMPkV+CXFriwf9lo4YrySj70O2ehLOqyl
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.19; envelope-from=its@irrelevant.dk;
 helo=wout3-smtp.messagingengine.com
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

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1765
Fixes: 3f7fe8de3d49 ("hw/nvme: Implement shadow doorbell buffer support")
Cc: qemu-stable@nongnu.org
Reported-by: Thomas Huth <thuth@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


