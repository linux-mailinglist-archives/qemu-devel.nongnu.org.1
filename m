Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A6F718092
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 14:56:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4LLf-0007BT-8N; Wed, 31 May 2023 08:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LLU-00079Y-VK
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:54:33 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LLR-0006lb-ND
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PoFNZrNJWz98R3ODnfaecWjSfrfY5PkU8ru7Md1o6rk=; b=yUdaotETq8HhZxxBHGOpwvBFUs
 6Ua2iTZDW0gTYYp77N4+3flEm3Na3XX5gQVHNFPyGLnbvS2C2eV3X9S0qYHzsYF9FETEnXHzBfwYm
 5mCbLlFE/abGVAEnQdjNgLqRfyvHmcSi91LcSFXrKl5JRc0qwhLjjnYKiLnjABm4EZ6Ll3x7Y/Wq4
 lFx0j0ndyPH69iHia8IcFmwCaobAVVdZUbmqAHusONN3y46WG4ArNpiZwuiy7Is+iMaUvL6Gw9HIQ
 LJOKk9W+z+fchVCyXC+V3t34wWn12ZCpKwPiAEdos7knKLGJ93Chn5pGPXPOh+0k5E2/+dDtm3KtP
 5TqU6rtp4I5gc3d08AbOR2XMGcjLnvQNQouiv206EcSKtrKUsktFKj5aXtYdR27xo6p2pmXyD8gXL
 1GlGY2BQ+eops2216QyM34GXuX7oAkSt9xKdp406VRZDuR+yCpNs/ADjQCyMDIOtsuVML/6Mn1+un
 v6EmdY37dkaUsMPhLMkOc8iDMHWnceL1hL+0vbzhveJAj4NXre+iwH79cEMN7iBgSmFKwbm6O/ViV
 ldrkXLvCbxymL6Zf/zXfudRphvBM8HU8GvoJztZVzLE5HnJvRX4WomWyB80EeKkiDU0xoR7bUmcxe
 wlUz3BWHjuaFfnqE2pnVys8TRA59IyorzP9C+PbFQ=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LLH-0008vd-1m; Wed, 31 May 2023 13:54:23 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 31 May 2023 13:53:39 +0100
Message-Id: <20230531125400.288917-3-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 02/23] q800: add missing space after parent object in
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
---
 hw/m68k/q800.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 1aead224e2..bb9e857632 100644
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


