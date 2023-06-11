Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F378572B0E9
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 11:00:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8GuX-0000wj-4D; Sun, 11 Jun 2023 04:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8GuV-0000vv-89
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 04:58:55 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8GuT-0003Wy-PO
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 04:58:54 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f6d7abe934so23008855e9.2
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 01:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686473932; x=1689065932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IqcnN0KHRLtGoEUii9PLdnN1fRMGq2pa7nlyy5bf34E=;
 b=Zn5IlRML6eagcijKlh9JGnDDOMuta5USJiO1q223b6mIWJCIax8URXH77t2TbzkGON
 oZlNbdL28efKdRqVfH9qVUn2VDtSQVkBWqvotbrUcFXhviW6t9tLx275casmOF2/bG3N
 n2qk939pVIQDsnkfDHpOK+Uz85K6ZfcXCer6HNd1KQUXMsmTJQKCNW1PgAtVXUQHwmwn
 yGjc/AupEKYsRDJCcST3g2dDkBMRxOeRhD7ucyKdj80D4LKJE9izMAg2xY7jbwjvAYyt
 EwQu4LzCjySG7JsovOXQZiT/5iZRau8rQlzo0oOI4w3alTDdiYVsEP356GgtikPv05Eb
 obow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686473932; x=1689065932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IqcnN0KHRLtGoEUii9PLdnN1fRMGq2pa7nlyy5bf34E=;
 b=gIycNAUN923Cp7Kq/oblFzZwo99p0A1ww/vWZMXWyFUf7e2a3fbu5rGddyIS9qyW8e
 OoYaWUrt/EEWwzFNIlLXjXXprCHSNVup7A3xQnaJUn6Um9qJSBBLDE45Z7O1tcOVC9hu
 ACxV/9cEsC1p9AYOJgW9hNCnziXzDTw5YvJdRLCnvXPC1Xt6HJZOf+9Qt5rCV/BNXzGN
 7b/mUX1a7MSNCu88iTQVJmNmUpWqifgB7rzJwqw99LaWO0hR1svQ/S8KuN7tOfJxXYPK
 PlT31vq01IWcG41BmfBaMiPMPe2pwpvCA50Xv8aDPUnJkCZEDdL87Uw3fy9rsN+zcyfV
 hPTQ==
X-Gm-Message-State: AC+VfDyybApirahUaNpsxJRK6sbWriyag0Te+lks4TQhyxs3Bfzz4b5u
 NtR0qJ5Ti9ywAGLlNY9gPdlBSkIzEddym4ch3nc=
X-Google-Smtp-Source: ACHHUZ5tysIoAXbe0Zfz5Xw4/Saueu/goLhCBOkSoriWHaHtaWxCjkVbMlSxvwV9WWTu+dfrOhToKQ==
X-Received: by 2002:a05:600c:2255:b0:3f8:11f6:69ff with SMTP id
 a21-20020a05600c225500b003f811f669ffmr2007877wmm.10.1686473932215; 
 Sun, 11 Jun 2023 01:58:52 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 a11-20020a05600c224b00b003f8126bcf34sm3482776wmm.48.2023.06.11.01.58.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 11 Jun 2023 01:58:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 01/26] plugins: Remove unused 'exec/helper-proto.h' header
Date: Sun, 11 Jun 2023 10:58:21 +0200
Message-Id: <20230611085846.21415-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230611085846.21415-1-philmd@linaro.org>
References: <20230611085846.21415-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 plugins/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/plugins/core.c b/plugins/core.c
index 9912f2cfdb..3c4e26c7ed 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -25,7 +25,6 @@
 
 #include "exec/exec-all.h"
 #include "exec/tb-flush.h"
-#include "exec/helper-proto.h"
 #include "tcg/tcg.h"
 #include "tcg/tcg-op.h"
 #include "plugin.h"
-- 
2.38.1


