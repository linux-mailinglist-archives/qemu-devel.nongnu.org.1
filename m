Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C80E77DDBD4
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 05:14:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy2Zx-0005tN-CO; Wed, 01 Nov 2023 00:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qy2Zu-0005t0-5r
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 00:11:38 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qy2Zs-0007TO-JO
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 00:11:37 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3b3f55e1bbbso4114741b6e.2
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 21:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698811895; x=1699416695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HeMyfJcx+peR5itTdqsCZ9Xkp/oHQ/IkwnAHAyhPKRo=;
 b=BlXg91Uh3rh7fvXwbMK3yV7dI2o5OpR0/jPXKer10ur8v7QOKF25t5LLTt/+wCHT+0
 hqXlkKwhSSwIBCdEIOBNUZcfSWaP+QVBuNqxl7d+UaijCE7RoA1muZmtHMm6j/vsyv+S
 jW8+Zy5X++xedenIPMmhcRebLsbqOhI+7IbUmde4Qk//ilKdatTqbSDgBKnB5fmj8sMz
 AgzYJv6gpal963xdEVvp0HJYAgghS1XsPWTILH9T4c1mJblQPVNTBw2jKcAc0/CHQUKu
 iC1/Bav5QNeitL0mSCvIRD3S1PY9LgtKCHxvnB+F5PVMLyDoxAEP3+yUWARTOLr/1OQl
 Azog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698811895; x=1699416695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HeMyfJcx+peR5itTdqsCZ9Xkp/oHQ/IkwnAHAyhPKRo=;
 b=H7HDatdVDZplzvQO2jlylzhbSbcfSdmlnwYHIu1d4t5XB0gs5EBfVT7jkiGdWdmQ55
 hbhRNfedSE9r46jvTsQ2QKTap7WFwrpfcApyGvN0ZOMKGm7/m9CSP3wnkGiMmZLZ4fhm
 vRX76sDORp9ApCmMLFvOJFew0K18mb90vJEHGxKz45IgKUJR5EB3n6ms5gGSEx+wFmQi
 B9/x4Hu467oJ9tuPgKqhgGjXcxp3SccWYHqxXoBnhqsq5pbZlDuTz6hH/s3rx+N2zxqS
 5ml+lRhmM4+ZkxSoUYH1DragJApLXpfO869qxiinDavvG6boTB7DvIpS5DeU/AiBIOXc
 1f0Q==
X-Gm-Message-State: AOJu0YyIjEH6lhiL1Rs635pArEGmJgUNLrw0w2/UxdXEvZCl/cAKLghQ
 D+/6wQ3vdOCB8jjv2pypxoD48MJEnQhXJrAlKHU=
X-Google-Smtp-Source: AGHT+IGrKsZHLXhNs2OoHo2gtJrkBG16riTtJXpPlZINkT2H2nLh6CmOb24pESHNVsBZGdETwvVj4A==
X-Received: by 2002:aca:f1a:0:b0:3b5:6bf3:c4cc with SMTP id
 26-20020aca0f1a000000b003b56bf3c4ccmr2459253oip.29.1698811895132; 
 Tue, 31 Oct 2023 21:11:35 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k8-20020aa79728000000b006875df4773fsm359576pfg.163.2023.10.31.21.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 21:11:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 01/21] target/sparc: Introduce cpu_put_psr_icc
Date: Tue, 31 Oct 2023 21:11:12 -0700
Message-Id: <20231101041132.174501-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101041132.174501-1-richard.henderson@linaro.org>
References: <20231101041132.174501-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
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


