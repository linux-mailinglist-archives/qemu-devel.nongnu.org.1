Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9257C7729F3
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 17:59:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT2c5-0006Mt-Eh; Mon, 07 Aug 2023 11:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qT2bw-00062r-Mx
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 11:57:37 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qT2bv-0002Zk-B0
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 11:57:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=B4qVJUcVRQmpohxrypGbJCTzfRn1IYVoyWR4GGcKOk0=; b=pjOjVrQpVGSBrZJi3KHjnn5noJ
 EGujL/cPOXy996vadh5LWngjLe5y5qw5VaDthG+Esu58Gj9AeSGE01bJ4EWXmhLvAJDcEDZyG70Pw
 HX5QXl3A/pM4+pgB2lDf9PnW63iuypa9P++Kjxhf+OArFZA8FqFFzuaPprvbr4CtKj1Q=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, richard.henderson@linaro.org, pbonzini@redhat.com,
 philmd@linaro.org, agraf@csgraf.de, dirty@apple.com, rbolshakov@ddn.com,
 anielhb413@gmail.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 ysato@users.sourceforge.jp, peter.maydell@linaro.org
Subject: [PATCH v2 7/9] include/exec: Widen tlb_hit/tlb_hit_page()
Date: Mon,  7 Aug 2023 17:57:04 +0200
Message-ID: <20230807155706.9580-8-anjo@rev.ng>
In-Reply-To: <20230807155706.9580-1-anjo@rev.ng>
References: <20230807155706.9580-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

tlb_addr is changed from target_ulong to uint64_t to match the type of
a CPUTLBEntry value, and the addressed is changed to vaddr.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
2.41.0


