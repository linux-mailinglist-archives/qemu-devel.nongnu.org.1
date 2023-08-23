Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59021784FF2
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 07:19:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYgEM-0004yV-E3; Wed, 23 Aug 2023 01:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYgEJ-0004xl-HE
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 01:16:31 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYgEG-0000tj-Tp
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 01:16:31 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1bdca7cc28dso41696165ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 22:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692767787; x=1693372587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rd/JAW+sPFhTSaNKV0zPbZhlNEehxWna67gnUamPROE=;
 b=sAzrnDjADtEPs0fYVdyi6WEIN4aZOB+g+alB9E/rM1uQKnNgU1lmsQpxXvas5RxAyQ
 iTsP1SIKaEn0Q4xByYZGhvQ/yMO4bCCfDOYLWyRL51nMxNoE1G3Bhmn3jHexz5ByHf2K
 xDsP5OuUXDp5BHvu780W5mMOlI3NQsijyjeUYcALXCTHSNf8XxCsIHHH1/MbirzEH2ZS
 CRu3/Fm7S5K7rIJ+me9ObIJwOZsfQnaw3XfM3HZ9FXmHjy7bpXI87FwulX3+9NNKIEzv
 FthY/EijNmFFpebbZMvCzKsLyr0lB4H8e8M+cNDohVoBMi5FssV2kl6cKsRNnDpJlVHb
 wAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692767787; x=1693372587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rd/JAW+sPFhTSaNKV0zPbZhlNEehxWna67gnUamPROE=;
 b=gkcSN2d3tHk10AMTvyvgqaRlWJSa6nk5jCqgk3Dutk9jU5g+9cF5N/WHd0RsE3kX5U
 GzvDcqfNYwloPVLu4YJ7C2bVdENuEU4jODWIN0euwa2gX9giFve9Kmy/y0Cwqpqhxg6c
 aMCv7RtBr6RqLR4GhB6Caze8DYI9mDF8g8ONU9COQ0w4NhbVNurbXNYYCJMDq6msOlKe
 ZI0e3OKBWTJ72kQ3UReXCUOcZ84K55XqhA6WOIATp5Oph5aNiGSMgtvl5UbH2QA4msYk
 i6GLcn+Sddg4E9UrWUApaHXGWZVKAxfJPYaUGDx1lFHQ6V6GlojFMZiTLhC7ipOauwRA
 NIbQ==
X-Gm-Message-State: AOJu0YwEjS7NL2uLoCAkrUS0F4C7cB63vRiETu+jShTsATWouNdGoNd+
 ykBoPqEqjxvwLuajRBJqkQmeP4yeQth2dBmZXEI=
X-Google-Smtp-Source: AGHT+IFpyvK8zj5rs7xP4w11xWk7fNgmCJ3etkImBYXLKN93Jp8wdYcGLBOj5CFebs1H2FIJ4qBW5g==
X-Received: by 2002:a17:903:2446:b0:1b1:9233:bbf5 with SMTP id
 l6-20020a170903244600b001b19233bbf5mr13342984pls.57.1692767787471; 
 Tue, 22 Aug 2023 22:16:27 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:4e3c:f4a4:b92a:b5ab])
 by smtp.gmail.com with ESMTPSA id
 5-20020a170902c24500b001bf044dc1a6sm9969402plg.39.2023.08.22.22.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 22:16:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v4 09/10] linux-user: Split out host_sig{segv,bus}_handler
Date: Tue, 22 Aug 2023 22:16:14 -0700
Message-Id: <20230823051615.1297706-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823051615.1297706-1-richard.henderson@linaro.org>
References: <20230823051615.1297706-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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
index a6917eadd8..68ceb2e4bd 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -815,6 +815,80 @@ void die_with_backtrace(siginfo_t *info)
     abort();
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
+        die_with_backtrace(info);
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
+        die_with_backtrace(info);
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
     CPUArchState *env = thread_cpu->env_ptr;
@@ -826,73 +900,23 @@ static void host_signal_handler(int host_sig, siginfo_t *info, void *puc)
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
-            die_with_backtrace(info);
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
@@ -933,6 +957,7 @@ static void host_signal_handler(int host_sig, siginfo_t *info, void *puc)
      * would write 0xff bytes off the end of the structure and trash
      * data on the struct.
      */
+    sigmask = host_signal_mask(uc);
     memset(sigmask, 0xff, SIGSET_T_SIZE);
     sigdelset(sigmask, SIGSEGV);
     sigdelset(sigmask, SIGBUS);
-- 
2.34.1


