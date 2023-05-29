Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0CB7148E6
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 13:51:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3bMm-00051M-H1; Mon, 29 May 2023 07:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q3bMj-0004w8-RI
 for qemu-devel@nongnu.org; Mon, 29 May 2023 07:48:45 -0400
Received: from mga03.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q3bMV-0004Vb-W7
 for qemu-devel@nongnu.org; Mon, 29 May 2023 07:48:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685360911; x=1716896911;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WnLCWfCSqwSiixTrHZEbE/aOCOJUgtmsHPfJ6KMuPx8=;
 b=M8WxTi1I86KDoPTw5GXXlK8wd3dQ/XlR4XVQ0qrVkeEJ1e6Rd8A6HZAa
 R/n+bpN0JhuZNl+/Y4GHnJ7+OnZi33qqy08XdT+bcA8XRxxdsuHYIlhS0
 Akg1e+mADhROKTPlnY5u/+GpTNk8szf84Nbt6Squ5iXifQ+54FTiXYZGz
 d59H2/KaGh+YSDXkg2ddzbIIp8Sa3V7YH8KnMFVovMCbq5fqxR1hWPeAH
 3ve4oVFozZjPd+9YsrZNLJCiU+I9KNOdlGrDGWs3YdSPkMWR+fDnEKJdV
 bulxvbbg6renVUaWzftCyH+8/zaXBfCHqnGUrkNzJCqOoeUiNRt0EtqFK w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="357939668"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; d="scan'208";a="357939668"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2023 04:48:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="683554473"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; d="scan'208";a="683554473"
Received: from wufei-optiplex-7090.sh.intel.com ([10.238.200.247])
 by orsmga006.jf.intel.com with ESMTP; 29 May 2023 04:48:26 -0700
From: Fei Wu <fei2.wu@intel.com>
To: richard.henderson@linaro.org, alex.bennee@linaro.org, qemu-devel@nongnu.org
Cc: Fei Wu <fei2.wu@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v13 07/10] tb-stats: reset the tracked TBs on a tb_flush
Date: Mon, 29 May 2023 19:49:44 +0800
Message-Id: <20230529114947.2123652-8-fei2.wu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230529114947.2123652-1-fei2.wu@intel.com>
References: <20230529114947.2123652-1-fei2.wu@intel.com>
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
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

We keep track of translations but can only do so up until the
translation cache is flushed. At that point we really have no idea if
we can re-create a translation because all the active tracking
information has been reset.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Fei Wu <fei2.wu@intel.com>
---
 accel/tcg/tb-maint.c    |  1 +
 accel/tcg/tb-stats.c    | 19 +++++++++++++++++++
 include/exec/tb-stats.h |  8 ++++++++
 3 files changed, 28 insertions(+)

diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 0980fca358..11ff0ddd90 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -763,6 +763,7 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
     qht_reset_size(&tb_ctx.htable, CODE_GEN_HTABLE_SIZE);
     tb_remove_all();
 
+    tbstats_reset_tbs();
     tcg_region_reset_all();
     /* XXX: flush processor icache at this point if cache flush is expensive */
     qatomic_inc(&tb_ctx.tb_flush_count);
diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
index 805e1fc74d..139f049ffc 100644
--- a/accel/tcg/tb-stats.c
+++ b/accel/tcg/tb-stats.c
@@ -267,6 +267,25 @@ void do_hmp_tbstats_safe(CPUState *cpu, run_on_cpu_data icmd)
     g_free(cmdinfo);
 }
 
+/*
+ * We have to reset the tbs array on a tb_flush as those
+ * TranslationBlocks no longer exist and we no loner know if the
+ * current mapping is still valid.
+ */
+
+static void reset_tbs_array(void *p, uint32_t hash, void *userp)
+{
+    TBStatistics *tbs = p;
+    g_ptr_array_set_size(tbs->tbs, 0);
+}
+
+void tbstats_reset_tbs(void)
+{
+    if (tb_ctx.tb_stats.map) {
+        qht_iter(&tb_ctx.tb_stats, reset_tbs_array, NULL);
+    }
+}
+
 void init_tb_stats_htable(void)
 {
     if (!tb_ctx.tb_stats.map && tb_stats_collection_enabled()) {
diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
index 4bb343870b..30b788f7b2 100644
--- a/include/exec/tb-stats.h
+++ b/include/exec/tb-stats.h
@@ -124,4 +124,12 @@ struct TbstatsCommand {
 
 void do_hmp_tbstats_safe(CPUState *cpu, run_on_cpu_data icmd);
 
+/**
+ * tbstats_reset_tbs: reset the linked array of TBs
+ *
+ * Reset the list of tbs for a given array. Should be called from
+ * safe work during tb_flush.
+ */
+void tbstats_reset_tbs(void);
+
 #endif
-- 
2.25.1


