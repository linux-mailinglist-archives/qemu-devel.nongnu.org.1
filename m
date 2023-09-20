Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6358E7A7E8F
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 14:18:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiw8E-0002O0-UR; Wed, 20 Sep 2023 08:16:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qiw7w-0002BP-H2; Wed, 20 Sep 2023 08:16:23 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qiw7t-0005K5-84; Wed, 20 Sep 2023 08:16:20 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C4B6A23A00;
 Wed, 20 Sep 2023 15:16:14 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 24929296F7;
 Wed, 20 Sep 2023 15:15:55 +0300 (MSK)
Received: (nullmailer pid 105892 invoked by uid 1000);
 Wed, 20 Sep 2023 12:15:53 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Conor Dooley <conor.dooley@microchip.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.6 58/63] hw/riscv: virt: Fix riscv,pmu DT node path
Date: Wed, 20 Sep 2023 15:15:43 +0300
Message-Id: <20230920121553.105832-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.6-20230920151401@cover.tls.msk.ru>
References: <qemu-stable-7.2.6-20230920151401@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Conor Dooley <conor.dooley@microchip.com>

On a dtb dumped from the virt machine, dt-validate complains:
soc: pmu: {'riscv,event-to-mhpmcounters': [[1, 1, 524281], [2, 2, 524284], [65561, 65561, 524280], [65563, 65563, 524280], [65569, 65569, 524280]], 'compatible': ['riscv,pmu']} should not be valid under {'type': 'object'}
        from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
That's pretty cryptic, but running the dtb back through dtc produces
something a lot more reasonable:
Warning (simple_bus_reg): /soc/pmu: missing or empty reg/ranges property

Moving the riscv,pmu node out of the soc bus solves the problem.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20230727-groom-decline-2c57ce42841c@spud>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 9ff31406312500053ecb5f92df01dd9ce52e635d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: context adjustment due to 568e0614d09 "hw/riscv/virt.c: rename MachineState 'mc' pointers to 'ms'")

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index a5bc7353b4..3a99b4b801 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -715,7 +715,7 @@ static void create_fdt_pmu(RISCVVirtState *s)
     MachineState *mc = MACHINE(s);
     RISCVCPU hart = s->soc[0].harts[0];
 
-    pmu_name = g_strdup_printf("/soc/pmu");
+    pmu_name = g_strdup_printf("/pmu");
     qemu_fdt_add_subnode(mc->fdt, pmu_name);
     qemu_fdt_setprop_string(mc->fdt, pmu_name, "compatible", "riscv,pmu");
     riscv_pmu_generate_fdt_node(mc->fdt, hart.cfg.pmu_num, pmu_name);
-- 
2.39.2


