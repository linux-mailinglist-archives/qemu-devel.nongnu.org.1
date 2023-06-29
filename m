Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17651742218
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 10:26:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEmyJ-0000zO-VO; Thu, 29 Jun 2023 04:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qEmyF-0000sR-1W
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 04:25:43 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qEmyC-0003yL-MI
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 04:25:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=z+1BEUmavoQO3HcH1kz8zqVdVEFpYdR3gpplJlnyaGk=; b=aEEfl3PCyu73Pfc1jSlJzgaIMg
 VLzdzV3Zt0MkMoX8Sv8pwPpjZW/ZFlUpqM8Hoy+O7zTYeppfrbqU7MqDgbyJNRm71VckdY80WWI8J
 hkn4ceOFEVHtUf5xYICXhrpayUqU4c9MM5iORa6Qsl7QgxNNXEEawKyyrTWyEr8Qf6uD1IMRQLEj3
 9EZizUABTrZ7HL3NxWgkse5rAPAusOhcMaY+oFkNulN7lWyyb21p5FxD3k98wV/zJroxmy3HIYLH0
 fEEBVL6Yu3A5vS3Cnb7b6Nw9+/khk/e9P0Nv8W2/s+ODjjYYoizbVg2zaNxC97QZepVXHqObvnn5m
 bRpCayBZOQRH9EgCVkxgqMXNtVdkv7bGVYm96It6xdVOT+GRd2a7jGP7uFT1pARRZEXVG7qyDfSRX
 +m7+1HyEUDgFBNa6gwrv7/DjyOdVD8pC8sAflwfbUTxsp+1bmiHSVSuv33dTx+csTRbMTF0dHQ1mU
 Sp6cFnkxcnnF5noNAKKLHcgMvb+nUPlcop3+9DrDy+8gaMSalAVcYxWP+jCqqh9ECCEJOlX4TLTzE
 ZxhQqYWJNnz15IKg9ueR5PsAyYXg57s5rFgO218e1I6uWO34K+OGzI4leC/u13CEvbtQI9EDi65rp
 s5yvobpuCcrisURfQQiNcMSlUNrdUQXCGgBMz55mc=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qEmxx-000AaV-8k; Thu, 29 Jun 2023 09:25:29 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: richard.henderson@linaro.org, clegoate@redhat.com, hsp.cat7@gmail.com,
 qemu-devel@nongnu.org
Date: Thu, 29 Jun 2023 09:25:22 +0100
Message-Id: <20230629082522.606219-3-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230629082522.606219-1-mark.cave-ayland@ilande.co.uk>
References: <20230629082522.606219-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 2/2] accel/tcg: add assert() check in
 tb_invalidate_phys_page_range__locked()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Add an assert() check in tb_invalidate_phys_page_range__locked() to ensure that
both the start and last addresses are within the same target page. Note that
due to performance concerns the check is only enabled when QEMU is configured
with --enable-debug-tcg.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 accel/tcg/tb-maint.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 33ea1aadd1..8cd730dcb0 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -1092,6 +1092,10 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
     TranslationBlock *current_tb = retaddr ? tcg_tb_lookup(retaddr) : NULL;
 #endif /* TARGET_HAS_PRECISE_SMC */
 
+#ifdef CONFIG_DEBUG_TCG
+    assert((last & TARGET_PAGE_MASK) == (start & TARGET_PAGE_MASK));
+#endif
+
     /*
      * We remove all the TBs in the range [start, last].
      * XXX: see if in some cases it could be faster to invalidate all the code
-- 
2.30.2


