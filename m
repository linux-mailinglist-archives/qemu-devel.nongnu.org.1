Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5407DEA4B
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:42:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMcY-00087S-48; Wed, 01 Nov 2023 21:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMbK-0006fI-0C
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:26 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMbG-0002AN-EZ
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:24 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6b3c2607d9bso475030b3a.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888861; x=1699493661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hES6yVQ0/11qdrvyqhHvx3Mqj7cvamUGm715KS/hVjU=;
 b=NGqTch6wuRH+AzUY4mbTETsgw9Y9cQKvDXBiPLIrwRJajsk9sAxcVs2Klr/7HYGTjk
 fgP3bCE3qohElocxBIhihlbLm0gRL/lwW1tlCCkwRxwZmKe9alyRh5CEEaucPp7ZnzTx
 blQQOf0qwfAzVht5qtgMVTeYwE+vwTVzOFsiGt8nbKZ3y0/w+DvRcxl5zbz0/WU96PqM
 Ph6lbTSodlGKRv4x3YfNVY7aHSndAce1rIJdSxzoAzdF8ktNtblWUqWiAHS82pxJA3Nw
 l8a38j0jj8r5D1wpf0BvkgRwTWtHYPCuu0RTHGzDFD704evFyBPdr226AAJY19g7YfO+
 OzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888861; x=1699493661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hES6yVQ0/11qdrvyqhHvx3Mqj7cvamUGm715KS/hVjU=;
 b=oKQ+U8EgoFu/Wt15RpGByyV+tuqwG58rElPPDN/CDd7VriaVJCLid4nf/OhnK3OzUr
 PFkJOL7yq9T9bsOMStihyV0z23MHMjfRLBOXPYkbDQRcTt0o8k1kSZ23DtTuaPJ9uRU+
 BK4TJVraD5hxZRwXV3kSdUUjAUZxPuc9BNtOYoD/Vdyz5nIg6K8DUIpEB7U8v2CY8DJB
 Pxwzsj/ifCLFoPjIP5UQRSDnwB6BLIK5yjrljlBSaAYu/2UpYvKG5XneMeBCssYadQyK
 Vw4iyJlz/6dUnr9duj0hyrB4jtMcSHuIke+o9HZ044rP77FCiIfXA/4XDX6PWIlU9LT8
 lwPw==
X-Gm-Message-State: AOJu0Yxefz1ofQUlkfdjD4W2BninTK6xUd7kcJP84xA8uUFeEWcwhX7Q
 TjwiJC94zN1lSWTb83hBWTAR8Yj4HQ8a8lH0bH8=
X-Google-Smtp-Source: AGHT+IHldjmRfG48fv3Jkj6OSfeQCXZsNkCifkWvrmq37yyanoDHaWZVzp8iTc0MVwSkXlMItj/pOQ==
X-Received: by 2002:a05:6a20:258d:b0:152:be08:b013 with SMTP id
 k13-20020a056a20258d00b00152be08b013mr16926335pzd.42.1698888861157; 
 Wed, 01 Nov 2023 18:34:21 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 t2-20020a1709027fc200b001a98f844e60sm1918125plb.263.2023.11.01.18.34.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:34:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 75/88] linux-user/hppa: Drop EXCP_DUMP from handled
 exceptions
Date: Wed,  1 Nov 2023 18:30:03 -0700
Message-Id: <20231102013016.369010-76-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/hppa/cpu_loop.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/linux-user/hppa/cpu_loop.c b/linux-user/hppa/cpu_loop.c
index 8ab1335106..d5232f37fe 100644
--- a/linux-user/hppa/cpu_loop.c
+++ b/linux-user/hppa/cpu_loop.c
@@ -147,12 +147,10 @@ void cpu_loop(CPUHPPAState *env)
             force_sig_fault(TARGET_SIGSEGV, TARGET_SEGV_MAPERR, env->iaoq_f);
             break;
         case EXCP_ILL:
-            EXCP_DUMP(env, "qemu: EXCP_ILL exception %#x\n", trapnr);
             force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPC, env->iaoq_f);
             break;
         case EXCP_PRIV_OPR:
             /* check for glibc ABORT_INSTRUCTION "iitlbp %r0,(%sr0, %r0)" */
-            EXCP_DUMP(env, "qemu: EXCP_PRIV_OPR exception %#x\n", trapnr);
             if (env->cr[CR_IIR] == 0x04000000) {
 		    force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPC, env->iaoq_f);
             } else {
@@ -160,7 +158,6 @@ void cpu_loop(CPUHPPAState *env)
             }
             break;
         case EXCP_PRIV_REG:
-            EXCP_DUMP(env, "qemu: EXCP_PRIV_REG exception %#x\n", trapnr);
             force_sig_fault(TARGET_SIGILL, TARGET_ILL_PRVREG, env->iaoq_f);
             break;
         case EXCP_OVERFLOW:
@@ -173,7 +170,6 @@ void cpu_loop(CPUHPPAState *env)
             force_sig_fault(TARGET_SIGFPE, 0, env->iaoq_f);
             break;
         case EXCP_BREAK:
-            EXCP_DUMP(env, "qemu: EXCP_BREAK exception %#x\n", trapnr);
             force_sig_fault(TARGET_SIGTRAP, TARGET_TRAP_BRKPT, env->iaoq_f & ~3);
             break;
         case EXCP_DEBUG:
-- 
2.34.1


