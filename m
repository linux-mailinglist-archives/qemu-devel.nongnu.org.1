Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F01A780EB8C
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 13:20:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD1jX-0005aY-MO; Tue, 12 Dec 2023 07:19:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rD1jV-0005R3-0h; Tue, 12 Dec 2023 07:19:29 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rD1jT-0000Nw-0u; Tue, 12 Dec 2023 07:19:28 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8A59B3AEFF;
 Tue, 12 Dec 2023 15:18:49 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4D49F3B94D;
 Tue, 12 Dec 2023 15:18:32 +0300 (MSK)
Received: (nullmailer pid 1003432 invoked by uid 1000);
 Tue, 12 Dec 2023 12:18:31 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Rom=C3=A1n=20C=C3=A1rdenas?= <rcardenas.rod@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.4 11/31] riscv: Fix SiFive E CLINT clock frequency
Date: Tue, 12 Dec 2023 15:17:59 +0300
Message-Id: <20231212121831.1003318-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.4-20231211211211@cover.tls.msk.ru>
References: <qemu-stable-8.1.4-20231211211211@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Román Cárdenas <rcardenas.rod@gmail.com>

If you check the manual of SiFive E310 (https://cdn.sparkfun.com/assets/7/f/0/2/7/fe310-g002-manual-v19p05.pdf),
you can see in Figure 1 that the CLINT is connected to the real time clock, which also feeds the AON peripheral (they share the same clock).
In page 43, the docs also say that the timer registers of the CLINT count ticks from the rtcclk.

I am currently playing with bare metal applications both in QEMU and a physical SiFive E310 board and
I confirm that the CLINT clock in the physical board runs at 32.768 kHz.
In QEMU, the same app produces a completely different outcome, as sometimes a new CLINT interrupt is triggered before finishing other tasks.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1978

Signed-off-by: Rom\ufffd\ufffdn C\ufffd\ufffdrdenas <rcardenas.rod@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20231117082840.55705-1-rcardenas.rod@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit a7472560ca5f7a61ef3a46b52118f680de81058c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 0d37adc542..87d9602383 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -225,7 +225,7 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
             RISCV_ACLINT_SWI_SIZE,
         RISCV_ACLINT_DEFAULT_MTIMER_SIZE, 0, ms->smp.cpus,
         RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_MTIME,
-        RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, false);
+        SIFIVE_E_LFCLK_DEFAULT_FREQ, false);
     sifive_e_prci_create(memmap[SIFIVE_E_DEV_PRCI].base);
 
     /* AON */
-- 
2.39.2


