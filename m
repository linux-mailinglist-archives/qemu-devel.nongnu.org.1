Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD6D772324
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 13:55:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSyoU-0001Y2-VM; Mon, 07 Aug 2023 07:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qSyoS-0001XA-MO; Mon, 07 Aug 2023 07:54:16 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qSyoQ-0007uR-RD; Mon, 07 Aug 2023 07:54:16 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 7176E3200912;
 Mon,  7 Aug 2023 07:54:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Mon, 07 Aug 2023 07:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm2; t=1691409251; x=
 1691495651; bh=krEYUYUCrma2v+1MyOa2Dc134OYURUJiu4ofsblS17g=; b=N
 XzQp+OdxZC4xtg7y8QlFa3xYQgIF0/u2S9njMD28FmM66nzJ8aZzuVJ/j4547Nqr
 u1wl2YBpd9fby1p2thuV81leCnQbNRxmpYO5d2bkDWIbeBgJyRXVsRmYZIsuVpPX
 21XCJhzyyhoMlDMEEavHavrlY64e0Q2k+I4fSY9CTxAHlI6q97cd/Z72S2AC0wU5
 O39dDHGdS6GZUfOG40DJttWUrltC0WjLgVa/9l88vwjLGMobYOQA0lXd3sq2V+3B
 zbnVS8PNCTdPWzBzbk5WPBeI2/489bWy0GK/GT9809pWtjdE841qRKxkptyor1ar
 K4IfbkjzHGd/cxNMPPRow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1691409251; x=
 1691495651; bh=krEYUYUCrma2v+1MyOa2Dc134OYURUJiu4ofsblS17g=; b=e
 4MqF8Ww6JcY9vog5FUOQeGQMzkOZl75BTEx21MuyW2/9EoW4ZACMOssyW+ABuybp
 TcWCzEv5HF+kQ0/yhi39cs4M3BUlGP1kSbblfy4+0O0on0IzErXy+utEqdsuIu5c
 2zAPOL+4F8ro6aqnbmYJDAn9WaojOI8ty93/J+qIAEIukdY1saw1OoF4lEBQ0Xxe
 9XOV6eibroGEhVWHmMV1QHo92dGnGU3EAKSOkMWeAktmMVT/lC1SCUU5YmvhFmPD
 FYL4jhUWQrhJ4W/YqxpPmn+LRUkErWzWYTdyQNcYJ3jiNsyJV/CLMwCMqOmGbS6X
 dGo5MWpSYHhNMpaQ0TL9g==
X-ME-Sender: <xms:Y9vQZIFUfURhOw3TkjxGUJFTsCgd2x21_-2I4AAyZ0DB0yrSqajjJg>
 <xme:Y9vQZBX9KtB58qjX7-o9usYBRgNQzZqXjrj8VYuSdmfbVbE36LEoTa8W_LXszHBpK
 1ohVJcDeCVW6piCWTc>
X-ME-Received: <xmr:Y9vQZCL4ar4983cZW6uNftEF1lXhOHUHJLq5z6_0jBr5CHMIHdsDYWJQZfAaBxWBQ39c0gmM5bfcYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrledtgdeghecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeefheetgeehffefgeekgffhgeeijeekveffhfejveefkeduieeiveehteeludej
 udenucffohhmrghinhepghhithhlrggsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
 enucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:Y9vQZKGeta5klpMMHU0sDZL3laC6O5UnPSG1axvUpnicRbtDK_3k3A>
 <xmx:Y9vQZOX0iKbs7h-G8kR7c2yQh8gyGHpE3V4cTGeFIxAnpAdJ2B9G4w>
 <xmx:Y9vQZNOfWM6zXJUF_i4oAGGjUvXmRL-XlJpGEF7pufFDG-aLGqX6XQ>
 <xmx:Y9vQZKSpYyVr3qix224J2ArApqoQRHp9vdFQhbwc9O89PY7Gg4rU_w>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Aug 2023 07:54:10 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Klaus Jensen <its@irrelevant.dk>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 2/2] hw/nvme: fix compliance issue wrt. iosqes/iocqes
Date: Mon,  7 Aug 2023 13:54:02 +0200
Message-ID: <20230807115359.123-6-its@irrelevant.dk>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807115359.123-4-its@irrelevant.dk>
References: <20230807115359.123-4-its@irrelevant.dk>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6870; i=k.jensen@samsung.com;
 h=from:subject; bh=FsubvJ+HP595O7KOeC9stZh/Kjcdnop2L3p03s4C6SU=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGTQ21iz1SOGOK4AHOqwLYOr1rnJiHdptIs0a
 sD1zBMOX1fWRokBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJk0NtYAAoJEE3hrzFt
 Tw3pA0AH/j7C+OiVj2meiA8Cd9Sj/3tCtQHPPTU3wCYpIt61fb4P1VvHsNUgtLg2xicWpXmdfw5
 KtUjYX3SZrYxADtj5fDEy8x5hIB2hn1xi/dmcAnZ3lY62K3UwYDoaF+p5hZZUdcLpirqrVmgHTu
 OVsOfN0kYC+A1FvPjNS8TyyyDbNXi65brM6sKjy4SbS3RwL4WwDbIacD/wdPpR4ZoACLWnNZoP1
 tUu3gmPq29Usq2Q57SahS5ewLguoRNjBB2uPndhnpTCmPWWfxzBQIgE1LnQyL/JV5AtrOIMrLdY
 fJYw9hH11/3XdxIWTHTP9irX5dHfZxgGOR9Wua2s+//u4zlOFs/Ooa/J
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
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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
---
 hw/nvme/ctrl.c       | 46 ++++++++++++--------------------------------
 hw/nvme/nvme.h       |  9 +++++++--
 hw/nvme/trace-events |  1 +
 3 files changed, 20 insertions(+), 36 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index e9b5a55811b8..d217ae91b506 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -1507,7 +1507,7 @@ static void nvme_post_cqes(void *opaque)
         req->cqe.status = cpu_to_le16((req->status << 1) | cq->phase);
         req->cqe.sq_id = cpu_to_le16(sq->sqid);
         req->cqe.sq_head = cpu_to_le16(sq->head);
-        addr = cq->dma_addr + cq->tail * n->cqe_size;
+        addr = cq->dma_addr + (cq->tail << NVME_CQES);
         ret = pci_dma_write(PCI_DEVICE(n), addr, (void *)&req->cqe,
                             sizeof(req->cqe));
         if (ret) {
@@ -5300,10 +5300,18 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeRequest *req)
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
@@ -7000,7 +7008,7 @@ static void nvme_process_sq(void *opaque)
     }
 
     while (!(nvme_sq_empty(sq) || QTAILQ_EMPTY(&sq->req_list))) {
-        addr = sq->dma_addr + sq->head * n->sqe_size;
+        addr = sq->dma_addr + (sq->head << NVME_SQES);
         if (nvme_addr_read(n, addr, (void *)&cmd, sizeof(cmd))) {
             trace_pci_nvme_err_addr_read(addr);
             trace_pci_nvme_err_cfs();
@@ -7225,34 +7233,6 @@ static int nvme_start_ctrl(NvmeCtrl *n)
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
@@ -7265,8 +7245,6 @@ static int nvme_start_ctrl(NvmeCtrl *n)
     n->page_bits = page_bits;
     n->page_size = page_size;
     n->max_prp_ents = n->page_size / sizeof(uint64_t);
-    n->cqe_size = 1 << NVME_CC_IOCQES(cc);
-    n->sqe_size = 1 << NVME_CC_IOSQES(cc);
     nvme_init_cq(&n->admin_cq, n, acq, 0, 0, NVME_AQA_ACQS(aqa) + 1, 1);
     nvme_init_sq(&n->admin_sq, n, asq, 0, 0, NVME_AQA_ASQS(aqa) + 1);
 
@@ -8235,8 +8213,8 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
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


