Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D847F6371
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 16:58:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6C4B-0005zi-Ba; Thu, 23 Nov 2023 10:56:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r6C48-0005yz-Cr
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 10:56:32 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r6C45-0002LJ-D0
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 10:56:32 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-332c7d4a6a7so655626f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 07:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700754988; x=1701359788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ioJLqOy8nUkq4xnhqJ7W94QlEYcKcmr7v1NrXI/ICuk=;
 b=Z5dYPDGCnixgV2JicqLnkrZ3NBFpp4Sfm4yaeETUi8jEihwn5KcacrfpZfwJHqLpeA
 D8WysxySWZ5Ld8L+xpMrtBja4rXjk9RrPM05WaeAsO15loPIuALRUcRU1vxaRAdg/UeI
 15IMAzCxFwjKHn6C51O3pF57cALF57HIW++vzJ4dErhs9i5vmwfkXULtypAcAX2b7yYs
 JoTx8MW8+uH6aU7lsQ85/YbWYtiGjhvLIzMK1QaXk6I8dsUwYPiOw9Nm9EOikkQz7Jxi
 G/Uw43NuYI/Rvz2COLg+HQhwbiaCL0iSVQmfkCaQIkd6O4ZujbmqBC9Ct+GkkHz0LFYV
 6dPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700754988; x=1701359788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ioJLqOy8nUkq4xnhqJ7W94QlEYcKcmr7v1NrXI/ICuk=;
 b=G8NlfcGPPy+1uVoisxcFqr8J4O2jlCdJvfF6ADjyMufRGLfaZT7OmNIWnKnZIllTWy
 /ypWqDxNylRC4f0WbAFGu8insCwCH1MG5tbM2etJE/bVU3yxYlbcb+IHDXzSXt1ClhoK
 ylJ/a86FQeWDko823KgzLAOHecL5Ol0tM3B3g1jW/5Bmixnb6knT5v29AelTsE408JuC
 DXNuLUARlqikA8/ix0J+4mTuxpvSzB8y7AQ9ZUevjJgioEmpr3GbIPpK8AAKOSI92Pte
 trnUGSwes77ywgBlvkLDsrEVv7QNQjSdaovXNY7uOr40HZchaw5nogoNsZB3CuMPUry1
 4k+Q==
X-Gm-Message-State: AOJu0YyXGgTzspB1hG/aH91+hCCUACVtVcKanO20zBwqyCJ+tIF4ykYA
 EvGPMI0GGZuGrBPcisq36a+QxQ==
X-Google-Smtp-Source: AGHT+IGsVkic60k/v14/kKBAE5V04tfbqw35DdspGylZ4BvDfnv7xPXRzPj2hK0x2QbilQmCec+3hQ==
X-Received: by 2002:a5d:5749:0:b0:332:e6b9:c5fc with SMTP id
 q9-20020a5d5749000000b00332e6b9c5fcmr501839wrw.11.1700754988089; 
 Thu, 23 Nov 2023 07:56:28 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 v5-20020adfe4c5000000b00332cb1bcd01sm1954173wrm.86.2023.11.23.07.56.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 07:56:24 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8EF7A645FF;
 Thu, 23 Nov 2023 15:56:21 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PULL 10/14] testing: move arm system tests into their own folder
Date: Thu, 23 Nov 2023 15:56:16 +0000
Message-Id: <20231123155620.3042891-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123155620.3042891-1-alex.bennee@linaro.org>
References: <20231123155620.3042891-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

Prepare for expanding the arm system tests by cleaning up the test
directory.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231120150833.2552739-11-alex.bennee@linaro.org>

diff --git a/tests/tcg/arm/Makefile.softmmu-target b/tests/tcg/arm/Makefile.softmmu-target
index 8b546e2aa3..7857ab9324 100644
--- a/tests/tcg/arm/Makefile.softmmu-target
+++ b/tests/tcg/arm/Makefile.softmmu-target
@@ -3,7 +3,7 @@
 # ARM SoftMMU tests - included from tests/tcg/Makefile
 #
 
-ARM_SRC=$(SRC_PATH)/tests/tcg/arm
+ARM_SRC=$(SRC_PATH)/tests/tcg/arm/system
 
 # Set search path for all sources
 VPATH 		+= $(ARM_SRC)
@@ -12,7 +12,6 @@ ARM_TESTS=test-armv6m-undef
 
 TESTS += $(ARM_TESTS)
 
-CFLAGS+=-Wl,--build-id=none -x assembler-with-cpp
 LDFLAGS+=-nostdlib -N -static
 
 %: %.S %.ld
@@ -20,7 +19,7 @@ LDFLAGS+=-nostdlib -N -static
 
 # Specific Test Rules
 
-test-armv6m-undef: EXTRA_CFLAGS+=-mcpu=cortex-m0 -mfloat-abi=soft
+test-armv6m-undef: EXTRA_CFLAGS+=-mcpu=cortex-m0 -mfloat-abi=soft -Wl,--build-id=none -x assembler-with-cpp
 
 run-test-armv6m-undef: QEMU_OPTS+=-semihosting -M microbit -kernel
 
diff --git a/tests/tcg/arm/test-armv6m-undef.S b/tests/tcg/arm/system/test-armv6m-undef.S
similarity index 100%
rename from tests/tcg/arm/test-armv6m-undef.S
rename to tests/tcg/arm/system/test-armv6m-undef.S
diff --git a/tests/tcg/arm/test-armv6m-undef.ld b/tests/tcg/arm/system/test-armv6m-undef.ld
similarity index 100%
rename from tests/tcg/arm/test-armv6m-undef.ld
rename to tests/tcg/arm/system/test-armv6m-undef.ld
-- 
2.39.2


