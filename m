Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7597C8C17
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 19:11:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrLg4-0000zw-2B; Fri, 13 Oct 2023 13:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrLg1-0000zd-Lx
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 13:10:17 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrLg0-0005UN-6X
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 13:10:17 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-69101022969so2071375b3a.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 10:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697217015; x=1697821815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AA7L0NLzkIrOUcDjlwriga27ooiuuZ7zo9pLt3rHark=;
 b=zAr7HhnWv1a2AnY3Wg6qIaR+VpmihKb2yYlsbfvrtVZJ7ot1VAJ2TCSPEZeI2tBT48
 uD+YRfBbq0bCOEAiR8YwLfk5LTaQtqXY0/ksavJgrnz+eseNcka82Ob/l+gxZIpmLKBK
 hv9XckACF52/a3/SwYblPckwiJrCRCh43RrKTLDMIMFhfsOgBJq9PeOJsd8mTDjv5r5M
 X0+PuBX++5VVf2C1h63hUV2Ih/924i7EuNI/pfgvM6O3cSLd4M2OflAI9fQ3NUTacgUt
 RqSFOCcFFMKG0maG42+Ufo0UtMuixz66lqRyNPod/CcqEcn6pGZ9sV6117zvWXGdwKLQ
 uycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697217015; x=1697821815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AA7L0NLzkIrOUcDjlwriga27ooiuuZ7zo9pLt3rHark=;
 b=QfV8rVLrW8DQzdz7ZjmsKEqf0EwGczIxPCDPCAid44F4m8HJr8HijvcTe+JQJA3Y4n
 tGLWSiMRWLMr2IFnAAxUaUqBXGGO61sT2Sx1oD/eP0I5NHRJ5icGhNOG23QVtTf32y1T
 fbXN2UjyaHGQMhaPTy31EuV7K0xbeENnx6SA6cQlZrO1EeL2dfT3KabMDnhD2SA63TyF
 82TYoKPk+7pzq8jT49WTYi9l/lBEmi9vEcTWZX/DrzS1qCNeIVjWcTvmbfRm/Cb5mXNE
 GzJfnDc20CXRiYTvk3I73uKyR/YjiMjwmx76UssU0GQhjrW9lnpa0sw9B7+rMj0+qRlJ
 fUKQ==
X-Gm-Message-State: AOJu0Yy1Dt5BpCTfpH041BtiXLeltpZOjrD2BAxtHtyPQPB5KsKnqP0n
 0tg9iPjuu/rY/K47uPNnJGUkExUeGBbkURSeSao=
X-Google-Smtp-Source: AGHT+IG1FKv9c3cqo0yL7ScRk/J82UaPtXD8VT0EiJjtE5T8XwCZH8IBNdeMBbKPou3TSyTD9GOyaA==
X-Received: by 2002:a05:6a00:1494:b0:693:3870:edf5 with SMTP id
 v20-20020a056a00149400b006933870edf5mr33258537pfu.22.1697217014847; 
 Fri, 13 Oct 2023 10:10:14 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020a62e507000000b00693411c6c3csm13687926pff.39.2023.10.13.10.10.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 10:10:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: jniethe5@gmail.com
Subject: [PATCH v4 01/13] tcg/ppc: Untabify tcg-target.c.inc
Date: Fri, 13 Oct 2023 10:10:00 -0700
Message-Id: <20231013171012.122980-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013171012.122980-1-richard.henderson@linaro.org>
References: <20231013171012.122980-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 5c873b2161..5cecc6ed95 100644
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
@@ -3645,7 +3645,7 @@ static void expand_vec_mul(TCGType type, unsigned vece, TCGv_vec v0,
                   tcgv_vec_arg(t1), tcgv_vec_arg(t2));
         vec_gen_3(INDEX_op_ppc_pkum_vec, type, vece, tcgv_vec_arg(v0),
                   tcgv_vec_arg(v0), tcgv_vec_arg(t1));
-	break;
+        break;
 
     case MO_32:
         tcg_debug_assert(!have_isa_2_07);
-- 
2.34.1


