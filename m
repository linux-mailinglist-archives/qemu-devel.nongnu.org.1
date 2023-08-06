Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A24C77158B
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 16:15:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSeWl-0006kn-LH; Sun, 06 Aug 2023 10:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qSeWh-0006hZ-WC
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 10:14:36 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qSeWg-00064N-HM
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 10:14:35 -0400
Received: from develop.s.cslab.moe (unknown [166.111.226.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id A26C343DF6;
 Sun,  6 Aug 2023 14:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1691331272; bh=XmrdYFFd7Hxs7xERxZjOBCLXmaPM6AQxKEGh/PfaCOg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=aV6iLoMUNXQwO28oB7ZMh868dunbBNfI6BP/W76FHAif5h2sHKC3YcZNdDwqh5Zqt
 YB0wme02JFfbR6UxAcx2e21YVi2PzsMHffgzY5H8ySBTcx3Qp7dC5DBi0j5kyqD0Kk
 NrW/Mow/sVrsxcwQRutv4pKw33JWOCDukCqi0UPM=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: Jiajie Chen <c@jia.je>, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>
Subject: [PATCH 3/3] target/loongarch: Mark CSR.PWCH as LoongArch64-only
Date: Sun,  6 Aug 2023 22:13:56 +0800
Message-Id: <20230806141357.1756714-3-c@jia.je>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230806141357.1756714-1-c@jia.je>
References: <20230806141357.1756714-1-c@jia.je>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

LoongArch32 does not provide CSR.PWCH, thus the CSR is marked as
LoongArch64-only.

Signed-off-by: Jiajie Chen <c@jia.je>
---
 target/loongarch/insn_trans/trans_privileged.c.inc | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/insn_trans/trans_privileged.c.inc b/target/loongarch/insn_trans/trans_privileged.c.inc
index 9c9de090f0..f00177d03d 100644
--- a/target/loongarch/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/insn_trans/trans_privileged.c.inc
@@ -56,6 +56,7 @@ enum {
     CSRFL_READONLY = (1 << 0),
     CSRFL_EXITTB   = (1 << 1),
     CSRFL_IO       = (1 << 2),
+    CSRFL_LA64ONLY = (1 << 3),
 };
 
 #define CSR_OFF_FUNCS(NAME, FL, RD, WR)                    \
@@ -96,7 +97,7 @@ static const CSRInfo csr_info[] = {
     CSR_OFF(PGDH),
     CSR_OFF_FUNCS(PGD, CSRFL_READONLY, gen_helper_csrrd_pgd, NULL),
     CSR_OFF(PWCL),
-    CSR_OFF(PWCH),
+    CSR_OFF_FLAGS(PWCH, CSRFL_LA64ONLY),
     CSR_OFF(STLBPS),
     CSR_OFF(RVACFG),
     CSR_OFF_FUNCS(CPUID, CSRFL_READONLY, gen_helper_csrrd_cpuid, NULL),
@@ -179,6 +180,11 @@ static bool check_csr_flags(DisasContext *ctx, const CSRInfo *csr, bool write)
     if ((csr->flags & CSRFL_READONLY) && write) {
         return false;
     }
+#ifdef TARGET_LOONGARCH32
+    if (csr->flags & CSRFL_LA64ONLY) {
+        return false;
+    }
+#endif
     if ((csr->flags & CSRFL_IO) && translator_io_start(&ctx->base)) {
         ctx->base.is_jmp = DISAS_EXIT_UPDATE;
     } else if ((csr->flags & CSRFL_EXITTB) && write) {
-- 
2.39.2


