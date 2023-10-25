Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8EF7D6130
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 07:31:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvWR1-0003wz-ED; Wed, 25 Oct 2023 01:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qvWQs-0003wH-PG
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 01:27:58 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qvWQp-0000tv-8i
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 01:27:54 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6be1bc5aa1cso5109458b3a.3
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 22:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698211669; x=1698816469;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OjaQTBHEg7Pi7GgQfB58kD6SCqzUEXVhmrqCuJsgRDg=;
 b=UE5uFzV5pRfmHPZVfqEaevhUjtulGrLe/2z8n2d6yzlZRCCa+rZviU/SnYiQbmarYr
 YPm39gfsiMXTQXkZPxCbStlPSPnR/6+8B5TgHduZ5QF+T8vTBLjIPjcrVMHjsxBfIx4M
 S06kywXN82ETuKwYf+//usuYkqKSfDuu1m1BIZiQDhK4uQCMOYYCUSto8dl5l5J1VDQL
 4QMuys+lJ73ZsUgEuY7/hkZCoL+boG20Aj4E4MoP61+3i29K/MbaHFoTGwIrKNwk5n2y
 2AK1UGoPUNcPSVKNG4jRbWGWy03lYqsw+aeTPxFP1cHytBgsPfwK/RRnp2plrX/V3+E2
 aaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698211669; x=1698816469;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OjaQTBHEg7Pi7GgQfB58kD6SCqzUEXVhmrqCuJsgRDg=;
 b=RnxeTlR1Mn2w+W6PK3qfdaY/tnmsrLdpHQ73hD7bvpA0nVtbePosUlAOM/kcL8ssow
 aosigDuyrH5frOXJymgb5AYEkX/kT5Z/7rleuCGfJfbNzvzHU5mwbICWNBflIhD1RH43
 MU6GFF9a9QsXoZUvmfZN11zAbo0gkRdyML0bmoBNYxpO0pkUsaaZdxjDWNRysQbhyha6
 2mCXQVvzEIftyCeIl/39DkC8uD1yR9y5GH3LeFJLHycDP6yJEI9awt5cQZYzsUEKUWPa
 gHrYAXDKbURpjZCdeNuwHafpWugXl0S7fc+HiNdh0HgZijsElYCfevSJO/4ETiHBvCrH
 tuTQ==
X-Gm-Message-State: AOJu0YwMw1L73WJvquMrByTxl87dz1Tf6eKo5ooSLc5daOWdYQ6ZBB1H
 wtnKk8gEpWpqoHgwd4Wnuts/0Q==
X-Google-Smtp-Source: AGHT+IHecretVBmAd1v0XQ8HDRtjIsK2pM9xDOLLvOkZ4+0jA6/LGyf/MXpS5gKuHcp+IGh0Zh1Vaw==
X-Received: by 2002:a05:6a21:66c6:b0:174:2a38:9d9c with SMTP id
 ze6-20020a056a2166c600b001742a389d9cmr5070865pzb.57.1698211668595; 
 Tue, 24 Oct 2023 22:27:48 -0700 (PDT)
Received: from localhost ([157.82.204.207])
 by smtp.gmail.com with UTF8SMTPSA id
 i1-20020aa796e1000000b006bdf4dfbe0dsm8820584pfq.12.2023.10.24.22.27.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 22:27:48 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v15 00/19] plugins: Allow to read registers
Date: Wed, 25 Oct 2023 14:27:22 +0900
Message-ID: <20231025052744.20697-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42e.google.com
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

Based-on: <20231019101030.128431-1-akihiko.odaki@daynix.com>
("[PATCH v5 0/6] gdbstub and TCG plugin improvements")

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

The execlog plugin will have new options to demonstrate the new feature.
I also have a plugin that uses this new feature to generate execution
traces for Sniper processor simulator, which is available at:
https://github.com/shioya-lab/sniper/tree/akihikodaki/bb

The below is a summary of patches:
Patch [01, 12] introduces num_regs member to GDBFeature.
Patch 13 adds members useful to identify registers to GDBFeature.
Patch 14 makes registers readable outside of gdbstub context.
Patch [15, 19] add the feature to read registers from plugins.

V14 -> V15:
  Added kdoc comments to include/exec/gdbstub.h.
  Changed to use g_array_append_val() in gdb_register_feature().
  Separated the CPU flags from event bitmap.

V13 -> V14:
  Fixed RISC-V CSR register numbers.

V12 -> V13:
  Rebased to "[PATCH v4 0/5] gdbstub and TCG plugin improvements".

V11 -> V12:
  Rebased to "[PATCH v2 0/3] gdbstub and TCG plugin improvements".

V10 -> V11:
  Fixed QEMU_PLUGIN_CB_RW_REGS.

V9 -> V10:
  Rebased to "[PATCH 0/4] gdbstub and TCG plugin improvements".
  Dropped patch "plugins: Support C++".
  Removed the unnecessary QEMU_PLUGIN_VERSION change.

V8 -> V9:
  Rebased to "[PATCH 00/25] October maintainer omnibus pre-PR (tests,
  gdbstub, plugins)".
  Added patch "target/riscv: Move MISA limits to class".
  Added patch "target/riscv: Remove misa_mxl validation".
  Added patch "target/riscv: Validate misa_mxl_max only once".
  Added patch "plugins: Use different helpers when reading".
  Moved contrib/plugins/cc.cc to tests/plugin/cc.cc.

V7 -> V8:
  Rebased to "[PATCH v3 00/12] gdbstub and TCG plugin improvements".
  Clarified that initialization and exit hooks affect TCG state.
  Simplified by adding the core feature to gdb_regs.

V6 -> V7:
  Rebased to "[PATCH v2 00/11] gdbstub and TCG plugin improvements".
  Replaced functions to get register identifiers.

V5 -> V6:
  Rebased to "[PATCH 0/8] gdbstub and TCG plugin improvements".

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

Akihiko Odaki (19):
  gdbstub: Add num_regs member to GDBFeature
  gdbstub: Introduce gdb_find_static_feature()
  gdbstub: Introduce GDBFeatureBuilder
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
  gdbstub: Expose functions to read registers
  cpu: Call plugin hooks only when ready
  plugins: Introduce CPU flags
  plugins: Use different helpers when reading registers
  plugins: Allow to read registers
  contrib/plugins: Allow to log registers

 docs/devel/tcg-plugins.rst   |  10 +-
 accel/tcg/plugin-helpers.h   |   3 +-
 include/exec/gdbstub.h       | 103 ++++++++++++++-
 include/exec/plugin-gen.h    |   4 +-
 include/hw/core/cpu.h        |  11 +-
 include/qemu/plugin.h        |   4 +
 include/qemu/qemu-plugin.h   |  50 ++++++-
 plugins/plugin.h             |   3 +-
 target/arm/cpu.h             |  27 ++--
 target/arm/internals.h       |  14 +-
 target/hexagon/internal.h    |   4 +-
 target/microblaze/cpu.h      |   4 +-
 target/ppc/cpu-qom.h         |   4 +-
 target/ppc/cpu.h             |   2 -
 target/riscv/cpu.h           |   5 +-
 target/s390x/cpu.h           |   2 -
 accel/tcg/plugin-gen.c       |  41 ++++--
 accel/tcg/translator.c       |   2 +-
 contrib/plugins/execlog.c    | 120 ++++++++++++-----
 cpu-target.c                 |  11 --
 gdbstub/gdbstub.c            | 245 +++++++++++++++++++++++++----------
 hw/core/cpu-common.c         |  15 ++-
 plugins/api.c                |  34 ++++-
 plugins/core.c               |  36 +++--
 plugins/loader.c             |   6 -
 target/arm/cpu.c             |   2 -
 target/arm/cpu64.c           |   1 -
 target/arm/gdbstub.c         | 230 ++++++++++++++++----------------
 target/arm/gdbstub64.c       | 122 ++++++++---------
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
 target/ppc/gdbstub.c         | 114 ++++++++--------
 target/riscv/cpu.c           |  15 ---
 target/riscv/gdbstub.c       | 139 +++++++++++---------
 target/rx/cpu.c              |   1 -
 target/s390x/cpu.c           |   1 -
 target/s390x/gdbstub.c       | 105 +++++++++------
 plugins/qemu-plugins.symbols |   3 +
 scripts/feature_to_c.py      |  58 ++++++++-
 48 files changed, 1050 insertions(+), 582 deletions(-)

-- 
2.42.0


