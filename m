Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C427057AD
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:43:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0Yi-0006h3-Iv; Tue, 16 May 2023 15:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0Yh-0006gt-7q
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:42:07 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0Yf-0002pt-JK
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:42:06 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6439d505274so9270805b3a.0
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266124; x=1686858124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gXvb5M+QQ4GlJC4+AWTZXZCLTvkRCJufT4wwLa/Umbo=;
 b=mbB7mZS/rh8KtNwrnd06tNhkE2dAL4nJHTfzdCTgA6g/Qcip/h5kxAyGwS6pn2Xx1w
 SLb9L0DhuoO7VFlSgpluK70wKup+ouVICxvRtWLN9/MJyUYKKWNkPQoLiV7oc74WHyE2
 x+xcClk/2dwk3bOyYcFob/m4J9j/pX8QF130Ej6FK3+wyP+g7WDIPwwcbassyezGipAP
 BKtX8fTHA2Zl0BK2lRMO3QLmPGwWnFAj7ZVqJH40S3ONuGtk822VrPBnOVHLnQX9E2wY
 TVwOlFgl16+4PjXMjFvD6AP+T+tCV7TxImkFhFXLAELiTKYt2WiVzAbCFKZL3592PSe0
 K+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266124; x=1686858124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gXvb5M+QQ4GlJC4+AWTZXZCLTvkRCJufT4wwLa/Umbo=;
 b=PMK8py22SoAzG6DMXOq+wzTNdIA4snZnw+EA7moLYSeJP9v3494OvbH0m/zwYb5l0y
 zdJgpgXuXnhienmenl1esaBeIqoD4HBsdPfobWbc3RD7bi7f9EmJXfqbOV20ssG2YAk9
 iG1kU4nciIslre6IXSgu8oBDUt8cUZH9Obe55JRNUUMybnWcZ1JWhdvu7c/lR3k1j1Zj
 K4Qm3Oi26ev8v/ojuYjaUFvvgEo1gTxGnwtD18T/WYXmbM/1LxL7luuE1bGK5+o4k3+b
 Vje+3uUl9GueYx+J+PWWGy9loCZY5N2XsZDJY2r6xHNCBiJzLUsvN8F2SKQnaUzYecRv
 2ypA==
X-Gm-Message-State: AC+VfDyOr0QQbo3lxMvHgEKXs5pR10sR0J6kNboHFzL/V456rHI189jj
 HPde4vxtaZP83NkjhzUm7rF2miWvNLU63cYdcg0=
X-Google-Smtp-Source: ACHHUZ7Rbgp1LGANzum/9/F88H+/2YrQucsFeqjZWD7aZbAfS1Tvj8aAA/6XGETtFvKocCZVKwo3Yw==
X-Received: by 2002:a05:6a00:a8b:b0:643:b27f:6c43 with SMTP id
 b11-20020a056a000a8b00b00643b27f6c43mr48193547pfl.27.1684266124208; 
 Tue, 16 May 2023 12:42:04 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 z21-20020aa791d5000000b006260526cf0csm13771165pfa.116.2023.05.16.12.42.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:42:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 19/80] tcg/arm: Use full load/store helpers in user-only mode
Date: Tue, 16 May 2023 12:40:44 -0700
Message-Id: <20230516194145.1749305-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Instead of using helper_unaligned_{ld,st}, use the full load/store helpers.
This will allow the fast path to increase alignment to implement atomicity
while not immediately raising an alignment exception.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target.c.inc | 45 ----------------------------------------
 1 file changed, 45 deletions(-)

diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index a02804dd69..eb0542f32e 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1325,7 +1325,6 @@ typedef struct {
     bool index_scratch;
 } HostAddress;
 
-#ifdef CONFIG_SOFTMMU
 static TCGReg ldst_ra_gen(TCGContext *s, const TCGLabelQemuLdst *l, int arg)
 {
     /* We arrive at the slow path via "BLNE", so R14 contains l->raddr. */
@@ -1368,50 +1367,6 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
     tcg_out_goto(s, COND_AL, qemu_st_helpers[opc & MO_SIZE]);
     return true;
 }
-#else
-static bool tcg_out_fail_alignment(TCGContext *s, TCGLabelQemuLdst *l)
-{
-    if (!reloc_pc24(l->label_ptr[0], tcg_splitwx_to_rx(s->code_ptr))) {
-        return false;
-    }
-
-    if (TARGET_LONG_BITS == 64) {
-        /* 64-bit target address is aligned into R2:R3. */
-        TCGMovExtend ext[2] = {
-            { .dst = TCG_REG_R2, .dst_type = TCG_TYPE_I32,
-              .src = l->addrlo_reg,
-              .src_type = TCG_TYPE_I32, .src_ext = MO_UL },
-            { .dst = TCG_REG_R3, .dst_type = TCG_TYPE_I32,
-              .src = l->addrhi_reg,
-              .src_type = TCG_TYPE_I32, .src_ext = MO_UL },
-        };
-        tcg_out_movext2(s, &ext[0], &ext[1], TCG_REG_TMP);
-    } else {
-        tcg_out_mov(s, TCG_TYPE_I32, TCG_REG_R1, l->addrlo_reg);
-    }
-    tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_R0, TCG_AREG0);
-
-    /*
-     * Tail call to the helper, with the return address back inline,
-     * just for the clarity of the debugging traceback -- the helper
-     * cannot return.  We have used BLNE to arrive here, so LR is
-     * already set.
-     */
-    tcg_out_goto(s, COND_AL, (const void *)
-                 (l->is_ld ? helper_unaligned_ld : helper_unaligned_st));
-    return true;
-}
-
-static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
-{
-    return tcg_out_fail_alignment(s, l);
-}
-
-static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
-{
-    return tcg_out_fail_alignment(s, l);
-}
-#endif /* SOFTMMU */
 
 static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
                                            TCGReg addrlo, TCGReg addrhi,
-- 
2.34.1


