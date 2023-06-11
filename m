Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDEC72B0FC
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 11:02:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8GxY-0004UR-RG; Sun, 11 Jun 2023 05:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8Gvg-0002fl-QD
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 05:00:15 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8Gvc-0003oM-VC
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 05:00:06 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-30fbf6603d2so125911f8f.0
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 02:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686474002; x=1689066002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=btom/u1hZkX8UjQkUT1e66Oa9l3yd2W6yx3XFKKVFxk=;
 b=WBikaPQO1TstEK7K2PjFrb1eYs8oL0HBtvj5KQKxNj6x0QBlOzZU87/x8IC6iqMqKP
 R4hsQYLfLPHItor73LkzF3hSdAbCD0nvVt7kSlnAhXfGCvLpZveQWjeHPxOqxRSczeWS
 umVGj65oO96m+mXZ/K+M0M/PKAe7/ZpyNG0KJF6H9Y6IKSCB15LjTtZ5fmmfzgke6Sko
 AtTkDoezZ2J97S+d5UcD28WawD8BrFL+5goYaDx9EaY37tucBKee3A0fWzMyCtdEqnOM
 xVQPhJAHdgmLHtUxpxX/rGI0Qj+iq2NIQGeh8wWCn/w9kewqSFcAzvq63WTv6eiauwX4
 RsvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686474002; x=1689066002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=btom/u1hZkX8UjQkUT1e66Oa9l3yd2W6yx3XFKKVFxk=;
 b=iZYioWqbwZDIKVS+61iBGj8/NThBgzOUOFTsBvUZyXal4NC+5cL9A4IOUGl6l6gicq
 IUqNMM6qpHJDXpzolJr2+SF+reRqPU8cGHVHicKLM9V4YmrAgEUqLdnEqTNAfrQ8jl97
 vqbjhcahcca5jIfFbf5+j2lsFHFGykcIsW9CEij4AOaRFF7YoPBS4AA8OuTgHYY49YGg
 Wngq6vI/zec1O03y16duL77gX+3oVodV93VszKg36yDf+U/Khj2nWojFlDmSMXnYDmI7
 wiJVCP7f/ocpwHogrIqrjWn9ac+NWCZRTQNZK+sBk1qcZkjeY9XahA5kVM8orw7KVJZ9
 6mMg==
X-Gm-Message-State: AC+VfDxqe6p+B89AXS3sL73vOdF0Jfd0uiD6AUX7cwbWyMwTNHkGnEvp
 S6aqonTwUbcoQMGh/Aae7k99Fgz6c1qBGVzkBjM=
X-Google-Smtp-Source: ACHHUZ4aD+Nir/NhYWpz/IcJAc8FW3CPUJaSm4XXvhh8OnfUm9F0d2S9+M9LHYs4HFri/bj3nPHQnA==
X-Received: by 2002:a5d:6682:0:b0:30f:bafb:2469 with SMTP id
 l2-20020a5d6682000000b0030fbafb2469mr1238430wru.53.1686474001951; 
 Sun, 11 Jun 2023 02:00:01 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 cr5-20020a05600004e500b0030c6751a49dsm9070871wrb.115.2023.06.11.02.00.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 11 Jun 2023 02:00:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 17/26] target/arm/tcg: Reduce 'helper-mve.h.inc' inclusion
Date: Sun, 11 Jun 2023 10:58:37 +0200
Message-Id: <20230611085846.21415-18-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230611085846.21415-1-philmd@linaro.org>
References: <20230611085846.21415-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Instead of including helper-mve.h.inc via helper.h which
is included by all TCG files, restrict it to the few files
that require it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/helper.h            | 2 --
 target/arm/tcg/mve_helper.c    | 5 ++++-
 target/arm/tcg/translate-mve.c | 6 ++++++
 target/arm/tcg/translate.c     | 4 ++++
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 134d428175..61cd8fd21e 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -541,5 +541,3 @@ DEF_HELPER_FLAGS_5(gvec_uclamp_d, TCG_CALL_NO_RWG,
 #include "tcg/helper-a64.h.inc"
 #include "tcg/helper-sme.h.inc"
 #endif
-
-#include "tcg/helper-mve.h.inc"
diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index d8ba5a9e60..a3fca486e0 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -21,7 +21,6 @@
 #include "cpu.h"
 #include "internals.h"
 #include "vec_internal.h"
-#include "exec/helper-proto.h"
 #include "exec/cpu_ldst.h"
 #include "exec/exec-all.h"
 #include "tcg/tcg.h"
@@ -31,6 +30,10 @@
 #include "exec/helper-proto.h.inc"
 #undef  HELPER_H
 
+#define HELPER_H "tcg/helper-mve.h.inc"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+
 static uint16_t mve_eci_mask(CPUARMState *env)
 {
     /*
diff --git a/target/arm/tcg/translate-mve.c b/target/arm/tcg/translate-mve.c
index bbc7b3f4ce..8577dc4377 100644
--- a/target/arm/tcg/translate-mve.c
+++ b/target/arm/tcg/translate-mve.c
@@ -21,6 +21,12 @@
 #include "translate.h"
 #include "translate-a32.h"
 
+#define HELPER_H "tcg/helper-mve.h.inc"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen.h.inc"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
+
 static inline int vidup_imm(DisasContext *s, int x)
 {
     return 1 << x;
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 2b3951cece..d88b355230 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -33,6 +33,10 @@
 #include "exec/helper-gen.h.inc"
 #undef  HELPER_H
 
+#define HELPER_H "tcg/helper-mve.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+
 #define HELPER_H "helper.h"
 #include "exec/helper-info.c.inc"
 #undef  HELPER_H
-- 
2.38.1


