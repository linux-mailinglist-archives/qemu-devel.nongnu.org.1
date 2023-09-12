Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5454379C7DE
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 09:15:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfxZV-0002P9-AF; Tue, 12 Sep 2023 03:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qfxZQ-0002Oq-KG
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 03:12:24 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qfxZM-0006SW-OS
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 03:12:24 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6c0bbbbad81so3241289a34.3
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 00:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694502739; x=1695107539;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hdHgy7yy7oaXKs87Sr2Z09/n9+UIIbODWBzDVADs0G4=;
 b=ph303A3k/VpJZc76eRujk7EM7ba2GqLVT+mueu2uOxJRzFf08rKvRwVuTmxPngr88H
 7uITywS+o3noEBUqqibHc0b/tfZo9Cu24UaCKqcoYMHZ05QVJ0C88O448P/A7IZiJaQb
 9brFMz97cUZWTMZD1mpZ0+mJpyL+o0Tb4M5iO4JTcoWnAhWcWMqET+x678bcBtOqJpqv
 m4Rxe10kFpAQJ93OvmVhU72p4n3WZG1dzOL0RFIUYRFMX0AX26USmdYeFkH3/NKRlrs7
 2zWlgTZ5X+mRmlObrM0ThESGBG1StQCSd3xFaCu9gu7JeDtfmaCfgpMjAucm9EaDgvpH
 XR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694502739; x=1695107539;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hdHgy7yy7oaXKs87Sr2Z09/n9+UIIbODWBzDVADs0G4=;
 b=WTTVMNeLGSq6N+Wj4+U+GCNIC5Vr9g6jyyt4Fh2jDLo4k3N4oi8T8nFsAq+eQ89Xor
 GZqLE5618JY7vWgdYAH0vpz9tKLbPecLRtskwxUS83HSDRRb/G405v3MV6RLPPErGxbx
 6iRukd0b62wphTYVVbyHPEjyDTsf+gjbB1tWZ6nkWsDOU6qR7ZMUVEgDem5wrENVji33
 j6Ic7kOp/2KqGvtY7swzu/AcxxCcomXi2C+8z4r+4YV8V1crH7ynnuCbWGTSGgeCZlMr
 vXetC9Y/shD59TdMr69Kl5nSwN8BAKnrCZ0HL9Bku8IJRwSi0Kh9sVz3gnGn1u4izIir
 5S0g==
X-Gm-Message-State: AOJu0YxV9CtO+3JtQt2AhSohaTeAgE7+neRhQ6sOHT8IR9GYQ+asysNs
 3m9bkcJIO15TYm2jXfvMETWc3w==
X-Google-Smtp-Source: AGHT+IE1VzqX0eNEyhgutjUnp3i5oZGKzRHP8SAtCMVP/EBWxSZEstTTWMP/CFSkerJ+HV5dfqo+6Q==
X-Received: by 2002:a05:6358:9142:b0:134:e964:134c with SMTP id
 r2-20020a056358914200b00134e964134cmr12996403rwr.11.1694502739420; 
 Tue, 12 Sep 2023 00:12:19 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 f13-20020aa78b0d000000b0068be348e35fsm6647495pfd.166.2023.09.12.00.12.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 00:12:19 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v7 00/18] plugins: Allow to read registers
Date: Tue, 12 Sep 2023 16:11:46 +0900
Message-ID: <20230912071206.30751-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::330;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x330.google.com
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

Based-on: <20230912065811.27796-1-akihiko.odaki@daynix.com>
("[PATCH v2 00/11] gdbstub and TCG plugin improvements")

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

V6 -> V7:
  Rebased to "[PATCH v2 00/11] gdbstub and TCG plugin improvements"
  Replaced functions to get register identifiers.

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
 configure                    |  15 ++-
 include/exec/gdbstub.h       |  33 ++++++-
 include/hw/core/cpu.h        |   9 +-
 include/qemu/qemu-plugin.h   |  56 ++++++++++-
 target/arm/cpu.h             |  26 ++---
 target/arm/internals.h       |   2 +-
 target/ppc/cpu-qom.h         |   3 +-
 target/ppc/cpu.h             |   3 +-
 target/riscv/cpu.h           |   4 +-
 target/s390x/cpu.h           |   2 -
 contrib/plugins/execlog.c    | 120 ++++++++++++++++-------
 cpu.c                        |  11 ---
 gdbstub/gdbstub.c            | 178 +++++++++++++++++++++++++++++------
 hw/core/cpu-common.c         |  10 ++
 plugins/api.c                |  19 ++++
 target/arm/cpu.c             |   5 +-
 target/arm/cpu64.c           |   4 +-
 target/arm/gdbstub.c         | 170 ++++++++++++++-------------------
 target/arm/gdbstub64.c       |  90 ++++++++----------
 target/arm/tcg/cpu32.c       |   3 +-
 target/avr/cpu.c             |   4 +-
 target/hexagon/cpu.c         |   5 +-
 target/i386/cpu.c            |   7 +-
 target/loongarch/cpu.c       |   8 +-
 target/loongarch/gdbstub.c   |   2 +-
 target/m68k/cpu.c            |   7 +-
 target/m68k/helper.c         |   6 +-
 target/microblaze/cpu.c      |   9 +-
 target/ppc/cpu_init.c        |   9 +-
 target/ppc/gdbstub.c         |  62 ++++--------
 target/riscv/cpu.c           |  21 +----
 target/riscv/gdbstub.c       |  89 ++++++++----------
 target/rx/cpu.c              |   4 +-
 target/s390x/cpu.c           |   4 +-
 target/s390x/gdbstub.c       |  28 ++----
 contrib/plugins/Makefile     |   5 +
 contrib/plugins/cc.cc        |  17 ++++
 plugins/qemu-plugins.symbols |   3 +
 scripts/feature_to_c.py      |  58 +++++++++++-
 tests/tcg/Makefile.target    |   3 +
 41 files changed, 694 insertions(+), 438 deletions(-)
 create mode 100644 contrib/plugins/cc.cc

-- 
2.42.0


