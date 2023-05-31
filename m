Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 109A6718077
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 14:55:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4LLj-0007EP-8V; Wed, 31 May 2023 08:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LLf-0007D6-BN
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:54:43 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LLd-0006n6-GE
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G1PTh/215G42j3AwR3rcSWj9cXdCIZl1IOqT7+r1HKA=; b=DP3usvGlXDJNMDAX4yARUWjzyO
 dkmC+RSCckpJD3KxOAiasOXtvpw7hOPN0cngTeCf6w8u//Sv+OGoUyiSeV2CfOWiSlmxQNNb2/Jvr
 oAroaClVHpxCyBVtV5Q68yNAMYY3JB11d3SpoQkJjhpTM5EcGRKtqbkffJmgkeMH1ks6wKlQsyCya
 MKlgWjsjIU6/COP8ITcyoEvSHPeX+gTBnvDLZqiPm62jBHTIXUlmH1bfoPQfl894ccX17tktv1NJQ
 4jK3ifVbgd4ODHGh3/s/7HO3jng20UaXNJN2UzICrSK7lWVc22iqaqXHfSOpTBkxPk0ymZe+qZD2+
 UPRhAMPOqaeb1SDEh3BQwmDlV1AFLqIVTuvWuoG0N1jFoBsIuUQKUOoMm8cz7KDLnUw31vTdtmjvx
 g/mVuiBuys4wIIDEKeKg780jQME7Z30uvzFQw511393FsIvA7wNsYsRGWt+/Go0Ht+1Pjxl+tNMAF
 xohCbE2/2Hfnqaq7VgX14dx3eIgTg4pdcBuUk1g8LPBbTb8Nl4P1wVSyWXGx0t3gYctN+ap+OLsl6
 aO6o8mORgSOB0jZUzAfvyUvbbWrQjUuTJConCh4TEmsZqoHOukbzmFxRVAgyEAXtsNMD2+OTAN4lb
 WJ6TqPCxMKisCmnPKdPCSCl1gu2bmhDGDssbnc6YA=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LLT-0008vd-Oq; Wed, 31 May 2023 13:54:35 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 31 May 2023 13:53:42 +0100
Message-Id: <20230531125400.288917-6-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 05/23] q800: move CPU object into Q800MachineState
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

Also change the instantiation of the CPU to use object_initialize_child()
followed by a separate realisation.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/q800.c         | 13 ++++++++-----
 include/hw/m68k/q800.h |  2 ++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 3730b30dd1..c34b2548ca 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -364,7 +364,7 @@ static uint8_t fake_mac_rom[] = {
 
 static void q800_machine_init(MachineState *machine)
 {
-    M68kCPU *cpu = NULL;
+    Q800MachineState *m = Q800_MACHINE(machine);
     int linux_boot;
     int32_t kernel_size;
     uint64_t elf_entry;
@@ -407,8 +407,10 @@ static void q800_machine_init(MachineState *machine)
     }
 
     /* init CPUs */
-    cpu = M68K_CPU(cpu_create(machine->cpu_type));
-    qemu_register_reset(main_cpu_reset, cpu);
+    object_initialize_child(OBJECT(machine), "cpu", &m->cpu,
+                            M68K_CPU_TYPE_NAME("m68040"));
+    object_property_set_bool(OBJECT(&m->cpu), "realized", true, &error_fatal);
+    qemu_register_reset(main_cpu_reset, &m->cpu);
 
     /* RAM */
     memory_region_add_subregion(get_system_memory(), 0, machine->ram);
@@ -430,7 +432,8 @@ static void q800_machine_init(MachineState *machine)
 
     /* IRQ Glue */
     glue = qdev_new(TYPE_GLUE);
-    object_property_set_link(OBJECT(glue), "cpu", OBJECT(cpu), &error_abort);
+    object_property_set_link(OBJECT(glue), "cpu", OBJECT(&m->cpu),
+                             &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(glue), &error_fatal);
 
     /* VIA 1 */
@@ -605,7 +608,7 @@ static void q800_machine_init(MachineState *machine)
 
     macfb_mode = (NUBUS_MACFB(dev)->macfb).mode;
 
-    cs = CPU(cpu);
+    cs = CPU(&m->cpu);
     if (linux_boot) {
         uint64_t high;
         void *param_blob, *param_ptr, *param_rng_seed;
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index 76ea6560b2..0f54f1c2cf 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -29,6 +29,8 @@
 
 struct Q800MachineState {
     MachineState parent_obj;
+
+    M68kCPU cpu;
 };
 
 #define TYPE_Q800_MACHINE MACHINE_TYPE_NAME("q800")
-- 
2.30.2


