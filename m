Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C067D7B6B
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 06:15:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvrlB-0002XI-OD; Thu, 26 Oct 2023 00:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvrl7-0002VW-BW
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 00:14:13 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvrl5-0000jK-3M
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 00:14:13 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1c5cd27b1acso3602135ad.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 21:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698293648; x=1698898448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lPY9mxzDBbOf1owj0FOY1MUzjClJ3s1wsYFvJx2toV4=;
 b=SKkv3jNEnzmbGHw48dQoUIRneJTwcrut1YGwQpz6az5vbuLLYPEgEO2HGhScAZSXU7
 bwVlf/dzW7OwuWJAE0Ylrf6cvf887oQBMULo820B3En945VvrSLxtl4DZ1qKnswZxki1
 pSt6XDjgqVzbwoz2bTJpXSqBpShUoq1w8znSJLAqiaNhYdy9nC6V9Yj6DiD0UVPOEdJO
 DebZyXBh+wFvod4eGqfaMfYfzfUEo7jHn6CO+6FU+BcgEmXjB+jl6pMJc/E+QFORn66k
 Rf/WP8oiox1XeNO1wDPlzjbw/2clKpAeXgNN3d7VUiTyop0t1nZZi2y7u5S//oH7gyuI
 jpfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698293648; x=1698898448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lPY9mxzDBbOf1owj0FOY1MUzjClJ3s1wsYFvJx2toV4=;
 b=VQJ1dKwP/JObWAvuPCJoZDsgxeJ+uCJE/yCx6Xb2AIfi+70HZviYTifyURjb1ffeQx
 BbwxMlZT+h2vsv3+gqVIFJGpmXtjxUWK0tTjatFrhMUQj5XkV3zceSiaEsVEBqppcyTV
 wHaEEaI+MR8cwipWz0oPMnbFnpIi+9av0ofQz+8tyeDqSlsWpvn0sNB9ozq9mDjfRaW2
 YV/FTib0IvcB/6ASodAtNartSjiFrgCKZnr9iIAgH0xLUKAJvGQSDJZSIDJvngrj9LpD
 pBfLM9U6iaR+ysoU24WgmkuK3ZlaIdJaLuCz8/FqHaXNB77u8Oow/BGfa8SUwPh66I7S
 pf8A==
X-Gm-Message-State: AOJu0YwbfdklVsnWi8USNn3JKSbIMLurHAo3ci3rzpVKhxIgn2lXrykl
 6E6KZx++C4UoMjB0S7ScXNsHCAEXjxSQpSvCRvk=
X-Google-Smtp-Source: AGHT+IFkaI6LUNRwyFKX9xzw6jO1vE22RxU4GVfFBe7jyHbWcGPWac+SVbNw4i4wd+zhuHFHS2q/ag==
X-Received: by 2002:a17:902:f686:b0:1c7:5f03:8562 with SMTP id
 l6-20020a170902f68600b001c75f038562mr19992779plg.30.1698293648581; 
 Wed, 25 Oct 2023 21:14:08 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 i12-20020a170902eb4c00b001b8b2b95068sm9953929pli.204.2023.10.25.21.14.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 21:14:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/6] tcg/mips: Implement neg opcodes
Date: Wed, 25 Oct 2023 21:14:02 -0700
Message-Id: <20231026041404.1229328-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026041404.1229328-1-richard.henderson@linaro.org>
References: <20231026041404.1229328-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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
 tcg/mips/tcg-target.h     | 4 ++--
 tcg/mips/tcg-target.c.inc | 8 ++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index 5b3fdcc726..20c14224fb 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -184,12 +184,12 @@ extern bool use_mips32r2_instructions;
 #endif
 
 /* optional instructions automatically implemented */
-#define TCG_TARGET_HAS_neg_i32          0 /* sub  rd, zero, rt   */
+#define TCG_TARGET_HAS_neg_i32          1
 #define TCG_TARGET_HAS_ext8u_i32        0 /* andi rt, rs, 0xff   */
 #define TCG_TARGET_HAS_ext16u_i32       0 /* andi rt, rs, 0xffff */
 
 #if TCG_TARGET_REG_BITS == 64
-#define TCG_TARGET_HAS_neg_i64          0 /* sub  rd, zero, rt   */
+#define TCG_TARGET_HAS_neg_i64          1
 #define TCG_TARGET_HAS_ext8u_i64        0 /* andi rt, rs, 0xff   */
 #define TCG_TARGET_HAS_ext16u_i64       0 /* andi rt, rs, 0xffff */
 #endif
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index f9b790ed8a..c38f5c9450 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1935,6 +1935,12 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         tcg_out_opc_reg(s, OPC_MFHI, a1, 0, 0);
         break;
 
+    case INDEX_op_neg_i32:
+        i1 = OPC_SUBU;
+        goto do_unary;
+    case INDEX_op_neg_i64:
+        i1 = OPC_DSUBU;
+        goto do_unary;
     case INDEX_op_not_i32:
     case INDEX_op_not_i64:
         i1 = OPC_NOR;
@@ -2159,6 +2165,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_ld16u_i32:
     case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
+    case INDEX_op_neg_i32:
     case INDEX_op_not_i32:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
@@ -2172,6 +2179,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld_i64:
+    case INDEX_op_neg_i64:
     case INDEX_op_not_i64:
     case INDEX_op_bswap16_i64:
     case INDEX_op_bswap32_i64:
-- 
2.34.1


