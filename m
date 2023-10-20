Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 935877D173F
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:45:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwLz-0007v6-N9; Fri, 20 Oct 2023 16:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLd-0007kR-Ox
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:44:01 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLX-0008BU-Qg
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:43:53 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6b44befac59so1870647b3a.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834630; x=1698439430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ka76jULHKdXJXE2rW24+yLIEC0vFTRHnoerX56yKdQY=;
 b=Qk9+nZ6oQUhUh9SXpMX4MSu6yV0rykmmZVlWtU5JL6qDcKcq2lGWUxbra8bN/CNIco
 peQ2i6QNEa0WI+OyvRK+XIyHS0HrUCqoKd6ARbG+ln+eQhxYNWwy3eAtDaIAdrfeD1qI
 uJxtYUgbGbj/wt4G+rYfa7fjTuydqgd+heIUOE/M/eFGjK1oSh1A28bAfsJJGxWWyVuE
 wkMAAYoPZY4KZBss/RYMnCZ4z7CaJVbUM1g7I6dG0Yd+kqSxPxMMKVXWEq+XpVKwLNa5
 2k15bFevOU9GVy9BOST5B3AYdfn3ftEB+SVqCDPwJ+tJLxtpmG1uNTmqnK1x68J7bV57
 yYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834630; x=1698439430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ka76jULHKdXJXE2rW24+yLIEC0vFTRHnoerX56yKdQY=;
 b=Ta2f7c9sLKg8+rIOd/QIg6CxaYpYB9KCP9N/xvqFMTgafITaNnqUKW1yiTzi+5oRPO
 nKkVcVI/6Ip+Gi/bBpaOtvsKOnqka4htiRF+52JWNDyH4DlTJWd8OQc/FRVEzJdw8Yaw
 Q8lXoIrMhdod9Q4XvSJO5LlssJLSJq1fEv7i+OoDVP3tEe/U6hmWkErBYy4lnlLjHL8H
 EDPHZWYwC9osr7u/Y3H1xNT5WfHAp+7qW3WAFOCT1pWQUlSeCDnxo5O/pdS2kW4TR6dL
 F+scVwxzl39sLWNSOE/bFw+gNlINcDwVzQtab0N+MEy/+ENS0EQLx9Z5MECM3uuob5Z5
 No/g==
X-Gm-Message-State: AOJu0Yw8e1O9INfCPkA0fjcgkdp+xTZKy3SABQQbRSnN0TqSm3bmooPd
 0HVVWndRcP3AkyMOftrCPeoE+MDjeAIZITDiCbw=
X-Google-Smtp-Source: AGHT+IHs449f6mvQ13E4i6iz+RUOERkmN3ovxLCa64A5qnUQ766ELwz0VtGwlDjOsbbe+J6RGOI6rA==
X-Received: by 2002:a05:6a20:a110:b0:17b:40:ccc6 with SMTP id
 q16-20020a056a20a11000b0017b0040ccc6mr3754626pzk.4.1697834630033; 
 Fri, 20 Oct 2023 13:43:50 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k15-20020aa7998f000000b00688965c5227sm1944975pfh.120.2023.10.20.13.43.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:43:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 19/65] target/hppa: Adjust hppa_cpu_dump_state for hppa64
Date: Fri, 20 Oct 2023 13:42:45 -0700
Message-Id: <20231020204331.139847-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Dump all 64 bits for pa2.0 and low 32 bits for pa1.x.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/helper.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/target/hppa/helper.c b/target/hppa/helper.c
index 6a00085dae..a2ae7aca30 100644
--- a/target/hppa/helper.c
+++ b/target/hppa/helper.c
@@ -119,18 +119,26 @@ void cpu_hppa_put_psw(CPUHPPAState *env, target_ureg psw)
 
 void hppa_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
-    HPPACPU *cpu = HPPA_CPU(cs);
-    CPUHPPAState *env = &cpu->env;
+    CPUHPPAState *env = cpu_env(cs);
     target_ureg psw = cpu_hppa_get_psw(env);
     target_ureg psw_cb;
     char psw_c[20];
-    int i;
+    int i, w;
+    uint64_t m;
+
+    if (hppa_is_pa20(env)) {
+        w = 16;
+        m = UINT64_MAX;
+    } else {
+        w = 8;
+        m = UINT32_MAX;
+    }
 
     qemu_fprintf(f, "IA_F " TARGET_FMT_lx " IA_B " TARGET_FMT_lx
-                 " IIR " TREG_FMT_lx  "\n",
+                 " IIR %0*" PRIx64 "\n",
                  hppa_form_gva_psw(psw, env->iasq_f, env->iaoq_f),
                  hppa_form_gva_psw(psw, env->iasq_b, env->iaoq_b),
-                 env->cr[CR_IIR]);
+                 w, m & env->cr[CR_IIR]);
 
     psw_c[0]  = (psw & PSW_W ? 'W' : '-');
     psw_c[1]  = (psw & PSW_E ? 'E' : '-');
@@ -151,13 +159,15 @@ void hppa_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     psw_c[16] = (psw & PSW_D ? 'D' : '-');
     psw_c[17] = (psw & PSW_I ? 'I' : '-');
     psw_c[18] = '\0';
-    psw_cb = ((env->psw_cb >> 4) & 0x01111111) | (env->psw_cb_msb << 28);
+    psw_cb = ((env->psw_cb >> 4) & ((target_ureg)-1 / 0xf))
+           | (env->psw_cb_msb << (TARGET_REGISTER_BITS - 4));
 
-    qemu_fprintf(f, "PSW  " TREG_FMT_lx " CB   " TREG_FMT_lx " %s\n",
-                 psw, psw_cb, psw_c);
+    qemu_fprintf(f, "PSW  %0*" PRIx64 " CB   %0*" PRIx64 " %s\n",
+                 w, m & psw, w, m & psw_cb, psw_c);
 
     for (i = 0; i < 32; i++) {
-        qemu_fprintf(f, "GR%02d " TREG_FMT_lx "%c", i, env->gr[i],
+        qemu_fprintf(f, "GR%02d %0*" PRIx64 "%c",
+                     i, w, m & env->gr[i],
                      (i & 3) == 3 ? '\n' : ' ');
     }
 #ifndef CONFIG_USER_ONLY
-- 
2.34.1


