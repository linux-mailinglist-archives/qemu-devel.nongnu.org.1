Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCD87DEA38
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:38:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMXq-0005lp-Tt; Wed, 01 Nov 2023 21:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXk-0005k3-8Z
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:44 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXi-0001c0-Hj
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:44 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6ce2d4567caso204624a34.2
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888641; x=1699493441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bwAWQA8/GuVM2/E4PyfEdsUUm5Pmb1ysDSj4ZwY6m/s=;
 b=siZFd8ifGkwsIzkNPa9LFxAap4VFNal5ML7JviLRKt96DSXbjN3svnYVL4FGgS0Nmq
 bLdkNJ92NIjUlXrINJm4b1Gu+aiy2PT5zyiX8rpbcywwM3e9eIJ32NJAqmHgjBZikw7j
 N3K4nJbioH2WSbj7ITpIZUqI0xQsoC4uCsBDw9sE6uakFz7lipb2ldOitisL2nIa6Vvi
 dF1gzYR+r7X7MRa7ES/4GLCcMsEFm2BlJYyNIxC6A4KazgriTCoZ/BI72sAJQHiwRwiT
 xbYcfCS12j0dDyQJCLzo4l1UogwzzDhX0DyF0DxibqS/qwQJ5TMkrj19DUO2YwGge2Ui
 K1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888641; x=1699493441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bwAWQA8/GuVM2/E4PyfEdsUUm5Pmb1ysDSj4ZwY6m/s=;
 b=SPPcWD4+UhD/hKU3JBm4OtP/QUZ7Fj/hykqtPzJoC0W/WWHTZ6n6+sc0CoT1VASViv
 C3NB9HXK0VZzQ1l5ebCb3HRLrARGKA1E4yGCIIl4bAkXdLe9p+34Wrk4lKhQ0gxLWj0M
 V0egrDLgLosx+x/raM98YC+XMTQjwRjUObJfTmF2bD0BlCsPIzPPN6IyEWSFFZG3m2wa
 W4Q7yZKDAmqI/+IjyWRBhJbId5n0W4a/mJKZWEiTjqc4Hm/PvUL0Pw04dxOD/Us8QxSk
 U/77+zLHf2Q6pnqou4Jz6V6bTM2p2fzqmmRcIxSl4Px0FsFkUkwAZ1yRw/HGDer97h5J
 rx0g==
X-Gm-Message-State: AOJu0YxxKP0c7HGZARjJGTFHvs7opKicwwptdRj3/lYRDhbvO16qnVDS
 fruqpCa7bwLnGohorDyVIet5sHUxmURyMDnAV8g=
X-Google-Smtp-Source: AGHT+IEsIO+8z3Lz4QzWNeXEcLhjKfjjHWTQTT7rRAEG//MKKrpWWDyGkd/NCG2OeesL1+FBZ0ysqQ==
X-Received: by 2002:a9d:62c3:0:b0:6c4:cda6:ff3e with SMTP id
 z3-20020a9d62c3000000b006c4cda6ff3emr17414912otk.18.1698888641431; 
 Wed, 01 Nov 2023 18:30:41 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r23-20020aa78457000000b006979f70fdd5sm1784191pfn.219.2023.11.01.18.30.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:30:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 25/88] target/hppa: Adjust hppa_cpu_dump_state for hppa64
Date: Wed,  1 Nov 2023 18:29:13 -0700
Message-Id: <20231102013016.369010-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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


