Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAAE85D273
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Feb 2024 09:23:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rchrS-0001ZN-0n; Wed, 21 Feb 2024 03:21:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rchrJ-0001To-As; Wed, 21 Feb 2024 03:21:41 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rchrH-0002BN-K0; Wed, 21 Feb 2024 03:21:41 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 864B74F3C8;
 Wed, 21 Feb 2024 11:21:20 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 51C58860A7;
 Wed, 21 Feb 2024 11:20:59 +0300 (MSK)
Received: (nullmailer pid 2142016 invoked by uid 1000);
 Wed, 21 Feb 2024 08:20:58 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.2 10/60] target/arm: Reinstate "vfp" property on AArch32
 CPUs
Date: Wed, 21 Feb 2024 11:19:58 +0300
Message-Id: <20240221082058.2141850-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.2-20240221110049@cover.tls.msk.ru>
References: <qemu-stable-8.2.2-20240221110049@cover.tls.msk.ru>
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

From: Peter Maydell <peter.maydell@linaro.org>

In commit 4315f7c614743 we restructured the logic for creating the
VFP related properties to avoid testing the aa32_simd_r32 feature on
AArch64 CPUs.  However in the process we accidentally stopped
exposing the "vfp" QOM property on AArch32 TCG CPUs.

This mostly hasn't had any ill effects because not many people want
to disable VFP, but it wasn't intentional.  Reinstate the property.

Cc: qemu-stable@nongnu.org
Fixes: 4315f7c614743 ("target/arm: Restructure has_vfp_d32 test")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2098
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240126193432.2210558-1-peter.maydell@linaro.org
(cherry picked from commit 185e3fdf8d106cb2f7d234d5e6453939c66db2a9)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index efb22a87f9..5d9bca5b8d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1615,6 +1615,10 @@ void arm_cpu_post_init(Object *obj)
         }
     } else if (cpu_isar_feature(aa32_vfp, cpu)) {
         cpu->has_vfp = true;
+        if (tcg_enabled() || qtest_enabled()) {
+            qdev_property_add_static(DEVICE(obj),
+                                     &arm_cpu_has_vfp_property);
+        }
         if (cpu_isar_feature(aa32_simd_r32, cpu)) {
             cpu->has_vfp_d32 = true;
             /*
-- 
2.39.2


