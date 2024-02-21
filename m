Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C6A85EB55
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Feb 2024 22:51:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcuTK-0001bi-6L; Wed, 21 Feb 2024 16:49:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rcuTD-0001NF-K6; Wed, 21 Feb 2024 16:49:40 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rcuTA-0007c6-Ez; Wed, 21 Feb 2024 16:49:38 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A7E4A4F875;
 Thu, 22 Feb 2024 00:47:47 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 50D9A869F6;
 Thu, 22 Feb 2024 00:47:25 +0300 (MSK)
Received: (nullmailer pid 2339899 invoked by uid 1000);
 Wed, 21 Feb 2024 21:47:23 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Xiaoyao Li <xiaoyao.li@intel.com>,
 Yang Weijiang <weijiang.yang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.10 25/33] i386/cpu: Mask with XCR0/XSS mask for
 FEAT_XSAVE_XCR0_HI and FEAT_XSAVE_XSS_HI leafs
Date: Thu, 22 Feb 2024 00:47:08 +0300
Message-Id: <20240221214723.2339742-25-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.10-20240221121815@cover.tls.msk.ru>
References: <qemu-stable-7.2.10-20240221121815@cover.tls.msk.ru>
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

The value of FEAT_XSAVE_XCR0_HI leaf and FEAT_XSAVE_XSS_HI leaf also
need to be masked by XCR0 and XSS mask respectively, to make it
logically correct.

Fixes: 301e90675c3f ("target/i386: Enable support for XSAVES based features")
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Yang Weijiang <weijiang.yang@intel.com>
Message-ID: <20240115091325.1904229-3-xiaoyao.li@intel.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit a11a365159b944e05be76f3ec3b98c8b38cb70fd)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 952fa5780f..52a3020032 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6134,9 +6134,9 @@ static void x86_cpu_enable_xsave_components(X86CPU *cpu)
     }
 
     env->features[FEAT_XSAVE_XCR0_LO] = mask & CPUID_XSTATE_XCR0_MASK;
-    env->features[FEAT_XSAVE_XCR0_HI] = mask >> 32;
+    env->features[FEAT_XSAVE_XCR0_HI] = (mask & CPUID_XSTATE_XCR0_MASK) >> 32;
     env->features[FEAT_XSAVE_XSS_LO] = mask & CPUID_XSTATE_XSS_MASK;
-    env->features[FEAT_XSAVE_XSS_HI] = mask >> 32;
+    env->features[FEAT_XSAVE_XSS_HI] = (mask & CPUID_XSTATE_XSS_MASK) >> 32;
 }
 
 /***** Steps involved on loading and filtering CPUID data
-- 
2.39.2


