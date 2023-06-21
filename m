Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA814737DD8
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 10:55:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBtbT-0001v3-2S; Wed, 21 Jun 2023 04:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtbR-0001ud-AU
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:54:13 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtbP-0003DK-O7
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IRzrPR9ntrOayXydUShbDK23mwAnImbRkwCubHvvs3Y=; b=jWpz3g8hscs/bKGN7+mTUemI/Z
 Xyf2C5NGOzaq8a7hX8KXIuoFKC+hmZ3HD1SawYhfktfmW50aGfxy4MhGF6oPkfdsCoUvK1N8xVLqG
 LzgpPYqNqW8LeenT+9nrfn+/jSjreBcpAlaIySrlXTiCAQRDgSMyV0Q4El0cn2Mau6oYeNNIonCXx
 z0sSBFzlMHiVWz9GPVZenZ3ohRfVyD5wi8eeulRdunl5ODJF6FzzKHCN5QAe6nbiWdg5sGXb63mNM
 C0uqQF1MdQhaohNLPx96bLCzSmzHe640w9GXfvo73OjQx+OAlLYk+LfwUInXwfP/+wd6ZVxDNLNjD
 6ZkX/EUwuUioo7w30KauRwCJ6Sc3ofh+2I4a4MAizMK79Jt0YHCih+7spNSbu/ECbsra+S9/fIbmC
 KMqind4xICG64lCkAHHIH1vnryt0Au3mn2b/cS/5NlcVAuYrfwg6WGkpDkRX9AbEpPbMPHKOimrEm
 m6m0iamt+k0XmGMFW9KTsOxtKyW1M5i3mtlkCqTFenJsa/Rl+0jVCuqy89gjdL4yHddtUOK/bNO+B
 MfE5VlWzf68YNmuOMFcBxFgKe42P8/X1jEg4hVGPIW8Sc3AXKemnLJy1sBSmdtJ6BPI4qv+4Txd8O
 25RKJbQ9GYPX00vk7mT2PIDe8fciJfws4VpDNG/yk=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtbE-0001ZB-C7; Wed, 21 Jun 2023 09:54:04 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 21 Jun 2023 09:53:31 +0100
Message-Id: <20230621085353.113233-3-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
References: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 02/24] q800: add missing space after parent object in
 GLUEState
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

This brings GLUEState in line with our current QOM guidelines.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/m68k/q800.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index dda57c60bf..465c510c18 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -100,6 +100,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(GLUEState, GLUE)
 
 struct GLUEState {
     SysBusDevice parent_obj;
+
     M68kCPU *cpu;
     uint8_t ipr;
     uint8_t auxmode;
-- 
2.30.2


