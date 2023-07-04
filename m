Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5437476DC
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 18:37:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGj1C-0001IE-OT; Tue, 04 Jul 2023 12:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGj1B-0001HP-IX
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 12:36:45 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGj14-0001nu-HT
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 12:36:41 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fbc12181b6so65827235e9.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 09:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688488597; x=1691080597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ANDE8o5tT4TCHpJ1lybjyH19qs/lumWSbTmj9hQZYtk=;
 b=raiJEk0nQA0pqGWXspkImP+EkS3myBqBZhuJ0UAYZ2thIttrWMp11BFd2kJW4MgZ7m
 n0BN2mPCgXpPYr4lT0QqWR8BO8CV65kkwnFvTh7Ygd8tfo+/NPmn2mYc+mLTdF1fgtF3
 qgOUztbT3UlUHl6zOGs2XmnJneaTs54veus9UJx/EOahUPlb9a7FUxm5GNmVcDL50/Pm
 MQQq/7oC1jEeI6lLh8tB/erMVCyipJguNhyQVa6A0tznufnB/R1T3kqNiNTuF2m8nfli
 VA32RMxSXey09xxlOQ4/ZHpN4aDWMEVqgVW3VS3F6BeNZ8U7vGGbHOkEVzLh9Ggkr3M1
 A/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688488597; x=1691080597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ANDE8o5tT4TCHpJ1lybjyH19qs/lumWSbTmj9hQZYtk=;
 b=ZY8D6KydpOVFbk39klubaRjSJYFhZriZAI3xEGDCYKLB8/VR+KPusSugfvPA03K+kB
 PBBod69KqGTNv8ILdHFcSFht6zC9oCZpvqbelRiPU+U82tBQmhIjX9ZXo9NvPgu96QgJ
 jMfyJa73mr7awnq6vmAobPtD7r2uJrcqsqgTphZllhYusjce7wGdWaq9muPRPysDNyEN
 P9UzWQAH3Pops9q6rDry7WDB63UwO4vr+J5crGicleb/VjvUj/CEsD/h+MGZpLUevj7O
 tav20gBmy3uI4gG3KmdDDeVxHwQbV4jg+N7rlksEsnbVPRJiCBWGJvEyKTULs2hE4OgF
 JNfg==
X-Gm-Message-State: ABy/qLZJLkt/QvqYRnUK20adZyuxvFlEWQeQ3jzjDINV+4niUdtaeEPo
 vgAdhXayJdmZHZk7X1atDKRGssEadqtuvg/lUDc=
X-Google-Smtp-Source: APBJJlHOz/r2UppZfoACYBp4upU/d98XIJU/PiKONjJCLt8p+Qp9/66jIpax1GgbQOEDN2yfe3GBmw==
X-Received: by 2002:a1c:f30b:0:b0:3fb:ce46:c0b3 with SMTP id
 q11-20020a1cf30b000000b003fbce46c0b3mr10156238wmq.35.1688488597011; 
 Tue, 04 Jul 2023 09:36:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 r8-20020a056000014800b003143b032b7asm4354258wrx.116.2023.07.04.09.36.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 09:36:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/11] target/arm: Avoid splitting Zregs across lines in dump
Date: Tue,  4 Jul 2023 17:36:26 +0100
Message-Id: <20230704163634.3188465-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230704163634.3188465-1-peter.maydell@linaro.org>
References: <20230704163634.3188465-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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


