Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E217E33F0
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:14:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CPL-0000FX-Ol; Mon, 06 Nov 2023 22:05:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0COW-00077q-R5
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:52 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0COL-0000gJ-6N
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:48 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1cc9784dbc1so30248955ad.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326266; x=1699931066; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bwAWQA8/GuVM2/E4PyfEdsUUm5Pmb1ysDSj4ZwY6m/s=;
 b=xjl/alRtLO5lCjOVpUNQ8OuTiUZI5VCGOUh6cDkAZyL/1KYIxE9xiYrShNQ8ULNxL2
 5Vhyychcth0MxJ0S1wKpZKBAwt4LXEznieOc+Zke2/8b6sEdDWi0uIqrVSuyA89IRL13
 fSRCu9IyO8xRDCDBT7U88Bxs0owueOCTaDEEEc0VyzRMmZESQAyMLWN3stAWMYsXgOrR
 UsTG+LczvcusI4WREpRRmE68mitSsacpBcitfeGE2R9RoGDsSVQad0bIPQqsKov/cwdl
 UIE//IUdnZAuav1J7F1qjEqZXIMT/jZ4l7Ea8uRT1bGSjiieaCOo2Qq7QxZKjixzE43B
 OPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326266; x=1699931066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bwAWQA8/GuVM2/E4PyfEdsUUm5Pmb1ysDSj4ZwY6m/s=;
 b=ZIl9AZdUwQEKXe/VbROwamzqFcdhuLeo9vYrpDpzfgmJMdfOuol7wEgcVdjq0tCouq
 tmaylJEIIwttetYl3BSYpOq01QqRVfQUSx9op11cE/PYQ97Z4Ypn3td6GXxErundEzFQ
 2X8QAG57tMheN5ilVHXhp3YZa/jgKeWlEWEY/kWhaNfWNL9C8NCUTzd5WZ7SR2XQE7+x
 lyV6ekfyQcSJqHTMDeJ/B7eC8y0RgZViYUFjVooWl8yjEOZkCtEwS1DJ/PUAwuCp10Qs
 wI2lCrenrI62beCKKd8eBaPYDbrUMvMyN8xvA1ZQXfNAKLjgOAvBXPJjjoBvR9A7skTM
 ZwAg==
X-Gm-Message-State: AOJu0YwVjl7jYbiwj1zycLutaNvw9XvZP2guDzRgXWf+w8rAaRejxQmm
 8ML7FMGNRXb+7p0GNcshY1KahWZKGDfUttA8rt4=
X-Google-Smtp-Source: AGHT+IGAJigh9oWXYQozhD5BqlqnFwfIGOnNcahmKF4WX3EzmkDdoX7+wuXerAfiKXXqd692mOb2fQ==
X-Received: by 2002:a17:902:c951:b0:1cc:70dd:62c3 with SMTP id
 i17-20020a170902c95100b001cc70dd62c3mr17744951pla.30.1699326265815; 
 Mon, 06 Nov 2023 19:04:25 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u9-20020a17090282c900b001c72d5e16acsm6518012plz.57.2023.11.06.19.04.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:04:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 23/85] target/hppa: Adjust hppa_cpu_dump_state for hppa64
Date: Mon,  6 Nov 2023 19:03:05 -0800
Message-Id: <20231107030407.8979-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Dump all 64 bits for pa2.0 and low 32 bits for pa1.x.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/helper.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/target/hppa/helper.c b/target/hppa/helper.c
index fa17fe6931..c973b65bea 100644
--- a/target/hppa/helper.c
+++ b/target/hppa/helper.c
@@ -111,18 +111,26 @@ void cpu_hppa_put_psw(CPUHPPAState *env, target_ureg psw)
 
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
@@ -143,13 +151,15 @@ void hppa_cpu_dump_state(CPUState *cs, FILE *f, int flags)
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


