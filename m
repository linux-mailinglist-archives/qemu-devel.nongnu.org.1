Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6702182BEE5
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 12:06:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOFLz-00063R-2G; Fri, 12 Jan 2024 06:05:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOFLB-0005ZU-HA
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:04:46 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOFL7-0008TW-Ik
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:04:44 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40e552dfa5dso33724575e9.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 03:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705057476; x=1705662276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=f3vQeV8eWyTwO9H0ULPby8YqplIIhOBiqPzCK2fXZbA=;
 b=XUK8rfViAmS3vtRGunBR/xu9m0mas3J8VFWDONhn4rHv7hpSykDKdQQLJK7aGKhwb0
 PRz/OP8FDYyJagMc8ePThOsnIpdmLzYTFly/IksDjy7WL8C4nxQ+KcJiRTkfxAEA/phR
 mafZpaPR5ZD3tlVNg22WZsNPtf1OoLURKzOw3jA2LoML//dKqh068JJUFKOrnitJRyYZ
 PlXxnJetPEd4yoGcXiu3W3NZFKbYyQCr/KWhlnC7/CjWW2sXkR5/fQK9njxc0hC1BQSv
 HvOe5NVhhMyPBhdiw2c0WQ2tc2LNdXgYKbbd4VjcHcpfikMLRGeEmolmsP4CSB6WD40H
 Dc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705057476; x=1705662276;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f3vQeV8eWyTwO9H0ULPby8YqplIIhOBiqPzCK2fXZbA=;
 b=Z/ny9gL76vCzs8oqQsI4l6tjcsfgNdkjLujoifxvTmQf59C0wCrQk/h4xCTZK6JjgS
 9uEXYaf2jzx9GAvIzbFJlNWY4uLm4Q3iVKORdLjIyJ7cc/5ccqWFrbLm43LE9fe2Z9h8
 WOnZwAOVwjoOJHjdsGXwTeUmnxuDLfny274GKr53Il+Z8CtwHsRCAujqIFDAWUcXGACJ
 axxo/33iCQMYzTIfOTUm+s/L7BsBU/kAGo8lQSfzm9N+DRg+X5iJTBWbZi8acCpnpbrM
 UFKsMRRG2teBpQJpDCWSjUPMs2hTNNHsW01ACNQgsslZwXe18SOb7RIKFEx2radpZ/Xr
 F8Ww==
X-Gm-Message-State: AOJu0YxMph/yW7a7IoEi1PkQy8nB6DZE1TVLiUuG1HZ3i5/A+5tNXmWF
 zwG9aPX/M5sL2T359SqlLs1uaSieDJ+m9pqKfNBLTc0QbhQ=
X-Google-Smtp-Source: AGHT+IFxYlbbn4tNwVYB/9lwkcAoEf77uqfsT3t4PCKEbKTpaY3QiJPlSYFgr3QHSAb2G5XU20NbIQ==
X-Received: by 2002:a05:600c:1310:b0:40e:4a58:3c1c with SMTP id
 j16-20020a05600c131000b0040e4a583c1cmr631582wmf.154.1705057475991; 
 Fri, 12 Jan 2024 03:04:35 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 o21-20020a05600c4fd500b0040e34ca648bsm5430612wmq.0.2024.01.12.03.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 03:04:35 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 151B35F760;
 Fri, 12 Jan 2024 11:04:35 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 00/22] testing and misc updates
Date: Fri, 12 Jan 2024 11:04:13 +0000
Message-Id: <20240112110435.3801068-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

The following changes since commit f614acb7450282a119d85d759f27eae190476058:

  Merge tag 'pull-target-arm-20240111' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-01-11 11:05:44 +0000)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-testing-updates-120124-1

for you to fetch changes up to b4960adfbd8975579016c94a087eb2f6bece7eda:

  Revert "tests/avocado: remove skips from replay_kernel" (2024-01-12 10:08:16 +0000)

----------------------------------------------------------------
testing and misc updates

  - add LE microblaze test to avocado
  - use modern snapshot=on to avoid trashing disk image
  - use plain bool for fe_is_open
  - various updates to qtest timeouts
  - enable meson test timeouts
  - tweak the readthedocs environment
  - revert the revert of flaky replay tests

----------------------------------------------------------------
Alex Bennée (5):
      tests/avocado: use snapshot=on in kvm_xen_guest
      gitlab: include microblazeel in testing
      chardev: use bool for fe_is_open
      readthodocs: fully specify a build environment
      Revert "tests/avocado: remove skips from replay_kernel"

Daniel P. Berrangé (12):
      qtest: bump min meson timeout to 60 seconds
      qtest: bump migration-test timeout to 8 minutes
      qtest: bump qom-test timeout to 15 minutes
      qtest: bump npcm7xx_pwm-test timeout to 5 minutes
      qtest: bump test-hmp timeout to 4 minutes
      qtest: bump pxe-test timeout to 10 minutes
      qtest: bump prom-env-test timeout to 6 minutes
      qtest: bump boot-serial-test timeout to 3 minutes
      qtest: bump qos-test timeout to 2 minutes
      qtest: bump aspeed_smc-test timeout to 6 minutes
      qtest: bump bios-table-test timeout to 9 minutes
      mtest2make: stop disabling meson test timeouts

Thomas Huth (5):
      tests/avocado: Add a test for a little-endian microblaze machine
      tests/qtest: Bump the device-introspect-test timeout to 12 minutes
      tests/unit: Bump test-aio-multithread test timeout to 2 minutes
      tests/unit: Bump test-crypto-block test timeout to 5 minutes
      tests/fp: Bump fp-test-mulAdd test timeout to 3 minutes

 docs/requirements.txt               |  2 ++
 include/chardev/char-fe.h           | 19 ++++++++++++-------
 chardev/char-fe.c                   | 16 ++++++++--------
 chardev/char.c                      |  2 +-
 .gitlab-ci.d/buildtest.yml          |  4 ++--
 .readthedocs.yml                    | 19 ++++++++++++-------
 scripts/mtest2make.py               |  3 ++-
 tests/avocado/kvm_xen_guest.py      |  2 +-
 tests/avocado/machine_microblaze.py | 26 ++++++++++++++++++++++++++
 tests/avocado/replay_kernel.py      | 11 +++++++++++
 tests/fp/meson.build                |  2 +-
 tests/qtest/meson.build             | 25 +++++++++++++------------
 tests/unit/meson.build              |  2 ++
 13 files changed, 93 insertions(+), 40 deletions(-)
 create mode 100644 docs/requirements.txt

-- 
2.39.2


