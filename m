Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2049A735BA6
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 17:57:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBHEz-00078g-KI; Mon, 19 Jun 2023 11:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBHEw-00073x-T9
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:56:26 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBHEv-00053A-0w
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:56:26 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5186a157b85so5216465a12.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 08:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687190183; x=1689782183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z2jMOqP0txK9r7JLBWhB+MQlTl1Nm4HNVxv5EqHk7Co=;
 b=HvJ5gDfbl9YzJXddB419cG8Jy22v7qYW+IWMmXC/NguxSSjFaRbwjLywt/708UxNFa
 631CEdOWHKNwQ9/WekHHt6bC5tShbjBsUIRTBwbf+A15Aj/A7w81s6SqMN3DdrNXhNIy
 GR8zMDHLYcDrTd0IGdbWohjS6NebK6xOjIQrgBhtdeHFRuz67Q7twvsRtsI4eTUJ4tgw
 yWc4y9p7JreLrr5Sr6xLheMXK6Mn6tgdelFKZgd3gHTcj2RhCyw+y9VNKoxe05EZLYHx
 HTKUyJ0+86MEmfTx9/N2pJy8IpYeHkCkmyGxKhnCEzPA1W9qv5IdtBK7ML5x35cwpzrg
 275w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687190183; x=1689782183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z2jMOqP0txK9r7JLBWhB+MQlTl1Nm4HNVxv5EqHk7Co=;
 b=VEruCoIkWCClLXPHj8JgYJ4x2M1ThlOSM23XxwL4Uey3ogvBRvgYUxsIfkujQS68Kt
 ALW/8o7uJuUmIlB+olBohSFMfvpaxwns6dFOqhK5CIclbQJbXcegjHKEpArhf5Xke8Ce
 Er9T7lgdToQKiEQnBtfTauz4Fcftv8A3ekdIZ0Eodw9ZUIWfJX9SosYfaX7sHPtMw9qh
 yhcQJg5KiHdXIvWb0Cah3J+vjaEkRBMXdUuNKRbdsBYtEFuoUGxN7HvI1Dxl2tf+BQUh
 2yl+F9BusKOrN5U8JKWRvqudZFrfQ5XB0DtSIOf0uKLLvPQ8Tgzar+Q+O/iQEOKiAzIT
 mvhQ==
X-Gm-Message-State: AC+VfDy+J+rLQ92uoPhMvyxIbJ9H5yEDAS/mmfbqE0we88NmAV1e3OOu
 kRlmVqLH7/dNtcaxLoYNMYxkfKt6j8j9ny6hHK0X8w==
X-Google-Smtp-Source: ACHHUZ5/TO4znGw5YV4zIxMYeL9r1Yxj/o6nIUf+wVYMOa/pxSpiYdMMCVbnbpn6dWcH7wRzWHNumQ==
X-Received: by 2002:a17:907:1c07:b0:94a:8291:a1e3 with SMTP id
 nc7-20020a1709071c0700b0094a8291a1e3mr10347732ejc.74.1687190183292; 
 Mon, 19 Jun 2023 08:56:23 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 lo25-20020a170906fa1900b0098692f1b803sm4425152ejb.166.2023.06.19.08.56.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Jun 2023 08:56:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 20/34] target/arm/tcg: Reduce 'helper-sve.h.inc' inclusion
Date: Mon, 19 Jun 2023 17:54:56 +0200
Message-Id: <20230619155510.80991-8-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230619155510.80991-1-philmd@linaro.org>
References: <20230619154302.80350-1-philmd@linaro.org>
 <20230619155510.80991-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

Instead of including helper-sve.h.inc via helper.h which
is included by all TCG files, restrict it to the few files
that require it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/helper.h            | 1 -
 target/arm/tcg/sve_helper.c    | 4 ++++
 target/arm/tcg/translate-sme.c | 4 ++++
 target/arm/tcg/translate-sve.c | 6 ++++++
 target/arm/tcg/vec_helper.c    | 4 ++++
 5 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index f347305c0f..38d3d1a2f3 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -148,7 +148,6 @@ DEF_HELPER_FLAGS_3(crc32c, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 
 #ifdef TARGET_AARCH64
 #include "tcg/helper-a64.h.inc"
-#include "tcg/helper-sve.h.inc"
 #include "tcg/helper-sme.h.inc"
 #endif
 
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 8a0d966aae..79a42af591 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -33,6 +33,10 @@
 #include "exec/helper-proto.h.inc"
 #undef  HELPER_H
 
+#define HELPER_H "tcg/helper-sve.h.inc"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+
 /* Return a value for NZCV as per the ARM PredTest pseudofunction.
  *
  * The return value has bit 31 set if N is set, bit 1 set if Z is clear,
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 24796e5d9e..e63b9883a9 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -25,6 +25,10 @@
 #include "exec/helper-gen.h.inc"
 #undef  HELPER_H
 
+#define HELPER_H "tcg/helper-sve.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+
 /*
  * Include the generated decoder.
  */
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 605cce0979..87f92b4d1d 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -26,6 +26,12 @@
 #include "exec/helper-gen.h.inc"
 #undef  HELPER_H
 
+#define HELPER_H "tcg/helper-sve.h.inc"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen.h.inc"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
+
 typedef void GVecGen2sFn(unsigned, uint32_t, uint32_t,
                          TCGv_i64, uint32_t, uint32_t);
 
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index b0aaca38e7..99f81df9e1 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -37,6 +37,10 @@
 #include "exec/helper-proto.h.inc"
 #undef  HELPER_H
 
+#define HELPER_H "tcg/helper-sve.h.inc"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+
 /*
  * Data for expanding active predicate bits to bytes, for byte elements.
  *
-- 
2.38.1


