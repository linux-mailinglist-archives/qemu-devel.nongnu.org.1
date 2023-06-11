Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BA572B106
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 11:06:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8Gv7-0001cj-OW; Sun, 11 Jun 2023 04:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8Gv4-0001Up-TZ
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 04:59:30 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8Gv2-0003a3-Ql
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 04:59:30 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3f6da07ff00so33873935e9.3
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 01:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686473967; x=1689065967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jPnCvSZ0LTnP+mwyCnVM/2nlrxmNit9JdtgjWZL7/t4=;
 b=lfGxV1Ki566549IaAA8d17ENQY4Dm9s/xfwMlcTMXHWycuhGkqRcZw/0wjxHE8I21k
 KvgCnLB0t0hHPkjLBt6ZJVvzchW1d1ELvChP021VkjbqmbKyQcP+3ISKEgofNd/RMxWe
 FprnTmIJjy/gowU1Kz0zq+SpyjKUsWyRDkQxnnmpxgCsmqemnguKVoMiZlaGX1u5g87B
 cr5NKYagDZgggiQZrZm9hV+oT28SuW23sBaZ/Koka4vHsKiOL9xQXcHhsjrnm+JE2fSb
 EBom5Luw95/YTxGbQm0uLIKe6pVEwvcAlsPK6zqy4La9voBNRWz96UQTbwBrpzv1pVho
 Ic3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686473967; x=1689065967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jPnCvSZ0LTnP+mwyCnVM/2nlrxmNit9JdtgjWZL7/t4=;
 b=hov7PISaIq62QFnNLkY3x4rzlj3Lvx1Z0uxzUMSj8Rfsf14rBTLfu9FYH8VQYZkP+6
 m0BK2gzMLUPL9Mo6UBMd3rBQ5MW+yyuzaL61npaNNOwnyn8TKuzFhF2CrHkk5MAHn0AS
 VuSPbnIho4tSpsyI4Wj8bIPewxfoEu5TfC4mFuYJFCNtMosoogIB/2NYqUNmoZ/Cs27L
 WEvPssVRpRm2tl43TL7ZR+TNXzQUo3wO6+mnqgiFIzvu1E2NPYKgvDVG+Dqyg2RfYoTj
 L+MH+BlQmoMsXkrer1M5j7A89aXE5Q4FvNSIrxGM9FWSW1GWciXII2KdWnUZgmnhqvTI
 Nhxg==
X-Gm-Message-State: AC+VfDzsiiCk1JbmSV/RhLYXHolFAa42xghMaKZt4abcsDRD/1ZWfbfN
 1Bh9CQ1vuKpVDZSBxlATrg0XoBnPYB/waaUxktY=
X-Google-Smtp-Source: ACHHUZ6TviHxRg8WMXl8/t3lLFBITCf7MqdXFBzGuuj5bQSPNc2Gmd8vAGWaKHfNyO4Ot1NXLHrJZA==
X-Received: by 2002:a05:600c:2297:b0:3f7:f544:4993 with SMTP id
 23-20020a05600c229700b003f7f5444993mr5236269wmf.20.1686473967732; 
 Sun, 11 Jun 2023 01:59:27 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 f10-20020adff8ca000000b0030fae7129e7sm3791910wrq.42.2023.06.11.01.59.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 11 Jun 2023 01:59:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 09/26] target/arm/tcg: Reduce 'helper-iwmmxt.h.inc'
 inclusion
Date: Sun, 11 Jun 2023 10:58:29 +0200
Message-Id: <20230611085846.21415-10-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230611085846.21415-1-philmd@linaro.org>
References: <20230611085846.21415-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Instead of including helper-iwmmxt.h.inc via helper.h which
is included by all TCG files, restrict it to the few files
that require it.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/helper.h               | 1 -
 target/arm/tcg/iwmmxt_helper.c    | 5 ++++-
 target/arm/tcg/translate-iwmmxt.c | 6 ++++++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index c4a321c0ea..dd12fee107 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -949,5 +949,4 @@ DEF_HELPER_FLAGS_5(gvec_uclamp_d, TCG_CALL_NO_RWG,
 #include "tcg/helper-sme.h.inc"
 #endif
 
-#include "tcg/helper-iwmmxt.h.inc"
 #include "tcg/helper-mve.h.inc"
diff --git a/target/arm/tcg/iwmmxt_helper.c b/target/arm/tcg/iwmmxt_helper.c
index 610b1b2103..ee607a3d3d 100644
--- a/target/arm/tcg/iwmmxt_helper.c
+++ b/target/arm/tcg/iwmmxt_helper.c
@@ -22,7 +22,10 @@
 #include "qemu/osdep.h"
 
 #include "cpu.h"
-#include "exec/helper-proto.h"
+
+#define HELPER_H "tcg/helper-iwmmxt.h.inc"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
 
 /* iwMMXt macros extracted from GNU gdb.  */
 
diff --git a/target/arm/tcg/translate-iwmmxt.c b/target/arm/tcg/translate-iwmmxt.c
index 57a924c578..9f6d717ee0 100644
--- a/target/arm/tcg/translate-iwmmxt.c
+++ b/target/arm/tcg/translate-iwmmxt.c
@@ -12,6 +12,12 @@
 #include "translate.h"
 #include "translate-a32.h"
 
+#define HELPER_H "tcg/helper-iwmmxt.h.inc"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen.h.inc"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
+
 #define ARM_CP_RW_BIT   (1 << 20)
 
 static inline void iwmmxt_load_reg(TCGv_i64 var, int reg)
-- 
2.38.1


