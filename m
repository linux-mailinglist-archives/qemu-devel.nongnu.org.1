Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DA3773AED
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 17:16:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTORh-0008L2-IS; Tue, 08 Aug 2023 11:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qTORe-0008Jl-Tt; Tue, 08 Aug 2023 11:16:27 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qTORd-0000oS-4I; Tue, 08 Aug 2023 11:16:26 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.west.internal (Postfix) with ESMTP id 8640C3200312;
 Tue,  8 Aug 2023 11:16:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Tue, 08 Aug 2023 11:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm2; t=1691507782; x=
 1691594182; bh=rx1eiDCVgW8lKg4tPT9pJHpMKFAyLXbF9hzf+QCdfG4=; b=V
 T66vm3jrwdvqpl0LJ2mJuWSaz21PaR9JO/eclzSKnDaxB0iZHy+1vgRwUYzP0CnM
 r25ACoRtEyUMm8s6IOpq7scrKiAWB+xB80vQZ6twYxnLiR5keDgadG+rIO3tUK5V
 6b3ivK/0K55Px4YsCNMtzRTZRcfH53rR0eaC+KWliUVx2XOwu3VqzVxmi7LZeD3H
 rYKu5G4OjfGDofSQXjv5qMFAWdy1Xv+iIB5KRlAX2yixNsWKA9SwBSJj9UdLDakc
 Rgk6ooyMAej77Az5EwrVjMw5EzQnltcdTHhScnimWqdSJ6mNaFu/UHrN5rQRGzZp
 l8IPrlWnxQ7PxZa2RYA3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1691507782; x=
 1691594182; bh=rx1eiDCVgW8lKg4tPT9pJHpMKFAyLXbF9hzf+QCdfG4=; b=R
 r103s5+vRQSL/KncSkKNPXylRWAp7p6/heeEWtBe6ZpnaHLjfqTDxYAUvmXq08Ve
 ZI4m6H7yJMqRJIxq1gP+eijThj2N8Ci5x+cs1dNVlNHM6lJqmDtrNfaF2mnvaJn+
 qK0zXttJ3je9LMd0bo4/klsAj15W08gahDTDtZPp1PXXkaLahb2dF99Hn5CJE81s
 E+STLYAgXyaRb3ZjLENYxLTM7qhiO/8nwafv6CSiIO9XuTjMPi1BFmrp/kUB63SX
 bdF08HSH8qwWSwAg4UmnqsFnmD9wwBi3vLRJQ5yVmQ8JZQUyFOJoStugOxiiR1y7
 lSZehL5wzCMxu1NfwGvQQ==
X-ME-Sender: <xms:RFzSZDk2qtu-wiZXShxXazqi-MD24GnQqWODXOV3zLWn8PFO8dhYbw>
 <xme:RFzSZG1osiYaEGiTBxg2pHJeXKNT_kbReJmiXtwOTGXJ_JN0FXITxl86QBCV7ogEO
 7SJFgFXmkvepEqB4Dw>
X-ME-Received: <xmr:RFzSZJq8pIWBbLFcSlpAgGa104m46eya3KQNQo9gWr3zRNgjtFzNy3t76kXRxM81UzYCICAUGv0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrledvgdekiecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgfeilefgieevheekueevheehkeefveegiefgheefgfejjeehffefgedujedu
 geenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehith
 hssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:RVzSZLkVcpfFldOiYCjdxcRW_6u5T0WKjh5tj4wJ-F6ejOazpoBUCw>
 <xmx:RVzSZB0656uUXdz_dHl57oVnBWX_kdhZCUKrC-q8Ut97jmQ2-3pelA>
 <xmx:RVzSZKtoTCmkPwJoJ7LBodF5z6TgdF7yqIRVu04rHdwWQK4kdXRcmA>
 <xmx:RlzSZJ_pi-BQyUypaHIaFoFdfLx9QE4CQNcEI4crGcRc56mw5ayCYg>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Aug 2023 11:16:19 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Keith Busch <kbusch@kernel.org>,
 Jesper Devantier <j.devantier@samsung.com>,
 Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org
Subject: [PATCH 2/2] hw/nvme: fix null pointer access in ruh update
Date: Tue,  8 Aug 2023 17:16:14 +0200
Message-ID: <20230808151611.81933-6-its@irrelevant.dk>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230808151611.81933-4-its@irrelevant.dk>
References: <20230808151611.81933-4-its@irrelevant.dk>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1150; i=k.jensen@samsung.com;
 h=from:subject; bh=r3EYdS4UbRYsXmJqdIzqatd4x/HJs6EmFk4hqmRzQLk=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGTSXDsXGqdt3OCZIUt2Rh1tkj2oJjfYiIJBK
 0QL/ccb6YHOzIkBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJk0lw7AAoJEE3hrzFt
 Tw3pNMEH/2+m9wO1J1abqtWDBkRtS3DnPXUnv/pJ8dMN8FgeBycGHE6VM/KZVPk1Ybw1DBXoKCc
 n99kRMvfl8IX3dmnc0i0olCoHwHw71+6+uxFc/KK3e4rWQ8oJtRBcq9V+nuCSZleiIpUUqjzw6W
 HtAyQJWgcDSy+6gHqIsw81tInKrZDP9hzLq6xiEJBPa2MLOe/f/Ss3TOBD9vb3bX89rFwpflRxP
 DnL4ALfwqeDMz4tIJzWk00Y+yVKvyirtsXD5Jh1S9r+DdQyVExW8X/f6Gq72AH5cdvvGqicvuMt
 FG2uKdwyA4xM7bKwZsl005iBDotOc/+XJa+T+4wFo/YBU3btPRbRrKlM
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.21; envelope-from=its@irrelevant.dk;
 helo=wout5-smtp.messagingengine.com
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

The Reclaim Unit Update operation in I/O Management Receive does not
verify the presence of a configured endurance group prior to accessing
it.

Fix this.

Cc: qemu-stable@nongnu.org
Fixes: 73064edfb864 ("hw/nvme: flexible data placement emulation")
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index e5b5c7034d2b..539d27355313 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -4361,7 +4361,13 @@ static uint16_t nvme_io_mgmt_send_ruh_update(NvmeCtrl *n, NvmeRequest *req)
     uint32_t npid = (cdw10 >> 1) + 1;
     unsigned int i = 0;
     g_autofree uint16_t *pids = NULL;
-    uint32_t maxnpid = n->subsys->endgrp.fdp.nrg * n->subsys->endgrp.fdp.nruh;
+    uint32_t maxnpid;
+
+    if (!ns->endgrp || !ns->endgrp->fdp.enabled) {
+        return NVME_FDP_DISABLED | NVME_DNR;
+    }
+
+    maxnpid = n->subsys->endgrp.fdp.nrg * n->subsys->endgrp.fdp.nruh;
 
     if (unlikely(npid >= MIN(NVME_FDP_MAXPIDS, maxnpid))) {
         return NVME_INVALID_FIELD | NVME_DNR;
-- 
2.41.0


