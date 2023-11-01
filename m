Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 745507DDBDC
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 05:16:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy2aC-0005yZ-E4; Wed, 01 Nov 2023 00:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qy2a1-0005vF-1V
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 00:11:45 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qy2Zz-0007XA-CU
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 00:11:44 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6b89ab5ddb7so6470940b3a.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 21:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698811902; x=1699416702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D8VHHcToqE8zPS4VqeaYr77Msx7TTI2MzHMcua1s2nQ=;
 b=pDDoLrZdMq0U9ILwKKQdUXAyerIZnX6L33ejcdUmbkV60V2linBkSkSrvkLokg0pbv
 Y+F7tTwVBVI5L5LbbQI4mtyBsvCk3M1zlTH9vKvGUPP5FdiXDTAX7UOYybZqctAZiqQE
 uemr53Qk5VmYaYDp06zpVfwkiPhKMPpsqw/tM4C+s1kyDZ5niF8kKaCIS8Zy3ekVfSVw
 I4Ic/7r9SGyHhspzD5DePpm0z20Tm0BhehYH2YiV20waCoc8v8j0e7f6T/Lwt7WkuoJo
 XoGJW6oroN0u0Svf5rNYT2C0XQe9D7QpSUe4lGUaDNpdfhd4O+sZTziI3wfevNkXWW12
 xNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698811902; x=1699416702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D8VHHcToqE8zPS4VqeaYr77Msx7TTI2MzHMcua1s2nQ=;
 b=oWChNlmhVId4RYxi2bh4Hb+pe6UXI9EhUznACUTH5M0XuskN5SYvPiKzNPpzzs6NSC
 fP/vm8CrfIOld7MgBOjyGG/VXd8YNevL8V/rkfsi6a0N0mZZ1fDPBUXd2q7M2ZZZNxzt
 kSBVw12z4aq7R2Rgf5+dxWYp+Acrn4a5u5TYDuWAhs2qd1CwFzqMGV4fyOqitru4yMOj
 PpoqWITIos7SwFO4321hVakTeuPwTrsJaaDqsMjb97Gk1O0e5ETdo7yi3FTco0MM2/0X
 mNvAulGHEL3LBHCWDfl1m/p+JlhZKHHddcOEUayX1prUbJA7di3Zg+42DqhS5a8dZ0CJ
 TvXg==
X-Gm-Message-State: AOJu0Yw5T1mE24+sw0I3mE+yWNT/B8hcE/l7WhwEg+qS4MKk6VvS5B/k
 aPdY2eiJQmnFeDbceyy2+9/vz0I6gowlpb2X0Og=
X-Google-Smtp-Source: AGHT+IEskJFCT+6GeM3CTpmhORZIuTs/c0/C30J38XQ4ym4ctVdGuZ2EHB9LgK/MU0BoV5T8cuFThw==
X-Received: by 2002:a05:6a00:218d:b0:6b2:5992:9e89 with SMTP id
 h13-20020a056a00218d00b006b259929e89mr17286238pfi.9.1698811902024; 
 Tue, 31 Oct 2023 21:11:42 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k8-20020aa79728000000b006875df4773fsm359576pfg.163.2023.10.31.21.11.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 21:11:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 09/21] target/sparc: Remove DisasCompare.is_bool
Date: Tue, 31 Oct 2023 21:11:20 -0700
Message-Id: <20231101041132.174501-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101041132.174501-1-richard.henderson@linaro.org>
References: <20231101041132.174501-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Since we're going to feed cpu_cond to another comparison, we don't
reqire a boolean value -- anything non-zero is sufficient.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 7c4fcf8326..464f1607e3 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -180,7 +180,6 @@ typedef struct DisasContext {
 
 typedef struct {
     TCGCond cond;
-    bool is_bool;
     TCGv c1, c2;
 } DisasCompare;
 
@@ -1039,7 +1038,6 @@ static void gen_compare(DisasCompare *cmp, bool xcc, unsigned int cond,
 {
     TCGv t1;
 
-    cmp->is_bool = false;
     cmp->c1 = t1 = tcg_temp_new();
     cmp->c2 = tcg_constant_tl(0);
 
@@ -1104,7 +1102,6 @@ static void gen_compare(DisasCompare *cmp, bool xcc, unsigned int cond,
 
     case 0x5: /* ltu: C */
         cmp->cond = TCG_COND_NE;
-        cmp->is_bool = true;
         if (TARGET_LONG_BITS == 32 || xcc) {
             tcg_gen_mov_tl(t1, cpu_cc_C);
         } else {
@@ -1132,7 +1129,6 @@ static void gen_compare(DisasCompare *cmp, bool xcc, unsigned int cond,
     }
     if (cond & 8) {
         cmp->cond = tcg_invert_cond(cmp->cond);
-        cmp->is_bool = false;
     }
 }
 
@@ -1143,7 +1139,6 @@ static void gen_fcompare(DisasCompare *cmp, unsigned int cc, unsigned int cond)
 
     /* For now we still generate a straight boolean result.  */
     cmp->cond = TCG_COND_NE;
-    cmp->is_bool = true;
     cmp->c1 = r_dst = tcg_temp_new();
     cmp->c2 = tcg_constant_tl(0);
 
@@ -1230,7 +1225,6 @@ static const TCGCond gen_tcg_cond_reg[8] = {
 static void gen_compare_reg(DisasCompare *cmp, int cond, TCGv r_src)
 {
     cmp->cond = tcg_invert_cond(gen_tcg_cond_reg[cond]);
-    cmp->is_bool = false;
     cmp->c1 = r_src;
     cmp->c2 = tcg_constant_tl(0);
 }
@@ -2232,18 +2226,14 @@ static void gen_fmovs(DisasContext *dc, DisasCompare *cmp, int rd, int rs)
 {
 #ifdef TARGET_SPARC64
     TCGv_i32 c32, zero, dst, s1, s2;
+    TCGv_i64 c64 = tcg_temp_new_i64();
 
     /* We have two choices here: extend the 32 bit data and use movcond_i64,
        or fold the comparison down to 32 bits and use movcond_i32.  Choose
        the later.  */
     c32 = tcg_temp_new_i32();
-    if (cmp->is_bool) {
-        tcg_gen_extrl_i64_i32(c32, cmp->c1);
-    } else {
-        TCGv_i64 c64 = tcg_temp_new_i64();
-        tcg_gen_setcond_i64(cmp->cond, c64, cmp->c1, cmp->c2);
-        tcg_gen_extrl_i64_i32(c32, c64);
-    }
+    tcg_gen_setcond_i64(cmp->cond, c64, cmp->c1, cmp->c2);
+    tcg_gen_extrl_i64_i32(c32, c64);
 
     s1 = gen_load_fpr_F(dc, rs);
     s2 = gen_load_fpr_F(dc, rd);
@@ -2445,8 +2435,10 @@ static bool advance_jump_cond(DisasContext *dc, DisasCompare *cmp,
             dc->jump_pc[0] = dest;
             dc->jump_pc[1] = npc + 4;
             dc->npc = JUMP_PC;
-            if (cmp->is_bool) {
-                tcg_gen_mov_tl(cpu_cond, cmp->c1);
+
+            /* The condition for cpu_cond is always NE -- normalize. */
+            if (cmp->cond == TCG_COND_NE) {
+                tcg_gen_xor_tl(cpu_cond, cmp->c1, cmp->c2);
             } else {
                 tcg_gen_setcond_tl(cmp->cond, cpu_cond, cmp->c1, cmp->c2);
             }
-- 
2.34.1


