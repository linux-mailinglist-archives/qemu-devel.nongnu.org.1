Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C814075D615
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 22:59:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMxDC-0006aX-Ns; Fri, 21 Jul 2023 16:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qMxDB-0006a2-2H
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 16:58:53 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qMxD9-0004R0-QA
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 16:58:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IyRUaUrZmROjsZyb/fgnX9P/cehJ9xeR6m1pZL2X7bw=; b=dQE1PHaZyB+utiSxRCl/Yv+pMT
 QfP9G+4m4DAt26fTmLOIgNYiakkX98xeBCzNGj6jC7OwbwcVHIqfHk6MkjAZ6wAqGgzLL83au0/ph
 LwOYxrQROq1mBxMFTZ5TqNSPxsTwOF3QVSDwjbipBSUVm06fnrYPs4KQKGpxVpguHYq8=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, richard.henderson@linaro.org, pbonzini@redhat.com,
 philmd@linaro.org, agraf@csgraf.de, dirty@apple.com, rbolshakov@ddn.com,
 anielhb413@gmail.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 ysato@users.sourceforge.jp, peter.maydell@linaro.org
Subject: [PATCH 8/9] accel/tcg: Widen address arg. in tlb_compare_set()
Date: Fri, 21 Jul 2023 22:58:26 +0200
Message-ID: <20230721205827.7502-9-anjo@rev.ng>
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

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 accel/tcg/cputlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 8e9dc51cd1..2f97ae2fda 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1108,7 +1108,7 @@ static void tlb_add_large_page(CPUArchState *env, int mmu_idx,
 }
 
 static inline void tlb_set_compare(CPUTLBEntryFull *full, CPUTLBEntry *ent,
-                                   target_ulong address, int flags,
+                                   vaddr address, int flags,
                                    MMUAccessType access_type, bool enable)
 {
     if (enable) {
-- 
2.41.0


