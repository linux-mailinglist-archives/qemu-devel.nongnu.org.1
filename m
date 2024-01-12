Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C41382BEA5
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 11:30:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOEnJ-0007xn-CC; Fri, 12 Jan 2024 05:29:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rOEnF-0007x7-Td
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 05:29:41 -0500
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rOEnD-0006HN-VN
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 05:29:41 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 48A82CE23AD;
 Fri, 12 Jan 2024 10:29:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9E4C433C7;
 Fri, 12 Jan 2024 10:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705055376;
 bh=HpEUBmPX5EgN1uf9bgKCgE2CkewlySOnta131nELozs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mWGHIRX9PlUjAanub6gJEsw3fczC3hXKDPh7Jl/EMLszYCUjsfmMeeKKePy98mZFl
 fY1ezRe7knUTgoElXl1dQCLLfBZl13gYHFY+VDU00fUxfmx4Rv7RPJYGF7UL5ljhdp
 kIAyAdLcPx63JAwxoFcIjExq3ILkGfIBsHhBjhZfj+gjPG8KpUgQAAoTR+6U9DfKG9
 +M7x9YerNk/6JEhL6JGxwik1hyevvT4zJoacVF8tG0+2ertkWYhh2maEpHu31awjXg
 CLNL1MnSdu4dNq5UwSiDWRPyQvM85eh3VyUkHPXx0EHzYfRhMM4k+8k9VuZRRORJkB
 Ss6Nt4llzY7oQ==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Bruno Haible <bruno@clisp.org>
Subject: [PATCH v3 4/9] target/hppa: Fix PDC address translation on PA2.0 with
 PSW.W=0
Date: Fri, 12 Jan 2024 11:29:22 +0100
Message-ID: <20240112102927.35406-5-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112102927.35406-1-deller@kernel.org>
References: <20240112102927.35406-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=deller@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Helge Deller <deller@gmx.de>

Fix the address translation for PDC space on PA2.0 if PSW.W=0.
Basically, for any address in the 32-bit PDC range from 0xf0000000 to
0xf1000000 keep the lower 32-bits and just set the upper 32-bits to
0xfffffff0.

This mapping fixes the emulated power button in PDC space for 32- and
64-bit machines and is how the physical C3700 machine seems to map
PDC.

Figures H-10 and H-11 in the parisc2.0 spec [1] show that the 32-bit
region will be mapped somewhere into a higher and bigger 64-bit PDC
space.  The start and end of this 64-bit space is defined by the
physical address bits. But the figures don't specifiy where exactly the
mapping will start inside that region. Tests on a real HP C3700
regarding the address of the power button indicate, that the lower
32-bits will stay the same though.
[1] https://parisc.wiki.kernel.org/images-parisc/7/73/Parisc2.0.pdf

Signed-off-by: Helge Deller <deller@gmx.de>
Tested-by: Bruno Haible <bruno@clisp.org>
---
 target/hppa/mem_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 08abd1a9f9..011b192406 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -56,7 +56,7 @@ hwaddr hppa_abs_to_phys_pa2_w0(vaddr addr)
         addr = (int32_t)addr;
     } else {
         /* PDC address space */
-        addr &= MAKE_64BIT_MASK(0, 24);
+        addr = (uint32_t)addr;
         addr |= -1ull << (TARGET_PHYS_ADDR_SPACE_BITS - 4);
     }
     return addr;
-- 
2.43.0


