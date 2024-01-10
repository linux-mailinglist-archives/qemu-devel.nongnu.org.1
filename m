Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3092E82A43F
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 23:49:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNhLR-0007bU-KW; Wed, 10 Jan 2024 17:46:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhL0-0006ZQ-38
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:46:19 -0500
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhKv-0003IX-UR
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:46:17 -0500
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-dbed4b84667so4107654276.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 14:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704926772; x=1705531572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SYMLLwA9gva4L4uzAlLYH7HUcuo07hrL8DJH/YZuBt8=;
 b=dOBJQBiX7IGwYiMXLqNTLkmDTKZYaSsFNePeAVBSpSVxPRb75qp8eQcbDxVYai5pvW
 0sbUu+f6+u1Nsi2xk+LmlVJygH/ujMiNxihSzNKqN4ETSmfgSTgpueWImCagcEEDDs+K
 92JhcfI5mWsCs7jSkAo8TWfQVDF3cafgAC2XKpYRsghY3sr70BWz1J0k9IEmooNa16Fh
 wu+KjdMXYNWlHA9WWjyk82wB+dSlxCmwLGCERiQ0BOvtaNZi2PJfSimQjbO3RHTDj9Nd
 wsIkVi0Y8eMvk6p62cZ5rvHuhga0ZWXxvr6BkCuFLOgmW6eZ28CRdfAQ8ooFRBLrkBpm
 m16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704926772; x=1705531572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SYMLLwA9gva4L4uzAlLYH7HUcuo07hrL8DJH/YZuBt8=;
 b=jk0lh0Anl4xFShDtHG4R+Rf3A9urdQAk14BbBcjs8qaN0Fu/uqTqiJQEM7k05gGcX2
 GKbrfiOWfzoatqaaS7BU/20WAfZtIAFDkA6FRdrzrZJxHEX8y+DtJYAhG/un6lvnVdYR
 RcsSuQaAIlU716aGWFSiMrdibs099dJxWe7TkwUw1S94Z6g/37GhwgEnc8I+2SreB4Sy
 oIRf94OQXCAEa8eizrf/0UZkkBBRop5Nhw2VN49j9HnKV08n6sUmDRAmyNMHUU4kbOPA
 XJQ1wKWHzHxACB+T+tJ29TrN/MLsZUqpKNcI7Cr2McO6OrBF0oqRS5CNan4sy8Mzk6t+
 VVxQ==
X-Gm-Message-State: AOJu0Yw5X5fl/ltFuic5fo9aefM9qdUhkNVi9M98XNXUfPZVzCDKcsBx
 rDNF0FqvFzF7abwR5WTeVrMVAY8tngDVJjWltJMJQ8NdEi3zDW6G
X-Google-Smtp-Source: AGHT+IGXGXSdy7Yazwarzw4VXB1nvRak09TCqmOHHzh/rX43IGRN4vC0+yzAKWHVPw2I2lZXYjWX7Q==
X-Received: by 2002:a25:abc1:0:b0:dbe:a098:6cfc with SMTP id
 v59-20020a25abc1000000b00dbea0986cfcmr402400ybi.25.1704926771758; 
 Wed, 10 Jan 2024 14:46:11 -0800 (PST)
Received: from stoup.. ([172.58.27.160]) by smtp.gmail.com with ESMTPSA id
 ks23-20020ac86217000000b0042987f6874bsm2092281qtb.92.2024.01.10.14.46.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 14:46:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v3 23/38] tcg/i386: Move tcg_cond_to_jcc[] into tcg_out_cmp
Date: Thu, 11 Jan 2024 09:43:53 +1100
Message-Id: <20240110224408.10444-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110224408.10444-1-richard.henderson@linaro.org>
References: <20240110224408.10444-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-yb1-xb2d.google.com
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

Return the x86 condition codes to use after the compare.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 2d6100a8f4..02718a02d8 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1449,8 +1449,8 @@ static void tcg_out_jxx(TCGContext *s, int opc, TCGLabel *l, bool small)
     }
 }
 
-static void tcg_out_cmp(TCGContext *s, TCGArg arg1, TCGArg arg2,
-                        int const_arg2, int rexw)
+static int tcg_out_cmp(TCGContext *s, TCGCond cond, TCGArg arg1,
+                       TCGArg arg2, int const_arg2, int rexw)
 {
     if (const_arg2) {
         if (arg2 == 0) {
@@ -1462,14 +1462,15 @@ static void tcg_out_cmp(TCGContext *s, TCGArg arg1, TCGArg arg2,
     } else {
         tgen_arithr(s, ARITH_CMP + rexw, arg1, arg2);
     }
+    return tcg_cond_to_jcc[cond];
 }
 
 static void tcg_out_brcond(TCGContext *s, int rexw, TCGCond cond,
                            TCGArg arg1, TCGArg arg2, int const_arg2,
                            TCGLabel *label, bool small)
 {
-    tcg_out_cmp(s, arg1, arg2, const_arg2, rexw);
-    tcg_out_jxx(s, tcg_cond_to_jcc[cond], label, small);
+    int jcc = tcg_out_cmp(s, cond, arg1, arg2, const_arg2, rexw);
+    tcg_out_jxx(s, jcc, label, small);
 }
 
 #if TCG_TARGET_REG_BITS == 32
@@ -1561,6 +1562,7 @@ static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
 {
     bool inv = false;
     bool cleared;
+    int jcc;
 
     switch (cond) {
     case TCG_COND_NE:
@@ -1597,7 +1599,7 @@ static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
          * We can then use NEG or INC to produce the desired result.
          * This is always smaller than the SETCC expansion.
          */
-        tcg_out_cmp(s, arg1, arg2, const_arg2, rexw);
+        tcg_out_cmp(s, TCG_COND_LTU, arg1, arg2, const_arg2, rexw);
 
         /* X - X - C = -C = (C ? -1 : 0) */
         tgen_arithr(s, ARITH_SBB + (neg ? rexw : 0), dest, dest);
@@ -1644,8 +1646,8 @@ static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
         cleared = true;
     }
 
-    tcg_out_cmp(s, arg1, arg2, const_arg2, rexw);
-    tcg_out_modrm(s, OPC_SETCC | tcg_cond_to_jcc[cond], 0, dest);
+    jcc = tcg_out_cmp(s, cond, arg1, arg2, const_arg2, rexw);
+    tcg_out_modrm(s, OPC_SETCC | jcc, 0, dest);
 
     if (!cleared) {
         tcg_out_ext8u(s, dest, dest);
@@ -1716,8 +1718,8 @@ static void tcg_out_movcond(TCGContext *s, int rexw, TCGCond cond,
                             TCGReg dest, TCGReg c1, TCGArg c2, int const_c2,
                             TCGReg v1)
 {
-    tcg_out_cmp(s, c1, c2, const_c2, rexw);
-    tcg_out_cmov(s, tcg_cond_to_jcc[cond], rexw, dest, v1);
+    int jcc = tcg_out_cmp(s, cond, c1, c2, const_c2, rexw);
+    tcg_out_cmov(s, jcc, rexw, dest, v1);
 }
 
 static void tcg_out_ctz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
@@ -1759,8 +1761,8 @@ static void tcg_out_clz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
         tgen_arithi(s, ARITH_XOR + rexw, dest, rexw ? 63 : 31, 0);
 
         /* Since we have destroyed the flags from BSR, we have to re-test.  */
-        tcg_out_cmp(s, arg1, 0, 1, rexw);
-        tcg_out_cmov(s, JCC_JE, rexw, dest, arg2);
+        int jcc = tcg_out_cmp(s, TCG_COND_EQ, arg1, 0, 1, rexw);
+        tcg_out_cmov(s, jcc, rexw, dest, arg2);
     }
 }
 
-- 
2.34.1


