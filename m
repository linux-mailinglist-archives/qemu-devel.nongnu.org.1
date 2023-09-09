Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 651F9799894
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 15:19:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qexhl-0000L9-3Z; Sat, 09 Sep 2023 09:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexhW-0000GD-RI; Sat, 09 Sep 2023 09:08:39 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexhU-00044Z-4B; Sat, 09 Sep 2023 09:08:38 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6984B205F1;
 Sat,  9 Sep 2023 16:06:11 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 3585526E44;
 Sat,  9 Sep 2023 16:05:20 +0300 (MSK)
Received: (nullmailer pid 354369 invoked by uid 1000);
 Sat, 09 Sep 2023 13:05:12 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.6 36/37] hw/net/vmxnet3: Fix guest-triggerable assert()
Date: Sat,  9 Sep 2023 16:05:06 +0300
Message-Id: <20230909130511.354171-36-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.6-20230909160328@cover.tls.msk.ru>
References: <qemu-stable-7.2.6-20230909160328@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Thomas Huth <thuth@redhat.com>

The assert() that checks for valid MTU sizes can be triggered by
the guest (e.g. with the reproducer code from the bug ticket
https://gitlab.com/qemu-project/qemu/-/issues/517 ). Let's avoid
this problem by simply logging the error and refusing to activate
the device instead.

Fixes: d05dcd94ae ("net: vmxnet3: validate configuration values during activate")
Signed-off-by: Thomas Huth <thuth@redhat.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
[Mjt: change format specifier from %d to %u for uint32_t argument]
(cherry picked from commit 90a0778421acdf4ca903be64c8ed19378183c944)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 56559cda24..399fc14129 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -1441,7 +1441,10 @@ static void vmxnet3_activate_device(VMXNET3State *s)
     vmxnet3_setup_rx_filtering(s);
     /* Cache fields from shared memory */
     s->mtu = VMXNET3_READ_DRV_SHARED32(d, s->drv_shmem, devRead.misc.mtu);
-    assert(VMXNET3_MIN_MTU <= s->mtu && s->mtu <= VMXNET3_MAX_MTU);
+    if (s->mtu < VMXNET3_MIN_MTU || s->mtu > VMXNET3_MAX_MTU) {
+        qemu_log_mask(LOG_GUEST_ERROR, "vmxnet3: Bad MTU size: %u\n", s->mtu);
+        return;
+    }
     VMW_CFPRN("MTU is %u", s->mtu);
 
     s->max_rx_frags =
-- 
2.39.2


