Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EE8773AEF
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 17:17:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTORe-0008J4-IL; Tue, 08 Aug 2023 11:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qTORc-0008HJ-1j; Tue, 08 Aug 2023 11:16:24 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qTORZ-0000nK-O0; Tue, 08 Aug 2023 11:16:23 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.west.internal (Postfix) with ESMTP id D68653200313;
 Tue,  8 Aug 2023 11:16:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Tue, 08 Aug 2023 11:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm2; t=1691507778; x=
 1691594178; bh=utIErE0zSRQECiJRKxegToY8hT7jxZDHY6ToNXDSHT0=; b=P
 V0vfnxwc118QxkL/zR7zbJ0RYlblHBhCdoIAVmpdI81URgAUH1NyPgCk3VeI3JSt
 kcK8ltDwADq0SzqSNMvy2hBuSV5ZNzTW5+YNi8AoQvBobxzg8z2W63zJF/cRE2kG
 1QzjnvmPdE1CJtfZTsHrmHwmCoTsRVAj01i3ooEwxtos9/bALah2hKLLAn/w2ANi
 aQXEwXRX8bvaM0jUInjmlqYYzqe5OgI0vVEkXbU9Icgd72CG5XzeWrOW8ryfRpXV
 Ssb8tqtgcHrwWaO28cIfUeInr99MMLLOur6BbZ13WElUMgdO1AJBGasJPy7fVUvJ
 FuCz/okePbZaIOxdeXdNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1691507778; x=
 1691594178; bh=utIErE0zSRQECiJRKxegToY8hT7jxZDHY6ToNXDSHT0=; b=i
 daWwfqUs3Fe4zVOts8IAshykFqve2qLV2471tEkCT7yc8gBMH9e/RwvYiUm0qUv4
 d6JwIORAo3pyDgh4/N4C3CdQ2EJMsEokHtVHm1pAUiZKz8A6Cu/g0Y9ojkK0p5wR
 ZvTaxA/Yplnch4Q+lUlX32RX53qeqnF5JqQ4QhUcAySirEfQc9fkVefI/GMhQlBX
 jSPGHaHa0QjHjAdWei4kLDwZk/zOnj/lTYmzPHDb3C3nGQLQhL/TFzzC0Nv49eB2
 15N+C/xObx4XOleBU0ldq4ZDb9qzgIvIpCodik9lX5pJoSuPWQleBOmJ/rC5GFe0
 nyyadXtSauZpv86dWpYsA==
X-ME-Sender: <xms:QlzSZN7dkYJiAXsOdMJIjGnShUT9nycVI-dg_k2MTdXidxh1TWr3cg>
 <xme:QlzSZK4HD_psbv8tmGPnfoZ48pGh2Qac9YqSL7D1eaMDXIzrusCuISTc1TuYAw3Q3
 v3uIQU05yzqfRk-vXE>
X-ME-Received: <xmr:QlzSZEfxFOlrS3TUl-Wb-KiRA9_FTkaSNnAEm-lupS95Wo6KrhXy4CugTI5YEIWJTlR4WmFlE7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrledvgdekhecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeefheetgeehffefgeekgffhgeeijeekveffhfejveefkeduieeiveehteeludej
 udenucffohhmrghinhepghhithhlrggsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
 enucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:QlzSZGLxB1PDaR4KHPfpI_1svFpTL8GpUfFKSMPa3OKEfB6XXpMfNA>
 <xmx:QlzSZBKX2zuTMYSV5qORhP9WkW3JmMKALcySH3s2riDnn2kRQVaXIw>
 <xmx:QlzSZPwauCeM-gL4Pf82Sf_ayBDXp45lsDesQ-FqlHxKatEYMmkx-A>
 <xmx:QlzSZPhErI-2_v-skKUtLJ5cudvKvoKbYEqWec7A-3ckwUH1nANGiA>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Aug 2023 11:16:17 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Keith Busch <kbusch@kernel.org>,
 Jesper Devantier <j.devantier@samsung.com>,
 Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org
Subject: [PATCH 1/2] hw/nvme: fix null pointer access in directive receive
Date: Tue,  8 Aug 2023 17:16:13 +0200
Message-ID: <20230808151611.81933-5-its@irrelevant.dk>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230808151611.81933-4-its@irrelevant.dk>
References: <20230808151611.81933-4-its@irrelevant.dk>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1116; i=k.jensen@samsung.com;
 h=from:subject; bh=j+NXBa/MMLYk3DAJYgmXBjwSLj9vOoizgsNljLeNsQo=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGTSXDvoFpMdDmuwaGu2FDyWDR/d/iE7ReVKy
 d+P2ntJ4I+HdokBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJk0lw7AAoJEE3hrzFt
 Tw3pgjoH/2QTQ3WtHqaSM4VIhTAlj/sXnU+bj2DV0mmfEiMZvkbKtjTux1h+UjjI5BEhz3V6qJz
 4FXdycOsIolXOWcm4UlOnCW3Am/egdlZNXt/UoBs0KKqP/+RhqVbs6HgOL2oNdNH2ryQLXaiLUD
 fFo/7dZXhNKtfCpTIsSE53Rm00I+7W5p0sDVtsweJxAtZCEBc2+kFSciJCip8y2OCjxYOXMXifb
 ui3+qM3+SyQxwSWaM80eP7AYaUC6oZJUuJpyA6w0K6Irlua4TaHzyiAAjuXYqxAJySXTrZTeOEb
 sQFnZN0j5wzliOK+qdwGsLsmR6UyN//QPOmzcjVMVJXMYPxms6lMAKjt
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

nvme_directive_receive() does not check if an endurance group has been
configured (set) prior to testing if flexible data placement is enabled
or not.

Fix this.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1815
Fixes: 73064edfb864 ("hw/nvme: flexible data placement emulation")
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index d217ae91b506..e5b5c7034d2b 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -6900,7 +6900,7 @@ static uint16_t nvme_directive_receive(NvmeCtrl *n, NvmeRequest *req)
     case NVME_DIRECTIVE_IDENTIFY:
         switch (doper) {
         case NVME_DIRECTIVE_RETURN_PARAMS:
-            if (ns->endgrp->fdp.enabled) {
+            if (ns->endgrp && ns->endgrp->fdp.enabled) {
                 id.supported |= 1 << NVME_DIRECTIVE_DATA_PLACEMENT;
                 id.enabled |= 1 << NVME_DIRECTIVE_DATA_PLACEMENT;
                 id.persistent |= 1 << NVME_DIRECTIVE_DATA_PLACEMENT;
-- 
2.41.0


