Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 283E67B79BF
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:11:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnwsr-0004EC-F3; Wed, 04 Oct 2023 04:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnwrE-0006zi-KX; Wed, 04 Oct 2023 04:03:48 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnwrC-0008IX-3p; Wed, 04 Oct 2023 04:03:48 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1CE312759C;
 Wed,  4 Oct 2023 11:02:26 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 70E1E2CBD8;
 Wed,  4 Oct 2023 11:02:25 +0300 (MSK)
Received: (nullmailer pid 2702804 invoked by uid 1000);
 Wed, 04 Oct 2023 08:02:21 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.2 18/45] include/exec: Widen tlb_hit/tlb_hit_page()
Date: Wed,  4 Oct 2023 11:01:39 +0300
Message-Id: <20231004080221.2702636-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.2-20231003193203@cover.tls.msk.ru>
References: <qemu-stable-8.1.2-20231003193203@cover.tls.msk.ru>
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

From: Anton Johansson <anjo@rev.ng>

tlb_addr is changed from target_ulong to uint64_t to match the type of
a CPUTLBEntry value, and the addressed is changed to vaddr.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230807155706.9580-8-anjo@rev.ng>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit c78edb563942ce80c9c6c03b07397725b006b625)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 94f44f1f59..c2c62160c6 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -397,7 +397,7 @@ QEMU_BUILD_BUG_ON(TLB_FLAGS_MASK & TLB_SLOW_FLAGS_MASK);
  * @addr: virtual address to test (must be page aligned)
  * @tlb_addr: TLB entry address (a CPUTLBEntry addr_read/write/code value)
  */
-static inline bool tlb_hit_page(target_ulong tlb_addr, target_ulong addr)
+static inline bool tlb_hit_page(uint64_t tlb_addr, vaddr addr)
 {
     return addr == (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK));
 }
@@ -408,7 +408,7 @@ static inline bool tlb_hit_page(target_ulong tlb_addr, target_ulong addr)
  * @addr: virtual address to test (need not be page aligned)
  * @tlb_addr: TLB entry address (a CPUTLBEntry addr_read/write/code value)
  */
-static inline bool tlb_hit(target_ulong tlb_addr, target_ulong addr)
+static inline bool tlb_hit(uint64_t tlb_addr, vaddr addr)
 {
     return tlb_hit_page(tlb_addr, addr & TARGET_PAGE_MASK);
 }
-- 
2.39.2


