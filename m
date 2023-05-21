Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB6A70B0FA
	for <lists+qemu-devel@lfdr.de>; Sun, 21 May 2023 23:50:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0qvC-0000Wh-Bs; Sun, 21 May 2023 17:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1q0qvA-0000W6-FI
 for qemu-devel@nongnu.org; Sun, 21 May 2023 17:48:56 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1q0qv8-00067t-H1
 for qemu-devel@nongnu.org; Sun, 21 May 2023 17:48:56 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id 1B51C5C00C4;
 Sun, 21 May 2023 17:48:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Sun, 21 May 2023 17:48:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm2; t=1684705734; x=
 1684792134; bh=iG0WvAqwd5DRB3lppeZtCGRegXlc7BNe6x/K/+x9hZg=; b=L
 NBETH5JLwfkCkmz90YaFocKQ1xkMAmNy4Ma2noQ+VthQryueoLqa8B1pxTwHDHxj
 SeQXtkYe0ZV2byXvyxPF92EliUSwJIhsCWw0oCN657XkHVH9a71+HFXAM27djYxL
 G4cBl+yy3hjK8gmm8wrUArxr6uQ6BEkje7EaOBtSlXEvA1wV+lhR4C35TlObrPQ5
 sa1qMkK6gxujflQyLBc67l8crvLeO5HV5vwIkgSQ+Dc1x6lqtAfajgXRBp9Qgh5D
 ujON/syX59tui8EJW3R3XVAyKI44j5Ns0qheG42O+GapXlpV/msTgNYDeHvi3ABW
 4qouqO2tkUInN6LFqADoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1684705734; x=
 1684792134; bh=iG0WvAqwd5DRB3lppeZtCGRegXlc7BNe6x/K/+x9hZg=; b=M
 Sz1aPzHIzQsXd77Jr6zZJAkPH2Xebe/OS9FpfzxhdcfTI0mwIstnhTagecybCeMI
 6ufaE97BVj9em2Jfw1kd7J2HkptjCwXtHN+9+EwnnuFcFJXWQzN8qIapbuCEenIr
 0CvnyECn3OsRyh334xgigWGFaADfS8+BBkdEOfr2fD0VOG3a1D4NSJa9MXdcCmDg
 PPW8nx2fOAoIHiBzLviKtQwNrW4nQSIiHf2VPkKA/I3yv+2TDZedXfCOSxRBg2+8
 SB8Eo5ySfLINB5g/zvDKwE7NtrErEhrLSCIFwhcNUXf3Zp5uXwabGcqMQcXbof1n
 2xHIGrtzdduPW19hVoazQ==
X-ME-Sender: <xms:xZFqZN2P0L6wxisUkqaJl_SfaTxme2R0homN-1Ga57abijY5sNwkUA>
 <xme:xZFqZEHrvy0-ZMaiwc1juNYK3vb3JCcdNe1_NrDnGleSxnuhDtVELzH1wpIc5Ssy2
 3DGSR-z2BGSDoTH4qs>
X-ME-Received: <xmr:xZFqZN7oXx2W4sE4rEyvZTG5b_XYmnQhHntAkRd_2MBhIMTiFKrhmy0M7HM8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejtddgtddvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
 ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
 ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
 dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
 vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
 hgohgrthdrtghomh
X-ME-Proxy: <xmx:xZFqZK0GmSLqJAf1enUZ9J94syohPlkxp47UslhGWj82k38NpWyFMg>
 <xmx:xZFqZAEK56Aqnzryxx11IN3CNYGf8XiuNNxz1qlm5atuXrrlvCpo5A>
 <xmx:xZFqZL_ELq18wb6_lwH1r-7iASEoZHqJxpsTxhgZ11IfSEkWr14r2Q>
 <xmx:xpFqZMhhIuUtFxWBhksRnTuecyJ6P_DDZa7E9WlCcW9FLPBpbK3B-A>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 May 2023 17:48:52 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
To: qemu-devel@nongnu.org
Cc: yangxiaojuan@loongson.cn, gaosong@loongson.cn, philmd@linaro.org,
 chenhuacai@kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 2/2] hw/mips/loongson3_virt: Remove CPU restrictions for TCG
Date: Sun, 21 May 2023 22:48:32 +0100
Message-Id: <20230521214832.20145-3-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230521214832.20145-1-jiaxun.yang@flygoat.com>
References: <20230521214832.20145-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.27; envelope-from=jiaxun.yang@flygoat.com;
 helo=out3-smtp.messagingengine.com
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

After implemented CPUCFG and CSR, we are now able to boot Linux
kernel with Loongson-3A4000 CPU, so there is no point to restrict
CPU type for TCG.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/mips/loongson3_virt.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index a57245012598..47289fb6bf85 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -488,10 +488,6 @@ static void mips_loongson3_virt_init(MachineState *machine)
         if (!machine->cpu_type) {
             machine->cpu_type = MIPS_CPU_TYPE_NAME("Loongson-3A1000");
         }
-        if (!strstr(machine->cpu_type, "Loongson-3A1000")) {
-            error_report("Loongson-3/TCG needs cpu type Loongson-3A1000");
-            exit(1);
-        }
     } else {
         if (!machine->cpu_type) {
             machine->cpu_type = MIPS_CPU_TYPE_NAME("Loongson-3A4000");
-- 
2.39.2 (Apple Git-143)


