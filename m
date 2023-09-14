Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5AD7A09DD
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 17:56:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgog3-0001rO-FN; Thu, 14 Sep 2023 11:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qgofw-0001Xh-JT
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 11:54:41 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qgofo-00086u-Nr
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 11:54:40 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-401b393ddd2so12804695e9.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 08:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694706864; x=1695311664; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OGbzz4QeWprzi5klBrJ8jVmyFfreEk6HpM3uxmYZCPI=;
 b=xL07VD25Lmxpts6mcdsMm1Ekm7P9CUutLEpVOI4IgEZIQe6v3gObRz5hd9miAydwru
 JiMbBRBWM+CdNTJdRtNQKHul4qok3L3ADmZG7GDdNEH5WW4l7iRl0DXzRhowfQuaBTJ3
 +JGpVaDE8vUAsnOFcuh5aVqOxI55eLuQP9cOJHeBG0KwqBn2YqEfOTBk+g3S1PVRT4uf
 AWfTOs0tcivwx7mVjWfOt06fwIAtdm37bR7Hr9GlriataVcKoEqMnKionzokmiSd47G5
 CL+CyU5x5gWzqo6KEWTm7OLkcV5U0bJwrSxMlqHrzFQ0Bh7GyQd8ewyy6fJvxPxf2/h+
 4fdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694706864; x=1695311664;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OGbzz4QeWprzi5klBrJ8jVmyFfreEk6HpM3uxmYZCPI=;
 b=P9DBzJUAtOO3spKnF1calhAtsalNT7Sb/8cFpnknhjVug+BAdAvuPn9SDHFI9zBsiE
 OBnkNW8mMjXX/poogrXvBOjNwZ8w11NUTHoh3ljyRFE6n6JaG/aIdcvyFK37uFISaown
 ZsLFJGwLbZMchTevYGyizQ+FtYtdkGVDfQFYn3sKx99AQPoTb4gXsYZ7OYxN3z2rb7Rf
 DZUseqF/BGds+zsF/+QdywXnQ0XzJ30mBE7OcPbgRQZ/deBXmeUEgWDaLlRx0OFdxbMD
 uXsjqaooWrH/LeXFHk7pzjhFkGKcBt6VIzDM/Amff8lpqE9e8fh1bnxnS61DgBCKFHQK
 dopw==
X-Gm-Message-State: AOJu0YxgIFTkd7xK86p288GWPeaQ5l4DHt+MfFGen9RXXoe2t+Pfvrg/
 haS9u0m9EuvOjcqKgybMbPA+Ww==
X-Google-Smtp-Source: AGHT+IHrSj9mtnPsKn3H57NMWVznNEnq7+UnMfFaYuxtt4XXjuiO5YTJRmG7zRg4ew/TJ75KGMwahw==
X-Received: by 2002:a7b:c8c6:0:b0:3f6:58ad:ed85 with SMTP id
 f6-20020a7bc8c6000000b003f658aded85mr4844641wml.10.1694706863288; 
 Thu, 14 Sep 2023 08:54:23 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 p18-20020a1c7412000000b00401d6c0505csm2286672wmc.47.2023.09.14.08.54.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 08:54:22 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 62FB21FFBB;
 Thu, 14 Sep 2023 16:54:22 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Joel Stanley <joel@jms.id.au>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 John Snow <jsnow@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 0/9] testing/next: avocado, gitlab, docker, cirrus
Date: Thu, 14 Sep 2023 16:54:13 +0100
Message-Id: <20230914155422.426639-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is mostly focused on getting the tree green again. There are
fixes for timeouts on various platforms. We explicitly disable a few
due to a known regression. Also there is a chance to update our
containers for Bookworm.

I dropped the attempt to migrate from global's htags support as the
lsif-clang source code injester seems broken.

The following still need review:

  tests/docker: Update docker-loongarch-cross toolchain
  gitlab: fix typo/spelling in comments
  tests: update Debian images to Bookworm

Alex Bennée (2):
  tests: update Debian images to Bookworm
  gitlab: fix typo/spelling in comments

Daniel P. Berrangé (4):
  microbit: add missing qtest_quit() call
  qtest: kill orphaned qtest QEMU processes on FreeBSD
  gitlab: make Cirrus CI timeout explicit
  gitlab: make Cirrus CI jobs gating

Nicholas Piggin (1):
  tests/avocado: Fix console data loss

Philippe Mathieu-Daudé (1):
  tests/avocado: Disable MIPS Malta tests due to GitLab issue #1884

Richard Henderson (1):
  tests/docker: Update docker-loongarch-cross toolchain

 tests/qtest/libqtest.c                        |  7 +++++++
 tests/qtest/microbit-test.c                   |  2 ++
 .gitlab-ci.d/base.yml                         |  2 +-
 .gitlab-ci.d/cirrus.yml                       |  4 +++-
 .gitlab-ci.d/cirrus/build.yml                 |  2 ++
 python/qemu/machine/machine.py                | 19 +++++++++++++++++++
 tests/avocado/avocado_qemu/__init__.py        |  2 +-
 tests/avocado/boot_linux_console.py           |  7 +++++++
 tests/avocado/machine_mips_malta.py           |  6 ++++++
 tests/avocado/replay_kernel.py                |  7 +++++++
 tests/avocado/tuxrun_baselines.py             |  4 ++++
 .../dockerfiles/debian-amd64-cross.docker     | 10 +++-------
 tests/docker/dockerfiles/debian-amd64.docker  | 10 +++-------
 .../dockerfiles/debian-arm64-cross.docker     | 10 +++-------
 .../dockerfiles/debian-armel-cross.docker     | 10 +++-------
 .../dockerfiles/debian-armhf-cross.docker     | 10 +++-------
 .../dockerfiles/debian-loongarch-cross.docker |  2 +-
 .../dockerfiles/debian-ppc64el-cross.docker   | 10 +++-------
 .../dockerfiles/debian-s390x-cross.docker     | 10 +++-------
 tests/docker/dockerfiles/ubuntu2004.docker    |  2 +-
 tests/docker/dockerfiles/ubuntu2204.docker    |  2 +-
 tests/lcitool/libvirt-ci                      |  2 +-
 tests/lcitool/refresh                         | 18 +++++++++---------
 23 files changed, 93 insertions(+), 65 deletions(-)

-- 
2.39.2


