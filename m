Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A560D7DA90E
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:48:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwpG0-0004uf-Nl; Sat, 28 Oct 2023 15:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFa-0004jg-TS
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:38 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFY-00047S-Hv
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:37 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2800f7c8125so1116322a91.1
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698522335; x=1699127135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eaS806fXDgpWYQcWW93tmIyE7x8YLTYsN4JgDu9oFC8=;
 b=rVgYZSBt9Pf8H91V09NR2pblM28ZYPRm5NL8J7nvng+Xw9L0PyoB/kK8MfwZzkd7I1
 NglQeXllnGLqagki+JcqFUhntBCKPNNLc/sC9pg1aqJ1tyGFn83LwR9pUJyBmpwxqZsY
 cAhZpT4J8XOgFyVZcVQ6IJ2Jc5N6/dw59MT3vjtjIqZ/VyTpo5U8uuRcvbAkbIXDoIqD
 iiuEtIk4IF1Y/nmTOBHKrbq7MLG+6YvGEFqAaql4L5Y8SMw9nl09acr9QyveIVMo1qKx
 CAYbHQoogNNnqcQZ5vqWdU5TPs8Bhm5M0E3TepghXUGYVHF032mQcWpcocZ9rppmG4a8
 BQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698522335; x=1699127135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eaS806fXDgpWYQcWW93tmIyE7x8YLTYsN4JgDu9oFC8=;
 b=cN3zVdqvO/iydAw5wV8wAWtASPOoemFUfl1qskKpYGBgpdPra5Z47Ojaer/wKDXqmA
 ljzQreFpVT6CXPE6HH/QPkzHpb5xT9bFIe3Je3bJyyNh2CAUijreCFJ20zxjMGocTsPV
 ecKBPyjQDNfN52XdlouUVxkqxAGQsjRTjMuXQgqRmePBeBa0CLvEmsQd0f/JJMxpCRr2
 H8/g02FZ9qDJ+DQIVUtPWMb76oFJnE58uRIRLtyrVOY+rDU121d7Tr9lGzmC8V/Mqm2g
 buYp3gIDO6LZR9/ksS1+609ZHXsedpNXwGn7POB/jDXo0XH060KuEsnqV6BAfXUVSnLd
 T1QA==
X-Gm-Message-State: AOJu0YySU/DA74FxfvxYj951muUVcFAe38rnuj9K5PU2ZDScEFM1KJbE
 xId0MatX+d6+R1sb1a09Wx7DQPtJDZUWJMH7V/E=
X-Google-Smtp-Source: AGHT+IEwNoz8OpQ4Qn4EhH7d9WlqsfZ5iaZQKgOMWXwhAe7n6quAYDBYRCvHNGULUMPdaRPKk4OfFA==
X-Received: by 2002:a17:90b:2405:b0:280:204e:9121 with SMTP id
 nr5-20020a17090b240500b00280204e9121mr3687604pjb.23.1698522335114; 
 Sat, 28 Oct 2023 12:45:35 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170902f7c900b001b8a3e2c241sm3600096plw.14.2023.10.28.12.45.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 12:45:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v2 12/35] tcg/i386: Pass x86 condition codes to tcg_out_cmov
Date: Sat, 28 Oct 2023 12:44:59 -0700
Message-Id: <20231028194522.245170-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231028194522.245170-1-richard.henderson@linaro.org>
References: <20231028194522.245170-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

Hoist the tcg_cond_to_jcc index outside the function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index eeb23d3fca..8b1baa8206 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1669,14 +1669,14 @@ static void tcg_out_setcond2(TCGContext *s, const TCGArg *args,
 }
 #endif
 
-static void tcg_out_cmov(TCGContext *s, TCGCond cond, int rexw,
+static void tcg_out_cmov(TCGContext *s, int jcc, int rexw,
                          TCGReg dest, TCGReg v1)
 {
     if (have_cmov) {
-        tcg_out_modrm(s, OPC_CMOVCC | tcg_cond_to_jcc[cond] | rexw, dest, v1);
+        tcg_out_modrm(s, OPC_CMOVCC | jcc | rexw, dest, v1);
     } else {
         TCGLabel *over = gen_new_label();
-        tcg_out_jxx(s, tcg_cond_to_jcc[tcg_invert_cond(cond)], over, 1);
+        tcg_out_jxx(s, jcc ^ 1, over, 1);
         tcg_out_mov(s, TCG_TYPE_I32, dest, v1);
         tcg_out_label(s, over);
     }
@@ -1687,7 +1687,7 @@ static void tcg_out_movcond(TCGContext *s, int rexw, TCGCond cond,
                             TCGReg v1)
 {
     tcg_out_cmp(s, c1, c2, const_c2, rexw);
-    tcg_out_cmov(s, cond, rexw, dest, v1);
+    tcg_out_cmov(s, tcg_cond_to_jcc[cond], rexw, dest, v1);
 }
 
 static void tcg_out_ctz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
@@ -1699,12 +1699,12 @@ static void tcg_out_ctz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
             tcg_debug_assert(arg2 == (rexw ? 64 : 32));
         } else {
             tcg_debug_assert(dest != arg2);
-            tcg_out_cmov(s, TCG_COND_LTU, rexw, dest, arg2);
+            tcg_out_cmov(s, JCC_JB, rexw, dest, arg2);
         }
     } else {
         tcg_debug_assert(dest != arg2);
         tcg_out_modrm(s, OPC_BSF + rexw, dest, arg1);
-        tcg_out_cmov(s, TCG_COND_EQ, rexw, dest, arg2);
+        tcg_out_cmov(s, JCC_JE, rexw, dest, arg2);
     }
 }
 
@@ -1717,7 +1717,7 @@ static void tcg_out_clz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
             tcg_debug_assert(arg2 == (rexw ? 64 : 32));
         } else {
             tcg_debug_assert(dest != arg2);
-            tcg_out_cmov(s, TCG_COND_LTU, rexw, dest, arg2);
+            tcg_out_cmov(s, JCC_JB, rexw, dest, arg2);
         }
     } else {
         tcg_debug_assert(!const_a2);
@@ -1730,7 +1730,7 @@ static void tcg_out_clz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
 
         /* Since we have destroyed the flags from BSR, we have to re-test.  */
         tcg_out_cmp(s, arg1, 0, 1, rexw);
-        tcg_out_cmov(s, TCG_COND_EQ, rexw, dest, arg2);
+        tcg_out_cmov(s, JCC_JE, rexw, dest, arg2);
     }
 }
 
-- 
2.34.1


