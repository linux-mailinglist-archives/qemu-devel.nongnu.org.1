Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCF9753081
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 06:21:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKAGu-0000CO-S6; Fri, 14 Jul 2023 00:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mborgerson@gmail.com>)
 id 1qKAGs-0000CB-PW
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 00:19:10 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mborgerson@gmail.com>)
 id 1qKAGr-0006iT-5N
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 00:19:10 -0400
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-4fb960b7c9dso2552637e87.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 21:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689308345; x=1691900345;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mhZGUjrpcSi/HV5PbXeLZy2nZZa57cTldyhlR/nyMFo=;
 b=S4S88tPignNFm9p9l6aadSZen6O1VnRpXa0knlXWrGUGyrWG5MCubY5V3vdvxB9iaw
 42r+CIkJIg0zrxeFTdo5JUfsP4m0JS9pSmXnxPKguAsZNSNrCwSbTz42Naz2SFK+M/fJ
 IBsjeEo0DNehTbfD0hJg0fWiPaxT8D0rJOswmX0s7C5oiQa9CFiohnfOB4E/5nXg5Ro3
 LS6uoNl6NhvZU3wt30YwI4IgdFEsotK+sDduuRD/LAj/KVxNzCyumzg739Qhu4vZHoUx
 4gumYUsVqHoRebKmK5pwuC011jwcLTcT+m3ZO9AcBTIgvKAwvAo74vYvHrmP1/cOjmLt
 uQuw==
X-Gm-Message-State: ABy/qLY85U5fnRUKBOUq3u50Ga7p27al1iAXYAx3B+HjV4U3PnHJbXD/
 5ZMcc5GPYyqmrUxcDeVc73exJoJPCJJ4XhQq
X-Google-Smtp-Source: APBJJlF9lNDZ9dPIfr5gc6J8cqKDzl6yxo8QMAihvVo+wXlzHMFvBKK/NPsb07z4Ry8idObUdMEpRQ==
X-Received: by 2002:a05:6512:2315:b0:4f8:5cde:a44f with SMTP id
 o21-20020a056512231500b004f85cdea44fmr3052233lfu.10.1689308345097; 
 Thu, 13 Jul 2023 21:19:05 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com.
 [209.85.208.178]) by smtp.gmail.com with ESMTPSA id
 u26-20020ac243da000000b004fb85ffc82csm1332174lfl.10.2023.07.13.21.19.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jul 2023 21:19:05 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id
 38308e7fff4ca-2b741cf99f8so22359561fa.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 21:19:04 -0700 (PDT)
X-Received: by 2002:a2e:9a99:0:b0:2b6:a05a:c5c with SMTP id
 p25-20020a2e9a99000000b002b6a05a0c5cmr2986175lji.1.1689308344660; Thu, 13 Jul
 2023 21:19:04 -0700 (PDT)
MIME-Version: 1.0
From: Matt Borgerson <contact@mborgerson.com>
Date: Thu, 13 Jul 2023 21:18:53 -0700
X-Gmail-Original-Message-ID: <CADc=-s4Ef9eBV7Z6FKYRT=-5c733ZHQRjvnumV5OwjJh8uFmmA@mail.gmail.com>
Message-ID: <CADc=-s4Ef9eBV7Z6FKYRT=-5c733ZHQRjvnumV5OwjJh8uFmmA@mail.gmail.com>
Subject: [PATCH] plugins: Set final instruction count in plugin_gen_tb_end
To: qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=209.85.167.46; envelope-from=mborgerson@gmail.com;
 helo=mail-lf1-f46.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
index 5c13615112..809529990a 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -866,10 +866,13 @@ void plugin_gen_insn_end(void)
  * do any clean-up here and make sure things are reset in
  * plugin_gen_tb_start.
  */
-void plugin_gen_tb_end(CPUState *cpu)
+void plugin_gen_tb_end(CPUState *cpu, int num_insns)
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
index 52828781bc..4feaa47b08 100644
--- a/include/exec/plugin-gen.h
+++ b/include/exec/plugin-gen.h
@@ -20,7 +20,7 @@ struct DisasContextBase;

 bool plugin_gen_tb_start(CPUState *cpu, const struct DisasContextBase *db,
                          bool supress);
-void plugin_gen_tb_end(CPUState *cpu);
+void plugin_gen_tb_end(CPUState *cpu, int num_insns);
 void plugin_gen_insn_start(CPUState *cpu, const struct DisasContextBase *db);
 void plugin_gen_insn_end(void);

@@ -42,7 +42,7 @@ void plugin_gen_insn_start(CPUState *cpu, const
struct DisasContextBase *db)
 static inline void plugin_gen_insn_end(void)
 { }

-static inline void plugin_gen_tb_end(CPUState *cpu)
+static inline void plugin_gen_tb_end(CPUState *cpu, int num_insns)
 { }

 static inline void plugin_gen_disable_mem_helpers(void)
-- 
2.34.1

