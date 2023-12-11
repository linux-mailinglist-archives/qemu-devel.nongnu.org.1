Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F05E480DCD3
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 22:23:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCni2-000133-I4; Mon, 11 Dec 2023 16:21:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCnhy-0000wA-5i
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 16:20:58 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCnhv-0005Lj-Fi
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 16:20:57 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a1ec87a7631so447844566b.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 13:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702329654; x=1702934454; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hdtduscqdl7lWoQvL5DT94RvR1c94dCnz5Zm14mzbGM=;
 b=HvI+Lbt0OMGxncTXfmCtUxEpk7DXjvqW4bWkxcD6aBPgh/7lafhBDKlqq2D83UUWBH
 MijxmKUwMrc/qcAvLr+04pocp7Q22lcmY0HQJARZJEnPFqxDkirBiIQWCvNWfEJCLQG+
 NkiYpS0fvA+lNDPjfsXLWXVXq1+8XPtEY/hg1mYzDLHdNTjs6bX/eEqqt9ZxQK1zEyu9
 olwSxOboJxM4WH6Bt+fKSaE3E477ZVBL5tRvDVmOjPzRfg/JPyQnaYVMnCR4ZA7SU0ms
 XPNnoi7pn5eheOTCBCQ+d0242nMvenjyoUttoTspvrsUL6xv/Jp79bFsRiuDPBGZv5e+
 lFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702329654; x=1702934454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hdtduscqdl7lWoQvL5DT94RvR1c94dCnz5Zm14mzbGM=;
 b=cDsHhZKNjHuNvyuBR/+sLMPRhLGMcxPdeOGEYxnG8Bvfeo3MDd+jIE16X//yHItwPe
 sTt3oCf90verH0oBQi4qRQBxDUuj8UghsrLWld5IYVxPlFUBIDNkwRog3jz5Dj6fB0cv
 YW5pcygT9ytrVwA7eHvmTy1ufYuxKvh0C/DMga+tgntX8TLj+9Uvh1hqb3XgSTerOdWs
 IjvOrFzD3lKAZcZJqVtAmyc88eouNJi0VHPno8/Lz7GPBTFh1Kr85kcaL3vF0Te3j/J4
 tmVq5aMhZu1As1E2wHPyZHj7JvoWypdOf3wLn/jUzSQBuThDOJoL5nv55PYP6oIjrdF3
 sTRw==
X-Gm-Message-State: AOJu0YwWXoLzI/mflkqCCZdTow/xrFNpjgDhgrNIg0x3r20cDuSI5PTh
 uQP6rqahIrWPqV7Yb0C1DKl9X6wih/0Bml2TsQPEgw==
X-Google-Smtp-Source: AGHT+IGSU6orrfEyQw8281nABb2ziCc9amYnSK9sAmfW+hjeDzK/Oj1EjnbDpucqQCNSeee/4ucj7Q==
X-Received: by 2002:a17:906:2207:b0:a1f:9f16:2cfd with SMTP id
 s7-20020a170906220700b00a1f9f162cfdmr1332861ejs.63.1702329653881; 
 Mon, 11 Dec 2023 13:20:53 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 tm6-20020a170907c38600b00a1db955c809sm5304903ejc.73.2023.12.11.13.20.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Dec 2023 13:20:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-riscv@nongnu.org, David Hildenbrand <david@redhat.com>,
 Warner Losh <imp@bsdimp.com>, Claudio Fontana <cfontana@suse.de>,
 Brian Cain <bcain@quicinc.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 05/24] semihosting/uaccess: Avoid including 'cpu.h'
Date: Mon, 11 Dec 2023 22:19:42 +0100
Message-ID: <20231211212003.21686-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231211212003.21686-1-philmd@linaro.org>
References: <20231211212003.21686-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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


