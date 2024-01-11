Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE9382B09A
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 15:25:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNvyt-0004Sx-D1; Thu, 11 Jan 2024 09:24:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rNvyX-0004NM-Pv
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 09:24:06 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rNvyV-0002by-Kz
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 09:24:05 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40d5336986cso69028505e9.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 06:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704983042; x=1705587842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BTn8iqDeGr0XAAzxAxgUm6NGko/94wD5dpWMO4sCVF8=;
 b=VMnAyScOHl86YYgTkYSIR5fFYzjmx2+0mRv6hEu0cq5ZABhIGfdVuMxxoBwhjAhvEG
 7pjyMkUuPP60q54gXtuLKfCn+7TqjnWA1Pm26RIs+oGntkuoB5zOq7xOUxgTMpjtGDFR
 TRzMthr+J9d+TMfc6KRtW3+szaEPWSKLeaxaNeumIKjXHrtK5FzhCGYxAQP0EE5t9Xwe
 CBfGOqZXyzF4FKezt0VheCmpudMyyaa2AIOXozKtfRY/6PSr5d4kWzUXhgX4FlFUr+KI
 Fa2PwIorD/T+7MxLUo3fQguLuQfKZoamFzoUAXa2fl8RTPCP/REKG85U+PTAnzeKWXRU
 B8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704983042; x=1705587842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BTn8iqDeGr0XAAzxAxgUm6NGko/94wD5dpWMO4sCVF8=;
 b=cBG/rrJmt/FyJ6Vd3OLiEwWY6+T2kXj5jEni679sZwuv2PZZjmmxfe3/MBVG2n5ZBP
 5YfX3SMKLqUVjZofs9ed5B5VOWSM2p2ea+WKh/8/jbja3o8F6ADLnB1BmngQtk/uuAvW
 nVJUAA9UrFAaUz7qoATMloAqe2tPUZSVeqo6IYaVWSW+yXUX86Wd7ZhE26eChRAF4ZLV
 pQAZEripFmulpsc0+aKBXiE6qMEXlj9g8Tl39xM0ZmvG1ywS6LwNoU5kDvaft9ldMnk+
 dG6qUuVYc68wAp+QvakIahULkOYHFWwymEydZURkRplXV1NwJIqKpxK7qgdHS+bn4bCw
 Q1hg==
X-Gm-Message-State: AOJu0Yw2IGe/bAkcnrbYBbK89I+oT9UHdutOdt1bqUg2sPZzVNCn1JEY
 inCSgBEMPfXkE1qX8Ob2pSVPbWPzBT62iLsjLcOa1u6Bv+TZow==
X-Google-Smtp-Source: AGHT+IFle3qmsRi7aJ+lk52W24+9p4cKH4le//pzFYsxyldlcVwY9IvuEKnpa0S1BGhUqDP4Mfsy8Q==
X-Received: by 2002:a7b:cb96:0:b0:40e:393d:715e with SMTP id
 m22-20020a7bcb96000000b0040e393d715emr454996wmi.207.1704983041835; 
 Thu, 11 Jan 2024 06:24:01 -0800 (PST)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 h7-20020adff4c7000000b0033677aae2e2sm1349000wrp.107.2024.01.11.06.23.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 06:24:01 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 07/12] tests/plugin/insn: migrate to new per_vcpu API
Date: Thu, 11 Jan 2024 18:23:20 +0400
Message-ID: <20240111142326.1743444-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111142326.1743444-1-pierrick.bouvier@linaro.org>
References: <20240111142326.1743444-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x334.google.com
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
 tests/plugin/insn.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tests/plugin/insn.c b/tests/plugin/insn.c
index 5fd3017c2b3..be79c5080fd 100644
--- a/tests/plugin/insn.c
+++ b/tests/plugin/insn.c
@@ -23,7 +23,7 @@ typedef struct {
 } InstructionCount;
 
 static InstructionCount counts[MAX_CPUS];
-static uint64_t inline_insn_count;
+static uint64_t inline_insn_count[MAX_CPUS];
 
 static bool do_inline;
 static bool do_size;
@@ -94,8 +94,9 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
         struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
 
         if (do_inline) {
-            qemu_plugin_register_vcpu_insn_exec_inline(
-                insn, QEMU_PLUGIN_INLINE_ADD_U64, &inline_insn_count, 1);
+            qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
+                insn, QEMU_PLUGIN_INLINE_ADD_U64,
+                inline_insn_count, sizeof(uint64_t), 1);
         } else {
             uint64_t vaddr = qemu_plugin_insn_vaddr(insn);
             qemu_plugin_register_vcpu_insn_exec_cb(
@@ -151,7 +152,11 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
             }
         }
     } else if (do_inline) {
-        g_string_append_printf(out, "insns: %" PRIu64 "\n", inline_insn_count);
+        uint64_t total = 0;
+        for (i = 0; i < MAX_CPUS; ++i) {
+            total += inline_insn_count[i];
+        }
+        g_string_append_printf(out, "insns: %" PRIu64 "\n", total);
     } else {
         uint64_t total_insns = 0;
         for (i = 0; i < MAX_CPUS; i++) {
@@ -195,6 +200,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                 fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
                 return -1;
             }
+            g_assert(info->system.smp_vcpus <= MAX_CPUS);
         } else if (g_strcmp0(tokens[0], "sizes") == 0) {
             if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &do_size)) {
                 fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
-- 
2.43.0


