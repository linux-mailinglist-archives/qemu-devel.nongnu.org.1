Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2527E7E1644
	for <lists+qemu-devel@lfdr.de>; Sun,  5 Nov 2023 21:13:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzjTx-00039q-FK; Sun, 05 Nov 2023 15:12:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qzjTv-00039a-Ql
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 15:12:27 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qzjTu-00027d-BU
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 15:12:27 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6b2018a11efso3987151b3a.0
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 12:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699215145; x=1699819945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qG+TirgfLO1yyR3v2seUl0zyqvQ6ZRohRxES3/K7nSo=;
 b=QmVv0FBq1qF2xTX+mHuACZURGPmJ0MOT9c7xIL54/kGoeYWS7aipdolChz+Wr8PrYX
 zMqDNH5+UsALub5cA1nYCDIV1J3bG1Cj2FYPCPr1fhw6VxmVYlb80Lpi8J/TVU9pGcFo
 sELufHuLNbU9Kg13MUs+m8Ucu+/S/2lX0rINVnhop+RPT52zkO9fgsWTPWcUgZ47Etvo
 SolvZCF1M2DhJvFp4A2/a564mEQ8OQRVDRq7ElKGsKMVGsWc3P/1GMNC1/zGGXoJu6AL
 UfpL8dl4Q1/lEzESQIbyJZ/O8gp3aSbEDB8U0DSdB6VCVtsXdHi6HmZwGzPTjz1beZz7
 +FGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699215145; x=1699819945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qG+TirgfLO1yyR3v2seUl0zyqvQ6ZRohRxES3/K7nSo=;
 b=iA3WPR1CVsIm6FvWdJGtt2PXe2lZx7KRZaa9Qm6Ldgix8WnoWxe1K2z3oDqNARO/eW
 QUnDrlGkdvx2Jst/P22/zSe3ojIsAKroa+RJZ9L2AMoqe4feCZoVafJn/DOMMGQXd4RG
 5T1BgS3eqAihuqFPJpsxuzk61g0oLGBxyaaLV7VFEXClGwyyNdC+te/QR0uxDgO86HoI
 0hxglhGRRlC9PSeMHToYI8GutMzIPOrNluUrhp9kFs+f/8GbW0rjNFW5V80xQWmKKGIr
 Cd/o/8aSRKjwfzLRoCZ5Pc6UVlywnzeaZm7todw7cWl7ieBJUFZuSdiXgjEGl4mO85CN
 /kYQ==
X-Gm-Message-State: AOJu0Yxfeq08uNw5kuzgJeln6v4kzrGoh/vwcxDg7VeIN0IczKh7Wf03
 tNh3fVqfi9BijjGM4osOwBzegG8gOkqbptk2+ww=
X-Google-Smtp-Source: AGHT+IE+QV13dDnnZv0fozZBr3mFGe94x/jSn3hFrAreeYl0+TFJdNsLtQBs7UB3H2wWUsy4VXz0dQ==
X-Received: by 2002:a05:6a21:7785:b0:180:db7b:23f2 with SMTP id
 bd5-20020a056a21778500b00180db7b23f2mr25375142pzc.61.1699215144694; 
 Sun, 05 Nov 2023 12:12:24 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u23-20020a056a00099700b006884549adc8sm4359777pfg.29.2023.11.05.12.12.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 12:12:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 01/21] target/sparc: Introduce cpu_put_psr_icc
Date: Sun,  5 Nov 2023 12:12:02 -0800
Message-Id: <20231105201222.202395-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231105201222.202395-1-richard.henderson@linaro.org>
References: <20231105201222.202395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Isolate linux-user from changes to icc representation.

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.h        | 1 +
 linux-user/sparc/signal.c | 2 +-
 target/sparc/win_helper.c | 7 ++++++-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 758a4e8aaa..955329f6c9 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -619,6 +619,7 @@ void sparc_restore_state_to_opc(CPUState *cs,
 /* win_helper.c */
 target_ulong cpu_get_psr(CPUSPARCState *env1);
 void cpu_put_psr(CPUSPARCState *env1, target_ulong val);
+void cpu_put_psr_icc(CPUSPARCState *env1, target_ulong val);
 void cpu_put_psr_raw(CPUSPARCState *env1, target_ulong val);
 #ifdef TARGET_SPARC64
 void cpu_change_pstate(CPUSPARCState *env1, uint32_t new_pstate);
diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
index 2be9000b9e..dfcae707e0 100644
--- a/linux-user/sparc/signal.c
+++ b/linux-user/sparc/signal.c
@@ -164,7 +164,7 @@ static void restore_pt_regs(struct target_pt_regs *regs, CPUSPARCState *env)
      */
     uint32_t psr;
     __get_user(psr, &regs->psr);
-    env->psr = (psr & PSR_ICC) | (env->psr & ~PSR_ICC);
+    cpu_put_psr_icc(env, psr);
 #endif
 
     /* Note that pc and npc are handled in the caller. */
diff --git a/target/sparc/win_helper.c b/target/sparc/win_helper.c
index 3a7c0ff943..bf2c90c780 100644
--- a/target/sparc/win_helper.c
+++ b/target/sparc/win_helper.c
@@ -67,9 +67,14 @@ target_ulong cpu_get_psr(CPUSPARCState *env)
 #endif
 }
 
-void cpu_put_psr_raw(CPUSPARCState *env, target_ulong val)
+void cpu_put_psr_icc(CPUSPARCState *env, target_ulong val)
 {
     env->psr = val & PSR_ICC;
+}
+
+void cpu_put_psr_raw(CPUSPARCState *env, target_ulong val)
+{
+    cpu_put_psr_icc(env, val);
 #if !defined(TARGET_SPARC64)
     env->psref = (val & PSR_EF) ? 1 : 0;
     env->psrpil = (val & PSR_PIL) >> 8;
-- 
2.34.1


