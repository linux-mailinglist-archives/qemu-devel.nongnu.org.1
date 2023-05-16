Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E051D7057B4
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:43:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0Yh-0006gr-G6; Tue, 16 May 2023 15:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0Ye-0006f8-GO
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:42:04 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0Yc-0002og-Rw
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:42:04 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-643aad3bc41so13989099b3a.0
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266121; x=1686858121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c2X0vEktAU9CIzOCMmP9cn2Oif9GXs/gZcvny2bfDX8=;
 b=uvl0ZopTb8oIbfZ5g+2Qo3kJXWessNouX2EwNEfvea1iYehrUVBtUpim9RYYqYGEzW
 AT8229jFrj1s6YDlhNnmwi3G6/ChKAt8BJvsbYPAZed0/STx0vU21ZlvIpUhvsZydzS4
 zumYBD31G7H3k8bS6ebFhNTF/if7K4ruxTt1jZXgkQonnwOBwaod7xEFTwfCD54kyURF
 PRNmPMMVg88RRVEifNVZWWKldjwxOVflfQWcTdZpdrKIoqjI/6VhWmvS8NuSUj8LJOkA
 uPm/DCXL7cy1yXQa1Uxhgha6cDIso6ZUu/kj6wqtVle2k3/BKCV2NAobWT67xPqdeRA6
 iyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266121; x=1686858121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c2X0vEktAU9CIzOCMmP9cn2Oif9GXs/gZcvny2bfDX8=;
 b=Cdfxj4QrWCtg3VTYYLeFjfuGp4aDvO7dLBvUC/CkiIk7KGd3rpH0Q1zYKszaOZqp/W
 6rEE5xwEeDftJqnlHRnTSS76IqTMmv+ARh7GmQKT1CX2j7SCXNfu3TFEK4oG8oqapbsu
 MZVvkvDQA7G1R9qlzDDVuRWMcHWMvvbC1vmLx7P7uBk6k5ZOfLQGJYKhkfvqh4ARQ+gm
 HFWNy98kT1hcT5R1RA9z9mwCVM09gP/O7F09EHlU6LMQdg9GEbaSzkjF1LE9993U9k/7
 Ox4gnCgk23A8Vye3jrC+woc0hA4BjGhYUw/YhVwA4xzSr4r9yVBT0Bb6nbeClnk1mKNa
 WS3w==
X-Gm-Message-State: AC+VfDxB7ShNF56xmaTcrGHaRgnkxLPzQkEWMiSbu/KLSlt30cudvrA1
 k33BEgtZeFGU+QdVTRGqYRE8wbqu0wNuwX4Kh9U=
X-Google-Smtp-Source: ACHHUZ5fyW3BOX1n3tgdRe7VdoiKy94zbcgBd9DSKaiXaUgEgrfvz8Lwaq1H/6bKMv1c7MVlLrTl0A==
X-Received: by 2002:a05:6a00:1749:b0:64a:f730:154b with SMTP id
 j9-20020a056a00174900b0064af730154bmr18049143pfc.5.1684266121556; 
 Tue, 16 May 2023 12:42:01 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 z21-20020aa791d5000000b006260526cf0csm13771165pfa.116.2023.05.16.12.42.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:42:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 16/80] tcg/loongarch64: Use full load/store helpers in
 user-only mode
Date: Tue, 16 May 2023 12:40:41 -0700
Message-Id: <20230516194145.1749305-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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
 tcg/loongarch64/tcg-target.c.inc | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index d1bc29826f..e651ec5c71 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -783,7 +783,6 @@ static bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
  * Load/store helpers for SoftMMU, and qemu_ld/st implementations
  */
 
-#if defined(CONFIG_SOFTMMU)
 static bool tcg_out_goto(TCGContext *s, const tcg_insn_unit *target)
 {
     tcg_out_opc_b(s, 0);
@@ -822,35 +821,6 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
     tcg_out_call_int(s, qemu_st_helpers[opc & MO_SIZE], false);
     return tcg_out_goto(s, l->raddr);
 }
-#else
-static bool tcg_out_fail_alignment(TCGContext *s, TCGLabelQemuLdst *l)
-{
-    /* resolve label address */
-    if (!reloc_br_sk16(l->label_ptr[0], tcg_splitwx_to_rx(s->code_ptr))) {
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
-
-#endif /* CONFIG_SOFTMMU */
 
 typedef struct {
     TCGReg base;
-- 
2.34.1


