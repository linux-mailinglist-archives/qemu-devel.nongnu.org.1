Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1C47A2DCA
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 05:38:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhM11-00061k-3K; Fri, 15 Sep 2023 23:30:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM0v-0005zS-I7
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:33 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM0t-00082e-Tw
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:33 -0400
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-414e78cdc11so17133491cf.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 20:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694835031; x=1695439831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WSx+iOunzn5x6KtU9atTesaa9D1WcsJ5igvJb30ju/8=;
 b=IVdyhCj27sIvTq781l7aAcZSOFrJ0gYERLfNC9Va9kjkbdL/T99VgfD3JIlEx4fmgs
 jAcenAtQklkTDDvxjjj8UTBgoYbqlnQkk5Xw8s73GKQ3sgUB0AQhT565RORKCxQ5vZN6
 3z2FdNWEgmKu4CIy/+nlbj2p2zlgqiXQKTFvVtVq1/GxxUl47AfSpusZOFuJkvwFgZ+C
 i5VDrqMUMtXUaZ9SIqFwmu7BgVFjr0ek6zu8nGGiZr26hPSwM8vtx9nvcUapUT4Y4Vyl
 vP6lBMqkIemJaIkMgdRGZgMQUgLQJVwGoIB740YaIwTaeLsZQpPF2hv0irIiu/mSL4Xd
 yD6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694835031; x=1695439831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WSx+iOunzn5x6KtU9atTesaa9D1WcsJ5igvJb30ju/8=;
 b=HU5fHAIVuiMWDN3slP6+Ob81E87a5mLQvs20cQnLi/rvP0PFu1JQRVMacMmV9cFQja
 KOkK9O1UeLA3OaDJTV+hlI959K6NSXzO7Bh2V2I4SYTscp/r/VrMUo3IUWMi5oyCfBT/
 DsjgOdwRjQaokgp4s8mIVZPgz4y1Zhu2TL25a4SR0O65eYGFHaoWokHWn0lSaGoffHDu
 SBEmNZqIcMF9bxvkvomIZZhgTzxqR5l6jx0nCyYix45Ze872MN8vjKGfjqePqcuUP24i
 fLb+pU7jblRlBKOqPQ8wK9mGPv+eH2VAaR8gYH7AM8kP1AagCtrrnoTopiIZO680q2PY
 ebZg==
X-Gm-Message-State: AOJu0Yz6/2aLZqF4vu/LbkrKAcPz4UxyirLLAZSxgF/qeSyMG8XvifG4
 IzJmYZ1Q55Wh2k/43RCc4KmXtnRNmPB8cA1rRdY=
X-Google-Smtp-Source: AGHT+IGW62bOaWQJqJKsD75bWpwMsji6zN9Xg7Dnq6lFmgf5Y9zkHGzt2Ep0Q/rTui4Oz0E8kRVA7w==
X-Received: by 2002:a05:620a:4553:b0:76d:a008:f713 with SMTP id
 u19-20020a05620a455300b0076da008f713mr3813460qkp.60.1694835030891; 
 Fri, 15 Sep 2023 20:30:30 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j26-20020aa783da000000b00687a4b70d1esm3577320pfn.218.2023.09.15.20.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 20:30:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiajie Chen <c@jia.je>
Subject: [PULL 19/39] tcg/loongarch64: Lower rotv_vec ops to LSX
Date: Fri, 15 Sep 2023 20:29:51 -0700
Message-Id: <20230916033011.479144-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916033011.479144-1-richard.henderson@linaro.org>
References: <20230916033011.479144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82c.google.com
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

- rotrv_vec
- rotlv_vec

Signed-off-by: Jiajie Chen <c@jia.je>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230908022302.180442-15-c@jia.je>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.h     |  2 +-
 tcg/loongarch64/tcg-target.c.inc | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index d7b806e252..d5c69bc192 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -191,7 +191,7 @@ extern bool use_lsx_instructions;
 #define TCG_TARGET_HAS_shv_vec          1
 #define TCG_TARGET_HAS_roti_vec         0
 #define TCG_TARGET_HAS_rots_vec         0
-#define TCG_TARGET_HAS_rotv_vec         0
+#define TCG_TARGET_HAS_rotv_vec         1
 #define TCG_TARGET_HAS_sat_vec          1
 #define TCG_TARGET_HAS_minmax_vec       1
 #define TCG_TARGET_HAS_bitsel_vec       1
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index c21c917083..8f448823b0 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1743,6 +1743,9 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     static const LoongArchInsn sari_vec_insn[4] = {
         OPC_VSRAI_B, OPC_VSRAI_H, OPC_VSRAI_W, OPC_VSRAI_D
     };
+    static const LoongArchInsn rotrv_vec_insn[4] = {
+        OPC_VROTR_B, OPC_VROTR_H, OPC_VROTR_W, OPC_VROTR_D
+    };
 
     a0 = args[0];
     a1 = args[1];
@@ -1890,6 +1893,15 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_sari_vec:
         tcg_out32(s, encode_vdvjuk3_insn(sari_vec_insn[vece], a0, a1, a2));
         break;
+    case INDEX_op_rotrv_vec:
+        tcg_out32(s, encode_vdvjvk_insn(rotrv_vec_insn[vece], a0, a1, a2));
+        break;
+    case INDEX_op_rotlv_vec:
+        /* rotlv_vec a1, a2 = rotrv_vec a1, -a2 */
+        tcg_out32(s, encode_vdvj_insn(neg_vec_insn[vece], temp_vec, a2));
+        tcg_out32(s, encode_vdvjvk_insn(rotrv_vec_insn[vece], a0, a1,
+                                        temp_vec));
+        break;
     case INDEX_op_bitsel_vec:
         /* vbitsel vd, vj, vk, va = bitsel_vec vd, va, vk, vj */
         tcg_out_opc_vbitsel_v(s, a0, a3, a2, a1);
@@ -2119,6 +2131,8 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_shlv_vec:
     case INDEX_op_shrv_vec:
     case INDEX_op_sarv_vec:
+    case INDEX_op_rotrv_vec:
+    case INDEX_op_rotlv_vec:
         return C_O1_I2(w, w, w);
 
     case INDEX_op_not_vec:
-- 
2.34.1


