Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70478723135
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:24:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6GgJ-0007Cs-C2; Mon, 05 Jun 2023 16:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gfw-0006v2-Qz
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:19:37 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gfs-0005ls-GA
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:19:34 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-652d1d3e040so2529715b3a.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996371; x=1688588371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GIcDEqUeirfwvFOcbTVpqxhfnFcXIKTiky9PUX69mio=;
 b=AjER9FBZQHjJvZCvKOsV/AcEDbenij+L47ht4Oqew48lCIJoRtfQtZinfzDUVNXpHB
 z4Dx1K+WBqplEylEMcaqh3k2kQiJHqS+23yoHpj8JPMFezfCLcK6MiCfa0HO56AHy31O
 jlSUrenAQmQtrR6zbr4/d4/CsWjMu4KIvPVG7xxfaAUU2z0oAVkKgqJhvp76d6tA9YCD
 I486fdSjpkFAInmYG+OYK4nRExb1f7acqdtFimYfu6DU35gq56ixclapldrcxnH3VV+6
 y2qFHLhDLicMe4qzGY1TEb5IVF33CngKhv25CNMDpIG2Yex73u8jpbT8H+qEBbL42PXy
 jjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996371; x=1688588371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GIcDEqUeirfwvFOcbTVpqxhfnFcXIKTiky9PUX69mio=;
 b=fvz7NAMRltfP7Fs7jZriZMQV62jHlFMAHv4PdKo8vdTPIB1N5IJZNgaA7AN3udzyGB
 x3v/FYKAn00EPP8XcgIojsW9c7f3pUR9hh+b3byV/fLmVHWzvLdZ3K6DO3RWFBeecfJf
 dvSlczmxwpQKnPzVP03LAtASgsPlgjdLeLXim60+xrPzUthMW0v8Tl3MCeNtnyv+VnSg
 Z/sIwJ/ei8tMsUkT4NKP07BiRliXkWPZVA6REGeSrgLbdOipiaogv9D1OI0ayZuV+0sN
 3VvT37Vg899VCkvKSMG+uRmXDV8HE2UY/JcczWjgDljJLSkJmSW5axjE342h0C9zLgL4
 kqHw==
X-Gm-Message-State: AC+VfDziIpTVrejUpKnDc3e4waJv1yloZnL2Woh9ji7SxTQK/Cul6Q4L
 K8BVTulfDPrJCQ2/oN9o4joEwnUXRyFgoI/NHfI=
X-Google-Smtp-Source: ACHHUZ7KyS3Ib1rWnoJBDDo0hcCPR+HIs9JFdILiYw6I4ksfgYn2UKYdSpfpvMqDaGSUJM7/lIrlfQ==
X-Received: by 2002:a05:6a20:94cb:b0:103:73a6:5cc1 with SMTP id
 ht11-20020a056a2094cb00b0010373a65cc1mr189656pzb.4.1685996370839; 
 Mon, 05 Jun 2023 13:19:30 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 w20-20020a170902c79400b001a980a23802sm7018184pla.111.2023.06.05.13.19.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:19:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 47/52] plugins: Move plugin_insn_append to translator.c
Date: Mon,  5 Jun 2023 13:15:43 -0700
Message-Id: <20230605201548.1596865-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
target-specific typedef: abi_ptr.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


