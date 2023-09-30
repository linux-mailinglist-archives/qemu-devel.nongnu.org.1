Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 331097B3DBD
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Sep 2023 05:12:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmQO2-0001TV-J8; Fri, 29 Sep 2023 23:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmQO0-0001RL-DQ
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 23:11:20 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmQNy-0000CZ-NN
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 23:11:20 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-279067b9823so3491353a91.1
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 20:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696043477; x=1696648277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CvIZ6W7L03y5eJZB7mtYJeqixddh+4BUTJc0pWynQtU=;
 b=HuuDBEP+0HD4wpkH9Y8GaESeEuE4NmQYrLhWa7M4aqjelYOFyiV8wJTZXBWvUXDKyQ
 GiO3vzfaSFPZX08CPw/19jhotlZiveuf43NUV0GSeolHiIDip9gPmPqGlwbCtl88OSj3
 AkTQtizx6QgM6xIuNAcLHy5EvqIg7KABAjxXrAnd/40+wqPJEtPLr+1Rm2QQPhvQsXc5
 HdGDrPPr0KJbstY7uolnf3j8qm3lmIzmn1DwehYev7PXn0nYZDxrYNUhYQIzB4i5N3Wg
 pQzFlllxUy9qGuFCElI8mpsIudvJ+iC8AdzCkrjzwRi6LqCL2ydNKXervZfEIAYcHbbf
 3aLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696043477; x=1696648277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CvIZ6W7L03y5eJZB7mtYJeqixddh+4BUTJc0pWynQtU=;
 b=NB++PsfLRBkvxl6ah0VSZNM9HrljRiqb5O0h4EN/O/r8HKEZLfF4sNODnQ32xQ+Xdk
 zjqFCBnUJp4L5AgXYXYS/dx5FBXPffWec+Q1PeVcEvFQWUHpTMlFbMXkqbJyfeSaLqis
 5AWDgveWeeCV2nccox1XC5ru375o7EXMRxw0umXbzZkgfmebi0iUOFVHocIUlqSCOjuc
 w2Lu0ZlYxnWSvy1d6MXCdduCMJg4b92iymHJKWfUKooFFJt0V4AG0f9yDXC9Y/szSj/h
 HtMQ4k1znDmxmpxS2R48mF99rSYDJL5nie+o8AUaTtBRDQk8d86j+N/41VyNOBpPPuGN
 2Wog==
X-Gm-Message-State: AOJu0Yyl86QXrKqig2D6waKtQN5T6U+epeEOINzgZuQqUiK/XaUmiUNr
 Lrgv4CB0Xb8tGAC4sfPBy5LorUXXO9yJwUvz7fI=
X-Google-Smtp-Source: AGHT+IGvo0AuEJCrilVmS4mPBa5vHk/ZTgXcgjpjURxY0OwyIED4fz/DdupmsOMAkPSUeMM7hkjcKg==
X-Received: by 2002:a17:90a:c913:b0:274:8a03:b546 with SMTP id
 v19-20020a17090ac91300b002748a03b546mr5951722pjt.23.1696043477142; 
 Fri, 29 Sep 2023 20:11:17 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 gp15-20020a17090adf0f00b002790ded9c6dsm2146821pjb.31.2023.09.29.20.11.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 20:11:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 1/2] tcg: Remove argument to tcg_prologue_init
Date: Fri, 29 Sep 2023 20:11:13 -0700
Message-Id: <20230930031114.1042913-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230930031114.1042913-1-richard.henderson@linaro.org>
References: <20230930031114.1042913-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

We can load tcg_ctx just as easily within the callee.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h   | 2 +-
 accel/tcg/tcg-all.c | 2 +-
 bsd-user/main.c     | 2 +-
 linux-user/main.c   | 2 +-
 tcg/tcg.c           | 3 ++-
 5 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index c9c6d770d0..44aced2ddd 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -785,7 +785,7 @@ static inline void *tcg_malloc(int size)
 
 void tcg_init(size_t tb_size, int splitwx, unsigned max_cpus);
 void tcg_register_thread(void);
-void tcg_prologue_init(TCGContext *s);
+void tcg_prologue_init(void);
 void tcg_func_start(TCGContext *s);
 
 int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start);
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 03dfd67e9e..d9d8dde202 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -121,7 +121,7 @@ static int tcg_init_machine(MachineState *ms)
      * There's no guest base to take into account, so go ahead and
      * initialize the prologue now.
      */
-    tcg_prologue_init(tcg_ctx);
+    tcg_prologue_init();
 #endif
 
     return 0;
diff --git a/bsd-user/main.c b/bsd-user/main.c
index f913cb55a7..dcdaf059bc 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -586,7 +586,7 @@ int main(int argc, char **argv)
      * generating the prologue until now so that the prologue can take
      * the real value of GUEST_BASE into account.
      */
-    tcg_prologue_init(tcg_ctx);
+    tcg_prologue_init();
 
     target_cpu_init(env, regs);
 
diff --git a/linux-user/main.c b/linux-user/main.c
index 96be354897..66962e1d4a 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -994,7 +994,7 @@ int main(int argc, char **argv, char **envp)
     /* Now that we've loaded the binary, GUEST_BASE is fixed.  Delay
        generating the prologue until now so that the prologue can take
        the real value of GUEST_BASE into account.  */
-    tcg_prologue_init(tcg_ctx);
+    tcg_prologue_init();
 
     target_cpu_copy_regs(env, regs);
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 604fa9bf3e..4ec4f34b93 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1387,8 +1387,9 @@ TranslationBlock *tcg_tb_alloc(TCGContext *s)
     return tb;
 }
 
-void tcg_prologue_init(TCGContext *s)
+void tcg_prologue_init(void)
 {
+    TCGContext *s = tcg_ctx;
     size_t prologue_size;
 
     s->code_ptr = s->code_gen_ptr;
-- 
2.34.1


