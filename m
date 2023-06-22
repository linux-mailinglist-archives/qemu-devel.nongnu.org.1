Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A23F7398B4
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 09:58:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCFAj-00047X-Mb; Thu, 22 Jun 2023 03:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAf-00040S-2H
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:56:01 -0400
Received: from mout.kundenserver.de ([212.227.126.133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAY-0002rO-90
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:55:58 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1M8hlZ-1q7YLD3B8D-004hYV; Thu, 22
 Jun 2023 09:55:46 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/24] q800: fix up minor spacing issues in hw_compat_q800
 GlobalProperty array
Date: Thu, 22 Jun 2023 09:55:21 +0200
Message-Id: <20230622075544.210899-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622075544.210899-1-laurent@vivier.eu>
References: <20230622075544.210899-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:oGnDNRk7z5rEwHHbUeu1Ly5s+5yURUSa4tum0ZFJUAxfUD2rxGX
 wjwu0Cm0yMAQSKiyWwmkkzHXULiOpfMNnu3RWpDfb6ob4IlTsgGlfgbsBPmepphfi/+OZhu
 YgO15e+6EWWRrhj25ElimEy5LQrd5Yi5bGeDkj8v/uyIuuT7KzWjBEE2ByW987EZpTW0t+H
 uVcOo3OQkCilEdTTPvlfg==
UI-OutboundReport: notjunk:1;M01:P0:K3zxL/9EqL4=;N85fwa4YgdarS8XGK+Vlq/sIyEt
 o8q3/YxHYSYrs7+rClhYUiLHrrtAEc68JPtXkPloVxCJKkRKKzmIvzsvaEoG+i3t1DIPjTDc4
 d7PT1CH+U5TPo1eKrn5j/6ljwFvCDFocnBNTNdgV7Gkf3KC2YIMupwlshBFsF1DE7XjjsZiDC
 MFFRM3YKpi52695Fr9Cqs1Td/o1hO7TtZxEBhPoN5l7BkML5FLgwX51VhKdyZwOsqILZgYlAu
 HRb8hZ37AKa1AtBJlhABr6KdiocCzAXFEpTFijIAk0wRevzBF3++18XHEasSCvmh9IUv8/ljj
 6OrYpfInk4/hchB9eKOfrFecnekkKe41zlSZzY1eXprydg3gR6bCGcZ1V0oWIobF+Hd9Ltvrj
 MSQHIf7H9VG0ljUWtW18M0u2eoYnMNijKZSZkTU6vxqgUH2G79QyiAQWasNVXtwsqFWXCKrJQ
 Y5ifQONDkgrl27USKDzB/Da04GQ0CA/lNx3dzDwCDrb4fuDRqBqhtOuh4zPlvU5dIarmrhKoT
 7yXFsTVNgKedpReCApPFt5IgJJitLy5A5mtzY+4QFX04LimdL5lXqVKzQBqaxAJQH+e0HjTXL
 TjBZMwN3N2xX/Hu1dvK6M1sz8IkPiBDLf4RjzCtxXklSB5n8SlTQmMiZZuG945717y/uCDgdQ
 x7QTAJjBpoQNYsAqvkdBhldt3qyyrroD70aAbJ3QXw==
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Ensure there is a space before the final closing brace for all global
properties.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230621085353.113233-2-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/m68k/q800.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 68f0cd8cac2e..dda57c60bfd9 100644
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
2.40.1


