Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2767E59E5
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 16:18:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0kJR-0002lt-Oe; Wed, 08 Nov 2023 10:17:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0kJP-0002li-Q2
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 10:17:47 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0kJN-0008IU-Pg
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 10:17:47 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4084095722aso52755815e9.1
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 07:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699456664; x=1700061464; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hud1pKYGi11Tg0anqT04aOA5m7WTtWFWwe/uFciid44=;
 b=do8bgSL1ote2AzqytTXhDzSPYADz5ctf5oy/EFcujpTq93z8+9j+GaY0duL87jBy88
 9PvD/c/eMHDk3z+jaFxmwoHFrCALoX9zHLxyx7YJnst1JA8BoIWvMSu/FCMqYo98dG9E
 I9lS91CTony+qDFnJYoFEH4x8g0T4nbmjb7uywYf2BXYjaM6zaTVbhdKYhA8jMyUieK4
 ghYEc1vIlcdF6KxsTiehuLdGsNMzb8VNs+NcG8mdirp0fbddHMY+iVLdfHMFwqEPqSku
 PyT/nSHRZwBpgj+Q1IVrkxEsDZ9PR3zVUJUPS8f3g29++UkI+Z2ClgTdNOmxX7+gepod
 NwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699456664; x=1700061464;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hud1pKYGi11Tg0anqT04aOA5m7WTtWFWwe/uFciid44=;
 b=AMCy4WWSALA69vfjVOlV38ebtuv8POy//Jk3q0d3MhWAUGVeyFL+Xuz+/OjBnNT0rw
 L9G0fSvnCiXcswt+J9O/43KtqIBuge3jagMW13BjMKcN6uR9ZTABvhAAtEc87PAxXN4f
 +sWHRSnE6GbDyGAD6z8GzougXwtTGTF4xiso+Ehr6a6UI66QBzrtY/ZjjmpN2c7fVJVK
 DdwkKv6yIhUIO2Piwvk2Hz1DMSrLVUoEeVCl+7jZMkO7doh9GuaJGO8IcfcfwSFZBYOo
 6Z3sypEnhkVWjuuFK+MQEP647+w9zniBH60345+R6zbjEhVDDfPTXOqMg87LckDwd56h
 UdGA==
X-Gm-Message-State: AOJu0YxExMxtVhIqqgRpGrVlgkKNLwp47SktdQWG1SFKUYWTBfH+yS2Y
 3SEd5mL3FwzZtxBq50yi8o+RWfYTkM5ZpMsnhvOxRA==
X-Google-Smtp-Source: AGHT+IFU1alyy5al+OMM48vTO5dJ7iEXS9zvcNz3CBfO2VmWG99mqjWv7P/975TrX/Z9i+wvyHQDZw==
X-Received: by 2002:adf:e781:0:b0:32d:9a8f:6245 with SMTP id
 n1-20020adfe781000000b0032d9a8f6245mr1758077wrm.68.1699456664136; 
 Wed, 08 Nov 2023 07:17:44 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 f9-20020a0560001b0900b0032db430fb9bsm5157727wrz.68.2023.11.08.07.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Nov 2023 07:17:43 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 633915F751;
 Wed,  8 Nov 2023 15:17:43 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL v2 00/23] Final test, gdbstub, plugin and gitdm updates for 8.2
Date: Wed,  8 Nov 2023 15:17:43 +0000
Message-Id: <20231108151743.3834165-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

The following changes since commit a3c3aaa846ad61b801e7196482dcf4afb8ba34e4:

  Merge tag 'pull-ppc-20231107' of https://gitlab.com/danielhb/qemu into staging (2023-11-08 20:35:00 +0800)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-halloween-omnibus-081123-1

for you to fetch changes up to a475f32b075d566f3f92f94387d50e132b73bcb8:

  Revert "tests/tcg/nios2: Re-enable linux-user tests" (2023-11-08 15:15:23 +0000)

----------------------------------------------------------------
Final test, gdbstub, plugin and gitdm updates for 8.2

  - fix duplicate register in arm xml
  - hide various duplicate system registers from gdbstub
  - add new gdb register test to the CI (skipping s390x/ppc64 for now)
  - introduce GDBFeatureBuilder
  - move plugin initialisation to after vCPU init completes
  - enable building TCG plugins on Windows platform
  - various gitdm updates
  - some mailmap fixes
  - disable testing for nios2 signals which have regressed

----------------------------------------------------------------
Akihiko Odaki (5):
      default-configs: Add TARGET_XML_FILES definition
      gdbstub: Add num_regs member to GDBFeature
      gdbstub: Introduce gdb_find_static_feature()
      gdbstub: Introduce GDBFeatureBuilder
      cpu: Call plugin hooks only when ready

Alex Bennée (13):
      gdb-xml: fix duplicate register in arm-neon.xml
      target/arm: mark the 32bit alias of PAR when LPAE enabled
      target/arm: hide all versions of DBGD[RS]AR from gdbstub
      target/arm: hide aliased MIDR from gdbstub
      tests/tcg: add an explicit gdbstub register tester
      tests/avocado: update the tcg_plugins test
      configure: tell meson and contrib_plugins about DLLTOOL
      gitlab: add dlltool to Windows CI
      contrib/gitdm: Add Rivos Inc to the domain map
      contrib/gitdm: map HiSilicon to Huawei
      contrib/gitdm: add Daynix to domain-map
      mailmap: fixup some more corrupted author fields
      Revert "tests/tcg/nios2: Re-enable linux-user tests"

Greg Manning (4):
      plugins: add dllexport and dllimport to api funcs
      plugins: make test/example plugins work on windows
      plugins: disable lockstep plugin on windows
      plugins: allow plugins to be enabled on windows

luzhipeng (1):
      contrib/gitdm: add domain-map for Cestc

 MAINTAINERS                                        |   2 +-
 configure                                          |  13 +-
 configs/targets/loongarch64-linux-user.mak         |   1 +
 meson.build                                        |   5 +
 include/exec/gdbstub.h                             |  59 ++++++
 include/qemu/qemu-plugin.h                         |  50 +++++-
 contrib/plugins/win32_linker.c                     |  34 ++++
 cpu-target.c                                       |  11 --
 gdbstub/gdbstub.c                                  |  78 ++++++++
 hw/core/cpu-common.c                               |  10 ++
 target/arm/debug_helper.c                          |  10 +-
 target/arm/helper.c                                |  37 ++--
 .gitlab-ci.d/crossbuilds.yml                       |   4 +-
 .gitlab-ci.d/windows.yml                           |   1 +
 .mailmap                                           |   2 +
 contrib/gitdm/domain-map                           |   4 +
 contrib/plugins/Makefile                           |  26 ++-
 gdb-xml/arm-neon.xml                               |   2 +-
 plugins/meson.build                                |  19 ++
 scripts/feature_to_c.py                            |  46 ++++-
 tests/avocado/tcg_plugins.py                       |  28 +--
 tests/plugin/meson.build                           |  14 +-
 tests/tcg/multiarch/Makefile.target                |  11 +-
 tests/tcg/multiarch/gdbstub/registers.py           | 197 +++++++++++++++++++++
 tests/tcg/multiarch/system/Makefile.softmmu-target |  13 +-
 tests/tcg/nios2/Makefile.target                    |  11 ++
 tests/tcg/ppc64/Makefile.target                    |   7 +
 tests/tcg/s390x/Makefile.target                    |   4 +
 28 files changed, 639 insertions(+), 60 deletions(-)
 create mode 100644 contrib/plugins/win32_linker.c
 create mode 100644 tests/tcg/multiarch/gdbstub/registers.py
 create mode 100644 tests/tcg/nios2/Makefile.target

-- 
2.39.2


