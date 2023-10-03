Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D849A7B71A7
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 21:22:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnkwf-0004km-JX; Tue, 03 Oct 2023 15:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkwW-0004iD-VB
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 15:20:29 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkwT-0004dp-S5
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 15:20:28 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c3bd829b86so10636455ad.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 12:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696360817; x=1696965617; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wk7Bln+tqnBhQ7Rx4jjEi5WJUcqRNod/ibptYsj0x9Y=;
 b=SfZx7chibSlbVQIex+biKqqAYrZpLoHopZIlIEkXduCAEJFKmjAWKQsRVzL/soHdJD
 t/ZLHJfoi2PvLQjNaNl/k0Up/KauXIr0mwGtTedMEAsc4WgqGFiOLQ29JgC/Q1JSSFdO
 dy1UQxiqglIYkZutxwaUFDaecAz456t4PXtWmxzXdIwuHfJhRuwd+nUp48cvpOOdbyck
 pAFjf+Q9AsTqwnq2z7W++BD2UcVBRHrXpjydh1JhjKar1RjYwfPv7dUaNGv7bNiDgcEN
 NSJjEBkhgLht++l6iCOoPD0sbBseHWAxPCiXAr+Ux4Btgwu42WUDotMI3oMORjqYXmuJ
 o1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696360817; x=1696965617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wk7Bln+tqnBhQ7Rx4jjEi5WJUcqRNod/ibptYsj0x9Y=;
 b=TAA9cV2YIeLnpPIz0RU9Pc4FV37zbqM8USV3l47sByMFetgAYREkk8cfZJSvf4e5jf
 HcUjWkiydav/6QHjcIbkDIoloHXt5Em2FSQr6BJjyS7DvQngt9Xr0qFIjbOAOEcIoAVW
 Yyh4rz8ryonyo4GlQYpOmHJaiwgDsySZ4UVRulLU7mwvJSXPwcw4RDoUaJXNcex4OBoT
 sbnvLwQ0EmYHQDD26qFtqghuv1u46JoGKU/cOZrJVs+8knf2JHZRl/FbsE61ypsZZp7B
 I8wFI6jSehsjVUXzLGQhiRI2jCdVKp5MF3u8kb/fu1Ows2WuZnDgpbFXAAc5XK4XKuNt
 GAeg==
X-Gm-Message-State: AOJu0YwNhnERBGYmgNJD+YO2ysb0ZXYJ53Sr94xVaibWZKV+FNPK7k7w
 SNVKTk9dINy+1U9FyQiZauzPnwsxdrJ359fRFYg=
X-Google-Smtp-Source: AGHT+IHp3qbunhvt1pl0RgtEoDR18J4AWpuOh0MOfn0fVW/JZLFzhTo9oA/ufowpZy20gyeCzY/KmQ==
X-Received: by 2002:a17:902:d489:b0:1c3:cdf5:d891 with SMTP id
 c9-20020a170902d48900b001c3cdf5d891mr615392plg.46.1696360817040; 
 Tue, 03 Oct 2023 12:20:17 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w5-20020a170902d3c500b001c5fd2a28d3sm1978497plb.28.2023.10.03.12.20.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 12:20:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	deller@gmx.de
Subject: [PATCH v5 4/9] linux-user: Only register handlers for
 core_dump_signal by default
Date: Tue,  3 Oct 2023 12:20:07 -0700
Message-Id: <20231003192012.1674888-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003192012.1674888-1-richard.henderson@linaro.org>
References: <20231003192012.1674888-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

The set of fatal signals is really immaterial.  If one arrives,
and is unhandled, then the qemu process dies and the parent gets
the correct signal.

It is only for those signals which we would like to perform a
guest core dump instead of a host core dump that we need to catch.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/signal.c | 43 ++++++++++++++-----------------------------
 1 file changed, 14 insertions(+), 29 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 9fadc51347..aab05f8eec 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -488,26 +488,6 @@ void target_to_host_siginfo(siginfo_t *info, const target_siginfo_t *tinfo)
     info->si_value.sival_ptr = (void *)(long)sival_ptr;
 }
 
-static int fatal_signal (int sig)
-{
-    switch (sig) {
-    case TARGET_SIGCHLD:
-    case TARGET_SIGURG:
-    case TARGET_SIGWINCH:
-        /* Ignored by default.  */
-        return 0;
-    case TARGET_SIGCONT:
-    case TARGET_SIGSTOP:
-    case TARGET_SIGTSTP:
-    case TARGET_SIGTTIN:
-    case TARGET_SIGTTOU:
-        /* Job control signals.  */
-        return 0;
-    default:
-        return 1;
-    }
-}
-
 /* returns 1 if given signal should dump core if not handled */
 static int core_dump_signal(int sig)
 {
@@ -602,8 +582,9 @@ void signal_init(void)
            SIGSEGV and SIGBUS, to detect exceptions.  We can not just
            trap all signals because it affects syscall interrupt
            behavior.  But do trap all default-fatal signals.  */
-        if (fatal_signal (i))
+        if (core_dump_signal(i)) {
             sigaction(host_sig, &act, NULL);
+        }
     }
 }
 
@@ -997,7 +978,6 @@ int do_sigaction(int sig, const struct target_sigaction *act,
                  struct target_sigaction *oact, abi_ulong ka_restorer)
 {
     struct target_sigaction *k;
-    struct sigaction act1;
     int host_sig;
     int ret = 0;
 
@@ -1057,22 +1037,27 @@ int do_sigaction(int sig, const struct target_sigaction *act,
             return 0;
         }
         if (host_sig != SIGSEGV && host_sig != SIGBUS) {
+            struct sigaction act1;
+
             sigfillset(&act1.sa_mask);
             act1.sa_flags = SA_SIGINFO;
-            if (k->sa_flags & TARGET_SA_RESTART)
-                act1.sa_flags |= SA_RESTART;
-            /* NOTE: it is important to update the host kernel signal
-               ignore state to avoid getting unexpected interrupted
-               syscalls */
             if (k->_sa_handler == TARGET_SIG_IGN) {
+                /*
+                 * It is important to update the host kernel signal ignore
+                 * state to avoid getting unexpected interrupted syscalls.
+                 */
                 act1.sa_sigaction = (void *)SIG_IGN;
             } else if (k->_sa_handler == TARGET_SIG_DFL) {
-                if (fatal_signal (sig))
+                if (core_dump_signal(sig)) {
                     act1.sa_sigaction = host_signal_handler;
-                else
+                } else {
                     act1.sa_sigaction = (void *)SIG_DFL;
+                }
             } else {
                 act1.sa_sigaction = host_signal_handler;
+                if (k->sa_flags & TARGET_SA_RESTART) {
+                    act1.sa_flags |= SA_RESTART;
+                }
             }
             ret = sigaction(host_sig, &act1, NULL);
         }
-- 
2.34.1


