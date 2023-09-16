Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 059DC7A2DBF
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 05:37:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhM0x-0005zU-9D; Fri, 15 Sep 2023 23:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM0u-0005yM-6A
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:32 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM0s-00082D-Hy
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:31 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3ab244ef065so1804970b6e.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 20:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694835029; x=1695439829; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZZqyLqhhPGXIJ6lzrdtIYtw/qVZtMaD5kLD3wMqVMdI=;
 b=hYncpgkY0KP9cjcIcjg453y4GdDducohCaSY//wh5+eUidC+eNrRxy2VkDq5MeCZmx
 fsPhZi7CHx9ZsPKp0Lt/WYJGXxNA1l6oJQvFyAO/+jfak0p1tpyJC7QJWDUmztTLwU2o
 pzPERUzWI+CFBhfDrMMGgzmU7NgzTpI34DZL8Fs7FSITURQNzOHUd/R3H+0oZrenx9BY
 lE1ch0QY5hSXFyZs0acXKvdNr0d14STOwpUGDEMSCbn69OrruL21Ke83j0ZXgNWKrsyj
 DI+/6ZYyLPih3DQwory/rKfsZW5SUrf9tdB4N2tzVPKq3Ij/97BIZwXO3XtC+Lrm+Yci
 b0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694835029; x=1695439829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZZqyLqhhPGXIJ6lzrdtIYtw/qVZtMaD5kLD3wMqVMdI=;
 b=CAdct5hcOcNIhve++Hgw+egQq1E9FkHJQ78q4EtySgLo17k73sKJK4IeWxGQBgLMv5
 xtPH3Hcf7M8vZOkiRYnQpobUUvLdUtKYehKSCdcZPcORe7yy/li9dN4Xa9evxFsx3NB+
 HxfwiLA/zkcnsikulma8yN85f7FLp8j/d8sJ3L9Re79DNRQcNwuPatOvuoVZG/zs0S5n
 85gEFCmIY3LVE9bB12PI1esP0FQephsAulKLyTBjLo8J0BN1phxKHA8DPTXvbMfqLPPw
 Vr972FjEaG2Ivba9u5xEBd6pn++7WYn6B/e947Y6j996SAdgDoBGG+s24Vjlsly6RTEG
 qtpQ==
X-Gm-Message-State: AOJu0Yyq740VbBmedxuATFmKYoJ2X0G8Tv+w9MJfcOQRPlxymFJBbXHo
 fvsvmYlYQg7NMPoYG/8q8aso940qq91/o1fKijM=
X-Google-Smtp-Source: AGHT+IGOh2zZ+F3YqoLMG2Pz4ARVJYbcHLkLoZE4aJKfzB6ynZpxGcp/zlfwQ7SL1qgjanrvcE8dMQ==
X-Received: by 2002:a05:6808:118:b0:3a8:6a03:c0c with SMTP id
 b24-20020a056808011800b003a86a030c0cmr3867692oie.27.1694835029252; 
 Fri, 15 Sep 2023 20:30:29 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j26-20020aa783da000000b00687a4b70d1esm3577320pfn.218.2023.09.15.20.30.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 20:30:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiajie Chen <c@jia.je>
Subject: [PULL 17/39] tcg/loongarch64: Lower bitsel_vec to vbitsel
Date: Fri, 15 Sep 2023 20:29:49 -0700
Message-Id: <20230916033011.479144-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916033011.479144-1-richard.henderson@linaro.org>
References: <20230916033011.479144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
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

Signed-off-by: Jiajie Chen <c@jia.je>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230908022302.180442-13-c@jia.je>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target-con-set.h |  1 +
 tcg/loongarch64/tcg-target.h         |  2 +-
 tcg/loongarch64/tcg-target.c.inc     | 11 ++++++++++-
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/tcg/loongarch64/tcg-target-con-set.h b/tcg/loongarch64/tcg-target-con-set.h
index 3f530ad4d8..914572d21b 100644
--- a/tcg/loongarch64/tcg-target-con-set.h
+++ b/tcg/loongarch64/tcg-target-con-set.h
@@ -35,4 +35,5 @@ C_O1_I2(r, rZ, rZ)
 C_O1_I2(w, w, w)
 C_O1_I2(w, w, wM)
 C_O1_I2(w, w, wA)
+C_O1_I3(w, w, w, w)
 C_O1_I4(r, rZ, rJ, rZ, rZ)
diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index 7e9fb61c47..bc56939a57 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -194,7 +194,7 @@ extern bool use_lsx_instructions;
 #define TCG_TARGET_HAS_rotv_vec         0
 #define TCG_TARGET_HAS_sat_vec          1
 #define TCG_TARGET_HAS_minmax_vec       1
-#define TCG_TARGET_HAS_bitsel_vec       0
+#define TCG_TARGET_HAS_bitsel_vec       1
 #define TCG_TARGET_HAS_cmpsel_vec       0
 
 #define TCG_TARGET_DEFAULT_MO (0)
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 6958fd219c..a33ec594ee 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1676,7 +1676,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                            const int const_args[TCG_MAX_OP_ARGS])
 {
     TCGType type = vecl + TCG_TYPE_V64;
-    TCGArg a0, a1, a2;
+    TCGArg a0, a1, a2, a3;
     TCGReg temp = TCG_REG_TMP0;
     TCGReg temp_vec = TCG_VEC_TMP0;
 
@@ -1738,6 +1738,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     a0 = args[0];
     a1 = args[1];
     a2 = args[2];
+    a3 = args[3];
 
     /* Currently only supports V128 */
     tcg_debug_assert(type == TCG_TYPE_V128);
@@ -1871,6 +1872,10 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_sarv_vec:
         tcg_out32(s, encode_vdvjvk_insn(sarv_vec_insn[vece], a0, a1, a2));
         break;
+    case INDEX_op_bitsel_vec:
+        /* vbitsel vd, vj, vk, va = bitsel_vec vd, va, vk, vj */
+        tcg_out_opc_vbitsel_v(s, a0, a3, a2, a1);
+        break;
     case INDEX_op_dupm_vec:
         tcg_out_dupm_vec(s, type, vece, a0, a1, a2);
         break;
@@ -1909,6 +1914,7 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_shlv_vec:
     case INDEX_op_shrv_vec:
     case INDEX_op_sarv_vec:
+    case INDEX_op_bitsel_vec:
         return 1;
     default:
         return 0;
@@ -2101,6 +2107,9 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_neg_vec:
         return C_O1_I1(w, w);
 
+    case INDEX_op_bitsel_vec:
+        return C_O1_I3(w, w, w, w);
+
     default:
         g_assert_not_reached();
     }
-- 
2.34.1


