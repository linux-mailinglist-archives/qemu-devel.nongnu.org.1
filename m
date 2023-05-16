Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 125F9705804
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:54:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0eO-0002mb-2Q; Tue, 16 May 2023 15:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0cI-0000Lm-ED
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:52 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0cC-0003kg-32
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:48 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-64ab2a37812so8129768b3a.1
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266339; x=1686858339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4fVGxJLZnm/9x1zczI0K5yPA644Oq34wOtBnW72R26I=;
 b=BPCrYin+SEGQkYn+HsOVDVVfjGfmjuVns6WVGhROOvX8bruyLMAAVLpwYd5ev2veZZ
 XsXdvh5L6Dg8Aws5JX0E8TWXKyEzlziUEKr6wCWzFW/9e6im4Jh3IOPbvgPUpN+KUB/G
 dNpTCRT3vECSvXKI93sGwURUcjCDN7HcOzKc+ZRm5UnyC70Q1r/qXQpViQQeAlCrO/GK
 iDzcY4HhWSmDMo1bmcAMywXYBtn/HgICcPvzv+RVCwJhgbsoB+2yoIn+U7pogtGefpUB
 i8YofOGQwQ42lG76k2yU0hDtw7GL46SHr/1955WXIrl0rv21uKDiigmyO/tgMBJYFVmi
 6i6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266339; x=1686858339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4fVGxJLZnm/9x1zczI0K5yPA644Oq34wOtBnW72R26I=;
 b=I87uvfQYDhU5/Y1kkmsw6GA8V+r3368Y/8DWhcnyHILHJGPWPgSEdYQCBKcCU4xjHI
 FrN1Md/XfotlmzwlPwSnqAh6wHPOIUSj0re4EZr/fAWjL1m2zhRAxD6GHlBgaSXSrgY9
 0R1fo4DQuQJ6FvKSsZw6s2Tib3r6bx8IzhZY0XxkihT8lCJcN+zkiVuXgffpJxyI9FSy
 +ha+GZuwPUs1g8Xv07Df7tr8eXBQmjjRDF159uq9N9PAhWGxAJW3Jq9Fq/scOQRs6mTV
 ekOTwz1tvHA74V31lNkEG6kVE6LwcLF5UUs7xEzYMnFyr2mfcyVgbq7oytAjfeM252CL
 fgOw==
X-Gm-Message-State: AC+VfDzK63dP9rD/PnHhuHEorIxlmJX0cPF/f+4X7w99Tys0rfYUNClG
 JDkXE19i481GPpnDdMzf/1VzRj2l54EJGncfVis=
X-Google-Smtp-Source: ACHHUZ4UiOG8CqpXK/funEY/CqZZDzBuZziY/cXyBR7P5N6JbSoCgYYlfAtvxg49A30etlFpbWPaTQ==
X-Received: by 2002:a17:903:1208:b0:1aa:d235:6dd4 with SMTP id
 l8-20020a170903120800b001aad2356dd4mr50774163plh.19.1684266339710; 
 Tue, 16 May 2023 12:45:39 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a17090abd0c00b002508d73f4e8sm25555pjr.57.2023.05.16.12.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:45:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 59/80] accel/tcg: Merge gen_mem_wrapped with
 plugin_gen_empty_mem_callback
Date: Tue, 16 May 2023 12:41:24 -0700
Message-Id: <20230516194145.1749305-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

As gen_mem_wrapped is only used in plugin_gen_empty_mem_callback,
we can avoid the curiosity of union mem_gen_fn by inlining it.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/plugin-gen.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 5efb8db258..04facd6305 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -202,35 +202,17 @@ static void plugin_gen_empty_callback(enum plugin_gen_from from)
     }
 }
 
-union mem_gen_fn {
-    void (*mem_fn)(TCGv, uint32_t);
-    void (*inline_fn)(void);
-};
-
-static void gen_mem_wrapped(enum plugin_gen_cb type,
-                            const union mem_gen_fn *f, TCGv addr,
-                            uint32_t info, bool is_mem)
+void plugin_gen_empty_mem_callback(TCGv addr, uint32_t info)
 {
     enum qemu_plugin_mem_rw rw = get_plugin_meminfo_rw(info);
 
-    gen_plugin_cb_start(PLUGIN_GEN_FROM_MEM, type, rw);
-    if (is_mem) {
-        f->mem_fn(addr, info);
-    } else {
-        f->inline_fn();
-    }
+    gen_plugin_cb_start(PLUGIN_GEN_FROM_MEM, PLUGIN_GEN_CB_MEM, rw);
+    gen_empty_mem_cb(addr, info);
     tcg_gen_plugin_cb_end();
-}
 
-void plugin_gen_empty_mem_callback(TCGv addr, uint32_t info)
-{
-    union mem_gen_fn fn;
-
-    fn.mem_fn = gen_empty_mem_cb;
-    gen_mem_wrapped(PLUGIN_GEN_CB_MEM, &fn, addr, info, true);
-
-    fn.inline_fn = gen_empty_inline_cb;
-    gen_mem_wrapped(PLUGIN_GEN_CB_INLINE, &fn, 0, info, false);
+    gen_plugin_cb_start(PLUGIN_GEN_FROM_MEM, PLUGIN_GEN_CB_INLINE, rw);
+    gen_empty_inline_cb();
+    tcg_gen_plugin_cb_end();
 }
 
 static TCGOp *find_op(TCGOp *op, TCGOpcode opc)
-- 
2.34.1


