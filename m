Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E9B73A481
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 17:13:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCLyn-0006l5-PG; Thu, 22 Jun 2023 11:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qCLyk-0006k8-3k
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 11:12:10 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qCLyi-0000FS-Bs
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 11:12:09 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2b46cad2fd9so81515881fa.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 08:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687446727; x=1690038727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xgozYS6yesRuFgtfrPvOnWO6FnQY+rPAC9VBfJhr4TI=;
 b=k2MD36C0r8i1T00pKZnus47mi/mkA2OkLmmhyGDqoV/ojZSupK647ASkFU0a/PK8Iy
 qI6CQbg2TMaF/1Jf88Pg5oezRwUFnmVtNepfwtTS0QbJsP8NIT28KK0RnH0ZZlDczGHw
 iwBjG5BHPslxYA3CLOwUbCqvV+cshdRPPh2CXDPD1sYac70Ub6C3GN/9YJCB1C4IZ6o6
 CwudoL0Nbz/ONXwjcNyofrhTedV58jGune17Z24CBdhvzA9i4G7F5mJqiu8rBbFKwifN
 exKBYWAJ0SAyeWlzYa156SV5tXA4J8EGABWR8a8l/2EQWbJZHnKxqwQsiTBgeQ0ayNRh
 li1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687446727; x=1690038727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xgozYS6yesRuFgtfrPvOnWO6FnQY+rPAC9VBfJhr4TI=;
 b=ZaXZ9N0KeIParuitba+BePrSatIcRrbcw6Zvt2ax1damF/GAg4fiZKmWsiQNNWxTR1
 KYziIkfBaPFSDLJ6icFUqnMUjw4l49VpdC5AeUKzmQm32hfRFmOkvAeKTsZxz646W6h5
 GYVkPvyU6xguvocZiv8XgybJc+9KTdMhLrtxxxzf1lIa3YXCH/fyLwGbHpBPDrGkNme+
 fAv3eRuYAU3q3HupBNpF1m/vGcMz3WMe7GB/ie8ZBycDu2fyjQlsZ6mYH5lGYD+N9Hd4
 US8u7+eX3fVhu10/ePRpqXIZlhgJBcWc7DjdzU5bO9XZcIDr7vCc/9Q//TqPs0Hjr/uX
 t1Pg==
X-Gm-Message-State: AC+VfDyIVYaprMedWcr9EsZnTuR+nRbuV5Yax53LHzHjcePEEs6/Zt2b
 LK383Hjy91/viGK0GAZzcWuVF3BKOUbzf899RxPyO6yd
X-Google-Smtp-Source: ACHHUZ7qtQyj1IuzCs/Zqr14aek8GTU8/RuzT5cvlw1NcCfA3TS/FvttyOa3nOLjJsBigFjS2dg/cQ==
X-Received: by 2002:a2e:880c:0:b0:2b4:6c47:6241 with SMTP id
 x12-20020a2e880c000000b002b46c476241mr9390006ljh.23.1687446726828; 
 Thu, 22 Jun 2023 08:12:06 -0700 (PDT)
Received: from stoup.. ([91.223.100.38]) by smtp.gmail.com with ESMTPSA id
 v3-20020a2e9f43000000b002b47fc5219dsm1320276ljk.67.2023.06.22.08.12.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 08:12:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 1/4] target/arm: Avoid splitting Zregs across lines in dump
Date: Thu, 22 Jun 2023 17:11:58 +0200
Message-Id: <20230622151201.1578522-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230622151201.1578522-1-richard.henderson@linaro.org>
References: <20230622151201.1578522-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x236.google.com
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

Allow the line length to extend to 548 columns.  While annoyingly wide,
it's still less confusing than the continuations we print.  Also, the
default VL used by Linux (and max for A64FX) uses only 140 columns.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 36 ++++++++++++++----------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 353fc48567..7cb70f9727 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -955,7 +955,7 @@ static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
     uint32_t psr = pstate_read(env);
-    int i;
+    int i, j;
     int el = arm_current_el(env);
     const char *ns_status;
     bool sve;
@@ -1014,7 +1014,7 @@ static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     }
 
     if (sve) {
-        int j, zcr_len = sve_vqm1_for_el(env, el);
+        int zcr_len = sve_vqm1_for_el(env, el);
 
         for (i = 0; i <= FFR_PRED_NUM; i++) {
             bool eol;
@@ -1054,32 +1054,24 @@ static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
             }
         }
 
-        for (i = 0; i < 32; i++) {
-            if (zcr_len == 0) {
+        if (zcr_len == 0) {
+            /*
+             * With vl=16, there are only 37 columns per register,
+             * so output two registers per line.
+             */
+            for (i = 0; i < 32; i++) {
                 qemu_fprintf(f, "Z%02d=%016" PRIx64 ":%016" PRIx64 "%s",
                              i, env->vfp.zregs[i].d[1],
                              env->vfp.zregs[i].d[0], i & 1 ? "\n" : " ");
-            } else if (zcr_len == 1) {
-                qemu_fprintf(f, "Z%02d=%016" PRIx64 ":%016" PRIx64
-                             ":%016" PRIx64 ":%016" PRIx64 "\n",
-                             i, env->vfp.zregs[i].d[3], env->vfp.zregs[i].d[2],
-                             env->vfp.zregs[i].d[1], env->vfp.zregs[i].d[0]);
-            } else {
+            }
+        } else {
+            for (i = 0; i < 32; i++) {
+                qemu_fprintf(f, "Z%02d=", i);
                 for (j = zcr_len; j >= 0; j--) {
-                    bool odd = (zcr_len - j) % 2 != 0;
-                    if (j == zcr_len) {
-                        qemu_fprintf(f, "Z%02d[%x-%x]=", i, j, j - 1);
-                    } else if (!odd) {
-                        if (j > 0) {
-                            qemu_fprintf(f, "   [%x-%x]=", j, j - 1);
-                        } else {
-                            qemu_fprintf(f, "     [%x]=", j);
-                        }
-                    }
                     qemu_fprintf(f, "%016" PRIx64 ":%016" PRIx64 "%s",
                                  env->vfp.zregs[i].d[j * 2 + 1],
-                                 env->vfp.zregs[i].d[j * 2],
-                                 odd || j == 0 ? "\n" : ":");
+                                 env->vfp.zregs[i].d[j * 2 + 0],
+                                 j ? ":" : "\n");
                 }
             }
         }
-- 
2.34.1


