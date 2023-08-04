Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EEA770B16
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 23:35:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS2Qw-00068z-QZ; Fri, 04 Aug 2023 17:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2Qu-00068D-6n
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 17:34:04 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2Qq-0001rA-Ad
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 17:34:03 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bb119be881so22238665ad.3
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 14:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691184838; x=1691789638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PZZSZu8M5U/PcU0xDddsAwmIrS1Z0aEmfJuCGCmTsdA=;
 b=Xk3vgCLxyyUSDKLK+SFS3WHOokYeVYFmqTtdbFoki9x27es/e8OWBXqlYQAH3xENZn
 4+N0wIyNDDRekgSPZlHHLDJfm5PNEeuGoV7gWs6F6XMd5Et4aBdfUQayBiZG4sBa/QIC
 kkE8FdXqlpEIcuCKpboSVPnHLpIQiebESLtM0+Tfc2IbI7p0Q7odksyMnKXiM1jRQypa
 BuP0KM+lnsZrG6cfQL2fFn/23mfYNMMkQAK0eVafttEiA6G7Ya6p8c5rHuMXll7K5sFt
 /kIy9Sn+xrmqliGBcWUQUijnyIF4izJXmx1OIgCuIpATDL3j27aBAhY8QG0lZnaOBz32
 mplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691184838; x=1691789638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PZZSZu8M5U/PcU0xDddsAwmIrS1Z0aEmfJuCGCmTsdA=;
 b=EZYU+5Gsbx7llYLe9nrBOVYbFnEO9Pe6aJApbq/xeaQDaXibdoR9Rutd7XA4Q7QPU3
 2cXRoequ03ucoZpowUCllxB9Ky/glBTx7SNj1eIXFT13gbpNFTzsgSv3luNjxqYxaOnG
 nRHEZ8F8cxxSqscjay/R+YtxYlIrUATiNT2TrRWnzw39tyC5N0TGBU+viXKSZEA43/By
 cF451QgTO1Fu1Br/z/AvLWrXmCvNXggz2cVaA2pg84339CG5xbmEjFfdBSGHk6dDCP+E
 o1d5kB2WrKMmqlPHspCetZ7AU+PIu5Q7VONVjcM1rY7pVSmpP7VeddE/SQfKgMUMYgxo
 uing==
X-Gm-Message-State: AOJu0YxvoWJFxBeBqDXRa3slpjGLHI/CgnAVdVN4u+rDhBVH4Vu8poyo
 S/uNyO9U21kSttsY8j/bx1g7NIDGQ3bi3bW1aK0=
X-Google-Smtp-Source: AGHT+IEu77czyk5M8btGorPaNgW5PkirhYyTpSLYYoAZBn2IfRFpkZtvs1LWbQPp2Ed/plsziYIRHw==
X-Received: by 2002:a17:902:d4c3:b0:1b8:b285:ec96 with SMTP id
 o3-20020a170902d4c300b001b8b285ec96mr3510005plg.23.1691184837762; 
 Fri, 04 Aug 2023 14:33:57 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:1eed:f77f:f320:8b14])
 by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001ae0152d280sm2188662plg.193.2023.08.04.14.33.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 14:33:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: jniethe5@gmail.com,
	qemu-ppc@nongnu.org,
	bgray@linux.ibm.com
Subject: [PATCH 1/7] tcg/ppc: Untabify tcg-target.c.inc
Date: Fri,  4 Aug 2023 14:33:49 -0700
Message-Id: <20230804213355.294443-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804213355.294443-1-richard.henderson@linaro.org>
References: <20230804213355.294443-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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


