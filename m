Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B7476993F
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 16:17:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQTgV-0005Xg-53; Mon, 31 Jul 2023 10:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQTgS-0005WH-1f
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 10:15:40 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQTgP-0007eR-N9
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 10:15:39 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fe2048c910so9788865e9.1
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 07:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690812936; x=1691417736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=G2c+LxpkCJdqb0ZH/SG20fuSzrbSnvwdJMIMMiLTze0=;
 b=yq/4W2XGdu8ykukOpT6cYpEf3IlhIlZQI+lS53iuJMxn3wIw0Krfh2abatuug68f1N
 jCLftmQvJI9tUdrjVSwpm60Sfa6O5w3f+mP3hd/tDzTUUJG1djgw90LJJt6SpTSq0p1G
 nP3J3RKFg8xAeJ+67hwkOTh1PrDAYOkyy39aiExLMWIrfOTNgLklwIDGf/2x9s6ERaJg
 gWG2QNyyOk7JeU9tu/f20m/cZ6iRXbkFUC7wb5WV1FkzR3eJ6o1NEKoh9YvRsLAyNEI4
 +TTgx46WRYQSh8R5gyTxwdHi3SUDpfV9rVwuxVRPtiZI1dqA61ZATot8YZF9U8qtNUcJ
 SqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690812936; x=1691417736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G2c+LxpkCJdqb0ZH/SG20fuSzrbSnvwdJMIMMiLTze0=;
 b=QFtB+MaTwaIDvD5AcAwHZQFBl/KCRxG2WHTzvlubmyPKo7G87r4vNEuGqDXGTaxONW
 m6ITFGsb4FJm0N+Ojpxx114YOE7UqOlNns37lBByUzVjWr4xBxFVDcnZfHEjaqsLuVu4
 2gy+f+nX9ZJ5rNXyYVx0YcrvAbtu5Me2AWPboI9nibJizTLQ5CvBrCmEjBZclRhqsVHB
 JwFQxVHV4a+EyD6K49BwiYT00ksBxqseHa0rsNyYhCHkcZ8ueE34vCkdn5lXM/3b1UaN
 QCmD9I/EJPtkzfOxkHLYd3v51hyFUQBOofCGztQtvB3YjaV2zpUu/VtxExAYErCysDIM
 RAog==
X-Gm-Message-State: ABy/qLaz63m0WLMbFWgfHZr0rfjmAaWTvoyupIqWLvsUMdZp2qNOYwEa
 AVNDxXJI0gUg8bIodiIlWQlv1xdBZyX17PhrFYw=
X-Google-Smtp-Source: APBJJlGk8mcii20ejdalQtBStTUHOKxfovSuCt9Zo5krGCsix3g1wnlrZMlBHKOdbKU1QAMTAShEKQ==
X-Received: by 2002:a1c:7c03:0:b0:3fe:2140:f504 with SMTP id
 x3-20020a1c7c03000000b003fe2140f504mr71732wmc.20.1690812935803; 
 Mon, 31 Jul 2023 07:15:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a05600c114f00b003fbb5506e54sm11450675wmz.29.2023.07.31.07.15.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 07:15:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/6] target/arm: Fix MemOp for STGP
Date: Mon, 31 Jul 2023 15:15:28 +0100
Message-Id: <20230731141533.3303894-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731141533.3303894-1-peter.maydell@linaro.org>
References: <20230731141533.3303894-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

When converting to decodetree, the code to rebuild mop for the pair
only made it into trans_STP and not into trans_STGP.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1790
Fixes: 8c212eb6594 ("target/arm: Convert load/store-pair to decodetree")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230726165416.309624-1-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index ef0c47407a9..5fa1257d32a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -3004,6 +3004,9 @@ static bool trans_STGP(DisasContext *s, arg_ldstpair *a)
     MemOp mop;
     TCGv_i128 tmp;
 
+    /* STGP only comes in one size. */
+    tcg_debug_assert(a->sz == MO_64);
+
     if (!dc_isar_feature(aa64_mte_insn_reg, s)) {
         return false;
     }
@@ -3029,13 +3032,25 @@ static bool trans_STGP(DisasContext *s, arg_ldstpair *a)
         gen_helper_stg(cpu_env, dirty_addr, dirty_addr);
     }
 
-    mop = finalize_memop(s, a->sz);
-    clean_addr = gen_mte_checkN(s, dirty_addr, true, false, 2 << a->sz, mop);
+    mop = finalize_memop(s, MO_64);
+    clean_addr = gen_mte_checkN(s, dirty_addr, true, false, 2 << MO_64, mop);
 
     tcg_rt = cpu_reg(s, a->rt);
     tcg_rt2 = cpu_reg(s, a->rt2);
 
-    assert(a->sz == 3);
+    /*
+     * STGP is defined as two 8-byte memory operations and one tag operation.
+     * We implement it as one single 16-byte memory operation for convenience.
+     * Rebuild mop as for STP.
+     * TODO: The atomicity with LSE2 is stronger than required.
+     * Need a form of MO_ATOM_WITHIN16_PAIR that never requires
+     * 16-byte atomicity.
+     */
+    mop = MO_128;
+    if (s->align_mem) {
+        mop |= MO_ALIGN_8;
+    }
+    mop = finalize_memop_pair(s, mop);
 
     tmp = tcg_temp_new_i128();
     if (s->be_data == MO_LE) {
-- 
2.34.1


