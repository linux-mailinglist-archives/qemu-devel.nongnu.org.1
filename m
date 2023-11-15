Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 679BE7ED41D
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 21:56:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3MvW-0004ol-Od; Wed, 15 Nov 2023 15:55:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r3MvO-0004lY-MQ
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 15:55:51 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r3MvJ-00088t-96
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 15:55:48 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40842752c6eso513795e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 12:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700081743; x=1700686543; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=chmVK3hou81Te+WRxpmiwBpJ3n9D+MzLpYrVVG2m/ng=;
 b=TM4IQOfwypGioLZcfTJkFC3QUdx19hYkeIp9Ekt01ta885IMxmAV9aetYfTGp3zr3U
 PCD7nOQDPfsB/0Qcvh21uxAHUG3B5Vi/dU/9fSlH01PuuekqPShFpaXOfvP1Twsj6nhm
 GZvEc36piDf2m8WGazbUaB+gAP3ze40C3KHQYNfft9y+Geoj4/w3Rt+8tKQpk3S5K3bD
 x7VrksmfHMr7zyCwOucWF/UxkanrWe70/SL+KhDMeGig0KnipxLGInbbHAJCMPAwUXde
 bwjgeSC6bSG5aZsZhnELr0R/xDJDBYoNlGwQOK4B/l0xkvYTY1aU35QltZHbdPmdC+wb
 2d/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700081743; x=1700686543;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=chmVK3hou81Te+WRxpmiwBpJ3n9D+MzLpYrVVG2m/ng=;
 b=B+05prHFp9H1An8prZN4F5jbHXiWUhLCFUEvfPDpiPSJca/ILKEIOiz+zv/7eokAPT
 vrgYuMr15lCvXIvu5X+9zDKrX3WuPxVPd1PgGVOpf5txMbpnbKUCJb0tQIpOk2CiaXBi
 xzWajs1u+g6kWvmJhVc91ilWGQkHda2WToClxVbS0Cj6/hGvCt9jeagVqsJu4qdGpUEz
 67IwOI27MJiHmPwKc1hArO/DNUgaOZ1DhS2s4X32YpWp0v8IVgBeH3Ry0g9U95kN162A
 /OYOPcpzG8IctB8H+IhFKcqXDhvIF+qcztM0D2cnSLvSJ5nPKWOggFhpJEDyl4pIj0QD
 w/Jg==
X-Gm-Message-State: AOJu0Yyn4TogGbr6VJqg8KDS1ueB5edEc0mZ0c/Gv3b878IEqaTGqlMx
 LtjfrLVoOvXW03stDNEoDEgDHw==
X-Google-Smtp-Source: AGHT+IHRfQEBPY8Avw55iFxU7l5Xst1GxL3szRHDsMRCql/U2kYC9krBv03SVaEzi0sjYIPprWCUhg==
X-Received: by 2002:adf:ec0c:0:b0:32f:83f4:e611 with SMTP id
 x12-20020adfec0c000000b0032f83f4e611mr10108450wrn.17.1700081743395; 
 Wed, 15 Nov 2023 12:55:43 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 o11-20020a5d408b000000b0032196c508e3sm11489021wrp.53.2023.11.15.12.55.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 12:55:43 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B55AB5F76C;
 Wed, 15 Nov 2023 20:55:42 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Beraldo Leal <bleal@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 00/10] random fixes for 8.2 (tests, plugins, docs, semihosting)
Date: Wed, 15 Nov 2023 20:55:32 +0000
Message-Id: <20231115205542.3092038-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

I've just been trying to clear some of the bugs against various
subsystems. These are mostly testing changes and a minor tweak I found
while checking up on semihosting behaviour. Enabling arm-softmmu
check-tcg tests expands our testing abilities slightly for the 32 bit
side of the family.

Let me know if there are any other patches worth picking up.

The following need review:

  tests/tcg: enable semiconsole test for Arm
  tests/tcg: enable arm softmmu tests
  testing: move arm system tests into their own folder
  hw/core: skip loading debug on all failures
  docs/emulation: expand warning about semihosting
  tests/tcg: fixup Aarch64 semiconsole test

Alex Bennée (7):
  tests/docker: merge debian-native with debian-amd64
  tests/tcg: fixup Aarch64 semiconsole test
  docs/emulation: expand warning about semihosting
  hw/core: skip loading debug on all failures
  testing: move arm system tests into their own folder
  tests/tcg: enable arm softmmu tests
  tests/tcg: enable semiconsole test for Arm

Daniel P. Berrangé (1):
  tests/docker: replace fedora-i386 with debian-i686

Greg Manning (1):
  plugins: fix win plugin tests on cross compile

Philippe Mathieu-Daudé (1):
  .gitlab-ci.d/cirrus: Upgrade macOS to 13 (Ventura)

 docs/about/emulation.rst                      |   5 +-
 configure                                     |   2 +-
 hw/core/loader.c                              |   2 +-
 tests/tcg/arm/system/semiconsole.c            |  42 +++
 .gitlab-ci.d/buildtest.yml                    |  12 +-
 .gitlab-ci.d/cirrus.yml                       |   6 +-
 .../cirrus/{macos-12.vars => macos-13.vars}   |   2 +-
 .gitlab-ci.d/container-cross.yml              |  11 +-
 .gitlab-ci.d/containers.yml                   |   2 +-
 .gitlab-ci.d/crossbuilds.yml                  |  14 +-
 contrib/plugins/Makefile                      |   2 +-
 plugins/meson.build                           |   2 +-
 tests/docker/Makefile.include                 |   3 -
 .../dockerfiles/debian-i686-cross.docker      | 182 +++++++++++
 tests/docker/dockerfiles/debian-native.docker |  54 ----
 .../{debian-amd64.docker => debian.docker}    |   7 +-
 .../dockerfiles/fedora-i386-cross.docker      |  40 ---
 tests/lcitool/refresh                         |  18 +-
 tests/plugin/meson.build                      |   3 +-
 tests/tcg/aarch64/Makefile.softmmu-target     |   5 +-
 tests/tcg/arm/Makefile.softmmu-target         |  76 ++++-
 tests/tcg/arm/system/boot.S                   | 288 ++++++++++++++++++
 tests/tcg/arm/system/kernel.ld                |  24 ++
 .../tcg/arm/{ => system}/test-armv6m-undef.S  |   0
 .../tcg/arm/{ => system}/test-armv6m-undef.ld |   0
 25 files changed, 655 insertions(+), 147 deletions(-)
 create mode 100644 tests/tcg/arm/system/semiconsole.c
 rename .gitlab-ci.d/cirrus/{macos-12.vars => macos-13.vars} (95%)
 create mode 100644 tests/docker/dockerfiles/debian-i686-cross.docker
 delete mode 100644 tests/docker/dockerfiles/debian-native.docker
 rename tests/docker/dockerfiles/{debian-amd64.docker => debian.docker} (96%)
 delete mode 100644 tests/docker/dockerfiles/fedora-i386-cross.docker
 create mode 100644 tests/tcg/arm/system/boot.S
 create mode 100644 tests/tcg/arm/system/kernel.ld
 rename tests/tcg/arm/{ => system}/test-armv6m-undef.S (100%)
 rename tests/tcg/arm/{ => system}/test-armv6m-undef.ld (100%)

-- 
2.39.2


