Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D408F7CEC1F
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 01:34:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtG0y-00045x-FD; Wed, 18 Oct 2023 19:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtG0v-0003yy-S3
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 19:31:45 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtG0u-0000LX-4m
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 19:31:45 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-581f78a0206so621684eaf.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 16:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697671903; x=1698276703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N8YP8FFBP63+6pJ6d97ew/Y5ZJwzVjBAkzrh/+j6myU=;
 b=ldUBiC9t4xg2eP9SVkGMYPf+O6B8F/z/eEQjjbaWv19rHu5cT9OQHIsnAGKS+zhv9E
 R/xGG9tFXDsPC1ECVceT7aWN5fZ7DtdElfZiWeWFmH/R7aA4Cz5adZbMcOIY9ud5efye
 ON+G5Ts0IkU0UE8rrCGBkdVWdBsL2zIESGPKUabW4WxjpElL/djugugqhGY0q8ygr+Rp
 wFQrI0RP8nExb5ogRG0pvWfq60u0r/eveUrJTMyERRgO+RRCUWjz9bSRMhsS/j+73b/T
 YlWyDKK18vcYu8Chkt74j4e7DT1jgOShmMLuk5x7nTVFcWOzDcSNR1ssyx+c/kAeCYJg
 P5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697671903; x=1698276703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N8YP8FFBP63+6pJ6d97ew/Y5ZJwzVjBAkzrh/+j6myU=;
 b=Pjy8j5NJQ64Ad0dUsGKtKUwNaY6+U1Q3xveL4n5DiIqint0sGH4elM33ShNaIrOpIh
 ee2w0WY5v6YUP0UeMzxb9lMetA9b5+qRYLHGRb0D2kxpirQL5mk+Dmb5tTGkPt7jUiwX
 hTqJyqMyI4UKWEbDx8eEixcBzkJJqGrPmWRJGNbT1CvDq/qWETjyYCUs3AWUz17099IJ
 XEeeUxnzejsx8UXXqFeosD8z2MGHo5Ueu28f02DEt5W0Nk7UV8WiOhqrM10b6hl4KR5B
 p631fOJvKbwkY4zkZsEFW81K9jbtL9DI28qO90NCsX8v8bp01PurB1qrMSpCopISNJmG
 awaw==
X-Gm-Message-State: AOJu0YwTbpe0gzLDIoxYgVbRNlkfszk4PnZQF29t8Lz4h4O1FqzVdyic
 MuX0dUvBtfMne9eVWNnUrfUWyhIB3W9zRvRW818=
X-Google-Smtp-Source: AGHT+IEUsWEnHKPFEP8Pq2bG3ixCk50BGeyeMtKwvwXDaBPHvVBLHuqUELfNw5B0CBtcbQrzXyznjw==
X-Received: by 2002:a05:6358:9f85:b0:139:9fc3:eade with SMTP id
 fy5-20020a0563589f8500b001399fc3eademr429405rwb.29.1697671902800; 
 Wed, 18 Oct 2023 16:31:42 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 g9-20020aa796a9000000b006be5af77f06sm3881690pfk.2.2023.10.18.16.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 16:31:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 09/14] linux-user: Only register handlers for core_dump_signal
 by default
Date: Wed, 18 Oct 2023 16:31:29 -0700
Message-Id: <20231018233134.1594292-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018233134.1594292-1-richard.henderson@linaro.org>
References: <20231018233134.1594292-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
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

Acked-by: Helge Deller <deller@gmx.de>
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


