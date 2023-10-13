Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2154E7C80D7
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:53:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDtc-000268-0R; Fri, 13 Oct 2023 04:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDsi-00077w-K3
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:50:53 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDsf-0001ad-L6
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:50:52 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-31fa15f4cc6so1718235f8f.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697187044; x=1697791844; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0VENQfQUdQ3dL4N/9O98oBVereDcK/ooYXylgOlWI+E=;
 b=ZWXJ+kIaPhGcJt5JJ0Hqd+UgFEc9KJpTPtOlMA41CXU7pImfB+FXjezgw9fxOmz7WS
 KspRZga+VEeJWRm+bFqPl5Byv9JVYEafqw7r7/GcMeJdLDPB0PMRLAngxz4B9xNNh5NV
 sFahLV6RONDTMizN3zrqXWqTRGpFtzvBZ1CEMriUUgE9JfW3UXYwmN88DBZXFES0D9wf
 acqEXBT13pAqPuZCSfLbUjgsjSRDoArvA2tOogOVRXQsJ8D5hl4UJubpl0U++7Lm37nU
 3X2ncPwrl4MJTWsXYM+Cvaho2k+xtsEuK1Jj+BhBbjZFXnG4URceaeeKrlmxJYYUUn+o
 Nwtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697187044; x=1697791844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0VENQfQUdQ3dL4N/9O98oBVereDcK/ooYXylgOlWI+E=;
 b=hEoVpstFYsppYA4uF74qd44LMDnqIdX2ximzAmRLcu7OB9XPz5CBWI3l1FC077S8E3
 3UojKE8DTuA7r3HOBn2t3p8peycSAfZbdi+TpvDwRetm+SfrJ2eaOkXUpQ5gKneMGl9I
 o/XMP5l24Fi/d6leAUfX13uXWUzRnRdZggeNvBqr7jhVkwGBn/MoTVvdZ10QBv3OcU7P
 vEiVtzcmTHT7k4TSGgolh6bltRJXkRUrL7udgwygvoFkQ7bRL9G51Xa+4vBjZyaPuqML
 wefTbVjY8QPlvPMNYEPU29X2tDc58mrP0v0rRYVtzi8BHvg90yrkwZdoyimggFB9k/Pw
 m54Q==
X-Gm-Message-State: AOJu0YzCZKYpTyLls+gg8CsfhOzKd/7TqGGWOA1SxPIhsFph7/DDoSYs
 rPVyRls/csZTH6r8cY2e71NYSM0iZv57kEXnGYo=
X-Google-Smtp-Source: AGHT+IEZFgIIjFOitffkxPXEZzaw6u/O9TGeoQJbRdjX8E6nB2HWqfbhqIIqcmjjvsKWHkdEAdqzlw==
X-Received: by 2002:adf:f103:0:b0:32d:9cd3:6a9d with SMTP id
 r3-20020adff103000000b0032d9cd36a9dmr948807wro.25.1697187044813; 
 Fri, 13 Oct 2023 01:50:44 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.50.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:50:44 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Joel Stanley <joel@jms.id.au>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org (open list:ASPEED BMCs)
Subject: [RFC PATCH v3 70/78] hw/rtc: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:46:38 +0300
Message-Id: <7bad24a9243a3d9f0190e2f89c86aa68816de5d6.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x435.google.com
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
 hw/rtc/aspeed_rtc.c  | 4 ++--
 hw/rtc/mc146818rtc.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/rtc/aspeed_rtc.c b/hw/rtc/aspeed_rtc.c
index fa861e2d49..59c64b01b9 100644
--- a/hw/rtc/aspeed_rtc.c
+++ b/hw/rtc/aspeed_rtc.c
@@ -78,7 +78,7 @@ static uint64_t aspeed_rtc_read(void *opaque, hwaddr addr,
         if (rtc->reg[CONTROL] & RTC_ENABLED) {
             rtc->reg[r] = aspeed_rtc_get_counter(rtc, r);
         }
-        /* fall through */
+        fallthrough;
     case CONTROL:
         val = rtc->reg[r];
         break;
@@ -106,7 +106,7 @@ static void aspeed_rtc_write(void *opaque, hwaddr addr,
         if (!(rtc->reg[CONTROL] & RTC_UNLOCKED)) {
             break;
         }
-        /* fall through */
+        fallthrough;
     case CONTROL:
         rtc->reg[r] = val;
         aspeed_rtc_calc_offset(rtc);
diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index c27c362db9..6b6eef94fd 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -457,7 +457,7 @@ static void cmos_ioport_write(void *opaque, hwaddr addr,
             break;
         case RTC_IBM_PS2_CENTURY_BYTE:
             s->cmos_index = RTC_CENTURY;
-            /* fall through */
+            fallthrough;
         case RTC_CENTURY:
         case RTC_SECONDS:
         case RTC_MINUTES:
@@ -686,7 +686,7 @@ static uint64_t cmos_ioport_read(void *opaque, hwaddr addr,
         switch(s->cmos_index) {
         case RTC_IBM_PS2_CENTURY_BYTE:
             s->cmos_index = RTC_CENTURY;
-            /* fall through */
+            fallthrough;
         case RTC_CENTURY:
         case RTC_SECONDS:
         case RTC_MINUTES:
-- 
2.39.2


