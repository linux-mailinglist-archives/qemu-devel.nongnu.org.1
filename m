Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0AB72975A
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 12:48:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Zee-0000ok-4O; Fri, 09 Jun 2023 06:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7Zeb-0000oU-Fo
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:47:37 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7Zea-0001Bu-28
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:47:37 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3f6d3f83d0cso16190875e9.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 03:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686307653; x=1688899653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8SETXkVu42iYrYwdrPf+7GUyYB5TIaCrhCdi2IDdcRo=;
 b=SwzEPOIJTOe/tptid0t2x1uvOZLNUBzfuQjpkwTTVALykjGv2GvhAhupkeXfzNOU5c
 56QRsaCmWE8/vlTRFLMttfaG+uyScKoN56P7ObnMsgYD70GrlkcEMHpgbpDG/oIEqWV9
 i8D14x7BEpk3h4OyPndSb/EQ8rsZyTr2i0C6IiB/XYvbcXVZ3qfhsxlg6AP5YMElXCjZ
 vxH3YHIrXSNwthJcBHaoUrXKsMlfnWn2R6qu8w+bGu1O+iC4uL+eKb1RjZUNGGBcejEE
 sUAqhAAXpPM9XAYY41lOO6x3V/JBlgMWQlqu2dHhAyzqseTjAR99Z669NZ2V5sOtFj9J
 pxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686307653; x=1688899653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8SETXkVu42iYrYwdrPf+7GUyYB5TIaCrhCdi2IDdcRo=;
 b=DeBpR5T2kFaJrClj4C8pRK+m3ioVYNKgVf/ohdb9E7mFee3hz3QMqSiYDp0bqOR5w9
 rPWEYpuo88Dtj6aDC69oe7zo3s0HVoWuHaKwVDDqNIsV5JCXS0u9gUbRgMGghZ1e+eU9
 QRByGtb5X2vQSI+iZxij7eEr0r7kCtTm0dZ3t0iwSTDWbzrFexPgyQ1bO+aOcgVGx3ys
 pl2ytn5Pb23sPbgNoZ7opn92QnVb1yqAfBFBXLm2MX9lSuwsvKu4nhnmz2O8xHlTu3ET
 XHbz+y5mtIQXzrdbgD62HeEZ6eb88vmcCQGF3tWN7tXwotH2amrCriZ5LMvm+kA3+/uR
 +Lkg==
X-Gm-Message-State: AC+VfDy5ADJl6yQ2esQE/gic/yom3G0x+2K/wWttbB0Wp7KkY/yrzb7M
 Z1lFQQQaOgLYk3g4kVirIfEvM50uYTn9i+E3cAvnig==
X-Google-Smtp-Source: ACHHUZ5ikDsF7gYde7zflJX+z9oUv5KYx39T+vZURYfZEvWiiDyPa1q591x033pPm/ZOnh6Rt2/h3Q==
X-Received: by 2002:a05:6000:1cf:b0:30a:e619:3a71 with SMTP id
 t15-20020a05600001cf00b0030ae6193a71mr794048wrx.23.1686307653277; 
 Fri, 09 Jun 2023 03:47:33 -0700 (PDT)
Received: from localhost.localdomain (23.171.88.92.rev.sfr.net. [92.88.171.23])
 by smtp.gmail.com with ESMTPSA id
 t4-20020a5d4604000000b002e5ff05765esm4117651wrq.73.2023.06.09.03.47.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jun 2023 03:47:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 02/22] accel/tcg/cpu-exec: Use generic 'helper-proto-common.h'
 header
Date: Fri,  9 Jun 2023 12:46:57 +0200
Message-Id: <20230609104717.95555-3-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230609104717.95555-1-philmd@linaro.org>
References: <20230609104717.95555-1-philmd@linaro.org>
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

We only need lookup_tb_ptr() typedef.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/cpu-exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 42086525d7..12362177af 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -38,7 +38,7 @@
 #include "sysemu/cpu-timers.h"
 #include "exec/replay-core.h"
 #include "sysemu/tcg.h"
-#include "exec/helper-proto.h"
+#include "exec/helper-proto-common.h"
 #include "tb-jmp-cache.h"
 #include "tb-hash.h"
 #include "tb-context.h"
-- 
2.38.1


