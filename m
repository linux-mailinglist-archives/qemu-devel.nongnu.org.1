Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98545827196
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 15:40:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMqlt-0006Y2-11; Mon, 08 Jan 2024 09:38:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rMqle-0006T5-G9
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 09:38:20 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rMqlb-0007iZ-Ss
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 09:38:18 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 34D5361053;
 Mon,  8 Jan 2024 14:38:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47EECC433C8;
 Mon,  8 Jan 2024 14:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1704724690;
 bh=RfMF/F1MWgRkg/cJ7tX1IjaxKfhLcUlRTaP90CvwDNc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LAze58PJgzIFIX2zpwmMljxRcxg7hsu2FNZ+jjofrcah7YMF92BTZrFyuB7zcBTpz
 GNFSZQE5BOvtpXZ7Xps8hHgvlbLwiKQ64yBfU56IMZqDZ58itGw2jlVaCp6rFUwVOx
 ylWGEF00mzmgXJv7fxJ9t7m9EGclu2dVj3MjZGqUQXcIJvDwQM6mE/3ucStkyxAgYq
 T5Sgg7zBqLnuAzYUdRNerq2HMrmjdzOF6ma+jPBRf/gnIi40lhhqs6KJhYCTPl0yFL
 D8TiD2Xw1j0Fp/bqx/mflJkuxvy4rC2EaYi8Sxyuo0Eak1MK1IiKcHOmZMm88OHuEl
 Br3otCmwMiKbQ==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 4/9] target/hppa: Fix PDC address translation on PA2.0 with
 PSW.W=0
Date: Mon,  8 Jan 2024 15:37:57 +0100
Message-ID: <20240108143802.50256-5-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108143802.50256-1-deller@kernel.org>
References: <20240108143802.50256-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -66
X-Spam_score: -6.7
X-Spam_bar: ------
X-Spam_report: (-6.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
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


