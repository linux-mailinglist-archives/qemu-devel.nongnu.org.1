Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CADA2810A86
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 07:42:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDIw5-0007Y0-5m; Wed, 13 Dec 2023 01:41:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rDIvz-0007XB-On
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 01:41:31 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rDIvu-0005Bo-BO
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 01:41:31 -0500
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6d84ddd642fso5008255a34.0
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 22:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702449682; x=1703054482;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=L/+A66pL25kn3XYpcz1nOENcvzH/cRI26qShJ+fqNCw=;
 b=j3ntsE245t9cYS/7qju/FmsS37y28kMjBAtDs39FHAJv8rG631pp3bb8BrVHvlNpFa
 JmI+Z0E4UQM0uIn4bIYIfb4pAjQMjVJ/SXBsyYOb/qXtPqkXGn55tc0NpGzBGgktVWyx
 TGZdB42DNVmGyX2fyXi/x+aJoSI8vlhHUup3fHDpl9Y6m6xf6FDrdNnQmrnRa8wHfLMZ
 DFqnFQT0qAYqscKkNVoW1Y9zIG5sRmvl95m4gXyoIYMy3P7P8xuO0FtgDMOwPyg+3eHu
 BiOXjAEFJXy1soqx8ugJ+f2ShkP0KdPE+83yV7+MLk1u4BrHS3fkZQvj2liz/ebQNKwV
 aJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702449682; x=1703054482;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L/+A66pL25kn3XYpcz1nOENcvzH/cRI26qShJ+fqNCw=;
 b=LszN5XQ7ijXU+/UxlaO3ZBpZsE1Pcj1Kria5Iw+F4MeNwG7wuBvG1HVj3J+u86bHmd
 rVsnhBkjK5B4J5oUKLFF0SjHrUF6NBGpSd13zd8yqDuhzNqylIEpr1NKiiCltarLAS6N
 f1E6EQaE5Uogr2lMWBCewQMDyQYbxqc/5I0JlUulIhFYpVnILR/4OTupT6WkFcm5vVjg
 rG1I2Xg4MgOwu9Iz1rJxDDDA2ixYMH6Dxes1EwVpjnOTmf/58kL7pAwd8x9syP/MJ+Iy
 XePGG+EnooXQ7VgQG+Khw7bYWq5tx6Cnizd67PN61C2WgEXny9hdtaj5yYrpzoBhWUql
 0g6g==
X-Gm-Message-State: AOJu0YyhhT0rcaWmTveyY8d2+7G7/KRcxMgYDQOfAHJ1gzggIUjnax10
 RmqtzKgt3XWLja7pUNjPNvunJw==
X-Google-Smtp-Source: AGHT+IH2OTmYiIudtuFvD5Um4b50Ij9KMAYBOovuQxiygKn3tZ2V4jzdlFUgdATkzDUMEeKHUgsMuA==
X-Received: by 2002:a05:6358:7f13:b0:170:2c2d:9d8f with SMTP id
 p19-20020a0563587f1300b001702c2d9d8fmr11021942rwn.1.1702449679908; 
 Tue, 12 Dec 2023 22:41:19 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 px6-20020a17090b270600b002609cadc56esm10280169pjb.11.2023.12.12.22.41.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Dec 2023 22:41:19 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v17 00/14] plugins: Allow to read registers
Date: Wed, 13 Dec 2023 15:40:59 +0900
Message-Id: <20231213-gdb-v17-0-777047380591@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPtReWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDM11FJSSM
 xLz0lN1M1OAAkpGBkbGhkaGxrrpKUm6xiaWKUkGKYmWxmlGSkCVBUWpaZkVYGOiY2trAYTvJsR
 WAAAA
To: Peter Maydell <peter.maydell@linaro.org>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Brian Cain <bcain@quicinc.com>, Song Gao <gaosong@loongson.cn>, 
 Laurent Vivier <laurent@vivier.eu>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Michael Rolnik <mrolnik@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, John Snow <jsnow@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Mikhail Tyutin <m.tyutin@yadro.com>, 
 Aleksandr Anenkov <a.anenkov@yadro.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org, 
 20231213-riscv-v7-0-a760156a337f@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::333;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x333.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
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

Based-on: <20231213-riscv-v7-0-a760156a337f@daynix.com>
("[PATCH v7 0/4] gdbstub and TCG plugin improvements")

I and other people in the University of Tokyo, where I research
processor design, found TCG plugins are very useful for processor design
exploration.

The feature we find missing is the capability to read registers from
plugins. In this series, I propose to add such a capability by reusing
gdbstub code.

The reuse of gdbstub code ensures the long-term stability of the TCG
plugin interface for register access without incurring a burden to
maintain yet another interface for register access.

This process to add TCG plugin involves four major changes. The first
one is to add members to GDBFeature necessary for register
identification.

The second one is to make gdb_read_register/gdb_write_register usable
outside of gdbstub context.

The third one is to actually make registers readable for plugins.

The execlog plugin will have new options to demonstrate the new feature.
I also have a plugin that uses this new feature to generate execution
traces for Sniper processor simulator, which is available at:
https://github.com/shioya-lab/sniper/tree/akihikodaki/bb

The below is a summary of patches:
Patch [01, 09] changes to use GDBFeature for dynamic XMLs.
Patch 10 adds members useful to identify registers to GDBFeature.
Patch 11 makes registers readable outside of gdbstub context.
Patch [12, 14] add the feature to read registers from plugins.

V16 -> V17:
  Rebased.

V15 -> V16:
  Added new plugin_dyn_cb_subtype and plugin_gen_cb to remove the global
  translator state change.

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

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Akihiko Odaki (14):
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
      plugins: Use different helpers when reading registers
      plugins: Allow to read registers
      contrib/plugins: Allow to log registers

 docs/devel/tcg-plugins.rst   |  10 +-
 accel/tcg/plugin-helpers.h   |   3 +-
 include/exec/gdbstub.h       |  44 ++++++++-
 include/hw/core/cpu.h        |   7 +-
 include/qemu/plugin.h        |   1 +
 include/qemu/qemu-plugin.h   |  50 +++++++++-
 target/arm/cpu.h             |  27 ++---
 target/arm/internals.h       |  14 +--
 target/hexagon/internal.h    |   4 +-
 target/microblaze/cpu.h      |   4 +-
 target/ppc/cpu-qom.h         |   1 +
 target/ppc/cpu.h             |   5 +-
 target/riscv/cpu.h           |   5 +-
 target/s390x/cpu.h           |   2 -
 accel/tcg/plugin-gen.c       |  43 +++++++-
 contrib/plugins/execlog.c    | 120 ++++++++++++++++------
 gdbstub/gdbstub.c            | 173 +++++++++++++++++++-------------
 hw/core/cpu-common.c         |   5 +-
 plugins/api.c                |  32 +++++-
 target/arm/cpu.c             |   2 -
 target/arm/cpu64.c           |   1 -
 target/arm/gdbstub.c         | 230 ++++++++++++++++++++++---------------------
 target/arm/gdbstub64.c       | 122 ++++++++++++-----------
 target/avr/cpu.c             |   1 -
 target/hexagon/cpu.c         |   4 +-
 target/hexagon/gdbstub.c     |  10 +-
 target/i386/cpu.c            |   2 -
 target/loongarch/cpu.c       |   2 -
 target/loongarch/gdbstub.c   |  13 ++-
 target/m68k/cpu.c            |   1 -
 target/m68k/helper.c         |  26 +++--
 target/microblaze/cpu.c      |   6 +-
 target/microblaze/gdbstub.c  |   9 +-
 target/ppc/cpu_init.c        |   7 --
 target/ppc/gdbstub.c         | 114 ++++++++++-----------
 target/riscv/cpu.c           |  15 ---
 target/riscv/gdbstub.c       | 139 ++++++++++++++------------
 target/rx/cpu.c              |   1 -
 target/s390x/cpu.c           |   1 -
 target/s390x/gdbstub.c       | 105 ++++++++++++--------
 plugins/qemu-plugins.symbols |   3 +
 scripts/feature_to_c.py      |  14 ++-
 42 files changed, 836 insertions(+), 542 deletions(-)
---
base-commit: 651f18e5def549b67df934e38c474963b884ccc7
change-id: 20231213-gdb-349db0da93f2

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


