Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3C575429C
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 20:34:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKNbV-0001Bt-BR; Fri, 14 Jul 2023 14:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mborgerson@gmail.com>)
 id 1qKNbI-0001BO-TX
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 14:33:08 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mborgerson@gmail.com>)
 id 1qKNbH-0002zy-2z
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 14:33:08 -0400
Received: by mail-lj1-f176.google.com with SMTP id
 38308e7fff4ca-2b702319893so34560171fa.3
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 11:33:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689359585; x=1691951585;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MVYnCU9ByQ1XkLYx4ziQPMNPniHHwWI9nIx55LqWA0c=;
 b=O01XnBlQp4dOhobotZnYbXW8Wo9bR+mTfbPl2qPXpd0z9f0PPyxGBpOijFg+MFvKjq
 ffyinti67V+HCAUJQdbYHKLUBWsz623UZsLcyG4yBC2ZYZ3IFYAUWKlVqJF3hubgC+0f
 QCJsFgDeSkbIGqDjK0loCJsDKuEKSrz3vxGoi3zuGm3SsJZ2av91G2LL4GPNjYAQJYoM
 lK0JbMj4UF5x2Or4hAHdlBxFSUXrcu1BgoI2wf3YWwRmlzEpNhI65Y50WlVojh3mz/Xr
 Gxirh6jt+ju8zFV0gddsImr30Xmj1WXyjYUfdfn6MY1HrfI8IS4sELm4eMF/jkAJ28LL
 WV9Q==
X-Gm-Message-State: ABy/qLalUBN69bPYqAYzX01cXrT6jC4n1h+1zb6EGJiIOF+aziDA8fKj
 Wy5W9GhtVGtYXJujuyhgHF4vVQa8Ox8aThDo
X-Google-Smtp-Source: APBJJlEwvywEWt/ADiIbnU/n/2Jmxa8jRHq1BumE/tLdsEVS/x06APvnVLsMUC0dXfK7hqSJ2SMBxw==
X-Received: by 2002:a2e:3503:0:b0:2b7:764:3caf with SMTP id
 z3-20020a2e3503000000b002b707643cafmr4033074ljz.10.1689359584771; 
 Fri, 14 Jul 2023 11:33:04 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com.
 [209.85.208.172]) by smtp.gmail.com with ESMTPSA id
 l26-20020a2e99da000000b002b6ce06618dsm2104284ljj.21.2023.07.14.11.33.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jul 2023 11:33:04 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id
 38308e7fff4ca-2b702319893so34559921fa.3
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 11:33:04 -0700 (PDT)
X-Received: by 2002:a2e:9252:0:b0:2b6:e296:bd68 with SMTP id
 v18-20020a2e9252000000b002b6e296bd68mr4476063ljg.35.1689359584517; Fri, 14
 Jul 2023 11:33:04 -0700 (PDT)
MIME-Version: 1.0
From: Matt Borgerson <contact@mborgerson.com>
Date: Fri, 14 Jul 2023 11:32:53 -0700
X-Gmail-Original-Message-ID: <CADc=-s5RwGViNTR-h5cq3np673W3RRFfhr4vCGJp0EoDUxvhog@mail.gmail.com>
Message-ID: <CADc=-s5RwGViNTR-h5cq3np673W3RRFfhr4vCGJp0EoDUxvhog@mail.gmail.com>
Subject: [PATCH v2] plugins: Set final instruction count in plugin_gen_tb_end
To: qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=209.85.208.176; envelope-from=mborgerson@gmail.com;
 helo=mail-lj1-f176.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Translation logic may partially decode an instruction, then abort and
remove the instruction from the TB. This can happen for example when an
instruction spans two pages. In this case, plugins may get an incorrect
result when calling qemu_plugin_tb_n_insns to query for the number of
instructions in the TB. This patch updates plugin_gen_tb_end to set the
final instruction count.

Signed-off-by: Matt Borgerson <contact@mborgerson.com>
---
 accel/tcg/plugin-gen.c    | 5 ++++-
 accel/tcg/translator.c    | 2 +-
 include/exec/plugin-gen.h | 4 ++--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 5c13615112..f18ecd6902 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -866,10 +866,13 @@ void plugin_gen_insn_end(void)
  * do any clean-up here and make sure things are reset in
  * plugin_gen_tb_start.
  */
-void plugin_gen_tb_end(CPUState *cpu)
+void plugin_gen_tb_end(CPUState *cpu, size_t num_insns)
 {
     struct qemu_plugin_tb *ptb = tcg_ctx->plugin_tb;

+    /* translator may have removed instructions, update final count */
+    ptb->n = num_insns;
+
     /* collect instrumentation requests */
     qemu_plugin_tb_trans_cb(cpu, ptb);

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 0fd9efceba..141f514886 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -215,7 +215,7 @@ void translator_loop(CPUState *cpu,
TranslationBlock *tb, int *max_insns,
     gen_tb_end(tb, cflags, icount_start_insn, db->num_insns);

     if (plugin_enabled) {
-        plugin_gen_tb_end(cpu);
+        plugin_gen_tb_end(cpu, db->num_insns);
     }

     /* The disas_log hook may use these values rather than recompute.  */
diff --git a/include/exec/plugin-gen.h b/include/exec/plugin-gen.h
index 52828781bc..c4552b5061 100644
--- a/include/exec/plugin-gen.h
+++ b/include/exec/plugin-gen.h
@@ -20,7 +20,7 @@ struct DisasContextBase;

 bool plugin_gen_tb_start(CPUState *cpu, const struct DisasContextBase *db,
                          bool supress);
-void plugin_gen_tb_end(CPUState *cpu);
+void plugin_gen_tb_end(CPUState *cpu, size_t num_insns);
 void plugin_gen_insn_start(CPUState *cpu, const struct DisasContextBase *db);
 void plugin_gen_insn_end(void);

@@ -42,7 +42,7 @@ void plugin_gen_insn_start(CPUState *cpu, const
struct DisasContextBase *db)
 static inline void plugin_gen_insn_end(void)
 { }

-static inline void plugin_gen_tb_end(CPUState *cpu)
+static inline void plugin_gen_tb_end(CPUState *cpu, size_t num_insns)
 { }

 static inline void plugin_gen_disable_mem_helpers(void)
-- 
2.34.1

