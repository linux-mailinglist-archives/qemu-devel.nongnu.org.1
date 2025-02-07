Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1D8A2C205
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Feb 2025 12:56:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgMxN-0002nK-J9; Fri, 07 Feb 2025 06:55:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tgMx8-0002bB-Kx; Fri, 07 Feb 2025 06:55:22 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tgMx2-0005XF-J5; Fri, 07 Feb 2025 06:55:21 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 06A6FE73DF;
 Fri, 07 Feb 2025 14:54:30 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8E9491B0B58;
 Fri,  7 Feb 2025 14:55:11 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 80FF352D9B; Fri, 07 Feb 2025 14:55:11 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Berthold Gunreben <azouhr@opensuse.org>,
 Sarah Kriesch <ada.lovelace@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.3 62/65] target/s390x: Fix MVC not always invalidating
 translation blocks
Date: Fri,  7 Feb 2025 14:54:55 +0300
Message-Id: <20250207115501.2278106-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.3-20250207102547@cover.tls.msk.ru>
References: <qemu-stable-9.1.3-20250207102547@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Node.js crashes in qemu-system-s390x with random SIGSEGVs / SIGILLs.

The v8 JIT used by Node.js can garbage collect and overwrite unused
code. Overwriting is performed by WritableJitAllocation::CopyCode(),
which ultimately calls memcpy(). For certain sizes, memcpy() uses the
MVC instruction.

QEMU implements MVC and other similar instructions using helpers. While
TCG store ops invalidate affected translation blocks automatically,
helpers must do this manually by calling probe_access_flags(). The MVC
helper does this using the access_prepare() -> access_prepare_nf() ->
s390_probe_access() -> probe_access_flags() call chain.

At the last step of this chain, the store size is replaced with 0. This
causes the probe_access_flags() -> notdirty_write() ->
tb_invalidate_phys_range_fast() chain to miss some translation blocks.

When this happens, QEMU executes a mix of old and new code. This
quickly leads to either a SIGSEGV or a SIGILL in case the old code
ends in the middle of a new instruction.

Fix by passing the true size.

Reported-by: Berthold Gunreben <azouhr@opensuse.org>
Cc: Sarah Kriesch <ada.lovelace@gmx.de>
Cc: qemu-stable@nongnu.org
Closes: https://bugzilla.opensuse.org/show_bug.cgi?id=1235709
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Fixes: e2faabee78ff ("accel/tcg: Forward probe size on to notdirty_write")
Message-ID: <20250128001338.11474-1-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit e43ced8be18dda77c229ab09f85136a4d600d40d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 0e12dae2aa..29ee5a8a07 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -146,7 +146,7 @@ static inline int s390_probe_access(CPUArchState *env, target_ulong addr,
                                     int mmu_idx, bool nonfault,
                                     void **phost, uintptr_t ra)
 {
-    int flags = probe_access_flags(env, addr, 0, access_type, mmu_idx,
+    int flags = probe_access_flags(env, addr, size, access_type, mmu_idx,
                                    nonfault, phost, ra);
 
     if (unlikely(flags & TLB_INVALID_MASK)) {
-- 
2.39.5


