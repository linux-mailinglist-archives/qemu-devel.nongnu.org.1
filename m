Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A06172976E
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 12:50:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Zg1-0005NO-BT; Fri, 09 Jun 2023 06:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7Zfy-0005BZ-Pn
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:49:02 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7Zfw-0001aV-0U
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:49:01 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3f6dfc4dffaso12079245e9.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 03:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686307738; x=1688899738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rvQHAgyj3tah0H+DK+kbZn5BByBm74hggAn69+C4TNw=;
 b=D+axYGoVewQ/QDKDhwGaSASxuky/QLdHSdNLsyEpuYg3cSFoaqsagKc4WWZ8+ypIZJ
 4QBNg3TSXhfchHbirRV+mzskeyyecsJXQDcoq/pdFp2CQIHAXAIetvDG2eHBdDuFhwbe
 s8GEwu7Q7MNOfuqonocAhV0aOXhi9hqwREGo23m28/wm2TpHDZ3nzl5jjg3SmlxrHEgG
 xi3PyuxgCT2ZxvZCdISq3tjyIKVE5vJJvm+5pTOnwyh217e0BEMwcf7fl1H0fkbhjNj5
 ci28nakTLKYe0q39DCpYMXeA4VAjVHEIRV5wzUfbaT0SNTvt5hgS/zVj855HH9Psaqk4
 sJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686307738; x=1688899738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rvQHAgyj3tah0H+DK+kbZn5BByBm74hggAn69+C4TNw=;
 b=UOczBse3IWdEAAPbxQuGpwlHplnSQkjJIRu66bnAZndy6//74A468qWD8e7CIeZHAm
 C5z58Jx/GvjyKS1nBWEEkXcZ3bN1v7AMmVWW/H9A3W89hHbDu+MchPR1mJ3MZPZP2UGr
 LR64gP9igt51sS62i4o0SQju/Gzg7ofno668XwCwZ1r+9kvRdmvp2al6xpR6l75mYx+J
 90kBu4Fd+dBZRQkpsV+R9on8ynhwosNmHicS6UFE9eIyvyXIW1it+RS8r0Qei/OfIyXz
 JefPmYP7ydpw6UjCpCLvWB+v60IKu5BaqQQN4qpSJe8QhF5PSVppbZHie35cJsqJUjK8
 g8sw==
X-Gm-Message-State: AC+VfDwAJtc25NkcewD4yB+j2rc6vT8eug1AMrY70Ign6tK+6+Hm/1I7
 814EQPY3ucay12PHlSPUqkCLJi6cRMNhTC3acbQjGg==
X-Google-Smtp-Source: ACHHUZ408FsjjEIPMnby3ySQiP/94KFNXZXUyt0CfjSNrhlszDIQsEZyvwYgtG2QLxYdH2OfKG7uYA==
X-Received: by 2002:a05:600c:292:b0:3f7:33da:f218 with SMTP id
 18-20020a05600c029200b003f733daf218mr624576wmk.35.1686307738077; 
 Fri, 09 Jun 2023 03:48:58 -0700 (PDT)
Received: from localhost.localdomain (23.171.88.92.rev.sfr.net. [92.88.171.23])
 by smtp.gmail.com with ESMTPSA id
 x5-20020adff0c5000000b003078a3f3a24sm4100901wro.114.2023.06.09.03.48.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jun 2023 03:48:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 15/22] target/arm/tcg: Extract SVE2 definitions to
 'helper-sve.h.inc'
Date: Fri,  9 Jun 2023 12:47:10 +0200
Message-Id: <20230609104717.95555-16-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230609104717.95555-1-philmd@linaro.org>
References: <20230609104717.95555-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
---
 target/arm/helper.h             | 46 ---------------------------------
 target/arm/tcg/helper-sve.h.inc | 46 +++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 82c34df538..0cbffa4097 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -181,23 +181,6 @@ DEF_HELPER_FLAGS_5(gvec_qrdmlah_s32, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(gvec_qrdmlsh_s32, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
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
 DEF_HELPER_FLAGS_5(gvec_sdot_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_udot_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_sdot_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
@@ -533,35 +516,6 @@ DEF_HELPER_FLAGS_5(gvec_mls_idx_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(gvec_mls_idx_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
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
 DEF_HELPER_FLAGS_4(gvec_xar_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_5(gvec_smmla_b, TCG_CALL_NO_RWG,
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


