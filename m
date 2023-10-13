Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 945BB7C7F4E
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:03:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD4v-0003iI-9l; Fri, 13 Oct 2023 03:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4f-0001sz-Nf
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:09 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4b-0006ye-QA
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:09 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-405505b07dfso18761095e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183942; x=1697788742; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=94FOLE3AewODflMphRBNbnkQLSI+z+5hLHjG8ZH95+c=;
 b=O48TNG1MbJ9kUeXJkR3NbQBdrdAvfeCMUEqmUongUpfi4OkeQP0CKle2CieDxZETXD
 agLny7wy6i1W4z8nfR5RbM4UUPkUXula8aO5Y7zndbq/+90y3jaHFx78wU0/CL3xZSaI
 /ZY+3EsvySJYcKQzk825eM6JWHNxamqiYcCtn/veT5S5ixPk+5DNPUlmyBGL+PA4GusC
 BQkCOZJXl++nRAhJDdOE7wCxHtQog5QvJj9yiRfgLN9p8QbGV7Y2mVZyyfl3GgyyizLw
 fvl1aJk6rf6k/XjJFveP4lqtCifPoSTTvmhQg364fE0Xam9vPoXxfIYbr/65YZzqlKQg
 /cZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183942; x=1697788742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=94FOLE3AewODflMphRBNbnkQLSI+z+5hLHjG8ZH95+c=;
 b=u5J9JXPvb05L6GJq2rEN07r56NMgBkBq4kse+oNZVA8VEGcFlCaglmd4spD3CkUyVs
 zZRv6+G2sEUPnF/XL1KWtqgFaS+8NOcwcoxAS441qpTDDU/re/vwPmY3fuj8l28c2qPG
 zsCymvOn/QCrhodPQwzArvqAXg4Vp9xoIANE+4eXCnWjSJVWPxmz5NMclfygGmbiWqWy
 Ds9HDCM2yiNQRHnwpVDBOVyEBJKUYj8u1mZ/8iVwOIN/llP88mwli/ChNrQUf4JQmcSk
 o8+Kbnq8lybGVjyQZyPAbTnqfwoGiDtpsLpKpbQPkC1+YECTB6Y19TvgSEkEnbDW6WJG
 sklw==
X-Gm-Message-State: AOJu0Yx0hwaWWywSx7+GqqE0wJLewomwLXf+go7u3I/saufvlyFAUHy2
 PH5Aug7/5LuLs600FQVtzlxwTt4DiD/2orQ/IBM=
X-Google-Smtp-Source: AGHT+IFiqUI4bWfUNc8ZjQufemN+N32rMPz+zYIbx+68lQLFk3H8ic2jGFFsO643owg2In6cajM1Fw==
X-Received: by 2002:a05:600c:21d7:b0:406:45c1:4dd with SMTP id
 x23-20020a05600c21d700b0040645c104ddmr19051354wmj.14.1697183941696; 
 Fri, 13 Oct 2023 00:59:01 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.59.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:59:01 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [RFC PATCH v2 38/78] system/rtc.c: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:57:05 +0300
Message-Id: <fd4aa9a42a7ec65acca8836696bb5a8c8215c88c.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


