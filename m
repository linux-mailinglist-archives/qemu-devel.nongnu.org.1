Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C6F77D3C9
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 22:00:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW0Ao-00053O-AK; Tue, 15 Aug 2023 15:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qW0Am-00052Q-Nv
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 15:57:48 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qW0Aj-00012Y-2h
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 15:57:48 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6887059f121so586475b3a.3
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 12:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692129463; x=1692734263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PZZSZu8M5U/PcU0xDddsAwmIrS1Z0aEmfJuCGCmTsdA=;
 b=n0Z6Cu6ZV7rmZah9JdMSjq6mIdC1qR4M4a4aWFe9U52OIBflhWADyfCn1b0qaDbGO9
 2OVQg5YGC5kamq4YUm5LnOkuBBZdoJkHp1fb+/SfHZiHOvx1NrrRkd4HM+epfVHiU+lz
 Dlezj4sTuvN+3Uz09brVGJf2RKeQHvLxWs+KPn9YmZ6Db4oOWKth6Q63Gy5ZFlxgCUMM
 bkc3lfQmMjtF48j7pNvqlQRiUeJyV7O3lzqgHRDQ9SSVGxjcWxGaP6yDy6T2GqRaEbI6
 BwyfWlVLlqT9MU79TDl9rZq2mufolp3k70ztNh7IcOomZw7yU7OBqDiaS2NvSaAkWAn/
 /w5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692129463; x=1692734263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PZZSZu8M5U/PcU0xDddsAwmIrS1Z0aEmfJuCGCmTsdA=;
 b=gRR1YK16sXqBeApujxapEDs/trm8F26B9Lzb89S9DhtD7SHg0Na7y+LsnJNadU4n+F
 Q4MrZ9mfcum/9XS6wzyBoalY8LotPdc1drtZf7rwq60Q+jd/EgPnpn84+7mgZmRoBjnV
 tCZp46Atf9fOH836Y486JgHSxH8UXA20bfBzKI9P5a6rctPteMiXvWjDSrxjn/3ePLb+
 MvyMPviZ5b+j8207U6YJpLMvQg9tlXG4QviiNfk+F4+FIC8j60AgGF5ZxoOYbxlsRXX1
 TczxoXNo5O8s/EuuksU0WTX4KTBhjHgB8yKTKO2pnUc077yFpOZJZYNSMX4D4iBKXheK
 7uXw==
X-Gm-Message-State: AOJu0YxHSBmiTReYb+aCcFfRtzeVmhCG/J5IlGhJQ00aq+R+CvedzyIE
 cipati85ZsXgeE4DVdsCtD+TWk1nS3tDjqdYokg=
X-Google-Smtp-Source: AGHT+IGukj38lkHvHU+zGwDyy8mP5ioY1yQbpHjotJHn5raXFUoKiNWSiGqH5M03NzZRs3LQQW/9jQ==
X-Received: by 2002:a05:6a00:10c7:b0:688:535b:717d with SMTP id
 d7-20020a056a0010c700b00688535b717dmr2132919pfu.30.1692129463505; 
 Tue, 15 Aug 2023 12:57:43 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:8d06:f27b:d26c:91c1])
 by smtp.gmail.com with ESMTPSA id
 n7-20020a62e507000000b00686b649cdd0sm9667699pff.86.2023.08.15.12.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 12:57:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org,
	jniethe5@gmail.com
Subject: [PATCH v3 01/14] tcg/ppc: Untabify tcg-target.c.inc
Date: Tue, 15 Aug 2023 12:57:28 -0700
Message-Id: <20230815195741.8325-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815195741.8325-1-richard.henderson@linaro.org>
References: <20230815195741.8325-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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


