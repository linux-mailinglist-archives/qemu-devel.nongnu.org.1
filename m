Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF077B71A6
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 21:22:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnkxN-00051E-GH; Tue, 03 Oct 2023 15:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkwo-0004sI-2x
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 15:20:47 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkwT-0004e7-Uz
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 15:20:44 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3af65455e7cso864218b6e.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 12:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696360820; x=1696965620; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x2cyUxn+xuVK4D2wBUl4hDzhwAR15+4cIMS3lBIQ8QQ=;
 b=L1JHtDSUHev1yQBec6ka2VC3UPilNJisSYn9X506O0sTBoHtghmDwWnTLxuqF9HdqB
 tVQyVPpcaMCIvAv6eu4wSvi2SWKxuf+D+w1UGABremlEJpWvo4ZsArEEwoIVCExhAES/
 XygsnroxxVJrBU0newSGmDT2yhirVBLpJYakk4ZQM3UfVgpxLEpyHnql6NCmeSnyrvTI
 vH3mIj23JkcjDpcpgyM9n/9RhBPdNbnA9YZr2w5/zY9DT9qf6opb0CoK2rvkU0SxNGIG
 WYJKmBsg9jip3Y3F6xLelLaDiZUZIXEeFSVH98DxRE+KrQEkBn6SHpC2vGsK/mmfzICP
 Ialg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696360820; x=1696965620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x2cyUxn+xuVK4D2wBUl4hDzhwAR15+4cIMS3lBIQ8QQ=;
 b=qg9feWb7VJAOiidUSdYKQjFbFg7okDInPOzITUNCSpdeZ4yfFnxOxPRWQ7LqsgLkuf
 gsn9tPOmKLx3zd1cCG+hct7KXb1GvqD8NXQ7rs0+yXV+OWnDrOG/cOaLHE/gQrKRj/3k
 q19rhlwzLz6lg/J1dUDhLlWg7Wf/i3PPO1j040qJcAT7H68ZstJ9/izJYM1rSqf0i6fG
 K/3bCCCvIJABFAfPfMs3+VJsNhrvTdj834ytqHQMKlst21bUjIgEGdiAv4s62+uW/Aco
 ayZFzHB/90RNmKvG8UHXyiMgrxCwQvkSHddj5As4Ch8LUUWZnF6v5eGhhgt3iwBH8DuW
 nL8g==
X-Gm-Message-State: AOJu0YyyoQKwRwFf+uItHND8gNvEhkd3EVsDMEh8AYO9ZdvDQYGhZ4dn
 /96Q9E62OcIRPUwomZvY6M0nE6M8iTsVteQdScE=
X-Google-Smtp-Source: AGHT+IFJDO/z3jw6PGt8Ss4mqTaUzMh91mfECjNuk8iDbDNSECrsfj3ucYyqndKJLWPwLDPkqiBdlw==
X-Received: by 2002:a05:6808:13c5:b0:3a8:43d5:878b with SMTP id
 d5-20020a05680813c500b003a843d5878bmr604634oiw.2.1696360820120; 
 Tue, 03 Oct 2023 12:20:20 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w5-20020a170902d3c500b001c5fd2a28d3sm1978497plb.28.2023.10.03.12.20.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 12:20:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	deller@gmx.de
Subject: [PATCH v5 7/9] linux-user: Split out host_sig{segv,bus}_handler
Date: Tue,  3 Oct 2023 12:20:10 -0700
Message-Id: <20231003192012.1674888-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003192012.1674888-1-richard.henderson@linaro.org>
References: <20231003192012.1674888-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
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

Make host_signal_handler slightly easier to read.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/signal.c | 145 ++++++++++++++++++++++++++------------------
 1 file changed, 85 insertions(+), 60 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 09840b0eb0..706b8ac7a7 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -811,6 +811,80 @@ void die_from_signal(siginfo_t *info)
     die_with_signal(info->si_signo);
 }
 
+static void host_sigsegv_handler(CPUState *cpu, siginfo_t *info,
+                                 host_sigcontext *uc)
+{
+    uintptr_t host_addr = (uintptr_t)info->si_addr;
+    /*
+     * Convert forcefully to guest address space: addresses outside
+     * reserved_va are still valid to report via SEGV_MAPERR.
+     */
+    bool is_valid = h2g_valid(host_addr);
+    abi_ptr guest_addr = h2g_nocheck(host_addr);
+    uintptr_t pc = host_signal_pc(uc);
+    bool is_write = host_signal_write(info, uc);
+    MMUAccessType access_type = adjust_signal_pc(&pc, is_write);
+    bool maperr;
+
+    /* If this was a write to a TB protected page, restart. */
+    if (is_write
+        && is_valid
+        && info->si_code == SEGV_ACCERR
+        && handle_sigsegv_accerr_write(cpu, host_signal_mask(uc),
+                                       pc, guest_addr)) {
+        return;
+    }
+
+    /*
+     * If the access was not on behalf of the guest, within the executable
+     * mapping of the generated code buffer, then it is a host bug.
+     */
+    if (access_type != MMU_INST_FETCH
+        && !in_code_gen_buffer((void *)(pc - tcg_splitwx_diff))) {
+        die_from_signal(info);
+    }
+
+    maperr = true;
+    if (is_valid && info->si_code == SEGV_ACCERR) {
+        /*
+         * With reserved_va, the whole address space is PROT_NONE,
+         * which means that we may get ACCERR when we want MAPERR.
+         */
+        if (page_get_flags(guest_addr) & PAGE_VALID) {
+            maperr = false;
+        } else {
+            info->si_code = SEGV_MAPERR;
+        }
+    }
+
+    sigprocmask(SIG_SETMASK, host_signal_mask(uc), NULL);
+    cpu_loop_exit_sigsegv(cpu, guest_addr, access_type, maperr, pc);
+}
+
+static void host_sigbus_handler(CPUState *cpu, siginfo_t *info,
+                                host_sigcontext *uc)
+{
+    uintptr_t pc = host_signal_pc(uc);
+    bool is_write = host_signal_write(info, uc);
+    MMUAccessType access_type = adjust_signal_pc(&pc, is_write);
+
+    /*
+     * If the access was not on behalf of the guest, within the executable
+     * mapping of the generated code buffer, then it is a host bug.
+     */
+    if (!in_code_gen_buffer((void *)(pc - tcg_splitwx_diff))) {
+        die_from_signal(info);
+    }
+
+    if (info->si_code == BUS_ADRALN) {
+        uintptr_t host_addr = (uintptr_t)info->si_addr;
+        abi_ptr guest_addr = h2g_nocheck(host_addr);
+
+        sigprocmask(SIG_SETMASK, host_signal_mask(uc), NULL);
+        cpu_loop_exit_sigbus(cpu, guest_addr, access_type, pc);
+    }
+}
+
 static void host_signal_handler(int host_sig, siginfo_t *info, void *puc)
 {
     CPUState *cpu = thread_cpu;
@@ -822,73 +896,23 @@ static void host_signal_handler(int host_sig, siginfo_t *info, void *puc)
     int guest_sig;
     uintptr_t pc = 0;
     bool sync_sig = false;
-    void *sigmask = host_signal_mask(uc);
+    void *sigmask;
 
     /*
      * Non-spoofed SIGSEGV and SIGBUS are synchronous, and need special
      * handling wrt signal blocking and unwinding.
      */
-    if ((host_sig == SIGSEGV || host_sig == SIGBUS) && info->si_code > 0) {
-        MMUAccessType access_type;
-        uintptr_t host_addr;
-        abi_ptr guest_addr;
-        bool is_write;
-
-        host_addr = (uintptr_t)info->si_addr;
-
-        /*
-         * Convert forcefully to guest address space: addresses outside
-         * reserved_va are still valid to report via SEGV_MAPERR.
-         */
-        guest_addr = h2g_nocheck(host_addr);
-
-        pc = host_signal_pc(uc);
-        is_write = host_signal_write(info, uc);
-        access_type = adjust_signal_pc(&pc, is_write);
-
-        /* If this was a write to a TB protected page, restart. */
-        if (is_write
-            && host_sig == SIGSEGV
-            && info->si_code == SEGV_ACCERR
-            && h2g_valid(host_addr)
-            && handle_sigsegv_accerr_write(cpu, sigmask, pc, guest_addr)) {
+    if (info->si_code > 0) {
+        switch (host_sig) {
+        case SIGSEGV:
+            /* Only returns on handle_sigsegv_accerr_write success. */
+            host_sigsegv_handler(cpu, info, uc);
             return;
+        case SIGBUS:
+            host_sigbus_handler(cpu, info, uc);
+            sync_sig = true;
+            break;
         }
-
-        /*
-         * If the access was not on behalf of the guest, within the executable
-         * mapping of the generated code buffer, then it is a host bug.
-         */
-        if (access_type != MMU_INST_FETCH
-            && !in_code_gen_buffer((void *)(pc - tcg_splitwx_diff))) {
-            die_from_signal(info);
-        }
-
-        if (host_sig == SIGSEGV) {
-            bool maperr = true;
-
-            if (info->si_code == SEGV_ACCERR && h2g_valid(host_addr)) {
-                /*
-                 * With reserved_va, the whole address space is PROT_NONE,
-                 * which means that we may get ACCERR when we want MAPERR.
-                 */
-                if (page_get_flags(guest_addr) & PAGE_VALID) {
-                    maperr = false;
-                } else {
-                    info->si_code = SEGV_MAPERR;
-                }
-            }
-
-            sigprocmask(SIG_SETMASK, sigmask, NULL);
-            cpu_loop_exit_sigsegv(cpu, guest_addr, access_type, maperr, pc);
-        } else {
-            sigprocmask(SIG_SETMASK, sigmask, NULL);
-            if (info->si_code == BUS_ADRALN) {
-                cpu_loop_exit_sigbus(cpu, guest_addr, access_type, pc);
-            }
-        }
-
-        sync_sig = true;
     }
 
     /* get target signal number */
@@ -929,6 +953,7 @@ static void host_signal_handler(int host_sig, siginfo_t *info, void *puc)
      * would write 0xff bytes off the end of the structure and trash
      * data on the struct.
      */
+    sigmask = host_signal_mask(uc);
     memset(sigmask, 0xff, SIGSET_T_SIZE);
     sigdelset(sigmask, SIGSEGV);
     sigdelset(sigmask, SIGBUS);
-- 
2.34.1


