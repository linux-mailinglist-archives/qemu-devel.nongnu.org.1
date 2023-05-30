Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BF57158A2
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 10:34:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3unN-0001zL-Od; Tue, 30 May 2023 04:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q3unM-0001vo-5X
 for qemu-devel@nongnu.org; Tue, 30 May 2023 04:33:32 -0400
Received: from mga17.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q3unK-0001e6-Ap
 for qemu-devel@nongnu.org; Tue, 30 May 2023 04:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685435610; x=1716971610;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GxUbS8UIGU9fRc7ViV5mnBxcf9bwR8+T1stIrLTct80=;
 b=F/RHHzWnEOCceKIKin4insjhdIYD2hsWfaA+M79po+ENxWQyd4isi504
 r0eLGiCXF4kssn1DyvXnlajyD5Qdm/lbJKN7mbeRAYW4INGKbdoMfjNhO
 lcKYrjLz+VkW/bqm8Hb1B9JE3RbQXMWWST8qmkED5zZFLbHqFONnaOgTf
 OptgxMYXgQ64UJdPPapjZZ4tAKAgP4Ds1Pfw4oO3Pz6R4uOhOyeDb5sg3
 QzI0X7VkWVENLmn2iEvm28+AB5plWHzTZs+4QCrunJ+EKUpd/vWNfZztB
 mQZccLX7w8+YWtvdT3ph73LfMzRByqa74WRj1yGe1A10Ovc4sxK2ZMWPW w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="335202154"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; d="scan'208";a="335202154"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2023 01:33:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="796188309"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; d="scan'208";a="796188309"
Received: from wufei-optiplex-7090.sh.intel.com ([10.238.200.247])
 by FMSMGA003.fm.intel.com with ESMTP; 30 May 2023 01:33:08 -0700
From: Fei Wu <fei2.wu@intel.com>
To: richard.henderson@linaro.org, alex.bennee@linaro.org, qemu-devel@nongnu.org
Cc: Fei Wu <fei2.wu@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v14 10/10] docs: add tb-stats how to
Date: Tue, 30 May 2023 16:35:26 +0800
Message-Id: <20230530083526.2174430-11-fei2.wu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230530083526.2174430-1-fei2.wu@intel.com>
References: <20230530083526.2174430-1-fei2.wu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.151; envelope-from=fei2.wu@intel.com;
 helo=mga17.intel.com
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

Signed-off-by: Fei Wu <fei2.wu@intel.com>
---
 docs/devel/tcg-tbstats.rst | 129 +++++++++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)
 create mode 100644 docs/devel/tcg-tbstats.rst

diff --git a/docs/devel/tcg-tbstats.rst b/docs/devel/tcg-tbstats.rst
new file mode 100644
index 0000000000..bfba222e96
--- /dev/null
+++ b/docs/devel/tcg-tbstats.rst
@@ -0,0 +1,129 @@
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
+    tb_stats command [stats_level] -- Control tb statistics collection:tb_stats (start|pause|stop|filter) [all|jit_stats|exec_stats]
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
+    TB id:1 | phys:0x79bca0 virt:0xffffffff8059bca0 flags:0x01024001 0 inv/1
+            | exec:1464084/0 guest inst cov:0.15%
+            | trans:1 ints: g:3 op:16 op_opt:15 spills:0
+            | h/g (host bytes / guest insts): 64.000000
+            | time to gen at 2.4GHz => code:607.08(ns) IR:250.83(ns)
+
+    TB id:2 | phys:0x2adf0c virt:0xffffffff800adf0c flags:0x01024001 0 inv/1
+            | exec:1033298/0 guest inst cov:0.28%
+            | trans:1 ints: g:8 op:35 op_opt:33 spills:0
+            | h/g (host bytes / guest insts): 86.000000
+            | time to gen at 2.4GHz => code:1429.58(ns) IR:545.42(ns)
+
+* Dive into the specific TB::
+
+    (qemu) info tb 1 op
+    ------------------------------
+
+    TB id:1 | phys:0x79bca0 virt:0xffffffff8059bca0 flags:0x01024001 7 inv/19
+            | exec:2038349/0 guest inst cov:0.15%
+            | trans:19 ints: g:3 op:16 op_opt:15 spills:0
+            | h/g (host bytes / guest insts): 64.000000
+            | time to gen at 2.4GHz => code:133434.17(ns) IR:176988.33(ns)
+
+    OP:
+     ld_i32 loc1,env,$0xfffffffffffffff0
+     brcond_i32 loc1,$0x0,lt,$L0
+     mov_i64 loc3,$0x7f3c70b3a4e0
+     call inc_exec_freq,$0x1,$0,loc3
+
+     ---- ffffffff8059bca0 0000000000006422
+     add_i64 loc5,x2/sp,$0x8
+     qemu_ld_i64 x8/s0,loc5,un+leq,1
+
+     ---- ffffffff8059bca2 0000000000000000
+     add_i64 x2/sp,x2/sp,$0x10
+
+     ---- ffffffff8059bca4 0000000000000000
+     mov_i64 pc,x1/ra
+     and_i64 pc,pc,$0xfffffffffffffffe
+     call lookup_tb_ptr,$0x6,$1,tmp9,env
+     goto_ptr tmp9
+     set_label $L0
+     exit_tb $0x7f3e887a8043
+
+    ------------------------------
+
+* Stop TBStatistics after investigation, this will disable TBStatistics completely.::
+
+    (qemu) tb_stats stop
+    (qemu)
+
+* Alternatively, TBStatistics can be paused, the previous collected TBStatistics
+  are not cleared but there is no TBStatistics recorded for new TBs.::
+
+    (qemu) tb_stats pause
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
+    -d tb_stats[[,level=(+all+jit+exec+time)][,dump_limit=<number>]]
+
+e.g. starting qemu like this:::
+
+    -d tb_stats,dump_limit=2
+
+Qemu prints the following at exit:::
+
+    QEMU: Terminated
+    TB id:1 | phys:0x61be02 virt:0xffffffff8041be02 flags:0x01024001 0 inv/1
+            | exec:72739176/0 guest inst cov:20.22%
+            | trans:1 ints: g:9 op:35 op_opt:33 spills:0
+            | h/g (host bytes / guest insts): 51.555557
+            | time to gen at 2.4GHz => code:1065.42(ns) IR:554.17(ns)
+
+    TB id:2 | phys:0x61bc66 virt:0xffffffff8041bc66 flags:0x01024001 0 inv/1
+            | exec:25069507/0 guest inst cov:0.77%
+            | trans:1 ints: g:1 op:15 op_opt:14 spills:0
+            | h/g (host bytes / guest insts): 128.000000
+            | time to gen at 2.4GHz => code:312.50(ns) IR:152.08(ns)
-- 
2.25.1


