Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 287477D7B6E
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 06:15:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvrl9-0002W9-03; Thu, 26 Oct 2023 00:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvrl6-0002VG-J9
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 00:14:12 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvrl4-0000jS-RO
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 00:14:12 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1cc0e78ec92so432895ad.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 21:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698293649; x=1698898449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kfOTc+047DdEYqk8cfseEawf9Tt5uNnX6caSwYhD9Rk=;
 b=gSTe/COKmGRO5lx48JaHInzlEZUstmLneCzzQOQ+85+4FFWyx4UpANg0/i2f86ieFX
 lvp9Skwne7ckO4R6taoy4dcEKSUORJe+Fi9I0nMFbHa8sxum1wbpNr4rjDvxU68hfVtp
 Gx2GIg7JsTWq22Gn2kBSIkyrZa6rjKB3p9X/HTtVNeUxHwAiFGgBvX1xITLm7vIcpaYP
 UqW7niBA0HTswfezGlCUVw80FQHtzMtLpSAL6s971TPVznNmJuuQXkTzFSGO22OOT8IC
 MVSuUGeqWcPx7E95iQurYI7g9CEusQD3M8S4yQW9SHAYG0AWrc0MIUPzjMcTgiK8HFij
 9vHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698293649; x=1698898449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kfOTc+047DdEYqk8cfseEawf9Tt5uNnX6caSwYhD9Rk=;
 b=V58jEyR+WpZqd2RJ3muC85ugT2jvOplpi1DQ1bL5qfDV9dSLQOoMCwORjEsyTUU1ta
 TVpqGc0BNMKWPHwov+rP+bqtfa+9tSg/pfhiD7NGxAzHbG4i3TvUj+sBGEMA2c9Qy7kI
 TEjHQl62bEPhmoWH1g6xxiybcNLWhWlEjm66+Q3LREfxmjBGOTD092VSSmiabqX7DqpD
 ZSoFX/Qync9XZ8o4n/d7gSRnzS/urov896zP52e4L/kiFBqhavgX7J35uZlxiFVcProF
 ZBNZOH/HcXKriyJeI5oxGURQKUw+HmGoXH9CK0yySzj5G7JUu2GuSIjZoQwJuH4hONE/
 J7sA==
X-Gm-Message-State: AOJu0YzXBAJ7gpiAnT0LeNSDGJoicjVwUHNTbR+K+O5HnqrtFH9ki6H3
 GTFCrpYUpFqPnRyCXeVy9l0279y1P7jG+RT+ovk=
X-Google-Smtp-Source: AGHT+IGguBEoZJnjkAtcaQyFPd1+NqgsgSEqN5cOe8dNDv6OUG5XLXvpEB68t8Uj6uor1j5gSzRFrw==
X-Received: by 2002:a17:902:da92:b0:1c7:4f87:3dbe with SMTP id
 j18-20020a170902da9200b001c74f873dbemr17411696plx.31.1698293649413; 
 Wed, 25 Oct 2023 21:14:09 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 i12-20020a170902eb4c00b001b8b2b95068sm9953929pli.204.2023.10.25.21.14.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 21:14:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/6] tcg/loongarch64: Implement neg opcodes
Date: Wed, 25 Oct 2023 21:14:03 -0700
Message-Id: <20231026041404.1229328-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026041404.1229328-1-richard.henderson@linaro.org>
References: <20231026041404.1229328-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.h     | 4 ++--
 tcg/loongarch64/tcg-target.c.inc | 9 +++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index bebb2c6a05..d1c8e6d341 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -119,7 +119,7 @@ extern bool use_lsx_instructions;
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_neg_i32          0
+#define TCG_TARGET_HAS_neg_i32          1
 #define TCG_TARGET_HAS_andc_i32         1
 #define TCG_TARGET_HAS_orc_i32          1
 #define TCG_TARGET_HAS_eqv_i32          0
@@ -153,7 +153,7 @@ extern bool use_lsx_instructions;
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_neg_i64          0
+#define TCG_TARGET_HAS_neg_i64          1
 #define TCG_TARGET_HAS_andc_i64         1
 #define TCG_TARGET_HAS_orc_i64          1
 #define TCG_TARGET_HAS_eqv_i64          0
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 4e850a29e5..f21fba9f66 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1458,6 +1458,13 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
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
@@ -2093,6 +2100,8 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
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


