Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8427A2E6F
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 10:03:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhQG1-0003Bu-JU; Sat, 16 Sep 2023 04:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qhQFu-0003Bi-Ui
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 04:02:18 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qhQFs-0005xj-Fm
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 04:02:18 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68fb46f38f9so2742322b3a.1
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 01:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694851335; x=1695456135;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iQ8HyBCroHZH3iih1FxoWv7eJyU63/SAW5zw/2IoJPM=;
 b=Q2JK2OtTgpkFJXKFMzYaBZ7AAFVzKqPQ2/6bWxyDzWhe5jjCYTp6clldEhfgfRwAl3
 dqypxqUOoaijlXin7Tkl6RlnyvWDMYfQjar0W3nyrX8Ig1Hx9337DxKclMiOltq7iwj8
 hFWtu6x29kfFbBUV0lMvK+8PfsNfpYTp/3Eh1uQHwtZ0sYVj4FsXS9pr3emogXxsylAH
 KnDqRBBVdikSuZR/B5FBtvwVHPeTIAY3wCupUE1cqm4e7Iijo4CMSIOvp8mObPU3EQHZ
 /dGy3hCPvjfvS3HWRdM3n2NTEriuCdWObgS2o/cBiPf2e8z3cJrab+2o2r6VbEcLdXQy
 rx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694851335; x=1695456135;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iQ8HyBCroHZH3iih1FxoWv7eJyU63/SAW5zw/2IoJPM=;
 b=GEx/m9vC9LYLP72o79b3V9Sa4Y291PNVleAYjnn7BHmZx9nXTLqNfSMjz4CkpQoby5
 5ufV/9gjJGs/BTbO+tC5biFp5qp0qGVBjndc3xn/9h9IWoK1leYDSu/SRJJQD5ql75Og
 w2R34tjoXQx1oLHnplyQMBaDU5YtgaMtX2PTTQyixJBJrNI/5s5hUdenXble0U61CvJ5
 x2dCi3v7f9JZzjD1/IT1Ubm2Yyd1ceQ0FBqKpgyucmBEVgYezhT6RsLvDodSOLtsXYk0
 23PDcPK6Bs+QDkmtdvnWxShlRMvcnB7o1cX2XnTZuFp8W5O/d5z1OXxUtQWd+FQGaTDT
 BSKg==
X-Gm-Message-State: AOJu0Ywe0m0/L2/lYqCyuN5/reBbXwSEGmtQH5WfxGP2ab/hF7zq3kFS
 OqmdcmrqW0f0YGqSVSn0IfaTu/IvIH71J86f4r4=
X-Google-Smtp-Source: AGHT+IGEIJbuePY4+QEeezfi2D0SatfwCZAeGmFQxtOKNwe+Eed8VOvytTUHwwv2SqKrmyKxy6+18g==
X-Received: by 2002:a05:6a00:1a86:b0:68c:3f2:6007 with SMTP id
 e6-20020a056a001a8600b0068c03f26007mr4011186pfv.8.1694851334597; 
 Sat, 16 Sep 2023 01:02:14 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 z21-20020aa791d5000000b0068a46cd4120sm4029484pfa.199.2023.09.16.01.02.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 01:02:14 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v8 00/19] plugins: Allow to read registers
Date: Sat, 16 Sep 2023 17:01:17 +0900
Message-ID: <20230916080149.129989-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42f.google.com
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

Based-on: <20230912224107.29669-1-akihiko.odaki@daynix.com>
("[PATCH v3 00/12] gdbstub and TCG plugin improvements")

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
Patch [01, 12] introduces num_regs member to GDBFeature.
Patch 13 adds members useful to identify registers to GDBFeature.
Patch 14 makes registers readable outside of gdbstub context.
Patch [15, 17] add the feature to read registers from plugins.
Patch [18, 19] make it possible to write plugins in C++.

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

The execlog plugin will have new options to demonstrate the new feature.
I also have a plugin that uses this new feature to generate execution
traces for Sniper processor simulator, which is available at:
https://github.com/shioya-lab/sniper/tree/akihikodaki/bb

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
  plugins: Allow to read registers
  contrib/plugins: Allow to log registers
  plugins: Support C++
  contrib/plugins: Add cc plugin

 docs/devel/tcg-plugins.rst   |  18 ++-
 configure                    |  15 ++-
 include/exec/gdbstub.h       |  39 ++++++-
 include/hw/core/cpu.h        |   7 +-
 include/qemu/qemu-plugin.h   |  56 ++++++++-
 target/arm/cpu.h             |  27 ++---
 target/arm/internals.h       |  14 +--
 target/hexagon/internal.h    |   4 +-
 target/microblaze/cpu.h      |   4 +-
 target/ppc/cpu-qom.h         |   4 +-
 target/ppc/cpu.h             |   3 +-
 target/riscv/cpu.h           |   5 +-
 target/s390x/cpu.h           |   2 -
 contrib/plugins/execlog.c    | 120 ++++++++++++++-----
 cpu.c                        |  11 --
 gdbstub/gdbstub.c            | 216 ++++++++++++++++++++++++++--------
 hw/core/cpu-common.c         |  15 ++-
 plugins/api.c                |  20 ++++
 target/arm/cpu.c             |   2 -
 target/arm/cpu64.c           |   1 -
 target/arm/gdbstub.c         | 221 +++++++++++++++++------------------
 target/arm/gdbstub64.c       | 117 +++++++++----------
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
 target/ppc/cpu_init.c        |   5 +-
 target/ppc/gdbstub.c         | 108 ++++++++---------
 target/riscv/cpu.c           |  15 ---
 target/riscv/gdbstub.c       | 135 +++++++++++----------
 target/rx/cpu.c              |   1 -
 target/s390x/cpu.c           |   1 -
 target/s390x/gdbstub.c       | 105 ++++++++++-------
 contrib/plugins/Makefile     |   5 +
 contrib/plugins/cc.cc        |  17 +++
 plugins/qemu-plugins.symbols |   3 +
 scripts/feature_to_c.py      |  58 ++++++++-
 tests/tcg/Makefile.target    |   3 +
 44 files changed, 921 insertions(+), 530 deletions(-)
 create mode 100644 contrib/plugins/cc.cc

-- 
2.42.0


