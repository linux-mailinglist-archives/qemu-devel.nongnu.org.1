Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1737579E3C7
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 11:31:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgMD8-0001JZ-57; Wed, 13 Sep 2023 05:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgMD1-0001Iz-D5
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 05:30:55 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgMCz-0002ME-5U
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 05:30:55 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40037db2fe7so70558695e9.0
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 02:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694597450; x=1695202250; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jtT3ML1tHJnWRfmIXQrD6YCHmxZTPOtervgh4drQU7s=;
 b=wyNU+9QIuqMCKmLMuDVDitnZ9U2QI4gOrUOvDogfi5g/eXEY3JeqLu+i9+ey11C5gj
 6Uzzhm02qLc8nq70C7SMk2Kb1oOencxz0rBgbVDtw5C8FpDt1mrVRKs7hZwUTrO+2wxh
 /Yb4+bJPtwb3SIKlxi2LC8Vm4uLp3SvijNkt3ltsSNWYZO1BpvoCn0+ADbe6EcHsSLsR
 frU82Q8MPNQUfa6MfzdQ+XFyCkgpX0EcWjPmnWRk02Yxig+t03P/NvGCnKdZqMPl1cZu
 kPED3u4zfpS1tvXN4M1l3h+Bn/RkJ/vIaC/oEPyyrn0s3HE3LALhyCSGLG7R4XN52cL+
 5kjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694597450; x=1695202250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jtT3ML1tHJnWRfmIXQrD6YCHmxZTPOtervgh4drQU7s=;
 b=Ngl/74MDcxPDIb9luUwgdxI/VUkK8CMbsDyd642dHPDsEqojC8CEpKakvVMcdYnT2X
 Zg58L+KIe0bGFNDU4sbvg4YcEAvgmrfN7rXxQx/F2R/fLogQUDCDxCXOBoqJqVOsgGjf
 t4Mk73Ky7qWe6/rYSsfGfSa4dO30jy0ir29QsRZHP7SjXxhF4fFT7URpm326SfLPxEtb
 RGWmRsaGWNvarrX3LWaQe97wAH8iIUAUPyf3qo6513opfCxw3Bv6W95Iv0BaGvi4m/D3
 d0HK6935xDYzFZiUi0e4BYkfqCL/7v8EpQXJdYjq40WTdJE2Y39XyMlJH82KqbFVHH5/
 sdcA==
X-Gm-Message-State: AOJu0Yy3j/eFCMdHItsap4RmuwRHjUQ5zqwXWVCWLmeQtnOrom22A7vy
 s9HkcJIejuQcPHWypVZrqXeEHuTjBj3C3sk6ad4=
X-Google-Smtp-Source: AGHT+IGD2WPDLCyweINrRoQof3jTKC1mX87q6WXI/fyFE1kXJNwVQRZhwnclukg8a31JArVaogLfzA==
X-Received: by 2002:a7b:c397:0:b0:402:ea6f:e88f with SMTP id
 s23-20020a7bc397000000b00402ea6fe88fmr1496700wmj.5.1694597450118; 
 Wed, 13 Sep 2023 02:30:50 -0700 (PDT)
Received: from m1x-phil.lan (176-131-211-241.abo.bbox.fr. [176.131.211.241])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a1c790e000000b003fe4ca8decdsm1465100wme.31.2023.09.13.02.30.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Sep 2023 02:30:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 6/6] target/i386: Prohibit target specific KVM prototypes
 on user emulation
Date: Wed, 13 Sep 2023 11:30:08 +0200
Message-ID: <20230913093009.83520-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230913093009.83520-1-philmd@linaro.org>
References: <20230913093009.83520-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

None of these target-specific prototypes should be used
by user emulation. Remove their declaration there, so we
get a compile failure if ever used (instead of having to
deal with linker and its possible optimizations, such
dead code removal).

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/kvm/kvm_i386.h | 4 ++++
 target/i386/cpu.c          | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 55d4e68c34..5ef73f0a1c 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -13,6 +13,10 @@
 
 #include "sysemu/kvm.h"
 
+#ifdef CONFIG_USER_ONLY
+#error Cannot include kvm_i386.h from user emulation
+#endif
+
 #ifdef CONFIG_KVM
 
 #define kvm_pit_in_kernel() \
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c201ff26bd..db8ed6284d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -26,7 +26,7 @@
 #include "tcg/helper-tcg.h"
 #include "sysemu/reset.h"
 #include "sysemu/hvf.h"
-#include "kvm/kvm_i386.h"
+#include "sysemu/kvm.h"
 #include "sev.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
@@ -40,6 +40,7 @@
 #include "exec/address-spaces.h"
 #include "hw/boards.h"
 #include "hw/i386/sgx-epc.h"
+#include "kvm/kvm_i386.h"
 #endif
 
 #include "disas/capstone.h"
-- 
2.41.0


