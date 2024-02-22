Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0764285F6C2
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Feb 2024 12:27:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd7E9-0008D3-4t; Thu, 22 Feb 2024 06:26:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rd7Dv-00087n-US; Thu, 22 Feb 2024 06:26:44 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rd7Dr-00052N-Ua; Thu, 22 Feb 2024 06:26:43 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1D20E4FB4E;
 Thu, 22 Feb 2024 14:26:26 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 97E888717A;
 Thu, 22 Feb 2024 14:26:02 +0300 (MSK)
Received: (nullmailer pid 2526176 invoked by uid 1000);
 Thu, 22 Feb 2024 11:26:01 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 12/34] system/physmem: remove redundant arg reassignment
Date: Thu, 22 Feb 2024 14:25:39 +0300
Message-Id: <20240222112601.2526057-13-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240222112601.2526057-1-mjt@tls.msk.ru>
References: <20240222112601.2526057-1-mjt@tls.msk.ru>
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Arguments `ram_block` are reassigned to local declarations `block`
without further use. Remove re-assignment to reduce noise.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 system/physmem.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 5e054650b8..e3ebc19eef 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2154,10 +2154,8 @@ void qemu_ram_remap(ram_addr_t addr, ram_addr_t length)
  *
  * Called within RCU critical section.
  */
-void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr)
+void *qemu_map_ram_ptr(RAMBlock *block, ram_addr_t addr)
 {
-    RAMBlock *block = ram_block;
-
     if (block == NULL) {
         block = qemu_get_ram_block(addr);
         addr -= block->offset;
@@ -2182,10 +2180,9 @@ void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr)
  *
  * Called within RCU critical section.
  */
-static void *qemu_ram_ptr_length(RAMBlock *ram_block, ram_addr_t addr,
+static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
                                  hwaddr *size, bool lock)
 {
-    RAMBlock *block = ram_block;
     if (*size == 0) {
         return NULL;
     }
-- 
2.39.2


