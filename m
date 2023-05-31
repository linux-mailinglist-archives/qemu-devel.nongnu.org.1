Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E13BB7174EC
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 06:12:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4D7X-0004d1-Hn; Wed, 31 May 2023 00:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D79-00039V-QH
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:07:14 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D78-0006vi-0F
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:07:11 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-53f7bef98b7so2995776a12.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 21:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685506027; x=1688098027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5T+y6XKoovlI/5PgO4ohU9QwOLRgrcATNcdajUNZQbc=;
 b=vCJBuOMMg5v+q045jkTPl/kPi6ASL1NHxLvVsGII3fZyaS7VRQ46PD3OpkU+NJ3sgC
 3prTk1/8uuHM8TeIs09SnC+0r9aa7/mdmCeHpcpCPp+jU4KK+LnaaDbF07VTmwQWw3sw
 PdysbnTOnF1ziEaq04zU4mqBeFlq2c5JF8ra08FWgBhqwrWz3lSRGmtSwaNPH/tyokAo
 a/D8NBVj+S6a7Uef+CN2rjr4HYhgOZk36BqX+t8EzjcTdQbhNASXsS7qhINTvIvEiRJl
 lzSY6Vcwr0ciQ1h4/e7RLkQwTY8TPAtUShWelcbZTriIZ5k36neI2EnhuMoSIFK9id2z
 aihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685506027; x=1688098027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5T+y6XKoovlI/5PgO4ohU9QwOLRgrcATNcdajUNZQbc=;
 b=OYNDmQ93swy92W7OG5zx8p3W7svtigwXHN5NrxPKd+Y7BdxFF1Pzthvk917HUErCEG
 pc1S9Zw6TKBcPH9gyu/aesru4rX/6npfit7wHFkee//LEJFMsaXXLMUnucLKMAe6potR
 0mPdojvEuzkNn3gAqj2DfIBXQe+LuHZ+9PJWLKQba3APINZYjELIt+9ZuzlOnke2m7oG
 Y6ppjLrxRfxrnAqEw3PSRQikJqCprUEro4zrYXF6bDnzdYhIlpzB28e62HYbEtv2Fozv
 QYaa3zveGu88PwKiixJSkSMCGqa1EM67V68jF5PScCdtPPGaf5+yYv6UgSS9GBsmRfr/
 F/jw==
X-Gm-Message-State: AC+VfDwalcCPVJ6aYCI4RMwJUNmABFEPW616veItYE5rSZFlJ8rKseQd
 bEmE1c5W+1Y4e8XdeDkiAepF5VrjvgwAhykVNEI=
X-Google-Smtp-Source: ACHHUZ5YdjAHAisULgvIUOPR8tWoHwaUHM8NjLsjNdugU59Z8tdLsRXo7mXRAOc6ZmyBNlUI/xNnCQ==
X-Received: by 2002:a17:902:d2c2:b0:1b0:3742:e725 with SMTP id
 n2-20020a170902d2c200b001b03742e725mr5498007plc.56.1685506027477; 
 Tue, 30 May 2023 21:07:07 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:1cd:ec7a:a720:ce9a])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a170902f7cd00b001aadd0d7364sm151797plw.83.2023.05.30.21.07.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 21:07:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 45/48] plugins: Move plugin_insn_append to translator.c
Date: Tue, 30 May 2023 21:03:27 -0700
Message-Id: <20230531040330.8950-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531040330.8950-1-richard.henderson@linaro.org>
References: <20230531040330.8950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

This function is only used in translator.c, and uses a
target-specific typedef, abi_ptr.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/plugin-gen.h | 22 ----------------------
 accel/tcg/translator.c    | 21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/include/exec/plugin-gen.h b/include/exec/plugin-gen.h
index 3af0168e65..e9a976f815 100644
--- a/include/exec/plugin-gen.h
+++ b/include/exec/plugin-gen.h
@@ -29,25 +29,6 @@ void plugin_gen_insn_end(void);
 void plugin_gen_disable_mem_helpers(void);
 void plugin_gen_empty_mem_callback(TCGv_i64 addr, uint32_t info);
 
-static inline void plugin_insn_append(abi_ptr pc, const void *from, size_t size)
-{
-    struct qemu_plugin_insn *insn = tcg_ctx->plugin_insn;
-    abi_ptr off;
-
-    if (insn == NULL) {
-        return;
-    }
-    off = pc - insn->vaddr;
-    if (off < insn->data->len) {
-        g_byte_array_set_size(insn->data, off);
-    } else if (off > insn->data->len) {
-        /* we have an unexpected gap */
-        g_assert_not_reached();
-    }
-
-    insn->data = g_byte_array_append(insn->data, from, size);
-}
-
 #else /* !CONFIG_PLUGIN */
 
 static inline bool
@@ -72,9 +53,6 @@ static inline void plugin_gen_disable_mem_helpers(void)
 static inline void plugin_gen_empty_mem_callback(TCGv_i64 addr, uint32_t info)
 { }
 
-static inline void plugin_insn_append(abi_ptr pc, const void *from, size_t size)
-{ }
-
 #endif /* CONFIG_PLUGIN */
 
 #endif /* QEMU_PLUGIN_GEN_H */
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index fda4e7f637..918a455e73 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -285,6 +285,27 @@ static void *translator_access(CPUArchState *env, DisasContextBase *db,
     return host + (pc - base);
 }
 
+static void plugin_insn_append(abi_ptr pc, const void *from, size_t size)
+{
+#ifdef CONFIG_PLUGIN
+    struct qemu_plugin_insn *insn = tcg_ctx->plugin_insn;
+    abi_ptr off;
+
+    if (insn == NULL) {
+        return;
+    }
+    off = pc - insn->vaddr;
+    if (off < insn->data->len) {
+        g_byte_array_set_size(insn->data, off);
+    } else if (off > insn->data->len) {
+        /* we have an unexpected gap */
+        g_assert_not_reached();
+    }
+
+    insn->data = g_byte_array_append(insn->data, from, size);
+#endif
+}
+
 uint8_t translator_ldub(CPUArchState *env, DisasContextBase *db, abi_ptr pc)
 {
     uint8_t ret;
-- 
2.34.1


