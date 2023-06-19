Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C3D735BBA
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 17:59:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBHGU-0002Gp-5x; Mon, 19 Jun 2023 11:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBHFq-0000cR-A6
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:57:26 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBHFj-0005Fj-AL
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:57:17 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-988aefaa44eso178196066b.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 08:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687190233; x=1689782233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TyRRQl63EjUwf6nuHb///9HEwrhn3HTdxj4GOGWSaio=;
 b=f6S2zwWWAF3t1VnoQDeiBA9YlPUEUuXhyaiTrXI/3rO3gJJ4guVLEpekLkCJCemuk9
 dwjRdbCy98pxzlUPgodmMxn79cy788qEA2PugNp/zT4kwepzxvaN1bxOxrrZDBHVtAVP
 ngcEk66/HIU5pZEf0z3paxbRoq8a81rJo3MQCF5CQBgLDEu/Bi7TUpAYshA+2RKEQeo2
 3af925cGoSm4/VUu+oSJjteibsAk6ZhANI94WobQIflnV8tMyt83XnnVi4pbiIDG+ny0
 WgI1xgCJPsFMMqfvRovxYtyn2d1KfogGANSX2i0aqWf4lHIpyl3CGBqPpRO2PaM1QkfU
 hEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687190233; x=1689782233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TyRRQl63EjUwf6nuHb///9HEwrhn3HTdxj4GOGWSaio=;
 b=axjFJ8HY38EkFK+NMcTd6Jtvf/rQ50n8H2pn22mM9MeFLZc2Yo0g/3jgt8czVLWqqQ
 QhwNiJ++f3t8brKpZ71Hc2RcFGfcAS7q9PejZobpLQANfoIIDUMIw0Aji43V6FoJJZKa
 ymNGDq8V6/8Pdf+3zAA3T36CQmalh7Lnxdz9vifnFHC0lMWLpr3zSKyQrlo+ZhUBUaJQ
 jE4qX8ROr8uBwk3OfUQgJa7cxhriPh+VhMs3VpZx4Acrnej9cvs6EZDayobFXlkvEuar
 Evk4SjZbUPNpKMlr2cT6X9ynDPFPqBc1+zOwUbkmoa6YBjuZl+7cwFAHlYwjYo4it0mC
 b7Ag==
X-Gm-Message-State: AC+VfDz/ccSFd/lpWj8WVnpzpXMvKU50ziYvpHqVVzBg7I8y9sm26SYK
 8+mPQtZTuK4SgW64B+jM76mdNfefrxMusQ0Be7Ea3A==
X-Google-Smtp-Source: ACHHUZ4G0rhfg3lOMPphj76GgNiE6LRhzIuVHL4DMdWehLCwt6TmY0ANKA4wo67bLV/8VdogbXBCqQ==
X-Received: by 2002:a17:906:730c:b0:988:9b29:5653 with SMTP id
 di12-20020a170906730c00b009889b295653mr3281223ejc.77.1687190233704; 
 Mon, 19 Jun 2023 08:57:13 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 u15-20020a170906068f00b009886aaeb722sm2632724ejb.137.2023.06.19.08.57.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Jun 2023 08:57:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 28/34] target/arm/tcg: Move v8m_stackcheck() from
 op_helper.c to m_helper.c
Date: Mon, 19 Jun 2023 17:55:04 +0200
Message-Id: <20230619155510.80991-16-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230619155510.80991-1-philmd@linaro.org>
References: <20230619154302.80350-1-philmd@linaro.org>
 <20230619155510.80991-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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


