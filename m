Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D6575D61B
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 23:00:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMxDA-0006ZE-A1; Fri, 21 Jul 2023 16:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qMxD8-0006V8-8O
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 16:58:50 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qMxD6-0004QM-PM
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 16:58:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Y1UU1LDKH1hTZPZdBiqE1snAV/bC24htdc/Y5+41wVE=; b=BMNkGhlvSTfL91yOkqkTlnRGeh
 VtP0xZKNRiIkgfWDn12CN5s62BfT8MIT7gExrpHzGBgiaZVIyFxd+zu5RYDuphSOMBjmq4HCXkJvB
 pqecvpg1QDghdh1dkCBsLegna0X6LZSFtwAJJnl3yYUVlZXacITqj3olsTzhlXNCPLf4=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, richard.henderson@linaro.org, pbonzini@redhat.com,
 philmd@linaro.org, agraf@csgraf.de, dirty@apple.com, rbolshakov@ddn.com,
 anielhb413@gmail.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 ysato@users.sourceforge.jp, peter.maydell@linaro.org
Subject: [PATCH 6/9] include/exec: typedef abi_ptr to vaddr in softmmu
Date: Fri, 21 Jul 2023 22:58:24 +0200
Message-ID: <20230721205827.7502-7-anjo@rev.ng>
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

In system mode, abi_ptr is primarily used for representing addresses
when accessing guest memory with cpu_[st|ld]*(). Widening it from
target_ulong to vaddr reduces the target dependence of these functions
and is step towards building accel/ once for system mode.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 include/exec/cpu_ldst.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index da10ba1433..f3ce4eb1d0 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -121,8 +121,8 @@ static inline bool guest_range_valid_untagged(abi_ulong start, abi_ulong len)
     h2g_nocheck(x); \
 })
 #else
-typedef target_ulong abi_ptr;
-#define TARGET_ABI_FMT_ptr TARGET_FMT_lx
+typedef vaddr abi_ptr;
+#define TARGET_ABI_FMT_ptr "%016" VADDR_PRIx
 #endif
 
 uint32_t cpu_ldub_data(CPUArchState *env, abi_ptr ptr);
-- 
2.41.0


