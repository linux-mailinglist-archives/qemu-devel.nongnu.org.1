Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E801C7057C6
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:46:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0Yj-0006h1-3U; Tue, 16 May 2023 15:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0Ye-0006fM-VW
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:42:04 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0Yd-0002lO-44
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:42:04 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-643557840e4so15613786b3a.2
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266122; x=1686858122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W19ruQQxWDDIeEDzZGJivenEm5AmU9KSchMTkoB+WqU=;
 b=ZeIhiwuV0DyAsO/BKOZrb56VSlvN9ZtwUXAvDVoOwMDeNrGh0BXfqvb5nxJtBAs5CI
 FMkNnyfSt1DXd9rcHG5T+R6CPWHj6f9m3sd7v+uCG4uLe0QlVXdia7seXfcZnjzT1jUP
 jwb0IrKBYVqTOuGJucsOPKP60ROzrNztJ/K4qEVdNEGdpLwMB3UYkE7Gpu221vqiB0Lk
 Iv7uEzzGfZEPHEO3CWu0jWmCFEfcVXhkA8uAU3DbJGr3X+4vTdV5e5ZbOJlYulJ2NR3k
 WinCqN5imZexdyKVD1BqYoOPqiTkpxXwy+Ro0sMiLFjpQ6jC2ltMx+OOzx/q96lqtfsT
 AVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266122; x=1686858122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W19ruQQxWDDIeEDzZGJivenEm5AmU9KSchMTkoB+WqU=;
 b=NSxmKoy2z5lRhtEXXQFgcpE6QooWUIb2mcEdNyBfRRJa/w7oOAc1+xDcIFE93OLjsy
 aW8bEuHV33004ErFmdE+JW0p3stSw2uhMRlkVZX0Ntx8Na9lSV59Kcpa8/JIT8renDOD
 NsQpebhxe2as0qefmOTfaepXvN6GxSEV4/ri/Q86Q9CbIZNll/ca529VRLBIZRzdCw6h
 5ZI3DdentpldQjlIPIY9oVunLfPdto66wNTLBmQqa8xHxT3flaU2babW+gYFSKlhIzOW
 AnFlbjzjByvv6H3wy8oglbG4e0eSvYHp6Xk/2u83t5MpXxIclsCpHCp6Id1Cbbt2/+u2
 Q4Jg==
X-Gm-Message-State: AC+VfDzN6Tl1exiI7zSK1sKjAyunJvEVDxc5wXMVby+0qAgS9rr+ezRf
 qpEYwkcxBR9j/gsIn/tQa/CHpXYqrRIznr1OXe0=
X-Google-Smtp-Source: ACHHUZ4MKp0vknZ3rkN2pNPpBKSF5qWawY0nkmdfIs85T7b719m0dI+PBJG2UGvg7kfh23Z44dtrBw==
X-Received: by 2002:a05:6a00:801:b0:63d:2260:f7d with SMTP id
 m1-20020a056a00080100b0063d22600f7dmr54301260pfk.8.1684266122352; 
 Tue, 16 May 2023 12:42:02 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 z21-20020aa791d5000000b006260526cf0csm13771165pfa.116.2023.05.16.12.42.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:42:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 17/80] tcg/riscv: Use full load/store helpers in user-only mode
Date: Tue, 16 May 2023 12:40:42 -0700
Message-Id: <20230516194145.1749305-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
 tcg/riscv/tcg-target.c.inc | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 8ed0e2f210..19cd4507fb 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -846,7 +846,6 @@ static void tcg_out_mb(TCGContext *s, TCGArg a0)
  * Load/store and TLB
  */
 
-#if defined(CONFIG_SOFTMMU)
 static void tcg_out_goto(TCGContext *s, const tcg_insn_unit *target)
 {
     tcg_out_opc_jump(s, OPC_JAL, TCG_REG_ZERO, 0);
@@ -893,34 +892,6 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
     tcg_out_goto(s, l->raddr);
     return true;
 }
-#else
-static bool tcg_out_fail_alignment(TCGContext *s, TCGLabelQemuLdst *l)
-{
-    /* resolve label address */
-    if (!reloc_sbimm12(l->label_ptr[0], tcg_splitwx_to_rx(s->code_ptr))) {
-        return false;
-    }
-
-    tcg_out_mov(s, TCG_TYPE_TL, TCG_REG_A1, l->addrlo_reg);
-    tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_A0, TCG_AREG0);
-
-    /* tail call, with the return address back inline. */
-    tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_RA, (uintptr_t)l->raddr);
-    tcg_out_call_int(s, (const void *)(l->is_ld ? helper_unaligned_ld
-                                       : helper_unaligned_st), true);
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
-#endif /* CONFIG_SOFTMMU */
 
 /*
  * For softmmu, perform the TLB load and compare.
-- 
2.34.1


