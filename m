Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6405D7ED41C
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 21:56:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Mvb-0004vd-3y; Wed, 15 Nov 2023 15:56:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r3MvV-0004oD-Sc
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 15:55:57 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r3MvQ-0008C2-Mi
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 15:55:57 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4083cd3917eso446635e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 12:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700081751; x=1700686551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n/NN7es3+1CZ0EFlUnLqZA7cRnxMs3Z1B4jfSUDxuyM=;
 b=F98uRXF/7MYSytcK8ZFqplcaqtdKuqiZyPyrMGAJ11lnS952waA1DhKosh4Ghnklk3
 WhBIWRs8UCwe8SMxPIapctUQqFb2OENGJ07SQ2ASWU/YsoeEtYCyOsqmrGnfjg7k+v7w
 fjSOgQ4mz620lwijDaucgZuvHpSCL2G5OtOxGAAafF2M3/UBA52qOBhm/URbczMUslJP
 C3fahJ3akb8E+Ve+Ljpep/qFTBkws9TDA0wfc8tnm0vd0MpwltGBXExbgUSq2xWppz+X
 gfo/uKhgJ2v8PRgXNS7djykmje1qI9f+KNjt5sBW+FtenZ4JXpIacKQWrBGHtjjZvd7y
 aRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700081751; x=1700686551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n/NN7es3+1CZ0EFlUnLqZA7cRnxMs3Z1B4jfSUDxuyM=;
 b=lj3iXCXUpaL6Tc1fyT/klUn6lY8YwpBn7qhBYJAA+MU2LcJZdaw3970gmJ3JpKsipO
 AQ+CBRvqbfj2Cy3RwSXVbUo8Lu9SfIusw8IamMiZs39oW7/2jUcr4CRpcq3GvX2OojIq
 ESP6cl1qKeXqqG9vJA0JOm6riBO6IU4ThV5rHbu1zHIoYwManeakIDNk23CM2Snfzm/9
 0dhZb+o7+F3VfYbJggWwx7WwlyVmi5FUh+B76zgbxHIyQxqSn2EiysT1RcTkcF5508Xa
 AZTcqokScB56Z19uu+wmH3DJQ7QbKSeL4E4B0VtGWgozB4zYdMVcwESUr/n/AeTbgf0T
 Ov9A==
X-Gm-Message-State: AOJu0Yzz7zCWRj9/9lvWqtB8V+C11QpuIaSKst9QCaOokPoAK6zV6dIb
 qVC6iVai2sX3RDc9fZT9XrWLUESZChEVCaPS8BJYFw==
X-Google-Smtp-Source: AGHT+IEQIM+qljeThCkmguttYEHfvGU6NsByrKr1pQdx/A2QHjvuu+EOjURlQ/F2LxgjlscJgp1vgg==
X-Received: by 2002:a05:600c:45c9:b0:405:40ab:7693 with SMTP id
 s9-20020a05600c45c900b0040540ab7693mr11590077wmo.31.1700081750916; 
 Wed, 15 Nov 2023 12:55:50 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 n20-20020a05600c4f9400b004060f0a0fd5sm884470wmq.13.2023.11.15.12.55.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 12:55:46 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 766D25F76C;
 Wed, 15 Nov 2023 20:55:43 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Beraldo Leal <bleal@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 08/10] testing: move arm system tests into their own folder
Date: Wed, 15 Nov 2023 20:55:40 +0000
Message-Id: <20231115205542.3092038-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231115205542.3092038-1-alex.bennee@linaro.org>
References: <20231115205542.3092038-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

Prepare for expanding the arm system tests by cleaning up the test
directory.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/arm/Makefile.softmmu-target           | 5 ++---
 tests/tcg/arm/{ => system}/test-armv6m-undef.S  | 0
 tests/tcg/arm/{ => system}/test-armv6m-undef.ld | 0
 3 files changed, 2 insertions(+), 3 deletions(-)
 rename tests/tcg/arm/{ => system}/test-armv6m-undef.S (100%)
 rename tests/tcg/arm/{ => system}/test-armv6m-undef.ld (100%)

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


