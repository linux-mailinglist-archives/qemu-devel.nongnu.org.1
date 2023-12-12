Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9219A80EBEF
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 13:36:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD1yR-0007xs-P8; Tue, 12 Dec 2023 07:34:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD1yP-0007sg-SO
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 07:34:53 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD1yM-0006kq-GQ
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 07:34:53 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a1f0616a15bso631907066b.2
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 04:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702384488; x=1702989288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=81Lrxkba5TiSEWNy5rmSbN+DrKv9XHIGlVRArHRoC/Y=;
 b=C3ya4RPFhCDuc/pU0ehFvvJl4i8hK1IjTN3lfOamjANhtPBXG1rl49uZkkcSXEOrmC
 iF14n3i1q83C4PdBcTMcePvbyfd2uWuZgvh65Z2+BiPrnA/YKm9Rw6NfdW6JozMNYFWb
 +fuExi70lUD7HdUlN4N/mTuWWWdzthEdKicXhp65OLfnIm+YV07LPFxVhj0/caTm1RsE
 shUArjcTqG2P2UXBQrIVVbpoIoEzYR1KAtqP/oDVV3xP3ce0XI8iA+Ja6rjB9woI+tn6
 Gu5i1yfABnQ3T32E2EngWMyvXn4v8CnhrfbbqrhvfFugBL+8f3iV9DBCvYnZEdKxZXSc
 0pmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702384488; x=1702989288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=81Lrxkba5TiSEWNy5rmSbN+DrKv9XHIGlVRArHRoC/Y=;
 b=h4b0KBcveTS7063jlVQi7P+pLpAMcG6hpblwOop9K0bGAqus78MtcYhjiluqg3GCaA
 a+VmXmYyfq3S+M1IsSE19722BTONeFlo8evMZjeIrpxFn9FhQ3/NToSSSbUMYPTDRqcu
 LTGtqVQ5c1Gyg8Tw2TLARH/z2wCxE8R9d4QIDNTH0h0biTQ5/IWJjR8UWSTPGo+4zDk7
 MWZRK0AWvq+GtdOAi1UncGeBjfd1+tPqrSKyyPze3kDHvSQXrwT1EkAG/HaGRJIglk/5
 ZaofTcdKroXhU4vGy7oiwpwaeP8I8l1G+WDyn6hchgbkON7Ycttg56aYvWwWg7+xAnrY
 HQIw==
X-Gm-Message-State: AOJu0YwBAXV0CDgxhsTeQFCUaS6OPFxvHaHfbqhw+00Z+sIxiekv27Oj
 0H1qmPGHTtdF/WFIWknrVqMe3YI3SdHjMQVQacLx7w==
X-Google-Smtp-Source: AGHT+IEXHKedmksOi5i+8cNWCq3xdc8whFnCDprHwI4ClL0JkDpXjFEvA15M4aXrvMqloFi9T4RFjQ==
X-Received: by 2002:a17:906:5a49:b0:9e0:4910:166a with SMTP id
 my9-20020a1709065a4900b009e04910166amr3516231ejc.32.1702384488777; 
 Tue, 12 Dec 2023 04:34:48 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 re14-20020a170907a2ce00b00a1f751d2ba4sm5517119ejc.99.2023.12.12.04.34.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 04:34:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Claudio Fontana <cfontana@suse.de>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, Brian Cain <bcain@quicinc.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 06/23] semihosting/uaccess: Avoid including 'cpu.h'
Date: Tue, 12 Dec 2023 13:33:42 +0100
Message-ID: <20231212123401.37493-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212123401.37493-1-philmd@linaro.org>
References: <20231212123401.37493-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

"semihosting/uaccess.h" only requires declarations
from "exec/cpu-defs.h". Avoid including the huge "cpu.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/semihosting/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/semihosting/uaccess.h b/include/semihosting/uaccess.h
index 3963eafc3e..6c8835fbcb 100644
--- a/include/semihosting/uaccess.h
+++ b/include/semihosting/uaccess.h
@@ -14,7 +14,7 @@
 #error Cannot include semihosting/uaccess.h from user emulation
 #endif
 
-#include "cpu.h"
+#include "exec/cpu-defs.h"
 
 #define get_user_u64(val, addr)                                         \
     ({ uint64_t val_ = 0;                                               \
-- 
2.41.0


