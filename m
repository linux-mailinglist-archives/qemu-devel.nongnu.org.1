Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F56C838BAB
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 11:25:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSDxI-0000OO-1r; Tue, 23 Jan 2024 05:24:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSDxF-0000Ni-Jn
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 05:24:29 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSDxD-0004ct-GP
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 05:24:29 -0500
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6ddf1e88e51so3178686a34.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 02:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706005466; x=1706610266; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CJwQ5ZzhzO00+g0UGwDiX0qf7mCAm8ExrbTS/sZFCpk=;
 b=wiw55JUkKxb5xsomSITLXgCKPi9KYKb6IFzsuwR0Tql8TdZSBa1BZxvpKdlcu1/2i/
 RdTNxlnPh0WrSlm9Ma0czuaKYneKt8fBPgXY8VGSzSjJ48tEEQamGXs76n3SfrVMa8k5
 LvhYRgQ+uITp0leEThapAYfLFBpfUoIPL+EAk4Az9Q3qFGLtiIeZ3Y0WbtsXCmNrngdv
 KGbcFv42/kRFKIVNQm92VdX60Lif522oVxoesYPH2fk8tuXs1JkGZYf1UYHCEqteAbBk
 sZzSttbqq5Eiiay11pQYnDWtrSlRPRZdkFYEvlV1Qu/ijZ2urwqUG3vgta//Hu3X4piJ
 VU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706005466; x=1706610266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CJwQ5ZzhzO00+g0UGwDiX0qf7mCAm8ExrbTS/sZFCpk=;
 b=ie2bAp2b233rw++bMA98DNTtHsu4+2iNyi1s85OpIuUN/u8JUx2YQNiV4Yy+QbFxnd
 nL56BmRdO1xntfHUyVrkJj/nKNAa4Ial4JIA+cLiS5mhZF+4Pck+M1i2g3yTzKxR3MUd
 DrmpoaUZ3HzaR8c5F3JzgIbdB9d56QmuBv0QG2Bjq6Btxds3NBo8iIMMjh8ZP2astRz7
 Du2eIqbcUdQGr/hKcsj/StNwGh61dOVLsrwOH7Ex5RBwyWexYHPXQ7dtwkcl9LRIaAmO
 XukNhyYbve/uIJoa7PtNPA7+zIATENMqI0yyjWBDpObuto9SBM9zEGGJjjEJJzB9nefB
 zQ0g==
X-Gm-Message-State: AOJu0Yyj+OkhLaGAQlDdXNKT90iz7A66Vhgls8ZPVBfsJMxWvBSTzJgo
 x3PUXo6Ybi37Jz4bdcqTKN6zzH+JjHwVqeUxvMPlDmER7UKFz9YI3z2uGEHeZVIBbI41BU0Cbia
 Pogo=
X-Google-Smtp-Source: AGHT+IE2t0Uph2iLe4YGmMFrsR5ALkQCrhaqZ2uHsX3OqZLHi3OnMYqK1tuDvpraxwJxx5A47/81JQ==
X-Received: by 2002:a05:6359:6241:b0:175:c293:68d0 with SMTP id
 sd1-20020a056359624100b00175c29368d0mr2665045rwb.60.1706005466146; 
 Tue, 23 Jan 2024 02:24:26 -0800 (PST)
Received: from stoup.lan
 (2001-44b8-2176-c800-b8a0-0408-58be-7d2e.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:b8a0:408:58be:7d2e])
 by smtp.gmail.com with ESMTPSA id
 d8-20020a62f808000000b006d9ce7d3258sm11072408pfh.204.2024.01.23.02.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 02:24:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Robbin Ehn <rehn@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PULL v2 3/8] linux-user: Fixed cpu restore with pc 0 on SIGBUS
Date: Tue, 23 Jan 2024 20:24:07 +1000
Message-Id: <20240123102412.4569-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123102412.4569-1-richard.henderson@linaro.org>
References: <20240123102412.4569-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
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


