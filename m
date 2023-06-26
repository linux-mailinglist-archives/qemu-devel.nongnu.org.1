Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC7073EAFC
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 21:12:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDrND-0004Fe-AN; Mon, 26 Jun 2023 14:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrLN-0001pI-Uz; Mon, 26 Jun 2023 14:53:51 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrLL-0005QW-TS; Mon, 26 Jun 2023 14:53:45 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 50A2CEF3C;
 Mon, 26 Jun 2023 21:50:26 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 8521AF7CB;
 Mon, 26 Jun 2023 21:50:24 +0300 (MSK)
Received: (nullmailer pid 1574070 invoked by uid 1000);
 Mon, 26 Jun 2023 18:50:16 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Yin Wang <yin.wang@intel.com>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.3 37/54] hw/riscv: qemu crash when NUMA nodes exceed
 available CPUs
Date: Mon, 26 Jun 2023 21:49:44 +0300
Message-Id: <20230626185002.1573836-37-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.3-20230626214235@cover.tls.msk.ru>
References: <qemu-stable-8.0.3-20230626214235@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Yin Wang <yin.wang@intel.com>

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
Message-Id: <20230519023758.1759434-1-yin.wang@intel.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit b9cedbf19cb4be04908a3a623f0f237875483499)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

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
2.39.2


