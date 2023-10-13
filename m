Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F28B7C8F6B
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:38:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPm2-0000Tz-Cq; Fri, 13 Oct 2023 17:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPlz-0000KV-Ka
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:43 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPlx-0001Rb-Db
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:43 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-57be3d8e738so1470613eaf.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232760; x=1697837560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FcfUpbij0skmnmwjAH/0sErdA7OfmBslk5mRhk5iwjE=;
 b=kQU654qK/feZo52pot6vKMy0rzASZRoZ8LjBI4juxNgTrARI/uMhKLWGDg+FhJjzcP
 xz/HBiApm3k8Z9XfnX+wrZ6skvBRKvhhecL21j8J0w6jr71j1Qyo7Gafnca0ElUjrvSM
 bkZroRwg3Ara8ksxe5x2FgP6rtw3l4EwWTT4d8e9DJSUfVoiORmSsTeBuWLt20bX/nb/
 EZqgmsXftQFzviuGGVp+dCYq0UqVUz/FEwdlXFX7vVnLFKw3GP7QIUmcyzqEl4yoCewX
 ar+gkSBK+Q73mP2Tcvk1oPW8MCLaloqlfXt//inRZ5prPyL7xV+NEaYISVMNI3YruF2t
 tZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232760; x=1697837560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FcfUpbij0skmnmwjAH/0sErdA7OfmBslk5mRhk5iwjE=;
 b=BoDoZEiTMZSudk16jKiU8+flbIBEXi62/QtWUKHZiXxiLUqdCCQPhg3ljzzDqoUIPY
 8ypVgz7fp/i9lj9oc+AwfYK3C0XXMg4aSvMXAtDpq7dJGZfg8co00mer4Ne4pJSUnz2N
 M/SDqAaOtzwUNvsmnlGa8Znd8T6UB/CZ4I6tVtTPlu+Ko6KKkf/ZfdMqJIcmUF7DMkzB
 tqQJG+pdIhaHbY6wWGbPVuOII4f1MhYmDwGdxTIH6ICxlUyeLaE7H+ambLxB0XapWNuZ
 8IkRrckjWG/1cA9TaArywhDLzbiciAvbkY4YItnbXV7Sj9rM2VGtU2Xm0NJJQmTFMVmq
 oUNQ==
X-Gm-Message-State: AOJu0YytIpNBsM6U0pRvwoE0w3WSBLWLU6BEBPI7lnB3r4J/wH0TWF46
 h/n3Ccb5t1N/DynxRRcNz5dkcrM6MFd6QaRar98=
X-Google-Smtp-Source: AGHT+IGzirrjultomogfDzV+Whl+8A+okdNdwHxBxWBk+LY20p3b+QqKa9B8xeFUAVD0nkSLSmGe8A==
X-Received: by 2002:a05:6358:9691:b0:164:8742:525 with SMTP id
 o17-20020a056358969100b0016487420525mr24323132rwa.17.1697232759960; 
 Fri, 13 Oct 2023 14:32:39 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 j5-20020aa78d05000000b0068842ebfd10sm13977191pfe.160.2023.10.13.14.32.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:32:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 56/85] target/sparc: Move ADDRALIGN* to decodetree
Date: Fri, 13 Oct 2023 14:28:17 -0700
Message-Id: <20231013212846.165724-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2d.google.com
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
 target/sparc/insns.decode |  3 +++
 target/sparc/translate.c  | 56 ++++++++++++++++++++++-----------------
 2 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index e8d49de888..f6ac8672c8 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -246,6 +246,9 @@ RETRY       10 00001 111110 00000 0 0000000000000
     ARRAY8      10 ..... 110110 ..... 0 0001 0000 .....    @r_r_r
     ARRAY16     10 ..... 110110 ..... 0 0001 0010 .....    @r_r_r
     ARRAY32     10 ..... 110110 ..... 0 0001 0100 .....    @r_r_r
+
+    ALIGNADDR   10 ..... 110110 ..... 0 0001 1000 .....    @r_r_r
+    ALIGNADDRL  10 ..... 110110 ..... 0 0001 1010 .....    @r_r_r
   ]
   NCP           10 ----- 110110 ----- --------- -----      # v8 CPop1
 }
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index c8685c6837..0392ef7cda 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2636,18 +2636,6 @@ static void gen_load_trap_state_at_tl(TCGv_ptr r_tsptr)
     }
 }
 
-static void gen_alignaddr(TCGv dst, TCGv s1, TCGv s2, bool left)
-{
-    TCGv tmp = tcg_temp_new();
-
-    tcg_gen_add_tl(tmp, s1, s2);
-    tcg_gen_andi_tl(dst, tmp, -8);
-    if (left) {
-        tcg_gen_neg_tl(tmp, tmp);
-    }
-    tcg_gen_deposit_tl(cpu_gsr, cpu_gsr, tmp, 0, 3);
-}
-
 static void gen_faligndata(TCGv dst, TCGv gsr, TCGv s1, TCGv s2)
 {
     TCGv t1, t2, shift;
@@ -4276,6 +4264,36 @@ TRANS(ARRAY8, VIS1, do_rrr, a, gen_helper_array8)
 TRANS(ARRAY16, VIS1, do_rrr, a, gen_op_array16)
 TRANS(ARRAY32, VIS1, do_rrr, a, gen_op_array32)
 
+static void gen_op_alignaddr(TCGv dst, TCGv s1, TCGv s2)
+{
+#ifdef TARGET_SPARC64
+    TCGv tmp = tcg_temp_new();
+
+    tcg_gen_add_tl(tmp, s1, s2);
+    tcg_gen_andi_tl(dst, tmp, -8);
+    tcg_gen_deposit_tl(cpu_gsr, cpu_gsr, tmp, 0, 3);
+#else
+    g_assert_not_reached();
+#endif
+}
+
+static void gen_op_alignaddrl(TCGv dst, TCGv s1, TCGv s2)
+{
+#ifdef TARGET_SPARC64
+    TCGv tmp = tcg_temp_new();
+
+    tcg_gen_add_tl(tmp, s1, s2);
+    tcg_gen_andi_tl(dst, tmp, -8);
+    tcg_gen_neg_tl(tmp, tmp);
+    tcg_gen_deposit_tl(cpu_gsr, cpu_gsr, tmp, 0, 3);
+#else
+    g_assert_not_reached();
+#endif
+}
+
+TRANS(ALIGNADDR, VIS1, do_rrr, a, gen_op_alignaddr)
+TRANS(ALIGNADDRL, VIS1, do_rrr, a, gen_op_alignaddrl)
+
 static bool do_shift_r(DisasContext *dc, arg_shiftr *a, bool l, bool u)
 {
     TCGv dst, src1, src2;
@@ -5168,21 +5186,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x010: /* VIS I array8 */
                 case 0x012: /* VIS I array16 */
                 case 0x014: /* VIS I array32 */
-                    g_assert_not_reached();  /* in decodetree */
                 case 0x018: /* VIS I alignaddr */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1 = gen_load_gpr(dc, rs1);
-                    cpu_src2 = gen_load_gpr(dc, rs2);
-                    gen_alignaddr(cpu_dst, cpu_src1, cpu_src2, 0);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
                 case 0x01a: /* VIS I alignaddrl */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1 = gen_load_gpr(dc, rs1);
-                    cpu_src2 = gen_load_gpr(dc, rs2);
-                    gen_alignaddr(cpu_dst, cpu_src1, cpu_src2, 1);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
+                    g_assert_not_reached();  /* in decodetree */
                 case 0x019: /* VIS II bmask */
                     CHECK_FPU_FEATURE(dc, VIS2);
                     cpu_src1 = gen_load_gpr(dc, rs1);
-- 
2.34.1


