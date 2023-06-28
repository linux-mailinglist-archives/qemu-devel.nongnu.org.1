Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8237410A6
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 14:02:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qETsX-0007Rd-QJ; Wed, 28 Jun 2023 08:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1qETsN-0007PX-Sz
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 08:02:27 -0400
Received: from mga01.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1qETsL-0006fL-Dl
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 08:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687953741; x=1719489741;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=j+4mk9FNek0343R9PsrWQM06pCfK3kv7Dkabywtr5KQ=;
 b=OQNB/NSTKk64RiBQrfI4ZOs6zv07o/eXXvrmzKhO4dWgxm6XaM1u2wGD
 rU0VJG21xKVC/YqPuEReqGqPJlchj4oB8f6FyV7sUv9vX4Lvca+0nWAnt
 mw8vZ/eKPIzRMksujMCNar2n1CfqAq0pFHDErKtOeIp3eeEW9YxOvOP5A
 69NwIiMq7CzLS0NOuHnt1s1nk060Y5ky8sR0iLDna/xyuPDMVyPr8cJAE
 wgIaHSXS1dzT7rmsArxJ2K6zeyL1n/u/pzZmrxa61I3icmmscHeHuOIQU
 WC2SsgmXDeru+N7Yo1bRXPTxDLHbmjy4FzKOQcS4x6kS1GXJUk/hHxu8M A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="392547231"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; d="scan'208";a="392547231"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2023 05:02:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="841047464"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; d="scan'208";a="841047464"
Received: from wufei-optiplex-7090.sh.intel.com ([10.238.200.247])
 by orsmga004.jf.intel.com with ESMTP; 28 Jun 2023 05:02:08 -0700
From: Fei Wu <fei2.wu@intel.com>
To: richard.henderson@linaro.org, alex.bennee@linaro.org, qemu-devel@nongnu.org
Cc: Fei Wu <fei2.wu@intel.com>
Subject: [PATCH v16 0/9] TCG code quality tracking
Date: Wed, 28 Jun 2023 20:04:21 +0800
Message-Id: <20230628120430.73777-1-fei2.wu@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.88; envelope-from=fei2.wu@intel.com;
 helo=mga01.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

v16
--
* rebase to latest commit 4329d049d (Jun 26)
* original patch 1 (remove CONFIG_PROFILER) has already upstreamed so is
  removed from here
* add async_safe_run_on_cpu back for info tb-list/tb
* add ram_addr support to monitor_disas and use it to disassemble guest code
* update the commit logs and documents
* small change to do_hmp_tbstats_safe() to avoid memory leaking


Alex Bennée (1):
  tb-stats: reset the tracked TBs on a tb_flush

Fei Wu (4):
  accel/tcg: add jit stats to TBStatistics
  debug: add -d tb_stats to control TBStatistics
  tb-stats: dump hot TBs at the end of the execution
  docs: add tb-stats how to

Vanderson M. do Rosario (4):
  accel/tcg: introduce TBStatistics structure
  accel: collecting TB execution count
  monitor: adding tb_stats hmp command
  tb-stats: Adding info [tb-list|tb] commands to HMP

 MAINTAINERS                      |   1 +
 accel/tcg/cpu-exec.c             |   6 +
 accel/tcg/meson.build            |   1 +
 accel/tcg/monitor.c              | 216 ++++++++++++++++++
 accel/tcg/tb-context.h           |   1 +
 accel/tcg/tb-hash.h              |   7 +
 accel/tcg/tb-maint.c             |  20 ++
 accel/tcg/tb-stats.c             | 366 +++++++++++++++++++++++++++++++
 accel/tcg/tcg-runtime.c          |   1 +
 accel/tcg/translate-all.c        |  77 ++++++-
 accel/tcg/translator.c           |  31 +++
 disas/disas-mon.c                |  15 +-
 disas/disas.c                    |   2 +
 docs/devel/index-tcg.rst         |   1 +
 docs/devel/tcg-tbstats.rst       | 126 +++++++++++
 hmp-commands-info.hx             |  16 ++
 hmp-commands.hx                  |  16 ++
 include/disas/disas.h            |   8 +-
 include/exec/tb-stats-dump.h     |  21 ++
 include/exec/tb-stats-flags.h    |  29 +++
 include/exec/tb-stats.h          | 130 +++++++++++
 include/exec/translation-block.h |   3 +
 include/monitor/hmp.h            |   3 +
 include/qemu/log.h               |   1 +
 include/tcg/tcg-temp-internal.h  |   2 +
 include/tcg/tcg.h                |  10 +
 linux-user/exit.c                |   2 +
 monitor/hmp-cmds-target.c        |   3 +-
 softmmu/runstate.c               |   2 +
 stubs/meson.build                |   1 +
 stubs/tb-stats.c                 |  36 +++
 tcg/tcg.c                        |  47 +++-
 util/log.c                       |  26 +++
 33 files changed, 1217 insertions(+), 10 deletions(-)
 create mode 100644 accel/tcg/tb-stats.c
 create mode 100644 docs/devel/tcg-tbstats.rst
 create mode 100644 include/exec/tb-stats-dump.h
 create mode 100644 include/exec/tb-stats-flags.h
 create mode 100644 include/exec/tb-stats.h
 create mode 100644 stubs/tb-stats.c

-- 
2.25.1


