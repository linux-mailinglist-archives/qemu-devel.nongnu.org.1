Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D2672A99D
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 09:00:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7sYv-0002zN-Ap; Sat, 10 Jun 2023 02:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q7sYl-0002uK-GA; Sat, 10 Jun 2023 02:58:51 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q7sYj-000649-ST; Sat, 10 Jun 2023 02:58:51 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 122EDBE2F;
 Sat, 10 Jun 2023 09:58:02 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id A0E9EB29C;
 Sat, 10 Jun 2023 09:58:01 +0300 (MSK)
Received: (nullmailer pid 1107538 invoked by uid 1000);
 Sat, 10 Jun 2023 06:57:58 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 15/16] linux-user: elfload: s/min_mmap_addr/mmap_min_addr/
Date: Sat, 10 Jun 2023 09:57:53 +0300
Message-Id: <f101c25cd66dc4dea1135d2f1783a0786534923a.1686379708.git.mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1686379708.git.mjt@tls.msk.ru>
References: <cover.1686379708.git.mjt@tls.msk.ru>
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

From: Andrew Jeffery <andrew@aj.id.au>

As-is the error message can cause some confusion as the mentioned sysctl
attribute name is wrong:

https://www.kernel.org/doc/html/latest/admin-guide/sysctl/vm.html#mmap-min-addr

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 linux-user/elfload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index d80d68484b..76874833e3 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2798,7 +2798,7 @@ static void pgb_reserved_va(const char *image_name, abi_ulong guest_loaddr,
     if (addr == MAP_FAILED || addr != test) {
         error_report("Unable to reserve 0x%lx bytes of virtual address "
                      "space at %p (%s) for use as guest address space (check your "
-                     "virtual memory ulimit setting, min_mmap_addr or reserve less "
+                     "virtual memory ulimit setting, mmap_min_addr or reserve less "
                      "using -R option)", reserved_va + 1, test, strerror(errno));
         exit(EXIT_FAILURE);
     }
-- 
2.39.2


