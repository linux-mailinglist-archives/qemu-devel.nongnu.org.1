Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DE072B0FF
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 11:04:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8Gxo-0005wY-27; Sun, 11 Jun 2023 05:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8Gvt-0002mQ-1j
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 05:00:21 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8Gvp-00042B-CN
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 05:00:19 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f6d7abe934so23013095e9.2
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 02:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686474015; x=1689066015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TyRRQl63EjUwf6nuHb///9HEwrhn3HTdxj4GOGWSaio=;
 b=wFALolBSDATXLAJZVy/5VIIHEKz6MtJ4Oo6FQJUB+5nDrq+KEN5DiyDI6EJlSwLAaT
 fj8VUBclM/4BP3MoSOiwGOMrHMFvfVVnE+nidosA3fVEsCPggsO40vArzPMWXHmxaihF
 RbZbz27aKCCfK/vrDMIW/FO9QzXpFLK+bLBH4rC6P+2CUz9FQpwPwfT93abSrDWclrBV
 roFycHxq5Ji56xFVMC2OetkezCi0Wfr06M/Od5T4ZbaCJgb0OqSMvb+dmET6EOiuKEeZ
 f6NKLV3bm473qj4aiyp3Q4WKzA1rB7z6URXN811+jCUW6GpJ3tWboJqR00+IQX8M/kgI
 qAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686474015; x=1689066015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TyRRQl63EjUwf6nuHb///9HEwrhn3HTdxj4GOGWSaio=;
 b=Kh1hFcc8oe4ckrQsOfhrpj0fPjOo3+bw5xeARypsc7p4d0cB3AzhwMDaEhZXmoDJEz
 s32JnzPp2109pzHXTWU0RcQ2Szo5LwbXOcWmcDcOrgYAkbCXtfLo0HlTrtIRN5Nn0jIY
 pXi5qKlkNCZh5thxthads0Ama30xvjDSqrG3e9Ui5Y7NBrvjnqcm9CJoevqM7nDLEiD2
 zWf61/+1WefULpi5TtSdcziuUHwXHEwzABezVzB35PU9nE+iV+4/K+e2N5EI/FpEA80z
 QGPQzkJwD2cwAwxxkFLVQPbCZCA8onEObY5RAGLixLV/rtGZSyUgxvk/V6bzJ5KSE4Wo
 2//g==
X-Gm-Message-State: AC+VfDwQZRGzfIbFXp21Va6j5SaJV8WQ28nMKmAeKbsbbgcbY11DE8QA
 XBfXvFeepfTR5DFMuIuczD/jy6NyAq25JGroYys=
X-Google-Smtp-Source: ACHHUZ75ZjLLQfBWYfV48x3geI/Q/YP6UC5aeKT2Hw/IrhB1aabzN9evzeSipV3IirlSI5YvMvikXA==
X-Received: by 2002:a7b:c7d4:0:b0:3f6:389:73b1 with SMTP id
 z20-20020a7bc7d4000000b003f6038973b1mr3909544wmk.6.1686474014917; 
 Sun, 11 Jun 2023 02:00:14 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 u5-20020a5d5145000000b0030fa57d8064sm5842041wrt.52.2023.06.11.02.00.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 11 Jun 2023 02:00:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 20/26] target/arm/tcg: Move v8m_stackcheck() from
 op_helper.c to m_helper.c
Date: Sun, 11 Jun 2023 10:58:40 +0200
Message-Id: <20230611085846.21415-21-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230611085846.21415-1-philmd@linaro.org>
References: <20230611085846.21415-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

No need to have the v8m_stackcheck() helper in the generic
op_helper.c, move it with the rest of the M-profile helpers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/tcg/m_helper.c  | 16 ++++++++++++++++
 target/arm/tcg/op_helper.c | 16 ----------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index 0891acc29c..0780bb3dea 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -2893,3 +2893,19 @@ uint32_t *arm_v7m_get_sp_ptr(CPUARMState *env, bool secure, bool threadmode,
         }
     }
 }
+
+void HELPER(v8m_stackcheck)(CPUARMState *env, uint32_t newvalue)
+{
+    /*
+     * Perform the v8M stack limit check for SP updates from translated code,
+     * raising an exception if the limit is breached.
+     */
+    if (newvalue < v7m_sp_limit(env)) {
+        /*
+         * Stack limit exceptions are a rare case, so rather than syncing
+         * PC/condbits before the call, we use raise_exception_ra() so
+         * that cpu_restore_state() will sort them out.
+         */
+        raise_exception_ra(env, EXCP_STKOF, 0, 1, GETPC());
+    }
+}
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 70a9c37b74..04a90e3e3a 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -82,22 +82,6 @@ void raise_exception_ra(CPUARMState *env, uint32_t excp, uint32_t syndrome,
     raise_exception(env, excp, syndrome, target_el);
 }
 
-void HELPER(v8m_stackcheck)(CPUARMState *env, uint32_t newvalue)
-{
-    /*
-     * Perform the v8M stack limit check for SP updates from translated code,
-     * raising an exception if the limit is breached.
-     */
-    if (newvalue < v7m_sp_limit(env)) {
-        /*
-         * Stack limit exceptions are a rare case, so rather than syncing
-         * PC/condbits before the call, we use raise_exception_ra() so
-         * that cpu_restore_state() will sort them out.
-         */
-        raise_exception_ra(env, EXCP_STKOF, 0, 1, GETPC());
-    }
-}
-
 uint32_t HELPER(add_setq)(CPUARMState *env, uint32_t a, uint32_t b)
 {
     uint32_t res = a + b;
-- 
2.38.1


