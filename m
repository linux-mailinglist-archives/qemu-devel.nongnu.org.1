Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E895735BB8
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 17:59:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBHEv-0006qY-6D; Mon, 19 Jun 2023 11:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBHEq-0006pc-UT
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:56:22 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBHEp-00051w-1q
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:56:20 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9887ebe16d0so219666066b.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 08:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687190177; x=1689782177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4XPgwFi+zbcJEMylGjhZK3bTyAFGq7BdRgg8xy5rWzE=;
 b=iDClyHf+eq2xuW1kKF7TDBsKl99GYfZmcH+BhBrMyHItP9AqzLemnFMlhCTJbov6ni
 OwOzEUGBfHh6FquTe0Z1o1eCsnxDA819VIXGH4na8iwKFrX/pPIeZ4b/RhMLJTbbONJ3
 DLjo39Nox6s+CoJr6kHjG3bJVHMN0YiB4D/4Xh9Sl1IH8bk7CDe2otZoS3kcdgnEMae2
 ieHevu2xtKz4y0cFXU3gXo6uh8fKp/t/h4qN4lK0sMu0UTxQN5xxlVdn8k5xhCjTmBk9
 0DaG+AcydNM0keUqJZxBRNNQmyvBtJWyfpG9HxtddLbVyBGeEhVvRbamtkZRVA8NK+4Y
 uBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687190177; x=1689782177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4XPgwFi+zbcJEMylGjhZK3bTyAFGq7BdRgg8xy5rWzE=;
 b=OHm7Snl6CQqqRbiNl1WWgPbkdV9wGfB/kRDgUqIz61xvY29yg3vPy50MMAWYWK650W
 MpKA1DA9/X5xj/h9fy7Ri7x7QRX7f5QrheyKSEk7gftgL3+gxQO6np9efpMblJ9Fdmot
 oZg+7IXl461Idk7FmDbNmav+s8szZ9tEl61evkHs+8ulwV0Qa/Lae7C2GUh+hnZ0FtdR
 3//mOZv8eSSZkUoe9/nRyQbldYUcUONbmn/J3W0dLLrjgmsvp0S2LO6E81zi9GtwDlXI
 EqTRxnn2GngqJ9fO/zkEBdYljZfY8IhwwLnX3/2bj5lgljX8HNpX+lsu6WqIuObXlIn3
 tG1A==
X-Gm-Message-State: AC+VfDwQTiNr34YcRPHLxWS9nAMQiEQz9Xw0zLz631IG0aQ/vCmr5pQJ
 Sg2o0A+1oK/WYYGHAviqtOD7/3Xct0x6KAG6eDdbsQ==
X-Google-Smtp-Source: ACHHUZ4GDfmzV5j0+89/d4orvjRdboQNf8wiiHtFhC+HGsrIY8O1X4bWsXKCIuwxVaAgzNM4nvf3Hg==
X-Received: by 2002:a17:906:5d0d:b0:988:cbf5:3a80 with SMTP id
 g13-20020a1709065d0d00b00988cbf53a80mr1955365ejt.62.1687190177126; 
 Mon, 19 Jun 2023 08:56:17 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 c21-20020a170906341500b00985bdb7dd5fsm5053131ejb.201.2023.06.19.08.56.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Jun 2023 08:56:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 19/34] target/arm/tcg: Extract SVE2 definitions to
 'helper-sve.h.inc'
Date: Mon, 19 Jun 2023 17:54:55 +0200
Message-Id: <20230619155510.80991-7-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230619155510.80991-1-philmd@linaro.org>
References: <20230619154302.80350-1-philmd@linaro.org>
 <20230619155510.80991-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

helper.h is used by all units, but not all require the
SVE2 definitions. We already have helper-sve.h.inc for
SVE* definitions, move them there. The next commit will
remove it from the common helper.h.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h             | 46 ---------------------------------
 target/arm/tcg/helper-sve.h.inc | 46 +++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 6d61694f5e..f347305c0f 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -146,52 +146,6 @@ DEF_HELPER_FLAGS_4(crypto_rax1, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(crc32, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 DEF_HELPER_FLAGS_3(crc32c, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 
-DEF_HELPER_FLAGS_5(sve2_sqrdmlah_b, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(sve2_sqrdmlsh_b, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(sve2_sqrdmlah_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(sve2_sqrdmlsh_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(sve2_sqrdmlah_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(sve2_sqrdmlsh_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(sve2_sqrdmlah_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(sve2_sqrdmlsh_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(sve2_sqdmulh_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(sve2_sqdmulh_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(sve2_sqdmulh_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(sve2_sqdmulh_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(sve2_sqrdmulh_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(sve2_sqrdmulh_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(sve2_sqrdmulh_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(sve2_sqrdmulh_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(sve2_sqdmulh_idx_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(sve2_sqdmulh_idx_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(sve2_sqdmulh_idx_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(sve2_sqrdmulh_idx_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(sve2_sqrdmulh_idx_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(sve2_sqrdmulh_idx_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_6(sve2_fmlal_zzzw_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_6(sve2_fmlal_zzxw_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
-
 #ifdef TARGET_AARCH64
 #include "tcg/helper-a64.h.inc"
 #include "tcg/helper-sve.h.inc"
diff --git a/target/arm/tcg/helper-sve.h.inc b/target/arm/tcg/helper-sve.h.inc
index cc4e1d8948..042a29d76a 100644
--- a/target/arm/tcg/helper-sve.h.inc
+++ b/target/arm/tcg/helper-sve.h.inc
@@ -2802,3 +2802,49 @@ DEF_HELPER_FLAGS_4(sve2_sqshlu_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_sqshlu_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_sqshlu_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_sqshlu_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_sqdmulh_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_sqdmulh_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_sqdmulh_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_sqdmulh_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_sqrdmulh_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_sqrdmulh_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_sqrdmulh_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_sqrdmulh_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve2_sqrdmlah_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_sqrdmlsh_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_sqrdmlah_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_sqrdmlsh_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_sqrdmlah_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_sqrdmlsh_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_sqrdmlah_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_sqrdmlsh_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_sqdmulh_idx_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_sqdmulh_idx_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_sqdmulh_idx_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_sqrdmulh_idx_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_sqrdmulh_idx_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_sqrdmulh_idx_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_6(sve2_fmlal_zzzw_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve2_fmlal_zzxw_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
-- 
2.38.1


