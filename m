Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E48077C7F90
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:09:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD4t-0003WX-Qg; Fri, 13 Oct 2023 03:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4n-0002lF-5Q
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:17 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4e-000715-66
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:16 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-405505b07dfso18761495e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183946; x=1697788746; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f7Dg215YCnUAL90pdfPDToNtTtwaGiAP3GeqoTrx5WM=;
 b=m+ohKE0LKpv3/jiIsKOIxOo94AeRXzj0gnjHcXDZkc8B+N+zzcUzLW6XfkfC+LNdMw
 817ckZA7ZsTAMqWPruxbOSvNdcetfqc5XtVhmd1+6zL2rmxNnAf9JQhTHxJjz6hVy172
 sOaxziuoCY88T9vfbq45GvzL7AsWRYLpNviwPCoqmtTgpFLDh3+hIWX6OsIKkhw4ejF7
 3yfK1Xq2ZdflFFfEup8czHeWAdFjcUCvsMJzyAzWmyffbN1oAZhBc4mHniie/JzK7Asq
 gEg5kfU2qfnZdv4ClJ7C5CmJJ6yfJfIdXx5n+XFOK/jIeQ/mOX1yVs2vWpETIMUXIG5p
 IOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183946; x=1697788746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f7Dg215YCnUAL90pdfPDToNtTtwaGiAP3GeqoTrx5WM=;
 b=l341spLgDaX4M+ePzFpRSgv5V2YEdg5FDsGZq1dWop4pfLo4z7gHpLKmhATsJg6w8b
 3AJxXpls3HA8elWzz8Rd9m7b2lHa92og74a10TP8IBB6eDeRlak3NzSwDP6dWrgEzGpW
 agOsh1BQFdE63UWHu2CBPqPl3KJQH7wRR0cQ2aKxSq+kAKz0mrrfnIySOevh/y86Viia
 /U6NA5KX52Hchfn17Ne75XfxPr5rgNJ3z7x1Jh3ksBlw9hAREQmLAUlZ774wwEZzz/aK
 DvB2F9ILiAc3BjFrASRWm46ESOks6ViV+f2whgzqkxArnBIanyWrDsI+40w3UYaQpUfr
 E5HA==
X-Gm-Message-State: AOJu0YxOhY8OJ7Mfajdi8D3oTKQWX5Jm7RbSJnuaEsGo0t43dxyBagZi
 jlLMOw8pV5FMtN4ijpV+cB0gaRD9eznEsgoddKs=
X-Google-Smtp-Source: AGHT+IFTKJxeKoxUBTTjkzPCY3m2IIiJVYmw/o3wTBZdR/GDLzdXPAfaSe5ZFrJcajYF68lHsoOLFQ==
X-Received: by 2002:a5d:5d88:0:b0:32d:5eeb:2a53 with SMTP id
 ci8-20020a5d5d88000000b0032d5eeb2a53mr9880206wrb.4.1697183946482; 
 Fri, 13 Oct 2023 00:59:06 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:59:06 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [RFC PATCH v2 41/78] linux-user: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:57:08 +0300
Message-Id: <c563ab0056605d4a4ba1401b1c310c38b18b3c51.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32d.google.com
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 linux-user/mips/cpu_loop.c | 8 ++++----
 linux-user/mmap.c          | 2 +-
 linux-user/syscall.c       | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index 8735e58bad..38ddcadfc6 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -63,68 +63,68 @@ static void do_tr_or_bp(CPUMIPSState *env, unsigned int code, bool trap)
 void cpu_loop(CPUMIPSState *env)
 {
     CPUState *cs = env_cpu(env);
     int trapnr, si_code;
     unsigned int code;
     abi_long ret;
 # ifdef TARGET_ABI_MIPSO32
     unsigned int syscall_num;
 # endif
 
     for(;;) {
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
         process_queued_cpu_work(cs);
 
         switch(trapnr) {
         case EXCP_SYSCALL:
             env->active_tc.PC += 4;
 # ifdef TARGET_ABI_MIPSO32
             syscall_num = env->active_tc.gpr[2] - 4000;
             if (syscall_num >= sizeof(mips_syscall_args)) {
                 /* syscall_num is larger that any defined for MIPS O32 */
                 ret = -TARGET_ENOSYS;
             } else if (mips_syscall_args[syscall_num] ==
                        MIPS_SYSCALL_NUMBER_UNUSED) {
                 /* syscall_num belongs to the range not defined for MIPS O32 */
                 ret = -TARGET_ENOSYS;
             } else {
                 /* syscall_num is valid */
                 int nb_args;
                 abi_ulong sp_reg;
                 abi_ulong arg5 = 0, arg6 = 0, arg7 = 0, arg8 = 0;
 
                 nb_args = mips_syscall_args[syscall_num];
                 sp_reg = env->active_tc.gpr[29];
                 switch (nb_args) {
                 /* these arguments are taken from the stack */
                 case 8:
                     if ((ret = get_user_ual(arg8, sp_reg + 28)) != 0) {
                         goto done_syscall;
                     }
-                    /* fall through */
+                    fallthrough;
                 case 7:
                     if ((ret = get_user_ual(arg7, sp_reg + 24)) != 0) {
                         goto done_syscall;
                     }
-                    /* fall through */
+                    fallthrough;
                 case 6:
                     if ((ret = get_user_ual(arg6, sp_reg + 20)) != 0) {
                         goto done_syscall;
                     }
-                    /* fall through */
+                    fallthrough;
                 case 5:
                     if ((ret = get_user_ual(arg5, sp_reg + 16)) != 0) {
                         goto done_syscall;
                     }
-                    /* fall through */
+                    fallthrough;
                 default:
                     break;
                 }
                 ret = do_syscall(env, env->active_tc.gpr[2],
                                  env->active_tc.gpr[4],
                                  env->active_tc.gpr[5],
                                  env->active_tc.gpr[6],
                                  env->active_tc.gpr[7],
                                  arg5, arg6, arg7, arg8);
             }
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 8ccaab7859..ff33b4ccf6 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -960,84 +960,84 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
 abi_long target_madvise(abi_ulong start, abi_ulong len_in, int advice)
 {
     abi_ulong len;
     int ret = 0;
 
     if (start & ~TARGET_PAGE_MASK) {
         return -TARGET_EINVAL;
     }
     if (len_in == 0) {
         return 0;
     }
     len = TARGET_PAGE_ALIGN(len_in);
     if (len == 0 || !guest_range_valid_untagged(start, len)) {
         return -TARGET_EINVAL;
     }
 
     /* Translate for some architectures which have different MADV_xxx values */
     switch (advice) {
     case TARGET_MADV_DONTNEED:      /* alpha */
         advice = MADV_DONTNEED;
         break;
     case TARGET_MADV_WIPEONFORK:    /* parisc */
         advice = MADV_WIPEONFORK;
         break;
     case TARGET_MADV_KEEPONFORK:    /* parisc */
         advice = MADV_KEEPONFORK;
         break;
     /* we do not care about the other MADV_xxx values yet */
     }
 
     /*
      * Most advice values are hints, so ignoring and returning success is ok.
      *
      * However, some advice values such as MADV_DONTNEED, MADV_WIPEONFORK and
      * MADV_KEEPONFORK are not hints and need to be emulated.
      *
      * A straight passthrough for those may not be safe because qemu sometimes
      * turns private file-backed mappings into anonymous mappings.
      * If all guest pages have PAGE_PASSTHROUGH set, mappings have the
      * same semantics for the host as for the guest.
      *
      * We pass through MADV_WIPEONFORK and MADV_KEEPONFORK if possible and
      * return failure if not.
      *
      * MADV_DONTNEED is passed through as well, if possible.
      * If passthrough isn't possible, we nevertheless (wrongly!) return
      * success, which is broken but some userspace programs fail to work
      * otherwise. Completely implementing such emulation is quite complicated
      * though.
      */
     mmap_lock();
     switch (advice) {
     case MADV_WIPEONFORK:
     case MADV_KEEPONFORK:
         ret = -EINVAL;
-        /* fall through */
+        fallthrough;
     case MADV_DONTNEED:
         if (page_check_range(start, len, PAGE_PASSTHROUGH)) {
             ret = get_errno(madvise(g2h_untagged(start), len, advice));
             if ((advice == MADV_DONTNEED) && (ret == 0)) {
                 page_reset_target_data(start, start + len - 1);
             }
         }
     }
     mmap_unlock();
 
     return ret;
 }
 
 #ifndef TARGET_FORCE_SHMLBA
 /*
  * For most architectures, SHMLBA is the same as the page size;
  * some architectures have larger values, in which case they should
  * define TARGET_FORCE_SHMLBA and provide a target_shmlba() function.
  * This corresponds to the kernel arch code defining __ARCH_FORCE_SHMLBA
  * and defining its own value for SHMLBA.
  *
  * The kernel also permits SHMLBA to be set by the architecture to a
  * value larger than the page size without setting __ARCH_FORCE_SHMLBA;
  * this means that addresses are rounded to the large size if
  * SHM_RND is set but addresses not aligned to that size are not rejected
  * as long as they are at least page-aligned. Since the only architecture
  * which uses this is ia64 this code doesn't provide for that oddity.
  */
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d49cd314a2..d15817846c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7740,74 +7740,74 @@ static int do_safe_futex(int *uaddr, int op, int val,
 /* ??? Using host futex calls even when target atomic operations
    are not really atomic probably breaks things.  However implementing
    futexes locally would make futexes shared between multiple processes
    tricky.  However they're probably useless because guest atomic
    operations won't work either.  */
 #if defined(TARGET_NR_futex) || defined(TARGET_NR_futex_time64)
 static int do_futex(CPUState *cpu, bool time64, target_ulong uaddr,
                     int op, int val, target_ulong timeout,
                     target_ulong uaddr2, int val3)
 {
     struct timespec ts, *pts = NULL;
     void *haddr2 = NULL;
     int base_op;
 
     /* We assume FUTEX_* constants are the same on both host and target. */
 #ifdef FUTEX_CMD_MASK
     base_op = op & FUTEX_CMD_MASK;
 #else
     base_op = op;
 #endif
     switch (base_op) {
     case FUTEX_WAIT:
     case FUTEX_WAIT_BITSET:
         val = tswap32(val);
         break;
     case FUTEX_WAIT_REQUEUE_PI:
         val = tswap32(val);
         haddr2 = g2h(cpu, uaddr2);
         break;
     case FUTEX_LOCK_PI:
     case FUTEX_LOCK_PI2:
         break;
     case FUTEX_WAKE:
     case FUTEX_WAKE_BITSET:
     case FUTEX_TRYLOCK_PI:
     case FUTEX_UNLOCK_PI:
         timeout = 0;
         break;
     case FUTEX_FD:
         val = target_to_host_signal(val);
         timeout = 0;
         break;
     case FUTEX_CMP_REQUEUE:
     case FUTEX_CMP_REQUEUE_PI:
         val3 = tswap32(val3);
-        /* fall through */
+        fallthrough;
     case FUTEX_REQUEUE:
     case FUTEX_WAKE_OP:
         /*
          * For these, the 4th argument is not TIMEOUT, but VAL2.
          * But the prototype of do_safe_futex takes a pointer, so
          * insert casts to satisfy the compiler.  We do not need
          * to tswap VAL2 since it's not compared to guest memory.
           */
         pts = (struct timespec *)(uintptr_t)timeout;
         timeout = 0;
         haddr2 = g2h(cpu, uaddr2);
         break;
     default:
         return -TARGET_ENOSYS;
     }
     if (timeout) {
         pts = &ts;
         if (time64
             ? target_to_host_timespec64(pts, timeout)
             : target_to_host_timespec(pts, timeout)) {
             return -TARGET_EFAULT;
         }
     }
     return do_safe_futex(g2h(cpu, uaddr), op, val, pts, haddr2, val3);
 }
 #endif
 
 #if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
-- 
2.39.2


