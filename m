Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2C2708DDF
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 04:39:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzq0U-0003pn-88; Thu, 18 May 2023 22:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin.wang@intel.com>)
 id 1pzq0S-0003pE-1J; Thu, 18 May 2023 22:38:12 -0400
Received: from mga02.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin.wang@intel.com>)
 id 1pzq0Q-0004rB-2c; Thu, 18 May 2023 22:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684463890; x=1715999890;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=TxyQsqyqnOhTBL2/T7k+HrhRFRAcxy9Mkce5NYYJ2w4=;
 b=UmnaJH8ifEeshVimL/rq+5s7pgo4ab6rMbTCNynjNbyBeUCU/3t0fg08
 2Szah5b1GmfQ1JOS0/OM1+3K20FmTwyJwg66ru5hmugJ21ibhlHLyAwKo
 zmuZAVUbxkzqbdAxcml8zjTq1VLa6TF/7ENn+UGMc65ZTUmP2Et1x3F/E
 65d87XFjGBOzi1Ey2HJhC3hgjLtf6EQpTuJK+cyqktdVLY8IW8v1hAXB9
 24syZ4+JVl7EsxqoK+ZDweo2qUWYinoVz4okfmNhr5OnLZBrLahr82dCs
 hjnGgmaKQvKxSL+AtqFNlv/QduWTDxySEWfqAt6qHWwd1sDNyonDLT8bz g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="341696108"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; d="scan'208";a="341696108"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2023 19:38:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="792185886"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; d="scan'208";a="792185886"
Received: from yin-optiplex-7090.sh.intel.com ([10.239.160.32])
 by FMSMGA003.fm.intel.com with ESMTP; 18 May 2023 19:38:00 -0700
From: Yin Wang <yin.wang@intel.com>
To: qemu-devel@nongnu.org
Cc: Yin Wang <yin.wang@intel.com>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>, Palmer Dabbelt <palmer@dabbelt.com>,
 Bin Meng <bin.meng@windriver.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PATCH v5] hw/riscv: qemu crash when NUMA nodes exceed available CPUs
Date: Fri, 19 May 2023 10:37:58 +0800
Message-Id: <20230519023758.1759434-1-yin.wang@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.20; envelope-from=yin.wang@intel.com;
 helo=mga02.intel.com
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

Command "qemu-system-riscv64 -machine virt
-m 2G -smp 1 -numa node,mem=1G -numa node,mem=1G"
would trigger this problem.Backtrace with:
 #0  0x0000555555b5b1a4 in riscv_numa_get_default_cpu_node_id  at ../hw/riscv/numa.c:211
 #1  0x00005555558ce510 in machine_numa_finish_cpu_init  at ../hw/core/machine.c:1230
 #2  0x00005555558ce9d3 in machine_run_board_init  at ../hw/core/machine.c:1346
 #3  0x0000555555aaedc3 in qemu_init_board  at ../softmmu/vl.c:2513
 #4  0x0000555555aaf064 in qmp_x_exit_preconfig  at ../softmmu/vl.c:2609
 #5  0x0000555555ab1916 in qemu_init  at ../softmmu/vl.c:3617
 #6  0x000055555585463b in main  at ../softmmu/main.c:47
This commit fixes the issue by adding parameter checks.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Yin Wang <yin.wang@intel.com>
---
 hw/riscv/numa.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/riscv/numa.c b/hw/riscv/numa.c
index 4720102561..e0414d5b1b 100644
--- a/hw/riscv/numa.c
+++ b/hw/riscv/numa.c
@@ -207,6 +207,12 @@ int64_t riscv_numa_get_default_cpu_node_id(const MachineState *ms, int idx)
 {
     int64_t nidx = 0;
 
+    if (ms->numa_state->num_nodes > ms->smp.cpus) {
+        error_report("Number of NUMA nodes (%d)"
+                     " cannot exceed the number of available CPUs (%d).",
+                     ms->numa_state->num_nodes, ms->smp.max_cpus);
+        exit(EXIT_FAILURE);
+    }
     if (ms->numa_state->num_nodes) {
         nidx = idx / (ms->smp.cpus / ms->numa_state->num_nodes);
         if (ms->numa_state->num_nodes <= nidx) {
-- 
2.34.1


