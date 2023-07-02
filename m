Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2691744F9C
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 20:07:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qG1SI-0000kQ-AO; Sun, 02 Jul 2023 14:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qG1Rt-0000dQ-E0; Sun, 02 Jul 2023 14:05:27 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qG1Rr-0005JX-5i; Sun, 02 Jul 2023 14:05:24 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EBBE310DF3;
 Sun,  2 Jul 2023 21:04:54 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 308BE11207;
 Sun,  2 Jul 2023 21:04:53 +0300 (MSK)
Received: (nullmailer pid 2122381 invoked by uid 1000);
 Sun, 02 Jul 2023 18:04:51 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.3 64/65] linux-user: Avoid mmap of the last byte of the
 reserved_va
Date: Sun,  2 Jul 2023 21:04:37 +0300
Message-Id: <20230702180439.2122316-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.3-20230702210422@cover.tls.msk.ru>
References: <qemu-stable-8.0.3-20230702210422@cover.tls.msk.ru>
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

From: Richard Henderson <richard.henderson@linaro.org>

There is an overflow problem in mmap_find_vma_reserved:
when reserved_va == UINT32_MAX, end may overflow to 0.
Rather than a larger rewrite at this time, simply avoid
the final byte of the VA, which avoids searching the
final page, which avoids the overflow.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1741
Fixes: 95059f9c ("include/exec: Change reserved_va semantics to last byte")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Message-Id: <20230629080835.71371-1-richard.henderson@linaro.org>
(cherry picked from commit 605a8b5491a119a2a6efbf61e5a38f9374645990)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 0aa8ae7356..2692936773 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -281,9 +281,15 @@ static abi_ulong mmap_find_vma_reserved(abi_ulong start, abi_ulong size,
     /* Note that start and size have already been aligned by mmap_find_vma. */
 
     end_addr = start + size;
+    /*
+     * Start at the top of the address space, ignoring the last page.
+     * If reserved_va == UINT32_MAX, then end_addr wraps to 0,
+     * throwing the rest of the calculations off.
+     * TODO: rewrite using last_addr instead.
+     * TODO: use the interval tree instead of probing every page.
+     */
     if (start > reserved_va - size) {
-        /* Start at the top of the address space.  */
-        end_addr = ((reserved_va + 1 - size) & -align) + size;
+        end_addr = ((reserved_va - size) & -align) + size;
         looped = true;
     }
 
@@ -296,8 +302,8 @@ static abi_ulong mmap_find_vma_reserved(abi_ulong start, abi_ulong size,
                 /* Failure.  The entire address space has been searched.  */
                 return (abi_ulong)-1;
             }
-            /* Re-start at the top of the address space.  */
-            addr = end_addr = ((reserved_va + 1 - size) & -align) + size;
+            /* Re-start at the top of the address space (see above). */
+            addr = end_addr = ((reserved_va - size) & -align) + size;
             looped = true;
         } else {
             prot = page_get_flags(addr);
-- 
2.39.2


