Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E4E784826
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 19:03:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYUlt-00008s-3s; Tue, 22 Aug 2023 13:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYUlo-0008Oe-8F
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 13:02:20 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYUlk-0002Kq-1O
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 13:02:20 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-68a1af910e0so2182574b3a.2
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 10:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692723734; x=1693328534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WtbxWpkqRs8uhBP9ntrNj0PDPLSc0E50BaiAIV/fKrE=;
 b=pxAWm1bhjnUv47l+4NiL/g0E8FPIh8B7RFTGlGDQAOLjCP0Cvv8IBPmduyHQJC3vn1
 bKgjUHx0n/J+Q3BJabLrwvezQPUm3yF7c1WcPagV6d7r250tqNW5eCc37dFretT8O2Wx
 JLlTIzvkI5qWBYgb4GiBBRXiQZwwY18On3PYSkFgtJAW//xR+jFBxXU3HBQkbWWn61Hm
 MO9UYwf4NBaHWsHxU0R8pzmsjXtZAWS9ALwFiVzdH501Auur+lrs0MbnRk4sBQeP9DBd
 Y1fEXHdnHavYJrp1vw46jI1ugMQ+mTnPR6bnGn1DHzFtywBtOZRkms5vhWoXNOZvmLnU
 c4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692723734; x=1693328534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WtbxWpkqRs8uhBP9ntrNj0PDPLSc0E50BaiAIV/fKrE=;
 b=QaVCph3ExmkmX5rIJkYQ50gfVfEHSLYwKMaBD6z1hcxFZZat7ombRn16tHFa/nCm7k
 BovE0J9GjbUMN4yNGiTbgC4dVdgaIWj42+x4HOe0Ks8pz7Z+/OZXUFM+6BsE6iQHGZSZ
 5Gny9oNcVpG7gv98y8ti8tC6dqTjhHrR0ckEsYzlIgjQ5jgfeoPE+AdvjdsCPE5DHM5I
 N7rV8ThOv/+rdsbAG0nfidIWk7kq17Av6umXtfjNShNROH2EQki7GqFAz3MLpZsG6D2v
 fYOgsrPUtxMhI6F+P5U/jVA0bBc1jH/PCGpiglwNiymvAQvkl3MdCmNZqyUuq2YqHk1T
 E96w==
X-Gm-Message-State: AOJu0YytxXswwTw9bv/MIF0vFkwzg40N4yy5QdlAleeeAcASK97im6Fy
 unCU84A70q+1F1b/PyRCmjFK44nT0DuaR1o/rpw=
X-Google-Smtp-Source: AGHT+IHeJBztbYQIrkoB+uCz6JDrez/Cyin6MKp5CkcMoXU+chQ8sgo9jTWo99VSLHuwF4o3mn0BIQ==
X-Received: by 2002:a17:90a:854c:b0:26d:1201:a8c4 with SMTP id
 a12-20020a17090a854c00b0026d1201a8c4mr7659567pjw.13.1692723733890; 
 Tue, 22 Aug 2023 10:02:13 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:4e3c:f4a4:b92a:b5ab])
 by smtp.gmail.com with ESMTPSA id
 27-20020a17090a031b00b00264040322desm8761121pje.40.2023.08.22.10.02.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 10:02:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 3/3] linux-user/aarch64: Add ESR signal frame for PACFAIL
Date: Tue, 22 Aug 2023 10:02:09 -0700
Message-Id: <20230822170209.1130173-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822170209.1130173-1-richard.henderson@linaro.org>
References: <20230822170209.1130173-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The PACFAIL fault uses ILL_ILLOPN and includes ESR.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/cpu_loop.c |  7 ++++++-
 linux-user/aarch64/signal.c   |  6 ++++++
 tests/tcg/aarch64/pauth-2.c   | 25 ++++++++++++++++++++++++-
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 22c9789326..5af17e8724 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -110,7 +110,12 @@ void cpu_loop(CPUARMState *env)
             /* just indicate that signals should be handled asap */
             break;
         case EXCP_UDEF:
-            force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPC, env->pc);
+            /* See kernel's do_el0_fpac, and our need_save_esr(). */
+            if (syn_get_ec(env->exception.syndrome) == EC_PACFAIL) {
+                force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPN, env->pc);
+            } else {
+                force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPC, env->pc);
+            }
             break;
         case EXCP_PREFETCH_ABORT:
         case EXCP_DATA_ABORT:
diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index b2280fa9e3..bcdd796cc2 100644
--- a/linux-user/aarch64/signal.c
+++ b/linux-user/aarch64/signal.c
@@ -582,6 +582,7 @@ static bool need_save_esr(target_siginfo_t *info, CPUARMState *env)
 {
     int sig = info->si_signo;
     int type = info->si_code >> 16;
+    int code = info->si_code & 0xffff;
 
     if (type != QEMU_SI_FAULT) {
         return false;
@@ -592,6 +593,11 @@ static bool need_save_esr(target_siginfo_t *info, CPUARMState *env)
         return true;
     }
 
+    /* See arch/arm64/kernel/traps.c, do_el0_fpac, and our cpu_loop(). */
+    if (sig == TARGET_SIGILL && code == TARGET_ILL_ILLOPN) {
+        return true;
+    }
+
     return false;
 }
 
diff --git a/tests/tcg/aarch64/pauth-2.c b/tests/tcg/aarch64/pauth-2.c
index d498d7dd8b..62b39af3d0 100644
--- a/tests/tcg/aarch64/pauth-2.c
+++ b/tests/tcg/aarch64/pauth-2.c
@@ -4,14 +4,37 @@
 #include <assert.h>
 #include <sys/auxv.h>
 
+static inline struct _aarch64_ctx *first_ctx(ucontext_t *uc)
+{
+    return (struct _aarch64_ctx *)&uc->uc_mcontext.__reserved;
+}
+
+static inline struct _aarch64_ctx *next_ctx(struct _aarch64_ctx *hdr)
+{
+    return (struct _aarch64_ctx *)((char *)hdr + hdr->size);
+}
+
 static void sigill(int sig, siginfo_t *info, void *vuc)
 {
     ucontext_t *uc = vuc;
-    uint64_t test;
+    struct _aarch64_ctx *hdr;
+    struct esr_context *ec;
+    uint64_t test, esr;
 
     /* There is only one insn below that is allowed to fault. */
     asm volatile("adr %0, auth2_insn" : "=r"(test));
     assert(test == uc->uc_mcontext.pc);
+
+    /* Find the esr_context. */
+    for (hdr = first_ctx(uc); hdr->magic != ESR_MAGIC; hdr = next_ctx(hdr)) {
+        assert(hdr->magic != 0);
+    }
+
+    ec = (struct esr_context *)hdr;
+    esr = ec->esr;
+
+    assert((esr >> 26) == 0x1c); /* EC_PACFAIL */
+    assert((esr & 3) == 2);      /* AUTDA: data=1 key=0 */
     exit(0);
 }
 
-- 
2.34.1


