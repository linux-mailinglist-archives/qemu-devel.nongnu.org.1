Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F3B79AB77
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 23:14:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfoE5-0003fl-Ji; Mon, 11 Sep 2023 17:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfoE4-0003eq-3t
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 17:13:44 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfoE1-0005Cy-TA
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 17:13:43 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-51e28cac164so12881617a12.1
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 14:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694466819; x=1695071619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+fItrFBqz4pCpmjDHSDhxOZeNtPLgdWkJxbwSRsqucM=;
 b=UKsqnR/nr+ZD4w7SdKYkNZDKI2dcOqQCU4FZ6i9sqw03G9LKmeIvVsWVHalud1fNw6
 gfdMCEbPBdOb7+Aor06tLUEMyFe7SX09VdVNyNZ0I1q/KodCQZWSyXuYTdR0yGOgN7XL
 UhQYDKu4pjX3HBDgb+s0eKa6xGWBSgnmk5VFE/yZhBFLVAZ6dp1m4P/ZPMqsnbG73yeF
 1BIqBm0aX+s7C9o+Qdxetl2Fw+QvlrN622qAFFXOXlqy8EAioGlrw4bnynqs2IfelqM6
 7BYrYfQRTh6Z+G0uEbkPfyu8JzPmR67X85tCrUUmqCJF1J/EpZ8e0FxL4imgGLXnoSB5
 xxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694466819; x=1695071619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+fItrFBqz4pCpmjDHSDhxOZeNtPLgdWkJxbwSRsqucM=;
 b=PuSQwl7azhZAK8tpVLPQ5TgAdURjH/WMUSACikLAzipYw53upTdJhmYZ7drLpK6GR9
 XOd2rK9p1aI2eYf4Dj6zaUsYyMy0veDEFbezt3OkOX0sfCbv44YuDCWqYjdYFiQtzMJu
 s9aocqU8W0oMPeG1MjLA9o6W2zcd4xpDHMLDpS8XW8lBK9/gRU/7U88zAmDykUxf4y7Q
 iFB0IkFuj1mtdyyNddS2deJRmvj/xL+i0H6rRivO5pcBa4oxwmZ65y13If38pCC/X+yh
 tznuC1vu+CC1GUtW/d75LQgvSM4t/VVuzPW7QxR/UOiACIntsu2NFzdQozjDXudR+8RK
 +WPQ==
X-Gm-Message-State: AOJu0Yy+LFr9xJT17y9j3l004AHZaQxusuDeaNfszyrDKbLta9uDICaC
 aF/9y7hj+qrJojFhxHs0j2Qo7BYL1SYXCVRA8Vo=
X-Google-Smtp-Source: AGHT+IGfByT/i1uRgqjMTCe03exo5MUd5hVuuL5bXU9pWThAdvv0M71SxBPmrWR8igy+0e5BQCrT7w==
X-Received: by 2002:a50:ee89:0:b0:523:37f0:2d12 with SMTP id
 f9-20020a50ee89000000b0052337f02d12mr1117871edr.17.1694466819175; 
 Mon, 11 Sep 2023 14:13:39 -0700 (PDT)
Received: from m1x-phil.lan (tfy62-h01-176-171-221-76.dsl.sta.abo.bbox.fr.
 [176.171.221.76]) by smtp.gmail.com with ESMTPSA id
 c18-20020aa7d612000000b005254b41f507sm5126392edr.32.2023.09.11.14.13.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Sep 2023 14:13:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v4 3/3] target/i386: Prohibit target specific KVM prototypes
 on user emulation
Date: Mon, 11 Sep 2023 23:13:17 +0200
Message-ID: <20230911211317.28773-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911211317.28773-1-philmd@linaro.org>
References: <20230911211317.28773-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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
index 8b57708604..6be59c7b2b 100644
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


