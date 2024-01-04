Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB26824850
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 19:38:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLSaH-0001MS-Kt; Thu, 04 Jan 2024 13:36:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rLSaC-0001HN-6B
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 13:36:44 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rLSa9-0005EN-QZ
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 13:36:43 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5AC1D616F9;
 Thu,  4 Jan 2024 18:36:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89072C433C9;
 Thu,  4 Jan 2024 18:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1704393400;
 bh=RfMF/F1MWgRkg/cJ7tX1IjaxKfhLcUlRTaP90CvwDNc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ho4F7WPUIxamr2T7Sh2cyXpcMLUjyqb3InGxhX5a2YKTAeDLsa4uz2bx1jto0YpdK
 CGNqi/1A45keAo6Co2Ksm/bEINHeh6j2TNkQFcIOmEeCTRBRuDfPuBCNQ+W+zkIcOX
 RxlPf3Wbuf+GzugmAFrHn3XkZhLV/nyAb30RJVkPXo+at3elBksYQdrWor2i0fSSX/
 H/bt/GTLw/tH9bTeUhzf5pMTJI0P8FXPgYwEID4G3kjkWjdWvlHVsS4rNZsLQ/gvTy
 UEI4Ez4MnGOg59zeuNXa7/v+8Kxm/PZnRuz9or8Q+fuArw4YPmZOOyOIfaMy0zIOvx
 m2EDibn9s9/7w==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Bruno Haible <bruno@clisp.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Nelson H . F . Beebe" <beebe@math.utah.edu>, Helge Deller <deller@gmx.de>
Subject: [PATCH 4/9] target/hppa: Fix PDC address translation on PA2.0 with
 PSW.W=0
Date: Thu,  4 Jan 2024 19:36:23 +0100
Message-ID: <20240104183628.101366-5-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104183628.101366-1-deller@kernel.org>
References: <20240104183628.101366-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.691,
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

Signed-off-by: Helge Deller <deller@gmx.de>
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


