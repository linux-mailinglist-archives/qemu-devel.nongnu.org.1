Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 550FA7D62F3
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 09:33:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvYIa-0000Fm-BA; Wed, 25 Oct 2023 03:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIX-0000EZ-BB
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:25 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIV-0004gt-Ql
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:25 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1c9e072472bso38256555ad.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 00:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698218842; x=1698823642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rVEq4DsEieVQejMYJAckiF1y6NMA1Ry2WtOvV/eWoA0=;
 b=OvCaGM8scc1KXKQGA/eUcT85Uw7a04t8xAOqz7oj3yg61XCsntuDgrUz65Oztm9Qk7
 sc2aw3XecmKWUm7352QUpZjm57bhI8UpMWSx9BLUaZbizjQAuwdKuu7SF1WfjqSwCZyW
 FtaOCYM2P5ET3NdP5ygx71H3lPsB+APtoBDhzpj4iZdRnee2TuPvg+Ep9vhwoSa3/hbQ
 WeM8jH4t3yQGTAHnqAokcWNsgTX7m7+W7Eicsp4dS35EsJaxjweeISNtPIdwUJS9yoJB
 rVWXxnn2bVIEPnTMUROzBmG3A1mkUfw2coGhTxrvLOVmrzugjtyjqpBuQlzvccBGbkU9
 Anmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698218842; x=1698823642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rVEq4DsEieVQejMYJAckiF1y6NMA1Ry2WtOvV/eWoA0=;
 b=UCqxLdsExH+TMXkHF/2umyd6xpJsNljxzeKxVk2PAaJyWFFP/C428PqM2/O6FVYgY0
 79J075T9FVnpo/hVV3XhwgJ/YAecRKZ/3noSW/oz6KrdNmeZ5xsfBSmDL0VTNDy9cgZo
 6aC+o6aAdoDel5T4rL52mdVYdmBp7mHOkqjRJkveGQLxSRTRUD/bw60hVzaSSBIu5trx
 CJ1UX4vw4bCayf6SoZmvnC0BR4CgUAunFujl1h1AvI30bLQqot6aDYzJ0dNPyn9h4j0D
 VXYFRvgI6FlldmYiK2Vd8YCc1LHsAI9Jj8UrFwaEBnKirwwIVVQL3m1CWce6KL+/rUVE
 TSQA==
X-Gm-Message-State: AOJu0YyIyFgN10wQxCTberBbwZqZkH5GkZ9d8JdGvYt3nTwD0rr1dQdh
 WPwKf6mKiy8WplWKQrUoFY7SWrSmHerJSxjkGTI=
X-Google-Smtp-Source: AGHT+IH2VFbmkOF1PeSofsu9oO7KkgDHZUf3FUG7rLy1j5/I06qBbL+MmZRHAJ4i8JfFFMtqayd+ow==
X-Received: by 2002:a17:902:7407:b0:1ca:86db:1d31 with SMTP id
 g7-20020a170902740700b001ca86db1d31mr12558198pll.7.1698218842628; 
 Wed, 25 Oct 2023 00:27:22 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ji5-20020a170903324500b001b06c106844sm8578661plb.151.2023.10.25.00.27.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 00:27:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 15/29] tcg/mips: Support TCG_COND_TST{EQ,NE}
Date: Wed, 25 Oct 2023 00:26:53 -0700
Message-Id: <20231025072707.833943-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025072707.833943-1-richard.henderson@linaro.org>
References: <20231025072707.833943-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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
 tcg/mips/tcg-target.c.inc | 41 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 328984ccff..739a0f60b7 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -909,6 +909,16 @@ static void tcg_out_setcond(TCGContext *s, TCGCond cond, TCGReg ret,
         tcg_out_opc_reg(s, OPC_SLTU, ret, TCG_REG_ZERO, arg1);
         break;
 
+    case TCG_COND_TSTEQ:
+        tcg_out_opc_reg(s, OPC_AND, ret, arg1, arg2);
+        tcg_out_opc_imm(s, OPC_SLTIU, ret, ret, 1);
+        break;
+
+    case TCG_COND_TSTNE:
+        tcg_out_opc_reg(s, OPC_AND, ret, arg1, arg2);
+        tcg_out_opc_reg(s, OPC_SLTU, ret, TCG_REG_ZERO, ret);
+        break;
+
     case TCG_COND_LT:
     case TCG_COND_GE:
     case TCG_COND_LE:
@@ -989,6 +999,14 @@ static void tcg_out_brcond(TCGContext *s, TCGCond cond, TCGReg arg1,
         arg2 = TCG_REG_ZERO;
         break;
 
+    case TCG_COND_TSTEQ:
+    case TCG_COND_TSTNE:
+        tcg_out_opc_reg(s, OPC_AND, TCG_TMP0, arg1, arg2);
+        arg1 = TCG_TMP0;
+        arg2 = TCG_REG_ZERO;
+        b_opc = cond == TCG_COND_TSTEQ ? OPC_BEQ : OPC_BNE;
+        break;
+
     default:
         g_assert_not_reached();
         break;
@@ -1052,6 +1070,14 @@ static void tcg_out_setcond2(TCGContext *s, TCGCond cond, TCGReg ret,
         tcg_out_setcond(s, cond, ret, tmp1, TCG_REG_ZERO);
         break;
 
+    case TCG_COND_TSTEQ:
+    case TCG_COND_TSTNE:
+        tcg_out_opc_reg(s, OPC_AND, TCG_TMP0, al, bl);
+        tcg_out_opc_reg(s, OPC_AND, TCG_TMP1, ah, bh);
+        tcg_out_opc_reg(s, OPC_OR, ret, TCG_TMP0, TCG_TMP1);
+        tcg_out_setcond(s, tcg_eqne_cond(cond), ret, tmp1, TCG_REG_ZERO);
+        break;
+
     default:
         tcg_out_setcond(s, TCG_COND_EQ, tmp0, ah, bh);
         tcg_out_setcond(s, tcg_unsigned_cond(cond), tmp1, al, bl);
@@ -1078,6 +1104,13 @@ static void tcg_out_brcond2(TCGContext *s, TCGCond cond, TCGReg al, TCGReg ah,
         tmp = tcg_out_reduce_eq2(s, TCG_TMP0, TCG_TMP1, al, ah, bl, bh);
         break;
 
+    case TCG_COND_TSTEQ:
+    case TCG_COND_TSTNE:
+        tcg_out_opc_reg(s, OPC_AND, TCG_TMP0, al, bl);
+        tcg_out_opc_reg(s, OPC_AND, TCG_TMP1, ah, bh);
+        tcg_out_opc_reg(s, OPC_OR, TCG_TMP1, TCG_TMP1, TCG_TMP0);
+        break;
+
     default:
         /* Minimize code size by preferring a compare not requiring INV.  */
         if (mips_cmp_map[cond] & MIPS_CMP_INV) {
@@ -1114,6 +1147,14 @@ static void tcg_out_movcond(TCGContext *s, TCGCond cond, TCGReg ret,
         }
         break;
 
+    case TCG_COND_TSTEQ:
+        eqz = true;
+        /* FALLTHRU */
+    case TCG_COND_TSTNE:
+        tcg_out_opc_reg(s, OPC_AND, TCG_TMP0, c1, c2);
+        c1 = TCG_TMP0;
+        break;
+
     default:
         /* Minimize code size by preferring a compare not requiring INV.  */
         if (mips_cmp_map[cond] & MIPS_CMP_INV) {
-- 
2.34.1


