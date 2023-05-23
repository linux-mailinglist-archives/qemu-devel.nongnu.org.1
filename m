Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B2770DEED
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 16:14:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SVn-0003UW-Fw; Tue, 23 May 2023 09:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SVf-0003HO-Db
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:57:07 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SVd-0004DN-1n
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:57:07 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-64d426e63baso4412074b3a.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850223; x=1687442223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5T+y6XKoovlI/5PgO4ohU9QwOLRgrcATNcdajUNZQbc=;
 b=ZFAldy4+tFBfVjc/8kmEkv5YJDcD3GBrtyg3gkEED1tEfFqlyHHj4hGhTxVhmFfHhj
 tT4uYed1gwQH2o0V6vaIpKJoDe6RE1qf5cJJRMAz7sBBOPkU9Ca3eQXlNPXSSHZFu2jv
 HwEQs0B00gIMAE9wBceoajBvv9YCOR0ougnIEA0k8bwTYcoRlI9EHNii61y9UaqNhJ7D
 hslnTi3MlL5CzdCuK9Cy82hU5GYqBxXsTebXfUd+bCteuYQQyRyP/ZyOq0OZf+T6hCMN
 s4OvVALYV21QTJNLQac47n/30q1q4STbZuuVX9o5VYRpqe2Gxl3OpyVRjjjXD9EQtEy5
 1wCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850223; x=1687442223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5T+y6XKoovlI/5PgO4ohU9QwOLRgrcATNcdajUNZQbc=;
 b=bvVHsKP/FhRPoD5A8fBBJs/Z7V8HdT9WlCSvmJNULO3S7kXMI23JBmax41hI8KofUF
 0RI3ME1p86jJN+OSafqULsq5QAKfxLR89xswzksYd2dPDEPk3uZUmJ4RROLVdyfVX47F
 sQKBv/WG5/XrS1L4x7G1ykjuhHAhMTQYc4G0YYux4hUiawwfXthuO/nGFx2ztMKU9emM
 6WE9yDbxsGVGCtq8JnAOn1EAKcwyHb6pudJzx+teeOl26Y2qYPISd+T+OM2pAj/IIG/F
 B3SNwZ3vqpaLunWG/vTEx+btopJfmUa6Ubr7WsVkhVUzF6pSEHmOgIT4eWIJu78Mx19r
 3uHA==
X-Gm-Message-State: AC+VfDzGlV923b0qQB+U/o3dVzL6dnFA/wcjd4BDiZPGD3LC+aAYXJCF
 Z5CbykdTHrsraB/JCxezhMt/+YbwE/5ej+8pB9A=
X-Google-Smtp-Source: ACHHUZ7NvL60hANmfPQ4YxSiuDHpMI3ba0EZ5Y3xrJNgZLaBByrGBuTkFKiXaLhM2JMZ4gy+jSkRgw==
X-Received: by 2002:a05:6a00:2d26:b0:63f:2f00:c6d with SMTP id
 fa38-20020a056a002d2600b0063f2f000c6dmr20201600pfb.2.1684850223702; 
 Tue, 23 May 2023 06:57:03 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 v11-20020a62a50b000000b0063799398eaesm5805790pfm.51.2023.05.23.06.57.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:57:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 49/52] plugins: Move plugin_insn_append to translator.c
Date: Tue, 23 May 2023 06:53:19 -0700
Message-Id: <20230523135322.678948-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523135322.678948-1-richard.henderson@linaro.org>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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


