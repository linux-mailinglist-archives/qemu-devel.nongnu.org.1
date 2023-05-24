Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECB770FFCA
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 23:13:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1vn0-00049Z-7R; Wed, 24 May 2023 17:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vmt-0003qW-IO
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:12:53 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vmq-0002Cn-VV
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=L7nuLEQTrkwuy5/EBzvC3FEBlp1hMl0MRLYUJtTKR+0=; b=0ODWCGKW8fqJPoM9csPWA7NhrR
 rl4DMlg2Kv+NgMrj2ze/IjAI0BPFi2qQnxrwRZZXIRIGNZ4MheCLeQLZd9ygGlxpV8qTpbBUlz0Yn
 UBs7EqPp5LFZrfnZe6xOEuaxVBFuyexE3A6hVJ3q2y9CZz5FUb8RCYOZnPQAjCXMH3610nwX6Y69N
 LgqcyRDB1xmDtrdbKZRxamud6QmyL8YDu6FaWuhS3Et/WZ3FCYtxur4FghSXW8C6R4d17hkNocimD
 fcC5ch9/NIdIECFXgkJpi5xUWPgA90UPR2zz5TVkcHamJVPFzEu1VVmlG7eYZ9K46cmMSqczZxV95
 mlbOVKVbLnUwOW+0J2FeBDCaVLLP39tqz8cho8Mq+ZuVHcMD7saShXZWDURNHAi+mUSKO6RXBuN9D
 uzTejfTmaYuYQQ8qHrqJMp5+FZ701LpO5rTzZhu4jrG3yfV0YH0m64w4FrKRj3cMOtLLhlz2KxisQ
 WvneGzJleLhDFn5aSSN6OpdAPsf2uZ4q8V78SCVi9i5v2VZ/6BRY5gcnWOtEyiM9AVXoGgvG+PeLn
 uf4K90/HWx1NoW75qhG1MBM7rlJRUQClZHjasGGWBUsADtG6olMeSSxiHmuLWnVjEEPtGExy6Hq2J
 sXtyY7taor3aY0U2ejIGdaka7a8AE3FkUtsYUolws=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vmY-0005XR-78; Wed, 24 May 2023 22:12:30 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 24 May 2023 22:10:56 +0100
Message-Id: <20230524211104.686087-23-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
References: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 22/30] mac_via: fix rtc command decoding from PRAM addresses
 0x0 to 0xf
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

A comparison between the rtc command table included in the comment and the code
itself shows that the decoding for PRAM addresses 0x0 to 0xf is being done on
the raw command, and not the shifted version held in value.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/misc/mac_via.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index 62f0988537..d7067030db 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -403,7 +403,7 @@ static int via1_rtc_compact_cmd(uint8_t value)
         } else if ((value & 0x1c) == 0x08) {
             /* RAM address 0x10 to 0x13 */
             return read | (REG_PRAM_ADDR + 0x10 + (value & 0x03));
-        } else if ((value & 0x43) == 0x41) {
+        } else if ((value & 0x10) == 0x10) {
             /* RAM address 0x00 to 0x0f */
             return read | (REG_PRAM_ADDR + (value & 0x0f));
         }
-- 
2.30.2


