Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC047B2605
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 21:42:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlwth-0007vD-BY; Thu, 28 Sep 2023 15:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qlwtf-0007u8-6z
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 15:42:03 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qlwtd-0007xA-Cp
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 15:42:02 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c7373cff01so8387035ad.1
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 12:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695930120; x=1696534920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ytGH6JE+ydbRM4358s66cugltU3Ll2YBV5fZ6EN4mvI=;
 b=cOXsYquntGSuWYRIER0dO1tukNE4WgcsDV+B7wnkd95r3444QZTMYqoBX7bJA9cS+k
 OjmNFXVO38G+dt0//w6UbhpYYifwgVfnkuTPPOXCao9AM6REOS88m17/iQvWPL4TbXdy
 0tqHqECBKOIQZpFdCfsbIcSKYxPbKLnbiUjtCqpO5wXZ6riO3oMqitkNXO1h0mxEigTF
 Hjwxa1CRh/yk/Sc3NuvC+p/ssS1XsaPmxiBzGbNkIeQw+iDCVIgmwy9CQ7v2r1UNoQDr
 qe+uzEZ5vYO6bZG8TOgwdKQUY8Ukg1v8rX9+aOhI4V8pOsYmnQMHm6s9PPAeiBqoSeCG
 WkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695930120; x=1696534920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ytGH6JE+ydbRM4358s66cugltU3Ll2YBV5fZ6EN4mvI=;
 b=k8Shncawt1k1MHF3RWbtFX3owi7ep1mYaaVZgI7YEjizTJKMATinIc2dXnAXxiZ+3J
 dmm7cVgfRzb9BqD4gTRFTg22dvtr682TD4buF4jeeU0tSo/tq0io0O/h4sMQypM5yIeq
 FXTkOr555CmBoifJ45ByxfWNcuI4ZtRBd0ItpGoArV1h4QEpjkA4kZOFdzt0sSzhrfWv
 cZWf6LI08yFCvsiQ59t2Iu7IhvaknRQvLHIndxj/ZvTq3fTK8bjQ2Cmo16vIQNyfNaIq
 LGdzqYooDI2L4GfDd4clIGFPJtBhXRleUavwdx8lxCQpUmpFfYNYlKgyU9mofhJbCbGI
 SXDg==
X-Gm-Message-State: AOJu0YwFiX6HkU0nlP0NDdFJFbJozZo8tF7fSSQ+jmb4A5xCd5daUN5j
 FTsbHI6chQLg9cAHUh/Ou82upFJe98peBup/XkY=
X-Google-Smtp-Source: AGHT+IHpcUnZboLNERVX7ZGYu5YoOmQnCb52f7Pves3ocIKUEhPFPDZJFjJlFciJrRM8YrZsOUDVHA==
X-Received: by 2002:a17:902:dad2:b0:1c7:2e8f:c3b5 with SMTP id
 q18-20020a170902dad200b001c72e8fc3b5mr3380815plx.20.1695930120071; 
 Thu, 28 Sep 2023 12:42:00 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 x23-20020a170902821700b001b80d399730sm15273450pln.242.2023.09.28.12.41.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Sep 2023 12:41:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 2/6] accel/tcg: Hoist CF_MEMI_ONLY check outside translation
 loop
Date: Thu, 28 Sep 2023 12:41:52 -0700
Message-Id: <20230928194156.237351-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928194156.237351-1-richard.henderson@linaro.org>
References: <20230928194156.237351-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

The condition checked is loop invariant; check it only once.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translator.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index a3983019a5..b6ab9f3d33 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -158,7 +158,13 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     ops->tb_start(db, cpu);
     tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
 
-    plugin_enabled = plugin_gen_tb_start(cpu, db, cflags & CF_MEMI_ONLY);
+    if (cflags & CF_MEMI_ONLY) {
+        /* We should only see CF_MEMI_ONLY for io_recompile. */
+        assert(cflags & CF_LAST_IO);
+        plugin_enabled = plugin_gen_tb_start(cpu, db, true);
+    } else {
+        plugin_enabled = plugin_gen_tb_start(cpu, db, false);
+    }
 
     while (true) {
         *max_insns = ++db->num_insns;
@@ -176,12 +182,8 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
         if (db->num_insns == db->max_insns && (cflags & CF_LAST_IO)) {
             /* Accept I/O on the last instruction.  */
             gen_io_start();
-            ops->translate_insn(db, cpu);
-        } else {
-            /* we should only see CF_MEMI_ONLY for io_recompile */
-            tcg_debug_assert(!(cflags & CF_MEMI_ONLY));
-            ops->translate_insn(db, cpu);
         }
+        ops->translate_insn(db, cpu);
 
         /*
          * We can't instrument after instructions that change control
-- 
2.34.1


