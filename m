Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4885F72315C
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:28:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Gd0-0001z5-Ig; Mon, 05 Jun 2023 16:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gck-0001vD-65
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:18 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gcg-00041B-HC
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:17 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-64d44b198baso3830868b3a.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996173; x=1688588173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H+UrwJ0Uc9kZfK3DxO9f4YdqZ7tw2V2PPN3Y5ahvr5k=;
 b=k6CDihM83jniika2t/cbIrG5vq9fFnpj1kt1/RSTm37U8gkYEGwfu1W6cBWUe54Ku/
 az2ksGqImtF0RlA0NsYLQBZ9o8ceFrkTREsVKxHMauvRmE/6JpCakDyidw32vsVuaqHI
 /tCWcDK+BWnE0YAHxTw7kuAYunC3poJwcrS3wGvY7wUxiGQY5l0N6bYhyj5NbIrViLxC
 BIqb33tzmJ9kY0OXFfynjjvNGFOvrDn4dkM9nkKo6GikIdZA1A7l3eJSSLELKb1pevZ+
 QsDje79JYa0uI9OhMuQe0oaHuca5cdVEoTfRpnDUpVSLiSIpq26t1D94YcvYazjgJKx6
 v//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996173; x=1688588173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H+UrwJ0Uc9kZfK3DxO9f4YdqZ7tw2V2PPN3Y5ahvr5k=;
 b=OMlTbK85egvJpEg6EsRuWJ7FkjEZKXEZ0/G8HUxAH+De4PrGoXgAcGil0yW6riD5c+
 kcpCY27GEXw3mWo5kUNfuxciuCVbOBH60mKyDwd8ZhbV8YA9FWbK1sY15e3tY9pgyOi+
 qpAPYiGrMgesdmDSY3b/f4TxvSQvy5vjF9apkpky12WFX/44kT5U3j5t+3gbpvsdsSMD
 Ch+u5nVZA3fj/fDJ6suQ250/1g2q1mUJ0rNQ3ie9jwQ4FXrj5CHj2HuQoosASNTI1xJU
 3Aq/VyPOSK7yJdIOgaHu0xp0/uFvWslSdpc0eY7NLc+hmJM5jHvX6DstZqIMNzaGToKd
 qotA==
X-Gm-Message-State: AC+VfDzCZNjQN0fB93uTH4Ds9AHGKuqaE6ApDyNS3t32V1vhi66j+nhk
 /ugQk3Qp6D+JvhIQk7K4zFRdak3pE8ElJGby2uM=
X-Google-Smtp-Source: ACHHUZ5IaSAvPoY1ivN6k1zHWHU5enzF/0q/rBBHbauo+MrwAd5GK5S9Rj/JyODvKb+B2UBM7BJZdQ==
X-Received: by 2002:a05:6a00:139c:b0:63b:54e4:871b with SMTP id
 t28-20020a056a00139c00b0063b54e4871bmr107140pfg.8.1685996173315; 
 Mon, 05 Jun 2023 13:16:13 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 f18-20020aa78b12000000b0064d32771fa8sm5552924pfd.134.2023.06.05.13.16.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:16:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 27/52] tcg: Add guest_mo to TCGContext
Date: Mon,  5 Jun 2023 13:15:23 -0700
Message-Id: <20230605201548.1596865-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

This replaces of TCG_GUEST_DEFAULT_MO in tcg-op-ldst.c.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h         | 1 +
 accel/tcg/translate-all.c | 5 +++++
 tcg/tcg-op-ldst.c         | 4 +---
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 813c733910..9f607e2664 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -521,6 +521,7 @@ struct TCGContext {
     uint8_t tlb_dyn_max_bits;
 #endif
     uint8_t insn_start_words;
+    TCGBar guest_mo;
 
     TCGRegSet reserved_regs;
     intptr_t current_frame_offset;
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 67b838e16b..200de2793c 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -364,6 +364,11 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
         (int)offsetof(ArchCPU, neg.tlb.f) - (int)offsetof(ArchCPU, env);
 #endif
     tcg_ctx->insn_start_words = TARGET_INSN_START_WORDS;
+#ifdef TCG_GUEST_DEFAULT_MO
+    tcg_ctx->guest_mo = TCG_GUEST_DEFAULT_MO;
+#else
+    tcg_ctx->guest_mo = TCG_MO_ALL;
+#endif
 
  tb_overflow:
 
diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 3c00bf0c95..9bcf63b041 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -104,9 +104,7 @@ static void gen_ldst_i64(TCGOpcode opc, TCGv_i64 v, TCGTemp *addr, MemOpIdx oi)
 
 static void tcg_gen_req_mo(TCGBar type)
 {
-#ifdef TCG_GUEST_DEFAULT_MO
-    type &= TCG_GUEST_DEFAULT_MO;
-#endif
+    type &= tcg_ctx->guest_mo;
     type &= ~TCG_TARGET_DEFAULT_MO;
     if (type) {
         tcg_gen_mb(type | TCG_BAR_SC);
-- 
2.34.1


