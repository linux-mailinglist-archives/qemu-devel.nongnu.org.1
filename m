Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5603E7DEA1E
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:36:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMck-0000S9-I8; Wed, 01 Nov 2023 21:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMbN-0006iO-0U
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:30 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMbJ-0002BT-Na
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:27 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1cc68c1fac2so3495015ad.0
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888863; x=1699493663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nPDrqyoPtn/P2Y3dlnz8L7OPFIA66GeNv3k0Fexkp9U=;
 b=hzS+e9McjoBxmaeepjlz1ZtieXAgRPKC0fql+/Zjko+QfPWwIh2y6aLyeiIsJOSgAO
 vTZzyFYkczRklRzIDEZUFMmbQbOdeKTf8C5n9IxReDEn+s0ZihAG0L/1nJoFd/isdyFA
 5LS200YjaghUz8ylmJZScyNBCKvpbWR5qJ7mtgBTF1sw5l603h/TmpsiRcZoUvT/jC9m
 rIi7219JuMx91fjsnIdXg1xabk+9apqG4KDufHz7z/JnCf1Dv/R8PnWCClxArQDxGB4l
 6bmrhjgj/DkWuqLQ8hztWiANN6fAeVrNU2eJn07Ru7sWLJrzJoCfK7RsxGFLgt8oUgp2
 c4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888863; x=1699493663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nPDrqyoPtn/P2Y3dlnz8L7OPFIA66GeNv3k0Fexkp9U=;
 b=R+6mfmxoN9SUcxCounlLUGc3KuALK6ru3EPclLbzkTcjdKbauTupswtwSTAAtOz/xe
 37UK4qwWa2M8CkP9bccdX3d/ugKc+7JDJ26UUgic+41bV+QJjeY7WvpiOuiohTADUHeS
 U/CGD+WidzJQMYGst1zAjE1B9+vNru7M2SSkGvlLrPJ8Q8/puvKFZsHPs2lBzLwEP8VW
 czdZ7CaNfwndlMw+zdqr1/Vl1QyL4zbGaxS49oYntrlCflC4b76ubBFz0sSWv5JNaTnB
 5Ce+SgcMgY5x7y6rf3Am6YMUFvRzHh8WDr2H0L3bnlGxoMmAwhipwYpL7JTwoEKCw+tP
 VHDw==
X-Gm-Message-State: AOJu0Yza9FQg/7r+9NVPORKTOIBECjB2V/ynOwCFhDtQXKlWF//nmUXz
 3zfpMlyiNwr5mAq1Az7m+PEpyGSdMApro5CsZvo=
X-Google-Smtp-Source: AGHT+IEOpk5sarXxGs8oIXRmscoQmwCuDuG/FEjA85Iw9ZFR5QPWIxAu2K3rOEHE5t1kmf2wdDNiMA==
X-Received: by 2002:a17:902:ab81:b0:1ca:7f91:aa5d with SMTP id
 f1-20020a170902ab8100b001ca7f91aa5dmr15637499plr.16.1698888863578; 
 Wed, 01 Nov 2023 18:34:23 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 t2-20020a1709027fc200b001a98f844e60sm1918125plb.263.2023.11.01.18.34.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:34:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 78/88] target/hppa: Avoid async_safe_run_on_cpu on
 uniprocessor system
Date: Wed,  1 Nov 2023 18:30:06 -0700
Message-Id: <20231102013016.369010-79-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/mem_helper.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 7132ea221c..602e6c809f 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -480,6 +480,7 @@ void HELPER(ptlb)(CPUHPPAState *env, target_ulong addr)
 {
     CPUState *src = env_cpu(env);
     CPUState *cpu;
+    bool wait = false;
 
     trace_hppa_tlb_ptlb(env);
     run_on_cpu_data data = RUN_ON_CPU_TARGET_PTR(addr);
@@ -487,9 +488,14 @@ void HELPER(ptlb)(CPUHPPAState *env, target_ulong addr)
     CPU_FOREACH(cpu) {
         if (cpu != src) {
             async_run_on_cpu(cpu, ptlb_work, data);
+            wait = true;
         }
     }
-    async_safe_run_on_cpu(src, ptlb_work, data);
+    if (wait) {
+        async_safe_run_on_cpu(src, ptlb_work, data);
+    } else {
+        ptlb_work(src, data);
+    }
 }
 
 void hppa_ptlbe(CPUHPPAState *env)
-- 
2.34.1


