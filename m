Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90085725F03
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 14:22:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6sAe-0001rh-Dw; Wed, 07 Jun 2023 08:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q6sAZ-0001rK-Fb
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 08:21:44 -0400
Received: from mga06b.intel.com ([134.134.136.31] helo=mga06.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q6sAX-0004hp-1j
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 08:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686140501; x=1717676501;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=RwPUzAq0hNC2C7SfUc4v6rEAWvvQK0xH7knmtC8VfCg=;
 b=BYsAALcMCNvoVJPmaaYf7wvluBI3zpThb7RgRxzSUmI5onTRpAvXToTW
 DH5DmfHInF1AWb2VvW48yVOzfEu1Tq7yLVM3IIiw0d+UNr7dfmajQvEQd
 UdQARoFpRzB6IfYyyfGDBShJnuvlb+WzMqS8yCkdwuRGuHAvcaUtQPAes
 ZmAqoxvJLuAZt9l53CD5uUFQGOJtYwnmz96vwpTtniLqsump9RpunEUUW
 aZovvbECuvFKZBVSBjJdSLEz0qNldvUMQsdzjNGPm5ociGzHaE5Rn5Nad
 pWFiYRR0ai+mmMIe+aLZ+PIVTYf+zChAwoUhKOJW4QPuxzua9FnTVlvW0 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="420527883"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; d="scan'208";a="420527883"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2023 05:21:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="686969969"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; d="scan'208";a="686969969"
Received: from wufei-optiplex-7090.sh.intel.com ([10.238.200.247])
 by orsmga006.jf.intel.com with ESMTP; 07 Jun 2023 05:21:35 -0700
From: Fei Wu <fei2.wu@intel.com>
To: richard.henderson@linaro.org, alex.bennee@linaro.org, qemu-devel@nongnu.org
Cc: Fei Wu <fei2.wu@intel.com>
Subject: [PATCH v15 00/10] TCG code quality tracking
Date: Wed,  7 Jun 2023 20:24:01 +0800
Message-Id: <20230607122411.3394702-1-fei2.wu@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.31; envelope-from=fei2.wu@intel.com;
 helo=mga06.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

v15
---
This is a large change:
* remove all time related stuffs, including cmd 'info profile'
* remove the per-TB flag, use global flag instead
* remove tb_stats pause/filter, but add status
* remove qemu_log changes, and use monitor_printf
* use array instead of list for sorting
* remove async_safe_run_on_cpu for cmd info tb-list & tb
* use monitor_disas instead of regenerate TB, but **doesn't work yet**
* other cleanups


Alex Bennée (1):
  tb-stats: reset the tracked TBs on a tb_flush

Fei Wu (5):
  accel/tcg: remove CONFIG_PROFILER
  accel/tcg: add jit stats to TBStatistics
  debug: add -d tb_stats to control TBStatistics
  tb-stats: dump hot TBs at the end of the execution
  docs: add tb-stats how to

Vanderson M. do Rosario (4):
  accel/tcg: introduce TBStatistics structure
  accel: collecting TB execution count
  monitor: adding tb_stats hmp command
  tb-stats: Adding info [tb-list|tb] commands to HMP (WIP)

 MAINTAINERS                   |   1 +
 accel/tcg/cpu-exec.c          |   6 +
 accel/tcg/meson.build         |   1 +
 accel/tcg/monitor.c           | 184 +++++++++++++++--
 accel/tcg/tb-context.h        |   1 +
 accel/tcg/tb-hash.h           |   7 +
 accel/tcg/tb-maint.c          |  20 ++
 accel/tcg/tb-stats.c          | 365 ++++++++++++++++++++++++++++++++++
 accel/tcg/tcg-accel-ops.c     |  10 -
 accel/tcg/tcg-runtime.c       |   1 +
 accel/tcg/translate-all.c     | 110 ++++++----
 accel/tcg/translator.c        |  30 +++
 disas/disas.c                 |   2 +
 docs/devel/tcg-tbstats.rst    |  97 +++++++++
 hmp-commands-info.hx          |  31 +--
 hmp-commands.hx               |  16 ++
 include/exec/exec-all.h       |   3 +
 include/exec/gen-icount.h     |   1 +
 include/exec/tb-stats-dump.h  |  21 ++
 include/exec/tb-stats-flags.h |  29 +++
 include/exec/tb-stats.h       | 130 ++++++++++++
 include/monitor/hmp.h         |   3 +
 include/qemu/log.h            |   1 +
 include/qemu/timer.h          |   9 -
 include/tcg/tcg.h             |  26 +--
 linux-user/exit.c             |   2 +
 meson.build                   |   2 -
 meson_options.txt             |   2 -
 qapi/machine.json             |  18 --
 scripts/meson-buildoptions.sh |   3 -
 softmmu/runstate.c            |  11 +-
 stubs/meson.build             |   1 +
 stubs/tb-stats.c              |  36 ++++
 tcg/tcg.c                     | 237 +++-------------------
 tests/qtest/qmp-cmd-test.c    |   3 -
 util/log.c                    |  26 +++
 36 files changed, 1093 insertions(+), 353 deletions(-)
 create mode 100644 accel/tcg/tb-stats.c
 create mode 100644 docs/devel/tcg-tbstats.rst
 create mode 100644 include/exec/tb-stats-dump.h
 create mode 100644 include/exec/tb-stats-flags.h
 create mode 100644 include/exec/tb-stats.h
 create mode 100644 stubs/tb-stats.c

-- 
2.25.1


