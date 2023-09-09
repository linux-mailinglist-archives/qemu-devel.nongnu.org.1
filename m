Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A79B5799860
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 15:10:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qexeY-0006cc-SN; Sat, 09 Sep 2023 09:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexeW-0006cB-Bx; Sat, 09 Sep 2023 09:05:32 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexeT-0003XE-QU; Sat, 09 Sep 2023 09:05:32 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9382F205D4;
 Sat,  9 Sep 2023 16:06:04 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 5F0CE26E27;
 Sat,  9 Sep 2023 16:05:13 +0300 (MSK)
Received: (nullmailer pid 354281 invoked by uid 1000);
 Sat, 09 Sep 2023 13:05:11 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Nathan Egge <negge@xiph.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.6 07/37] linux-user/elfload: Set V in ELF_HWCAP for RISC-V
Date: Sat,  9 Sep 2023 16:04:37 +0300
Message-Id: <20230909130511.354171-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.6-20230909160328@cover.tls.msk.ru>
References: <qemu-stable-7.2.6-20230909160328@cover.tls.msk.ru>
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

From: Nathan Egge <negge@xiph.org>

Set V bit for hwcap if misa is set.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1793
Signed-off-by: Nathan Egge <negge@xiph.org>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Tested-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-Id: <20230803131424.40744-1-negge@xiph.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 4333f0924c2f2ca8efaebaed8c24f55f77d8b013)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 20894b633f..c2c095d383 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1664,7 +1664,8 @@ static uint32_t get_elf_hwcap(void)
 #define MISA_BIT(EXT) (1 << (EXT - 'A'))
     RISCVCPU *cpu = RISCV_CPU(thread_cpu);
     uint32_t mask = MISA_BIT('I') | MISA_BIT('M') | MISA_BIT('A')
-                    | MISA_BIT('F') | MISA_BIT('D') | MISA_BIT('C');
+                    | MISA_BIT('F') | MISA_BIT('D') | MISA_BIT('C')
+                    | MISA_BIT('V');
 
     return cpu->env.misa_ext & mask;
 #undef MISA_BIT
-- 
2.39.2


