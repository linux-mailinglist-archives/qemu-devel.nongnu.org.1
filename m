Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F14CB4774F
	for <lists+qemu-devel@lfdr.de>; Sat,  6 Sep 2025 23:12:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uv02L-0003D6-Pt; Sat, 06 Sep 2025 17:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uv02G-000388-MS; Sat, 06 Sep 2025 17:01:24 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uv028-0005kB-Bq; Sat, 06 Sep 2025 17:01:24 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D469C150F7E;
 Sun, 07 Sep 2025 00:00:54 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 99EDB278689;
 Sun,  7 Sep 2025 00:00:56 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Zero Tang <zero.tangptr@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.20 19/34] i386/tcg/svm: fix incorrect canonicalization
Date: Sun,  7 Sep 2025 00:00:39 +0300
Message-ID: <20250906210056.127031-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-7.2.20-20250906235950@cover.tls.msk.ru>
References: <qemu-stable-7.2.20-20250906235950@cover.tls.msk.ru>
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

From: Zero Tang <zero.tangptr@gmail.com>

For all 32-bit systems and 64-bit Windows systems, "long" is 4 bytes long.
Due to using "long" for a linear address, svm_canonicalization would
set all high bits to 1 when (assuming 48-bit linear address) the segment
base is bigger than 0x7FFF.

This fixes booting guests under TCG when the guest IDT and GDT bases are
above 0x7FFF, thereby resulting in incorrect bases. When an interrupt
arrives, it would trigger a #PF exception; the #PF would trigger again,
resulting in a #DF exception; the #PF would trigger for the third time,
resulting in triple-fault, and eventually causes a shutdown VM-Exit to
the hypervisor right after guest boot.

Cc: qemu-stable@nongnu.org
Signed-off-by: Zero Tang <zero.tangptr@gmail.com>
(cherry picked from commit c12cbaa007c9da97a11e74119ea3aed9fcc3ac4c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/sysemu/svm_helper.c b/target/i386/tcg/sysemu/svm_helper.c
index 744aed4b31..75a2b1e04b 100644
--- a/target/i386/tcg/sysemu/svm_helper.c
+++ b/target/i386/tcg/sysemu/svm_helper.c
@@ -49,7 +49,7 @@ static void svm_save_seg(CPUX86State *env, int mmu_idx, hwaddr addr,
 static inline void svm_canonicalization(CPUX86State *env, target_ulong *seg_base)
 {
     uint16_t shift_amt = 64 - cpu_x86_virtual_addr_width(env);
-    *seg_base = ((((long) *seg_base) << shift_amt) >> shift_amt);
+    *seg_base = (((int64_t) *seg_base) << shift_amt) >> shift_amt;
 }
 
 static void svm_load_seg(CPUX86State *env, int mmu_idx, hwaddr addr,
-- 
2.47.3


