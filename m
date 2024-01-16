Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 031FF82ED09
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 11:50:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPgzj-0002PU-I7; Tue, 16 Jan 2024 05:48:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rPgzQ-0002HR-4b
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 05:48:17 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rPgzN-0007Ao-O5
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 05:48:15 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40e60e137aaso49312475e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 02:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705402092; x=1706006892; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VcUss7o1hqN+n+0AAkWV5ZRYdfS//MAFhmJ+MtkOJ0g=;
 b=DxPw9Ly5U7ziutsRQJYNWsd0hLTi/r//McDmEyH7cIVQ5I4hdP5fGW8Yr3jEUwOBBO
 m96hhmrfhRBzGCAcd6MqwLdlWE+f70fDfX7SYO9LfeZUFQFAwGvB4anMz+8NLVk04FQ+
 bXrYk0JCCtr/ubyq9eTiOqs8QLvcR2NN4m+cDmj5uIJ0zOiv+NuobgEJ5VjOVt8PuUzv
 6jsykpqpxRuv6STJ6R5V0abzZm/+JfHoZuQKgWDz8u5k9IVvE2FwLi2ANDrj9pIBIWYQ
 dNNXG4Nc8lCjFTYIDzKo///RyWPidWjSe/ksc7i8+0vdPR4CvqtsuuSe+UNDthVkaMhR
 ZdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705402092; x=1706006892;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VcUss7o1hqN+n+0AAkWV5ZRYdfS//MAFhmJ+MtkOJ0g=;
 b=mCsMovRZXoGDYdSUzz5cZLIG+LxG4fjsbscLq5aGNKt6iiASXR0xmRI9guNb8ke6AN
 6yyjgkDhwTIcQfUYzCyBjNF4N2afc72dSo+Pp1+eqXpU5zZJAlufSRGFGMSlDW5TB4FX
 WhfyAhPxTbc8cX1+p18UW5POTpXQLdEGFHMawjjQzQStwmdIjQKkHIZc31Nv4bPV7DV2
 oEEC6XS2ag/Ouv52qeA4w3QK9EJXIf1nF7hnPPrKZouDWQrAZ/bIzJktvSrTfgbJaiM4
 LfpTVrGekU32pFXonK1JGBXfNmPqtNn/joAv/fUYkRiDV9SyJp3bQMt5OuWQnqv5Zk/6
 qcDg==
X-Gm-Message-State: AOJu0YwYmwyz6GNCLYZTG0Qkt8SlD9mJ/hOJ/SmQlZSdqb/S/F+DbEED
 QLEbMnez43Cu53UtanmTcxI94tNTBDMUoyAWAm17fVs701E=
X-Google-Smtp-Source: AGHT+IHEr1J9DI04cxE9yMCTVDyfDMcHcjP3eCVvDZZPL2U25DlzKJStR7mL+9m+l8aqejUqBqloeg==
X-Received: by 2002:a05:600c:220f:b0:40e:7546:243a with SMTP id
 z15-20020a05600c220f00b0040e7546243amr1705042wml.188.1705402092241; 
 Tue, 16 Jan 2024 02:48:12 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 g14-20020a05600c310e00b0040e398f8cafsm18882465wmo.31.2024.01.16.02.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 02:48:10 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 47EEB5F7B5;
 Tue, 16 Jan 2024 10:48:09 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 00/22] gdb cleanups and tcg plugin register access
Date: Tue, 16 Jan 2024 10:47:47 +0000
Message-Id: <20240116104809.250076-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

The following changes since commit 977542ded7e6b28d2bc077bcda24568c716e393c:

  Merge tag 'pull-testing-updates-120124-2' of https://gitlab.com/stsquad/qemu into staging (2024-01-12 14:02:53 +0000)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-registers-for-plugins-160124-2

for you to fetch changes up to 87bed6910aa0d0942244b5eedee60b4f8b162c05:

  docs/devel: document some plugin assumptions (2024-01-16 10:34:20 +0000)

----------------------------------------------------------------
read-only register access for plugins:

  - move misa_mxl to CPU class for riscv
  - use GDBFeature for arm XML
  - use GDBFeature for ppc XML
  - use GDBFeature for riscv XML
  - unify gdb code to use GDBFeature
  - move dynamic XML generation to core GDB code
  - provide introspection APIs for rest of QEMU
  - expose a plugin API to access registers
  - fix memory re-use in execlog
  - extend execlog to track registers
  - optimise instrumentation based on disassembly
  - tweak API docs and expand on assumptions

----------------------------------------------------------------
Akihiko Odaki (15):
      hw/riscv: Use misa_mxl instead of misa_mxl_max
      target/riscv: Remove misa_mxl validation
      target/riscv: Move misa_mxl_max to class
      target/riscv: Validate misa_mxl_max only once
      target/arm: Use GDBFeature for dynamic XML
      target/ppc: Use GDBFeature for dynamic XML
      target/riscv: Use GDBFeature for dynamic XML
      gdbstub: Use GDBFeature for gdb_register_coprocessor
      gdbstub: Use GDBFeature for GDBRegisterState
      gdbstub: Change gdb_get_reg_cb and gdb_set_reg_cb
      gdbstub: Simplify XML lookup
      gdbstub: Infer number of core registers from XML
      hw/core/cpu: Remove gdb_get_dynamic_xml member
      gdbstub: Add members to identify registers to GDBFeature
      plugins: Use different helpers when reading registers

Alex Bennée (7):
      gdbstub: expose api to find registers
      plugins: add an API to read registers
      contrib/plugins: fix imatch
      contrib/plugins: extend execlog to track register changes
      contrib/plugins: optimise the register value tracking
      docs/devel: lift example and plugin API sections up
      docs/devel: document some plugin assumptions

 docs/devel/tcg-plugins.rst   |  72 +++++++++-
 accel/tcg/plugin-helpers.h   |   3 +-
 include/exec/gdbstub.h       |  62 ++++++++-
 include/hw/core/cpu.h        |   7 +-
 include/qemu/plugin.h        |   1 +
 include/qemu/qemu-plugin.h   |  51 ++++++-
 target/arm/cpu.h             |  27 ++--
 target/arm/internals.h       |  14 +-
 target/hexagon/internal.h    |   4 +-
 target/microblaze/cpu.h      |   4 +-
 target/ppc/cpu-qom.h         |   1 +
 target/ppc/cpu.h             |   5 +-
 target/riscv/cpu.h           |   9 +-
 target/s390x/cpu.h           |   2 -
 accel/tcg/plugin-gen.c       |  43 +++++-
 contrib/plugins/execlog.c    | 324 ++++++++++++++++++++++++++++++++++++-------
 gdbstub/gdbstub.c            | 198 +++++++++++++++++---------
 hw/core/cpu-common.c         |   5 +-
 hw/riscv/boot.c              |   2 +-
 plugins/api.c                | 123 +++++++++++++++-
 target/arm/cpu.c             |   2 -
 target/arm/cpu64.c           |   1 -
 target/arm/gdbstub.c         | 230 +++++++++++++++---------------
 target/arm/gdbstub64.c       | 122 ++++++++--------
 target/avr/cpu.c             |   1 -
 target/hexagon/cpu.c         |   4 +-
 target/hexagon/gdbstub.c     |  10 +-
 target/i386/cpu.c            |   2 -
 target/loongarch/cpu.c       |   2 -
 target/loongarch/gdbstub.c   |  13 +-
 target/m68k/cpu.c            |   1 -
 target/m68k/helper.c         |  26 +++-
 target/microblaze/cpu.c      |   6 +-
 target/microblaze/gdbstub.c  |   9 +-
 target/ppc/cpu_init.c        |   7 -
 target/ppc/gdbstub.c         | 114 +++++++--------
 target/riscv/cpu.c           | 193 +++++++++++++-------------
 target/riscv/gdbstub.c       | 151 +++++++++++---------
 target/riscv/kvm/kvm-cpu.c   |  10 +-
 target/riscv/machine.c       |   7 +-
 target/riscv/tcg/tcg-cpu.c   |  44 +-----
 target/riscv/translate.c     |   3 +-
 target/rx/cpu.c              |   1 -
 target/s390x/cpu.c           |   1 -
 target/s390x/gdbstub.c       | 105 ++++++++------
 plugins/qemu-plugins.symbols |   2 +
 scripts/feature_to_c.py      |  14 +-
 47 files changed, 1343 insertions(+), 695 deletions(-)

-- 
2.39.2


