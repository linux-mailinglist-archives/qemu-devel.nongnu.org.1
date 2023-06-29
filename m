Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 745E17422F1
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 11:11:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEngK-0006Wh-H4; Thu, 29 Jun 2023 05:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEngI-0006WF-CV
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 05:11:14 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEngG-0001k2-PK
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 05:11:14 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-313e1c27476so328366f8f.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 02:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688029871; x=1690621871;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PBnJV9HPW19aC/M2ORbO//nRzVHbhASHV5/MMu3GCMQ=;
 b=QgncVg1xWYzzTJD4EsBc1faR1m6h2kG74YK8C8qmy0faCKVB13m0aztOf6DA91skPl
 2O6jUiqVMLy3KNnnDKA8Ufc89Xx8Zgr9vl7/ePtRk2VX0kij8qnrhJl5y4g8/4lyRrO/
 68OdUdRaLhx6GrRbb3daojmMYKC9heGRo+fEhWb73KcGsm48QAumD9btX6xyWEw8J5z4
 vcsr34G/sTFE4tyUMdY9DPIVY7tAW0eHXCpETEnr4kcccHDNIkFc9D4NGvaa/WJKTMTI
 Sb25Z7Vrlwg2VUW9K3/Hg53Re9AukP5dSqHxYGeptLPZgHi3wmeKtqO1/zLfJeNVwZib
 0etg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688029871; x=1690621871;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PBnJV9HPW19aC/M2ORbO//nRzVHbhASHV5/MMu3GCMQ=;
 b=aaa3vaef+F6T+NiPHA+KkL2/XY57bSKT2AhpBEnGq7NqaCoiHv3jZ4KApNStf1e0Cw
 nJuoTKk7JLSzJCIQTdfqWhCZF6V6+DoyPsiQ8JaJicucxEhAwTVdTRZFSP6eGAWwMtuv
 BBQZaEomOioaC1Tyx8d/WtBO2hTv/FigYg8j0uxmczFvqI/xK0dAoGf18n3+KZ4GyuTS
 Kp7ZHPoORpX0wrI+r68eOEBdPFWFXO2NuT7mjY1EQ4/cB3giKTOtnDNeR+lWwwvprKlj
 /SPdnprvPlD/EzRrIodGtznPKGxNmYBctKD4xy+X9R1iy1NA76Uw6WLFN2jR+axUCI5s
 /Lew==
X-Gm-Message-State: AC+VfDxhVmwLFp8Rb2TumM9CGGJcdu2RlUU6z/E5pABLDRwoZn8t63E8
 8LxftUMRsQDE9Zb7Pj6QsJOKWxGe3SzC4OGc4gg=
X-Google-Smtp-Source: ACHHUZ5gjkaf+2WXBqb1cWWil8MpnkfE+K5BDFDxt3gdPnknt28iqmxShes6X4pDn5N7Ev2Joh8/UA==
X-Received: by 2002:adf:f206:0:b0:314:77a:c2a6 with SMTP id
 p6-20020adff206000000b00314077ac2a6mr4068135wro.25.1688029870971; 
 Thu, 29 Jun 2023 02:11:10 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.166.242])
 by smtp.gmail.com with ESMTPSA id
 i7-20020adfdec7000000b00313dfe954ecsm15285319wrn.11.2023.06.29.02.11.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Jun 2023 02:11:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH] tcg: Reduce tcg_assert_listed_vecop() scope
Date: Thu, 29 Jun 2023 11:11:07 +0200
Message-Id: <20230629091107.74384-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

tcg_assert_listed_vecop() is only used in tcg-op-vec.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
RFC: Maybe we plan to use it in tcg-op-gvec.c?
---
 include/tcg/tcg.h | 6 ------
 tcg/tcg-op-vec.c  | 6 +++---
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 95541e9474..0875971719 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -1135,12 +1135,6 @@ uint64_t dup_const(unsigned vece, uint64_t c);
         : (qemu_build_not_reached_always(), 0))                    \
      : dup_const(VECE, C))
 
-#ifdef CONFIG_DEBUG_TCG
-void tcg_assert_listed_vecop(TCGOpcode);
-#else
-static inline void tcg_assert_listed_vecop(TCGOpcode op) { }
-#endif
-
 static inline const TCGOpcode *tcg_swap_vecop_list(const TCGOpcode *n)
 {
 #ifdef CONFIG_DEBUG_TCG
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 64bc8a2156..ad8ee08a7e 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -42,9 +42,9 @@
  * tcg_ctx->vec_opt_opc is non-NULL, the tcg_gen_*_vec expanders
  * will validate that their opcode is present in the list.
  */
-#ifdef CONFIG_DEBUG_TCG
-void tcg_assert_listed_vecop(TCGOpcode op)
+static void tcg_assert_listed_vecop(TCGOpcode op)
 {
+#ifdef CONFIG_DEBUG_TCG
     const TCGOpcode *p = tcg_ctx->vecop_list;
     if (p) {
         for (; *p; ++p) {
@@ -54,8 +54,8 @@ void tcg_assert_listed_vecop(TCGOpcode op)
         }
         g_assert_not_reached();
     }
-}
 #endif
+}
 
 bool tcg_can_emit_vecop_list(const TCGOpcode *list,
                              TCGType type, unsigned vece)
-- 
2.38.1


