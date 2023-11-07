Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C377E333C
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:50:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0C9O-0008PX-4M; Mon, 06 Nov 2023 21:49:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C9J-0008Mu-He
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:49:05 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C9H-0005tf-TK
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:49:05 -0500
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6ce37683cf6so3226253a34.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699325342; x=1699930142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8GSD+l+fgsavoFgGdG3xylhNYKfi9yVBkELAIfWGGOI=;
 b=WH6EHvtw4nprZlRHXJBdO9mqZAoH4cUg6657bNWUDhYaHDRBQlxRW83MN3gkZ/G3WY
 xH7TVIKIjFe6pEqwEPHFXC0P6RpG571aOmaOWYfRoxkqqFuYBgukl1bmAhUmsd/TLh7B
 KFpTTSJvqkpslAZP9UddZSW1v2uDdGQkQaQKIOoPXtC66fODJX0e+EMdF3EABOGrGqQn
 N0NBiQebkix//6tTVSu+rDzjFbGUuwnqqondR9KtESg5k3vbI9CgSC47MMH9CCmwUlmh
 0sXSQvG8nPyNQwmK5RuBzX9aWd6BKwxSTQR+d5HUhsOoJt/8LA2U/No+mkrOmWO3G1a1
 5vsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699325342; x=1699930142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8GSD+l+fgsavoFgGdG3xylhNYKfi9yVBkELAIfWGGOI=;
 b=U58aLZqNPRH04Or7ZsT1DYNx0l2Cj3FktVViGzZ7OgQWDHkxslRo4K5LBC3Jt3RBKw
 HIpuCBrDf2gZ3CIMmx2h9/VkL+mKxT/JC5MU4XefhBR0nVBnWiD8VVVzMRtMmA8scUBU
 eB6YPhs3Qpw8b/ZeoxZn4e2KW7qhCvfWcJwzzV+0tAxE8dNOEZ2pLak7rdPk3akRaTSK
 AZ3ZkoeSlA/HSc8Oj9h/ZjbcW5aNuf4KEpHEpWOe/P1UbpPfkc3sC0zGQXSpASU38JpL
 lTgH/k5+XY77pD88yUllU0ndq/S+HnMGddFVdY5KrpgR2CIaGhOSu4SLxgVOSnBK/5Da
 TVWw==
X-Gm-Message-State: AOJu0YwY2SfZonE7nvNylq3Ko2RjHBMWFWsJQJEy6fYviqRlj3WqMstX
 fbX1++lqcgY9JXJzWFT/r210gEc+MKAStzHE6fQ=
X-Google-Smtp-Source: AGHT+IGZJrV13Q2AoQ9ZDO/S9HxzyrqcRafIj1uhx8GzWicpkFsJgiJ5t1n6AufycYBnD4E2tXnfPQ==
X-Received: by 2002:a9d:6293:0:b0:6b9:bf1e:c141 with SMTP id
 x19-20020a9d6293000000b006b9bf1ec141mr32466655otk.23.1699325342724; 
 Mon, 06 Nov 2023 18:49:02 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fn11-20020a056a002fcb00b006bff7c36fb3sm6367478pfb.95.2023.11.06.18.49.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:49:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 24/35] tcg/loongarch64: Implement neg opcodes
Date: Mon,  6 Nov 2023 18:48:31 -0800
Message-Id: <20231107024842.7650-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107024842.7650-1-richard.henderson@linaro.org>
References: <20231107024842.7650-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231026041404.1229328-6-richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.h     | 4 ++--
 tcg/loongarch64/tcg-target.c.inc | 9 +++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index 486898c2d3..189997644a 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -119,7 +119,7 @@ typedef enum {
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_neg_i32          0
+#define TCG_TARGET_HAS_neg_i32          1
 #define TCG_TARGET_HAS_andc_i32         1
 #define TCG_TARGET_HAS_orc_i32          1
 #define TCG_TARGET_HAS_eqv_i32          0
@@ -153,7 +153,7 @@ typedef enum {
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_neg_i64          0
+#define TCG_TARGET_HAS_neg_i64          1
 #define TCG_TARGET_HAS_andc_i64         1
 #define TCG_TARGET_HAS_orc_i64          1
 #define TCG_TARGET_HAS_eqv_i64          0
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index ae13c1f666..a588fb3085 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1441,6 +1441,13 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         }
         break;
 
+    case INDEX_op_neg_i32:
+        tcg_out_opc_sub_w(s, a0, TCG_REG_ZERO, a1);
+        break;
+    case INDEX_op_neg_i64:
+        tcg_out_opc_sub_d(s, a0, TCG_REG_ZERO, a1);
+        break;
+
     case INDEX_op_mul_i32:
         tcg_out_opc_mul_w(s, a0, a1, a2);
         break;
@@ -2076,6 +2083,8 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
     case INDEX_op_ext_i32_i64:
+    case INDEX_op_neg_i32:
+    case INDEX_op_neg_i64:
     case INDEX_op_not_i32:
     case INDEX_op_not_i64:
     case INDEX_op_extract_i32:
-- 
2.34.1


