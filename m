Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2459AA6589
	for <lists+qemu-devel@lfdr.de>; Thu,  1 May 2025 23:31:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbPx-0008OJ-0m; Thu, 01 May 2025 17:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbOu-0005GE-HL
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:25:01 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbOo-0002CN-B0
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:24:59 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-72d3b48d2ffso1656473b3a.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134692; x=1746739492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ee3yc1GwjdX802YpUH6+ttgdvKSjZdMr+u38Re0lfBg=;
 b=Ud/tWVp3/qAqabq4N9jDdG9zBVqogCmL8CJAzSTK1UTd0prPGowqqABxN1RCF9wrWz
 svUZULI4cHjqSj73RzFwTunQ3CIg2Y2ip3rbDmRJgciFbR88txPxm2CHp6/GNcGH35jf
 qqPkwbDKjVIX5y7PgwsDiIuNFV+cXTt25TK6yeAHvPwpOd97huYmXlGQtCUNUaZ/3Wrw
 QFEPG3UDmPB3CmWhiwyKwyl+82W1SeVg4iB88deLL6eqQ9HZLxNED65EoLzm74Kc1B9r
 YG8G6EHNXm8EhZWXquLjHmKSPEq8OAVOszgPQclm1NC4mIbX87s8bMQhnG0+3kia6gEd
 sRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134692; x=1746739492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ee3yc1GwjdX802YpUH6+ttgdvKSjZdMr+u38Re0lfBg=;
 b=k2R/QdEP/boiERqQ0ohk5ZXDh2kF8gjiNgaVtmUqdlTcw35Te+oMbKRHcpT45FFbbB
 CHS+cyNSkig+gA57bqQ8lecSFk8eWUXwAWt+RPS/4SKMuZap4dvg5/gtlrMwkbJ/fRVV
 IXjNiJLpcsBS4Im8dG+NzilV8QLRduLIeRdpAb9sam9H4ZiIMKuuxeRMKhmE7ipI94rA
 pAARLw/6/wtLgQ+TQkE9uswJYQN+H0PppQT+0IHVx2LKOzr5DPR668tstnZTjYvhCobr
 +emx25s2+AEEDA9Ae6gA0Odr4dm9/iZPIL/XQdzFwjcTh9ZR2o810akMU+a+/HVoVblZ
 DO1Q==
X-Gm-Message-State: AOJu0YxKyTv4QLrCM0Mw5Gx0z9eXAqYB6maE5DiQsNduLJkSLufOTRIn
 cWF/Ys1XzPAw+0CLFRkM16YixBrEkOeU10W0s3/2kHvIgYgF+1md2WLkEYctBOSyzDd4hvKFGeW
 T
X-Gm-Gg: ASbGncuyyHT1NFD5TnSmwvnIAa2vApSapCpYdX50bPEJ6szDH/2uCwikYq33ELEqdQ5
 VnWlOHFdRgbDEnflGsDOYRZXHDXbkUhrNNb0QrJoYOAfxyZqjjEjq0ZiCsUXCv4yOfkNHavnpHM
 fA8o4w24sNmUa0LDhD1FCptfpt8fp8/sKUVyZKTDTmiPzgV/D5F5qjPxHPs4fwbhLrpW6QivV22
 xlrs8fIl3ITuiahrXCH2ohV/qh6jrqphbWn5xyYzE6c6BVv6bYzGpMhEwdnqU6iAzdcHosRU8tJ
 dmB34XfRK8clWIcSx2TKypVbXjB+p4TVEv4/dMqwhOTLSVQ0WFQOGin9+H5dxzLhDM3XhJdvoBA
 =
X-Google-Smtp-Source: AGHT+IEFq8xNX336bIFKytr/uQmtnupiSJLMOCDX+EH85BrDN4n4sUVHVy4Lgn0TxIaKXp5FCYJ01g==
X-Received: by 2002:a05:6a00:4ac2:b0:736:4fe0:2661 with SMTP id
 d2e1a72fcca58-74058a486f4mr609164b3a.11.1746134692505; 
 Thu, 01 May 2025 14:24:52 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590610desm135897b3a.146.2025.05.01.14.24.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:24:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 48/59] accel/tcg: Use vaddr in cpu_loop.h
Date: Thu,  1 May 2025 14:21:02 -0700
Message-ID: <20250501212113.2961531-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Use vaddr instead of abi_ptr or target_ulong for a guest address.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/user/cpu_loop.h | 12 +++++-------
 accel/tcg/user-exec.c   |  2 +-
 linux-user/signal.c     |  4 ++--
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/include/user/cpu_loop.h b/include/user/cpu_loop.h
index 589c66543f..ad8a1d711f 100644
--- a/include/user/cpu_loop.h
+++ b/include/user/cpu_loop.h
@@ -20,11 +20,9 @@
 #ifndef USER_CPU_LOOP_H
 #define USER_CPU_LOOP_H
 
-#include "exec/abi_ptr.h"
+#include "exec/vaddr.h"
 #include "exec/mmu-access-type.h"
-#include "exec/log.h"
-#include "exec/target_long.h"
-#include "special-errno.h"
+
 
 /**
  * adjust_signal_pc:
@@ -46,7 +44,7 @@ MMUAccessType adjust_signal_pc(uintptr_t *pc, bool is_write);
  * Return true if the write fault has been handled, and should be re-tried.
  */
 bool handle_sigsegv_accerr_write(CPUState *cpu, sigset_t *old_set,
-                                 uintptr_t host_pc, abi_ptr guest_addr);
+                                 uintptr_t host_pc, vaddr guest_addr);
 
 /**
  * cpu_loop_exit_sigsegv:
@@ -59,7 +57,7 @@ bool handle_sigsegv_accerr_write(CPUState *cpu, sigset_t *old_set,
  * Use the TCGCPUOps hook to record cpu state, do guest operating system
  * specific things to raise SIGSEGV, and jump to the main cpu loop.
  */
-G_NORETURN void cpu_loop_exit_sigsegv(CPUState *cpu, target_ulong addr,
+G_NORETURN void cpu_loop_exit_sigsegv(CPUState *cpu, vaddr addr,
                                       MMUAccessType access_type,
                                       bool maperr, uintptr_t ra);
 
@@ -73,7 +71,7 @@ G_NORETURN void cpu_loop_exit_sigsegv(CPUState *cpu, target_ulong addr,
  * Use the TCGCPUOps hook to record cpu state, do guest operating system
  * specific things to raise SIGBUS, and jump to the main cpu loop.
  */
-G_NORETURN void cpu_loop_exit_sigbus(CPUState *cpu, target_ulong addr,
+G_NORETURN void cpu_loop_exit_sigbus(CPUState *cpu, vaddr addr,
                                      MMUAccessType access_type,
                                      uintptr_t ra);
 
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 68e01fc584..e1f4c4eacf 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -126,7 +126,7 @@ MMUAccessType adjust_signal_pc(uintptr_t *pc, bool is_write)
  * guest, we'd end up in an infinite loop of retrying the faulting access.
  */
 bool handle_sigsegv_accerr_write(CPUState *cpu, sigset_t *old_set,
-                                 uintptr_t host_pc, abi_ptr guest_addr)
+                                 uintptr_t host_pc, vaddr guest_addr)
 {
     switch (page_unprotect(cpu, guest_addr, host_pc)) {
     case 0:
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 4dafc2c3a2..cd0e7398aa 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -750,7 +750,7 @@ void force_sigsegv(int oldsig)
 }
 #endif
 
-void cpu_loop_exit_sigsegv(CPUState *cpu, target_ulong addr,
+void cpu_loop_exit_sigsegv(CPUState *cpu, vaddr addr,
                            MMUAccessType access_type, bool maperr, uintptr_t ra)
 {
     const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
@@ -766,7 +766,7 @@ void cpu_loop_exit_sigsegv(CPUState *cpu, target_ulong addr,
     cpu_loop_exit_restore(cpu, ra);
 }
 
-void cpu_loop_exit_sigbus(CPUState *cpu, target_ulong addr,
+void cpu_loop_exit_sigbus(CPUState *cpu, vaddr addr,
                           MMUAccessType access_type, uintptr_t ra)
 {
     const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
-- 
2.43.0


