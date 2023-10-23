Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 058397D3EFA
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:18:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzQu-0005UO-KR; Mon, 23 Oct 2023 14:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzQq-0005Tb-5v
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:40 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzQk-00084r-ML
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:39 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5842c251d7cso1760725eaf.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 11:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698084812; x=1698689612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AA7L0NLzkIrOUcDjlwriga27ooiuuZ7zo9pLt3rHark=;
 b=F7A1RbUMV/uPK4zcLlGQw9iEv54WZHHHMcmPA6G2ov8QZT3gjsqT67b/NNhmL/BArp
 0vPFdWMddjr0Oyh/nz2J+e9S/G7z6qAEiX94hm9RXrHLztlyPYOBcysp2s3zuTwDPFKo
 Abhom6Ew3dANGzjSIOy6R1fVqcdj+P8S8malI6n0dExmouYHcnCo0foNEmCFrWGAviq+
 mq0+8mqp58w/L/wnfBa7s4MV3MOfPMJbbRaaRQLoKt9CQZeoT939VfazyNt82/Fjg5Rh
 8vpWinWXDSkvPrBaNw0hYb0LOstPuqFns2jk5yINvKkGyt4ulqck1CYGQKRY9RAcX8JP
 JB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698084812; x=1698689612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AA7L0NLzkIrOUcDjlwriga27ooiuuZ7zo9pLt3rHark=;
 b=I+NcaAsizoZWOL9yExLyInFKFyDNo3M/E45W1ODLfLiVVOW/R6S+1WBcdPE7S8ZrS8
 L2O4WJrK949Z7jH1RSP5ryOGpDr4ph8bKnEMZFir5Pv/VNjjgAJjEysTkvS5vwLuiJS1
 jtdEqtHrx1d5DkkbF3oa+yfWUqFXw2T4ftoZCspbDVC8KS71uKPDSgRoXs40OHwwZhSP
 lpBWIqA/kH/3BgUgIqouAHHubDdCTBmT2nzzq/26FgfvE2EI6QIvXIZbxiG0ISmhOncJ
 nEBMgd2s54y9BX4mBHbwVbWGwARDdtd8E/moF6oH5sqaqo+R2ym+PztGhtOhshU9wHPB
 drXw==
X-Gm-Message-State: AOJu0Yzg6TvspiiDu1BtHROtvLzg2yiBwY6O6Pb1ORmjeBLepnsFDB7R
 PJJnVSu/nCsSs6rOHwc07O56fYCKrl5An0E/ft4=
X-Google-Smtp-Source: AGHT+IEZOTZV89AvubM81Goo2+Irk0ayhwqnNr9/HMamnqMfRvKr3GqKLqlA0FcT6UScf4uwB2LY7w==
X-Received: by 2002:a05:6358:15c6:b0:168:e1d3:adf2 with SMTP id
 t6-20020a05635815c600b00168e1d3adf2mr3127812rwh.2.1698084812243; 
 Mon, 23 Oct 2023 11:13:32 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v10-20020a65568a000000b005b83bc255fbsm5205137pgs.71.2023.10.23.11.13.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 11:13:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v3 01/38] tcg/ppc: Untabify tcg-target.c.inc
Date: Mon, 23 Oct 2023 11:12:52 -0700
Message-Id: <20231023181329.171490-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023181329.171490-1-richard.henderson@linaro.org>
References: <20231023181329.171490-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc36.google.com
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


