Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 525B47D7F23
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 10:58:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvwB9-0005kV-Al; Thu, 26 Oct 2023 04:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qvwB3-0005iP-8a
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 04:57:17 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qvwAy-000610-Uc
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 04:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=m8yxVOFYY049SfOfPaVYJTXIZNb3z2k+XL0AxUUInpI=; b=ydYDnYif7T1jGCmuCffXianWpz
 pdJ05XHq2o2toagr+gLlGpCoPqo2Tc1OA1PZ8XybD6ZTg8/Se60zU+flVV5oZLXl+aaQJzgnO8eWe
 aGjvTn0NZlLUkAIVDB/nnwDhaPm1eyt03Out3gNhRj+RY6ydys/4YJlmJpUgTMNQf3/tLbDEJxclx
 ab3l7JgDCEJBhOPOuzWNZ01syjTr+ws2UL/F4Mq5Bpb0RfY2hAnSUY9lB8zNNFUnFok5g+UxGPRd5
 BFQfIxNnNGIiVooVnxtDFzOW/Ta95a5R2voaUxR1wL5AvcIXS710W+TEDNCbVQ4WgIQxdOLaGMXxI
 S5tjMbYywOd06Ca7zOD4ssHlC5dr/Ay4Y29w2hs0zojmBek1SGBK2Gs4myNzk8SrQAnB9xPZrFv6R
 c2rvXnTwx+ZLWOb9dLaeG2g0I8pcFfxptKQRmizJADN87at2OzRG8BMRLD2DnSxxzRCm91tgzZDOv
 ADcobS1KtHtP5prAq/CYemp+6DOYqTkEe8e3ZbH3AqMaeMf2kzz+79dnf7Hz8Tw08A/oAzK6Stkls
 AkPDJC57nbvtd2KWbPJ1D0wPWuYcMhrc7jbOnxLJWykytJ2qM3r03mWDpfav/BIkQl51eN1LfwEoW
 j8/TlaGpWNToB3cZ51aWj4QYJfSz4cStmt39h72Wc=;
Received: from host86-130-37-248.range86-130.btcentralplus.com
 ([86.130.37.248] helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qvwAe-0000md-NY; Thu, 26 Oct 2023 09:56:56 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Thu, 26 Oct 2023 09:56:47 +0100
Message-Id: <20231026085650.917663-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231026085650.917663-1-mark.cave-ayland@ilande.co.uk>
References: <20231026085650.917663-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.248
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 1/4] macfb: don't clear interrupts when writing to DAFB_RESET
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Traces from A/UX suggest that this register is only used to reset the framebuffer
LUT (colour lookup table) and not any other device state.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/display/macfb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/display/macfb.c b/hw/display/macfb.c
index 2f8e016566..28db2e9f24 100644
--- a/hw/display/macfb.c
+++ b/hw/display/macfb.c
@@ -585,8 +585,6 @@ static void macfb_ctrl_write(void *opaque,
         break;
     case DAFB_RESET:
         s->palette_current = 0;
-        s->regs[DAFB_INTR_STAT >> 2] &= ~DAFB_INTR_VBL;
-        macfb_update_irq(s);
         break;
     case DAFB_LUT:
         s->color_palette[s->palette_current] = val;
-- 
2.39.2


