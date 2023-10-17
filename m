Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCFE7CBB7D
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:43:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdlW-0007qu-3M; Tue, 17 Oct 2023 02:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdlT-0007q3-24
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:41:15 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdlR-0001pi-8b
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:41:14 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6b87c1edfd5so2331316b3a.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697524871; x=1698129671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HeMyfJcx+peR5itTdqsCZ9Xkp/oHQ/IkwnAHAyhPKRo=;
 b=Y9zUgqM8DPfJ0UdCyLoToyFn4fUjhbImQsQjgHV9kUgsCbeBoWgtBT4lKeQfMcc9sG
 cSj1g75mSeTR/ZzILARcR03YrsBo0UaPYVYcmCHf74+bLhE6NyHZV7Vu+ZJJl18weAxO
 ce6h9jYTlzradoib8UNl83hkWtD1pSNcP6JU1va+52fzggrp3AkSfi0HYBKNl7c/8F3p
 RgRYjH8qlqvThJMTI69OPHvjGY0ayDJpV+towNCBx6kGf3wCK0cc6Epea/DyvJUI8UDm
 TBEKbb8iqqGK8NnokFfrHvTNWX+UfY0CZtbSsVTOu6AD3rWafo0zmCai2tUXEZx36AK0
 koBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697524871; x=1698129671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HeMyfJcx+peR5itTdqsCZ9Xkp/oHQ/IkwnAHAyhPKRo=;
 b=D6fzwX2h3P71zoldNQYW8V54eF6/qZvfiEvF2FPcoLT6rCAnST6j9Uh3B981w2rJG9
 n7H4N8fdZDtS40tglFXtFrebplg5M345l2JEkhn4GaDyyPlBgtV1fV5ftTnMBY3+HxHx
 NfO/ZBSZ/fFFn+iRpU2HaRSJ5ct0tUUwv0Pxp+Yp/WANMJzHUAUUcBTkSoHytAKOpZwn
 bUStCm8yn7Iks1hc/JwDK7+ojCC6jnmLgvgs9zhllDaP74pDh/SR6E56h5hXbcSByCvi
 9XN39EmxtXZoF9JQS+1IJGTPQt6fZB9INoZc2rx34JdV321H90K8+vFUptJ7v7yX4i7X
 z85A==
X-Gm-Message-State: AOJu0YyqrOID4ekTUp2YytTzN9ojLOmRl9ZiYVsK7ZLfIvGRry6lBr/k
 uZSt7cHX7KNzZlJlJP7Bt5ygnko0FbcIZgM66Y4=
X-Google-Smtp-Source: AGHT+IFlqDvXu7awXngEfWr7mljl4nH0GNdTpUFXPfCXNp8W14BHJS99G3a5rZBZbS9T8nVmuOq6Fw==
X-Received: by 2002:a05:6a20:ceaa:b0:140:a25:1c1d with SMTP id
 if42-20020a056a20ceaa00b001400a251c1dmr1097705pzb.51.1697524871031; 
 Mon, 16 Oct 2023 23:41:11 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 x18-20020a17090300d200b001b891259eddsm685682plc.197.2023.10.16.23.41.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:41:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 01/20] target/sparc: Introduce cpu_put_psr_icc
Date: Mon, 16 Oct 2023 23:40:50 -0700
Message-Id: <20231017064109.681935-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017064109.681935-1-richard.henderson@linaro.org>
References: <20231017064109.681935-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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


