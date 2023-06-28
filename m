Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5EE7410B6
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 14:05:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qETtD-0008BK-EN; Wed, 28 Jun 2023 08:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1qETsj-0007ZQ-Eo
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 08:02:46 -0400
Received: from mga01.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1qETsh-0006fL-Ef
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 08:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687953763; x=1719489763;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9LJJviAfYCdAvePXobpw6wkDnhxf+chY/C56H1WEv/Y=;
 b=Ti57/p4auF4fe7VjbOEGI8B0enGoxOUXc/SUyrsSi/BPnXUOzrXkRdw9
 UwPli6sRdEga7OUl2NwZODIFi3oEcJmAc9MbBDg48IwhowvUtr8Yb7Jgy
 NzUq2GzCqy5LuZXldKMZ5VPexXfS5FYpdHRMaCcXnA1FbZEWjzNBYEMHa
 rovBuAm+k5rSurRWGMTda4fze4eIf246rVa581z6NAb5Fp60xTAP34BRF
 d7BsCvN5/Frnx8BHv+c8Nb2nRfsQuG8d8cFREQToPwmhgXg4oaF/IMYcJ
 8RMycA7hr1pGWfeOvgWd42PnIudXyQDs73Q6CE9yKbsbikMY7MHUxkHv2 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="392547374"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; d="scan'208";a="392547374"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2023 05:02:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="841047527"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; d="scan'208";a="841047527"
Received: from wufei-optiplex-7090.sh.intel.com ([10.238.200.247])
 by orsmga004.jf.intel.com with ESMTP; 28 Jun 2023 05:02:32 -0700
From: Fei Wu <fei2.wu@intel.com>
To: richard.henderson@linaro.org, alex.bennee@linaro.org, qemu-devel@nongnu.org
Cc: Fei Wu <fei2.wu@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v16 9/9] docs: add tb-stats how to
Date: Wed, 28 Jun 2023 20:04:30 +0800
Message-Id: <20230628120430.73777-10-fei2.wu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230628120430.73777-1-fei2.wu@intel.com>
References: <20230628120430.73777-1-fei2.wu@intel.com>
MIME-Version: 1.0
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

Signed-off-by: Fei Wu <fei2.wu@intel.com>
---
 docs/devel/index-tcg.rst   |   1 +
 docs/devel/tcg-tbstats.rst | 126 +++++++++++++++++++++++++++++++++++++
 2 files changed, 127 insertions(+)
 create mode 100644 docs/devel/tcg-tbstats.rst

diff --git a/docs/devel/index-tcg.rst b/docs/devel/index-tcg.rst
index b44ff8b5a4..8d2832737f 100644
--- a/docs/devel/index-tcg.rst
+++ b/docs/devel/index-tcg.rst
@@ -14,4 +14,5 @@ are only implementing things for HW accelerated hypervisors.
    multi-thread-tcg
    tcg-icount
    tcg-plugins
+   tcg-tbstats
    replay
diff --git a/docs/devel/tcg-tbstats.rst b/docs/devel/tcg-tbstats.rst
new file mode 100644
index 0000000000..3940a3cb9d
--- /dev/null
+++ b/docs/devel/tcg-tbstats.rst
@@ -0,0 +1,126 @@
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
+What does TBStatistics collect
+===============================
+
+TBStatistics mainly collects the following stats:
+
+* TB exec stats, e.g. the execution count of each TB
+* TB jit stats, e.g. guest insn count, tcg ops, tcg spill etc.
+* opcount of each instruction, use 'info opcount' to show it
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
+            | trans:1 inst: g:3 op:16 op_opt:15 spills:0
+            | h/g (host bytes / guest insts): 64.000000
+
+    TB id:1 | phys:0x2adf0c virt:0xffffffff800adf0c flags:0x01024001 0 inv/1
+            | exec:1033298/0 guest inst cov:0.28%
+            | trans:1 inst: g:8 op:35 op_opt:33 spills:0
+            | h/g (host bytes / guest insts): 86.000000
+
+* Dive into the specific TB::
+
+    (qemu) info tb 0
+    ------------------------------
+
+    TB id:0 | phys:0x63474e virt:0x0000000000000000 flags:0x01028001 0 inv/1
+            | exec:131719290/0 guest inst cov:8.44%
+            | trans:1 ints: g:9 op:36 op_opt:34 spills:0
+            | h/g (host bytes / guest insts): 51.555557
+
+    0x0063474e:  00194a83          lbu                     s5,1(s2)
+    0x00634752:  00094803          lbu                     a6,0(s2)
+    0x00634756:  0b09              addi                    s6,s6,2
+    0x00634758:  008a9a9b          slliw                   s5,s5,8
+    0x0063475c:  01586833          or                      a6,a6,s5
+    0x00634760:  ff0b1f23          sh                      a6,-2(s6)
+    0x00634764:  1c7d              addi                    s8,s8,-1
+    0x00634766:  0909              addi                    s2,s2,2
+    0x00634768:  fe0c13e3          bnez                    s8,-26                  # 0x63474e
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
+2. Start TBStatistics with command line
+---------------------------------------
+
+If you don't want to missing anything at guest starting, command line option is
+provided to start TBStatistics at start:::
+
+    -d tb_stats_{all,jit,exec}
+
+
+3. Dump hottest at exit
+-----------------------
+
+TBStatistics is able to dump hottest TB information at exit as follows:::
+
+    -d tb_stats_{all,jit,exec}[:dump_num_at_exit]
+
+e.g. starting qemu like this:::
+
+    -d tb_stats_all:2
+
+QEMU prints the following at exit:::
+
+    TB id:0 | phys:0x242b8 virt:0x00000000000242b8 flags:0x00024078 0 inv/0
+            | exec:1161/0 guest inst cov:10.36%
+            | trans:1 ints: g:2 op:20 op_opt:19 spills:0
+            | h/g (host bytes / guest insts): 61.500000
+
+    TB id:1 | phys:0x242be virt:0x00000000000242be flags:0x00024078 0 inv/0
+            | exec:1161/0 guest inst cov:10.36%
+            | trans:1 ints: g:2 op:20 op_opt:18 spills:0
+            | h/g (host bytes / guest insts): 59.500000
+
+This is particularly useful for user mode QEMU.
-- 
2.25.1


