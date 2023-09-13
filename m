Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D34B279E915
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 15:22:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgPls-0007i3-Hr; Wed, 13 Sep 2023 09:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qgPlq-0007ha-Fw; Wed, 13 Sep 2023 09:19:06 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qgPlm-0003iY-K2; Wed, 13 Sep 2023 09:19:06 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 49B502176A;
 Wed, 13 Sep 2023 16:18:10 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 34CF927C8D;
 Wed, 13 Sep 2023 16:18:04 +0300 (MSK)
Received: (nullmailer pid 4073313 invoked by uid 1000);
 Wed, 13 Sep 2023 13:18:00 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng@tinylab.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.5 59/66] hw/char/riscv_htif: Fix the console syscall on
 big endian hosts
Date: Wed, 13 Sep 2023 16:17:40 +0300
Message-Id: <20230913131757.4073200-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.5-20230913160844@cover.tls.msk.ru>
References: <qemu-stable-8.0.5-20230913160844@cover.tls.msk.ru>
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

From: Thomas Huth <thuth@redhat.com>

Values that have been read via cpu_physical_memory_read() from the
guest's memory have to be swapped in case the host endianess differs
from the guest.

Fixes: a6e13e31d5 ("riscv_htif: Support console output via proxy syscall")
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bmeng@tinylab.org>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-Id: <20230721094720.902454-3-thuth@redhat.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 058096f1c55ab688db7e1d6814aaefc1bcd87f7a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: context fix in hw/char/riscv_htif.c for #include)

diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
index e6e0fa3015..198175e232 100644
--- a/hw/char/riscv_htif.c
+++ b/hw/char/riscv_htif.c
@@ -29,6 +29,7 @@
 #include "chardev/char-fe.h"
 #include "qemu/timer.h"
 #include "qemu/error-report.h"
+#include "exec/tswap.h"
 
 #define RISCV_DEBUG_HTIF 0
 #define HTIF_DEBUG(fmt, ...)                                                   \
@@ -167,11 +168,11 @@ static void htif_handle_tohost_write(HTIFState *s, uint64_t val_written)
             } else {
                 uint64_t syscall[8];
                 cpu_physical_memory_read(payload, syscall, sizeof(syscall));
-                if (syscall[0] == PK_SYS_WRITE &&
-                    syscall[1] == HTIF_DEV_CONSOLE &&
-                    syscall[3] == HTIF_CONSOLE_CMD_PUTC) {
+                if (tswap64(syscall[0]) == PK_SYS_WRITE &&
+                    tswap64(syscall[1]) == HTIF_DEV_CONSOLE &&
+                    tswap64(syscall[3]) == HTIF_CONSOLE_CMD_PUTC) {
                     uint8_t ch;
-                    cpu_physical_memory_read(syscall[2], &ch, 1);
+                    cpu_physical_memory_read(tswap64(syscall[2]), &ch, 1);
                     qemu_chr_fe_write(&s->chr, &ch, 1);
                     resp = 0x100 | (uint8_t)payload;
                 } else {
-- 
2.39.2


