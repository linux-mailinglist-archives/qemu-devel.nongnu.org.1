Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E89A3790ADE
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Sep 2023 07:05:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcfHF-0002eY-Rd; Sun, 03 Sep 2023 01:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qcfH1-0002e6-Lj
 for qemu-devel@nongnu.org; Sun, 03 Sep 2023 01:03:47 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qcfGy-0001ex-T0
 for qemu-devel@nongnu.org; Sun, 03 Sep 2023 01:03:47 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-68c3ec0578bso216613b3a.2
 for <qemu-devel@nongnu.org>; Sat, 02 Sep 2023 22:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1693717423; x=1694322223;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=C/aJJlprExbZmmAiyobRX92/BYN2SSv60j7BO9mWs38=;
 b=r9Oa8Hzm05bcRmi+J3XO/GnoUN92+i5CwOYapw/f9+VkLk1m+o76GVipJg8zobdlj1
 xN9vWyRCMjSy15tZGVzum8523OoymB487cQ9LQp+iWaF16b5SHv5g0jSn/eSaViSaMdM
 1UOSrHb0Z5AHtkHCglkcfXNrat1Q79dy75OAEok8ZmUcU4lf32P2naKoiT9QDOeIWhYQ
 vZ60OsmO76u88TtbgApIHhedSWigOwJ7f3cpjjiTk/dbH04AlyZnLg6xayRscX1NEuTc
 Bgz/AqssjpFslfR17PzjbiUBcrH1KCStbLnXp6/uUEtzGStaY3VxGLIgYDZxuYhw69Hk
 p9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693717423; x=1694322223;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C/aJJlprExbZmmAiyobRX92/BYN2SSv60j7BO9mWs38=;
 b=ZtmdlloI39c+KwipA1SjPXYIi9sb3nlNCCDoAODP5RlQIj4syNy86rxsHcruPuFJw/
 mHnGs4j1pQ5LNDFrDmeue/ToQWM9oB95RFk88uxMVxcqNo1T8HvMAVb0M1r/h+puxXiy
 CeXF3ku6Yyub9QRD59epopwNUABDwHTp4qaRp3bomL5sSesst4QhyRvVoUeor/R/M/Fm
 S/adCnXUW24xhbIAmJ4I+wqR+Ayx4SxXDhng327UhWE/Noq2LEcrBX2gW2izPvW69dSW
 8uXHW1ul7gzjhG9iZiO3LfW0AnhqOcOQl7IJGoH2j9uoEKWh9EbZtfZktWfwfKecIQn6
 W9sQ==
X-Gm-Message-State: AOJu0YxKgjxgtGcg12ELx7Nm0PGyWOHTUtmMNwbKHEL+HfPQLMu5Rh/w
 0JWdhfR5nfyyYuXZu3OYobaSzQ==
X-Google-Smtp-Source: AGHT+IFfoe8UH+L/dlZ3mXoFjPnjrlLu1HXVN6rSaRHBnGuVIl+/zAQXXCusd2+A98/PDdw1vwmLsQ==
X-Received: by 2002:a05:6300:8002:b0:140:8537:85c1 with SMTP id
 an2-20020a056300800200b00140853785c1mr5448155pzc.28.1693717423220; 
 Sat, 02 Sep 2023 22:03:43 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 l11-20020a170902f68b00b001b8af7f632asm5324835plg.176.2023.09.02.22.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 22:03:42 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v6 00/18] plugins: Allow to read registers
Date: Sun,  3 Sep 2023 14:03:08 +0900
Message-ID: <20230903050338.35256-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::430;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Based-on: <20230903043030.20708-1-akihiko.odaki@daynix.com>
("[PATCH 0/8] gdbstub and TCG plugin improvements")

I and other people in the University of Tokyo, where I research processor
design, found TCG plugins are very useful for processor design exploration.

The feature we find missing is the capability to read registers from
plugins. In this series, I propose to add such a capability by reusing
gdbstub code.

The reuse of gdbstub code ensures the long-term stability of the TCG plugin
interface for register access without incurring a burden to maintain yet
another interface for register access.

This process to add TCG plugin involves four major changes. The first one
is to add GDBFeature structure that represents a GDB feature, which usually
includes registers. GDBFeature can be generated from static XML files or
dynamically generated by architecture-specific code. In fact, this is a
refactoring independent of the feature this series adds, and potentially
it's benefitial even without the plugin feature. The plugin feature will
utilize this new structure to describe registers exposed to plugins.

The second one is to make gdb_read_register/gdb_write_register usable
outside of gdbstub context.

The third one is to actually make registers readable for plugins.

The last one is to allow to implement a QEMU plugin in C++. A plugin that
I'll describe later is written in C++.

The below is a summary of patches:
Patch [01, 03] introduces num_regs member to GDBFeature.
Patch [04, 11] converts dynamic features to use GDBFeature.
Patch 12 adds members useful to identify registers to GDBFeature.
Patch 13 makes registers readable outside of gdbstub context.
Patch [14, 16] add the feature to read registers from plugins.
Patch [17, 18] make it possible to write plugins in C++.

The execlog plugin will have new options to demonstrate the new feature.
I also have a plugin that uses this new feature to generate execution
traces for Sniper processor simulator, which is available at:
https://github.com/shioya-lab/sniper/tree/akihikodaki/bb

V5 -> V6:
  Rebased to "[PATCH 0/8] gdbstub and TCG plugin improvements"

V4 -> V5:
  Corrected g_rw_lock_writer_lock() call. (Richard Henderson)
  Replaced abort() with g_assert_not_reached(). (Richard Henderson)
  Fixed CSR name leak in target/riscv. (Richard Henderson)
  Removed gdb_has_xml variable.

V3 -> V4:
  Added execlog changes I forgot to include in the last version.

V2 -> V3:
  Added patch "hw/core/cpu: Return static value with gdb_arch_name()".
  Added patch "gdbstub: Dynamically allocate target.xml buffer".
  (Alex Bennée)
  Added patch "gdbstub: Introduce GDBFeatureBuilder". (Alex Bennée)
  Dropped Reviewed-by tags for "target/*: Use GDBFeature for dynamic XML".
  Changed gdb_find_static_feature() to abort on failure. (Alex Bennée)
  Changed the execlog plugin to log the register value only when changed.
  (Alex Bennée)
  Dropped 0x prefixes for register value logs for conciseness.

V1 -> V2:
  Added SPDX-License-Identifier: GPL-2.0-or-later. (Philippe Mathieu-Daudé)
  Split long lines. (Philippe Mathieu-Daudé)
  Renamed gdb_features to gdb_static_features (Philippe Mathieu-Daudé)
  Dropped RFC.

Akihiko Odaki (18):
  gdbstub: Add num_regs member to GDBFeature
  gdbstub: Introduce gdb_find_static_feature()
  hw/core/cpu: Replace gdb_core_xml_file with gdb_core_feature
  gdbstub: Introduce GDBFeatureBuilder
  target/arm: Use GDBFeature for dynamic XML
  target/ppc: Use GDBFeature for dynamic XML
  target/riscv: Use GDBFeature for dynamic XML
  gdbstub: Use GDBFeature for gdb_register_coprocessor
  gdbstub: Use GDBFeature for GDBRegisterState
  gdbstub: Simplify XML lookup
  hw/core/cpu: Remove gdb_get_dynamic_xml member
  gdbstub: Add members to identify registers to GDBFeature
  gdbstub: Expose functions to read registers
  cpu: Call plugin hooks only when ready
  plugins: Allow to read registers
  contrib/plugins: Allow to log registers
  plugins: Support C++
  contrib/plugins: Add cc plugin

 docs/devel/tcg-plugins.rst   |  18 +++-
 configure                    |  15 +++-
 include/exec/gdbstub.h       |  34 ++++++-
 include/hw/core/cpu.h        |   9 +-
 include/qemu/qemu-plugin.h   |  69 +++++++++++++-
 target/arm/cpu.h             |  26 ++----
 target/arm/internals.h       |   2 +-
 target/ppc/cpu-qom.h         |   3 +-
 target/ppc/cpu.h             |   3 +-
 target/riscv/cpu.h           |   4 +-
 target/s390x/cpu.h           |   2 -
 contrib/plugins/execlog.c    | 140 ++++++++++++++++++++++-------
 cpu.c                        |  11 ---
 gdbstub/gdbstub.c            | 145 ++++++++++++++++++++++++------
 hw/core/cpu-common.c         |  10 +++
 plugins/api.c                |  40 +++++++++
 target/arm/cpu.c             |   5 +-
 target/arm/cpu64.c           |   4 +-
 target/arm/gdbstub.c         | 170 +++++++++++++++--------------------
 target/arm/gdbstub64.c       |  90 ++++++++-----------
 target/arm/tcg/cpu32.c       |   3 +-
 target/avr/cpu.c             |   4 +-
 target/hexagon/cpu.c         |   5 +-
 target/i386/cpu.c            |   7 +-
 target/loongarch/cpu.c       |   4 +-
 target/loongarch/gdbstub.c   |   2 +-
 target/m68k/cpu.c            |   7 +-
 target/m68k/helper.c         |   6 +-
 target/microblaze/cpu.c      |   9 +-
 target/ppc/cpu_init.c        |   9 +-
 target/ppc/gdbstub.c         |  62 ++++---------
 target/riscv/cpu.c           |  21 +----
 target/riscv/gdbstub.c       |  89 ++++++++----------
 target/rx/cpu.c              |   4 +-
 target/s390x/cpu.c           |   4 +-
 target/s390x/gdbstub.c       |  28 ++----
 contrib/plugins/Makefile     |   5 ++
 contrib/plugins/cc.cc        |  17 ++++
 plugins/qemu-plugins.symbols |   2 +
 scripts/feature_to_c.py      |  58 +++++++++++-
 tests/tcg/Makefile.target    |   3 +
 41 files changed, 713 insertions(+), 436 deletions(-)
 create mode 100644 contrib/plugins/cc.cc

-- 
2.42.0


