Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C74A3FDE7
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Feb 2025 18:51:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlXAi-0001IC-JN; Fri, 21 Feb 2025 12:50:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tlXAY-0001D4-Sk; Fri, 21 Feb 2025 12:50:35 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tlXAW-0001pa-AN; Fri, 21 Feb 2025 12:50:34 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 53175EFB6E;
 Fri, 21 Feb 2025 20:49:31 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0BE181BB58A;
 Fri, 21 Feb 2025 20:49:51 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id E8C3853F8F; Fri, 21 Feb 2025 20:49:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.2 11/14] elfload: Fix alignment when unmapping excess
 reservation
Date: Fri, 21 Feb 2025 20:49:41 +0300
Message-Id: <20250221174949.836197-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.2-20250221204240@cover.tls.msk.ru>
References: <qemu-stable-9.2.2-20250221204240@cover.tls.msk.ru>
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

From: Fabiano Rosas <farosas@suse.de>

When complying with the alignment requested in the ELF and unmapping
the excess reservation, having align_end not aligned to the guest page
causes the unmap to be rejected by the alignment check at
target_munmap and later brk adjustments hit an EEXIST.

Fix by aligning the start of region to be unmapped.

Fixes: c81d1fafa6 ("linux-user: Honor elf alignment when placing images")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1913
Signed-off-by: Fabiano Rosas <farosas@suse.de>
[rth: Align load_end as well.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250213143558.10504-1-farosas@suse.de>
(cherry picked from commit 4b7b20a3b72c5000ea71bef505c16e6e628268b6)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 471a384b22..aa3607f3ac 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3349,8 +3349,8 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
 
     if (align_size != reserve_size) {
         abi_ulong align_addr = ROUND_UP(load_addr, align);
-        abi_ulong align_end = align_addr + reserve_size;
-        abi_ulong load_end = load_addr + align_size;
+        abi_ulong align_end = TARGET_PAGE_ALIGN(align_addr + reserve_size);
+        abi_ulong load_end = TARGET_PAGE_ALIGN(load_addr + align_size);
 
         if (align_addr != load_addr) {
             target_munmap(load_addr, align_addr - load_addr);
-- 
2.39.5


