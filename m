Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A45B07D593C
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 19:00:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvKkb-0000Em-Ed; Tue, 24 Oct 2023 12:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvKkZ-0000D4-O5
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:59:27 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvKkY-0002jJ-31
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:59:27 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-53e2308198eso7353768a12.1
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 09:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698166763; x=1698771563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iByrXA/jbstkhKAzvnIubYkosqn7r/1jZtcy6mOhkro=;
 b=KpQsHF6Y8nbywuccYUbXI+PxdOZziu6v4oDcovgcMnR1faLGBcqOruZ9mvxb/dxNkR
 z6HCUvUQIbhNDyaAKy0s0j82HVFmCY30c+s5XfC56xfQXGyJeoc8IanLrnxlImN4RggL
 oOxFG82vsTU7+f3kFsAZmWnQIj8F9wq7xEgjafiZabNeE7uB9pyjQvoY8f3565fkzzzs
 gO0ZXTS2mQpbn+uYfK/pqNsJa3tp42O/BuwFeoEcr2xeKrlw9s7thYYZSYh/ysBihOsD
 VidszGcMKSIfJ8IH8xwLGJKi0mEF3oICtC8eL+O4ey//Jd6c2YYA/W5+LCm2JKPQC2TZ
 CYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698166763; x=1698771563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iByrXA/jbstkhKAzvnIubYkosqn7r/1jZtcy6mOhkro=;
 b=hxuDnQ7TOt4RvqtaUtroSo9kzNColzmovUSF0dW0TxHmBV/21w3Wt+woj6WYcUsClq
 bY8caYD9c/xUfNMGam4Io8C0+AcTC7TZZdvQVMQXFcySKXF+jFScn/Paf79asTWQf6Z7
 T2zfE6IYlvb15ehAOt42N/L6/wpPtAd1JIuWxwZpM8sAVmY7pnae4oLeMJ/RUcqitMNC
 8AaLtnG1hojH0xkoJtdRZuSfZEmvn73Gaq08UXSXy5L31dA/rj3CtZHT3l/1DNEGcPzz
 cqRE+pQp3OZX3uKv+VIOil8QassqQgZdTO97Itpkxl7gY19VGhdxpBPqTAmmk0Bp63vW
 2++Q==
X-Gm-Message-State: AOJu0YxqOnuRmmlFDKuMeg5GAnUQNPxnuQFAXEyyfbioPqMCEP112oWm
 HyzYw7JSOy5zpkGqBslG6bbrx45y8Zj9myjgUUE=
X-Google-Smtp-Source: AGHT+IHA13AeIznXvhDlLZ6rrN9dv7/351ys1WkM+S+Gy/xbo39kmwfEGnBcbvxIlCXtwiYr1r5pIA==
X-Received: by 2002:a05:6402:3549:b0:514:9ab4:3524 with SMTP id
 f9-20020a056402354900b005149ab43524mr12299177edd.7.1698166763229; 
 Tue, 24 Oct 2023 09:59:23 -0700 (PDT)
Received: from m1x-phil.lan (sem44-h01-176-172-55-165.dsl.sta.abo.bbox.fr.
 [176.172.55.165]) by smtp.gmail.com with ESMTPSA id
 v15-20020a056402174f00b0054042ebbb86sm4089239edx.89.2023.10.24.09.59.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Oct 2023 09:59:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 3/9] target/i386: Use tcg_gen_extract_tl
Date: Tue, 24 Oct 2023 18:58:56 +0200
Message-ID: <20231024165903.40861-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024165903.40861-1-philmd@linaro.org>
References: <20231024165903.40861-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
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

Inspired-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/translate.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 587d88692a..25289eeec9 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1159,8 +1159,7 @@ static void gen_setcc1(DisasContext *s, int b, TCGv reg)
 
     if (cc.cond == TCG_COND_NE && !cc.use_reg2 && cc.imm == 0 &&
         cc.mask != 0 && (cc.mask & (cc.mask - 1)) == 0) {
-        tcg_gen_shri_tl(reg, cc.reg, ctztl(cc.mask));
-        tcg_gen_andi_tl(reg, reg, 1);
+        tcg_gen_extract_tl(reg, cc.reg, ctztl(cc.mask), 1);
         return;
     }
     if (cc.mask != -1) {
@@ -1783,8 +1782,7 @@ static void gen_rot_rm_T1(DisasContext *s, MemOp ot, int op1, int is_right)
        currently dead.  */
     if (is_right) {
         tcg_gen_shri_tl(cpu_cc_src2, s->T0, mask - 1);
-        tcg_gen_shri_tl(cpu_cc_dst, s->T0, mask);
-        tcg_gen_andi_tl(cpu_cc_dst, cpu_cc_dst, 1);
+        tcg_gen_extract_tl(cpu_cc_dst, s->T0, mask, 1);
     } else {
         tcg_gen_shri_tl(cpu_cc_src2, s->T0, mask);
         tcg_gen_andi_tl(cpu_cc_dst, s->T0, 1);
@@ -1873,8 +1871,7 @@ static void gen_rot_rm_im(DisasContext *s, MemOp ot, int op1, int op2,
            currently dead.  */
         if (is_right) {
             tcg_gen_shri_tl(cpu_cc_src2, s->T0, mask - 1);
-            tcg_gen_shri_tl(cpu_cc_dst, s->T0, mask);
-            tcg_gen_andi_tl(cpu_cc_dst, cpu_cc_dst, 1);
+            tcg_gen_extract_tl(cpu_cc_dst, s->T0, mask, 1);
         } else {
             tcg_gen_shri_tl(cpu_cc_src2, s->T0, mask);
             tcg_gen_andi_tl(cpu_cc_dst, s->T0, 1);
-- 
2.41.0


