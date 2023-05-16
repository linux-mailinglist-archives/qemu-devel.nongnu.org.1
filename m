Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F827057BD
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:45:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0Yk-0006iI-Ec; Tue, 16 May 2023 15:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0Yi-0006h7-8H
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:42:08 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0Yg-0002qM-Hn
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:42:08 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-64359d9c531so10855218b3a.3
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266125; x=1686858125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K2D+W3Frhm1HnR66jCW7Uv+/eEEehjSzUkt7BPDzA4s=;
 b=TTKN56KE0YQPNgRxxpnHIaBG1HjMfRK70FxkKxZLzubfgPh0SGvRhoa8BinspPrvUz
 xX8fau9il95dLxKo9Maxf7eERP+BYb/QB7I3AdQhZ96ad7fLYcpZ3whmSHrnU1sFU8eo
 61Q/AzedOVpjfKLPJeg4s6Dd+ku6APPmrASvgd3ytKlzNG62DSJ1OZ6WG5LS5D++d2rc
 wKX2nMpmUlRHYUABWnHPEZC4AGgVsZ8x8IT735MO1gwgr1DY7H5PYabtBvf8JT0rSxKp
 TtlFZIFXaVOTQEIXJYD2/9Gim+lOXrenuInIQQ2miR3MuCLoIIdHumMakkN23d/mMNfD
 MMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266125; x=1686858125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K2D+W3Frhm1HnR66jCW7Uv+/eEEehjSzUkt7BPDzA4s=;
 b=E6U0BQvdqZ0+AMZt/yjLULNUkOSkkWfibrAOn9p0wGZ1x0/oPe/iiUpSaZEikptMzu
 dKpeiK7w44cHhQdT8sXunm+ze413D3kIpoPMhgZjdEsvvvFzYP6owBSbexGlV8sR8tpI
 64YaPKqoUV2w+eAk0lNmyBrFxCYHkHPYBXZ4zUyyT2s5Q8++eEtjkNd/zNbCTRp+2D+o
 beUzowOum1iihPjDYHbDo0G1XGFq5f8sYgHyHhgURiJkOvKAVJdsq7Rq9B8sLgt6vfdP
 /NR2X0I4YhqEm40MR1EUPpi/SmRvaues0leIkj/cq997/kE8ZsthOBlqmpllSgw4KMxc
 x/LA==
X-Gm-Message-State: AC+VfDz0j/1ZLUIh6snvEGUc4TJNDt5E/Q6X6oMfiCsAPdR6a3CAQzWE
 pokBXsxxVCldc1AP4gkGZKQWH3P1BVcZCUZdXXA=
X-Google-Smtp-Source: ACHHUZ7PnbPY1desd5h4TNAjR64PuKSOgiRiuBZwYmyt/WcquwYfqjNlHjOn6gSZfMatj3WirI7QGA==
X-Received: by 2002:a05:6a00:23d3:b0:63d:4752:4da3 with SMTP id
 g19-20020a056a0023d300b0063d47524da3mr50326109pfc.25.1684266125278; 
 Tue, 16 May 2023 12:42:05 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 z21-20020aa791d5000000b006260526cf0csm13771165pfa.116.2023.05.16.12.42.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:42:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 20/80] tcg/mips: Use full load/store helpers in user-only mode
Date: Tue, 16 May 2023 12:40:45 -0700
Message-Id: <20230516194145.1749305-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
 tcg/mips/tcg-target.c.inc | 57 ++-------------------------------------
 1 file changed, 2 insertions(+), 55 deletions(-)

diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 7770ef46bd..fa0f334e8d 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1075,7 +1075,6 @@ static void tcg_out_call(TCGContext *s, const tcg_insn_unit *arg,
     tcg_out_nop(s);
 }
 
-#if defined(CONFIG_SOFTMMU)
 /* We have four temps, we might as well expose three of them. */
 static const TCGLdstHelperParam ldst_helper_param = {
     .ntmp = 3, .tmp = { TCG_TMP0, TCG_TMP1, TCG_TMP2 }
@@ -1088,8 +1087,7 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
 
     /* resolve label address */
     if (!reloc_pc16(l->label_ptr[0], tgt_rx)
-        || (TCG_TARGET_REG_BITS < TARGET_LONG_BITS
-            && !reloc_pc16(l->label_ptr[1], tgt_rx))) {
+        || (l->label_ptr[1] && !reloc_pc16(l->label_ptr[1], tgt_rx))) {
         return false;
     }
 
@@ -1118,8 +1116,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
 
     /* resolve label address */
     if (!reloc_pc16(l->label_ptr[0], tgt_rx)
-        || (TCG_TARGET_REG_BITS < TARGET_LONG_BITS
-            && !reloc_pc16(l->label_ptr[1], tgt_rx))) {
+        || (l->label_ptr[1] && !reloc_pc16(l->label_ptr[1], tgt_rx))) {
         return false;
     }
 
@@ -1139,56 +1136,6 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
     return true;
 }
 
-#else
-static bool tcg_out_fail_alignment(TCGContext *s, TCGLabelQemuLdst *l)
-{
-    void *target;
-
-    if (!reloc_pc16(l->label_ptr[0], tcg_splitwx_to_rx(s->code_ptr))) {
-        return false;
-    }
-
-    if (TCG_TARGET_REG_BITS < TARGET_LONG_BITS) {
-        /* A0 is env, A1 is skipped, A2:A3 is the uint64_t address. */
-        TCGReg a2 = MIPS_BE ? l->addrhi_reg : l->addrlo_reg;
-        TCGReg a3 = MIPS_BE ? l->addrlo_reg : l->addrhi_reg;
-
-        if (a3 != TCG_REG_A2) {
-            tcg_out_mov(s, TCG_TYPE_I32, TCG_REG_A2, a2);
-            tcg_out_mov(s, TCG_TYPE_I32, TCG_REG_A3, a3);
-        } else if (a2 != TCG_REG_A3) {
-            tcg_out_mov(s, TCG_TYPE_I32, TCG_REG_A3, a3);
-            tcg_out_mov(s, TCG_TYPE_I32, TCG_REG_A2, a2);
-        } else {
-            tcg_out_mov(s, TCG_TYPE_I32, TCG_TMP0, TCG_REG_A2);
-            tcg_out_mov(s, TCG_TYPE_I32, TCG_REG_A2, TCG_REG_A3);
-            tcg_out_mov(s, TCG_TYPE_I32, TCG_REG_A3, TCG_TMP0);
-        }
-    } else {
-        tcg_out_mov(s, TCG_TYPE_TL, TCG_REG_A1, l->addrlo_reg);
-    }
-    tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_A0, TCG_AREG0);
-
-    /*
-     * Tail call to the helper, with the return address back inline.
-     * We have arrived here via BNEL, so $31 is already set.
-     */
-    target = (l->is_ld ? helper_unaligned_ld : helper_unaligned_st);
-    tcg_out_call_int(s, target, true);
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
-
 typedef struct {
     TCGReg base;
     MemOp align;
-- 
2.34.1


