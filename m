Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB487A2DB5
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 05:32:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhM0y-00060D-Ql; Fri, 15 Sep 2023 23:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM0s-0005y1-PV
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:30 -0400
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM0r-00081u-6E
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:30 -0400
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-76e09202322so190979985a.3
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 20:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694835028; x=1695439828; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TSJchoO7elNF6CTfsutNUylbFp3svGbYXVIq53KIlfk=;
 b=A/UVry0xX8mAc6+FRnZpr7ar0JVZfMIfTWFG3MtbnIrNcZSAhSe3FyQrWVEV3eqgH0
 ds1xkP77jWgNi1Hz/junFgjWINKB9GX+x16q43XtrycU+tP8ZFT88Ce8wZ/Xk1j1O9JW
 561P3xbyt6e4+XboW5QKONtIM/MITbJxQ5hdn7nlOmyZ8qxMwcvDFfg33kno7GB2C53U
 Rsihs3WUIazDHUUZW/d8btty3BqORDBm6330cFIaLJbq2X9Z8/apNAZsLQISVzasFOx7
 lT4bbb2QjBpwdugNyeteaw17Y4x6kPHqZSSPXMH6/gy0FUk5PCXODVWBJSfV8pgWzuB6
 onZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694835028; x=1695439828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TSJchoO7elNF6CTfsutNUylbFp3svGbYXVIq53KIlfk=;
 b=cWHCWZASAFbyla3DSI04Sp7/wAFNsLg0Lk8rddP1oO9558OMR2Q/pqTWxDAmNDOVEY
 lNzvyzJ2uouiCHfr82odgCdis6bkyKT6ECFJKn5WG04TY3ZofRUQrtAGZ8I1yBhCglQN
 P43lRtkpIEYzqCuko8nu959PBAuqI82Btl77lPQR8Z83TA+F2CYqZNbJf9J/JtddEqNN
 nYokpJdLbvkKuXOf9rLO2qpKlwtU13Od5bq0DIpp9jyx2IsR1oRfGjS+tPNmoKuOznA3
 w5/YtzHAh/Q0sOgqHAJSOcGo2A1xk3nViUcMAHbVh1d+Np5sSUQ5LPL7sGjukf40VkFx
 UViw==
X-Gm-Message-State: AOJu0YwKBx94cgHzoMN+PrbXWsUQLFc+I/UMFx3uI1DWQeHeSoxeWWKq
 NhgL/S8seFSpw6WHKgWhEhRDqwhqyPzaO+Vn4E0=
X-Google-Smtp-Source: AGHT+IFz22L/fn8mu4KjzIWBojyFhwxY/AYJ81fVZjPvEwHwhEuBB0wshbB0ckPOodKYpFIt7Td9YA==
X-Received: by 2002:a05:620a:372c:b0:75b:23a1:8336 with SMTP id
 de44-20020a05620a372c00b0075b23a18336mr3814750qkb.49.1694835028238; 
 Fri, 15 Sep 2023 20:30:28 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j26-20020aa783da000000b00687a4b70d1esm3577320pfn.218.2023.09.15.20.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 20:30:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiajie Chen <c@jia.je>
Subject: [PULL 16/39] tcg/loongarch64: Lower vector shift vector ops
Date: Fri, 15 Sep 2023 20:29:48 -0700
Message-Id: <20230916033011.479144-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916033011.479144-1-richard.henderson@linaro.org>
References: <20230916033011.479144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::733;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x733.google.com
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

From: Jiajie Chen <c@jia.je>

Lower the following ops:

- shlv_vec
- shrv_vec
- sarv_vec

Signed-off-by: Jiajie Chen <c@jia.je>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230908022302.180442-12-c@jia.je>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.h     |  2 +-
 tcg/loongarch64/tcg-target.c.inc | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index fa14558275..7e9fb61c47 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -188,7 +188,7 @@ extern bool use_lsx_instructions;
 #define TCG_TARGET_HAS_mul_vec          1
 #define TCG_TARGET_HAS_shi_vec          0
 #define TCG_TARGET_HAS_shs_vec          0
-#define TCG_TARGET_HAS_shv_vec          0
+#define TCG_TARGET_HAS_shv_vec          1
 #define TCG_TARGET_HAS_roti_vec         0
 #define TCG_TARGET_HAS_rots_vec         0
 #define TCG_TARGET_HAS_rotv_vec         0
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 90c52c38cf..6958fd219c 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1725,6 +1725,15 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     static const LoongArchInsn ussub_vec_insn[4] = {
         OPC_VSSUB_BU, OPC_VSSUB_HU, OPC_VSSUB_WU, OPC_VSSUB_DU
     };
+    static const LoongArchInsn shlv_vec_insn[4] = {
+        OPC_VSLL_B, OPC_VSLL_H, OPC_VSLL_W, OPC_VSLL_D
+    };
+    static const LoongArchInsn shrv_vec_insn[4] = {
+        OPC_VSRL_B, OPC_VSRL_H, OPC_VSRL_W, OPC_VSRL_D
+    };
+    static const LoongArchInsn sarv_vec_insn[4] = {
+        OPC_VSRA_B, OPC_VSRA_H, OPC_VSRA_W, OPC_VSRA_D
+    };
 
     a0 = args[0];
     a1 = args[1];
@@ -1853,6 +1862,15 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_ussub_vec:
         tcg_out32(s, encode_vdvjvk_insn(ussub_vec_insn[vece], a0, a1, a2));
         break;
+    case INDEX_op_shlv_vec:
+        tcg_out32(s, encode_vdvjvk_insn(shlv_vec_insn[vece], a0, a1, a2));
+        break;
+    case INDEX_op_shrv_vec:
+        tcg_out32(s, encode_vdvjvk_insn(shrv_vec_insn[vece], a0, a1, a2));
+        break;
+    case INDEX_op_sarv_vec:
+        tcg_out32(s, encode_vdvjvk_insn(sarv_vec_insn[vece], a0, a1, a2));
+        break;
     case INDEX_op_dupm_vec:
         tcg_out_dupm_vec(s, type, vece, a0, a1, a2);
         break;
@@ -1888,6 +1906,9 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_usadd_vec:
     case INDEX_op_sssub_vec:
     case INDEX_op_ussub_vec:
+    case INDEX_op_shlv_vec:
+    case INDEX_op_shrv_vec:
+    case INDEX_op_sarv_vec:
         return 1;
     default:
         return 0;
@@ -2071,6 +2092,9 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_usadd_vec:
     case INDEX_op_sssub_vec:
     case INDEX_op_ussub_vec:
+    case INDEX_op_shlv_vec:
+    case INDEX_op_shrv_vec:
+    case INDEX_op_sarv_vec:
         return C_O1_I2(w, w, w);
 
     case INDEX_op_not_vec:
-- 
2.34.1


