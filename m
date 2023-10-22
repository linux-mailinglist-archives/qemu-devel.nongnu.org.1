Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B09927D2150
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:07:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRW3-0000VT-GO; Sun, 22 Oct 2023 02:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRW1-0000UI-Kq
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:00:45 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRVz-0001Wh-7s
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:00:45 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6be840283ceso1740394b3a.3
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954441; x=1698559241; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vNn7jVogYLYvnKzq1R44V4cOiOcSGXgz1/4pjUiWR3E=;
 b=zpYh/Dy9C0U4Sjxld20/Pul5bf3vFbZvvJhjHBlxr7OnhxCmqQmXsgTorGzt3+d9/F
 3VLlotZa6awYI2tulF3rSaEEvmPza4KOzX7eyRAy7j7jUM76g/1qYR8yaQd5/OR38xt8
 rnJgYepIbo6Q8zsqIlnByYCPYnxwCrXeYNCDRS3/Cf4p1mJu3CVep8SoRhrUfeBfA90n
 Kl/f07CKITpdwTx+seKgdFuutWn/HhZPVZQnoLr2M5WoLMWVt4BYNEWwvss2BlQVQmTp
 43jzuZ8JAYuvPJqf2MVdzU40cpctSTuc0AuE4t3HsQV2LKxSpAs4gfg19XASChjthkGb
 wyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954441; x=1698559241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vNn7jVogYLYvnKzq1R44V4cOiOcSGXgz1/4pjUiWR3E=;
 b=RucspMMg/bjDHPPnPMB4YkY8UAxwSrzBj9EY4kyApIdYRl7Cnflk/qAtLmA65krPON
 j3FBs95Exnl+h3hy5VSgcuIcM+yal6ldBre4gz6w7+1hHePD8qNo/to0SrlUl/RBarm7
 R8EoTeiYwpBg12v4NApmnIzMIqSM0xmRimdLGu8iJp9fFQwHTLP4S4VT5vCLi5+khb5Y
 frZlB1ef96PnpybEpgrdvp/jY0+M+hKqWS6WrnEfIWYx5oJUBmIGM9iqCipKAUK6CtZZ
 z8+ZJmpMq5cdSlbUpf3pxdkdf5ikEB2lKlsTLAWFyApe1I2KhKXq+/mqrZPYOdb9t5D2
 NjVQ==
X-Gm-Message-State: AOJu0YwXNQxfyT2sqsvSpSEpmTmpVYkMlmzeOZBZR+TmY6+OMSVL3on+
 sbZGjKB9TFGbsU+/2f6TWVDMTEUAYCmN99Zwg7Q=
X-Google-Smtp-Source: AGHT+IGdGD7ALuFgyyrsEtjmHCOxmTavMkB4gSkB59+bp24mVzocMMqUQdZ2CjmuHPefuIU6VZ4kTg==
X-Received: by 2002:a05:6a21:a5aa:b0:14c:c393:6af with SMTP id
 gd42-20020a056a21a5aa00b0014cc39306afmr5267383pzc.0.1697954441527; 
 Sat, 21 Oct 2023 23:00:41 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 je17-20020a170903265100b001c728609574sm3999887plb.6.2023.10.21.23.00.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:00:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 10/90] target/sparc: Define AM_CHECK for sparc32
Date: Sat, 21 Oct 2023 22:59:11 -0700
Message-Id: <20231022060031.490251-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Define as false, which allows some ifdef removal.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 080bc5f8a2..9eb2b7e52f 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -268,20 +268,21 @@ static void gen_move_Q(DisasContext *dc, unsigned int rd, unsigned int rs)
 #endif
 #endif
 
-#ifdef TARGET_SPARC64
-#ifndef TARGET_ABI32
-#define AM_CHECK(dc) ((dc)->address_mask_32bit)
+#if !defined(TARGET_SPARC64)
+# define AM_CHECK(dc)  false
+#elif defined(TARGET_ABI32)
+# define AM_CHECK(dc)  true
+#elif defined(CONFIG_USER_ONLY)
+# define AM_CHECK(dc)  false
 #else
-#define AM_CHECK(dc) (1)
-#endif
+# define AM_CHECK(dc)  ((dc)->address_mask_32bit)
 #endif
 
 static void gen_address_mask(DisasContext *dc, TCGv addr)
 {
-#ifdef TARGET_SPARC64
-    if (AM_CHECK(dc))
+    if (AM_CHECK(dc)) {
         tcg_gen_andi_tl(addr, addr, 0xffffffffULL);
-#endif
+    }
 }
 
 static TCGv gen_load_gpr(DisasContext *dc, int reg)
@@ -1366,11 +1367,9 @@ static void do_branch(DisasContext *dc, int32_t offset, uint32_t insn, int cc)
     unsigned int cond = GET_FIELD(insn, 3, 6), a = (insn & (1 << 29));
     target_ulong target = dc->pc + offset;
 
-#ifdef TARGET_SPARC64
     if (unlikely(AM_CHECK(dc))) {
         target &= 0xffffffffULL;
     }
-#endif
     if (cond == 0x0) {
         /* unconditional not taken */
         if (a) {
@@ -1406,11 +1405,9 @@ static void do_fbranch(DisasContext *dc, int32_t offset, uint32_t insn, int cc)
     unsigned int cond = GET_FIELD(insn, 3, 6), a = (insn & (1 << 29));
     target_ulong target = dc->pc + offset;
 
-#ifdef TARGET_SPARC64
     if (unlikely(AM_CHECK(dc))) {
         target &= 0xffffffffULL;
     }
-#endif
     if (cond == 0x0) {
         /* unconditional not taken */
         if (a) {
-- 
2.34.1


