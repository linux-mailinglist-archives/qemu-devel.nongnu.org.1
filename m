Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B26FC799890
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 15:18:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qexeV-0006a7-Dg; Sat, 09 Sep 2023 09:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexeT-0006Zn-Ao; Sat, 09 Sep 2023 09:05:29 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexeP-0003UQ-TK; Sat, 09 Sep 2023 09:05:28 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1DB0E205D2;
 Sat,  9 Sep 2023 16:06:04 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id D762926E25;
 Sat,  9 Sep 2023 16:05:12 +0300 (MSK)
Received: (nullmailer pid 354275 invoked by uid 1000);
 Sat, 09 Sep 2023 13:05:11 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Dongli Zhang <dongli.zhang@oracle.com>,
 Joe Jin <joe.jin@oracle.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.6 05/37] dump: kdump-zlib data pages not dumped with
 pvtime/aarch64
Date: Sat,  9 Sep 2023 16:04:35 +0300
Message-Id: <20230909130511.354171-5-mjt@tls.msk.ru>
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

From: Dongli Zhang <dongli.zhang@oracle.com>

The kdump-zlib data pages are not dumped from aarch64 host when the
'pvtime' is involved, that is, when the block->target_end is not aligned to
page_size. In the below example, it is expected to dump two blocks.

(qemu) info mtree -f
... ...
  00000000090a0000-00000000090a0fff (prio 0, ram): pvtime KVM
... ...
  0000000040000000-00000001bfffffff (prio 0, ram): mach-virt.ram KVM
... ...

However, there is an issue with get_next_page() so that the pages for
"mach-virt.ram" will not be dumped.

At line 1296, although we have reached at the end of the 'pvtime' block,
since it is not aligned to the page_size (e.g., 0x10000), it will not break
at line 1298.

1255 static bool get_next_page(GuestPhysBlock **blockptr, uint64_t *pfnptr,
1256                           uint8_t **bufptr, DumpState *s)
... ...
1294             memcpy(buf + addr % page_size, hbuf, n);
1295             addr += n;
1296             if (addr % page_size == 0) {
1297                 /* we filled up the page */
1298                 break;
1299             }

As a result, get_next_page() will continue to the next
block ("mach-virt.ram"). Finally, when get_next_page() returns to the
caller:

- 'pfnptr' is referring to the 'pvtime'
- but 'blockptr' is referring to the "mach-virt.ram"

When get_next_page() is called the next time, "*pfnptr += 1" still refers
to the prior 'pvtime'. It will exit immediately because it is out of the
range of the current "mach-virt.ram".

The fix is to break when it is time to come to the next block, so that both
'pfnptr' and 'blockptr' refer to the same block.

Fixes: 94d788408d2d ("dump: fix kdump to work over non-aligned blocks")
Cc: Joe Jin <joe.jin@oracle.com>
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20230713055819.30497-1-dongli.zhang@oracle.com>
(cherry picked from commit 8a64609eea8cb2bac015968c4b62da5bce266e22)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/dump/dump.c b/dump/dump.c
index df117c847f..0f3b6a58d5 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -1298,8 +1298,8 @@ static bool get_next_page(GuestPhysBlock **blockptr, uint64_t *pfnptr,
 
             memcpy(buf + addr % page_size, hbuf, n);
             addr += n;
-            if (addr % page_size == 0) {
-                /* we filled up the page */
+            if (addr % page_size == 0 || addr >= block->target_end) {
+                /* we filled up the page or the current block is finished */
                 break;
             }
         } else {
-- 
2.39.2


