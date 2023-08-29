Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAB878D06F
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:24:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb83y-0004fo-FX; Tue, 29 Aug 2023 19:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb83u-0004Hj-GO
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 19:23:54 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb83p-0001Ow-74
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 19:23:54 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bf3a2f4528so39093565ad.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 16:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693351428; x=1693956228; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rbgZWuFBEAnasVpd2Kly8rMi99QBufRW3Lhak1ajaXE=;
 b=gHhryrUmHCuN0NKKsuWxIXwBWnIbVCONpe3nOOHM8gQznbPGp014AapaSS23ttzKQ9
 5pw1nWuWyJxh21YrOaMkp+fG0i4++tcQwnuM3RPJg86STOn7zU2d+2hkeHTqQn6B/R9B
 ZJhOLJWGnFCIE1iSpYU25Zu2HmFM4bev3PxnU93DRLkG0Q1jN1n+OhwXNn0j8PSc4K/w
 BrV+4rEjkdzEclt9Y4Rk7DLXbG+lx1rOFWBeuYR1dirXn0+v9v4AG4DdmEs/A+17miCM
 jnEvi6mH0EzSjFfK/Me/GndgH4GTLkmwCHvG+gu9BgeNp/qD/cVujsks3Os/y3baApeE
 lFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693351428; x=1693956228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rbgZWuFBEAnasVpd2Kly8rMi99QBufRW3Lhak1ajaXE=;
 b=c7Edbjc+YOfPEgrJs1mcEYaXrXGP7x8HlMPlYQrjc458HH5NC1bat/F2JWDPB5389o
 SvQ7Qrhm9eDFJLMRBEXdEk+aL16u2thILRX2FgYsWBA6Pm/w5TkZDupu+itS0I6TG3tI
 zmjIcX9fRWNAO8zpmT/lsGzot+ylZh2T5Q1k4d4nvPGx2yinMFgwYplS8YqarOzYTo7j
 xPQm8r1TONi6YjmxZko+9o5BEXyOaCBGs9R/hla5stSg5/saT04LYyElwI5eeoOvDoOt
 obPcuU5/kcBdOURfEEc8cF9bDleYBRUBCKV7DnwevHGwYk1wO2BA3HOqPs2hdn1c9dCu
 oapA==
X-Gm-Message-State: AOJu0YxSIQnk1ytyoC2GSpONbC1WWzJawGa6jqLJlKvtmSj3Gwd4GGFm
 yu3R0FMJLTbyYgfi2p6920zrjrxMhjHOWwi094Y=
X-Google-Smtp-Source: AGHT+IGH6gBlsrRcr1fsbilOUeBolS4SQ0d/3WIPph5nPIWdzXbvVDjPkQ9DgNYL4cepcxTTdu2J+A==
X-Received: by 2002:a17:902:e5cc:b0:1c0:d89e:904a with SMTP id
 u12-20020a170902e5cc00b001c0d89e904amr610179plf.29.1693351427816; 
 Tue, 29 Aug 2023 16:23:47 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 t9-20020a170902e84900b001b9dadf8bd2sm9829970plg.190.2023.08.29.16.23.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 16:23:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: aaron@os.amperecomputing.com, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v5 12/12] linux-user/aarch64: Add ESR signal frame for PACFAIL
Date: Tue, 29 Aug 2023 16:23:35 -0700
Message-Id: <20230829232335.965414-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829232335.965414-1-richard.henderson@linaro.org>
References: <20230829232335.965414-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

The PACFAIL fault uses ILL_ILLOPN and includes ESR.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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
index 40a476c33e..375b8350f6 100644
--- a/linux-user/aarch64/signal.c
+++ b/linux-user/aarch64/signal.c
@@ -582,6 +582,7 @@ static bool need_save_esr(target_siginfo_t *info, CPUARMState *env)
 {
     int sig = info->si_signo;
     int type = info->si_code >> 16;
+    int code = info->si_code & 0xffff;
 
     if (type != QEMU_SI_FAULT) {
         return false;
@@ -596,6 +597,11 @@ static bool need_save_esr(target_siginfo_t *info, CPUARMState *env)
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
index 89ffdbf1df..aaf7c4a19f 100644
--- a/tests/tcg/aarch64/pauth-2.c
+++ b/tests/tcg/aarch64/pauth-2.c
@@ -5,14 +5,37 @@
 #include "pauth.h"
 
 
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


