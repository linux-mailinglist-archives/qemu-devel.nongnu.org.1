Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCC470FFBB
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 23:13:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1vlb-0001Dc-Eu; Wed, 24 May 2023 17:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vlY-0001Cy-Lb
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:11:28 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vlX-0001xh-3e
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:11:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zJXbXBIFRyKxZRHU1YwZtLM7uzSs0hYuUBhKs+2crCc=; b=BXrqe5kn9TuuMnYTUemdS3gG8W
 lx7UGkSrwq43z/urP4TP4Ged6GsuQjCKQq6/Vc7VcvMTcJ5SJpHjOGVrC1OcJtlVVvvykeHbtEGZo
 quHxFL+HTgenKAxp/Ac/B/0yW8CjnDDvn4pJ4T1WmZZLwoeZMCApiOtTncukrF22vviF5TOuk7vfN
 oq1ixsnQ2Ruk2rfzFovpgb4m80HvZCCt/WYdDg15dZiqIablYJw1a7MiEFaDBPkq7JwUV3O9DG1Ch
 qZbTh6q+pW2mauGR6GwwNgf3kWe/Hxvh2mdBLtfu5lMuONl7SS5/F1xJB5fH/rH2EJiYZlo8A+Pt3
 ndqfl+yyFnXedA4sHRKaMc+EVd+RTvfgfz2GNtPwCNByIwysGsL9xuUVo6zh+YrklOVcysSXaiPQh
 hcH6e/CpIupf3nXLL922UJZoHnuPP69H1qSUcxNcx7fzAuF+DvEupnuT4bMkaR/fbR6HSHJ5uCVdA
 Ptnh2AL1uq5LtLE0D1VhSVmvi1NOck+GsP1G8duY5LbB/ajNVxVP3ENPwL0+7OwWdeHlOaUCpph5z
 FQCyd2scrTkx+7zMXS8Sz6fqmezspZpn523VSRYHCUCdOcdqOYJQ/3wQatI46KxA85ACFcauo/c1h
 +6EkugJRQ3jXAOxGfUy+0M5UcunZ73W/xfLUJHI3w=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vlP-0005XR-8I; Wed, 24 May 2023 22:11:23 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 24 May 2023 22:10:37 +0100
Message-Id: <20230524211104.686087-4-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
References: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 03/30] q800: rename q800_init() to q800_machine_init()
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
---
 hw/m68k/q800.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index bdccd93c7f..976da06231 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -361,7 +361,7 @@ static uint8_t fake_mac_rom[] = {
     0x60, 0xFE                          /* bras [self] */
 };
 
-static void q800_init(MachineState *machine)
+static void q800_machine_init(MachineState *machine)
 {
     M68kCPU *cpu = NULL;
     int linux_boot;
@@ -737,8 +737,9 @@ static const size_t hw_compat_q800_len = G_N_ELEMENTS(hw_compat_q800);
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


