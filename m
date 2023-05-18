Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EAD708356
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 15:58:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pze8I-0004pt-Bl; Thu, 18 May 2023 09:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1pze8G-0004ly-5z
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:57:28 -0400
Received: from mga12.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1pze8D-0002T5-8O
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684418245; x=1715954245;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=nWRAIWMWrMIimTopfekgs94LLyTiAZ7gYt4lq+MEsjs=;
 b=U6K64On3bOpIVSpDNSeesdl3Mv60KOr+donTwKE+Xtp8FA106ffs6t7M
 a1bu6wHa4bJLDTLGlpAWEdxfOVB/h+NQLHxvUToCT5tWhtxPw4/p4C8dx
 gSbkmZXUeWfwLuP2I4VgYXEsdxNaJUB15sKL6hbSuWhDoku8usl/sg3MS
 YzKCgA/bLTNbx3Lg54wWz6EV19AQOeRF+cCXIgBYBpc94uBX/xXKkcXay
 THv7rzeF72Vae39spN5kdc3SGuNr5+ZkaR83/yLCx3ebfjQfZCXfOy5nE
 QArpaS2oXGOvEkjcnLoOowJivpLX/hM4br/yZfUJGOrX86avNXO5pWM93 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="331685955"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; d="scan'208";a="331685955"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2023 06:57:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="876428879"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; d="scan'208";a="876428879"
Received: from wufei-optiplex-7090.sh.intel.com ([10.238.200.247])
 by orsmga005.jf.intel.com with ESMTP; 18 May 2023 06:57:23 -0700
From: Fei Wu <fei2.wu@intel.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, fei2.wu@intel.com
Subject: [PATCH v12 15/15] docs/tb-stats: add how to
Date: Thu, 18 May 2023 21:57:57 +0800
Message-Id: <20230518135757.1442654-16-fei2.wu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518135757.1442654-1-fei2.wu@intel.com>
References: <20230518135757.1442654-1-fei2.wu@intel.com>
MIME-Version: 1.0
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

Signed-off-by: Fei Wu <fei2.wu@intel.com>
---
 docs/tb-stats.txt | 116 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100644 docs/tb-stats.txt

diff --git a/docs/tb-stats.txt b/docs/tb-stats.txt
new file mode 100644
index 0000000000..2f96ebb741
--- /dev/null
+++ b/docs/tb-stats.txt
@@ -0,0 +1,116 @@
+TBStatistics
+============
+
+What is TBStatistics
+--------------------
+TBStatistics (tb_stats) is a tool to gather various internal information of TCG
+during binary translation, this allows us to identify such as hottest TBs,
+guest to host instruction translation ratio, number of spills during register
+allocation and more.
+
+
+How to use TBStatistics
+-----------------------
+
+1. HMP interface
+---------------
+
+TBStatistics provides HMP interface, you can try the following examples after
+connecting to the monitor.
+
+* First check the help info
+    (qemu) help tb_stats
+    tb_stats command [stats_level] -- Control tb statistics collection:tb_stats (start|pause|stop|filter) [all|jit_stats|exec_stats]
+
+    (qemu) help info tb-list
+    info tb-list [number sortedby] -- show a [number] translated blocks sorted by [sortedby]sortedby opts: hotness hg spills
+
+    (qemu) help info tb
+    info tb id [flag1,flag2,...] -- show information about one translated block by id.dump flags can be used to set dump code level: out_asm in_asm op
+
+* Enable TBStatistics
+    (qemu) tb_stats start all
+    (qemu)
+
+* Get interested TB list
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
+* Dive into the specific TB
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
+* Stop TBStatistics after investigation, this will disable TBStatistics completely.
+    (qemu) tb_stats stop
+    (qemu)
+
+* Alternatively, TBStatistics can be paused, the previous collected TBStatistics
+  are not cleared but there is no TBStatistics recorded for new TBs.
+    (qemu) tb_stats pause
+    (qemu)
+
+* Definitely, TBStatistics can be restarted for another round of investigation.
+    (qemu) tb_stats start all
+    (qemu)
+
+
+2. Dump at exit
+---------------
+New command line options have been added to enable dump TB information at exit:
+    -d tb_stats[[,level=(+all+jit+exec+time)][,dump_limit=<number>]]
+
+e.g. starting qemu like this:
+    -d tb_stats,dump_limit=2
+
+Qemu prints the following at exit:
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


