Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CCB80EB5A
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 13:20:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD1jT-0005H6-7H; Tue, 12 Dec 2023 07:19:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rD1jQ-0005GV-Kg; Tue, 12 Dec 2023 07:19:24 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rD1jP-0000Mz-2S; Tue, 12 Dec 2023 07:19:24 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 641433AEFD;
 Tue, 12 Dec 2023 15:18:49 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 2919C3B94B;
 Tue, 12 Dec 2023 15:18:32 +0300 (MSK)
Received: (nullmailer pid 1003425 invoked by uid 1000);
 Tue, 12 Dec 2023 12:18:31 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Palmer Dabbelt <palmer@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.4 09/31] linux-user/riscv: Add Zicboz block size to
 hwprobe
Date: Tue, 12 Dec 2023 15:17:57 +0300
Message-Id: <20231212121831.1003318-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.4-20231211211211@cover.tls.msk.ru>
References: <qemu-stable-8.1.4-20231211211211@cover.tls.msk.ru>
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

From: Palmer Dabbelt <palmer@rivosinc.com>

Support for probing the Zicboz block size landed in Linux 6.6, which was
released a few weeks ago.  This provides the user-configured block size
when Zicboz is enabled.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20231110173716.24423-1-palmer@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 301c65f49f9602f39b9f3ce0ad9ff70d4bda7226)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: fixup linux-user/syscall.c to before v8.1.0-2602-ge57039ddab
 "target/riscv: rename ext_icboz to ext_zicboz")

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9353268cc1..bd0c99859d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9058,6 +9058,8 @@ static int do_getdents64(abi_long dirfd, abi_long arg2, abi_long count)
 #define     RISCV_HWPROBE_MISALIGNED_UNSUPPORTED (4 << 0)
 #define     RISCV_HWPROBE_MISALIGNED_MASK        (7 << 0)
 
+#define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE 6
+
 struct riscv_hwprobe {
     abi_llong  key;
     abi_ullong value;
@@ -9102,6 +9104,10 @@ static void risc_hwprobe_fill_pairs(CPURISCVState *env,
         case RISCV_HWPROBE_KEY_CPUPERF_0:
             __put_user(RISCV_HWPROBE_MISALIGNED_FAST, &pair->value);
             break;
+        case RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE:
+            value = cfg->ext_icboz ? cfg->cboz_blocksize : 0;
+            __put_user(value, &pair->value);
+            break;
         default:
             __put_user(-1, &pair->key);
             break;
-- 
2.39.2


