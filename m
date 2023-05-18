Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7F8708347
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 15:56:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pze6f-0002Go-IB; Thu, 18 May 2023 09:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1pze6a-0002GT-6m
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:55:44 -0400
Received: from mga12.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1pze6X-0002CY-BG
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:55:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684418141; x=1715954141;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ta/qgVRJ85gykMNOkH8d4mJuhoRrakQ5cD1caOTRvrU=;
 b=bfjL8U2/F0apKS0llI05ugG3lquephfzgMAdyTBMcCDdOplXgft6KMS3
 8UdJEfoy925riqOKEKJZCy9S7976WmGrWrXQNBWvN8hzgPKlmdUlNTSyT
 Vt26bIdY9PbpCQaBE72dSVn31bUaz7eM1whi5ofTbYzhqpI+/jFhcQOEP
 QMula2sIX3J6pyazT7RoQkQkz7N+M7jiFOneGJypnm4b7NB1BmLId9oOP
 UnTVodrry+4phy/zNOOH+cQbRtCIEWkJs1Tq/Jbgmahw5V7miYezMdav6
 C/8lzooMGF6oy/z/gumizs/vRqgPtryp32F5F4ubsmDGyBr1csm2vPdVA Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="331685290"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; d="scan'208";a="331685290"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2023 06:55:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="876428728"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; d="scan'208";a="876428728"
Received: from wufei-optiplex-7090.sh.intel.com ([10.238.200.247])
 by orsmga005.jf.intel.com with ESMTP; 18 May 2023 06:55:36 -0700
From: Fei Wu <fei2.wu@intel.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, fei2.wu@intel.com
Subject: [PATCH v12 00/15] TCG code quality tracking
Date: Thu, 18 May 2023 21:57:42 +0800
Message-Id: <20230518135757.1442654-1-fei2.wu@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.136; envelope-from=fei2.wu@intel.com;
 helo=mga12.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

v12
---
* fix some CI issues, including make do-meson-check and build
* move part of patch 9 to 1
* fix inverse_sort_tbs
* use normal ++ instead of qatomic_inc for stats->executions.normal
* add how to for tb-stats
* append Fei Wu to Signed-off-by


Alex Bennée (5):
  accel/tcg: move profiler dev_time to tb_stats
  accel/tcg: convert profiling of restore operations to TBStats
  accel/tcg: convert profiling of code generation to TBStats
  tb-stats: reset the tracked TBs on a tb_flush
  configure: remove the final bits of --profiler support

Fei Wu (1):
  docs/tb-stats: add how to

Vanderson M. do Rosario (9):
  accel/tcg: introduce TBStatistics structure
  accel: collecting TB execution count
  accel: collecting JIT statistics
  accel: replacing part of CONFIG_PROFILER with TBStats
  accel: adding TB_JIT_TIME and full replacing CONFIG_PROFILER
  debug: add -d tb_stats to control TBStatistics collection:
  monitor: adding tb_stats hmp command
  Adding info [tb-list|tb] commands to HMP (WIP)
  tb-stats: dump hot TBs at the end of the execution

 MAINTAINERS                   |   1 +
 accel/tcg/cpu-exec.c          |   6 +
 accel/tcg/meson.build         |   1 +
 accel/tcg/monitor.c           | 122 +++++-
 accel/tcg/tb-context.h        |   1 +
 accel/tcg/tb-hash.h           |   7 +
 accel/tcg/tb-maint.c          |  20 +
 accel/tcg/tb-stats.c          | 689 ++++++++++++++++++++++++++++++++++
 accel/tcg/tcg-accel-ops.c     |  15 +-
 accel/tcg/tcg-runtime.c       |   8 +
 accel/tcg/tcg-runtime.h       |   1 +
 accel/tcg/translate-all.c     | 147 ++++++--
 accel/tcg/translator.c        |  13 +
 disas/disas.c                 |  24 +-
 docs/tb-stats.txt             | 116 ++++++
 hmp-commands-info.hx          |  16 +
 hmp-commands.hx               |  16 +
 include/exec/exec-all.h       |   3 +
 include/exec/gen-icount.h     |   2 +
 include/exec/tb-stats-dump.h  |  21 ++
 include/exec/tb-stats-flags.h |  33 ++
 include/exec/tb-stats.h       | 164 ++++++++
 include/monitor/hmp.h         |   3 +
 include/qemu/log-for-trace.h  |   6 +-
 include/qemu/log.h            |   3 +
 include/qemu/timer.h          |   5 +-
 include/tcg/tcg.h             |  50 ++-
 linux-user/exit.c             |   2 +
 meson.build                   |   2 -
 meson_options.txt             |   2 -
 scripts/meson-buildoptions.sh |   3 -
 softmmu/runstate.c            |  10 +-
 stubs/meson.build             |   1 +
 stubs/tb-stats.c              |  32 ++
 tcg/tcg.c                     | 224 +++--------
 tests/qtest/qmp-cmd-test.c    |   2 +-
 util/log.c                    | 103 ++++-
 37 files changed, 1590 insertions(+), 284 deletions(-)
 create mode 100644 accel/tcg/tb-stats.c
 create mode 100644 docs/tb-stats.txt
 create mode 100644 include/exec/tb-stats-dump.h
 create mode 100644 include/exec/tb-stats-flags.h
 create mode 100644 include/exec/tb-stats.h
 create mode 100644 stubs/tb-stats.c

-- 
2.25.1


