Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC9E737DE9
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 10:57:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBtbb-0001vq-8o; Wed, 21 Jun 2023 04:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtbZ-0001vi-H3
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:54:21 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtbY-0003cT-0L
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nmM/4gzs4L7qGQ7k4E+4KvRFO3wMFBE9VaIv9LgbDF8=; b=J8zt9WKC/gSFIMogBji2c8BJv+
 bwpMePdILzE5E1OL+EpGMjlKrFRQavr9LXsHAetkRGSuNX9vXdinpBsRwqmm+s5KEck46/cBeMjgf
 ciLkV29m9Q2BtpZdtV4827RCJeRhi2GWQuz85azxxy1J9NXkF7GBSa371UC1FkItTGuJdTW0cFr/L
 s0miHRMgMky9RZWYqWR4N9+hzNnrOstSqUaj2tU0/p9XdJNQvEUIe9xT2s3OTjy/YctokJuPSqlvn
 kvzyyVINNbvA3LE7tal2GviCyVmE0BuSxQmOUbVEd2q4EKjOPkbjnFiqH5zcqutOsQkZtyHw3Pfk4
 Nyrt84cIzC7xYxiKZnxNwvawymwmB8MWXdCjIREeKJlWYQQWiQxifsDXIkgAD6swBoNu32vvIE65q
 cHpEKdH1Tzm7juugcR0JDQ5siu9PmpHwuOx1YLAosnIlTcVmA71pWYo+24FCRsDjHkqX0QysvBtKj
 WXqAeQx5bXcLgrnfuXBqqD3OH4LXPurnLjGQG/ToEB6GfW8TweTcypt4ZCqsTZior7hlmkhNF00ns
 iYcHkyubQE4KVC+6ouhOJ7JZDV0nYhA+5Gx3jY63Fd5+iv7/E3rKmIT/Uj7wwj7C/uXrRr7LtW0x6
 JGJdSHUWKCtpCs9kccaG1jlM6Bd+L5V+s83tp/gNE=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtbM-0001ZB-Hk; Wed, 21 Jun 2023 09:54:12 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 21 Jun 2023 09:53:33 +0100
Message-Id: <20230621085353.113233-5-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
References: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 04/24] q800: rename q800_init() to q800_machine_init()
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

This will enable us later to distinguish between QOM initialisation and machine
initialisation.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/m68k/q800.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index c0256c8a90..062a3c6c76 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -362,7 +362,7 @@ static uint8_t fake_mac_rom[] = {
     0x60, 0xFE                          /* bras [self] */
 };
 
-static void q800_init(MachineState *machine)
+static void q800_machine_init(MachineState *machine)
 {
     M68kCPU *cpu = NULL;
     int linux_boot;
@@ -738,8 +738,9 @@ static const size_t hw_compat_q800_len = G_N_ELEMENTS(hw_compat_q800);
 static void q800_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "Macintosh Quadra 800";
-    mc->init = q800_init;
+    mc->init = q800_machine_init;
     mc->default_cpu_type = M68K_CPU_TYPE_NAME("m68040");
     mc->max_cpus = 1;
     mc->block_default_type = IF_SCSI;
-- 
2.30.2


