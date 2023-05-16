Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0957057B6
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:43:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0Yw-0006nC-8h; Tue, 16 May 2023 15:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0Yu-0006mm-Bb
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:42:20 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0Ys-0002o7-E8
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:42:20 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-64384c6797eso11570558b3a.2
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266137; x=1686858137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kD4l8epPfORT7xhdho6r//UErZNcfQbpb7324wXt3a4=;
 b=c/C67CUhEa5yOSBg+BNaNKAn+XzlPiugXtW9Ek5KjIis4Y6yRsYcKCKoCfyZ4PzhQx
 20ll2WA4BHP9ryt/sBfWWG8zJl+wbsoHJVrmue6zrTEjgGCA+xaz1Pc0IgMyuY6SJgfA
 E8lMIV7ESqvR7A5/OQg2e7qh5smpLSO+NBNzLwaloAHztg0p/X+Nsb0kSCWv7FmWnMNQ
 h7AXA8WIEJM0RAgT693KHE6pqmrA+zTTq5kSj8ppPlksLsSRgsp5ZkwHpBmlyNVqX4W/
 EhLgLbu5YRdnFjqR/Ifg4vRMdoNUjgpTOHeGU0O7Fj/tDV0e2bRt//VfJUAjMLyTtWra
 sr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266137; x=1686858137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kD4l8epPfORT7xhdho6r//UErZNcfQbpb7324wXt3a4=;
 b=mG0aH6emJSAx/gnUdX8jyqcv3s6pLpt+NTwuAslBskqflX6NKmVCRWJLINUeY6bDm2
 /q87f7ScFjGkQx1jrpIMru06PJiEUHjvKjCiOhNA6gLCi+odme4DwfyXLiVH75A4xaPf
 O0vzqBrASKXHtpZ6yzppYfBVwCt+Wl5fFpfkwfQXayhQ9OXUtHz4l/5mouthbjupnwLn
 2iQ+hwjtImso/7Tyk6UtiurjfPcSAnKiV1TRRJHhlDsv2aVGJ0YdgYjXfGyPvV6Gkg6T
 L2RlrKVL9cj5DXzh+zxZ1/ZO9KBewmupLRmoa56nTpQOOoCQ0ye3d4uRHY6T8p1ZCNCX
 5hWQ==
X-Gm-Message-State: AC+VfDyw3k/nhOcqivNINILGNdbVH8xgOyH9g0JtAzpjMZytSZ0fHTVi
 JRO1TTvVIlwD/VY9vYFIdMRa9jtvuftwo7MoXxY=
X-Google-Smtp-Source: ACHHUZ6Y5IX86FUetfxXKbyxKcnqOIKrhF/yhnpAXjY+p6dHSGI+oMkZ2/jTJIqSXZ0AQbP3zjxmCA==
X-Received: by 2002:a05:6a00:1582:b0:643:b37d:d350 with SMTP id
 u2-20020a056a00158200b00643b37dd350mr51882112pfk.31.1684266137618; 
 Tue, 16 May 2023 12:42:17 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 z21-20020aa791d5000000b006260526cf0csm13771165pfa.116.2023.05.16.12.42.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:42:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 34/80] tcg: Introduce tcg_out_movext3
Date: Tue, 16 May 2023 12:40:59 -0700
Message-Id: <20230516194145.1749305-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

With x86_64 as host, we do not have any temporaries with which to
resolve cycles, but we do have xchg.   As a side bonus, the set of
graphs that can be made with 3 nodes and all nodes conflicting is
small: two.  We can solve the cycle with a single temp.

This is required for x86_64 to handle stores of i128: 1 address
register and 2 data registers.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 138 ++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 108 insertions(+), 30 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 44b8c700a7..5de9380c6b 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -532,6 +532,82 @@ static void tcg_out_movext2(TCGContext *s, const TCGMovExtend *i1,
     tcg_out_movext1_new_src(s, i1, src1);
 }
 
+/**
+ * tcg_out_movext3 -- move and extend three pair
+ * @s: tcg context
+ * @i1: first move description
+ * @i2: second move description
+ * @i3: third move description
+ * @scratch: temporary register, or -1 for none
+ *
+ * As tcg_out_movext, for all of @i1, @i2 and @i3, caring for overlap
+ * between the sources and destinations.
+ */
+
+static void tcg_out_movext3(TCGContext *s, const TCGMovExtend *i1,
+                            const TCGMovExtend *i2, const TCGMovExtend *i3,
+                            int scratch)
+{
+    TCGReg src1 = i1->src;
+    TCGReg src2 = i2->src;
+    TCGReg src3 = i3->src;
+
+    if (i1->dst != src2 && i1->dst != src3) {
+        tcg_out_movext1(s, i1);
+        tcg_out_movext2(s, i2, i3, scratch);
+        return;
+    }
+    if (i2->dst != src1 && i2->dst != src3) {
+        tcg_out_movext1(s, i2);
+        tcg_out_movext2(s, i1, i3, scratch);
+        return;
+    }
+    if (i3->dst != src1 && i3->dst != src2) {
+        tcg_out_movext1(s, i3);
+        tcg_out_movext2(s, i1, i2, scratch);
+        return;
+    }
+
+    /*
+     * There is a cycle.  Since there are only 3 nodes, the cycle is
+     * either "clockwise" or "anti-clockwise", and can be solved with
+     * a single scratch or two xchg.
+     */
+    if (i1->dst == src2 && i2->dst == src3 && i3->dst == src1) {
+        /* "Clockwise" */
+        if (tcg_out_xchg(s, MAX(i1->src_type, i2->src_type), src1, src2)) {
+            tcg_out_xchg(s, MAX(i2->src_type, i3->src_type), src2, src3);
+            /* The data is now in the correct registers, now extend. */
+            tcg_out_movext1_new_src(s, i1, i1->dst);
+            tcg_out_movext1_new_src(s, i2, i2->dst);
+            tcg_out_movext1_new_src(s, i3, i3->dst);
+        } else {
+            tcg_debug_assert(scratch >= 0);
+            tcg_out_mov(s, i1->src_type, scratch, src1);
+            tcg_out_movext1(s, i3);
+            tcg_out_movext1(s, i2);
+            tcg_out_movext1_new_src(s, i1, scratch);
+        }
+    } else if (i1->dst == src3 && i2->dst == src1 && i3->dst == src2) {
+        /* "Anti-clockwise" */
+        if (tcg_out_xchg(s, MAX(i2->src_type, i3->src_type), src2, src3)) {
+            tcg_out_xchg(s, MAX(i1->src_type, i2->src_type), src1, src2);
+            /* The data is now in the correct registers, now extend. */
+            tcg_out_movext1_new_src(s, i1, i1->dst);
+            tcg_out_movext1_new_src(s, i2, i2->dst);
+            tcg_out_movext1_new_src(s, i3, i3->dst);
+        } else {
+            tcg_debug_assert(scratch >= 0);
+            tcg_out_mov(s, i1->src_type, scratch, src1);
+            tcg_out_movext1(s, i2);
+            tcg_out_movext1(s, i3);
+            tcg_out_movext1_new_src(s, i1, scratch);
+        }
+    } else {
+        g_assert_not_reached();
+    }
+}
+
 #define C_PFX1(P, A)                    P##A
 #define C_PFX2(P, A, B)                 P##A##_##B
 #define C_PFX3(P, A, B, C)              P##A##_##B##_##C
@@ -5151,46 +5227,48 @@ static int tcg_out_helper_stk_ofs(TCGType type, unsigned slot)
 
 static void tcg_out_helper_load_regs(TCGContext *s,
                                      unsigned nmov, TCGMovExtend *mov,
-                                     unsigned ntmp, const int *tmp)
+                                     const TCGLdstHelperParam *parm)
 {
+    TCGReg dst3;
+
     switch (nmov) {
-    default:
+    case 4:
         /* The backend must have provided enough temps for the worst case. */
-        tcg_debug_assert(ntmp + 1 >= nmov);
+        tcg_debug_assert(parm->ntmp >= 2);
 
-        for (unsigned i = nmov - 1; i >= 2; --i) {
-            TCGReg dst = mov[i].dst;
+        dst3 = mov[3].dst;
+        for (unsigned j = 0; j < 3; ++j) {
+            if (dst3 == mov[j].src) {
+                /*
+                 * Conflict. Copy the source to a temporary, perform the
+                 * remaining moves, then the extension from our scratch
+                 * on the way out.
+                 */
+                TCGReg scratch = parm->tmp[1];
 
-            for (unsigned j = 0; j < i; ++j) {
-                if (dst == mov[j].src) {
-                    /*
-                     * Conflict.
-                     * Copy the source to a temporary, recurse for the
-                     * remaining moves, perform the extension from our
-                     * scratch on the way out.
-                     */
-                    TCGReg scratch = tmp[--ntmp];
-                    tcg_out_mov(s, mov[i].src_type, scratch, mov[i].src);
-                    mov[i].src = scratch;
-
-                    tcg_out_helper_load_regs(s, i, mov, ntmp, tmp);
-                    tcg_out_movext1(s, &mov[i]);
-                    return;
-                }
+                tcg_out_mov(s, mov[3].src_type, scratch, mov[3].src);
+                tcg_out_movext3(s, mov, mov + 1, mov + 2, parm->tmp[0]);
+                tcg_out_movext1_new_src(s, &mov[3], scratch);
+                break;
             }
-
-            /* No conflicts: perform this move and continue. */
-            tcg_out_movext1(s, &mov[i]);
         }
-        /* fall through for the final two moves */
 
+        /* No conflicts: perform this move and continue. */
+        tcg_out_movext1(s, &mov[3]);
+        /* fall through */
+
+    case 3:
+        tcg_out_movext3(s, mov, mov + 1, mov + 2,
+                        parm->ntmp ? parm->tmp[0] : -1);
+        break;
     case 2:
-        tcg_out_movext2(s, mov, mov + 1, ntmp ? tmp[0] : -1);
-        return;
+        tcg_out_movext2(s, mov, mov + 1,
+                        parm->ntmp ? parm->tmp[0] : -1);
+        break;
     case 1:
         tcg_out_movext1(s, mov);
-        return;
-    case 0:
+        break;
+    default:
         g_assert_not_reached();
     }
 }
@@ -5237,7 +5315,7 @@ static void tcg_out_helper_load_slots(TCGContext *s,
     for (i = 0; i < nmov; ++i) {
         mov[i].dst = tcg_target_call_iarg_regs[mov[i].dst];
     }
-    tcg_out_helper_load_regs(s, nmov, mov, parm->ntmp, parm->tmp);
+    tcg_out_helper_load_regs(s, nmov, mov, parm);
 }
 
 static void tcg_out_helper_load_imm(TCGContext *s, unsigned slot,
-- 
2.34.1


