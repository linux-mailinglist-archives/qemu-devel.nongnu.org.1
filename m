Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAB87C80D1
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:53:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDqY-0000cm-Bu; Fri, 13 Oct 2023 04:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqK-0008Qz-Fr
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:24 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqH-00012y-Pg
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:24 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-32d8c2c6dfdso1802264f8f.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186900; x=1697791700; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ktYSo/KofsbOWp7cKckK42a+Ld8N4Tt1Ed/nkNsWmLU=;
 b=fnNAHoJEOA79HAUphlPUx5hNl0cLpfexc0Py4WRMwmakANb2Wkj5CyEHN8KEYAc0PW
 NXAcJI1gEeIwNrd6R+++LcFZtuHS7yVJVg/p/Y5GJ0JsHXaOHx8hHE4XFGEaJMmoSwnb
 n/DRB/XHjc6PZohZBq4F3clNxls8kHt54gnEP6jou3Z+tqM6FPAZAL7HsfWr3u/+wYh+
 okSHwvPuw4yvQ/sLCiyHkqg6infEOCXgQXplhgtEsm97cqnw0e0SmOxSFyP7QAMOKwtX
 EQHtGIcZOtmWQHRL28T/+V834WfrwLRACCy0chVmlp9P4Hk/rzAMk6kqgoR+rpDfIpjX
 VGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186900; x=1697791700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ktYSo/KofsbOWp7cKckK42a+Ld8N4Tt1Ed/nkNsWmLU=;
 b=p0Xrl3wBGE/8AwcGEidZ5fg3r/cjRcyn8DYPAjGB8DaNLrCKfmyE0aE8UPvAOR5BpI
 uw+/Fz4At8oRC0Ha99iwT7aRkdHYL/FPekiWu7vw7E61uTxy4DhSaO0NixlxxaI0DYPo
 i6VlsRx7vmGVB83cXYnnHlevn1WJJ6kFUW0WewSfWGPnlDmcUHzi+WNSMjv0kdjNEM3k
 BEjO8k6oxfBArmCdpGA3XZFWj0PYroHRnsqn4GNpr9+UkJzZHuC7NU0yLawKdLItCZe5
 LqNZR/nHA09tS60pJEqWazCZoY86+xuQDfQa20FVspnrH7EHIvk6KhemMbaDv/u+7a07
 lylg==
X-Gm-Message-State: AOJu0YxB5Bsi7I3uJSvM/zhx1kiLmPDqGzf9fa2gUEKsrxygx9on1i2n
 gDu9OCuggzn2dw0PWqfJ2hAl/jNUQbKAlX0I+gk=
X-Google-Smtp-Source: AGHT+IH3pEmFv1vl3cA/Gyhz0FZIwMdfaT2FEmYzw8cEAOEv03K04YmsuXJGh8Q9h4EHm1Tn7uUNbw==
X-Received: by 2002:adf:fed2:0:b0:32d:9a2b:4f86 with SMTP id
 q18-20020adffed2000000b0032d9a2b4f86mr1155534wrs.68.1697186900236; 
 Fri, 13 Oct 2023 01:48:20 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.48.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:48:19 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bin.meng@windriver.com>,
 qemu-block@nongnu.org (open list:SD (Secure Card))
Subject: [RFC PATCH v3 40/78] hw/sd/sdhci.c: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:46:08 +0300
Message-Id: <5e159bb9fdedd630c2cab239d471f0ceb678736f.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/sd/sdhci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 5564765a9b..5c641d24de 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -92,7 +92,7 @@ static void sdhci_check_capareg(SDHCIState *s, Error **errp)
         trace_sdhci_capareg("ADMA3", val);
         msk = FIELD_DP64(msk, SDHC_CAPAB, ADMA3, 0);
 
-    /* fallthrough */
+        fallthrough;
     case 3:
         val = FIELD_EX64(s->capareg, SDHC_CAPAB, ASYNC_INT);
         trace_sdhci_capareg("async interrupt", val);
@@ -136,7 +136,7 @@ static void sdhci_check_capareg(SDHCIState *s, Error **errp)
         trace_sdhci_capareg("clock multiplier", val);
         msk = FIELD_DP64(msk, SDHC_CAPAB, CLOCK_MULT, 0);
 
-    /* fallthrough */
+        fallthrough;
     case 2: /* default version */
         val = FIELD_EX64(s->capareg, SDHC_CAPAB, ADMA2);
         trace_sdhci_capareg("ADMA2", val);
@@ -150,7 +150,7 @@ static void sdhci_check_capareg(SDHCIState *s, Error **errp)
         trace_sdhci_capareg("64-bit system bus (v3)", val);
         msk = FIELD_DP64(msk, SDHC_CAPAB, BUS64BIT, 0);
 
-    /* fallthrough */
+        fallthrough;
     case 1:
         y = FIELD_EX64(s->capareg, SDHC_CAPAB, TOUNIT);
         msk = FIELD_DP64(msk, SDHC_CAPAB, TOUNIT, 0);
@@ -1839,7 +1839,7 @@ usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
          * so we artificially set it to that value.
          */
         val |= 0x7 << 12;
-        /* FALLTHROUGH */
+        fallthrough;
     default:
         sdhci_write(opaque, offset, val, size);
         break;
-- 
2.39.2


