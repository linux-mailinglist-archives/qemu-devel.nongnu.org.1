Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4A77A7E71
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 14:17:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiw7p-00029S-2f; Wed, 20 Sep 2023 08:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qiw7n-00028c-0y; Wed, 20 Sep 2023 08:16:11 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qiw7f-0005Fp-TM; Wed, 20 Sep 2023 08:16:10 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B9D2B239FB;
 Wed, 20 Sep 2023 15:16:13 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 11C0B296F2;
 Wed, 20 Sep 2023 15:15:54 +0300 (MSK)
Received: (nullmailer pid 105877 invoked by uid 1000);
 Wed, 20 Sep 2023 12:15:53 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Colton Lewis <coltonlewis@google.com>,
 Andrew Jones <andrew.jones@linux.dev>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.6 53/63] arm64: Restore trapless ptimer access
Date: Wed, 20 Sep 2023 15:15:38 +0300
Message-Id: <20230920121553.105832-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.6-20230920151401@cover.tls.msk.ru>
References: <qemu-stable-7.2.6-20230920151401@cover.tls.msk.ru>
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

From: Colton Lewis <coltonlewis@google.com>

Due to recent KVM changes, QEMU is setting a ptimer offset resulting
in unintended trap and emulate access and a consequent performance
hit. Filter out the PTIMER_CNT register to restore trapless ptimer
access.

Quoting Andrew Jones:

Simply reading the CNT register and writing back the same value is
enough to set an offset, since the timer will have certainly moved
past whatever value was read by the time it's written.  QEMU
frequently saves and restores all registers in the get-reg-list array,
unless they've been explicitly filtered out (with Linux commit
680232a94c12, KVM_REG_ARM_PTIMER_CNT is now in the array). So, to
restore trapless ptimer accesses, we need a QEMU patch to filter out
the register.

See
https://lore.kernel.org/kvmarm/gsntttsonus5.fsf@coltonlewis-kvm.c.googlers.com/T/#m0770023762a821db2a3f0dd0a7dc6aa54e0d0da9
for additional context.

Cc: qemu-stable@nongnu.org
Signed-off-by: Andrew Jones <andrew.jones@linux.dev>
Signed-off-by: Colton Lewis <coltonlewis@google.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Colton Lewis <coltonlewis@google.com>
Message-id: 20230831190052.129045-1-coltonlewis@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 682814e2a3c883b27f24b9e7cab47313c49acbd4)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 810db33ccb..ed85bcfb5c 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -950,6 +950,7 @@ typedef struct CPRegStateLevel {
  */
 static const CPRegStateLevel non_runtime_cpregs[] = {
     { KVM_REG_ARM_TIMER_CNT, KVM_PUT_FULL_STATE },
+    { KVM_REG_ARM_PTIMER_CNT, KVM_PUT_FULL_STATE },
 };
 
 int kvm_arm_cpreg_level(uint64_t regidx)
-- 
2.39.2


