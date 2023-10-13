Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D44F67C8F5F
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:37:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPmp-0003w7-Nq; Fri, 13 Oct 2023 17:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPmJ-0002kK-0h
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:33:06 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPmH-0001bR-3y
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:33:02 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6c61d955161so1593459a34.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232779; x=1697837579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BiZ+CwO6WgsvjHllUC4v+o7X9RG/JhsuRFwxzJ+jJkw=;
 b=qnEH2uTRv0UaNzG4oHcLk06On23zk2Cd9XeLidjO9q7kJ6hyPOkmV7MYBAoiy1UCx7
 9dVIWccqFMumUGWr3kfexevR/Nw9KDVoFZHwybe0Zs2h5NT+CQ31K3yXPsBJEYrofYFS
 cC3M2umU+Rfq2gExtXr34CgZL/MeMhAfB6kcb+ImVHxD0v6FTif5VZhIJF3bSRcvlbCs
 cal7cptWdkoUAQ5Ltc5gi+URcnrXLPmr7YtDaTY79CdCUsXXDYihVBnIUQ2vSXbraXx5
 Rm722SevQGICChh85ikRAxGg7WiNQusdbqFu3s62V8CrrW0rX6mr4wyfeKpl1i7cUZAM
 AuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232779; x=1697837579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BiZ+CwO6WgsvjHllUC4v+o7X9RG/JhsuRFwxzJ+jJkw=;
 b=jEBjzaK0evP90GR8ZTxt/VcO1mNPDppSD7VpQQsv97frGHiq83oFjuUUeV8iuiQBPa
 eXTqv37rSfbeBBQoohwDhNPzfO4vdrpXp1SUJK3bZKi9U5aAprFr/rl5wkw3XnEST5NW
 Gno5/N9oDAviF1Xs0Be9iVp/9NX/mU7o/97/Ly8oKmT/8PSUaniyL6XZTiQr7TaMzNAe
 gpL2uwhv0c2iwx+EVABY8Hq2r7hT5/BaO0F6IMgnUC3ipdjkp6gec8HM1wdsn64zm8al
 QmH83Ytjc6EP42U/q7KSsdLV0GZ3KtUQHPA8YDbQFylCJ5hpk4rZSX6Bth2aJ+s/pY/T
 oYuQ==
X-Gm-Message-State: AOJu0YwyK+KU4jFMi/JOOywqBNSTpVlkzPQDcGBcDyUo3LMkSK3p3XWV
 +owkDbRoe5FvmDmK27aGuAxfBb5RwYGhjp0bXkc=
X-Google-Smtp-Source: AGHT+IFqLqwKFkEzdq9tKZynGQcZEnliScPqprq38lqRL9IyZBWD+zy1ANGfbOa38AsI4HBZW4h6jg==
X-Received: by 2002:a9d:4d04:0:b0:6bf:17d3:4268 with SMTP id
 n4-20020a9d4d04000000b006bf17d34268mr28640269otf.25.1697232779036; 
 Fri, 13 Oct 2023 14:32:59 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 j5-20020aa78d05000000b0068842ebfd10sm13977191pfe.160.2023.10.13.14.32.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:32:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 78/85] target/sparc: Move FdTOq, FxTOq to decodetree
Date: Fri, 13 Oct 2023 14:28:39 -0700
Message-Id: <20231013212846.165724-79-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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
 target/sparc/insns.decode |  2 ++
 target/sparc/translate.c  | 47 ++++++++++++++++++++++-----------------
 2 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index f0a6abb170..f749e23ae6 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -261,6 +261,7 @@ FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_r2
 FqTOx       10 ..... 110100 00000 0 1000 0011 .....        @r_r2
 FxTOs       10 ..... 110100 00000 0 1000 0100 .....        @r_r2
 FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @r_r2
+FxTOq       10 ..... 110100 00000 0 1000 1100 .....        @r_r2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
 FdTOs       10 ..... 110100 00000 0 1100 0110 .....        @r_r2
 FqTOs       10 ..... 110100 00000 0 1100 0111 .....        @r_r2
@@ -269,6 +270,7 @@ FsTOd       10 ..... 110100 00000 0 1100 1001 .....        @r_r2
 FqTOd       10 ..... 110100 00000 0 1100 1011 .....        @r_r2
 FiTOq       10 ..... 110100 00000 0 1100 1100 .....        @r_r2
 FsTOq       10 ..... 110100 00000 0 1100 1101 .....        @r_r2
+FdTOq       10 ..... 110100 00000 0 1100 1110 .....        @r_r2
 FsTOi       10 ..... 110100 00000 0 1101 0001 .....        @r_r2
 FdTOi       10 ..... 110100 00000 0 1101 0010 .....        @r_r2
 FqTOi       10 ..... 110100 00000 0 1101 0011 .....        @r_r2
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index d6ae4431dc..22a1a13ef8 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -60,6 +60,7 @@
 #define gen_helper_fqtox                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fxtod                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fxtos                ({ qemu_build_not_reached(); NULL; })
+#define gen_helper_fxtoq                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_done(E)              qemu_build_not_reached()
 #define gen_helper_retry(E)             qemu_build_not_reached()
 #define gen_helper_udivx(D, E, A, B)    qemu_build_not_reached()
@@ -1542,19 +1543,6 @@ static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
 }
 #endif
 
-static void gen_ne_fop_QD(DisasContext *dc, int rd, int rs,
-                          void (*gen)(TCGv_ptr, TCGv_i64))
-{
-    TCGv_i64 src;
-
-    src = gen_load_fpr_D(dc, rs);
-
-    gen(tcg_env, src);
-
-    gen_op_store_QT0_fpr(QFPREG(rd));
-    gen_update_fprs_dirty(dc, QFPREG(rd));
-}
-
 /* asi moves */
 typedef enum {
     GET_ASI_HELPER,
@@ -4798,6 +4786,29 @@ static bool do_env_qf(DisasContext *dc, arg_r_r *a,
 TRANS(FiTOq, ALL, do_env_qf, a, gen_helper_fitoq)
 TRANS(FsTOq, ALL, do_env_qf, a, gen_helper_fstoq)
 
+static bool do_env_qd(DisasContext *dc, arg_r_r *a,
+                      void (*func)(TCGv_env, TCGv_i64))
+{
+    TCGv_i64 src;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+    if (gen_trap_float128(dc)) {
+        return true;
+    }
+
+    gen_op_clear_ieee_excp_and_FTT();
+    src = gen_load_fpr_D(dc, a->rs);
+    func(tcg_env, src);
+    gen_op_store_QT0_fpr(QFPREG(a->rd));
+    gen_update_fprs_dirty(dc, QFPREG(a->rd));
+    return advance_pc(dc);
+}
+
+TRANS(FdTOq, ALL, do_env_qd, a, gen_helper_fdtoq)
+TRANS(FxTOq, 64, do_env_qd, a, gen_helper_fxtoq)
+
 static bool do_fff(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i32, TCGv_i32, TCGv_i32))
 {
@@ -5085,11 +5096,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x83: /* V9 fqtox */
                 case 0xcc: /* fitoq */
                 case 0xcd: /* fstoq */
-                    g_assert_not_reached(); /* in decodetree */
                 case 0xce: /* fdtoq */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_ne_fop_QD(dc, rd, rs2, gen_helper_fdtoq);
-                    break;
+                case 0x8c: /* V9 fxtoq */
+                    g_assert_not_reached(); /* in decodetree */
 #ifdef TARGET_SPARC64
                 case 0x3: /* V9 fmovq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
@@ -5103,10 +5112,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QQ(dc, rd, rs2, gen_helper_fabsq);
                     break;
-                case 0x8c: /* V9 fxtoq */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_ne_fop_QD(dc, rd, rs2, gen_helper_fxtoq);
-                    break;
 #endif
                 default:
                     goto illegal_insn;
-- 
2.34.1


