Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AB679E922
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 15:23:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgPlq-0007hS-So; Wed, 13 Sep 2023 09:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qgPlo-0007gd-GH; Wed, 13 Sep 2023 09:19:04 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qgPlm-0003gf-1L; Wed, 13 Sep 2023 09:19:04 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2E45921769;
 Wed, 13 Sep 2023 16:18:10 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id BAD6B27C8C;
 Wed, 13 Sep 2023 16:18:03 +0300 (MSK)
Received: (nullmailer pid 4073310 invoked by uid 1000);
 Wed, 13 Sep 2023 13:18:00 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng@tinylab.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.5 58/66] hw/char/riscv_htif: Fix printing of console
 characters on big endian hosts
Date: Wed, 13 Sep 2023 16:17:39 +0300
Message-Id: <20230913131757.4073200-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.5-20230913160844@cover.tls.msk.ru>
References: <qemu-stable-8.0.5-20230913160844@cover.tls.msk.ru>
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

The character that should be printed is stored in the 64 bit "payload"
variable. The code currently tries to print it by taking the address
of the variable and passing this pointer to qemu_chr_fe_write(). However,
this only works on little endian hosts where the least significant bits
are stored on the lowest address. To do this in a portable way, we have
to store the value in an uint8_t variable instead.

Fixes: 5033606780 ("RISC-V HTIF Console")
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bmeng@tinylab.org>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230721094720.902454-2-thuth@redhat.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit c255946e3df4d9660e4f468a456633c24393d468)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
index 098de50e35..e6e0fa3015 100644
--- a/hw/char/riscv_htif.c
+++ b/hw/char/riscv_htif.c
@@ -190,7 +190,8 @@ static void htif_handle_tohost_write(HTIFState *s, uint64_t val_written)
             s->tohost = 0; /* clear to indicate we read */
             return;
         } else if (cmd == HTIF_CONSOLE_CMD_PUTC) {
-            qemu_chr_fe_write(&s->chr, (uint8_t *)&payload, 1);
+            uint8_t ch = (uint8_t)payload;
+            qemu_chr_fe_write(&s->chr, &ch, 1);
             resp = 0x100 | (uint8_t)payload;
         } else {
             qemu_log("HTIF device %d: unknown command\n", device);
-- 
2.39.2


