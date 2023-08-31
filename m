Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DF178EAE2
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 12:47:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbfBP-000443-OC; Thu, 31 Aug 2023 06:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbfBB-0003dc-BZ
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:45:37 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbfB4-00044W-8M
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:45:33 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-401b393df02so6708195e9.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 03:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693478728; x=1694083528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=s00V8qsZzvUC1XcFHALZKjs4t4kYMM3LSzHUfv3Lp2w=;
 b=H6tli410nSAl/cOOAylZow8bq0X/PMOuwoh/GUEOCwZWLbaOYXFgUnsmRO95uz0o33
 bEyBuIgUrQtNsmnxG1vEKm/bGFdEemyHa6eU/xIxLKjzic9e9dbmjXlYpHRJq3u9s2Gl
 p37h499FJdBNJj8FzDYRN6pT8HeqZ3fHl8cFECJdE9X8syrNlZYfjcp/DM1bV5cFYIVC
 CjtDCWfsmt1Jmh8AwLPLwQLjWznbDua1G1WkynN3SIazH095obE3kY6yzCCTzkwkpvpQ
 LCa6bR7IkeQgp6j3NCqlRz8u5Q6J4k7MIPZn+MU1fx+mO6kqiFi8X7j8XZjzVaIgim8s
 RMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693478728; x=1694083528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s00V8qsZzvUC1XcFHALZKjs4t4kYMM3LSzHUfv3Lp2w=;
 b=AjrR/DKnLrIHdzZYEQjW4lzQEi+o9JLre3M5jM8MWv/B3JKQg12bUXsmRrt4Ip7Rwv
 eKh9PQkDOp7cC1WIei5hXTapR+2DYiEuI2iJng7bnduW1I6cMXKYacsoKvaemL0XSnZv
 nPS371ij1D3jLKq1BnFSn0A624hYHs3ifpRdiucq65mnVa7OnJZcC3ca+m5VJwaVdAKP
 HCawLCZs65wsrKhOWFqYjAkGwAzG9niEY2/0+DFFYddIunqwK950HHBZqCo/rI/bik9R
 b/iW4HJiqiaTpCeWXcklkfO810LtkAff4Hbq9JviDjG0ioEyDXMNE1Pc9Y3bVIUSBC7H
 mKEQ==
X-Gm-Message-State: AOJu0YxpQEszlLT4oKT2WzXcT/UZtC14ty3Z0Ftfng1VBsNYmLlvpDZZ
 9hj7dspNNPXpoCoNGpER6EhrapFoHmbCaGfKpTg=
X-Google-Smtp-Source: AGHT+IHv9BctU1+HNVOmJD8U+nvcwo6FsYbPiroJU/BevvSY1CFmQebJhMnCFDwCK4RBsI2wSX4PGg==
X-Received: by 2002:a5d:4088:0:b0:317:3deb:a899 with SMTP id
 o8-20020a5d4088000000b003173deba899mr3119478wrp.1.1693478728234; 
 Thu, 31 Aug 2023 03:45:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 l5-20020adfe585000000b0031c71693449sm1785524wrm.1.2023.08.31.03.45.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 03:45:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/24] hw/rtc/m48t59: Use 64-bit arithmetic in set_alarm()
Date: Thu, 31 Aug 2023 11:45:13 +0100
Message-Id: <20230831104519.3520658-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831104519.3520658-1-peter.maydell@linaro.org>
References: <20230831104519.3520658-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

In the m48t59 device we almost always use 64-bit arithmetic when
dealing with time_t deltas.  The one exception is in set_alarm(),
which currently uses a plain 'int' to hold the difference between two
time_t values.  Switch to int64_t instead to avoid any possible
overflow issues.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/rtc/m48t59.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/rtc/m48t59.c b/hw/rtc/m48t59.c
index ec3e56e84fd..2e2c849985c 100644
--- a/hw/rtc/m48t59.c
+++ b/hw/rtc/m48t59.c
@@ -133,7 +133,7 @@ static void alarm_cb (void *opaque)
 
 static void set_alarm(M48t59State *NVRAM)
 {
-    int diff;
+    int64_t diff;
     if (NVRAM->alrm_timer != NULL) {
         timer_del(NVRAM->alrm_timer);
         diff = qemu_timedate_diff(&NVRAM->alarm) - NVRAM->time_offset;
-- 
2.34.1


