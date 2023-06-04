Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA5C721742
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 15:16:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5nZn-0004wT-Em; Sun, 04 Jun 2023 09:15:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5nZf-0004vY-OR
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 09:15:11 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5nZX-0002xq-0q
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 09:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YH3u+lBKxTGmU9U2PS6xpkAsnUA2aD2sNi6w+PFhK3U=; b=BMf9mi+Rmh/ZpQPTfLfogANcDC
 +Fi2OMgKtXGX4MA8jU+0dmLKNuhao2YHReurYOHjYMeX8tImad8um7le8dFD2UFhl14HCAZg/ZhuD
 FnchpWzb1ZrKs9f7UlGcHZpKSCmV+aQy5yPFnU5GvdNcM4N20Z9WMAjBoCkAktb9qJNj/fMXerg1c
 wM9a1FxppmRsd8SjZdIUhL4OdHdCIXWlwGXWzf9b4fPbra7V3GKy5hXJjdKklsp3xPh2QV5CWgAs6
 iezyndsiGSVgDn7NaD0J4a4twePadRf+Mk3/giE1BZbeT7d8pprBW/RaeONgwNNcrejcQ8RPeUnua
 +BRUMLBUP5la9gkW0DxpJTO5jtLLprNC6Hpbh/fCwhnhp2H24oAYS44/TrQCXUUW9dxxt/QaMPX9B
 j8evgItmernKzGW69sfQmtiEZt2MZtJ4qFQtzYWsPq7GE1Iy2nzQ/32s9GTbkzAnKp9+/wfS+9/Yi
 z5gq5/C35YvhNMtbcTszWN6pmR6ZZ+hI2qCZ/kqrVxL6YnzJ00itwWRh0yRIg76NJWeb2WXu8eHzC
 i6iMZQtaOf1OrRUdq5bB5AoJhFjun6qER+WsMPKW3emaCJRVr7IzFgbgDN6Onskndkojv6NmsfFdG
 oDF363gDSDeqwuLwWwU/D5YG737aaAfPKHTrEzDGw=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5nZL-0005pb-VG; Sun, 04 Jun 2023 14:14:56 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Sun,  4 Jun 2023 14:14:28 +0100
Message-Id: <20230604131450.428797-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230604131450.428797-1-mark.cave-ayland@ilande.co.uk>
References: <20230604131450.428797-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 01/23] q800: fix up minor spacing issues in hw_compat_q800
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


