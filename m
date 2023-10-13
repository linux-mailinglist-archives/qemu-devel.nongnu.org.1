Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0D17C8F30
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:33:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPim-0006Ny-UK; Fri, 13 Oct 2023 17:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPik-0006Mq-Qe
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:22 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPii-0000Wg-Ta
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:22 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-1e1b1b96746so1453666fac.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232559; x=1697837359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=spqhpyLr9DhJlUOb397bKlRCT4fGUNuYBx3haFG17o0=;
 b=YfIRkVhyud451OTRXVwbrAYyCZgH8RffhzTEH8rZYOtps7brdKxpHZIjEbuQWzSzQf
 6m6Pj5MxfS6sI9dPf/4aKg87TetAPP3nIrbcZbx6rEN17x4oDbWMskV13SCD79jQK1YX
 mU7GK1RqU5iwRpG0SoBxUDYMtbyqHLE4erD9SSdAYyRkPHw1OK6iLNxExjzcplQx7U+p
 3i3ZrSihi8eBalLaeacrGDoVUfh3ZBaeZA/q8Tw3ru2bvW74QSbHRQrNmj6x4QjPlXI4
 JktK1NM5DxsO5cK6LZj4eKpVSdOLsceGEenJ/elLwPEo5aQdKgYguvkb7PTZO3WP3u0M
 A0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232559; x=1697837359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=spqhpyLr9DhJlUOb397bKlRCT4fGUNuYBx3haFG17o0=;
 b=LhFPbq1opdKffcl58mZ7WWQKl+gvi/oWezO9iavcPmGQvnbsGkQ3QT+VY24SS7O6Pu
 JENBG9CpJoleAjJlCoj7sf6pAr/AYgmF/T2JiZ5t7GEnQ3k/zvxtdd+gkmZc/B2ep0Si
 GXWm6puvgLEaA1DJnQqpgpaioUJP0HZHyu90D0FXoVVxPAFkAR6PXnf65qS8cteMR88o
 p6Ll3g6eoO2uolYN/Oygp0RYbntJ61KMNK4fb3V5vvJju4KyJU7bv3c79o9LrqNjJf1a
 1YlXGJYJbdZrjnA8NANjdlFYuc5+HMkneFDm2KbE2H8gQDKJe1BoOyLj8BTpbE0OVwoo
 JEfw==
X-Gm-Message-State: AOJu0YwFbarOD+8tmW49wO8PH9lu39KYVP3j3kkMHITwxNDTCi8xvzeM
 Pf6RkbfO3Fqj/bYCcSfLkdMjND6p3pkZPDuSVVU=
X-Google-Smtp-Source: AGHT+IF4iOiRiU+BLmyA05GL//AxhY6WTZhEi10JpELlHNzMusqTH3sfZusl3WXhmGn8OukZ0qcpBA==
X-Received: by 2002:a05:6870:2c99:b0:1e9:a741:44f3 with SMTP id
 oh25-20020a0568702c9900b001e9a74144f3mr8411220oab.14.1697232559138; 
 Fri, 13 Oct 2023 14:29:19 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 b185-20020a6334c2000000b0058988954686sm70753pga.90.2023.10.13.14.29.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:29:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 33/85] target/sparc: Move MOVcc, MOVR to decodetree
Date: Fri, 13 Oct 2023 14:27:54 -0700
Message-Id: <20231013212846.165724-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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
 target/sparc/insns.decode |   4 ++
 target/sparc/translate.c  | 103 +++++++++++++++++---------------------
 2 files changed, 51 insertions(+), 56 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 597519b99b..1f6dfa210f 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -206,3 +206,7 @@ SRA_r       10 ..... 100111 ..... 0 .   0000000 .....      @shiftr
 SLL_i       10 ..... 100101 ..... 1 .   000000 ......      @shifti
 SRL_i       10 ..... 100110 ..... 1 .   000000 ......      @shifti
 SRA_i       10 ..... 100111 ..... 1 .   000000 ......      @shifti
+
+MOVcc       10 rd:5  101100 1 cond:4 imm:1 cc:1 0 rs2_or_imm:s11
+MOVfcc      10 rd:5  101100 0 cond:4 imm:1 cc:2   rs2_or_imm:s11
+MOVR        10 rd:5  101111 rs1:5    imm:1 cond:3 rs2_or_imm:s10
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 3672a8105b..81a2518498 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4350,6 +4350,51 @@ TRANS(SLL_i, ALL, do_shift_i, a, true, true)
 TRANS(SRL_i, ALL, do_shift_i, a, false, true)
 TRANS(SRA_i, ALL, do_shift_i, a, false, false)
 
+static bool do_mov_cond(DisasContext *dc, DisasCompare *cmp, int rd, TCGv src2)
+{
+    TCGv dst = gen_load_gpr(dc, rd);
+
+    tcg_gen_movcond_tl(cmp->cond, dst, cmp->c1, cmp->c2, src2, dst);
+    gen_store_gpr(dc, rd, dst);
+    return advance_pc(dc);
+}
+
+static bool trans_MOVcc(DisasContext *dc, arg_MOVcc *a)
+{
+    TCGv src2 = gen_rs2_or_imm(dc, a->imm, a->rs2_or_imm);
+    DisasCompare cmp;
+
+    if (src2 == NULL) {
+        return false;
+    }
+    gen_compare(&cmp, a->cc, a->cond, dc);
+    return do_mov_cond(dc, &cmp, a->rd, src2);
+}
+
+static bool trans_MOVfcc(DisasContext *dc, arg_MOVfcc *a)
+{
+    TCGv src2 = gen_rs2_or_imm(dc, a->imm, a->rs2_or_imm);
+    DisasCompare cmp;
+
+    if (src2 == NULL) {
+        return false;
+    }
+    gen_fcompare(&cmp, a->cc, a->cond);
+    return do_mov_cond(dc, &cmp, a->rd, src2);
+}
+
+static bool trans_MOVR(DisasContext *dc, arg_MOVR *a)
+{
+    TCGv src2 = gen_rs2_or_imm(dc, a->imm, a->rs2_or_imm);
+    DisasCompare cmp;
+
+    if (src2 == NULL) {
+        return false;
+    }
+    gen_compare_reg(&cmp, a->cond, gen_load_gpr(dc, a->rs1));
+    return do_mov_cond(dc, &cmp, a->rd, src2);
+}
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -4722,66 +4767,12 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                         goto illegal_insn;  /* WRTBR, WRHPR in decodetree */
 #ifdef TARGET_SPARC64
                     case 0x2c: /* V9 movcc */
-                        {
-                            int cc = GET_FIELD_SP(insn, 11, 12);
-                            int cond = GET_FIELD_SP(insn, 14, 17);
-                            DisasCompare cmp;
-                            TCGv dst;
-
-                            if (insn & (1 << 18)) {
-                                if (cc == 0) {
-                                    gen_compare(&cmp, 0, cond, dc);
-                                } else if (cc == 2) {
-                                    gen_compare(&cmp, 1, cond, dc);
-                                } else {
-                                    goto illegal_insn;
-                                }
-                            } else {
-                                gen_fcompare(&cmp, cc, cond);
-                            }
-
-                            /* The get_src2 above loaded the normal 13-bit
-                               immediate field, not the 11-bit field we have
-                               in movcc.  But it did handle the reg case.  */
-                            if (IS_IMM) {
-                                simm = GET_FIELD_SPs(insn, 0, 10);
-                                tcg_gen_movi_tl(cpu_src2, simm);
-                            }
-
-                            dst = gen_load_gpr(dc, rd);
-                            tcg_gen_movcond_tl(cmp.cond, dst,
-                                               cmp.c1, cmp.c2,
-                                               cpu_src2, dst);
-                            gen_store_gpr(dc, rd, dst);
-                            break;
-                        }
+                    case 0x2f: /* V9 movr */
+                        goto illegal_insn;  /* in decodetree */
                     case 0x2e: /* V9 popc */
                         tcg_gen_ctpop_tl(cpu_dst, cpu_src2);
                         gen_store_gpr(dc, rd, cpu_dst);
                         break;
-                    case 0x2f: /* V9 movr */
-                        {
-                            int cond = GET_FIELD_SP(insn, 10, 12);
-                            DisasCompare cmp;
-                            TCGv dst;
-
-                            gen_compare_reg(&cmp, cond, cpu_src1);
-
-                            /* The get_src2 above loaded the normal 13-bit
-                               immediate field, not the 10-bit field we have
-                               in movr.  But it did handle the reg case.  */
-                            if (IS_IMM) {
-                                simm = GET_FIELD_SPs(insn, 0, 9);
-                                tcg_gen_movi_tl(cpu_src2, simm);
-                            }
-
-                            dst = gen_load_gpr(dc, rd);
-                            tcg_gen_movcond_tl(cmp.cond, dst,
-                                               cmp.c1, cmp.c2,
-                                               cpu_src2, dst);
-                            gen_store_gpr(dc, rd, dst);
-                            break;
-                        }
 #endif
                     default:
                         goto illegal_insn;
-- 
2.34.1


