Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7ACC7E6BEF
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 15:02:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15be-0000vM-RT; Thu, 09 Nov 2023 09:02:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15a3-0005ef-Mz; Thu, 09 Nov 2023 09:00:28 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15Zl-0005Wu-Ir; Thu, 09 Nov 2023 09:00:19 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E78BF31BC1;
 Thu,  9 Nov 2023 16:59:41 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id F2E77344FA;
 Thu,  9 Nov 2023 16:59:33 +0300 (MSK)
Received: (nullmailer pid 1462788 invoked by uid 1000);
 Thu, 09 Nov 2023 13:59:33 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.7 11/62] target/arm: Don't skip MTE checks for LDRT/STRT
 at EL0
Date: Thu,  9 Nov 2023 16:58:39 +0300
Message-Id: <20231109135933.1462615-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.7-20231109164316@cover.tls.msk.ru>
References: <qemu-stable-7.2.7-20231109164316@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

The LDRT/STRT "unprivileged load/store" instructions behave like
normal ones if executed at EL0. We handle this correctly for
the load/store semantics, but get the MTE checking wrong.

We always look at s->mte_active[is_unpriv] to see whether we should
be doing MTE checks, but in hflags.c when we set the TB flags that
will be used to fill the mte_active[] array we only set the
MTE0_ACTIVE bit if UNPRIV is true (i.e.  we are not at EL0).

This means that a LDRT at EL0 will see s->mte_active[1] as 0,
and will not do MTE checks even when MTE is enabled.

To avoid the translate-time code having to do an explicit check on
s->unpriv to see if it is OK to index into the mte_active[] array,
duplicate MTE_ACTIVE into MTE0_ACTIVE when UNPRIV is false.

(This isn't a very serious bug because generally nobody executes
LDRT/STRT at EL0, because they have no use there.)

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230912140434.1333369-2-peter.maydell@linaro.org
(cherry picked from commit 903dbefc2b6918c10d12d9aafa0168cee8d287c7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: before v7.2.0-1636-g671efad16a this code was in target/arm/helper.c)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 22bc935242..a52ef3dfe4 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11301,6 +11301,15 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
                 && !(env->pstate & PSTATE_TCO)
                 && (sctlr & (el == 0 ? SCTLR_TCF0 : SCTLR_TCF))) {
                 DP_TBFLAG_A64(flags, MTE_ACTIVE, 1);
+                if (!EX_TBFLAG_A64(flags, UNPRIV)) {
+                    /*
+                     * In non-unpriv contexts (eg EL0), unpriv load/stores
+                     * act like normal ones; duplicate the MTE info to
+                     * avoid translate-a64.c having to check UNPRIV to see
+                     * whether it is OK to index into MTE_ACTIVE[].
+                     */
+                    DP_TBFLAG_A64(flags, MTE0_ACTIVE, 1);
+                }
             }
         }
         /* And again for unprivileged accesses, if required.  */
-- 
2.39.2


