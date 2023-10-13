Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1FD7C7F1D
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 09:58:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrCyL-0002z9-9Z; Fri, 13 Oct 2023 03:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCxB-0006jt-K8
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:51:27 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCwq-0004xG-Oa
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:51:20 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-32d9b507b00so385382f8f.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183463; x=1697788263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=94FOLE3AewODflMphRBNbnkQLSI+z+5hLHjG8ZH95+c=;
 b=Rd+JNnjiT9hmYEnHXiJrJRCJvmPAxZUc2Pn9mmmFPJdixmn3Qo0MlG6mWEITR0nQAn
 q4YlHOMIewfGqhdZXoOurBemBk/0i1oJ8G9Krdp8wR5MJPjSf7BV0u6FXHqVwc/BbLyJ
 H11R7xmwSB6uCBaU4ZciEDi+e2YedGfHBmYxIkJlm0HQvgA1ajDR1Qt4HPRddUK7mfz1
 w36A+ofmOCgyrAYelrWLMIwauw1Z3WDz+JBj1n522UpxEm23hTrr9wnntAgtikcXyWnV
 OG1BmtHbj00z56a0VShSmAN9eEDrYNq+ATbulyXB/6VUQOJmJXfV3uoGFLFgiSSFPzRD
 HitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183463; x=1697788263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=94FOLE3AewODflMphRBNbnkQLSI+z+5hLHjG8ZH95+c=;
 b=K6HrgTJ0iuevLzbSLYXz9LHpUnChGykvIXpUeSAWkIvUDytoz2YqXMsXdJiMCXSOez
 0HEmef6ifIIeVOVX4E/x5y/g2pZb2blEHAi9OR5J7mCrKR+udRFKrx9CACFRPDeqUjag
 LNICBEqVT/Xjs7tVbIDPaNJPdc7odYeXIRN+TNlIypijluywg3ge7dQqvEZDGCC+kgra
 Qzr2yGvXLBW9XtVyoehcqMACJwNCfYfz+tIq29rnUd+Z1pLGbnf5nCCT7ZGB+ukpV+70
 XQMRcrdWZqKW0kfLFBmIY4eKNGb3MxWPs0/ac0aVTQ9iCIL1we1r1vnHjCrs6phlEraP
 NeuQ==
X-Gm-Message-State: AOJu0YyVv8iCdmW30UAphyU8Fva9SZ8zrl2+8yZ8Wq+Md8HMMK9jGFFu
 ca5uThp1kK3SfUhDsfYRI1xjOBpzTOt4/7Wb8mk=
X-Google-Smtp-Source: AGHT+IEP8dY4aAutpXYuvstV+T+daGUFA9sK58Epub4nJT6xakKM+XCGIKMMi+j9HjOwKt3QUyT09A==
X-Received: by 2002:a05:6000:614:b0:32d:8c7d:a13a with SMTP id
 bn20-20020a056000061400b0032d8c7da13amr5054363wrb.18.1697183463114; 
 Fri, 13 Oct 2023 00:51:03 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 m8-20020adfa3c8000000b0032d7fde2d3csm7990663wrb.79.2023.10.13.00.51.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:51:02 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [RFC PATCH 38/78] system/rtc.c: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:47:44 +0300
Message-Id: <fd4aa9a42a7ec65acca8836696bb5a8c8215c88c.1697183082.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
 system/rtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/rtc.c b/system/rtc.c
index 4904581abe..bb406542c8 100644
--- a/system/rtc.c
+++ b/system/rtc.c
@@ -48,22 +48,22 @@ QEMUClockType rtc_clock;
 /***********************************************************/
 /* RTC reference time/date access */
 static time_t qemu_ref_timedate(QEMUClockType clock)
 {
     time_t value = qemu_clock_get_ms(clock) / 1000;
     switch (clock) {
     case QEMU_CLOCK_REALTIME:
         value -= rtc_realtime_clock_offset;
-        /* fall through */
+        fallthrough;
     case QEMU_CLOCK_VIRTUAL:
         value += rtc_ref_start_datetime;
         break;
     case QEMU_CLOCK_HOST:
         if (rtc_base_type == RTC_BASE_DATETIME) {
             value -= rtc_host_datetime_offset;
         }
         break;
     default:
         assert(0);
     }
     return value;
 }
-- 
2.39.2


