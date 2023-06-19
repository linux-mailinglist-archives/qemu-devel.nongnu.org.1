Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6C4735BBB
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 17:59:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBHGQ-0001u5-PQ; Mon, 19 Jun 2023 11:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBHFy-0000hF-IB
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:57:34 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBHFw-0005HV-3l
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:57:30 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-4f86fbe5e4fso1616428e87.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 08:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687190246; x=1689782246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qijpLk0wX0ptsmF+P6fto7vBQE77SEwZLEtPibO5Rfc=;
 b=VnzFdwDKN6dTUumBbiSX+y+pMOcK+T9cEWbT7ukd4+BEwr7pmyKnZOv4UcYzCAOM0w
 4OIauB7BhK2K9PqOVtZgdfYfGK0tQeQjE30aRVKsSytBOe+Nxi5vMXsZy4AHhgat7Q0n
 AhjwMLWzoSwxOJJ6oEEfjDdDHzdft2ke1PjTyCFwKy68wCGuPMF4qnVtEzQrOfb9wrCB
 /ZxE7J8IKWW17fNxEvauQW0fJx/7tgSe1T89VMQuK9Oi/scqFobfM514GEQz81pTXDaP
 oubwE7OLoxQLBKmy93OPYSz3njaw9sh9g7Q2DQxUIFGKIPqYNEva7Im49uGBd5Spr2AY
 OmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687190246; x=1689782246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qijpLk0wX0ptsmF+P6fto7vBQE77SEwZLEtPibO5Rfc=;
 b=AurG4pxWFTDbVEry8JTyhMTnwCEJnKjpKUaeNh/709E2PlSD3Ldr6fzNP7KeicOqSC
 l3RIh4GmcyZj5xcLRYLQaLtZQX2TIvZulyQvvcXLysegQ0Kp/Agisc+zBXaOslKRYTFy
 6GLYLIY6Gjskzb4KXxVwynqDBYCVlI6Yug/NaGNOVER5GyFCpSNSEduM76znVaT3DX+e
 y7AGMJTGPclcUY3QAg5xrK0E0mjsGX4GPE2vXVtVlQoGcbM80LJq1WJm4AYhKx5rYpe8
 0+vj44pxff5GBKxUliJTbhr4Gc18QssnagHZ/nlnHUc1sHu2L7fD79rEQhoAAsgJEdBo
 COJA==
X-Gm-Message-State: AC+VfDzE5wyCEqXXIEriZShonY/kEo7KrxVr70Ns6vu4ss1zUF/BFfjn
 oPGicxx1c0f9EB6mbpVIvZR83C0XsgknUE00dynwPg==
X-Google-Smtp-Source: ACHHUZ4ePr+aNv5WaTEs2Vwz2zXOG3ts5d8d9kxLdXgS1a6iHccoMD4xg/6tUFisebJ1tHb0/XuQxg==
X-Received: by 2002:a19:644d:0:b0:4f8:6833:b13c with SMTP id
 b13-20020a19644d000000b004f86833b13cmr2228393lfj.14.1687190246197; 
 Mon, 19 Jun 2023 08:57:26 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 n7-20020aa7d047000000b0051a5a6a04a8sm1467336edo.68.2023.06.19.08.57.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Jun 2023 08:57:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 30/34] target/arm/tcg: Reduce 'helper-m.h.inc' inclusion
Date: Mon, 19 Jun 2023 17:55:06 +0200
Message-Id: <20230619155510.80991-18-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230619155510.80991-1-philmd@linaro.org>
References: <20230619154302.80350-1-philmd@linaro.org>
 <20230619155510.80991-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
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

Instead of including helper-m.h.inc via helper.h which is
included by all TCG files, restrict it to the few files
that require it.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/helper.h               | 2 --
 target/arm/tcg/m_helper.c         | 4 ++++
 target/arm/tcg/translate-m-nocp.c | 6 ++++++
 target/arm/tcg/translate-vfp.c    | 4 ++++
 target/arm/tcg/translate.c        | 4 ++++
 5 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 70ae3513e5..77c004a70c 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -95,5 +95,3 @@ DEF_HELPER_3(ror_cc, i32, env, i32, i32)
 
 DEF_HELPER_FLAGS_3(crc32, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 DEF_HELPER_FLAGS_3(crc32c, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
-
-#include "tcg/helper-m.h.inc"
diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index 0780bb3dea..45568d96bb 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -21,6 +21,10 @@
 #include "hw/intc/armv7m_nvic.h"
 #endif
 
+#define HELPER_H "tcg/helper-m.h.inc"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+
 static void v7m_msr_xpsr(CPUARMState *env, uint32_t mask,
                          uint32_t reg, uint32_t val)
 {
diff --git a/target/arm/tcg/translate-m-nocp.c b/target/arm/tcg/translate-m-nocp.c
index 7343945b41..ee9c296a98 100644
--- a/target/arm/tcg/translate-m-nocp.c
+++ b/target/arm/tcg/translate-m-nocp.c
@@ -25,6 +25,12 @@
 #include "exec/helper-gen.h.inc"
 #undef  HELPER_H
 
+#define HELPER_H "tcg/helper-m.h.inc"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen.h.inc"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
+
 /* Include the generated decoder */
 #include "decode-m-nocp.c.inc"
 
diff --git a/target/arm/tcg/translate-vfp.c b/target/arm/tcg/translate-vfp.c
index b890c7ed01..ff61c53db2 100644
--- a/target/arm/tcg/translate-vfp.c
+++ b/target/arm/tcg/translate-vfp.c
@@ -24,6 +24,10 @@
 #include "translate.h"
 #include "translate-a32.h"
 
+#define HELPER_H "tcg/helper-m.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+
 #define HELPER_H "tcg/helper-vfp.h.inc"
 #include "exec/helper-proto.h.inc"
 #include "exec/helper-gen.h.inc"
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index a71c60f4fb..4b54e177d1 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -37,6 +37,10 @@
 #include "exec/helper-gen.h.inc"
 #undef  HELPER_H
 
+#define HELPER_H "tcg/helper-m.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+
 #define HELPER_H "helper.h"
 #include "exec/helper-info.c.inc"
 #undef  HELPER_H
-- 
2.38.1


