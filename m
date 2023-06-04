Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6240F72174B
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 15:17:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5nZn-0004wU-Ep; Sun, 04 Jun 2023 09:15:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5nZh-0004wF-Gp
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 09:15:13 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5nZf-0003BF-Ns
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 09:15:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KJoFUtJkX0Pp6ysiE37fPcjZrz3Q6qAu63rzfHq7wcM=; b=Rn7XyWe4VqZXFBA7yHIhmuxNob
 HwsBfVeQYQFk4Eu/8PXme01tvPyZrS/YkGBjbPEVCGIbldvWG4uJRtZ3Ih3bAr5wRHxnypqgmGUFZ
 2zKSgaLmBmxrOKgp7ixJdw0aEKkTZabZBXOxZ8kJc5ozW8BimhB4t/gxhot6pYHxCHEVacnHXaAv+
 gvCW2h0453WkuccSYbOrv3HdhfSq5Geyk1fagJ64in7GXz6ZO7bWS/8ZGZ7XCIhxZV/nqlAaTSVbp
 qqJSDbWad9RuUm1F9hqPqbF15UrmZCIOxT6ox8AKeAtLRajmbiF1nPw1h9V1vITxx5DEu/DyKDTpZ
 vm3e0uws+yvGPA8JHKOD5qc/bD9JAasRWaUkE7IcaB5qRj0EyWu6GW6JYBy5Tw6WagZu6sUqeFfrU
 jnPovM0bDeAIQJiS7LsnXoBwdXxWFpcZJy+MEtfr5nXWSq6Q/3ZhTq8sYQjF22ICRHdnavXmKBEty
 jMH7ihxx289PXIlBivjlgCis03EZjfbqnibEEVqD6mZZT4EZOb2BZO9VSFpE+44l0WzSL/TvZqD5f
 qUgr9zNkCC0xKS3FX9c6w33z0GQIfbG3y0MwW4lUg84CLow6uyXE3z1aynMYFOb3ZlOjiL+MVC3PR
 bGxFArz7fRjsYpgMbY0orFQcJDXvIJH3++/ByMZsY=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5nZU-0005pb-Mk; Sun, 04 Jun 2023 14:15:04 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Sun,  4 Jun 2023 14:14:31 +0100
Message-Id: <20230604131450.428797-5-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230604131450.428797-1-mark.cave-ayland@ilande.co.uk>
References: <20230604131450.428797-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 04/23] q800: rename q800_init() to q800_machine_init()
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
index 93a3f96991..3730b30dd1 100644
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


