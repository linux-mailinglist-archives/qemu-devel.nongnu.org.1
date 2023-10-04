Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0427B7986
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:05:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnwsJ-00012e-1x; Wed, 04 Oct 2023 04:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnwrG-00072D-4G; Wed, 04 Oct 2023 04:03:51 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnwrD-0008Ll-Ct; Wed, 04 Oct 2023 04:03:49 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3C4B82759D;
 Wed,  4 Oct 2023 11:02:26 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 988EF2CBD9;
 Wed,  4 Oct 2023 11:02:25 +0300 (MSK)
Received: (nullmailer pid 2702807 invoked by uid 1000);
 Wed, 04 Oct 2023 08:02:21 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fabian Vogt <fvogt@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.2 19/45] hw/arm/boot: Set SCR_EL3.FGTEn when booting
 kernel
Date: Wed,  4 Oct 2023 11:01:40 +0300
Message-Id: <20231004080221.2702636-19-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.2-20231003193203@cover.tls.msk.ru>
References: <qemu-stable-8.1.2-20231003193203@cover.tls.msk.ru>
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

From: Fabian Vogt <fvogt@suse.de>

Just like d7ef5e16a17c sets SCR_EL3.HXEn for FEAT_HCX, this commit
handles SCR_EL3.FGTEn for FEAT_FGT:

When we direct boot a kernel on a CPU which emulates EL3, we need to
set up the EL3 system registers as the Linux kernel documentation
specifies:
    https://www.kernel.org/doc/Documentation/arm64/booting.rst

> For CPUs with the Fine Grained Traps (FEAT_FGT) extension present:
> - If EL3 is present and the kernel is entered at EL2:
>   - SCR_EL3.FGTEn (bit 27) must be initialised to 0b1.

Cc: qemu-stable@nongnu.org
Signed-off-by: Fabian Vogt <fvogt@suse.de>
Message-id: 4831384.GXAFRqVoOG@linux-e202.suse.de
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 32b214384e1e1472ddfa875196c57f6620172301)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 720f22531a..24fa169060 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -761,6 +761,10 @@ static void do_cpu_reset(void *opaque)
                     if (cpu_isar_feature(aa64_hcx, cpu)) {
                         env->cp15.scr_el3 |= SCR_HXEN;
                     }
+                    if (cpu_isar_feature(aa64_fgt, cpu)) {
+                        env->cp15.scr_el3 |= SCR_FGTEN;
+                    }
+
                     /* AArch64 kernels never boot in secure mode */
                     assert(!info->secure_boot);
                     /* This hook is only supported for AArch32 currently:
-- 
2.39.2


