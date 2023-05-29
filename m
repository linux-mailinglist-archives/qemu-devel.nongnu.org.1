Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA507148CB
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 13:48:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3bMJ-0004bK-EI; Mon, 29 May 2023 07:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q3bMF-0004b5-U0
 for qemu-devel@nongnu.org; Mon, 29 May 2023 07:48:16 -0400
Received: from mga03.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q3bME-0004TO-6P
 for qemu-devel@nongnu.org; Mon, 29 May 2023 07:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685360894; x=1716896894;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=WIMKX826tsnHuPbFAtzoTETCugNxBLkKspzQJtLEEmw=;
 b=SyVGjaC9vzI9H53AV8zeU4v3kPX96hxNhWFuU5z+PYJDsPtbBO0CvFy5
 xLxQLt7tYNQ+E1LxJVwzQlaSJmJTDipBAxQSzsqFDjStXoiix8Ob+YRiD
 kFwIhyM97reR0xDJ+ht828bJsxQWqVlJWnJw9HedwUwyemBeXCYwwBmpl
 jXxsywT+28ODHQZUFHyEz3DQHZbF5Vu6qoj6XH0skR9V8DmTYxXHPfCGQ
 k5W9VyYNPEkwJCDcoto0/fNmVUN2H682Mhq7gamGrK4Uujt9Z1R8+DuT6
 wYqw6WDOfGfFqMVFVVTVlIvCzCtzr0a8Kjm6q1/c42icKR6xfR9AnMabM g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="357939608"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; d="scan'208";a="357939608"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2023 04:48:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="683554388"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; d="scan'208";a="683554388"
Received: from wufei-optiplex-7090.sh.intel.com ([10.238.200.247])
 by orsmga006.jf.intel.com with ESMTP; 29 May 2023 04:48:09 -0700
From: Fei Wu <fei2.wu@intel.com>
To: richard.henderson@linaro.org, alex.bennee@linaro.org, qemu-devel@nongnu.org
Cc: Fei Wu <fei2.wu@intel.com>
Subject: [PATCH v13 00/10] TCG code quality tracking
Date: Mon, 29 May 2023 19:49:37 +0800
Message-Id: <20230529114947.2123652-1-fei2.wu@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.65; envelope-from=fei2.wu@intel.com;
 helo=mga03.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
* remove CONFIG_PROFILER completely at the first
* squash original patches 3-8 into one
* use Richard's inline version gen_tb_exec_count
* convert how-to to rst format as suggested by Thomas
* small change to patch 6 of hmp command


Alex Bennée (1):
  tb-stats: reset the tracked TBs on a tb_flush

Fei Wu (3):
  accel/tcg: remove CONFIG_PROFILER
  accel/tcg: add jit stats and time to TBStatistics
  docs: add tb-stats how to

Vanderson M. do Rosario (6):
  accel/tcg: introduce TBStatistics structure
  accel: collecting TB execution count
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
 accel/tcg/tb-stats.c          | 692 ++++++++++++++++++++++++++++++++++
 accel/tcg/tcg-accel-ops.c     |  15 +-
 accel/tcg/tcg-runtime.c       |   1 +
 accel/tcg/translate-all.c     | 147 ++++++--
 accel/tcg/translator.c        |  28 ++
 disas/disas.c                 |  26 +-
 docs/devel/tcg-tbstats.rst    | 129 +++++++
 hmp-commands-info.hx          |  16 +
 hmp-commands.hx               |  16 +
 include/exec/exec-all.h       |   3 +
 include/exec/gen-icount.h     |   2 +
 include/exec/tb-stats-dump.h  |  21 ++
 include/exec/tb-stats-flags.h |  34 ++
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
 36 files changed, 1614 insertions(+), 286 deletions(-)
 create mode 100644 accel/tcg/tb-stats.c
 create mode 100644 docs/devel/tcg-tbstats.rst
 create mode 100644 include/exec/tb-stats-dump.h
 create mode 100644 include/exec/tb-stats-flags.h
 create mode 100644 include/exec/tb-stats.h
 create mode 100644 stubs/tb-stats.c

-- 
2.25.1


