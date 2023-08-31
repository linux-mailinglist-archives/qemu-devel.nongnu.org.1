Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA61678E4F4
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 05:08:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbY1i-0003Xy-Rh; Wed, 30 Aug 2023 23:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbY1g-0003XT-Rm
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 23:07:20 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbY1e-00012n-Nt
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 23:07:20 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1bdca7cc28dso2692855ad.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 20:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693451237; x=1694056037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=e02Mul0OfqUA50lWHNyjtWfRKC7498FCi8j1nOB5Wto=;
 b=RfgEdQ8qmlKuL/Gta7YDAaxsIFvPFycrdZmBshkPyQlbFwXRLj4Fs+ZwPMCFNwfsMC
 kZ7byuok5Qq52c09j0+d+yzvkbAJQjrYWbs8+kI7jKaNYwNC1ilFzSiFSbtECbW7YTDb
 5TE1kniKHxIeXYiCEe8dy/YxO9c28Ei28upf2lZ8Ho9m0lgiMj2zIecIln1RX2HhfwWJ
 LIqL0cN/M/FjGPvDkKm7lKMPY0V9b1rCIMB3p2zA6zeHyQ8p3fCRSHWY1TAcPUpyn91o
 R6Q/UwrmhSCcvyeSDs6jqDJPnNmyHIonXiMnyiOJ8nppMgiGHKZ2wgSNyaQwm/wLxh55
 sZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693451237; x=1694056037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e02Mul0OfqUA50lWHNyjtWfRKC7498FCi8j1nOB5Wto=;
 b=W8BN8XYcuGqpRhMVTkpaxH7JmaDTGQJ53va/P92pnaOmUu1rPX1dNjy6q8eGxZQJ2L
 mjthoQtrmai2PeayuxbrsXIyoibKfbyIasC4tD+fFDfRZX37TUFbVk2S0HbaW5Jretq6
 61581LoqhTytDJvOysryEvXhP8USNGQVnIKbis3Uf2GmRsiI2TsCH4Je9fQQp7I3FO+m
 82IDOseqSVQNNYvyC4Yqo60b3+GPybZu7AZ6jyPq0zZx1nakcpSflQykOj4NbHbY/NNS
 OXcZeGLTX4RZueSWtY/a+xdq//B2PZeUSWQmuK33JfCJ39cNiWu0Aoiys8+JEvJrXFN+
 TJTg==
X-Gm-Message-State: AOJu0Yzk5CCqpaX1n9JgxEtPKBBvSfDpmG+p/mF6DZ9Lxtoq3z3JcbhH
 1qOq3hyjwHTBU9zvUbDnOU5UhviQT9kp89NOzsE=
X-Google-Smtp-Source: AGHT+IGYE8zzog4ZD5qeY7JWfT+6AJNQ7E10szK6V3HSmHU70BV2RrpSoX68kkAmype793aN+uPcMA==
X-Received: by 2002:a17:902:bd48:b0:1c0:d7a9:580 with SMTP id
 b8-20020a170902bd4800b001c0d7a90580mr3581453plx.60.1693451237191; 
 Wed, 30 Aug 2023 20:07:17 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 ju19-20020a170903429300b001b8c689060dsm228847plb.28.2023.08.30.20.07.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 20:07:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] tcg: Add tcg_gen_{ld,st}_i128
Date: Wed, 30 Aug 2023 20:07:13 -0700
Message-Id: <20230831030714.1194595-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831030714.1194595-1-richard.henderson@linaro.org>
References: <20230831030714.1194595-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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
extract of i64 in order to move values to and from  env.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h |  3 +++
 tcg/tcg-op.c                | 22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index a53b15933b..c81cdbe11c 100644
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
index 02a8cadcc0..a005a0eb29 100644
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


