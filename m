Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4197DA91A
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:49:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwpG1-0004uy-83; Sat, 28 Oct 2023 15:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFg-0004ko-6Q
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:49 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFe-00048P-DR
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:43 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6b3c2607d9bso2910957b3a.1
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698522340; x=1699127140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FATcYYBcT5Qcr4CmjwLfHyaaqUPwRVxCY1BCP+WOhQw=;
 b=u5Y1tfMf9IJAcKxqPAwYF6WogSzsvXu1kLsSE3diwyYr+Lo7XjzMC0Kh7Trw4uvmUt
 RORpa+S/mponZJO+8Gu60KqU+rnD8DlfGbVm4/PVKlX+HJkNqHC2Y25OATiCu4foYh7l
 /6r1HScUKQshXeaOe6BC0xzrUUxCB5sfj5IXYq+C9xr0xEwYQe4DpI+ZVRrKrqAO0YnN
 73hJkcJ2ja/+ystvr0Mf4qpt5lwg2kRZ6wTgecyOtV5fZ0gvs4JfnLO51X33FfIpsA5b
 x9rvFppYYAS1nR3aO/G+2YVwupVPWmvsIl5Wfebh0IQyBvsO8JaisaBX8UqSjSyqWQgV
 8CvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698522340; x=1699127140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FATcYYBcT5Qcr4CmjwLfHyaaqUPwRVxCY1BCP+WOhQw=;
 b=Fb7qG2QSGuh4GMULok+Dn1SVxrR341BeHa+xF4W0Yi1IlNoTrYE/35siaPuT2psjz7
 cfS/7PhRCf8AzmvFIYucXV3wJkEU6m6h107gYcyNzWFbiFXkBZGr9sS074Y4CjjCIMOo
 NMYdpeSyOHrAC7t8Kmoz/HRc72n5v0BnGOzYe6XvfC0JmTXw7PXDD/u2+7EeZ1oJ0mJS
 qMVIoY4VOGPbyGer5AWjyPtLmgI9pwVwhco10g1nGUd6I0TDosjfkt4EEJmg7Kiees+E
 9+bk+tWH/og5D1Uu6LelWKqQkjt1m00luw7HDSCm2yw+hpOetn/YV4egsT/85tsIa+xz
 scWw==
X-Gm-Message-State: AOJu0Yx9DfVSIn2P92Hjg1gj+B023xUyzrTZ3ccH3AEyWilkYAHO7Kxf
 ioL7qNa3KRu2k8lA4lD7Q5xXHQcURsFYexBR6m4=
X-Google-Smtp-Source: AGHT+IEMyW+svbMr2DZifst5/6ZohgPgGPb52oWwTS0QJg1R2o2/fxI4tu7W8uMKCA4wIwa7OqxtkA==
X-Received: by 2002:a05:6a21:66cb:b0:16b:f71d:1b82 with SMTP id
 ze11-20020a056a2166cb00b0016bf71d1b82mr4993965pzb.34.1698522339685; 
 Sat, 28 Oct 2023 12:45:39 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170902f7c900b001b8a3e2c241sm3600096plw.14.2023.10.28.12.45.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 12:45:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v2 17/35] tcg/mips: Support TCG_COND_TST{EQ,NE}
Date: Sat, 28 Oct 2023 12:45:04 -0700
Message-Id: <20231028194522.245170-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231028194522.245170-1-richard.henderson@linaro.org>
References: <20231028194522.245170-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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
index 35eff82bb3..f5680d7b89 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -910,6 +910,16 @@ static void tcg_out_setcond(TCGContext *s, TCGCond cond, TCGReg ret,
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
@@ -990,6 +1000,14 @@ static void tcg_out_brcond(TCGContext *s, TCGCond cond, TCGReg arg1,
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
@@ -1053,6 +1071,14 @@ static void tcg_out_setcond2(TCGContext *s, TCGCond cond, TCGReg ret,
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
@@ -1079,6 +1105,13 @@ static void tcg_out_brcond2(TCGContext *s, TCGCond cond, TCGReg al, TCGReg ah,
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
@@ -1115,6 +1148,14 @@ static void tcg_out_movcond(TCGContext *s, TCGCond cond, TCGReg ret,
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


