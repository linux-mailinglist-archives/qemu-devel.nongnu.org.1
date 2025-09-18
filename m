Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 921F0B38835
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Aug 2025 19:06:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urJbB-0008F8-VE; Wed, 27 Aug 2025 13:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urJaN-0006kH-9Z; Wed, 27 Aug 2025 13:05:23 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urJaG-0007yP-Vd; Wed, 27 Aug 2025 13:05:23 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E4EC914C730;
 Wed, 27 Aug 2025 20:03:29 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 032322698F6;
 Wed, 27 Aug 2025 20:03:57 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.20 14/18] target/arm: Fix big-endian handling of NEON gdb
 remote debugging
Date: Wed, 27 Aug 2025 20:03:49 +0300
Message-ID: <20250827170356.2698446-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-7.2.20-20250827180339@cover.tls.msk.ru>
References: <qemu-stable-7.2.20-20250827180339@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>

In the code for allowing the gdbstub to set the value of an AArch64
FP/SIMD register, we weren't accounting for target_big_endian()
being true. This meant that for aarch64_be-linux-user we would
set the two halves of the FP register the wrong way around.
The much more common case of a little-endian guest is not affected;
nor are big-endian hosts.

Correct the handling of this case.

Cc: qemu-stable@nongnu.org
Signed-off-by: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Message-id: 20250722173736.2332529-2-vacha.bhavsar@oss.qualcomm.com
[PMM: added comment, expanded commit message, fixed missing space]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 35cca0f95ff5345f54c11d116efc8940a0dab8aa)
(Mjt: s/target_big_endian/target_words_bigendian/ due to missing
 v10.0.0-277-gb939b8e42a "exec: Rename target_words_bigendian() -> target_big_endian()")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 07a6746944..2dc058fcd6 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -99,8 +99,22 @@ int aarch64_fpu_gdb_set_reg(CPUARMState *env, uint8_t *buf, int reg)
         /* 128 bit FP register */
         {
             uint64_t *q = aa64_vfp_qreg(env, reg);
-            q[0] = ldq_le_p(buf);
-            q[1] = ldq_le_p(buf + 8);
+
+            /*
+             * On the wire these are target-endian 128 bit values.
+             * In the CPU state these are host-order uint64_t values
+             * with the least-significant one first. This means they're
+             * the other way around for target_words_bigendian() (which is
+             * only true for us for aarch64_be-linux-user).
+             */
+            if (target_words_bigendian()) {
+                q[1] = ldq_p(buf);
+                q[0] = ldq_p(buf + 8);
+            } else{
+                q[0] = ldq_p(buf);
+                q[1] = ldq_p(buf + 8);
+            }
+
             return 16;
         }
     case 32:
-- 
2.47.2


