Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3322D80073C
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 10:38:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8zww-0003nd-0K; Fri, 01 Dec 2023 04:36:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8zwt-0003lf-TT
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 04:36:39 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8zwq-00044j-Iu
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 04:36:39 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40b399a6529so19105945e9.1
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 01:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701423395; x=1702028195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gxbS2bqtSols01ki1dGMQKNbIUJ4Ip2adQtteeYqp2Y=;
 b=Z1pwXapzRQyuuwTrBRSpoj72TzS9AVaGqVE+44BIzvmS3NZ102i7Scafo0hg1SEJWl
 wgLk+2cY05HLcGGvOc14yfkFTbUZkvdzI+8Ja4fRzXfMPBB/0aotsxtt9ygKFA5pgKX1
 07gKofORcPOyozWzMEuB6oHQJ7DfhvkFcnzSJydIAIAR1c8aAU4losNbDSkoG2wgH3Ob
 X15qzDk95W/m7pYapUADc5huB0hG5syMBtUA+X64OYwrouX/7CPKRzXKxjmd7wamPkPB
 2iQ+H7vrFqhbk9nW3a05B+WipBkYvfaGQPlJEH+XhOMalmpIr60v4LTt26oWwvpqispW
 EVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701423395; x=1702028195;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gxbS2bqtSols01ki1dGMQKNbIUJ4Ip2adQtteeYqp2Y=;
 b=MulGed4BZ4t6G+ydVyjvHiYnFZ7+vFvbzR/esnPOLmyTNh2kKD0oQvyojFE7xL2A5W
 ACcwmlKHuLMrHSD3qWjSSufyq9O613Ln72zN719jcKNWdeI43rmvT0H7+KdGr9tD42nM
 kdfQLxi9yOycE/8On29VJbreGat159KKzsgk1ioTycix5axsTW37nZUVamlNeE7YvZHO
 rFgth0UVp9ZpUlsv95SiKoNrSRKtQqs++poPtlDM2QYFwe+XxU99EbdJYFH5splsGwwg
 uXLDWI0dm+W6ui6Ao3Dy9wNZoUwXuxVd2W8tXFEhc6s8zisk91USASdZAOmA/6LLDWAi
 1NUg==
X-Gm-Message-State: AOJu0YyYQCap6ctifBqfp3IiHfqKX4tCfvvOpo7zvGc6wkdU79gOHDSc
 WvzD1W4w2MA7pTnchqx+eyKjTg==
X-Google-Smtp-Source: AGHT+IEIFZN0mFeNp4Jt02AdG72wf+RlaM7HfVcOtNf7Lr5dJMj+83K4aIiMpvHOdKbRCP2xXY8TNA==
X-Received: by 2002:a05:600c:1d0a:b0:40b:5e26:2386 with SMTP id
 l10-20020a05600c1d0a00b0040b5e262386mr495246wms.55.1701423394859; 
 Fri, 01 Dec 2023 01:36:34 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 z3-20020a05600c0a0300b0040839fcb217sm4911959wmp.8.2023.12.01.01.36.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 01:36:34 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DEB025FB5F;
 Fri,  1 Dec 2023 09:36:33 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Beraldo Leal <bleal@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Eric Auger <eric.auger@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Cleber Rosa <crosa@redhat.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/7] final fixes for 8.2
Date: Fri,  1 Dec 2023 09:36:26 +0000
Message-Id: <20231201093633.2551497-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

8.2 is looking fairly stable but I do have one bug fix for gdbstub
which I came across while debugging something else. The changes for
avocado rationalise all flaky tests under the QEMU_TEST_FLAKY_TESTS
environment variable. The final patch re-adds the flaky tests to the
CI as a manually run allow_fail job so we can still attempt to debug
their failure in the place they tend to fall over.

v2
--

  - addressed some review comments
  - emphasised raising a bug for failing tests
  - drop some tests now missing assets online
  - fix wrong microblaze target for tests

The following still need review:

  gitlab: build the correct microblaze target
  tests/avocado: tag sbsa tests as tcg only
  tests/avocado: drop malta yamon tests
  tests/avocado: drop BootLinuxConsole.test_mips_malta_cpio test

Alex.

Alex Bennée (7):
  gdbstub: use a better signal when we halt for IO reasons
  docs/devel: rationalise unstable gitlab tests under FLAKY_TESTS
  tests/avocado: drop BootLinuxConsole.test_mips_malta_cpio test
  tests/avocado: drop malta yamon tests
  tests/avocado: tag sbsa tests as tcg only
  gitlab: build the correct microblaze target
  gitlab: add optional job to run flaky avocado tests

 docs/devel/testing.rst                   | 32 ++++++++++------
 gdbstub/internals.h                      |  1 +
 gdbstub/system.c                         |  2 +-
 .gitlab-ci.d/buildtest.yml               | 32 +++++++++++++++-
 tests/avocado/boot_linux.py              | 10 +++--
 tests/avocado/boot_linux_console.py      | 28 ++------------
 tests/avocado/intel_iommu.py             |  6 ++-
 tests/avocado/linux_initrd.py            |  7 +++-
 tests/avocado/machine_aarch64_sbsaref.py |  1 +
 tests/avocado/machine_aspeed.py          | 10 +++--
 tests/avocado/machine_mips_malta.py      | 47 ++++--------------------
 tests/avocado/machine_rx_gdbsim.py       | 10 +++--
 tests/avocado/machine_s390_ccw_virtio.py |  3 +-
 tests/avocado/replay_kernel.py           |  8 +++-
 tests/avocado/reverse_debugging.py       | 16 +++++---
 tests/avocado/smmu.py                    |  6 ++-
 tests/avocado/tuxrun_baselines.py        |  5 ++-
 17 files changed, 122 insertions(+), 102 deletions(-)

-- 
2.39.2


