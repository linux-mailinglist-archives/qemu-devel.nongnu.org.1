Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2F271806D
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 14:55:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4LLa-00079f-TA; Wed, 31 May 2023 08:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LLP-00078c-Me
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:54:27 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LLM-0006ky-LL
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GOf7442ERRUcuG7WwB0WdO9q4oKqttnofVihpPsZqIU=; b=00KvasedDtQ7VV2mdnpMFyIzEY
 3O04MLOz1djqlja4k8Wus4DWltarFkGTgUaB8n+75ym+DnAsumhIPomUl+jM9Cwftkd1fReQJRnlA
 as465gcowZt2qAdZQ+wZBbu0Q49xRNjAzayIDYqBRox8O8bq7OsF550Dq+VoUYkjLng0TZmF1nm9k
 k/0/bnYlG/SYwiOayop+W8PJjCLimAQnAW8NwB5Vi1FJi0L8hujW+dyDGLdWeIWtZ4/R1XTl+apgT
 cQZfjWw082aGoYxfikp3EDYYUYzgL6GMG1KwRHNMGPBtZDuehjnoKIypYv1PxJmaLeqW6A7AesuXi
 WoC6ylTYiMND6AhPKoaUD+LFtooY9VhRqHbjixVnaNN1DSygnZ13fMqfJ+cxiFwQhJs45WVYbalZg
 GMN9En9pH2reuTPFO+AIennf+FaD7jTNf8oG+RAAqvbuWd2GxfG2K9qY/O8Su0jq9c9XiJ5IRS1Va
 VsUAFE+k6ydDkjLj0dIhpvUo+vFFii/rcnwpVSGnaQHfYcSFSIaxHdGMwv9GcKhqr9XUO9B9hhF8i
 LEJjF/NFcHTJIaEOqgfQt++jxhdt6/zHwKGRF6VshEb2Ez1iCgd4LDrExtxPyddKt6Syal2kOlKyx
 RPpPlbqC+NLXbI9NwXEY51LFW3dkeeREPv0DpJDao=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LLC-0008vd-Qd; Wed, 31 May 2023 13:54:18 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 31 May 2023 13:53:38 +0100
Message-Id: <20230531125400.288917-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 01/23] q800: fix up minor spacing issues in hw_compat_q800
 GlobalProperty array
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

Ensure there is a space before the final closing brace for all global
properties.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/m68k/q800.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index b35ecafbc7..1aead224e2 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -719,14 +719,14 @@ static void q800_init(MachineState *machine)
 }
 
 static GlobalProperty hw_compat_q800[] = {
-    { "scsi-hd", "quirk_mode_page_vendor_specific_apple", "on"},
+    { "scsi-hd", "quirk_mode_page_vendor_specific_apple", "on" },
     { "scsi-hd", "vendor", " SEAGATE" },
     { "scsi-hd", "product", "          ST225N" },
     { "scsi-hd", "ver", "1.0 " },
-    { "scsi-cd", "quirk_mode_page_apple_vendor", "on"},
-    { "scsi-cd", "quirk_mode_sense_rom_use_dbd", "on"},
-    { "scsi-cd", "quirk_mode_page_vendor_specific_apple", "on"},
-    { "scsi-cd", "quirk_mode_page_truncated", "on"},
+    { "scsi-cd", "quirk_mode_page_apple_vendor", "on" },
+    { "scsi-cd", "quirk_mode_sense_rom_use_dbd", "on" },
+    { "scsi-cd", "quirk_mode_page_vendor_specific_apple", "on" },
+    { "scsi-cd", "quirk_mode_page_truncated", "on" },
     { "scsi-cd", "vendor", "MATSHITA" },
     { "scsi-cd", "product", "CD-ROM CR-8005" },
     { "scsi-cd", "ver", "1.0k" },
-- 
2.30.2


