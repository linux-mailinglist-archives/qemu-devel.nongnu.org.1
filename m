Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C36EE723E3A
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 11:49:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6TIv-0007nx-W6; Tue, 06 Jun 2023 05:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIm-0007hA-Oy
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:32 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIj-0004nR-Kd
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:32 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-30c2bd52f82so5988356f8f.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 02:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686044908; x=1688636908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eYiuLhZJEb6+DB2CYoVrbymZAjqr59ZfPJAsxjK+bgU=;
 b=dXgn6MiAiPre4IwXhOBCoKx4LDpBcSk3zPWISgx6YmyWDFec4v3GLD9TTxzYRRiwOV
 6qinSb/3dNvkGm9DDJAlbBDM6jcTYk3wCtAZ+AfdZ/gTwn9lrmbii9qLKxBoP9O3PixN
 qOZbiwehiH2J1cR3zX3gY9cmj/RguL/3wIWijkTWooRgGn6HjrYfBjh0NyCOqPniuL+J
 3FzTMRtCNXzdhikrSm5G/ImBAq1HHfSpX0WlBeqPgMkJr5AjKfm6rb4h439iTkb4hSWN
 c3S623ypl83QLXh8Zy256knEweCqKj2hZp8BSTyqg+3AeLxGMZyjNNmAB4lIW1GBynU/
 tKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686044908; x=1688636908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eYiuLhZJEb6+DB2CYoVrbymZAjqr59ZfPJAsxjK+bgU=;
 b=ZXSdjdOfzoRkv9Nnv19gh25zjFaDfk+VA3D940Uenn0TH7/jS5PeEgvXKzBalNAeSO
 FEwuuQZAIvF0NvCAZ+R1sQrjs19DCz1Ykd1WV03AqLY1Catx96Dgi84ISb3ip8GK677x
 bbYWJjd2b+1TG7ri7KjUp/iGP3dT/vSkPjbFrNd3iksY07NOHgaevj+eKUceJgL3d9fj
 t8U9SHDZ2E2B+PJs6pxADjcqA5izcciNazF3calBl37ReFWke3p3rzx24r+c1Hy20TNW
 VoDzPwsLwqulpCSHZBbHJzmOc1PdPkA3aafdcdZppJxPNWkGgEPve/YHOSlekayCgAa9
 NUag==
X-Gm-Message-State: AC+VfDxP3UJjp5JJiyBbVAkB8kjvQ7vHvxFU2ZNwMgqHEt7Tg2rDuylu
 vT1MHB3Ea4NbUQKCLfBImoYz/yQ0Af1cvLAnBp4=
X-Google-Smtp-Source: ACHHUZ5cNnTfXdlXyerz+XMYSUfP05Mhc8M57AzWWo/alIUpw1pK+ce5UI8tSx31RN2g39gcjfT6BQ==
X-Received: by 2002:adf:efc7:0:b0:306:26d1:230a with SMTP id
 i7-20020adfefc7000000b0030626d1230amr1279407wrp.65.1686044908177; 
 Tue, 06 Jun 2023 02:48:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a5d4b0a000000b0030789698eebsm12134017wrq.89.2023.06.06.02.48.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 02:48:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/42] target/arm: Use tcg_gen_qemu_st_i128 for STZG, STZ2G
Date: Tue,  6 Jun 2023 10:47:57 +0100
Message-Id: <20230606094814.3581397-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606094814.3581397-1-peter.maydell@linaro.org>
References: <20230606094814.3581397-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

This fixes a bug in that these two insns should have been using atomic
16-byte stores, since MTE is ARMv8.5 and LSE2 is mandatory from ARMv8.4.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230530191438.411344-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 3674fc1bc16..35eac7729b0 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -4058,15 +4058,18 @@ static void disas_ldst_tag(DisasContext *s, uint32_t insn)
 
     if (is_zero) {
         TCGv_i64 clean_addr = clean_data_tbi(s, addr);
-        TCGv_i64 tcg_zero = tcg_constant_i64(0);
+        TCGv_i64 zero64 = tcg_constant_i64(0);
+        TCGv_i128 zero128 = tcg_temp_new_i128();
         int mem_index = get_mem_index(s);
-        int i, n = (1 + is_pair) << LOG2_TAG_GRANULE;
+        MemOp mop = finalize_memop(s, MO_128 | MO_ALIGN);
 
-        tcg_gen_qemu_st_i64(tcg_zero, clean_addr, mem_index,
-                            MO_UQ | MO_ALIGN_16);
-        for (i = 8; i < n; i += 8) {
-            tcg_gen_addi_i64(clean_addr, clean_addr, 8);
-            tcg_gen_qemu_st_i64(tcg_zero, clean_addr, mem_index, MO_UQ);
+        tcg_gen_concat_i64_i128(zero128, zero64, zero64);
+
+        /* This is 1 or 2 atomic 16-byte operations. */
+        tcg_gen_qemu_st_i128(zero128, clean_addr, mem_index, mop);
+        if (is_pair) {
+            tcg_gen_addi_i64(clean_addr, clean_addr, 16);
+            tcg_gen_qemu_st_i128(zero128, clean_addr, mem_index, mop);
         }
     }
 
-- 
2.34.1


