Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E481742216
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 10:25:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEmyH-0000sX-94; Thu, 29 Jun 2023 04:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qEmy9-0000p0-Cf
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 04:25:39 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qEmy7-0003rj-3K
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 04:25:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RNcZkPa/rKhmBl8lqIGxrWEqpXBOTKDxE9CIQX80Ino=; b=VQi6RxqGv6HkPJlfdYobZTD++Z
 UZjvCvEDiXgr6soYq0PueGoDKapEWuHGA9OXcY3I1NKlwaYq9f+AHHZLXwaI/zRPxCEphRKhuiF7H
 pQfWTsrMmZuHnTKiPS7tO5omMRzLuRNj7o1iYyxoP5RGYYUBqGOoD/B5x5UxE54Dnt8pVaZ7JJd0z
 dZb7MHHkqeqxiQLA3SlFNKSpF/H94NsFlN1uKtnlMEWJh06Xi/x54dfFMmoExoAEMyFmbK1RmPfqz
 pBPovEUMkT4/x478gFvhd7drrVx/+djt2WVbHieaybrx5vbAiDitw2LCeXAyaE7GO9F0MmJ65q6b7
 Ifa8E1XLn0tAcPIE2tJj9MUFZWRjMzuzCTBJdsQuzX8E/HV1ksjfyg+1IOQMpmnRq70tDYL77sanM
 MTb5OpKyaC1k/yWJyFvOT8m7EPqJRrHCs4MA9oW6Xui6yAa3PlNR1b9W70wZEQ6LS0JJ/qK4VJk7o
 CYUYs0hG4/VzDDiNssMfJUhVpO3jWsw7jtCmCLL6e0poTQ9HZb5TFpeydFl+YIbkU/9jP4OEO1D0W
 OPiGH1X/BuYjUSmRysYyS67gmiLCBBA2wV3NfFNoy86HfVi05r74jSywEr29ARarBOEpCFy0NJe4p
 ziveRfwLCEUhTsqutjoqzwY/1znWizb68f095onps=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qEmxo-000AaV-Lb; Thu, 29 Jun 2023 09:25:20 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: richard.henderson@linaro.org, clegoate@redhat.com, hsp.cat7@gmail.com,
 qemu-devel@nongnu.org
Date: Thu, 29 Jun 2023 09:25:20 +0100
Message-Id: <20230629082522.606219-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 0/2] accel/tcg: fix page invalidation in
 tb_invalidate_phys_range()
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

This series contains 2 patches: the first is a fix for page invalidation in
tb_invalidate_phys_range() which resolves the crash reported by Howard and
Cédric when booting MacOS 9 under qemu-system-ppc -M mac99,via=pmu.

The second patch adds an assert() to tb_invalidate_phys_page_range__locked()
which is enabled by --enable-debug-tcg to ensure that both the start and last
addresses are within the same target page.

I've confirmed that this assert() is first triggered by the commit that
initially introduced the bug e506ad6a05 ("accel/tcg: Pass last not end to
tb_invalidate_phys_range") when building QEMU with --enable-debug and
doesn't trigger after the series is applied.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Mark Cave-Ayland (2):
  accel/tcg: fix start page passed to
    tb_invalidate_phys_page_range__locked()
  accel/tcg: add assert() check in
    tb_invalidate_phys_page_range__locked()

 accel/tcg/tb-maint.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

-- 
2.30.2


