Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 698C27CEC16
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 01:32:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtG1F-0004Co-AN; Wed, 18 Oct 2023 19:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtG0y-00046X-Ua
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 19:31:48 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtG0x-0000MQ-Ai
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 19:31:48 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5832ea25c7eso345589eaf.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 16:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697671906; x=1698276706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cPRrHvcXgvktiUIzW9SQzWI6+9vUxSTnLoJeJQFy4uw=;
 b=Q4ftAnus3bAgnokg7B1JoaQSGGyy4MUj3ftVpw+YvnQ1Xh3v174V4bNxFYwyfLh4i5
 N8xrR4CFTxjaC63y8PEuPxUOKl/bUygLWpjJSW4yNwaH234+yaNUvSOWiIatELQ4SKu3
 HLUfrNuVamfY6eqZ3WglmQ+3SNYYSCRFE1WRxeLdTkQpuP4p17a7uxENbCNNwmrEdc4S
 0EobzHA8O7EhGKCDZxd78y5RyxYy4LODTlQYnitThE39WrBENT8D/8Z9BJ/zE20YTACn
 ptINnIIFVgpd/qx5nbtDBr5hmWrUGfJ6DGimne7hVGNxgxZRYMDmFc9/7eu+yyW93doF
 sTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697671906; x=1698276706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cPRrHvcXgvktiUIzW9SQzWI6+9vUxSTnLoJeJQFy4uw=;
 b=FGuRr+C3ioQe3XREZBLPnBvYtHobGNWuf1NSPgObyWDMR50XlnVMATIWNK6y8i5kse
 KwMO5EW1wVad3wdBdcXU1UUs3EQxIXwQMkTlX/QvgxX2ON0DyaV7tsBvt93ULoKHROlM
 NCsktZUotqwrUZV5noWbVVSRI/noQNDkm6AjWdM16AE9qNhY1hVNY5JRSkld35iDiAhc
 Jf4MzyhDioAE50TmJOC1bCJX1d4pRzL2dwgIIq1WTskxdniuTFOTgfwJcAHNdHG6Apdv
 7Ub3ZPVlNoi13owzGJzDF11xw9+405Gp/1/JUmw6/EYxxkXywFP1ISXuP+X62Y47mNYP
 1W+w==
X-Gm-Message-State: AOJu0YwrGN1yO0UihF2DWoNdIQC8tniQJIQ1rwGZ6/AucE38eK9rZvtW
 SPLGGs7hYOo0BDiqg1vp5fahc+KVA3IAi1+HgkM=
X-Google-Smtp-Source: AGHT+IGYNBMmBtJusrVDe2Dmtnn+/ugkCpQpRaZREWiChk3JgoNXhtioxbHn+/SjQnohNEzPmnpJbQ==
X-Received: by 2002:a05:6359:3110:b0:134:d806:69df with SMTP id
 rh16-20020a056359311000b00134d80669dfmr364662rwb.18.1697671906034; 
 Wed, 18 Oct 2023 16:31:46 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 g9-20020aa796a9000000b006be5af77f06sm3881690pfk.2.2023.10.18.16.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 16:31:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 13/14] linux-user: Detect and report host SIGILL, SIGFPE,
 SIGTRAP
Date: Wed, 18 Oct 2023 16:31:33 -0700
Message-Id: <20231018233134.1594292-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018233134.1594292-1-richard.henderson@linaro.org>
References: <20231018233134.1594292-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2f.google.com
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

These signals, when not spoofed via kill(), are always bugs.
Use die_from_signal to report this sensibly.

Acked-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/signal.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 706b8ac7a7..b67077f320 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -796,6 +796,43 @@ void die_from_signal(siginfo_t *info)
             break;
         }
         break;
+    case SIGILL:
+        sig = "ILL";
+        switch (info->si_code) {
+        case ILL_ILLOPC:
+            code = "ILLOPC";
+            break;
+        case ILL_ILLOPN:
+            code = "ILLOPN";
+            break;
+        case ILL_ILLADR:
+            code = "ILLADR";
+            break;
+        case ILL_PRVOPC:
+            code = "PRVOPC";
+            break;
+        case ILL_PRVREG:
+            code = "PRVREG";
+            break;
+        case ILL_COPROC:
+            code = "COPROC";
+            break;
+        }
+        break;
+    case SIGFPE:
+        sig = "FPE";
+        switch (info->si_code) {
+        case FPE_INTDIV:
+            code = "INTDIV";
+            break;
+        case FPE_INTOVF:
+            code = "INTOVF";
+            break;
+        }
+        break;
+    case SIGTRAP:
+        sig = "TRAP";
+        break;
     default:
         snprintf(sigbuf, sizeof(sigbuf), "%d", info->si_signo);
         sig = sigbuf;
@@ -900,7 +937,8 @@ static void host_signal_handler(int host_sig, siginfo_t *info, void *puc)
 
     /*
      * Non-spoofed SIGSEGV and SIGBUS are synchronous, and need special
-     * handling wrt signal blocking and unwinding.
+     * handling wrt signal blocking and unwinding.  Non-spoofed SIGILL,
+     * SIGFPE, SIGTRAP are always host bugs.
      */
     if (info->si_code > 0) {
         switch (host_sig) {
@@ -912,6 +950,10 @@ static void host_signal_handler(int host_sig, siginfo_t *info, void *puc)
             host_sigbus_handler(cpu, info, uc);
             sync_sig = true;
             break;
+        case SIGILL:
+        case SIGFPE:
+        case SIGTRAP:
+            die_from_signal(info);
         }
     }
 
-- 
2.34.1


