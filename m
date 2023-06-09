Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE44729784
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 12:51:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7ZgD-0006yE-64; Fri, 09 Jun 2023 06:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7ZgA-0006k2-Sz
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:49:14 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7Zg8-0001eO-V6
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:49:14 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-4f64fb05a8aso2071420e87.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 03:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686307751; x=1688899751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9vVibkDFYfG6DFhVF0ZSzLEwHPzqjB5BANscN4p9qZ4=;
 b=snXUvl+Dkxo33YpZvAGQs08bEAuQ30El4p/XugjuVXSuXKj03u5wrU6aN8mwkPLPRo
 kun/4YMok3Cr9orZTqTO9ZjGfOJgZ9UlULxMXyY2HQterlpglIgPkQxeYhdo4pbdlMAx
 MZN18La3m7W15scj9K/kmbqo/So5epWv9y9R9CbYn03yNZTgLivxM4eRwlc7Pllr/GoA
 xWYB0HwlLz3GwRdrHFcODEsSP0tCIm/BWyBs6uOjR/e/4ssU4dnrT+G5cXPxwNVUmPiF
 eVRcSUPZE1TzKtEtb1+LlhkW3gUSQ4NllDru2dBYxhUFaTAmJ8bnn4FYh3Up7x2EmHFI
 RnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686307751; x=1688899751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9vVibkDFYfG6DFhVF0ZSzLEwHPzqjB5BANscN4p9qZ4=;
 b=ObcnJOtjYsu6ukBwv7fGyg5JpqsuMMEnswb1mfBgHcf7XHLXsj7jn2Yy5JFgniKgWk
 pQNPWgrdDUbbMe8QpehVKrZ3/Q30EIgAo5iQECdERAetjiRU7LAjq+rcv0dmLNpYM+/u
 y88V8WuHGNmZFjXiiHN0ysMq+J1MqlEYBU7cKZ1BW+J5NhTUwsc8xZPjVcMdQ4IVK0i+
 1AsCnR4y4EH8HcuUOcd1NcmZuobyrT/pfUT1eOMHHIIajNJUceBvZ0MO6zIjp6lHobwN
 eAfnzZUmf1y3y3K+EqyqfJQqTPySAuA2rzZs0HNgd9iAXrMbYa/mi2pbHVCXqxEY8c+t
 WaZw==
X-Gm-Message-State: AC+VfDxtKlteQrJpcy//Qb4nYz5F7UTe4uf0v0c4pKTsxTiDKp5vkFno
 dKkpacOjm8ANb627jI/deYACNXxzd1yRp4+0rUxNSg==
X-Google-Smtp-Source: ACHHUZ5xVSfR2DthlP0mxfLbIb8FTLIx5Ijkja8J5oTfYXuB329z44/c0vi7rt1aMcrp52QOngLVRQ==
X-Received: by 2002:a05:6512:b0e:b0:4f3:bb14:6bac with SMTP id
 w14-20020a0565120b0e00b004f3bb146bacmr599722lfu.56.1686307750991; 
 Fri, 09 Jun 2023 03:49:10 -0700 (PDT)
Received: from localhost.localdomain (23.171.88.92.rev.sfr.net. [92.88.171.23])
 by smtp.gmail.com with ESMTPSA id
 w11-20020a1cf60b000000b003f7ff6b1201sm2231660wmc.29.2023.06.09.03.49.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jun 2023 03:49:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 17/22] target/arm/tcg: Reduce 'helper-mve.h.inc' inclusion
Date: Fri,  9 Jun 2023 12:47:12 +0200
Message-Id: <20230609104717.95555-18-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230609104717.95555-1-philmd@linaro.org>
References: <20230609104717.95555-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12b.google.com
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
 target/arm/tcg/mve_helper.c    | 5 +++++
 target/arm/tcg/translate-mve.c | 6 ++++++
 target/arm/tcg/translate.c     | 5 +++++
 4 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 8983489cf0..4e431c2116 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -560,5 +560,3 @@ DEF_HELPER_FLAGS_5(gvec_uclamp_d, TCG_CALL_NO_RWG,
 #include "tcg/helper-a64.h.inc"
 #include "tcg/helper-sme.h.inc"
 #endif
-
-#include "tcg/helper-mve.h.inc"
diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 9914f45b16..fc003b7c7d 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -32,6 +32,11 @@
 #include "exec/helper-gen.h.inc"
 #undef  HELPER_H
 
+#define HELPER_H "tcg/helper-mve.h.inc"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen.h.inc"
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
index 7bfced1bc6..da3e0445b2 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -34,6 +34,11 @@
 #include "exec/helper-gen.h.inc"
 #undef  HELPER_H
 
+#define HELPER_H "tcg/helper-mve.h.inc"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+
 #define HELPER_H "helper.h"
 #include "exec/helper-info.c.inc"
 #undef  HELPER_H
-- 
2.38.1


