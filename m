Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF8B7E3416
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:16:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CS1-00063M-3F; Mon, 06 Nov 2023 22:08:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRo-0005UQ-Gx
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:08:12 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRi-0001TP-Hm
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:08:12 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6c32a20d5dbso4117230b3a.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326485; x=1699931285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nPDrqyoPtn/P2Y3dlnz8L7OPFIA66GeNv3k0Fexkp9U=;
 b=sL3fOJnLOR9kZCiEdsGL4sQhMkS4es7TG+BZOcJngDcfWYVNwjzEfdlmlMl3xpHEVM
 vNOCT15b11efDowXaVqNrsU7q1BzzG1WkqBbfge3I+YNAm27+ja6oFXmQe6kRo0jis/R
 gZQZ1wIBY4JWbqQk/N7t56IWK1nnD6bi6spweqG2/nFUQ5eAWWOfInzbFQ7C/2gVUWXe
 ZZGu+26ILxA2YNTGvjCPDtDjX8nT4VVKFMi2MJUeT8tUEVOIQqmivmSgRuXDMYFwKVv4
 SE9eNxa5oiwGLeCQvq2RSPZ/UTASQLxH2Znx+JsQ4oq3itWFMixS2XlW989+FHA1grLT
 i8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326485; x=1699931285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nPDrqyoPtn/P2Y3dlnz8L7OPFIA66GeNv3k0Fexkp9U=;
 b=FD0ygvT7Mfc7JOMMN2Irz3J3am/f3EBsXbIM5RUxjV6Bz3aepPsuJAjKhr59fzrA6F
 BZX2PnL2oHeQ5A1+54ccYtl4MhjHTc1ffgxbGMxCUo3SthpsgkbUQX06cFVzZZoLD0S+
 wSdMm/NhMuok/GSSn+GFBsaRryYJ6OBrNTyxtm0ltl4gRQhNrfaheIk1x3V0zoFG+i3P
 6MBv7CmCrcxdAIWDufk69li+MKQFMCCJAHE162OLCZyNby7PBtJjm8u6k8TI3VDXN8H3
 QVA9PzPJB8Y5EmevSkp+Dite5PhWBHDkQN4ntvcd5SU0HBbVZjIW9rJeB7gj1crjqp/P
 QFLg==
X-Gm-Message-State: AOJu0YyOy+n7JVr4qF3gMkv+1r+XEJ3aoe9SBpSdzqzYLQb0KvqBcCsf
 pJhTS9Trq6U/NZX65AHvj7cb6+xrhQ34gw59sFQ=
X-Google-Smtp-Source: AGHT+IEuHSD7stoDNuRFBdWddGQ0funxm5NxwGr3ZV8FgKzmSS9kuWMAjsh+1PeytQ44BPqcoKq2uQ==
X-Received: by 2002:a05:6a20:7f8a:b0:183:e7ba:8a8a with SMTP id
 d10-20020a056a207f8a00b00183e7ba8a8amr5733730pzj.30.1699326485013; 
 Mon, 06 Nov 2023 19:08:05 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a17090a004d00b0027782f611d1sm6744883pjb.36.2023.11.06.19.08.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:08:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 76/85] target/hppa: Avoid async_safe_run_on_cpu on uniprocessor
 system
Date: Mon,  6 Nov 2023 19:03:58 -0800
Message-Id: <20231107030407.8979-77-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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


