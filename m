Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3073D832B8E
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 15:46:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQq31-0005td-BC; Fri, 19 Jan 2024 09:40:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQq2q-0005q5-S9
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:40:34 -0500
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQq2m-0003tM-Ty
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:40:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=na16a3kkbbDiLaCoxLNStnzoqPivBaqVHjAABny5AW8=; b=wBtvCYVIMYuSebIS6/omyghrtp
 gBXa74s7midl/DiGwBoREI5CYN1FIhogfkWJEtHDFkzrImB01LD4MCQGxMHzGU+JTFGG4q5lU09Bg
 nDeJW3tVCjrTVSRARXf53+vL8VmQ/H+9npJDlf6TekMahDyZHN4OYVw8dxMtL2v/cL6I=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng,
	richard.henderson@linaro.org,
	philmd@linaro.org
Subject: [RFC PATCH 17/34] hw/core: [CPUTLB] Move target specifics to end of
 TCGCPUOps
Date: Fri, 19 Jan 2024 15:40:07 +0100
Message-ID: <20240119144024.14289-18-anjo@rev.ng>
In-Reply-To: <20240119144024.14289-1-anjo@rev.ng>
References: <20240119144024.14289-1-anjo@rev.ng>
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

TCGCPUOps contains an extra function pointer when included with
NEED_CPU_H, these are moved from the middle to the end of the struct. As
such offsets to target independent function pointers don't vary in
target specific and independent code.

[Move target specfic fields to separate struct?]

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 include/hw/core/tcg-cpu-ops.h | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
index 479713a36e..feb849051f 100644
--- a/include/hw/core/tcg-cpu-ops.h
+++ b/include/hw/core/tcg-cpu-ops.h
@@ -49,21 +49,6 @@ struct TCGCPUOps {
     /** @debug_excp_handler: Callback for handling debug exceptions */
     void (*debug_excp_handler)(CPUState *cpu);
 
-#ifdef NEED_CPU_H
-#if defined(CONFIG_USER_ONLY) && defined(TARGET_I386)
-    /**
-     * @fake_user_interrupt: Callback for 'fake exception' handling.
-     *
-     * Simulate 'fake exception' which will be handled outside the
-     * cpu execution loop (hack for x86 user mode).
-     */
-    void (*fake_user_interrupt)(CPUState *cpu);
-#else
-    /**
-     * @do_interrupt: Callback for interrupt handling.
-     */
-    void (*do_interrupt)(CPUState *cpu);
-#endif /* !CONFIG_USER_ONLY || !TARGET_I386 */
 #ifdef CONFIG_USER_ONLY
     /**
      * record_sigsegv:
@@ -171,8 +156,25 @@ struct TCGCPUOps {
     bool (*io_recompile_replay_branch)(CPUState *cpu,
                                        const TranslationBlock *tb);
 #endif /* !CONFIG_USER_ONLY */
+
+#ifdef NEED_CPU_H
+#if defined(CONFIG_USER_ONLY) && defined(TARGET_I386)
+    /**
+     * @fake_user_interrupt: Callback for 'fake exception' handling.
+     *
+     * Simulate 'fake exception' which will be handled outside the
+     * cpu execution loop (hack for x86 user mode).
+     */
+    void (*fake_user_interrupt)(CPUState *cpu);
+#else
+    /**
+     * @do_interrupt: Callback for interrupt handling.
+     */
+    void (*do_interrupt)(CPUState *cpu);
+#endif /* !CONFIG_USER_ONLY || !TARGET_I386 */
 #endif /* NEED_CPU_H */
 
+
 };
 
 #if defined(CONFIG_USER_ONLY)
-- 
2.43.0


