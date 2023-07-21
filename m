Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBCB75D619
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 23:00:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMxDD-0006ah-4Z; Fri, 21 Jul 2023 16:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qMxDA-0006Zl-3A
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 16:58:52 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qMxD8-0004Qo-Np
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 16:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5F3lH1+nT4GucAsP0HhVZxiLvA88in7yC8PC1DDMSuc=; b=nPXXkHGsxIdlese79Mfgx5LHNB
 CDyNi2Rjv7zgXQikHfQskUDT1X0k5VMSFJXjF74N8SQWxGG/kJRzI3uhD4My3QQA1kkrfxVyDCzKK
 7JRcd/69GwNnCDFvQSFHUY4+4cNeBWaBu/6HerUwNHOIw0zyErIpErBHFcRO82+Y+cZ0=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, richard.henderson@linaro.org, pbonzini@redhat.com,
 philmd@linaro.org, agraf@csgraf.de, dirty@apple.com, rbolshakov@ddn.com,
 anielhb413@gmail.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 ysato@users.sourceforge.jp, peter.maydell@linaro.org
Subject: [PATCH 7/9] include/exec: Widen tlb_hit/tlb_hit_page()
Date: Fri, 21 Jul 2023 22:58:25 +0200
Message-ID: <20230721205827.7502-8-anjo@rev.ng>
In-Reply-To: <20230721205827.7502-1-anjo@rev.ng>
References: <20230721205827.7502-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


