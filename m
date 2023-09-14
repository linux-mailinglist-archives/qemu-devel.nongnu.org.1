Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9E07A0BEF
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 19:46:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgqOU-0000ds-CJ; Thu, 14 Sep 2023 13:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgqOR-0000cs-FS
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 13:44:43 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgqOP-0006yy-6e
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 13:44:43 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-68fb71ded6dso998113b3a.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 10:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694713479; x=1695318279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bgCEQn26u9cOavCqkRzqblhPRJruQuAIdfQLbzQ1zEg=;
 b=MDiFtmxG/VbbRVIHQ8wtvyw5adaY+/CBt8uMMAg5VpN/TF7BZu2Us0wmu1L6QzBOfd
 OlvhMnQWYOjYk0yz7vHD+aXH2+IaPDhRizmsaQJjSTP5yNyJezlWZc1daCzGGH2hLwBT
 yVyFNDPWGtsz0Dr9krhHW9YBBJcu5lQRCNpCnglTJYsL6OoGJ06g2sDFOxetaHWSTROm
 QnTK5Ww4iVZ9mtoi0nCisfxW82UrCn8DbYeNK2FPKGwJLydm5v+1LiS7g2mKlYTcsmQS
 6Lgb0rcvM/Gpryd393+6L1gj9OIvA2ZTCuYWEr54sZDr62C2P2ji+QS4WJzJL8TasP2A
 dFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694713479; x=1695318279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bgCEQn26u9cOavCqkRzqblhPRJruQuAIdfQLbzQ1zEg=;
 b=CsvM0RQXW7Qy6M1Gk8bUJxGFrNn2f0eWvI13+LmU7t2Z+L59m7CfPCHmGFz8QEO7Jg
 FXXFRxjzK56MAx6qF9+2gaoDHCszjFYklRiYyDtvaoA3c2fnucjKCvAC1Mzjl80xRiIM
 bQF/1JURPSjZBFkC6pocXEjw7+uSaIITR95T4PKqzEVkXMtE/Hw20akJ/G62CemABcCx
 gnKagkBKpfkDciccXnhKUAlNpfOxSQvF8KuK8xxL7Ihb54lGFLYZveDWfIhyerSLTj/p
 gCiNDdsc/OMCFxO4j1Qjpa1jlaaNESZuHCZ6r+rwwbprb6RTxbH/VENzkp/AhkZBg4zy
 BPAQ==
X-Gm-Message-State: AOJu0YyUouD7/3gE/+YUXayrFYraXpFMylkLlBrGhyjNNe2ThSD1r+io
 rtYRdWJi7QMoIZELSXSkaj5tgK/SXaDn9BrBhjI=
X-Google-Smtp-Source: AGHT+IHs6QF5maY85m/NSmUxFqQjf0h7LvQOjIt5eFOBrpMhn3jeouSEH/f5MYGg+PBoMw5ids8i2g==
X-Received: by 2002:a05:6a00:851:b0:68e:2d59:b1f3 with SMTP id
 q17-20020a056a00085100b0068e2d59b1f3mr7473449pfk.13.1694713479363; 
 Thu, 14 Sep 2023 10:44:39 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 w17-20020aa78591000000b0068c5bd3c3b4sm1588933pfn.206.2023.09.14.10.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 10:44:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 2/6] accel/tcg: Hoist CF_MEMI_ONLY check outside translation
 loop
Date: Thu, 14 Sep 2023 10:44:32 -0700
Message-Id: <20230914174436.1597356-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914174436.1597356-1-richard.henderson@linaro.org>
References: <20230914174436.1597356-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

The condition checked is loop invariant; check it only once.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translator.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index a3983019a5..b6ab9f3d33 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -158,7 +158,13 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     ops->tb_start(db, cpu);
     tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
 
-    plugin_enabled = plugin_gen_tb_start(cpu, db, cflags & CF_MEMI_ONLY);
+    if (cflags & CF_MEMI_ONLY) {
+        /* We should only see CF_MEMI_ONLY for io_recompile. */
+        assert(cflags & CF_LAST_IO);
+        plugin_enabled = plugin_gen_tb_start(cpu, db, true);
+    } else {
+        plugin_enabled = plugin_gen_tb_start(cpu, db, false);
+    }
 
     while (true) {
         *max_insns = ++db->num_insns;
@@ -176,12 +182,8 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
         if (db->num_insns == db->max_insns && (cflags & CF_LAST_IO)) {
             /* Accept I/O on the last instruction.  */
             gen_io_start();
-            ops->translate_insn(db, cpu);
-        } else {
-            /* we should only see CF_MEMI_ONLY for io_recompile */
-            tcg_debug_assert(!(cflags & CF_MEMI_ONLY));
-            ops->translate_insn(db, cpu);
         }
+        ops->translate_insn(db, cpu);
 
         /*
          * We can't instrument after instructions that change control
-- 
2.34.1


