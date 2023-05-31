Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAE371806E
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 14:55:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4LLi-0007Dv-0I; Wed, 31 May 2023 08:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LLc-0007BU-Sw
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:54:41 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LLa-0006mc-Rw
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=L/oNTY3b8TUVy638ADdD2WSFfGo4JzvoXYfBpNyyMeU=; b=UQ+1VkvVf+87fr740MqHnZPCNM
 OkXZISeGuc+a7bpx2LnnhwEMMe0L7/8ZHmY2dCG30VQNxJwM0gllva138Ys4eJFQEaKhTJy0E4bWj
 NZCUd3yEE2GMpZDdm6W3tEDZQOUZSyRqRhvFrj2/t17AedMA1bUgON/efzL3T/p57XO2O8RnhOL73
 96cUK6RWNztDBDxvlhSchsrK3msVXZkqYaCyHDbPRlNVNhxWXVFOhNPfvOJpZbfHWesVMOYx7r+pW
 wxFVfaTkSTHwNiY71fqMlosKkMOrSvf/vrMwYNChr4LUgrh2VQmDi31ku7JbXeLSeb5XBMUsOH6a7
 ei6y9nBndaPInMzdZWBiiTUdjVjcS7zVe8dkyD3c8bFiavKB4l3fKzH5s2DXDj4sILbwAmZ+LFDvr
 wdWZew9GPU0c7jdGXI9X4QWNzLcgt2EcLi6lvWgNoyBgq6CMRvhzWqK/goqwVh1rw9jo0GpK2V1IC
 EU6Parfsl3tOYBB82OZ3AQ6GKVyq4THnUoXwiOfxrou0MrfuBWjbmetQDAyB+q0Cje846kaSRdTfM
 G4sluv9xiBB5Xlk4fKfJk9g2rnPgrYVXH3AojD4S+FH/79fqIcoDd7UkjRPIp+9vIIoBNJvtieGNC
 7ijkoCW8lMAeHnC5NZCo72SRSrYac/M+zrzay8gNY=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LLP-0008vd-Hu; Wed, 31 May 2023 13:54:31 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 31 May 2023 13:53:41 +0100
Message-Id: <20230531125400.288917-5-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 04/23] q800: rename q800_init() to q800_machine_init()
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


