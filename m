Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F5676993C
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 16:16:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQTgb-0005a3-1k; Mon, 31 Jul 2023 10:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQTgS-0005WX-Go
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 10:15:40 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQTgP-0007eT-Pi
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 10:15:40 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fbc5d5746cso49716645e9.2
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 07:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690812936; x=1691417736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IRJJsXiQGVscOzwBrvnsqBjJfHH56GzCgg2J9O7gwx0=;
 b=uxeB1ZzkopKK73UMeuz+c3AxaygULbEBZEGT7Pyfuwmdu+TqS/mtrbPzKjBJKpuBHG
 IUI9y6oQw3z08sgSqf1tfMJ3QPNq+yagO18HhLWSWcdprtedSLqTm4oy2WCiAEUSsPEv
 FHa+gGBRR1c08SqV6WdqnMXoY3X84x4OIQx9ijKMJV3hDs3cizqOAptu0BpMU8vsuIaU
 ZoxWX0VUMFkCkwXGk6b+X2YqlT8eQTR5RnuNhb7FXGZmtVEq1chCyKWYgmqJC6F4d6Dy
 8oiZ4KV3tBrMkAikbidCcbkB7GZ8iLI6cDmjB6xBVv3tgzeoPsu6kEmTH10YXJFKHvTZ
 5B1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690812936; x=1691417736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IRJJsXiQGVscOzwBrvnsqBjJfHH56GzCgg2J9O7gwx0=;
 b=MhR//X9ntfC2YuvnbC5zxadsua7qNJAXYPHmhxm3/6uVTRgCkjBxiJg4s2/fPQQgpc
 OEexS4I9Zo5BOzjIwffcAl+KZEwBXv4DSRz0EP6chPVAFeoSSRu1Wz8bc1rInZnvvin+
 ekdEj8xcD3uXSypPEa+lG/CfvX3HsXY985c/18JA7g5CnSUsXsH3+7JBp3VK4uAWN2KV
 NrAH6FjGhBLhxtNdKw4p805dnrCYeIdbZd/Kox+/R3ZeIMsoU1LS4INW7CkEvKlZfDjx
 fjc7ShlUldN/LzwkveqyD4CIkdbomc583KRFiNaKpdHCd1kK8Q3WQj7YltdT8sc3whLD
 Hh5w==
X-Gm-Message-State: ABy/qLb2fXz6dUNb5IaF2wLcsXa8ubDKtFsf3Q/xe3mTijl6FfxYuJ3c
 wsfLB6AEWmkTHCvYTzaNjxGlqllqTLgG+UmwKto=
X-Google-Smtp-Source: APBJJlE9lXKlYmNfKeuZuUET56z4AGdSedb/jWaxtytphZSzNnaTQEBJ9pbI1Q+Ivq4B1c3/kvVeMw==
X-Received: by 2002:a7b:cb86:0:b0:3fa:9538:963e with SMTP id
 m6-20020a7bcb86000000b003fa9538963emr37649wmi.36.1690812936227; 
 Mon, 31 Jul 2023 07:15:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a05600c114f00b003fbb5506e54sm11450675wmz.29.2023.07.31.07.15.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 07:15:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/6] elf2dmp: Don't abandon when Prcb is set to 0
Date: Mon, 31 Jul 2023 15:15:29 +0100
Message-Id: <20230731141533.3303894-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731141533.3303894-1-peter.maydell@linaro.org>
References: <20230731141533.3303894-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Prcb may be set to 0 for some CPUs if the dump was taken before they
start. The dump may still contain valuable information for started CPUs
so don't abandon conversion in such a case.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Message-id: 20230611033434.14659-1-akihiko.odaki@daynix.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/elf2dmp/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index 89f0c69ab0f..6d4d18501a3 100644
--- a/contrib/elf2dmp/main.c
+++ b/contrib/elf2dmp/main.c
@@ -316,6 +316,11 @@ static int fill_context(KDDEBUGGER_DATA64 *kdbg,
             return 1;
         }
 
+        if (!Prcb) {
+            eprintf("Context for CPU #%d is missing\n", i);
+            continue;
+        }
+
         if (va_space_rw(vs, Prcb + kdbg->OffsetPrcbContext,
                     &Context, sizeof(Context), 0)) {
             eprintf("Failed to read CPU #%d ContextFrame location\n", i);
-- 
2.34.1


