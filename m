Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 400577CBAC8
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:18:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdK7-00006P-Vr; Tue, 17 Oct 2023 02:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdK5-0008QI-90
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:12:57 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdK3-0003qj-IK
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:12:56 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5aaebfac4b0so2199007a12.2
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523174; x=1698127974; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vNn7jVogYLYvnKzq1R44V4cOiOcSGXgz1/4pjUiWR3E=;
 b=gL3JXWF1uV1wWdKFi1UVNfDTgvgticQm+4TDpZjBoHgBK2qhYMQNDhT0w5DTjNAADs
 7sz5nPdnjty1KlgZsexwzoa+XpTe0FQQTfv8MGqt4dNnAVD5BJnHy5JD8vuQdX+IR/P7
 t5kjOWvua0xytE3qWPFh4FjOVWA4K0on1Y5IcizGzU0KQ4aRxs7lnDnfSzSHDj7TvPRk
 kIMrInKISDfGsIoOPitVp2yEzvkKClM/7dAnTmMbKFitiwcLp4bGucaUuFfj5wQotGcX
 oHunYJsJ7EgdKG2/43oM3RKoarDbwyMfLoQqDIQrOoeSvo9T9YWm0e45NHpCkKRW1jmr
 auVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523174; x=1698127974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vNn7jVogYLYvnKzq1R44V4cOiOcSGXgz1/4pjUiWR3E=;
 b=ZssrrJDTx6dtZ5FuCiQEEL938iBTBz6noPNFaAtezRGHGLTPWCp6GHqHSotqM5zOFW
 M+lJM2y7Jx6nr0dek91QYcRXYPquZ07KR2lS3rr98TKSaP2/kIOa8jq5hTjP5TczSE2Y
 zG44JOGnigQCs1pT401wm2078PlEyl9U+zGGyjoCpfJ1F5ReHgUvtFvefqHwRFN7JceU
 PmzQXuc2gMm7ZH2JJ51odORXl9KyscjGz0Dl5gv3BYFxQgWuWZR5gmneo19CVekjrFT/
 ijDijqUAN+JQjiIu+S2KvLZfXkw0uO3pwz7prAIQrJR1LZccWtMFgsuZlK1IslhBwwR5
 Thmg==
X-Gm-Message-State: AOJu0YzdXnXYMGQdhOJs8VM8W174EDBEe1qyumRV1Vew8hw4gazg3a1W
 u11GxgiCHwtga6ENqkHY6pv/hSmUsqq9IyEEZdg=
X-Google-Smtp-Source: AGHT+IFtSum7RN7FNx5cv19+4dnU2I6CDHKwpPhjxSo+1CK1SKnpUYzjZlFzKAzBWoUqEIRQoC31+w==
X-Received: by 2002:a05:6a21:7802:b0:16b:f3b1:c045 with SMTP id
 be2-20020a056a21780200b0016bf3b1c045mr1134522pzc.23.1697523174274; 
 Mon, 16 Oct 2023 23:12:54 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf4-20020a170903268400b001ca21e05c69sm629150plb.109.2023.10.16.23.12.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:12:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 10/90] target/sparc: Define AM_CHECK for sparc32
Date: Mon, 16 Oct 2023 23:11:24 -0700
Message-Id: <20231017061244.681584-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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


