Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F567922B6
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 14:40:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdVL4-000357-RI; Tue, 05 Sep 2023 08:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdVL1-00034o-QE
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 08:39:23 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdVKx-0003UZ-Sd
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 08:39:21 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-31aec0a1a8bso1618750f8f.0
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 05:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693917558; x=1694522358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HwtR8ST5C2gT9QZH0W0hWxDT0SVcL1yuloYQ+/FZKU8=;
 b=enHfNXJ6/G/OSApqsrXuy5z56B1krSQo4K4MHrR6zvbGl/kqU8CEq19jnJSqaP9Yqf
 XFGZgjwJSInsRsA2GscyXatRYMv0TF7Tl2Hi7VJXPeS0Fnh+0k3oE1/Vj2Rnd6oFKS7k
 Fc3syAr6W9Zz65bTZ0h8LOutckH0QyK66AdiViMcTiv70L7R8kwbxCj/JByJqRQRGbhn
 OxXFlrRkSyY2NNxYWtW3z6GUQUE0+w1ttWE7Lk0j5sz2ABpiitywr8qnHf789N0Pyfim
 duyF+mtwU6aavMBsvKJhv+BzXRRbbwinLmeb51TQkWhYWkrTJjhgfSdnAdDUbt/zFByf
 u49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693917558; x=1694522358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HwtR8ST5C2gT9QZH0W0hWxDT0SVcL1yuloYQ+/FZKU8=;
 b=eAMnIl1Ys+2GCiJ7Kr0e3mN+D3XVLPxqMXdH272I2Vv+x0IKDX6g5Jbs5uRA7+UY3F
 f/1xTs3zmFM6uPDjUniIa7eLwooKRpQR3l1IXYze7sQ/7zr3wHuUwcMgWu/+VQWMV/5m
 iT02qOkEOMf1trqJmpTI4oPJx/IxDZZToAfrJwidugi1s9kcquEvvDsYEXWrRtFZOl/b
 DLm1e5Yg2dFkY0PGs2q5Aoof9EOaOOM3mgnC2c9LVYjTvXPoEmkUWrU36xpoBtTaHV7B
 LufqnXnZmpV9R8AtJZplJRgEh0HsA/T7ZfvzVtqnI82RkmffWcBivZAkg2tra/yKupEv
 se9g==
X-Gm-Message-State: AOJu0YxO8bhNbcBm07NjqFQmAsYgOwnYyhXM0utZKfHH0ZVnrpcLOoYh
 6PzJ8PJPVQrnQ82IFshNiCg9yMzrVwJTWUIxEf8=
X-Google-Smtp-Source: AGHT+IHjtynQsibAxHHekZngWfgK1CqFG8o73F0HzryQaZvImD9LI005+xJy4OmITbPd1s9w45melQ==
X-Received: by 2002:a5d:4f0d:0:b0:317:e68f:e1af with SMTP id
 c13-20020a5d4f0d000000b00317e68fe1afmr12500415wru.20.1693917557770; 
 Tue, 05 Sep 2023 05:39:17 -0700 (PDT)
Received: from localhost.localdomain ([37.69.27.38])
 by smtp.gmail.com with ESMTPSA id
 x2-20020adff0c2000000b0031971ab70c9sm17402964wro.73.2023.09.05.05.39.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Sep 2023 05:39:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] sysemu/kvm: Restrict hvf_get_supported_cpuid() to x86
 targets
Date: Tue,  5 Sep 2023 14:39:06 +0200
Message-ID: <20230905123906.6880-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230905123906.6880-1-philmd@linaro.org>
References: <20230905123906.6880-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

hvf_get_supported_cpuid() is only defined for x86 targets
(in target/i386/hvf/x86_cpuid.c).
Its declaration is pointless on all other targets.

All the calls to it in target/i386/cpu.c are guarded by
a call on hvf_enabled(), so are elided when HVF is not
built in. Therefore we can remove the unnecessary function
stub.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/sysemu/hvf.h       | 3 ---
 target/i386/hvf/hvf-i386.h | 2 ++
 target/i386/cpu.c          | 1 +
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
index 4037cd6a73..4a7c6af3a5 100644
--- a/include/sysemu/hvf.h
+++ b/include/sysemu/hvf.h
@@ -20,13 +20,10 @@
 #include "cpu.h"
 
 #ifdef CONFIG_HVF
-uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
-                                 int reg);
 extern bool hvf_allowed;
 #define hvf_enabled() (hvf_allowed)
 #else /* !CONFIG_HVF */
 #define hvf_enabled() 0
-#define hvf_get_supported_cpuid(func, idx, reg) 0
 #endif /* !CONFIG_HVF */
 
 #endif /* NEED_CPU_H */
diff --git a/target/i386/hvf/hvf-i386.h b/target/i386/hvf/hvf-i386.h
index 243bc111cc..e99c02cd4b 100644
--- a/target/i386/hvf/hvf-i386.h
+++ b/target/i386/hvf/hvf-i386.h
@@ -16,6 +16,8 @@
 #ifndef HVF_I386_H
 #define HVF_I386_H
 
+uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx, int reg);
+
 void hvf_handle_io(CPUArchState *, uint16_t, void *, int, int, int);
 
 /* Host specific functions */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 00f913b638..6789384bec 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -26,6 +26,7 @@
 #include "tcg/helper-tcg.h"
 #include "sysemu/reset.h"
 #include "sysemu/hvf.h"
+#include "hvf/hvf-i386.h"
 #include "kvm/kvm_i386.h"
 #include "sev.h"
 #include "qapi/error.h"
-- 
2.41.0


