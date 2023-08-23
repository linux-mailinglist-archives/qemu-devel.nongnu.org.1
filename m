Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0AC784FEF
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 07:18:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYgEI-0004wb-0Z; Wed, 23 Aug 2023 01:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYgEE-0004vd-R4
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 01:16:26 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYgEC-0000sv-Iw
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 01:16:26 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1bdca7cc28dso41695865ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 22:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692767783; x=1693372583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QVZ8TmDLEIACLc9a/Qe1Sv9+EQSNfIXJRPDML0Xg9Mk=;
 b=sQoq9fdjunWJscF2evV197uTf6fpJAOQAd/XpXpW8JheP8cbgKKlKRT+CQ+XEzXr8x
 R3I7U4vS25V4dEb24jAn40P5QoK7H4+bgkAwrbZN0auuxFxS4hXa1btg1IkyD5mZN03e
 x5mwEYGtbRXVWsLdKNz7B0hN2DhgLCNsX5Il2noTkmXYi179NMfpIXypuNitno3Zykrp
 gWI2vw+a3OyDgYzV3yLmMlW3+IsGHYkFGI3Svg2+B5t6xValivcQ+3DhQGXtO03s0SmB
 biNcIqWugYIIjvKHJnVDwqK/mJkdS4dXrJYPXEhY3d4iQhUKLdFbtBcG1VKA9mQ51TT4
 v9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692767783; x=1693372583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QVZ8TmDLEIACLc9a/Qe1Sv9+EQSNfIXJRPDML0Xg9Mk=;
 b=PUBdCw8lNwxpfCjqY7meiGD8cD/3oUwKi19sEVottozlyPcsJmnorzp71En3e4LV0L
 Ct1urwjw5ppUJFq2Fnz7jxDJ+o641l5XLKVzY4f9unvTTIWO0ZKND2hYIncn2diWbCOv
 /0RyckPIm15CULwOy4xE28RK9I0TsOAvjTqhXCsh6J05OWGoT4/cpf/SdCCTf7H2N6wh
 +nHNyvTA59nl3DiKm1d6Yl1rHL/14x97O7HW5VfzIrvaWKHFav8ySU+9m2ZAcmN9dtuo
 6Ad7Ayd3bJWrVpnCF5bZNFrRaK4Fbva1OuyWbWwCFQMClJfRt4k9gJoywVSch6MsY2kx
 qj/g==
X-Gm-Message-State: AOJu0YygWZskfsEv8xO+BARCfT3DpkRqkbNEKHV7ZtljhzSEROUpjWYC
 53KYLyySdOUvf7Nq0F1fwrMq9Bt4sAeztQA7+DE=
X-Google-Smtp-Source: AGHT+IEPjHFjKhagvCE9Uu/227fkQhVgsYpRggL0lf6S61jPaefnEHIq6DDR1Skv0GjDGL9DeR7+6w==
X-Received: by 2002:a17:903:1108:b0:1bc:1b01:8961 with SMTP id
 n8-20020a170903110800b001bc1b018961mr13766450plh.1.1692767783217; 
 Tue, 22 Aug 2023 22:16:23 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:4e3c:f4a4:b92a:b5ab])
 by smtp.gmail.com with ESMTPSA id
 5-20020a170902c24500b001bf044dc1a6sm9969402plg.39.2023.08.22.22.16.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 22:16:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v4 05/10] linux-user: Only register handlers for
 core_dump_signal by default
Date: Tue, 22 Aug 2023 22:16:10 -0700
Message-Id: <20230823051615.1297706-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823051615.1297706-1-richard.henderson@linaro.org>
References: <20230823051615.1297706-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
index 529fea8bba..73f40699ad 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -489,26 +489,6 @@ void target_to_host_siginfo(siginfo_t *info, const target_siginfo_t *tinfo)
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
@@ -608,8 +588,9 @@ void signal_init(void)
            SIGSEGV and SIGBUS, to detect exceptions.  We can not just
            trap all signals because it affects syscall interrupt
            behavior.  But do trap all default-fatal signals.  */
-        if (fatal_signal (i))
+        if (core_dump_signal(i)) {
             sigaction(host_sig, &act, NULL);
+        }
     }
 }
 
@@ -999,7 +980,6 @@ int do_sigaction(int sig, const struct target_sigaction *act,
                  struct target_sigaction *oact, abi_ulong ka_restorer)
 {
     struct target_sigaction *k;
-    struct sigaction act1;
     int host_sig;
     int ret = 0;
 
@@ -1059,22 +1039,27 @@ int do_sigaction(int sig, const struct target_sigaction *act,
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


