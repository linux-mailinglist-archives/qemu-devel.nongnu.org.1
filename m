Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C81072B105
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 11:06:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8Gxl-0005dE-BW; Sun, 11 Jun 2023 05:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8Gvk-0002hr-7Y
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 05:00:19 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8Gvg-000401-Ef
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 05:00:11 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-30af56f5f52so2111512f8f.1
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 02:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686474006; x=1689066006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6fgvCMeWGWtzi1ogVNS3n2ceF5EfOYaR43hCpswXEso=;
 b=j/qXLV/9sVhsCh+/pKikW540b9dVvIF3Gz9WWELqLKNQlKcGmEF5gPf7nAgeWOgq47
 XoXJP28L1REftwOig/rwqZGN8S0/Wu172rPjgq4sllTA6cpMDWLhAjS5GItSRC3N/gTt
 SstZ5wQhZtF6QGFoEvIhbcsWfnqDAT0UzPDZL4jz+Bfqnx9URfWKFvayiIdZg+/EPAXN
 ZIFAhK2cBbJ9X8/UdCquuy4MkCyavks7G8IDoLu9EDB2BoEb0L27vGpMYv8NLTG2hLNu
 h1/+QAe9Zhk8KrGMCfVz7end6nU3woQqAh+QmD6Q38wyDJv2kJIohIzdNtFwSwa274lg
 ewug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686474006; x=1689066006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6fgvCMeWGWtzi1ogVNS3n2ceF5EfOYaR43hCpswXEso=;
 b=KDKNVGJxiaKNZ/e+BtCU8kvClaoer0DksXlzvz0b9Uyp54hOZhsuHRfGH9He0tISQJ
 59QVzRUXsYGgygjuKI1oHuZdUDqO19q0lTW+JNP9PkW8CO7H9JnOZmk7kYC6zU0mW8iD
 J6+K3QkXRhBMZvvk2VcXj4JuToGc38Juh7VClcKzTSuzFkRbym86CFZvouHVV2vcryMR
 e+OAL0YJkJVDRXWJKV+VBJKQph97E8/lMhDU4FGI/E1IBUE2RisVjHWViOeo18E3+dhu
 98U1iLnyFNtL60GkL6LfEBw1gvls4OqRA8e1+G09c9Bb1qY5IN4wD0sbZ3qqrH3FhK+J
 joEQ==
X-Gm-Message-State: AC+VfDxb+riMjmaOdONg66WKZVhWSzt5LwGUc2qderLTRNeRi4B8z56A
 CyflSbgWFEuNV9wmr8gFlO0GN9DT6MnCX/MKPdw=
X-Google-Smtp-Source: ACHHUZ5iO9zuLrN6TJoL+lJmI+a3Plt2MDM6WR8WDENIVtQxFvacvManeZ7zSAuZBjXGvoFMThvyGA==
X-Received: by 2002:a5d:5491:0:b0:30f:bb97:37e8 with SMTP id
 h17-20020a5d5491000000b0030fbb9737e8mr916769wrv.47.1686474006262; 
 Sun, 11 Jun 2023 02:00:06 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 d17-20020adffbd1000000b0030fb4b55c13sm3028336wrs.96.2023.06.11.02.00.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 11 Jun 2023 02:00:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 18/26] target/arm/tcg: Reduce 'helper-sme.h.inc' inclusion
Date: Sun, 11 Jun 2023 10:58:38 +0200
Message-Id: <20230611085846.21415-19-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230611085846.21415-1-philmd@linaro.org>
References: <20230611085846.21415-1-philmd@linaro.org>
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

Instead of including helper-sme.h.inc via helper.h which
is included by all TCG files, restrict it to the few files
that require it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/helper.h            | 1 -
 target/arm/tcg/sme_helper.c    | 5 ++++-
 target/arm/tcg/translate-a64.c | 4 ++++
 target/arm/tcg/translate-sme.c | 6 ++++++
 4 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 61cd8fd21e..b7201eb89c 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -539,5 +539,4 @@ DEF_HELPER_FLAGS_5(gvec_uclamp_d, TCG_CALL_NO_RWG,
 
 #ifdef TARGET_AARCH64
 #include "tcg/helper-a64.h.inc"
-#include "tcg/helper-sme.h.inc"
 #endif
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 1e67fcac30..04170ad18d 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -21,7 +21,6 @@
 #include "cpu.h"
 #include "internals.h"
 #include "tcg/tcg-gvec-desc.h"
-#include "exec/helper-proto.h"
 #include "exec/cpu_ldst.h"
 #include "exec/exec-all.h"
 #include "qemu/int128.h"
@@ -29,6 +28,10 @@
 #include "vec_internal.h"
 #include "sve_ldst_internal.h"
 
+#define HELPER_H "tcg/helper-sme.h.inc"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+
 void helper_set_svcr(CPUARMState *env, uint32_t val, uint32_t mask)
 {
     aarch64_set_svcr(env, val, mask);
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 22caf89bb0..d1ab1edf6d 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -34,6 +34,10 @@
 #include "exec/helper-gen.h.inc"
 #undef  HELPER_H
 
+#define HELPER_H "tcg/helper-sme.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+
 static TCGv_i64 cpu_X[32];
 static TCGv_i64 cpu_pc;
 
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index e63b9883a9..fa0dc20bf2 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -29,6 +29,12 @@
 #include "exec/helper-gen.h.inc"
 #undef  HELPER_H
 
+#define HELPER_H "tcg/helper-sme.h.inc"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen.h.inc"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
+
 /*
  * Include the generated decoder.
  */
-- 
2.38.1


