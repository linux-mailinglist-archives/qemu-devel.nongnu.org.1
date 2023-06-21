Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C307385DA
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 15:58:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qByKY-0004Gn-Az; Wed, 21 Jun 2023 09:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qByKT-0004Fa-Sg
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 09:57:01 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qByKS-00058p-Gw
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 09:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iBEfz/KCc5207JIEaXFfAvq994A+PmFkYIeuBso5UcM=; b=Vv8gxvmxhSuVzTkS/hINU2/5ku
 X5YcWboJ27jB9O8Ji0BCroDx9baK28w97VWZtk/a8g3UvbWmpZT/DLrFXxacSrlqLm0UIvISO1Dag
 wu9EjX+CBFL/KrRlVwF7MkfiH5dO7K9JRA5Q+NFAKAGQ1HyO7EyjY1mLGDDohHMJBp5o=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, richard.henderson@linaro.org, pbonzini@redhat.com,
 eduardo@habkost.net, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com
Subject: [PATCH v3 12/12] cpu: Replace target_ulong with hwaddr in
 tb_invalidate_phys_addr()
Date: Wed, 21 Jun 2023 15:56:33 +0200
Message-ID: <20230621135633.1649-13-anjo@rev.ng>
In-Reply-To: <20230621135633.1649-1-anjo@rev.ng>
References: <20230621135633.1649-1-anjo@rev.ng>
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

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 cpu.c                   | 2 +-
 include/exec/exec-all.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/cpu.c b/cpu.c
index 65ebaf8159..1c948d1161 100644
--- a/cpu.c
+++ b/cpu.c
@@ -293,7 +293,7 @@ void list_cpus(void)
 }
 
 #if defined(CONFIG_USER_ONLY)
-void tb_invalidate_phys_addr(target_ulong addr)
+void tb_invalidate_phys_addr(hwaddr addr)
 {
     mmap_lock();
     tb_invalidate_phys_page(addr);
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index cc1c3556f6..200c27eadf 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -526,7 +526,7 @@ uint32_t curr_cflags(CPUState *cpu);
 
 /* TranslationBlock invalidate API */
 #if defined(CONFIG_USER_ONLY)
-void tb_invalidate_phys_addr(target_ulong addr);
+void tb_invalidate_phys_addr(hwaddr addr);
 #else
 void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr, MemTxAttrs attrs);
 #endif
-- 
2.41.0


