Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8051C749D9A
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 15:27:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHOzd-0005Lz-IL; Thu, 06 Jul 2023 09:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qHOzP-0004sH-Eh
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:25:45 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qHOzL-0000r9-SE
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:25:43 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-31427ddd3fbso643062f8f.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 06:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688649916; x=1691241916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ANDE8o5tT4TCHpJ1lybjyH19qs/lumWSbTmj9hQZYtk=;
 b=FKrawGvb0YULfhnbhpMnujLdzjpBqwRsVs9Fk4GUfcYCSVItQS7XqJIplTllGnb0fc
 FMbdOXq+FoUy+HFQ68HLUmY5du/CMi1806TOcLJUrK3VV7r5977x46RRyZRv5ntUfS7c
 AaJP+EPdl3pa1z1GShrk4jNQ5qinH7YeRQ8qo3qQhOZc/gVC06AwfGp0nHg5Mgw58mC2
 poP+zjYIZpp3lVv3TalxdBJsb90nBOIu/qPUqHmGtfzYe+LfBG/91yakT7EnZTAMW1jI
 QJ4Ba+SdvaNDQJtIGpN5Zc9guOdUSjCtrBw7XTYwamBYXWDIlAzWNRBfNgtozVrJBdiL
 K+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688649916; x=1691241916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ANDE8o5tT4TCHpJ1lybjyH19qs/lumWSbTmj9hQZYtk=;
 b=DXTR2ECPU3yNR2U4HLOX4YpnDac0X0/FOiT6KWOPC5OIhhD+RVuc1L8f/KfE8QfCwS
 DTBjFcCzsCGUX9bBulLhRMYERHUd6kI2gEudWGYP7VF0UrSrfyc+Ooo7N+hHHJD2Ilno
 TKcBdAC3MF+3TFb7/a/bTtho2WTuc8c+q2Iqf1IhiF+gDIPWsYCYx9h9/4iPmACRZzPa
 hNZwkvcY/7xCAfp4n9o0cZgY7hJmSToVysd8/eSPOz5KxA8JSIRYC+izqHyMzwlVL3aQ
 +ncv5eyqAV1PZTg1XpweNZuUgbLp6Td/tl5e9C7DbJEy4x8NlmSGlmrk3kVz81OyGt7M
 7wiA==
X-Gm-Message-State: ABy/qLZp0trgeitN/mvXwiLEr6D4apwd8fVePvl91zJmz4pWlHkW0NLb
 igkPpGRtkKJYeVBKypwRT4FxWAAmrjCNibJ7ISM=
X-Google-Smtp-Source: APBJJlHthDv4ijNcqs0/u8Jb/sgaoN2H3/XBo/OJAL5acQKtYYt3YlTCtBCmUWvnYprCAyvaM1Hhlg==
X-Received: by 2002:a05:6000:90c:b0:313:f7f1:e34c with SMTP id
 cw12-20020a056000090c00b00313f7f1e34cmr1461376wrb.60.1688649916035; 
 Thu, 06 Jul 2023 06:25:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s15-20020a5d510f000000b00304adbeeabbsm1856170wrt.99.2023.07.06.06.25.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 06:25:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/14] target/arm: Avoid splitting Zregs across lines in dump
Date: Thu,  6 Jul 2023 14:25:02 +0100
Message-Id: <20230706132512.3534397-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230706132512.3534397-1-peter.maydell@linaro.org>
References: <20230706132512.3534397-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Allow the line length to extend to 548 columns.  While annoyingly wide,
it's still less confusing than the continuations we print.  Also, the
default VL used by Linux (and max for A64FX) uses only 140 columns.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230622151201.1578522-2-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 36 ++++++++++++++----------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index a1e77698ba2..f12c714bc43 100644
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


