Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8124977374A
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 05:04:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTCzp-0001MG-P8; Mon, 07 Aug 2023 23:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTCzo-0001L8-DA
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 23:02:56 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTCzm-0006ZF-2a
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 23:02:56 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-686ed1d2594so5014291b3a.2
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 20:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691463773; x=1692068573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PZZSZu8M5U/PcU0xDddsAwmIrS1Z0aEmfJuCGCmTsdA=;
 b=e/iAIBHMt2hlcB+cbx3S0zWJb/t1SpU0uIhpuHer38hgyGb4Tw5n7jWQRI8O2Ubkj0
 G7D3G512RTkvaBuDRfCD1o1scDAJrX3RHGqMzo3Z236rbNcSLA1PprowBWVwAZn9Eut1
 lI4U6ocPfC7UNHizaRL0rutKvv/hutlTfuUx3tB9PVGCs0sreKIYyM7OYDoThn0puzPO
 bLVMxZU8k+h9Ux1A0EdnS0lesZ0NhIDS4O1SEhWeCTE+LJzmMYQN5gBEMIs6Xc/AeRTW
 jDsRG+Vife4zoi1KIDVqPM7EYBT/SzHNiFlS8aVxAoFfg7zH4pUgGER6jlWOz8QGYIIY
 lWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691463773; x=1692068573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PZZSZu8M5U/PcU0xDddsAwmIrS1Z0aEmfJuCGCmTsdA=;
 b=ErfLbbT70OxcvLG/1AUC6SyKt5jI2cDTKEqmXT6udp3EltGSeZfW4g2OG762OKhqRT
 dSuTvm0cUSoJ8PGE/qsCGsqwU7F4hOGooLpKp7sbLj8n+MwAdLGU6geE2RauXsT5kE4U
 tR5cGiu+8mf+xoen7VlFPVVyHauTijgg3Jb2s7+NZksTUzwhiFzSmQfREHUfC83kxgkc
 ANb6PZX1ueEAspWdW/NGrZC2lYqPbe1uQEjFYaVrxI/YCQ8ogCo8P6E/Wqra3Y/gIRBS
 k+4UFW2FeanbbK/sKIiAjW/2fcT59gmWqYIX36KDuoCWKnVkzNHemvBb3wcZcc/mW8V6
 6rNg==
X-Gm-Message-State: AOJu0YyOr3IWGIeWVLwn4h7HwQoM+8mhJwzVOCD71NDzbwx1ZLbmn7L5
 3T8jvLq/pfbggJ3NvyAORhE/2as3IWtdjiHetDY=
X-Google-Smtp-Source: AGHT+IFjN8pZuzvj/6ciS65xyG3Ab1XUGi7Hlo3zPRGeD1HctgPudjYnKjl8M+fuKw7shHP9R7Yykg==
X-Received: by 2002:a05:6a20:3d94:b0:140:a6ec:b55f with SMTP id
 s20-20020a056a203d9400b00140a6ecb55fmr8968954pzi.16.1691463772836; 
 Mon, 07 Aug 2023 20:02:52 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 r7-20020a62e407000000b006870c50efaesm6903609pfh.9.2023.08.07.20.02.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 20:02:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: npiggin@gmail.com,
	jniethe5@gmail.com,
	qemu-ppc@nongnu.org
Subject: [PATCH v2 1/7] tcg/ppc: Untabify tcg-target.c.inc
Date: Mon,  7 Aug 2023 20:02:44 -0700
Message-Id: <20230808030250.50602-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808030250.50602-1-richard.henderson@linaro.org>
References: <20230808030250.50602-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 511e14b180..642d0fd128 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -221,7 +221,7 @@ static inline bool in_range_b(tcg_target_long target)
 }
 
 static uint32_t reloc_pc24_val(const tcg_insn_unit *pc,
-			       const tcg_insn_unit *target)
+                               const tcg_insn_unit *target)
 {
     ptrdiff_t disp = tcg_ptr_byte_diff(target, pc);
     tcg_debug_assert(in_range_b(disp));
@@ -241,7 +241,7 @@ static bool reloc_pc24(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
 }
 
 static uint16_t reloc_pc14_val(const tcg_insn_unit *pc,
-			       const tcg_insn_unit *target)
+                               const tcg_insn_unit *target)
 {
     ptrdiff_t disp = tcg_ptr_byte_diff(target, pc);
     tcg_debug_assert(disp == (int16_t) disp);
@@ -3587,7 +3587,7 @@ static void expand_vec_mul(TCGType type, unsigned vece, TCGv_vec v0,
                   tcgv_vec_arg(t1), tcgv_vec_arg(t2));
         vec_gen_3(INDEX_op_ppc_pkum_vec, type, vece, tcgv_vec_arg(v0),
                   tcgv_vec_arg(v0), tcgv_vec_arg(t1));
-	break;
+        break;
 
     case MO_32:
         tcg_debug_assert(!have_isa_2_07);
-- 
2.34.1


