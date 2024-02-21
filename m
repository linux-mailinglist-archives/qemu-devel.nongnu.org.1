Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0648A85E1D7
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Feb 2024 16:49:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoTv-0007Zg-8Q; Wed, 21 Feb 2024 10:26:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rcoMB-0000wD-8u; Wed, 21 Feb 2024 10:18:03 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rchvO-00034e-5k; Wed, 21 Feb 2024 03:25:56 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7261A4F3F2;
 Wed, 21 Feb 2024 11:21:23 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 3E82B860D1;
 Wed, 21 Feb 2024 11:21:02 +0300 (MSK)
Received: (nullmailer pid 2142146 invoked by uid 1000);
 Wed, 21 Feb 2024 08:20:58 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Xiaoyao Li <xiaoyao.li@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.2 52/60] i386/cpuid: Move leaf 7 to correct group
Date: Wed, 21 Feb 2024 11:20:40 +0300
Message-Id: <20240221082058.2141850-52-mjt@tls.msk.ru>
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

CPUID leaf 7 was grouped together with SGX leaf 0x12 by commit
b9edbadefb9e ("i386: Propagate SGX CPUID sub-leafs to KVM") by mistake.

SGX leaf 0x12 has its specific logic to check if subleaf (starting from 2)
is valid or not by checking the bit 0:3 of corresponding EAX is 1 or
not.

Leaf 7 follows the logic that EAX of subleaf 0 enumerates the maximum
valid subleaf.

Fixes: b9edbadefb9e ("i386: Propagate SGX CPUID sub-leafs to KVM")
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <20240125024016.2521244-4-xiaoyao.li@intel.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 0729857c707535847d7fe31d3d91eb8b2a118e3c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index e68eb8f5e6..a0bc9ea7b1 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1955,7 +1955,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
                 c = &cpuid_data.entries[cpuid_i++];
             }
             break;
-        case 0x7:
         case 0x12:
             for (j = 0; ; j++) {
                 c->function = i;
@@ -1975,6 +1974,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
                 c = &cpuid_data.entries[cpuid_i++];
             }
             break;
+        case 0x7:
         case 0x14:
         case 0x1d:
         case 0x1e: {
-- 
2.39.2


