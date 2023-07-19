Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C636759D32
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 20:23:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMBoS-0001Pt-7j; Wed, 19 Jul 2023 14:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qMBoP-0001Ow-Rt; Wed, 19 Jul 2023 14:22:10 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qMBoL-0002mS-Va; Wed, 19 Jul 2023 14:22:09 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 364CF5C00D0;
 Wed, 19 Jul 2023 14:22:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Wed, 19 Jul 2023 14:22:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:sender
 :subject:subject:to:to; s=fm2; t=1689790921; x=1689877321; bh=UT
 vE79+coNlITXdMzqCP0LqEJhZ3o8pM1gaCxPzEnIs=; b=KxepFlYS7q72Nd6+pD
 w7MXQexZXH6WToMq/rKS5BvWk0UsabbpvrJ41Ddv4C196Bbif5Nk8xxVXgUsfxPI
 +Al6Cke/u3/g0grwE43V57iZzBTF+CbAwxl/Q+RJdXrbuL8sEFzuuNP/lm8Wnwjn
 33o3z50p+ZwJA/Q1iQgWLbzP2HXTXVIsp25EHKkwjMhyyQoBDfoeYYkAkR8ubEk4
 UfhkO0/Hf2RKr/E/vATqhTsHx8Y65NlkAPUGiVXmo0A4vlrg4YN6qfYYpmr/WgjQ
 +hRo1riz2CVp4h91fk2xptEi8GT5nGzFaUBJvK7tS3sAchZFoNbYpc8aaGqwOW4C
 sz+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1689790921; x=1689877321; bh=UTvE79+coNlIT
 XdMzqCP0LqEJhZ3o8pM1gaCxPzEnIs=; b=3GwtKoakFiIphDdF2dH1bnqNt74OA
 HkybDe4TvgGdXgkXDmPbeAHxEFBYAIbUs7Cwy/8mhq5UNFPuiFMr+CoKnQrkcr67
 zZC5IvM+x7PeDeQYBF31xA4+S225f9hBxHEyJ25diwSCDp6wYtT1MbkWDJDQx7wL
 crpk6IEDslrWt1Xt2mV06qEpClcGIOwMVwXGTNZC5GwLODKcIlQFxcgt8WE6H22k
 0c/cHfZfs8U+s/zQn9rglNg9H+KvC2NKH2OUZewRPLCtSnIRMv6OZO/GLJvJ2nmo
 jhUTAaSx6//Lo/5sWtj42t1H/UJNykiVQBeyx92+HaHX7rzYzHP130OFw==
X-ME-Sender: <xms:yCm4ZNPe8IpPhvx8x1Zi84UZ5w-uEIceVWzXkIwo3LQWNu55t7OA5w>
 <xme:yCm4ZP-NOj1iiFFPkkJx6lItx4lHi3FtE-d0UYG9YBaSPvXHzcOx0myWHsCbSCGlV
 KjclrlZYFlVtIRL6F8>
X-ME-Received: <xmr:yCm4ZMTn9a07wyl6GQngTWHvGhDuSB6mkw75LqOrpyEqQ9ONz99Y6ekiSJQfzUw27aZBSRoJRjI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrgeekgddutdejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjeevheevhffhvdegveetjeevgfevgeeuueehffeuvedvjeejjeduheeiueffkefh
 necuffhomhgrihhnpehgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:yCm4ZJsygeW64dLu8qmg2D0NM3ndNWNbem_wm1j39Nxhb_z5FqTBwA>
 <xmx:yCm4ZFeSoRil89C70_sg6ToV8MrRdNLbVH6-QkuBmVOPVUNt3f6k-A>
 <xmx:yCm4ZF0VYIHTPUzSnfrB1pl96eySXd1VzoNMUC_00EzK7CAhOqugfw>
 <xmx:ySm4ZJ7pwBkvOW6T-DfSpMhudQMrahjJESOSaOP6zVO_1Sj4uQ3QqA>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Jul 2023 14:21:59 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH for-8.1] hw/nvme: fix compliance issue wrt. iosqes/iocqes
Date: Wed, 19 Jul 2023 20:21:58 +0200
Message-ID: <20230719182157.18545-2-its@irrelevant.dk>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6869; i=k.jensen@samsung.com;
 h=from:subject; bh=98MeWUj3WPRznMsiQSMPsNjn3urU4o+2cLj2l+oVWlM=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGS4KcXP8R63IzFn4FKzE4PkpY7SRgUP6TUi5
 sZ3/IECVDnW7YkBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJkuCnFAAoJEE3hrzFt
 Tw3pND8H/2znyYy0BrYosej8M0mfMZV5kBsxu/tGQK31Qlv+VwxTX/P4+LHFEborSXWY8JHb5H6
 GJvsRgcGTGFSF0hC21HjC8WVIHmX1haVSAIn4VaHI2Ta9oOevLdQLbtpMjkj7SUkE4LoOVOWoKv
 1abHv0uOnv6VCYmxh9KMiYNlfoAIE/usmDkz4FY1L/HQ3Qoj1ad45wvqwsa6aZKriqRGuPDjQr9
 wogQ9ktQ50hn4wuAMDb4+knj4b/MBd+6DfvF1FL9aoSG3adu3L9+QHX6VXUJ/daOn1vF93BFzE0
 5u0WFnpcHJXhbo7vHS6au5HibUzmojAp+W+3iW7YaNniRcvniJ+8wa6L
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

As of prior to this patch, the controller checks the value of CC.IOCQES
and CC.IOSQES prior to enabling the controller. As reported by Ben in
GitLab issue #1691, this is not spec compliant. The controller should
only check these values when queues are created.

This patch moves these checks to nvme_create_cq(). We do not need to
check it in nvme_create_sq() since that will error out if the completion
queue is not already created.

Also, since the controlle exclusively supports SQEs of size 64 bytes and
CQEs of size 16 bytes, hard code that.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1691
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c       | 46 ++++++++++++--------------------------------
 hw/nvme/nvme.h       |  9 +++++++--
 hw/nvme/trace-events |  1 +
 3 files changed, 20 insertions(+), 36 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 8e8e870b9a80..414e9ea60e05 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -1511,7 +1511,7 @@ static void nvme_post_cqes(void *opaque)
         req->cqe.status = cpu_to_le16((req->status << 1) | cq->phase);
         req->cqe.sq_id = cpu_to_le16(sq->sqid);
         req->cqe.sq_head = cpu_to_le16(sq->head);
-        addr = cq->dma_addr + cq->tail * n->cqe_size;
+        addr = cq->dma_addr + (cq->tail << NVME_CQES);
         ret = pci_dma_write(PCI_DEVICE(n), addr, (void *)&req->cqe,
                             sizeof(req->cqe));
         if (ret) {
@@ -5299,10 +5299,18 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeRequest *req)
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
@@ -7003,7 +7011,7 @@ static void nvme_process_sq(void *opaque)
     }
 
     while (!(nvme_sq_empty(sq) || QTAILQ_EMPTY(&sq->req_list))) {
-        addr = sq->dma_addr + sq->head * n->sqe_size;
+        addr = sq->dma_addr + (sq->head << NVME_SQES);
         if (nvme_addr_read(n, addr, (void *)&cmd, sizeof(cmd))) {
             trace_pci_nvme_err_addr_read(addr);
             trace_pci_nvme_err_cfs();
@@ -7228,34 +7236,6 @@ static int nvme_start_ctrl(NvmeCtrl *n)
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
@@ -7268,8 +7248,6 @@ static int nvme_start_ctrl(NvmeCtrl *n)
     n->page_bits = page_bits;
     n->page_size = page_size;
     n->max_prp_ents = n->page_size / sizeof(uint64_t);
-    n->cqe_size = 1 << NVME_CC_IOCQES(cc);
-    n->sqe_size = 1 << NVME_CC_IOSQES(cc);
     nvme_init_cq(&n->admin_cq, n, acq, 0, 0, NVME_AQA_ACQS(aqa) + 1, 1);
     nvme_init_sq(&n->admin_sq, n, asq, 0, 0, NVME_AQA_ASQS(aqa) + 1);
 
@@ -8238,8 +8216,8 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
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
index 209e8f5b4c08..5f2ae7b28b9c 100644
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
index 9afddf3b951c..3a67680c6ad1 100644
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
2.41.0


