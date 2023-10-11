Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A647C51EE
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 13:24:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqXHT-0007Ya-Sh; Wed, 11 Oct 2023 07:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qqXHL-0007Ux-Jh; Wed, 11 Oct 2023 07:21:28 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qqXHJ-0000wW-Qv; Wed, 11 Oct 2023 07:21:27 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D126D29675;
 Wed, 11 Oct 2023 14:21:01 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 3EE592E6FB;
 Wed, 11 Oct 2023 14:20:56 +0300 (MSK)
Received: (nullmailer pid 1032031 invoked by uid 1000);
 Wed, 11 Oct 2023 11:20:55 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 05/13] MAINTAINERS: Add unowned RISC-V related files to the
 right sections
Date: Wed, 11 Oct 2023 14:20:46 +0300
Message-Id: <20231011112054.1031975-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011112054.1031975-1-mjt@tls.msk.ru>
References: <20231011112054.1031975-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Thomas Huth <thuth@redhat.com>

There are a bunch of RISC-V files that are currently not covered
by the "get_maintainers.pl" script. Add them to the right sections
in MAINTAINERS to fix this problem.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Acked-by: Christoph Müllner <christoph.muellner@vrull.eu>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Philipp Tomsich <philipp.tomsich@vrull.eu>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 MAINTAINERS | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93756ec21a..e80fca855a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -318,8 +318,11 @@ R: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
 R: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
 L: qemu-riscv@nongnu.org
 S: Supported
+F: configs/targets/riscv*
+F: docs/system/target-riscv.rst
 F: target/riscv/
 F: hw/riscv/
+F: hw/intc/riscv*
 F: include/hw/riscv/
 F: linux-user/host/riscv32/
 F: linux-user/host/riscv64/
@@ -331,6 +334,7 @@ L: qemu-riscv@nongnu.org
 S: Supported
 F: target/riscv/insn_trans/trans_xthead.c.inc
 F: target/riscv/xthead*.decode
+F: disas/riscv-xthead*
 
 RISC-V XVentanaCondOps extension
 M: Philipp Tomsich <philipp.tomsich@vrull.eu>
@@ -338,6 +342,7 @@ L: qemu-riscv@nongnu.org
 S: Maintained
 F: target/riscv/XVentanaCondOps.decode
 F: target/riscv/insn_trans/trans_xventanacondops.c.inc
+F: disas/riscv-xventana*
 
 RENESAS RX CPUs
 R: Yoshinori Sato <ysato@users.sourceforge.jp>
@@ -1527,6 +1532,7 @@ Microchip PolarFire SoC Icicle Kit
 M: Bin Meng <bin.meng@windriver.com>
 L: qemu-riscv@nongnu.org
 S: Supported
+F: docs/system/riscv/microchip-icicle-kit.rst
 F: hw/riscv/microchip_pfsoc.c
 F: hw/char/mchp_pfsoc_mmuart.c
 F: hw/misc/mchp_pfsoc_dmc.c
@@ -1542,6 +1548,7 @@ Shakti C class SoC
 M: Vijai Kumar K <vijai@behindbytes.com>
 L: qemu-riscv@nongnu.org
 S: Supported
+F: docs/system/riscv/shakti-c.rst
 F: hw/riscv/shakti_c.c
 F: hw/char/shakti_uart.c
 F: include/hw/riscv/shakti_c.h
@@ -1553,6 +1560,7 @@ M: Bin Meng <bin.meng@windriver.com>
 M: Palmer Dabbelt <palmer@dabbelt.com>
 L: qemu-riscv@nongnu.org
 S: Supported
+F: docs/system/riscv/sifive_u.rst
 F: hw/*/*sifive*.c
 F: include/hw/*/*sifive*.h
 
@@ -3573,7 +3581,7 @@ M: Alistair Francis <Alistair.Francis@wdc.com>
 L: qemu-riscv@nongnu.org
 S: Maintained
 F: tcg/riscv/
-F: disas/riscv.c
+F: disas/riscv.[ch]
 
 S390 TCG target
 M: Richard Henderson <richard.henderson@linaro.org>
-- 
2.39.2


