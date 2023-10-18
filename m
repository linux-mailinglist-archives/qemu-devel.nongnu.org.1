Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A214F7CEA61
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 23:57:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtESZ-0001Rq-Tw; Wed, 18 Oct 2023 17:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESH-00017e-Rg
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:51:54 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESG-0004QA-EC
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:51:53 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-57f0f81b2aeso4041299eaf.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697665911; x=1698270711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gxoeDFewjCpExZ9mTpKevDYx6+NicYXRP6vcBDYf3yo=;
 b=j5Aut7FItsu6la4W/zIHqt51lWIp6FKUBwn4hOOghnw8rf/uRYah8IZUQUCt1qC5bJ
 sxFVeaDOgxA9RQWU7/YIFSeAhGQrkGxDKlrz8sms4VCTZIVJCKrGHWpwCiMVXyBTU/J7
 kjmh8kErE4T8grLQ0zTj5pAiXtSqgXWVV7YeSRITHMjJifEHQ8WVNdD3cHHAolclgAwq
 tIgCIndttowTr7QfL/qclJuYLMCNuW2zm/3EBgJaCxtUb7WBHGA8wRiLZMFg/FDxrdol
 BVQRf6eh/bKxIec7VIOa51UkUB62FWIPCZyTsUH+PM0UkF5oM/XJOCaN8hmP9lmRkQSU
 p3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697665911; x=1698270711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gxoeDFewjCpExZ9mTpKevDYx6+NicYXRP6vcBDYf3yo=;
 b=RTw9LGSUEA8wpDwM+e1tZnIwcgxI4zuPYQKvAACMKyffvyNzCExZoLR5B7IY+pqb3/
 Pswbmzhx7gcacQ6PGTkMFnpjyk1dI/SrabaHCL7RNlTvQ5nN1tkbW3XLe2AiEAMdUuwc
 v8W7nlHaFBX7aEpmA1wxaDx/l1WUkl1g7VVqWryVV4b3WuUCNI5K5AANfTsV2qh+1wZH
 ROv+XQC40NmoTJwxyPvghZ3Y512y9OJlcr3dANtmsaTGhPR1/FzVdzYZxAFXoOGoLcGy
 o+a5O/bVhgci1vK/dnYCV/c73Th95Zoq7i+N7Yd0SJZU4s0JWVhK1pgRX30UtwULyQ1o
 bFqw==
X-Gm-Message-State: AOJu0YygV1/3NAMfi1x3u1BWTx2WHwgVligWNdEmEEPm6YwcT3j0Iqqt
 7JQYW9k9WCsRkLjb2Q+oIBJGx9z9Wru2E/guFYM=
X-Google-Smtp-Source: AGHT+IFSLl9+NCYVs6zKOsfGHV7vXziqgt+/AW89G0ZSG5VLnixcA07AEvC6GDVwSKZHdYV50Wd4nQ==
X-Received: by 2002:a05:6358:c62a:b0:166:a6e3:cb9c with SMTP id
 fd42-20020a056358c62a00b00166a6e3cb9cmr296039rwb.5.1697665911306; 
 Wed, 18 Oct 2023 14:51:51 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w17-20020a63f511000000b005b61a024ec7sm2176380pgh.74.2023.10.18.14.51.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:51:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 18/61] target/hppa: Adjust hppa_cpu_dump_state for hppa64
Date: Wed, 18 Oct 2023 14:50:52 -0700
Message-Id: <20231018215135.1561375-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
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
 target/hppa/helper.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/target/hppa/helper.c b/target/hppa/helper.c
index 0ef890184a..04cdbafe9d 100644
--- a/target/hppa/helper.c
+++ b/target/hppa/helper.c
@@ -124,13 +124,17 @@ void hppa_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     target_ureg psw = cpu_hppa_get_psw(env);
     target_ureg psw_cb;
     char psw_c[20];
-    int i;
+    int i, w;
+    uint64_t m;
+
+    w = cpu->is_pa20 ? 16 : 8;
+    m = cpu->is_pa20 ? UINT64_MAX : UINT32_MAX;
 
     qemu_fprintf(f, "IA_F " TARGET_FMT_lx " IA_B " TARGET_FMT_lx
-                 " IIR " TREG_FMT_lx  "\n",
+                 " IIR %0*" PRIx64 "\n",
                  hppa_form_gva_psw(psw, env->iasq_f, env->iaoq_f),
                  hppa_form_gva_psw(psw, env->iasq_b, env->iaoq_b),
-                 env->cr[CR_IIR]);
+                 w, m & env->cr[CR_IIR]);
 
     psw_c[0]  = (psw & PSW_W ? 'W' : '-');
     psw_c[1]  = (psw & PSW_E ? 'E' : '-');
@@ -151,13 +155,15 @@ void hppa_cpu_dump_state(CPUState *cs, FILE *f, int flags)
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


