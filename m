Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 414DE725F07
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 14:22:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6sAx-0002Dn-3T; Wed, 07 Jun 2023 08:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q6sAu-00028J-7Y
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 08:22:04 -0400
Received: from mga06b.intel.com ([134.134.136.31] helo=mga06.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q6sAs-0004lg-55
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 08:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686140522; x=1717676522;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dJ+2Srr8PrkmCOnhhnEFjWHUwRO9J31R50sJcSnAkj0=;
 b=CesYm1mTI/wnas320Ju2DVekHIkBqkC+SqzVC/LgPNaNAZNxyg3jlXik
 +NH9/jJEz3xbkSAAJeoUxdDRRtyYIql+rpRd19ZG5ZMbKKimivmELr6Oo
 7H2eMKwPbtL4Bant/I1dUqd9gmq2hslXnOwabTStz9XmCjFKEBXWHoJQz
 nlLglIXio0UF3FXPSrWt7czrE3a727DpQxUNEH+/ZOGU10rabMRYVSKLK
 iGAyrAjgbJF7cGY4aDlPmlAny/7finEPgSZ+Znp2Q+ndBgVAt4vyM/iod
 wy5S5CIKau9D/ffEyCKauwjsJX6gbMo4ElFC33uiRiXIDvTUnlXHwPnLL A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="420527977"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; d="scan'208";a="420527977"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2023 05:22:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="686970084"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; d="scan'208";a="686970084"
Received: from wufei-optiplex-7090.sh.intel.com ([10.238.200.247])
 by orsmga006.jf.intel.com with ESMTP; 07 Jun 2023 05:21:59 -0700
From: Fei Wu <fei2.wu@intel.com>
To: richard.henderson@linaro.org, alex.bennee@linaro.org, qemu-devel@nongnu.org
Cc: Fei Wu <fei2.wu@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v15 10/10] docs: add tb-stats how to
Date: Wed,  7 Jun 2023 20:24:11 +0800
Message-Id: <20230607122411.3394702-11-fei2.wu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230607122411.3394702-1-fei2.wu@intel.com>
References: <20230607122411.3394702-1-fei2.wu@intel.com>
MIME-Version: 1.0
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

Signed-off-by: Fei Wu <fei2.wu@intel.com>
---
 docs/devel/tcg-tbstats.rst | 97 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 docs/devel/tcg-tbstats.rst

diff --git a/docs/devel/tcg-tbstats.rst b/docs/devel/tcg-tbstats.rst
new file mode 100644
index 0000000000..dd611e41f3
--- /dev/null
+++ b/docs/devel/tcg-tbstats.rst
@@ -0,0 +1,97 @@
+============
+TBStatistics
+============
+
+What is TBStatistics
+====================
+
+TBStatistics (tb_stats) is a tool to gather various internal information of TCG
+during binary translation, this allows us to identify such as hottest TBs,
+guest to host instruction translation ratio, number of spills during register
+allocation and more.
+
+
+How to use TBStatistics
+=======================
+
+1. HMP interface
+----------------
+
+TBStatistics provides HMP interface, you can try the following examples after
+connecting to the monitor.
+
+* First check the help info::
+
+    (qemu) help tb_stats
+    tb_stats command [flag] -- Control tb statistics collection:tb_stats (start|stop|status) [all|jit|exec]
+
+    (qemu) help info tb-list
+    info tb-list [number sortedby] -- show a [number] translated blocks sorted by [sortedby]sortedby opts: hotness hg spills
+
+    (qemu) help info tb
+    info tb id [flag1,flag2,...] -- show information about one translated block by id.dump flags can be used to set dump code level: out_asm in_asm op
+
+* Enable TBStatistics::
+
+    (qemu) tb_stats start all
+    (qemu)
+
+* Get interested TB list::
+
+    (qemu) info tb-list 2
+    TB id:0 | phys:0x79bca0 virt:0xffffffff8059bca0 flags:0x01024001 0 inv/1
+            | exec:1464084/0 guest inst cov:0.15%
+            | trans:1 ints: g:3 op:16 op_opt:15 spills:0
+            | h/g (host bytes / guest insts): 64.000000
+
+    TB id:1 | phys:0x2adf0c virt:0xffffffff800adf0c flags:0x01024001 0 inv/1
+            | exec:1033298/0 guest inst cov:0.28%
+            | trans:1 ints: g:8 op:35 op_opt:33 spills:0
+            | h/g (host bytes / guest insts): 86.000000
+
+* Dive into the specific TB::
+
+    (qemu) info tb 1
+    ------------------------------
+
+    TB id:0 | phys:0x79bca0 virt:0xffffffff8059bca0 flags:0x01024001 7 inv/19
+            | exec:2038349/0 guest inst cov:0.15%
+            | trans:19 ints: g:3 op:16 op_opt:15 spills:0
+            | h/g (host bytes / guest insts): 64.000000
+
+    ------------------------------
+
+* Stop TBStatistics after investigation, this will disable TBStatistics completely.::
+
+    (qemu) tb_stats stop
+    (qemu)
+
+* Definitely, TBStatistics can be restarted for another round of investigation.::
+
+    (qemu) tb_stats start all
+    (qemu)
+
+
+2. Dump at exit
+---------------
+
+New command line options have been added to enable dump TB information at exit:::
+
+    -d tb_stats_{all,jit,exec}[:dump_num_at_exit]
+
+e.g. starting qemu like this:::
+
+    -d tb_stats_all:2
+
+Qemu prints the following at exit:::
+
+    QEMU: Terminated
+    TB id:1 | phys:0x61be02 virt:0xffffffff8041be02 flags:0x01024001 0 inv/1
+            | exec:72739176/0 guest inst cov:20.22%
+            | trans:1 ints: g:9 op:35 op_opt:33 spills:0
+            | h/g (host bytes / guest insts): 51.555557
+
+    TB id:2 | phys:0x61bc66 virt:0xffffffff8041bc66 flags:0x01024001 0 inv/1
+            | exec:25069507/0 guest inst cov:0.77%
+            | trans:1 ints: g:1 op:15 op_opt:14 spills:0
+            | h/g (host bytes / guest insts): 128.000000
-- 
2.25.1


