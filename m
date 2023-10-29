Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF417DAE73
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 22:11:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxD1q-0002g6-Se; Sun, 29 Oct 2023 17:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxD1n-0002f6-1M
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 17:08:59 -0400
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxD1k-0005Do-5q
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 17:08:58 -0400
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-357f59f76e6so13431265ab.0
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 14:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698613733; x=1699218533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rBNU5zatbfNZ+9sFWvaKxmcKtFnGExknbp1MC3+RSvA=;
 b=as5HsRu4xiaucKfwWMXdLf151RSqo1yS2JCf/CIhPmOkRKgxNkk8qC9jlGKJGuzU09
 +L/dA6V4FplEAVaBRL68MsWrD4dS/CLh1jFjvqm3MKbk+P3Z8Jj4UWAy1BWirclxoJmO
 WWAHyB64m9dIFk41dtXv59qE8K8PQKhj9YsvMhldhEFBX4ESbGGIHCi5D9334m6R0Cji
 F7jW8dzueabxqCjTj+qv5N6CI27h+trXmiPuK4p1+eK+qF3394Mmf22IvY0qQPVv0vDq
 YpREnoqV9W4HDepYZx0LoQHSXs1aMRczLuUNb3JlW4VFvuhIj/5ehkPTpt4NpOm1HOLj
 Av6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698613733; x=1699218533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rBNU5zatbfNZ+9sFWvaKxmcKtFnGExknbp1MC3+RSvA=;
 b=R9KDJ7y1oAEe4LG8yX9jX6Q80stBccye12d7ZvSwWaXtA3O6x7494nNw6CNHVW903X
 RBJf4/qs7CxYjdBe8jVhCvZRg6QsbTUTz7jNXcmZWnB64Lu8JAL+znd63Yo1aUxI8XUG
 e0/TGDGSy0qtGaGLDvsoJ29mlm2RyVJtoH2Q+ZJYKgv4giHT234UNfJ18yw3gjNdWZy5
 Tut/pQx6gXKWwJZ3Nua0fPwYmVGqHaRxJbdfA5zv26zXYxHDZ9X29wuAKcbLdJFMQFBE
 5Fnw2d/Gc0xCrm9KxpWA3eLZiMn6Zvmzoc2S64f72t+wT83xPleTmzhZeaJaJJPgwpku
 YRIA==
X-Gm-Message-State: AOJu0YxqOsnluW38yf7li7zFxh0f5Pn/BTRkBBrwNjPPqKfaLEZPHWAu
 Yp6Q6ZmTJVRQ/VrjIpxQckMDFqXVtq9H6io5UfM=
X-Google-Smtp-Source: AGHT+IHiHSo3Dnb6YzeNc2nuxuZQrb59ApsW0m2udv4x+ffN8jTU+tOQCxV39sob0+AnpYdCeziwRw==
X-Received: by 2002:a05:6e02:1be7:b0:357:7cca:418d with SMTP id
 y7-20020a056e021be700b003577cca418dmr12814784ilv.14.1698613733071; 
 Sun, 29 Oct 2023 14:08:53 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 z11-20020aa785cb000000b006c0685422e0sm4622847pfn.214.2023.10.29.14.08.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Oct 2023 14:08:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/11] tcg: Move generic expanders out of line
Date: Sun, 29 Oct 2023 14:08:40 -0700
Message-Id: <20231029210848.78234-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231029210848.78234-1-richard.henderson@linaro.org>
References: <20231029210848.78234-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::134;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x134.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h | 19 +++----------------
 tcg/tcg-op.c                | 16 ++++++++++++++++
 2 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index e093f541a7..2134961a98 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -72,12 +72,7 @@ void tcg_gen_op6ii_i64(TCGOpcode, TCGv_i64, TCGv_i64, TCGv_i64,
 
 /* Generic ops.  */
 
-static inline void gen_set_label(TCGLabel *l)
-{
-    l->present = 1;
-    tcg_gen_op1(INDEX_op_set_label, label_arg(l));
-}
-
+void gen_set_label(TCGLabel *l);
 void tcg_gen_br(TCGLabel *l);
 void tcg_gen_mb(TCGBar);
 
@@ -121,16 +116,8 @@ void tcg_gen_goto_tb(unsigned idx);
  */
 void tcg_gen_lookup_and_goto_ptr(void);
 
-static inline void tcg_gen_plugin_cb_start(unsigned from, unsigned type,
-                                           unsigned wr)
-{
-    tcg_gen_op3(INDEX_op_plugin_cb_start, from, type, wr);
-}
-
-static inline void tcg_gen_plugin_cb_end(void)
-{
-    tcg_emit_op(INDEX_op_plugin_cb_end, 0);
-}
+void tcg_gen_plugin_cb_start(unsigned from, unsigned type, unsigned wr);
+void tcg_gen_plugin_cb_end(void);
 
 /* 32 bit ops */
 
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 6c826b46b0..a8cbad212d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -300,6 +300,12 @@ void DNI tcg_gen_op6ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
 
 /* Generic ops.  */
 
+void gen_set_label(TCGLabel *l)
+{
+    l->present = 1;
+    tcg_gen_op1(INDEX_op_set_label, label_arg(l));
+}
+
 static void add_last_as_label_use(TCGLabel *l)
 {
     TCGLabelUse *u = tcg_malloc(sizeof(TCGLabelUse));
@@ -333,6 +339,16 @@ void tcg_gen_mb(TCGBar mb_type)
     }
 }
 
+void tcg_gen_plugin_cb_start(unsigned from, unsigned type, unsigned wr)
+{
+    tcg_gen_op3(INDEX_op_plugin_cb_start, from, type, wr);
+}
+
+void tcg_gen_plugin_cb_end(void)
+{
+    tcg_emit_op(INDEX_op_plugin_cb_end, 0);
+}
+
 /* 32 bit ops */
 
 void tcg_gen_movi_i32(TCGv_i32 ret, int32_t arg)
-- 
2.34.1


