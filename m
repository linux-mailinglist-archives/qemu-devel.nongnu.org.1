Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC7DB479D5
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Sep 2025 10:43:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uv9Rs-0001Gs-UB; Sun, 07 Sep 2025 03:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uv9Rl-0000yS-Gq; Sun, 07 Sep 2025 03:04:21 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uv9Rd-0004VL-LQ; Sun, 07 Sep 2025 03:04:19 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 424C715105A;
 Sun, 07 Sep 2025 10:02:05 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 388142793C7;
 Sun,  7 Sep 2025 10:02:06 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Justin Applegate <justink.applegate@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.4 76/81] linux-user/mips: Select 74Kf CPU to run MIPS16e
 binaries
Date: Sun,  7 Sep 2025 10:01:55 +0300
Message-ID: <20250907070205.135289-18-mjt@tls.msk.ru>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The 74Kf is our latest CPU supporting MIPS16e ASE.

Note, currently QEMU doesn't have 64-bit CPU supporting MIPS16e ASE.

Cc: qemu-stable@nongnu.org
Fixes: 6ea219d0196..d19954f46df ("target-mips: MIPS16 support")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3054
Reported-by: Justin Applegate <justink.applegate@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250814070650.78657-3-philmd@linaro.org>
(cherry picked from commit 7a09b3cc70ab6d717b18dec5c5995f7a06af4593)
(Mjt: in 10.1 and before the code is in linux-user/mips/target_elf.h)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/mips/target_elf.h b/linux-user/mips/target_elf.h
index 71a32315a8..cd8622ce28 100644
--- a/linux-user/mips/target_elf.h
+++ b/linux-user/mips/target_elf.h
@@ -12,6 +12,9 @@ static inline const char *cpu_get_model(uint32_t eflags)
     if ((eflags & EF_MIPS_ARCH) == EF_MIPS_ARCH_32R6) {
         return "mips32r6-generic";
     }
+    if ((eflags & EF_MIPS_ARCH_ASE) == EF_MIPS_ARCH_ASE_M16) {
+        return "74Kf";
+    }
     if (eflags & EF_MIPS_NAN2008) {
         return "P5600";
     }
-- 
2.47.3


