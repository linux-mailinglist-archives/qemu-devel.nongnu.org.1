Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4B170AD71
	for <lists+qemu-devel@lfdr.de>; Sun, 21 May 2023 12:25:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0gER-0004Gv-1c; Sun, 21 May 2023 06:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1q0gEN-0004Fe-Sc
 for qemu-devel@nongnu.org; Sun, 21 May 2023 06:24:03 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1q0gEL-0003JX-UK
 for qemu-devel@nongnu.org; Sun, 21 May 2023 06:24:03 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 2E8445C0101;
 Sun, 21 May 2023 06:24:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Sun, 21 May 2023 06:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm2; t=1684664640; x=
 1684751040; bh=DbYwJfU969KkgdSfKT1Db23fqol4X6eaY4w+54yLWbo=; b=G
 sxQA+Y3ysA6KNIFRk2DH0rQ7CH+EFNHus/0icMkS2DAouPgXLLYiUiFjOc1uI2zS
 rS4HWowy/wWrjVsk14mlQnXFzt8htNEzge4Ma2GVmMpbem2ujP9yHCSEKx2F6euB
 blGanVrgJGvAn6JcePP9un9kcob5t0wHFkwvj/y8twMnsSVaSbVO8UR2aUwRXUV1
 X7uQcxCOp45/OVwBmwv4XNww5/0qz3ePyvwV4k0OcnV23hu2uRV8gPxGuVVCUtlG
 oALZerdljdAy9OS8hrZuLZ9nsWnvgXy6+snnMob1I76SVt5Pjh3QfPf/VtKUt48x
 3mRmDFNC24SNs8N+AcCwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1684664640; x=
 1684751040; bh=DbYwJfU969KkgdSfKT1Db23fqol4X6eaY4w+54yLWbo=; b=q
 ut5/TUFUM+Cy2+/O7byHWYsO8uLtqEATJLgbMAgh4zT2C9zKlWJl1ovu4QA9bE8e
 5XT4zoVJslB7TvIhY3GaxyPJv8PjkG2cplSQP/D6S3DZUXUz2KUxyUFSceKzTGmV
 2OCdnaEgUJ8r0d/HfDALFNBQFCePOywfZB7iF+lw8cBZw3zVYtKWDxQ/n3/BhRsD
 k5XCu/D+cFx1ezVDE9ne9P97bNuiFacrxNXHQx0ejbHIoFiDrkqWq/iuw7btvMov
 otEMTgoeuoB3oLyfyIFNGSHSzut1i9f0J2f5xM81QPXvZreLn/N1eJnEmseFTn20
 mxoDqyFlWmkTPV1PuEg7w==
X-ME-Sender: <xms:QPFpZPfWVcXr-EJc7x4EgShDoCZOij7dlS9gUNKebzrLfZAlGUlpxg>
 <xme:QPFpZFONWMoT3_YSVyNptIjhcFx9ZBXgM7-h_i2HGQHFxXcgUo2h6hQi8emfv38SK
 P4AiykoNFx-vyuagEw>
X-ME-Received: <xmr:QPFpZIgWkfDdJzYjXW4WTze1J0rZ6MEheFFDaGZHivzlr1S1S9zMDBEpegBn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeiledgvdekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
 ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
 ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
 dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
 vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
 hgohgrthdrtghomh
X-ME-Proxy: <xmx:QPFpZA80SMI_zPlFJjf8OxRqAAot0dbJLvvD-xJrRGhMelTTiChhYA>
 <xmx:QPFpZLtom9PPvEggW_myoiccdvQZsVsMs3Y-y-JWCpSu0ZmPYOdriQ>
 <xmx:QPFpZPE1jvCX0em0ZpC9iNyLG8g77LpGpJiqJZ1jXsgX-p7iWb09gw>
 <xmx:QPFpZE8SnC0lhZfxos_BOPySCL2f-ur9lH5npaxea5Y1Z-Cs6Tohnw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 May 2023 06:23:58 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
To: qemu-devel@nongnu.org
Cc: yangxiaojuan@loongson.cn, gaosong@loongson.cn, philmd@linaro.org,
 chenhuacai@kernel.org, crosa@redhat.com, wainersm@redhat.com,
 bleal@redhat.com, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 2/4] hw/intc/loongarch_ipi: Guard LoongArch only features with
 ifdef
Date: Sun, 21 May 2023 11:23:05 +0100
Message-Id: <20230521102307.87081-3-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230521102307.87081-1-jiaxun.yang@flygoat.com>
References: <20230521102307.87081-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.25; envelope-from=jiaxun.yang@flygoat.com;
 helo=out1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

IOCSR based send features are tied to LoongArch's CPU implmentation,
ifdef them for LoongArch only so we can build loongarch_ipi on MIPS.

Note that Loongson-3A4000 have IOCSR as well, so we may implement
those features for MIPS in future.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/intc/loongarch_ipi.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
index 3e453816524e..895a2ee96e1e 100644
--- a/hw/intc/loongarch_ipi.c
+++ b/hw/intc/loongarch_ipi.c
@@ -50,6 +50,7 @@ static uint64_t loongarch_ipi_readl(void *opaque, hwaddr addr, unsigned size)
     return ret;
 }
 
+#ifdef TARGET_LOONGARCH64
 static void send_ipi_data(CPULoongArchState *env, uint64_t val, hwaddr addr)
 {
     int i, mask = 0, data = 0;
@@ -140,6 +141,25 @@ static void any_send(uint64_t val)
     env = &cpu->env;
     send_ipi_data(env, val, addr);
 }
+#else
+static void ipi_send(uint64_t val)
+{
+    qemu_log_mask(LOG_UNIMP, "%s: Unimplemented send 0x%" PRIx64 "\n",
+                    __func__, val);
+}
+
+static void mail_send(uint64_t val)
+{
+    qemu_log_mask(LOG_UNIMP, "%s: Unimplemented send 0x%" PRIx64 "\n",
+                    __func__, val);
+}
+
+static void any_send(uint64_t val)
+{
+    qemu_log_mask(LOG_UNIMP, "%s: Unimplemented send 0x%" PRIx64 "\n",
+                    __func__, val);
+}
+#endif
 
 static void loongarch_ipi_writel(void *opaque, hwaddr addr, uint64_t val,
                                  unsigned size)
-- 
2.39.2 (Apple Git-143)


