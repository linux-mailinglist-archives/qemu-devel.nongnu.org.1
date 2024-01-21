Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF8C833731
	for <lists+qemu-devel@lfdr.de>; Sun, 21 Jan 2024 01:22:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRLaG-0002WZ-M7; Sat, 20 Jan 2024 19:21:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rRLaE-0002W3-23
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 19:21:06 -0500
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rRLaB-0007P5-F1
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 19:21:04 -0500
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-36201722a7cso2146745ab.2
 for <qemu-devel@nongnu.org>; Sat, 20 Jan 2024 16:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705796462; x=1706401262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CJwQ5ZzhzO00+g0UGwDiX0qf7mCAm8ExrbTS/sZFCpk=;
 b=EyhLAyNPKBwEvxm+EbslBqz2LEavZEf8npnFeBgBmiSZMDo/KxRSJ5wH+QbF3WCaoW
 +64tw6cz6We529M0BB6eh8dCona0SFRAzClv217WkFF3LOKILtCf+X7wiCdKxJVqjIw0
 NUFVEqljjPAxzb0yOAcTt96Dzjbr6OL8BRg/+3DMq7S5T5ZNC19HJVS8ptiZc6KMxjWK
 4oE6hGWLlI5EsDJ9iYtk0tKj9l2DK1o0i7B1drrIf3vfve86/FWSqu0aqTB1j+JKMj1H
 B0tUQpfmHNVd8whrsaE3HyUkbKziYkczEOiioQ3q2WCcltpGGn6IV1QwEDVUxTQsz/ak
 wXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705796462; x=1706401262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CJwQ5ZzhzO00+g0UGwDiX0qf7mCAm8ExrbTS/sZFCpk=;
 b=th6LYheDEQgWRjdQPS9jbQ4CPqd990axatt+k4N77BiPsdvLwIt+8rf6aLjXZ2yKQu
 GquaYYevQMCIE/cdlm5mBfNs6I0KiGOGYaL4XAH35dr27M/4QVIbWUdZlbYQ/8CMaf7o
 wpwSrwZ4dgkn/7xOlLfLNM099dE61mt4wMverMR1x4O0WL52he9OTAZlQU5XMLF//tHF
 eWA0C0uTSRjy/x7ydrYplg/wIJRre6utHTs0giHNVdgOOgPgYoGdVzYCF6JlnYO9uH47
 N8NfSE+4B3QeyUUT36df/l7hfwEsuUeLdJef1AfjFxpvPXeLV7fSOYizfsj6EAD0680v
 Vqkw==
X-Gm-Message-State: AOJu0YxxjBeopel6rGDDURcRSdxXK//UZKdgi5jS77LPPWgyq7U5oKUv
 8AT5L7UTItokZIwO2CKI5VvexHz7Z4xQrJlQjbVLhv35M0yh/4yaYWWlYfdzcGpTr0ZKKaVtxE6
 mfFM=
X-Google-Smtp-Source: AGHT+IEEMcnSBg73OcDCeUR0w3ZirKD8muFeo8AtczFP2EgyWWDVuF4q9pkrcYzwuI4dNqEIJ1NWig==
X-Received: by 2002:a92:c6c3:0:b0:361:9665:da9d with SMTP id
 v3-20020a92c6c3000000b003619665da9dmr3520252ilm.9.1705796462205; 
 Sat, 20 Jan 2024 16:21:02 -0800 (PST)
Received: from stoup.net ([2001:8004:5170:1e39:1361:3840:4873:7990])
 by smtp.gmail.com with ESMTPSA id
 j4-20020a17090276c400b001d5af7fbda0sm5023546plt.122.2024.01.20.16.20.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jan 2024 16:21:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Robbin Ehn <rehn@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PULL 3/8] linux-user: Fixed cpu restore with pc 0 on SIGBUS
Date: Sun, 21 Jan 2024 11:20:42 +1100
Message-Id: <20240121002047.89234-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240121002047.89234-1-richard.henderson@linaro.org>
References: <20240121002047.89234-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::133;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Robbin Ehn <rehn@rivosinc.com>

Commit f4e1168198 (linux-user: Split out host_sig{segv,bus}_handler)
introduced a bug, when returning from host_sigbus_handler the PC is
never set. Thus cpu_loop_exit_restore is called with a zero PC and
we immediate get a SIGSEGV.

Signed-off-by: Robbin Ehn <rehn@rivosinc.com>
Fixes: f4e1168198 ("linux-user: Split out host_sig{segv,bus}_handler")
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Message-Id: <33f27425878fb529b9e39ef22c303f6e0d90525f.camel@rivosinc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/signal.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index b35d1e512f..c9527adfa3 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -925,7 +925,7 @@ static void host_sigsegv_handler(CPUState *cpu, siginfo_t *info,
     cpu_loop_exit_sigsegv(cpu, guest_addr, access_type, maperr, pc);
 }
 
-static void host_sigbus_handler(CPUState *cpu, siginfo_t *info,
+static uintptr_t host_sigbus_handler(CPUState *cpu, siginfo_t *info,
                                 host_sigcontext *uc)
 {
     uintptr_t pc = host_signal_pc(uc);
@@ -947,6 +947,7 @@ static void host_sigbus_handler(CPUState *cpu, siginfo_t *info,
         sigprocmask(SIG_SETMASK, host_signal_mask(uc), NULL);
         cpu_loop_exit_sigbus(cpu, guest_addr, access_type, pc);
     }
+    return pc;
 }
 
 static void host_signal_handler(int host_sig, siginfo_t *info, void *puc)
@@ -974,7 +975,7 @@ static void host_signal_handler(int host_sig, siginfo_t *info, void *puc)
             host_sigsegv_handler(cpu, info, uc);
             return;
         case SIGBUS:
-            host_sigbus_handler(cpu, info, uc);
+            pc = host_sigbus_handler(cpu, info, uc);
             sync_sig = true;
             break;
         case SIGILL:
-- 
2.34.1


