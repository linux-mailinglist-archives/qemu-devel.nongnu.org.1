Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 604117E33A1
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:11:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CRz-0005yx-9K; Mon, 06 Nov 2023 22:08:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRl-0005Iu-Kh
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:08:10 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRh-0001RT-B5
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:08:09 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2800bdf888dso3995980a91.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326483; x=1699931283; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hES6yVQ0/11qdrvyqhHvx3Mqj7cvamUGm715KS/hVjU=;
 b=OTAhW5/cT0iuMyHeQfrZ4HrXxy5lf7HT3Tqcc2BQCphciUAfwYPGgFlL/2AINPEIgo
 twQysGtmyN2z0vUdbERD7pftawGr5E16yyBJiUeGZuK14kCI1ThD2uzsxVc/ljurJA/E
 YJP4TDYDM1p0PlpFCgN//x38dsV5oKAsgOYENoBxzw0aPBK9YAqMtU3ENgoZOxjyTpWI
 YBtc2WuIDZ9xgp2jTKGyQzISspJYQbyI32f74VXTtMTYUSQNqICpUdaO3guihUTCR7PN
 Hlu6Bgia0u4NdFP0tv1oJ3x6naXSeUsdNccQtRzSTMPwM14teMSuEUXQ2iN8IFEczUjq
 lLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326483; x=1699931283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hES6yVQ0/11qdrvyqhHvx3Mqj7cvamUGm715KS/hVjU=;
 b=mYvNivtmez6jR7ajhegRlKfUpBxn5kvsyabPL9GTumOfsDZMKBbLk2i8FDHx2OHHAw
 9L71HR6vXIBT5dmYpcGUplpxTPcfrddGQdxn1au4LY4cibVvc5V/9hSPvtUW6iTb96ne
 vBTWOXh5fkuDZQj8AAn+HKQDjPvRFmQakXlEmk8OfplQvazhhzxUG08KZOPNOR+irWsj
 bMZ6lIbiU3bCA0YLjGEtKyPvfM7kkb5k0yV3SrknX7obf67lva6Aav85htSKf9txRaiA
 oabUFLdsOHHtV1lgNdHVj9JIUTxaK9AcGuXtWHIPfXIcpj3SCn4h7uigwqN8rK7Kex5H
 oDcg==
X-Gm-Message-State: AOJu0YwEPNW4g/4u3gZgvR8Q7UYtARaWo39wVMAaEwnbvtLa+WmCW/Wi
 WBGgP5damSuSiNTnn+VdDWsnLdKVD423aCy/DYw=
X-Google-Smtp-Source: AGHT+IEuBwrCfiGrRpo+8Pw9SKwUxCEYPxV1M9uxN5/m/JSNjnZLCvMHz5pBaHFKYxs6ylxNQGaRKw==
X-Received: by 2002:a17:90b:1e49:b0:27c:ecec:8854 with SMTP id
 pi9-20020a17090b1e4900b0027cecec8854mr1783970pjb.7.1699326482854; 
 Mon, 06 Nov 2023 19:08:02 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a17090a004d00b0027782f611d1sm6744883pjb.36.2023.11.06.19.08.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:08:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 73/85] linux-user/hppa: Drop EXCP_DUMP from handled exceptions
Date: Mon,  6 Nov 2023 19:03:55 -0800
Message-Id: <20231107030407.8979-74-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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


