Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FF9716D51
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:17:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44o4-0006YF-BY; Tue, 30 May 2023 15:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44nw-00065V-DC
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:14:49 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44nt-0004dK-Ta
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:14:48 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-64d5b4c3ffeso3567398b3a.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 12:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685474084; x=1688066084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QJBfhL5s/JujOKO92cVuqA077g93rVli8DiADyiaM+o=;
 b=eOvUz7Ddp8ODeyX9jX5snYHI997v80KRwXBk0EeTt7+c9V5OHwbZ5Y3PmXg3Thahys
 5EwbBmFLOuFT5NedmWPThpC6NcEw9GcDCFJESONFBtZFDjkzSk93u59kJPcpFGrEMOmT
 vZ8OEvn0WwwqQd7AwFf0W0zJAx2rDFSvQF7eSc2qgBJ3opHzc5EEfMKOmALzUaktZZYL
 2ULlxkqgtrAtd7IQQMnEVtQjVbkzVag+00FAtE8Tc2aFqeYnft15ZiuYUaPRUOutuT9x
 KjXHcQ+c/eV4N74KCmq90/Bck5DqxL0OieA6fdo4x2q3FfI+chtfPAPuScT9mUkLvFAe
 J+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685474084; x=1688066084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QJBfhL5s/JujOKO92cVuqA077g93rVli8DiADyiaM+o=;
 b=BZ/5ZUiYPB2RwyuccYmABZSkLzo1/Za3aQyP9HcUR3fFO55iYVZr78ANjlRyV+Kdmr
 WbNYNvPj9+vGuLogJAImuQfBLze6c5Qss3kfnnG/1ke1jdR3LGDlVWt7yw+AAonhPslE
 y1v7YBBRUiio96UmP20OO8t49FhTjNWO0qtUxeWZahyvvXonX8vlHnbxfiZJ/16nE+/p
 KGvfRgRufQwzjLZ9yyF5N5DfeI/7jW/3sS9kJUP7EkEdiFHEkKtYD8MMh2dFz9vCCDKI
 SjXs1PgXLhVpFpmOUBjES9C1jDPJf99Wun+bxlBJpb4TCqjSrClAbrLkydzWWbTburKh
 e8aw==
X-Gm-Message-State: AC+VfDxK3A98C2ILawsKGnzyXCtjOdjtFWe+2JVGHMNOL0GpfITkJW67
 O0+V9EINmYlqBCK190hFWIGXYRrLPlQdN4gefDM=
X-Google-Smtp-Source: ACHHUZ6vjFE8O9aceFAhoDOgw+wWNl2cFOZ4hXPoYq4bvwG8RxStzBBK54bTSVHGPSuhocuTvtBcuQ==
X-Received: by 2002:a05:6a21:998d:b0:10b:d70d:f96b with SMTP id
 ve13-20020a056a21998d00b0010bd70df96bmr4213441pzb.3.1685474084493; 
 Tue, 30 May 2023 12:14:44 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 10-20020a63104a000000b0051806da5cd6sm8926757pgq.60.2023.05.30.12.14.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 12:14:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 06/20] target/arm: Use tcg_gen_qemu_st_i128 for STZG, STZ2G
Date: Tue, 30 May 2023 12:14:24 -0700
Message-Id: <20230530191438.411344-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530191438.411344-1-richard.henderson@linaro.org>
References: <20230530191438.411344-1-richard.henderson@linaro.org>
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
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This fixes a bug in that these two insns should have been using atomic
16-byte stores, since MTE is ARMv8.5 and LSE2 is mandatory from ARMv8.4.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 6bb68618a0..51f9d227e7 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -4070,15 +4070,18 @@ static void disas_ldst_tag(DisasContext *s, uint32_t insn)
 
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


