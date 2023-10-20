Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9E47D1784
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:51:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwPA-00028E-2C; Fri, 20 Oct 2023 16:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwP5-00024j-Sf
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:47:31 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwP4-0001El-Dc
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:47:31 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6b1ef786b7fso1160542b3a.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834849; x=1698439649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hES6yVQ0/11qdrvyqhHvx3Mqj7cvamUGm715KS/hVjU=;
 b=BFp2Elu+kkiM6mPMqNX9M9WL6O6bv+RQ5ws2DX/Ecb8b5GAWO7wAthwra7U9AJdGUh
 E6lhL1bgk+BtlNTPnDelQYaM+MwTEf8CV/sJWSwIQCBJD7AUKwKXdwCdRQ4JZszPgng+
 laMpcZYkSPfmXdFuNDdw+xH/qzvy1RD1O0lsfwYwKzxyKeY0Tz4Bo4RQDoJYBwRYI4fj
 tFlvWcUwyHP/E9luL3cRWALgtvELS6k63D9jKARpYRr+aQVOOa8H4jedZz29tI2vw+zi
 WjaKM4n5sdRMCBxgN2MZd3NzaIyqxcCF5pP2Z+A90rhwigzI0mTJ9lmpQgjXl/jT1/+t
 DLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834849; x=1698439649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hES6yVQ0/11qdrvyqhHvx3Mqj7cvamUGm715KS/hVjU=;
 b=FziQzKzMYXv1P4xlGkYsFuRIWeGgi03xiTo8JfCN3AOo27wYSxoGQTXITwC2TUjoSo
 3xqrC7xN49ce/qQz75xEuiyLaRnfAwrifCTUTsFddHDasvVnG3TVQ07TSE2E8l4McwoJ
 zFhftCElGT7cgX6Vs800wcz6HbiNa9worTPuZtVeYlEc/bzpIZ8A3MiBky7RClI/iwmU
 fO7Tw7xgyEYsSy92ABVLqvYhh1bw1l/Y68iWwxOdM//vh4S4X/IabsI2g1NxX/9ppBzN
 sxvOV7h+qSIHGCDYtNtE4+WKCCh8s2SIL9UlG8k5qmQ0vjb+kq5pzR14Crnva+/7HxUw
 AIeg==
X-Gm-Message-State: AOJu0YzyrX5bXy//zy3ZRMVym6ytlQaAb5P+LYszP9MCdp89IjObFjKa
 3sklCorNnnsZuXeZIIwluAMlhNDKeXVk0wDdS8E=
X-Google-Smtp-Source: AGHT+IHZII/TdrlWstNnNThIxBcsFajqtwiWiB3GsEpmVUirGD5S7pnNQmSZ0kQmRPjTMrkyMB9DFQ==
X-Received: by 2002:a05:6a00:24c5:b0:6bf:4cb1:e78 with SMTP id
 d5-20020a056a0024c500b006bf4cb10e78mr593535pfv.6.1697834849289; 
 Fri, 20 Oct 2023 13:47:29 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u7-20020aa78487000000b00694fee1011asm1946775pfn.208.2023.10.20.13.47.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:47:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 65/65] linux-user/hppa: Drop EXCP_DUMP from handled
 exceptions
Date: Fri, 20 Oct 2023 13:43:31 -0700
Message-Id: <20231020204331.139847-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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


