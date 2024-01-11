Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0782782B099
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 15:25:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNvyW-0004Mb-5T; Thu, 11 Jan 2024 09:24:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rNvyR-0004LR-Jx
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 09:24:00 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rNvyN-0002QX-FI
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 09:23:59 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3367a304091so4690002f8f.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 06:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704983033; x=1705587833; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xFv6E5kkXfIGfEX1pT8iilVpb1LB0Hjh6FDK0KUik1o=;
 b=GMitChlbw9fHcIenm3QtyIOZdslthxohFULnifPccdh6uFrGzVJBz2Q7Gt1HDX8Nrn
 v1U8bdgkpu/W5Na0DPaIPTtCWRc3wDNcZ4Zrd75HM9aDexUAAAcGv8x479a+3RgN9PPq
 R2kRliVelgWhp5ZcKn6+lycO2Kh7H4jSUnIaBJlgvPKYTdkRhI6DalwZ353c0XtbTrje
 7z6lEk/W35bRgQPmBWP20dKNey8/xBpTEQmYZeys736segLCumkT8WUUCPVvVEjtgHz9
 Of30+UhofC77QbCi2cjrtB8+xrwL5jUcinXEcZdNFHq4JlLl3ZjfqQHyv2SmD1yv5Ez7
 ztJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704983033; x=1705587833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xFv6E5kkXfIGfEX1pT8iilVpb1LB0Hjh6FDK0KUik1o=;
 b=RrBsMJZ8kbsW7Fw/npwsDAFprTaIQheXyj+O8nTS5e4UMQVdjqQuS2t16FE/aYm0ox
 4kS0xvzSUYyChsowDieIzNNWDpHeRE9hbbpyeueCbAXHl/xqeHBpisApA4KcedMlKBlP
 QKyN1r5hgvw8Gqbw1Y9YEpb7krWezGnV1PkRqYgqHbLygyCznCZsf6YbFNCgEBrNsDuk
 i5rNwVIpI121wyEl2J3xccH8OVO5lBgvjfLuwJhwWHnGznboj4OOOpI5Um63t9dF6Xwd
 qdSP+BC1Ign7yJ/QZQG3vrexIjELlq43dFO+HK90C7Jeih26K0+dF7P9DpEosCSX+gmJ
 utzQ==
X-Gm-Message-State: AOJu0YwhM09oq7QH00YdeSPtMJ69XzY0Ll/Oq4dfJdXuLr7PJIKl/dpk
 rP/XdZy76OOPaIyGV92+0OU+rLJiFpog8j1pUTPHZe+66tg3xA==
X-Google-Smtp-Source: AGHT+IFJdexCQTbgMGPOP4Amkmn/mSGTxF2FRnEe+PZ72gyeMYwSssxi2JWyLejS4xYig9kZLlZaUA==
X-Received: by 2002:adf:cd07:0:b0:336:5bf4:9904 with SMTP id
 w7-20020adfcd07000000b003365bf49904mr430816wrm.142.1704983033223; 
 Thu, 11 Jan 2024 06:23:53 -0800 (PST)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 h7-20020adff4c7000000b0033677aae2e2sm1349000wrp.107.2024.01.11.06.23.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 06:23:52 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 04/12] tests/plugin/inline: migrate to new per_vcpu API
Date: Thu, 11 Jan 2024 18:23:17 +0400
Message-ID: <20240111142326.1743444-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111142326.1743444-1-pierrick.bouvier@linaro.org>
References: <20240111142326.1743444-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x436.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/plugin/inline.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/tests/plugin/inline.c b/tests/plugin/inline.c
index 6114ebca545..ae59f7af7a7 100644
--- a/tests/plugin/inline.c
+++ b/tests/plugin/inline.c
@@ -18,15 +18,12 @@
 static uint64_t count_tb;
 static uint64_t count_tb_per_vcpu[MAX_CPUS];
 static uint64_t count_tb_inline_per_vcpu[MAX_CPUS];
-static uint64_t count_tb_inline_racy;
 static uint64_t count_insn;
 static uint64_t count_insn_per_vcpu[MAX_CPUS];
 static uint64_t count_insn_inline_per_vcpu[MAX_CPUS];
-static uint64_t count_insn_inline_racy;
 static uint64_t count_mem;
 static uint64_t count_mem_per_vcpu[MAX_CPUS];
 static uint64_t count_mem_inline_per_vcpu[MAX_CPUS];
-static uint64_t count_mem_inline_racy;
 static GMutex tb_lock;
 static GMutex insn_lock;
 static GMutex mem_lock;
@@ -50,11 +47,9 @@ static void stats_insn(void)
     printf("insn: %" PRIu64 "\n", expected);
     printf("insn: %" PRIu64 " (per vcpu)\n", per_vcpu);
     printf("insn: %" PRIu64 " (per vcpu inline)\n", inl_per_vcpu);
-    printf("insn: %" PRIu64 " (inline racy)\n", count_insn_inline_racy);
     g_assert(expected > 0);
     g_assert(per_vcpu == expected);
     g_assert(inl_per_vcpu == expected);
-    g_assert(count_insn_inline_racy <= expected);
 }
 
 static void stats_tb(void)
@@ -65,11 +60,9 @@ static void stats_tb(void)
     printf("tb: %" PRIu64 "\n", expected);
     printf("tb: %" PRIu64 " (per vcpu)\n", per_vcpu);
     printf("tb: %" PRIu64 " (per vcpu inline)\n", inl_per_vcpu);
-    printf("tb: %" PRIu64 " (inline racy)\n", count_tb_inline_racy);
     g_assert(expected > 0);
     g_assert(per_vcpu == expected);
     g_assert(inl_per_vcpu == expected);
-    g_assert(count_tb_inline_racy <= expected);
 }
 
 static void stats_mem(void)
@@ -80,11 +73,9 @@ static void stats_mem(void)
     printf("mem: %" PRIu64 "\n", expected);
     printf("mem: %" PRIu64 " (per vcpu)\n", per_vcpu);
     printf("mem: %" PRIu64 " (per vcpu inline)\n", inl_per_vcpu);
-    printf("mem: %" PRIu64 " (inline racy)\n", count_mem_inline_racy);
     g_assert(expected > 0);
     g_assert(per_vcpu == expected);
     g_assert(inl_per_vcpu == expected);
-    g_assert(count_mem_inline_racy <= expected);
 }
 
 static void plugin_exit(qemu_plugin_id_t id, void *udata)
@@ -142,8 +133,6 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
 {
     qemu_plugin_register_vcpu_tb_exec_cb(tb, vcpu_tb_exec,
                                          QEMU_PLUGIN_CB_NO_REGS, 0);
-    qemu_plugin_register_vcpu_tb_exec_inline(tb, QEMU_PLUGIN_INLINE_ADD_U64,
-                                             &count_tb_inline_racy, 1);
     qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
         tb, QEMU_PLUGIN_INLINE_ADD_U64,
         count_tb_inline_per_vcpu, sizeof(uint64_t), 1);
@@ -152,18 +141,12 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
         struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, idx);
         qemu_plugin_register_vcpu_insn_exec_cb(insn, vcpu_insn_exec,
                                                QEMU_PLUGIN_CB_NO_REGS, 0);
-        qemu_plugin_register_vcpu_insn_exec_inline(
-            insn, QEMU_PLUGIN_INLINE_ADD_U64,
-            &count_insn_inline_racy, 1);
         qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
             insn, QEMU_PLUGIN_INLINE_ADD_U64,
             count_insn_inline_per_vcpu, sizeof(uint64_t), 1);
         qemu_plugin_register_vcpu_mem_cb(insn, &vcpu_mem_access,
                                          QEMU_PLUGIN_CB_NO_REGS,
                                          QEMU_PLUGIN_MEM_RW, 0);
-        qemu_plugin_register_vcpu_mem_inline(insn, QEMU_PLUGIN_MEM_RW,
-                                             QEMU_PLUGIN_INLINE_ADD_U64,
-                                             &count_mem_inline_racy, 1);
         qemu_plugin_register_vcpu_mem_inline_per_vcpu(
             insn, QEMU_PLUGIN_MEM_RW,
             QEMU_PLUGIN_INLINE_ADD_U64,
-- 
2.43.0


