Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA297804E0
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 05:41:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWqII-0001lN-7z; Thu, 17 Aug 2023 23:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qWqIF-0001kb-1f
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 23:36:59 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qWqIB-0005js-6J
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 23:36:58 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-68879fc4871so428676b3a.0
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 20:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1692329813; x=1692934613;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mQyi6gfRgbfl9Ba+HuBYDjs0BflAbozpyrrSa1VYhO8=;
 b=FDgLpzAee2003jos8P7myvZSK7R1ePMAm2AV0GTWbrVDw9R85F892Kfgss7TlhlRTM
 Vc5vuOTHvyzhthTIVQmPtk707j9R/8hq5SyEKgNTs1AO1rLDc09EUROrCDaoW2x1pDn3
 yM+x7DKcvIgB1XiCK5nNYiyPKSWghFFRnTKmuQ9/ZAiqOhGcyYo+kryLS4FTX0H1wnpI
 xCUZNC4SvgT271kVbg99CLRVVxaOJ3X9dfIpGCbg5MfH3Y61k10kS0bdYQXzPUPPbiBX
 vr/YwIzG0tSkogmCNM2MEfe5hSs7j+ERf+vgaGbatCZMmW4EjiOCA4UPq3YbeeHeWNQV
 /qYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692329813; x=1692934613;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mQyi6gfRgbfl9Ba+HuBYDjs0BflAbozpyrrSa1VYhO8=;
 b=j1/JFvb89BUe/A4Ga43lPiw2UoRK+EYFK+UqL7GgF49lKTvkfCRB+qfAHJbXYBQfzo
 jThQWYmTbpUrUFuvBoz6/8wBSo1N39JU3JNF98a2PUeKK+rCvQH2sPyCex/MiUKtLpf2
 I7paP1tJSxGiy3VcA/Q8e6Q2L6BjbZhS1Z6X7Di/uJ1ifBQRQM/0FGUulcOhHV4zs8pR
 wa3RiRAHjehAG0zuxRh/mJzPE0RSTKgZexJCNFSXNaaCyuzSJt4LbP0URy43PoIptuG2
 DbB7Hsyx5hKIEmUrhXs38hLl9H8+VY4UUuV756OLGS2AMXvj7Awu05VOh0eEbBg9pzWv
 F3IA==
X-Gm-Message-State: AOJu0YyTnsGkMJASJHav2VJGfLXsA2VlUeXlM/qLKPxl/3S2fsh7cuRp
 aVcr9+ZfR9J/loIBmkb8SG/YRw==
X-Google-Smtp-Source: AGHT+IGLWsPohV+74USpB08Q/CRm8WdujwyToMM41Sg2DGbnZJojbHx2tDX04md8/hn3loDMn4uVTQ==
X-Received: by 2002:a05:6a00:816:b0:687:1780:aa02 with SMTP id
 m22-20020a056a00081600b006871780aa02mr1476168pfk.24.1692329813031; 
 Thu, 17 Aug 2023 20:36:53 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 c24-20020aa781d8000000b00686a80f431dsm484135pfn.126.2023.08.17.20.36.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 20:36:52 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH RESEND v5 00/26] plugins: Allow to read registers
Date: Fri, 18 Aug 2023 12:36:19 +0900
Message-ID: <20230818033648.8326-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
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
Patch 01 fixes a bug in execlog plugin.
Patch [02, 16] introduce GDBFeature.
Patch 17 adds information useful for plugins to GDBFeature.
Patch [18, 21] make registers readable outside of gdbstub context.
Patch [22, 24] add the feature to read registers from plugins.
Patch [25, 26] make it possible to write plugins in C++.

The execlog plugin will have new options to demonstrate the new feature.
I also have a plugin that uses this new feature to generate execution
traces for Sniper processor simulator, which is available at:
https://github.com/shioya-lab/sniper/tree/akihikodaki/bb

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

Akihiko Odaki (26):
  contrib/plugins: Use GRWLock in execlog
  gdbstub: Introduce GDBFeature structure
  gdbstub: Add num_regs member to GDBFeature
  gdbstub: Introduce gdb_find_static_feature()
  target/arm: Move the reference to arm-core.xml
  hw/core/cpu: Replace gdb_core_xml_file with gdb_core_feature
  gdbstub: Introduce GDBFeatureBuilder
  target/arm: Use GDBFeature for dynamic XML
  target/ppc: Use GDBFeature for dynamic XML
  target/riscv: Use GDBFeature for dynamic XML
  gdbstub: Use GDBFeature for gdb_register_coprocessor
  gdbstub: Use GDBFeature for GDBRegisterState
  hw/core/cpu: Return static value with gdb_arch_name()
  gdbstub: Dynamically allocate target.xml buffer
  gdbstub: Simplify XML lookup
  hw/core/cpu: Remove gdb_get_dynamic_xml member
  gdbstub: Add members to identify registers to GDBFeature
  target/arm: Remove references to gdb_has_xml
  target/ppc: Remove references to gdb_has_xml
  gdbstub: Remove gdb_has_xml variable
  gdbstub: Expose functions to read registers
  cpu: Call plugin hooks only when ready
  plugins: Allow to read registers
  contrib/plugins: Allow to log registers
  plugins: Support C++
  contrib/plugins: Add cc plugin

 MAINTAINERS                  |   2 +-
 docs/devel/tcg-plugins.rst   |  18 +++-
 configure                    |  15 ++-
 meson.build                  |   2 +-
 gdbstub/internals.h          |   2 +-
 include/exec/gdbstub.h       |  51 +++++++--
 include/hw/core/cpu.h        |  11 +-
 include/qemu/qemu-plugin.h   |  69 +++++++++++-
 target/arm/cpu.h             |  26 ++---
 target/arm/internals.h       |   2 +-
 target/ppc/cpu-qom.h         |   3 +-
 target/ppc/cpu.h             |   3 +-
 target/ppc/internal.h        |   2 +-
 target/riscv/cpu.h           |   4 +-
 target/s390x/cpu.h           |   2 -
 contrib/plugins/execlog.c    | 150 ++++++++++++++++++++------
 cpu.c                        |  11 --
 gdbstub/gdbstub.c            | 198 +++++++++++++++++++++++-----------
 gdbstub/softmmu.c            |   3 +-
 gdbstub/user.c               |   1 -
 hw/core/cpu-common.c         |  10 ++
 plugins/api.c                |  40 +++++++
 stubs/gdbstub.c              |   6 +-
 target/arm/cpu.c             |  12 +--
 target/arm/cpu64.c           |   8 +-
 target/arm/gdbstub.c         | 202 +++++++++++++----------------------
 target/arm/gdbstub64.c       |  90 +++++++---------
 target/arm/tcg/cpu32.c       |   3 +-
 target/avr/cpu.c             |   4 +-
 target/hexagon/cpu.c         |   5 +-
 target/i386/cpu.c            |  13 ++-
 target/loongarch/cpu.c       |   8 +-
 target/loongarch/gdbstub.c   |   2 +-
 target/m68k/cpu.c            |   7 +-
 target/m68k/helper.c         |   6 +-
 target/microblaze/cpu.c      |   9 +-
 target/ppc/cpu_init.c        |   9 +-
 target/ppc/gdbstub.c         |  80 ++++----------
 target/riscv/cpu.c           |  27 ++---
 target/riscv/gdbstub.c       |  89 +++++++--------
 target/rx/cpu.c              |   4 +-
 target/s390x/cpu.c           |   8 +-
 target/s390x/gdbstub.c       |  28 ++---
 target/tricore/cpu.c         |   4 +-
 contrib/plugins/Makefile     |   5 +
 contrib/plugins/cc.cc        |  17 +++
 plugins/qemu-plugins.symbols |   2 +
 scripts/feature_to_c.py      | 102 ++++++++++++++++++
 scripts/feature_to_c.sh      |  69 ------------
 tests/tcg/Makefile.target    |   3 +
 50 files changed, 825 insertions(+), 622 deletions(-)
 create mode 100644 contrib/plugins/cc.cc
 create mode 100755 scripts/feature_to_c.py
 delete mode 100644 scripts/feature_to_c.sh

-- 
2.41.0


