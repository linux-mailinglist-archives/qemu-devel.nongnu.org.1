Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CEA7CEB35
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:28:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEzn-0008E6-Fy; Wed, 18 Oct 2023 18:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEzi-0008Cd-Si
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:26 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEzg-0002Wu-Ry
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:26 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1c0ecb9a075so51284725ad.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 15:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697667983; x=1698272783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i+3c/q3YHMTCq7WXcy5yo10z7tmQCbWln7ShYoiyjhk=;
 b=lL2j41WC81p7BdVmwpZb9bTmWMsxHzIovu9uQ3Wc68cnFVYdoCEjj2xb6FM4zM5CJ6
 PcNGCMAM2Piaox1q1nw3IseALeuHGXVMHizQU+f1USlCWLWFxhLrJ7FrpUNr4/zy2f8J
 tQ8Ts0tXANQdz2X5x77mWCEIimsz8/DTr9VEh1YO9VHAObcKmWLMKvbpYS7BQAOSwWRG
 OFhzTbqE/t3nriSAaSWv7yiwG+SAfYIIeVtaVrtLgJY1Myjj4RKKgbuHb9SDVWW6xGHo
 /h5KD5jabX8pHkc7Ak0v40jEdXdZsYMkCNjIYNEu2gGWjlnIOh+M3BKHD0cqnct+l6Hr
 ctBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697667983; x=1698272783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i+3c/q3YHMTCq7WXcy5yo10z7tmQCbWln7ShYoiyjhk=;
 b=gnrc5lFZSY5K+cv72Y6l5N3ujGVY66rgSS2Xr5XufUkYH6YcXBV0vv24OnJj4jSK/j
 rTQ9Q+Eft3gV2SjzQL82svhQULv5kepCMSFpagoX7QbJVilHS56gIyGWsRBQ9xVlDOP3
 kkakaHkjTJx24UFsN2bppDh5FZklksTID6XWcCIoQIgOOYW5Rg13+QdVrgnV2XdLKJNd
 Y90epTnlUpw5/9KK9ZonYxEojUulWb338NxRhVL/L9Ujc+nN8nCkQpXzV9vOyzYIAHNT
 OEtAS30M7aGNOUG+F5w4M5LpCXqcnxHkwSoX22lWSPQvj5AMLKrJl2jOq+sgv1xHfMhr
 jFMA==
X-Gm-Message-State: AOJu0Yy6jevPwjmDQ5NAmsU8hJd+EIqCXra7SP4Oc4jyhoj7ugc3/t87
 WHB8VsjRS3ASes9G3sL2ZuwEBHKi171DcLKzAe0=
X-Google-Smtp-Source: AGHT+IG6/aHbuZlW4w+aTI5xLmj2t6mqr6LPD6JM/SFFoQ3L/NYWauhz5JsP2CS1BYeWWH4+77CoCA==
X-Received: by 2002:a17:902:ce8a:b0:1c7:7b27:f9a9 with SMTP id
 f10-20020a170902ce8a00b001c77b27f9a9mr784385plg.59.1697667983472; 
 Wed, 18 Oct 2023 15:26:23 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a170902c24d00b001b9d95945afsm431058plg.155.2023.10.18.15.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 15:26:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 28/29] tcg: Add tcg_gen_{ld,st}_i128
Date: Wed, 18 Oct 2023 15:25:56 -0700
Message-Id: <20231018222557.1562065-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018222557.1562065-1-richard.henderson@linaro.org>
References: <20231018222557.1562065-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Do not require the translators to jump through concat and
extract of i64 in order to move values to and from env.

Tested-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h |  3 +++
 tcg/tcg-op.c                | 22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 2048f92b5e..56d4e9cb9f 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -747,6 +747,9 @@ void tcg_gen_mov_i128(TCGv_i128 dst, TCGv_i128 src);
 void tcg_gen_extr_i128_i64(TCGv_i64 lo, TCGv_i64 hi, TCGv_i128 arg);
 void tcg_gen_concat_i64_i128(TCGv_i128 ret, TCGv_i64 lo, TCGv_i64 hi);
 
+void tcg_gen_ld_i128(TCGv_i128 ret, TCGv_ptr base, tcg_target_long offset);
+void tcg_gen_st_i128(TCGv_i128 val, TCGv_ptr base, tcg_target_long offset);
+
 static inline void tcg_gen_concat32_i64(TCGv_i64 ret, TCGv_i64 lo, TCGv_i64 hi)
 {
     tcg_gen_deposit_i64(ret, lo, hi, 32, 32);
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index c29355b67b..b4dbb2f2ba 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2880,6 +2880,28 @@ void tcg_gen_mov_i128(TCGv_i128 dst, TCGv_i128 src)
     }
 }
 
+void tcg_gen_ld_i128(TCGv_i128 ret, TCGv_ptr base, tcg_target_long offset)
+{
+    if (HOST_BIG_ENDIAN) {
+        tcg_gen_ld_i64(TCGV128_HIGH(ret), base, offset);
+        tcg_gen_ld_i64(TCGV128_LOW(ret), base, offset + 8);
+    } else {
+        tcg_gen_ld_i64(TCGV128_LOW(ret), base, offset);
+        tcg_gen_ld_i64(TCGV128_HIGH(ret), base, offset + 8);
+    }
+}
+
+void tcg_gen_st_i128(TCGv_i128 val, TCGv_ptr base, tcg_target_long offset)
+{
+    if (HOST_BIG_ENDIAN) {
+        tcg_gen_st_i64(TCGV128_HIGH(val), base, offset);
+        tcg_gen_st_i64(TCGV128_LOW(val), base, offset + 8);
+    } else {
+        tcg_gen_st_i64(TCGV128_LOW(val), base, offset);
+        tcg_gen_st_i64(TCGV128_HIGH(val), base, offset + 8);
+    }
+}
+
 /* QEMU specific operations.  */
 
 void tcg_gen_exit_tb(const TranslationBlock *tb, unsigned idx)
-- 
2.34.1


