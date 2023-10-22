Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C32E07D270A
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:33:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhtO-00077j-KP; Sun, 22 Oct 2023 19:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhtC-00075g-QR
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:29:46 -0400
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhtA-0006j0-Pi
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:29:46 -0400
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-35748b32d73so11004855ab.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017383; x=1698622183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zhJv02LeNSNRi9K7QfhBZ5XwbuSGXoIYziudXEjPl7w=;
 b=TNM3lJmGF/wL7qMstIDO7do5Q2NdIec9S/R8tX7aSGcraRdcVUm5BczmEc8nTVo/4V
 j2d8Pi5ONtwtmpaeHm4KuXEzTWO8KHn9eYnBZKwOSw9DKYo3kncWm5KUHJBAcNu0c3Qq
 E0exdh472fDrp4nEIwPiUtNFULck5+c/A6b0L5SEl2nrr4iI5lpFJYp0Oduw5dr238ih
 BB3V3MeQJwLDOT2JPRLvfusFOKhv57bdkXjTJrylic6tsRHwpfDNRfEIi6lq5V/X3yYF
 /UgSq5GG0amL++I7vW/12l4JkDYDGNGyLVBoffIWMNF1YDYM6hNpx+nc9jhbIYSONjYE
 ziBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017383; x=1698622183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zhJv02LeNSNRi9K7QfhBZ5XwbuSGXoIYziudXEjPl7w=;
 b=MfJDjcm0EvI3q8Ea83c5NsAHMHAYX8tgokihX8tu/NeFZlmDNKgrNh9uArUveUKqzz
 Mby+QgAT7yw+XpV8TacuZFmQ/TSV3sW+gqfpEsvtF+ETY6v7EecvKUu3YU606JIpdkUc
 baO+FC6D+sHPgZgRp+GVazwEg9ftVG8h6mMiG0iW3GT1FxmG0/OZ6uGYrJLVGFctzO6z
 ipDEwo6ShimCIKCSuMJPgiGmX5qVREmHlSTHyncg5TYTBrxktFKXfZhrN48W01XSpO0c
 pP00Iw2uGiMgcZnU12yN8ORGmccrUyARApnH/3/X0GtMhtbzBlGBYFOxFMqFDyNIojGz
 yi9A==
X-Gm-Message-State: AOJu0YwoIrdqlQbusI2hZ0QxYrugKOESiwzml/xQHh1B/0NeMmp6vnBC
 qA9hdMnuGYQrf4tomEPWzR5E7gzqDcDzRgfoEoo=
X-Google-Smtp-Source: AGHT+IG9VuhSVtlEhHkmOoxx7dp1fYTpsZqaHPq/DF15FugaLKXGYowpqU4ERNe/1K6e3cYMxHTj4w==
X-Received: by 2002:a92:d691:0:b0:357:71f2:bbb7 with SMTP id
 p17-20020a92d691000000b0035771f2bbb7mr8183698iln.21.1698017383720; 
 Sun, 22 Oct 2023 16:29:43 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k26-20020a63ba1a000000b005b25a04cf8bsm4023772pgf.12.2023.10.22.16.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:29:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 11/94] target/sparc: Define AM_CHECK for sparc32
Date: Sun, 22 Oct 2023 16:28:09 -0700
Message-Id: <20231022232932.80507-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12f;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12f.google.com
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

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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


