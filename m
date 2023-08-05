Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE8B770FB9
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 14:53:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSGlE-0006Mt-Jx; Sat, 05 Aug 2023 08:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <negge@xiph.org>) id 1qSGlC-0006MV-Gy
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 08:51:58 -0400
Received: from mailfish.xiph.osuosl.org ([140.211.166.35]
 helo=mailfish.xiph.org) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <negge@xiph.org>) id 1qSGlA-0006a4-5y
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 08:51:58 -0400
Received: from localhost.localdomain (c-24-126-94-29.hsd1.wv.comcast.net
 [24.126.94.29])
 by mailfish.xiph.org (Postfix) with ESMTPSA id 92B3D9F8A1;
 Sat,  5 Aug 2023 12:51:51 +0000 (UTC)
From: Nathan Egge <negge@xiph.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Helge Deller <deller@gmx.de>,
 qemu-devel@nongnu.org, "Nathan Egge" <negge@xiph.org>
Subject: [PATCH] Fix scripts/checkpatch.py style failures.
Date: Sat,  5 Aug 2023 08:51:24 -0400
Message-Id: <20230805125124.42482-1-negge@xiph.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=140.211.166.35; envelope-from=negge@xiph.org;
 helo=mailfish.xiph.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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

From: "Nathan Egge" <negge@xiph.org>

Signed-off-by: Nathan Egge <negge@xiph.org>
---
 linux-user/syscall.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 95727a816a..38ab2201e2 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -863,8 +863,8 @@ abi_long do_brk(abi_ulong brk_val)
     if (new_host_brk_page > brk_page) {
         new_alloc_size = new_host_brk_page - brk_page;
         mapped_addr = get_errno(target_mmap(brk_page, new_alloc_size,
-                                        PROT_READ|PROT_WRITE,
-                                        MAP_ANON|MAP_PRIVATE, 0, 0));
+                                        PROT_READ | PROT_WRITE,
+                                        MAP_ANON | MAP_PRIVATE, 0, 0));
     } else {
         new_alloc_size = 0;
         mapped_addr = brk_page;
@@ -6128,8 +6128,8 @@ static abi_long write_ldt(CPUX86State *env,
     if (!ldt_table) {
         env->ldt.base = target_mmap(0,
                                     TARGET_LDT_ENTRIES * TARGET_LDT_ENTRY_SIZE,
-                                    PROT_READ|PROT_WRITE,
-                                    MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
+                                    PROT_READ | PROT_WRITE,
+                                    MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
         if (env->ldt.base == -1)
             return -TARGET_ENOMEM;
         memset(g2h_untagged(env->ldt.base), 0,
-- 
2.35.1


