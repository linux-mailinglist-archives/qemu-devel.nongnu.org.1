Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AB570834D
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 15:56:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pze7e-00030R-9l; Thu, 18 May 2023 09:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1pze7c-000304-UN
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:56:48 -0400
Received: from mga12.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1pze7b-0002MR-EH
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684418207; x=1715954207;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ArZMSSGO1qFoz9Hu/1LYlf34qg3L88AfoA5zxcaf5bU=;
 b=hbBjVBlrCAfX4kfCv8wdSVq4ww+zL+6fanDwhEdm22Ke7H8IreSJT2nW
 y4IliIpAyO2gH6RbjkQ2OouPWy9CsPrXv2akTiVHZaRRlTvwlRz6xZHy3
 tEQkk26OhspJlHt+lrW02LOjujk6Y1HrINpVJ5cQsjINesNqPqnwlVE3Q
 ADH0metPFD8orIAtOr6m9VHp12Qtg57KuiJcyFtznIdKhHZ9qxeqRTHVy
 VwD49uPnILo320Mg+5dUC+wlqPulMUoatfitS/mx9wWFiXqX9fmETO09x
 n3KmvtSuLibM8CrEktg7kgDnHNuLIYvpR8wjK0UoEV5vs/wQuGjBxIGx3 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="331685718"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; d="scan'208";a="331685718"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2023 06:56:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="876428823"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; d="scan'208";a="876428823"
Received: from wufei-optiplex-7090.sh.intel.com ([10.238.200.247])
 by orsmga005.jf.intel.com with ESMTP; 18 May 2023 06:56:44 -0700
From: Fei Wu <fei2.wu@intel.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, fei2.wu@intel.com
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v12 05/15] accel/tcg: move profiler dev_time to tb_stats
Date: Thu, 18 May 2023 21:57:47 +0800
Message-Id: <20230518135757.1442654-6-fei2.wu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518135757.1442654-1-fei2.wu@intel.com>
References: <20230518135757.1442654-1-fei2.wu@intel.com>
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

From: Alex Bennée <alex.bennee@linaro.org>

This shouldn't live in the monitor code anyway. While we are at it
make it an uint64_t as we won't be dealing in negative numbers.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Fei Wu <fei2.wu@intel.com>
---
 accel/tcg/monitor.c  | 2 --
 accel/tcg/tb-stats.c | 2 ++
 include/qemu/timer.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
index 92fce580f1..d4e044f7f5 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/monitor.c
@@ -82,8 +82,6 @@ HumanReadableText *qmp_x_query_opcount(Error **errp)
 
 #ifdef CONFIG_PROFILER
 
-int64_t dev_time;
-
 HumanReadableText *qmp_x_query_profile(Error **errp)
 {
     g_autoptr(GString) buf = g_string_new("");
diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
index 74708d1f40..7deb617446 100644
--- a/accel/tcg/tb-stats.c
+++ b/accel/tcg/tb-stats.c
@@ -28,6 +28,8 @@ enum TBStatsStatus {
 static enum TBStatsStatus tcg_collect_tb_stats;
 static uint32_t default_tbstats_flag;
 
+uint64_t dev_time;
+
 struct jit_profile_info {
     uint64_t translations;
     uint64_t aborted;
diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index ee071e07d1..d86fc73a17 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -995,7 +995,7 @@ static inline int64_t profile_getclock(void)
     return get_clock();
 }
 
-extern int64_t dev_time;
+extern uint64_t dev_time;
 #endif
 
 #endif
-- 
2.25.1


