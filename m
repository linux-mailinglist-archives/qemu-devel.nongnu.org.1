Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4648AB47989
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Sep 2025 10:14:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uv9Rn-0000yM-Qw; Sun, 07 Sep 2025 03:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uv9Rc-0000lQ-FG; Sun, 07 Sep 2025 03:04:12 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uv9RO-0004UM-Mk; Sun, 07 Sep 2025 03:04:12 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 27CAB151059;
 Sun, 07 Sep 2025 10:02:05 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1ECD12793C6;
 Sun,  7 Sep 2025 10:02:06 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.4 75/81] elf: Add EF_MIPS_ARCH_ASE definitions
Date: Sun,  7 Sep 2025 10:01:54 +0300
Message-ID: <20250907070205.135289-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.4-20250907000448@cover.tls.msk.ru>
References: <qemu-stable-10.0.4-20250907000448@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Include MIPS ASE ELF definitions from binutils:
https://sourceware.org/git/?p=binutils-gdb.git;a=blob;f=include/elf/mips.h;h=4fc190f404d828ded84e621bfcece5fa9f9c23c8;hb=HEAD#l210

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250814070650.78657-2-philmd@linaro.org>
(cherry picked from commit 14ab44b96d5bf761af81cc723314ef5ecf73ed17)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/include/elf.h b/include/elf.h
index e7259ec366..bbfac055de 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -56,6 +56,13 @@ typedef int64_t  Elf64_Sxword;
 #define EF_MIPS_ARCH_32R6     0x90000000      /* MIPS32r6 code.  */
 #define EF_MIPS_ARCH_64R6     0xa0000000      /* MIPS64r6 code.  */
 
+/* MIPS Architectural Extensions. */
+#define EF_MIPS_ARCH_ASE      0x0f000000
+
+#define EF_MIPS_ARCH_ASE_MICROMIPS 0x02000000
+#define EF_MIPS_ARCH_ASE_M16  0x04000000
+#define EF_MIPS_ARCH_ASE_MDMX 0x08000000
+
 /* The ABI of a file. */
 #define EF_MIPS_ABI_O32       0x00001000      /* O32 ABI.  */
 #define EF_MIPS_ABI_O64       0x00002000      /* O32 extended for 64 bit.  */
-- 
2.47.3


