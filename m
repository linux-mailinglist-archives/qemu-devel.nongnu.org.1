Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CEF7B71AE
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 21:22:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnkxV-00054Y-1H; Tue, 03 Oct 2023 15:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkws-0004th-2a
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 15:20:53 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkwT-0004eG-UK
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 15:20:49 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c7373cff01so1235335ad.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 12:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696360821; x=1696965621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MD3OzDuuDGgXDQMB1J8iXNmpATULZDtwIUTwe03wb+E=;
 b=ABfllLMSoaA4iPE8tJXyJl5SB2E/2UKGesTeXJrLzkg39n0xKwqVg8Pq/9ZtiQWijk
 64uldqz/Sol8WbmmIxj2mHx9tQe6FqTVZM1tDNkd4NtHkh+xCeq5KWk6cHwajL3l7kzW
 qumOz/8PzWY3+H53lbzMooP7xfKuMLIwl61KnnnNCNx+kCeFLi8IQ7dErKl0i/taw0/d
 ttH26pFF+wF25bktr2JzVgCEwqROtUHGgH//scM8bQfEu9F3uSrYAjUp6ZAuarj4JuMV
 rEqN2fK5mzir36TtE+qbAI2+MKAn5pyzFry4I0pxIB2xHYKjrD6nP1/+COjpy1cfO05Z
 v6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696360821; x=1696965621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MD3OzDuuDGgXDQMB1J8iXNmpATULZDtwIUTwe03wb+E=;
 b=Ij+auvVWAsjEX/LV6hLIUCcvMu/ObQ3UflWgT09NC0e6UoYLT8lmKdQbyL15rjTi1o
 6/tH5oRj8+LvHip2uv5F3D7sNcFZ5huhw6EdM9hcdx3eLssIrasieShseeYwDtiGPggT
 +4sAYP0UOhXnMaqRWdrvesKQlt1hzzYam4XH/PQgGKoWywl8EmTgSaSSg5QarKhNtPKf
 6UKiGcDen3kJwvyWcrG7+7tYM0prsDqY3DMCc2php82eZZhIY1wFmSkvJ0ybPfjc3aG7
 xMIbhJqgIRdqorXbRSRmbgcsXJkesu1DtXor0wvl4SwH/6UsfqGxXoERsDN3JGVamxCT
 6N4Q==
X-Gm-Message-State: AOJu0YyIzcr05K9KnD2OF2wWJew1PHGGipz4Wcw8l5/+FVZg+NtTDwD+
 AS2YceePLxCAfeebiEKuG8u5hHTfRV0wBkZ4ZXs=
X-Google-Smtp-Source: AGHT+IFVaYDnWXK7NrIenxlou8rgkrTl0uM5OckObaqpHoyqmlBAQ3hoG0H6sUgDU7k+rht6vldtUQ==
X-Received: by 2002:a17:902:db0a:b0:1c3:432f:9f69 with SMTP id
 m10-20020a170902db0a00b001c3432f9f69mr247445plx.23.1696360821237; 
 Tue, 03 Oct 2023 12:20:21 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w5-20020a170902d3c500b001c5fd2a28d3sm1978497plb.28.2023.10.03.12.20.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 12:20:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	deller@gmx.de
Subject: [PATCH v5 8/9] linux-user: Detect and report host SIGILL, SIGFPE,
 SIGTRAP
Date: Tue,  3 Oct 2023 12:20:11 -0700
Message-Id: <20231003192012.1674888-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003192012.1674888-1-richard.henderson@linaro.org>
References: <20231003192012.1674888-1-richard.henderson@linaro.org>
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


