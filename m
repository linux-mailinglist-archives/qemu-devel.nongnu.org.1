Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6619970FFB0
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 23:12:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1vlf-0001E8-1K; Wed, 24 May 2023 17:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vlc-0001Df-L5
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:11:32 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vlb-0001yi-5G
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:11:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=adm+eTHhzuXLH0ulibd9BmXFfZhQieMR40WhD6xOhBU=; b=zgeM/RPfIfNtUxdYu0A4NfeQkQ
 knvGaqrR7dumzIhAyImTkFdi95AU+vwzNAYw4liRNiM8rlTRsP4hWcq2xnDLTVh76LFNrGqUZkB1w
 KwwvdIqj/FRME9KtAxA1e2eeifquujXsRDhNOT+MelPMj3tv03EKqdkBNkHPsiJ+nRqHWW77TpNFz
 /pU/D6+cBZ7YLyMnFH5ifucoroWByppnj9gsHbvt/txmuU7NzaiTxZPkm7zODbG0qJW4nW7Cct9zz
 YoISdUJysNu+jpscqXpROhNcbvrHbTpZ/DxpdpFjUw/ADCq6Lt8CUXiU4NM3OQ8CPFYajZMkrh38P
 A9u4RE5lD0JFJMKnrOzoNTQth/1URZNgEr2LNw00GLhrE3fxX99LAb9HSwRCSB7ss6GvlNvqEYiRG
 GTSPnZSTGsbCkFrERjgFxw6b1RP8hr6rwoDhc1SE4MLvkz+/idMBVwzkBfkaer0EFCTqLHHN+Qusm
 4yoY/pNWuRUX6S+s9O7Xj5ILWHPP4oKk3qZS7G8mU3bONJUQcYtx2vvyrkQYl/HOXdrDLkftsJhlz
 1+nANw+cf4bMZDU7B/nT7hgwg2ohlnZkbw6iCf8aET7fIl9hIFqyX8Vieb749OJu6vQvWNH2pwESS
 4/ysuNesBNUvFBj29htjVuEksNmdcgSpVBkgjqdkg=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vlT-0005XR-DF; Wed, 24 May 2023 22:11:27 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 24 May 2023 22:10:38 +0100
Message-Id: <20230524211104.686087-5-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
References: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 04/30] q800: move CPU object into Q800MachineState
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

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/q800.c         | 10 +++++-----
 include/hw/m68k/q800.h |  4 +++-
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 976da06231..ee6175ceb4 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -363,7 +363,7 @@ static uint8_t fake_mac_rom[] = {
 
 static void q800_machine_init(MachineState *machine)
 {
-    M68kCPU *cpu = NULL;
+    Q800MachineState *m = Q800_MACHINE(machine);
     int linux_boot;
     int32_t kernel_size;
     uint64_t elf_entry;
@@ -406,8 +406,8 @@ static void q800_machine_init(MachineState *machine)
     }
 
     /* init CPUs */
-    cpu = M68K_CPU(cpu_create(machine->cpu_type));
-    qemu_register_reset(main_cpu_reset, cpu);
+    m->cpu = M68K_CPU(cpu_create(machine->cpu_type));
+    qemu_register_reset(main_cpu_reset, m->cpu);
 
     /* RAM */
     memory_region_add_subregion(get_system_memory(), 0, machine->ram);
@@ -429,7 +429,7 @@ static void q800_machine_init(MachineState *machine)
 
     /* IRQ Glue */
     glue = qdev_new(TYPE_GLUE);
-    object_property_set_link(OBJECT(glue), "cpu", OBJECT(cpu), &error_abort);
+    object_property_set_link(OBJECT(glue), "cpu", OBJECT(m->cpu), &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(glue), &error_fatal);
 
     /* VIA 1 */
@@ -604,7 +604,7 @@ static void q800_machine_init(MachineState *machine)
 
     macfb_mode = (NUBUS_MACFB(dev)->macfb).mode;
 
-    cs = CPU(cpu);
+    cs = CPU(m->cpu);
     if (linux_boot) {
         uint64_t high;
         void *param_blob, *param_ptr, *param_rng_seed;
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index 560fd6f93d..5867c3ae33 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -29,9 +29,11 @@
 
 struct Q800MachineState {
     MachineState parent_obj;
+
+    M68kCPU *cpu;
 };
 
 #define TYPE_Q800_MACHINE MACHINE_TYPE_NAME("q800")
-OBJECT_DECLARE_SIMPLE_TYPE(Q800MachineState, q800, Q800_MACHINE, MachineState)
+OBJECT_DECLARE_SIMPLE_TYPE(Q800MachineState, Q800_MACHINE)
 
 #endif
-- 
2.30.2


