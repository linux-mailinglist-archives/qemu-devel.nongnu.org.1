Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0703796E30
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 02:45:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qe38p-0003MA-5R; Wed, 06 Sep 2023 20:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qe38l-0003BF-Un
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 20:45:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qe38j-0003R8-26
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 20:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694047496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RdbxXNukzek+Y8wiVB7IfwunHPcBxv6sgiSQsY7TUmo=;
 b=hLUIQWOjjFyy+gZ7ITNTvnlH9ViJQ0mCwtW3ReyQ4Xg0FCMuMNMr3YquHANivLOBXLTTcz
 S0mLMdFPPu4JSfhJxHMKZVrXcXfWpWp3rD28SqH/nOI24S0o03KhlqkAeRu7PhPvVh6/lH
 cAhpQShHsX0Tyk6cIH+J61YhWhfjCcU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-XJIBTfNHOD6Dm0uVcLr1fw-1; Wed, 06 Sep 2023 20:44:49 -0400
X-MC-Unique: XJIBTfNHOD6Dm0uVcLr1fw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC5A8181792F;
 Thu,  7 Sep 2023 00:44:46 +0000 (UTC)
Received: from gshan.redhat.com (unknown [10.64.136.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DD4ACC03295;
 Thu,  7 Sep 2023 00:44:31 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, imp@bsdimp.com, kevans@freebsd.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, peter.maydell@linaro.org, b.galvani@gmail.com,
 strahinja.p.jankovic@gmail.com, sundeep.lkml@gmail.com, kfting@nuvoton.com,
 wuhaotsh@google.com, nieklinnenbank@gmail.com, rad@semihalf.com,
 quic_llindhol@quicinc.com, marcin.juszkiewicz@linaro.org,
 laurent@vivier.eu, vijai@behindbytes.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 richard.henderson@linaro.org, mrolnik@gmail.com, edgar.iglesias@gmail.com,
 bcain@quicinc.com, gaosong@loongson.cn, yangxiaojuan@loongson.cn,
 aurelien@aurel32.net, jiaxun.yang@flygoat.com,
 aleksandar.rikalo@syrmia.com, chenhuacai@kernel.org, crwulff@gmail.com,
 marex@denx.de, shorne@gmail.com, clg@kaod.org, david@gibson.dropbear.id.au,
 groug@kaod.org, npiggin@gmail.com, ysato@users.sourceforge.jp,
 david@redhat.com, thuth@redhat.com, iii@linux.ibm.com,
 mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com,
 kbastian@mail.uni-paderborn.de, jcmvbkbc@gmail.com, pbonzini@redhat.com,
 imammedo@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v3 31/32] hw/arm: Check CPU type in machine_run_board_init()
Date: Thu,  7 Sep 2023 10:35:52 +1000
Message-ID: <20230907003553.1636896-32-gshan@redhat.com>
In-Reply-To: <20230907003553.1636896-1-gshan@redhat.com>
References: <20230907003553.1636896-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Set mc->valid_cpu_types so that the user specified CPU type can
be validated in machine_run_board_init(). We needn't to do it by
ourselves.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 hw/arm/bananapi_m2u.c   | 12 ++++++------
 hw/arm/cubieboard.c     | 12 ++++++------
 hw/arm/mps2-tz.c        | 20 ++++++++++++++------
 hw/arm/mps2.c           | 25 +++++++++++++++++++------
 hw/arm/msf2-som.c       | 12 ++++++------
 hw/arm/musca.c          | 13 ++++++-------
 hw/arm/npcm7xx_boards.c | 13 ++++++-------
 hw/arm/orangepi.c       | 12 ++++++------
 8 files changed, 69 insertions(+), 50 deletions(-)

diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
index 74121d8966..2d8551aa67 100644
--- a/hw/arm/bananapi_m2u.c
+++ b/hw/arm/bananapi_m2u.c
@@ -29,6 +29,11 @@
 
 static struct arm_boot_info bpim2u_binfo;
 
+static const char * const valid_cpu_types[] = {
+    ARM_CPU_TYPE_NAME("cortex-a7"),
+    NULL
+};
+
 /*
  * R40 can boot from mmc0 and mmc2, and bpim2u has two mmc interface, one is
  * connected to sdcard and another mount an emmc media.
@@ -70,12 +75,6 @@ static void bpim2u_init(MachineState *machine)
         exit(1);
     }
 
-    /* Only allow Cortex-A7 for this board */
-    if (strcmp(machine->cpu_type, ARM_CPU_TYPE_NAME("cortex-a7")) != 0) {
-        error_report("This board can only be used with cortex-a7 CPU");
-        exit(1);
-    }
-
     r40 = AW_R40(object_new(TYPE_AW_R40));
     object_property_add_child(OBJECT(machine), "soc", OBJECT(r40));
     object_unref(OBJECT(r40));
@@ -138,6 +137,7 @@ static void bpim2u_machine_init(MachineClass *mc)
     mc->max_cpus = AW_R40_NUM_CPUS;
     mc->default_cpus = AW_R40_NUM_CPUS;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a7");
+    mc->valid_cpu_types = valid_cpu_types;
     mc->default_ram_size = 1 * GiB;
     mc->default_ram_id = "bpim2u.ram";
 }
diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index 8c7fa91529..f77fd5fe6c 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -28,6 +28,11 @@ static struct arm_boot_info cubieboard_binfo = {
     .board_id = 0x1008,
 };
 
+static const char * const valid_cpu_types[] = {
+    ARM_CPU_TYPE_NAME("cortex-a8"),
+    NULL
+};
+
 static void cubieboard_init(MachineState *machine)
 {
     AwA10State *a10;
@@ -51,12 +56,6 @@ static void cubieboard_init(MachineState *machine)
         exit(1);
     }
 
-    /* Only allow Cortex-A8 for this board */
-    if (strcmp(machine->cpu_type, ARM_CPU_TYPE_NAME("cortex-a8")) != 0) {
-        error_report("This board can only be used with cortex-a8 CPU");
-        exit(1);
-    }
-
     a10 = AW_A10(object_new(TYPE_AW_A10));
     object_property_add_child(OBJECT(machine), "soc", OBJECT(a10));
     object_unref(OBJECT(a10));
@@ -115,6 +114,7 @@ static void cubieboard_machine_init(MachineClass *mc)
 {
     mc->desc = "cubietech cubieboard (Cortex-A8)";
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a8");
+    mc->valid_cpu_types = valid_cpu_types;
     mc->default_ram_size = 1 * GiB;
     mc->init = cubieboard_init;
     mc->block_default_type = IF_IDE;
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index eae3639da2..d7bb6d965f 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -190,6 +190,16 @@ OBJECT_DECLARE_TYPE(MPS2TZMachineState, MPS2TZMachineClass, MPS2TZ_MACHINE)
 /* For cpu{0,1}_mpu_{ns,s}, means "leave at SSE's default value" */
 #define MPU_REGION_DEFAULT UINT32_MAX
 
+static const char * const valid_cpu_types[] = {
+    ARM_CPU_TYPE_NAME("cortex-m33"),
+    NULL
+};
+
+static const char * const mps3tz_an547_valid_cpu_types[] = {
+    ARM_CPU_TYPE_NAME("cortex-m55"),
+    NULL
+};
+
 static const uint32_t an505_oscclk[] = {
     40000000,
     24580000,
@@ -809,12 +819,6 @@ static void mps2tz_common_init(MachineState *machine)
     int num_ppcs;
     int i;
 
-    if (strcmp(machine->cpu_type, mc->default_cpu_type) != 0) {
-        error_report("This board can only be used with CPU %s",
-                     mc->default_cpu_type);
-        exit(1);
-    }
-
     if (machine->ram_size != mc->default_ram_size) {
         char *sz = size_to_str(mc->default_ram_size);
         error_report("Invalid RAM size, should be %s", sz);
@@ -1321,6 +1325,7 @@ static void mps2tz_an505_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = mc->default_cpus;
     mmc->fpga_type = FPGA_AN505;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m33");
+    mc->valid_cpu_types = valid_cpu_types;
     mmc->scc_id = 0x41045050;
     mmc->sysclk_frq = 20 * 1000 * 1000; /* 20MHz */
     mmc->apb_periph_frq = mmc->sysclk_frq;
@@ -1350,6 +1355,7 @@ static void mps2tz_an521_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = mc->default_cpus;
     mmc->fpga_type = FPGA_AN521;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m33");
+    mc->valid_cpu_types = valid_cpu_types;
     mmc->scc_id = 0x41045210;
     mmc->sysclk_frq = 20 * 1000 * 1000; /* 20MHz */
     mmc->apb_periph_frq = mmc->sysclk_frq;
@@ -1379,6 +1385,7 @@ static void mps3tz_an524_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = mc->default_cpus;
     mmc->fpga_type = FPGA_AN524;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m33");
+    mc->valid_cpu_types = valid_cpu_types;
     mmc->scc_id = 0x41045240;
     mmc->sysclk_frq = 32 * 1000 * 1000; /* 32MHz */
     mmc->apb_periph_frq = mmc->sysclk_frq;
@@ -1413,6 +1420,7 @@ static void mps3tz_an547_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = mc->default_cpus;
     mmc->fpga_type = FPGA_AN547;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m55");
+    mc->valid_cpu_types = mps3tz_an547_valid_cpu_types;
     mmc->scc_id = 0x41055470;
     mmc->sysclk_frq = 32 * 1000 * 1000; /* 32MHz */
     mmc->apb_periph_frq = 25 * 1000 * 1000; /* 25MHz */
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index d92fd60684..691b0803cf 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -110,6 +110,21 @@ OBJECT_DECLARE_TYPE(MPS2MachineState, MPS2MachineClass, MPS2_MACHINE)
  */
 #define REFCLK_FRQ (1 * 1000 * 1000)
 
+static const char * const valid_cpu_types[] = {
+    ARM_CPU_TYPE_NAME("cortex-m3"),
+    NULL
+};
+
+static const char * const mps2_an386_valid_cpu_types[] = {
+    ARM_CPU_TYPE_NAME("cortex-m4"),
+    NULL
+};
+
+static const char * const mps2_an500_valid_cpu_types[] = {
+    ARM_CPU_TYPE_NAME("cortex-m7"),
+    NULL
+};
+
 /* Initialize the auxiliary RAM region @mr and map it into
  * the memory map at @base.
  */
@@ -140,12 +155,6 @@ static void mps2_common_init(MachineState *machine)
     DeviceState *armv7m, *sccdev;
     int i;
 
-    if (strcmp(machine->cpu_type, mc->default_cpu_type) != 0) {
-        error_report("This board can only be used with CPU %s",
-                     mc->default_cpu_type);
-        exit(1);
-    }
-
     if (machine->ram_size != mc->default_ram_size) {
         char *sz = size_to_str(mc->default_ram_size);
         error_report("Invalid RAM size, should be %s", sz);
@@ -484,6 +493,7 @@ static void mps2_an385_class_init(ObjectClass *oc, void *data)
     mc->desc = "ARM MPS2 with AN385 FPGA image for Cortex-M3";
     mmc->fpga_type = FPGA_AN385;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m3");
+    mc->valid_cpu_types = valid_cpu_types;
     mmc->scc_id = 0x41043850;
     mmc->psram_base = 0x21000000;
     mmc->ethernet_base = 0x40200000;
@@ -498,6 +508,7 @@ static void mps2_an386_class_init(ObjectClass *oc, void *data)
     mc->desc = "ARM MPS2 with AN386 FPGA image for Cortex-M4";
     mmc->fpga_type = FPGA_AN386;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m4");
+    mc->valid_cpu_types = mps2_an386_valid_cpu_types;
     mmc->scc_id = 0x41043860;
     mmc->psram_base = 0x21000000;
     mmc->ethernet_base = 0x40200000;
@@ -512,6 +523,7 @@ static void mps2_an500_class_init(ObjectClass *oc, void *data)
     mc->desc = "ARM MPS2 with AN500 FPGA image for Cortex-M7";
     mmc->fpga_type = FPGA_AN500;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m7");
+    mc->valid_cpu_types = mps2_an500_valid_cpu_types;
     mmc->scc_id = 0x41045000;
     mmc->psram_base = 0x60000000;
     mmc->ethernet_base = 0xa0000000;
@@ -526,6 +538,7 @@ static void mps2_an511_class_init(ObjectClass *oc, void *data)
     mc->desc = "ARM MPS2 with AN511 DesignStart FPGA image for Cortex-M3";
     mmc->fpga_type = FPGA_AN511;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m3");
+    mc->valid_cpu_types = valid_cpu_types;
     mmc->scc_id = 0x41045110;
     mmc->psram_base = 0x21000000;
     mmc->ethernet_base = 0x40200000;
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index 7b3106c790..470951a006 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -42,6 +42,11 @@
 #define M2S010_ENVM_SIZE      (256 * KiB)
 #define M2S010_ESRAM_SIZE     (64 * KiB)
 
+static const char * const valid_cpu_types[] = {
+    ARM_CPU_TYPE_NAME("cortex-m3"),
+    NULL
+};
+
 static void emcraft_sf2_s2s010_init(MachineState *machine)
 {
     DeviceState *dev;
@@ -55,12 +60,6 @@ static void emcraft_sf2_s2s010_init(MachineState *machine)
     MemoryRegion *ddr = g_new(MemoryRegion, 1);
     Clock *m3clk;
 
-    if (strcmp(machine->cpu_type, mc->default_cpu_type) != 0) {
-        error_report("This board can only be used with CPU %s",
-                     mc->default_cpu_type);
-        exit(1);
-    }
-
     memory_region_init_ram(ddr, NULL, "ddr-ram", DDR_SIZE,
                            &error_fatal);
     memory_region_add_subregion(sysmem, DDR_BASE_ADDRESS, ddr);
@@ -109,6 +108,7 @@ static void emcraft_sf2_machine_init(MachineClass *mc)
     mc->desc = "SmartFusion2 SOM kit from Emcraft (M2S010)";
     mc->init = emcraft_sf2_s2s010_init;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m3");
+    mc->valid_cpu_types = valid_cpu_types;
 }
 
 DEFINE_MACHINE("emcraft-sf2", emcraft_sf2_machine_init)
diff --git a/hw/arm/musca.c b/hw/arm/musca.c
index 6eeee57c9d..9bd78fd531 100644
--- a/hw/arm/musca.c
+++ b/hw/arm/musca.c
@@ -102,6 +102,11 @@ OBJECT_DECLARE_TYPE(MuscaMachineState, MuscaMachineClass, MUSCA_MACHINE)
 /* Slow 32Khz S32KCLK frequency in Hz */
 #define S32KCLK_FRQ (32 * 1000)
 
+static const char * const valid_cpu_types[] = {
+    ARM_CPU_TYPE_NAME("cortex-m33"),
+    NULL
+};
+
 static qemu_irq get_sse_irq_in(MuscaMachineState *mms, int irqno)
 {
     /* Return a qemu_irq which will signal IRQ n to all CPUs in the SSE. */
@@ -355,7 +360,6 @@ static void musca_init(MachineState *machine)
 {
     MuscaMachineState *mms = MUSCA_MACHINE(machine);
     MuscaMachineClass *mmc = MUSCA_MACHINE_GET_CLASS(mms);
-    MachineClass *mc = MACHINE_GET_CLASS(machine);
     MemoryRegion *system_memory = get_system_memory();
     DeviceState *ssedev;
     DeviceState *dev_splitter;
@@ -366,12 +370,6 @@ static void musca_init(MachineState *machine)
     assert(mmc->num_irqs <= MUSCA_NUMIRQ_MAX);
     assert(mmc->num_mpcs <= MUSCA_MPC_MAX);
 
-    if (strcmp(machine->cpu_type, mc->default_cpu_type) != 0) {
-        error_report("This board can only be used with CPU %s",
-                     mc->default_cpu_type);
-        exit(1);
-    }
-
     mms->sysclk = clock_new(OBJECT(machine), "SYSCLK");
     clock_set_hz(mms->sysclk, SYSCLK_FRQ);
     mms->s32kclk = clock_new(OBJECT(machine), "S32KCLK");
@@ -609,6 +607,7 @@ static void musca_class_init(ObjectClass *oc, void *data)
     mc->min_cpus = mc->default_cpus;
     mc->max_cpus = mc->default_cpus;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m33");
+    mc->valid_cpu_types = valid_cpu_types;
     mc->init = musca_init;
 }
 
diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index 2aef579aac..ca37c893b4 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -55,6 +55,11 @@
 
 static const char npcm7xx_default_bootrom[] = "npcm7xx_bootrom.bin";
 
+static const char * const valid_cpu_types[] = {
+    ARM_CPU_TYPE_NAME("cortex-a9"),
+    NULL
+};
+
 static void npcm7xx_load_bootrom(MachineState *machine, NPCM7xxState *soc)
 {
     const char *bios_name = machine->firmware ?: npcm7xx_default_bootrom;
@@ -121,15 +126,8 @@ static NPCM7xxState *npcm7xx_create_soc(MachineState *machine,
                                         uint32_t hw_straps)
 {
     NPCM7xxMachineClass *nmc = NPCM7XX_MACHINE_GET_CLASS(machine);
-    MachineClass *mc = MACHINE_CLASS(nmc);
     Object *obj;
 
-    if (strcmp(machine->cpu_type, mc->default_cpu_type) != 0) {
-        error_report("This board can only be used with %s",
-                     mc->default_cpu_type);
-        exit(1);
-    }
-
     obj = object_new_with_props(nmc->soc_type, OBJECT(machine), "soc",
                                 &error_abort, NULL);
     object_property_set_uint(obj, "power-on-straps", hw_straps, &error_abort);
@@ -469,6 +467,7 @@ static void npcm7xx_machine_class_init(ObjectClass *oc, void *data)
     mc->no_parallel = 1;
     mc->default_ram_id = "ram";
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a9");
+    mc->valid_cpu_types = valid_cpu_types;
 }
 
 /*
diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index 10653361ed..5c6d4538b9 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -28,6 +28,11 @@
 
 static struct arm_boot_info orangepi_binfo;
 
+static const char * const valid_cpu_types[] = {
+    ARM_CPU_TYPE_NAME("cortex-a7"),
+    NULL
+};
+
 static void orangepi_init(MachineState *machine)
 {
     AwH3State *h3;
@@ -48,12 +53,6 @@ static void orangepi_init(MachineState *machine)
         exit(1);
     }
 
-    /* Only allow Cortex-A7 for this board */
-    if (strcmp(machine->cpu_type, ARM_CPU_TYPE_NAME("cortex-a7")) != 0) {
-        error_report("This board can only be used with cortex-a7 CPU");
-        exit(1);
-    }
-
     h3 = AW_H3(object_new(TYPE_AW_H3));
     object_property_add_child(OBJECT(machine), "soc", OBJECT(h3));
     object_unref(OBJECT(h3));
@@ -118,6 +117,7 @@ static void orangepi_machine_init(MachineClass *mc)
     mc->max_cpus = AW_H3_NUM_CPUS;
     mc->default_cpus = AW_H3_NUM_CPUS;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a7");
+    mc->valid_cpu_types = valid_cpu_types;
     mc->default_ram_size = 1 * GiB;
     mc->default_ram_id = "orangepi.ram";
 }
-- 
2.41.0


