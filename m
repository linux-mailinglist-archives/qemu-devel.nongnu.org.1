Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D547C5072
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 12:44:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqWgo-0008F5-HQ; Wed, 11 Oct 2023 06:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWgm-0008Di-Tz
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:43:40 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWgg-0007fI-Ob
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:43:40 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-32d834ec222so675294f8f.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 03:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697021013; x=1697625813; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yd35sPPYW+65MfBRsBZG66w/oIpnWjGdXLFZzvofEuI=;
 b=sgbPZFBFlybtMB/12dzG4MaqVDuLrNNwStEEwEmseUU0+eFT7JeS6HEYx9ytPPmoB8
 Jqc6vkrrWplGfxFqrLB7XjwAM/Ab0UtJxqS9xpfeV7ggTh/xNJyI0VY5YDUQK5BA7vbB
 mKbnCuJUfnoOoQW8js8GWBWZ+gklTrqrNsWBJVy7whvMsZrRHwnTrOF4nRTgfKf4lwVA
 2iWDLm9kujqr5Mp+RHinkr5RcAfuGN9y/czrLANAxNZdF2ESdUrUTUfCxDgRqLqX/9Ws
 a/F/ADDjUYVqMiPR4qpggsvo7Gk/FTujpjhHArRCkyG+k+k57ZKkFfxiyV8+SWRDl8QS
 Pzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697021013; x=1697625813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yd35sPPYW+65MfBRsBZG66w/oIpnWjGdXLFZzvofEuI=;
 b=wdMVeXtaDa72naXXmke7/hxmQJplMV2lyHZTHbp6Xc7QFRmXZID+Et8BD+St4tD3ld
 8NWIUdG7X54Nh3H/Ew8EoOrmM7N6338pOLe6xL/Ac2jylyf4Q915VafR6o51Xjp+gEv0
 FN1aF2FpchZzIc++cpmiBWQ+qF2Oly8oEri2jGbqcucC3SqA63SIyjHXEgw/Zu4K/y7Y
 VSIHWAoSNtHXfNvQs8nOxwCnyNW0G93jkz+WpBnU7kjecD16sUIJz4WshJKqQe2XH1kl
 v/XEiqFYzAZ1+dOJ+0SJREmzluF2pyJPT1fsPgXCJz8gMuak9FlkykTd9FfITkvQM7mc
 +2gQ==
X-Gm-Message-State: AOJu0YwbR2TZ1IW0dSU9Tw8lQyT7ElGsDV5PEU5dNK8nw2CPoAY7W6Sq
 TYj4PFXRZpK2Uzr+ZbyxNQiPKbBEXbjoxSGqsds=
X-Google-Smtp-Source: AGHT+IHCNi1U2lGv99D+WmqD2xJYMxkLWk1JhG1hB/bEjavSMBvXSjlYEBw8+eoVJT0L5uToCyI09w==
X-Received: by 2002:a05:6000:180d:b0:32d:88dd:419b with SMTP id
 m13-20020a056000180d00b0032d88dd419bmr740659wrh.35.1697021013115; 
 Wed, 11 Oct 2023 03:43:33 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 t25-20020adfa2d9000000b0032d8373fbe4sm1804097wra.51.2023.10.11.03.43.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 03:43:32 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8C9B91FFCE;
 Wed, 11 Oct 2023 11:33:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Borgerson <contact@mborgerson.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 22/25] plugins: Set final instruction count in plugin_gen_tb_end
Date: Wed, 11 Oct 2023 11:33:26 +0100
Message-Id: <20231011103329.670525-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011103329.670525-1-alex.bennee@linaro.org>
References: <20231011103329.670525-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Matt Borgerson <contact@mborgerson.com>

Translation logic may partially decode an instruction, then abort and
remove the instruction from the TB. This can happen for example when an
instruction spans two pages. In this case, plugins may get an incorrect
result when calling qemu_plugin_tb_n_insns to query for the number of
instructions in the TB. This patch updates plugin_gen_tb_end to set the
final instruction count.

Signed-off-by: Matt Borgerson <contact@mborgerson.com>
[AJB: added g_assert to defed API]
Message-Id: <CADc=-s5RwGViNTR-h5cq3np673W3RRFfhr4vCGJp0EoDUxvhog@mail.gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231009164104.369749-23-alex.bennee@linaro.org>

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
 
@@ -42,7 +42,7 @@ void plugin_gen_insn_start(CPUState *cpu, const struct DisasContextBase *db)
 static inline void plugin_gen_insn_end(void)
 { }
 
-static inline void plugin_gen_tb_end(CPUState *cpu)
+static inline void plugin_gen_tb_end(CPUState *cpu, size_t num_insns)
 { }
 
 static inline void plugin_gen_disable_mem_helpers(void)
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index d31c9993ea..39b3c9351f 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -866,10 +866,14 @@ void plugin_gen_insn_end(void)
  * do any clean-up here and make sure things are reset in
  * plugin_gen_tb_start.
  */
-void plugin_gen_tb_end(CPUState *cpu)
+void plugin_gen_tb_end(CPUState *cpu, size_t num_insns)
 {
     struct qemu_plugin_tb *ptb = tcg_ctx->plugin_tb;
 
+    /* translator may have removed instructions, update final count */
+    g_assert(num_insns <= ptb->n);
+    ptb->n = num_insns;
+
     /* collect instrumentation requests */
     qemu_plugin_tb_trans_cb(cpu, ptb);
 
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index c5da7b32a5..575b9812ad 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -210,7 +210,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     gen_tb_end(tb, cflags, icount_start_insn, db->num_insns);
 
     if (plugin_enabled) {
-        plugin_gen_tb_end(cpu);
+        plugin_gen_tb_end(cpu, db->num_insns);
     }
 
     /* The disas_log hook may use these values rather than recompute.  */
-- 
2.39.2


