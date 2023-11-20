Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1DF7F16E4
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 16:12:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r55tx-0006ZJ-Je; Mon, 20 Nov 2023 10:09:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r55tU-0005uu-81
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:09:01 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r55tG-0001H0-FK
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:08:58 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40839807e82so11558025e9.0
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 07:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700492922; x=1701097722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O3M5so5KQtqF5mm95cyn9rkcyTI0JWjubshaMltcnQo=;
 b=EaXNvAARSoxDYNDl/4Wl5cL1fUfxP9m0OHmNRObetLADqmYTz7LBVHdRgTuB4SFF4k
 Y+oJEYFOEin3z6rsQeQ5y+5D9jM7iN0TdAajettLd06KxIlraShzi3ewLJCIet2y8Hl4
 r+vgVFVM9ADbcK9IHao4laJKlVqIlI7Elrwzp4hsL1Lja9vyDU2ilR+L8cJtZoug3TUP
 Rg/ndm2I0WVcnyGBh48dcoorN8ZxlMq04tCZ5MUgppe8pg3yUP50Iwlgt2knitySd7eC
 XCYaRCPnrGFtkzQhkFJKlUuxYKen1f42s2bh7n2CghK3pGTUoT1x9mnm2Sbm2CsbJ2QI
 WrXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700492922; x=1701097722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O3M5so5KQtqF5mm95cyn9rkcyTI0JWjubshaMltcnQo=;
 b=ADmvbEDs+SIv3SLFF74LwLVaUESFyjzD0SBjzGrrfR/Arswuv0v4N2bIWmlKvW1aYr
 Faf2eeCNPZ+AjXfP4f5iTapNqK4vHqzAHXhkwCbE6zPSQb4zuY5oMCtKQe6dpRNtCJ3d
 8BXxcCIosk8RUCChnUlsvULJL8rmstQnDT4I1SAIs3rn0ld0J75YnK3k/blHyn90P3wI
 pV5fugfQ/xZ5AmrBCAOobUVIp0guaUvmyfH2881P6F1VUSfP6sSjvDEOJmH0cZmn+b2v
 A1O/Pg0ecpBtwrNzi03QfCJv0/usD8B9oxoKYJdEjPNt2nJ4I3rA95hXgl3k2Ohls1e1
 7d0w==
X-Gm-Message-State: AOJu0YxCX1tX8gBFwnkFHLWkMBbV3UxCsBTfdSBuw1IHzA4Yv6Rym+xN
 /38LhPyY6AffUTN48QJxrdW1Og==
X-Google-Smtp-Source: AGHT+IEksQ0r4JHvcvr44NsEm1g1mI2GHXdi5NLIYndv2caLqfR80ZQE9BRMSKjHlV173djZWfW4AQ==
X-Received: by 2002:a05:600c:4f87:b0:407:4701:f9e with SMTP id
 n7-20020a05600c4f8700b0040747010f9emr6883890wmq.17.1700492922440; 
 Mon, 20 Nov 2023 07:08:42 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 n23-20020a7bcbd7000000b004064ac107cfsm13599341wmi.39.2023.11.20.07.08.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 07:08:38 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E0A3765778;
 Mon, 20 Nov 2023 15:08:34 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-s390x@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Marek Vasut <marex@denx.de>,
 Thomas Huth <thuth@redhat.com>, Chris Wulff <crwulff@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 10/14] testing: move arm system tests into their own folder
Date: Mon, 20 Nov 2023 15:08:29 +0000
Message-Id: <20231120150833.2552739-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120150833.2552739-1-alex.bennee@linaro.org>
References: <20231120150833.2552739-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

Message-Id: <20231115205542.3092038-9-alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


