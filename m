Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD287E82CC
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 20:36:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1XI7-0006Q1-QH; Fri, 10 Nov 2023 14:35:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=DfYf=GX=gmx.de=deller@kernel.org>)
 id 1r1XI5-0006Pg-2V
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 14:35:41 -0500
Received: from ams.source.kernel.org ([145.40.68.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=DfYf=GX=gmx.de=deller@kernel.org>)
 id 1r1XI3-0007vz-4F
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 14:35:40 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 2BEFDB81FAE;
 Fri, 10 Nov 2023 19:35:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD7FC433C7;
 Fri, 10 Nov 2023 19:35:27 +0000 (UTC)
Date: Fri, 10 Nov 2023 20:35:24 +0100
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] target/hppa: Fix possible overflow in TLB size calculation
Message-ID: <ZU6F/H8CZr3q4pP/@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=145.40.68.75;
 envelope-from=SRS0=DfYf=GX=gmx.de=deller@kernel.org;
 helo=ams.source.kernel.org
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
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

Coverty found that the shift of TARGET_PAGE_SIZE (32-bit type) might
overflow.  Fix it by casting TARGET_PAGE_SIZE to a 64-bit type before
doing the shift (CID 1523902 and CID 1523908).

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index f100c26290..30f0415d1b 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -460,7 +460,7 @@ static void itlbt_pa20(CPUHPPAState *env, target_ulong r1,
     int mask_shift;
 
     mask_shift = 2 * (r1 & 0xf);
-    va_size = TARGET_PAGE_SIZE << mask_shift;
+    va_size = ((uint64_t) TARGET_PAGE_SIZE) << mask_shift;
     va_b &= -va_size;
     va_e = va_b + va_size - 1;
 
@@ -522,7 +522,7 @@ static void ptlb_work(CPUState *cpu, run_on_cpu_data data)
      */
     end = start & 0xf;
     start &= TARGET_PAGE_MASK;
-    end = TARGET_PAGE_SIZE << (2 * end);
+    end = ((vaddr) TARGET_PAGE_SIZE) << (2 * end);
     end = start + end - 1;
 
     hppa_flush_tlb_range(env, start, end);

