Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0126373EA94
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 20:55:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDrKA-0007vy-Tp; Mon, 26 Jun 2023 14:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrK2-0007os-Mc; Mon, 26 Jun 2023 14:52:22 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrK1-0005Em-04; Mon, 26 Jun 2023 14:52:22 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2ADDCEF31;
 Mon, 26 Jun 2023 21:50:23 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id AFFBDF7C0;
 Mon, 26 Jun 2023 21:50:21 +0300 (MSK)
Received: (nullmailer pid 1574037 invoked by uid 1000);
 Mon, 26 Jun 2023 18:50:16 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.3 26/54] hw/mips/malta: Fix the malta machine on big
 endian hosts
Date: Mon, 26 Jun 2023 21:49:33 +0300
Message-Id: <20230626185002.1573836-26-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.3-20230626214235@cover.tls.msk.ru>
References: <qemu-stable-8.0.3-20230626214235@cover.tls.msk.ru>
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

From: Thomas Huth <thuth@redhat.com>

Booting a Linux kernel with the malta machine is currently broken
on big endian hosts. The cpu_to_gt32 macro wants to byteswap a value
for little endian targets only, but uses the wrong way to do this:
cpu_to_[lb]e32 works the other way round on big endian hosts! Fix
it by using the same ways on both, big and little endian hosts.

Fixes: 0c8427baf0 ("hw/mips/malta: Use bootloader helper to set BAR registers")
Cc: qemu-stable@nongnu.org
Message-Id: <20230330152613.232082-1-thuth@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit dc96009afd8cf2372fa1bbced0bcbcbb2c5d6f1b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index af9021316d..b26ed1fc9a 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -629,9 +629,9 @@ static void bl_setup_gt64120_jump_kernel(void **p, uint64_t run_addr,
 
     /* Bus endianess is always reversed */
 #if TARGET_BIG_ENDIAN
-#define cpu_to_gt32 cpu_to_le32
+#define cpu_to_gt32(x) (x)
 #else
-#define cpu_to_gt32 cpu_to_be32
+#define cpu_to_gt32(x) bswap32(x)
 #endif
 
     /* setup MEM-to-PCI0 mapping as done by YAMON */
-- 
2.39.2


