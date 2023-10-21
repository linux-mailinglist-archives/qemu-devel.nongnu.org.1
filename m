Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A9C7D1B0B
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:41:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4as-000792-P9; Sat, 21 Oct 2023 01:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4ap-00077a-Hu
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:11 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4an-0008MS-L2
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:10 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6be840283ceso1340270b3a.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866328; x=1698471128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vNn7jVogYLYvnKzq1R44V4cOiOcSGXgz1/4pjUiWR3E=;
 b=uskYM7bQHYsPX5xXV592Hqtrcs7inHZdqs8Y6BLLEHmkGX3yAjhCV2Vj47uDyyOHKN
 tBdXkYsrBElH/Cz1rpu6sI+zP/AfO4OhMWXG51Zi3WLEo05B3jIGJ6TN/ETMCcDKGkTb
 uO2U61Q5wC+S1d9+Cb8X6aq/bgkwu/eke/0/Mysu4VHMl7mmutNFSs0Y4FjANwPKdFbT
 pir/c/PE/kxzgy7IH8URA+AvqHaA+sTuIoj03s8UXCLUsNEPNoytGB90w4SI3GmTMZMD
 wtt9UaIU3e1RH2lCvejZKB7aoF9pzI0vMDLgg2BFp6nbJKO8xsjWZa6JNbwX9i6bqGnF
 MVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866328; x=1698471128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vNn7jVogYLYvnKzq1R44V4cOiOcSGXgz1/4pjUiWR3E=;
 b=V013ovxLxSXqfFcfKKD2fj7UXLdue5eDMtrYlz2jykeeXd/4zouWmTiWuAM3LMCrl5
 IYx5mB7XOYSfbVOJ0vJNNBSqY5lwEXtjUescfweQfo3iyCXUIZYzP8JmE1c/zR0f4lKF
 aEsc1NMj4YJ1j0y8XFKvDp1GE8NwsJwvb2ghFMmznXZuZurWUohLT5Ow+gIpet/y2GBq
 Xq9vIiNByl/1XxckO1azygMypXJPESIMGwMc9HUgGylzkxVrvB1M6uMl43+ard5hbRNx
 cd25mU4G47lEIsZSKZwVqoo0VzF2u914sg9qdgfvKZEoIGJcvBitFEnUPf98WtbyxX8i
 YNgg==
X-Gm-Message-State: AOJu0Yw6fL/v5oPYwX2NOjIWJMUJCuXRlTXkDoVgVeoOaVyV6B+88rjr
 N5Wp8+Rwja0l+xkq/MMo03aGqB35KuDDs42tbxQ=
X-Google-Smtp-Source: AGHT+IEcwKFkg6oiAGf28/byzlfifdx71/q2FNkFsmRamk6wJaFmpVvg4bcXMIgPbu76uXnc3nyl3w==
X-Received: by 2002:a05:6a00:a10:b0:6b7:b42f:e438 with SMTP id
 p16-20020a056a000a1000b006b7b42fe438mr3289912pfh.8.1697866328369; 
 Fri, 20 Oct 2023 22:32:08 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 f20-20020a056a001ad400b006b2677d3684sm2434831pfv.206.2023.10.20.22.32.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:32:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 10/90] target/sparc: Define AM_CHECK for sparc32
Date: Fri, 20 Oct 2023 22:30:38 -0700
Message-Id: <20231021053158.278135-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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


