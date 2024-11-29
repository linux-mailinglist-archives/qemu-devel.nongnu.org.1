Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 090189D1919
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Nov 2024 20:38:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD7XA-0006bA-Pk; Mon, 18 Nov 2024 14:35:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tD7X7-0006Zi-K8; Mon, 18 Nov 2024 14:35:37 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tD7X5-0002gq-Q1; Mon, 18 Nov 2024 14:35:37 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 872DDA54E1;
 Mon, 18 Nov 2024 22:35:17 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 06D1017359F;
 Mon, 18 Nov 2024 22:35:21 +0300 (MSK)
Received: (nullmailer pid 2312682 invoked by uid 1000);
 Mon, 18 Nov 2024 19:35:20 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.8 53/61] linux-user: Tolerate CONFIG_LSM_MMAP_MIN_ADDR
Date: Mon, 18 Nov 2024 22:35:08 +0300
Message-Id: <20241118193520.2312620-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-8.2.8-20241118211929@cover.tls.msk.ru>
References: <qemu-stable-8.2.8-20241118211929@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Running qemu-i386 on a system running with SELinux in enforcing mode
(more precisely: s390x trixie container on Fedora 40) fails with:

    qemu-i386: tests/tcg/i386-linux-user/sigreturn-sigmask: Unable to find a guest_base to satisfy all guest address mapping requirements
      00000000-ffffffff

The reason is that main() determines mmap_min_addr from
/proc/sys/vm/mmap_min_addr, but SELinux additionally defines
CONFIG_LSM_MMAP_MIN_ADDR, which is normally larger: 32K or 64K, but,
in general, can be anything. There is no portable way to query its
value: /boot/config, /proc/config and /proc/config.gz are distro- and
environment-specific.

Once the identity map fails, the magnitude of guest_base does not
matter, so fix by starting the search from 1M or 1G.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2598
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20241023002558.34589-1-iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit fb7f3572b111ffb6c2dd2c7f6c5b4dc57dd8a3f5)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index d11842cb94..a79f915c37 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2980,7 +2980,7 @@ static uintptr_t pgb_try_itree(const PGBAddrs *ga, uintptr_t base,
 static uintptr_t pgb_find_itree(const PGBAddrs *ga, IntervalTreeRoot *root,
                                 uintptr_t align, uintptr_t brk)
 {
-    uintptr_t last = mmap_min_addr;
+    uintptr_t last = sizeof(uintptr_t) == 4 ? MiB : GiB;
     uintptr_t base, skip;
 
     while (true) {
-- 
2.39.5


