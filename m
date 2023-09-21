Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FEF7A92A6
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 10:37:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjFAf-00074A-E3; Thu, 21 Sep 2023 04:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qjF9t-00067C-Qw; Thu, 21 Sep 2023 04:35:39 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qjF9o-0001JD-FM; Thu, 21 Sep 2023 04:35:36 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 965FF23DAA;
 Thu, 21 Sep 2023 11:35:34 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 438F329A04;
 Thu, 21 Sep 2023 11:35:13 +0300 (MSK)
Received: (nullmailer pid 509103 invoked by uid 1000);
 Thu, 21 Sep 2023 08:35:11 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 07/17] hw/other: spelling fixes
Date: Thu, 21 Sep 2023 11:34:56 +0300
Message-Id: <20230921083506.509032-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230921083506.509032-1-mjt@tls.msk.ru>
References: <20230921083506.509032-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/acpi/aml-build.c              |  6 +++---
 hw/acpi/hmat.c                   |  2 +-
 hw/acpi/nvdimm.c                 |  2 +-
 hw/block/hd-geometry.c           |  4 ++--
 hw/block/pflash_cfi01.c          |  2 +-
 hw/char/cadence_uart.c           |  2 +-
 hw/char/imx_serial.c             |  2 +-
 hw/char/serial.c                 |  2 +-
 hw/core/generic-loader.c         |  4 ++--
 hw/core/machine.c                |  2 +-
 hw/core/qdev-properties-system.c |  2 +-
 hw/cpu/a15mpcore.c               |  2 +-
 hw/cxl/cxl-events.c              |  2 +-
 hw/cxl/cxl-mailbox-utils.c       |  4 ++--
 hw/dma/omap_dma.c                |  4 ++--
 hw/input/hid.c                   |  2 +-
 hw/input/tsc2005.c               | 16 ++++++++--------
 hw/intc/loongarch_extioi.c       |  2 +-
 hw/intc/loongson_liointc.c       |  2 +-
 hw/intc/omap_intc.c              |  2 +-
 hw/intc/pnv_xive.c               |  2 +-
 hw/intc/spapr_xive.c             |  2 +-
 hw/intc/spapr_xive_kvm.c         |  6 +++---
 hw/intc/xive.c                   |  2 +-
 hw/intc/xive2.c                  |  6 +++---
 hw/ipmi/ipmi_bmc_extern.c        |  2 +-
 hw/mem/cxl_type3.c               |  6 +++---
 hw/misc/imx7_ccm.c               |  2 +-
 hw/misc/mac_via.c                |  2 +-
 hw/misc/stm32f2xx_syscfg.c       |  4 ++--
 hw/misc/trace-events             |  2 +-
 hw/misc/zynq_slcr.c              |  2 +-
 hw/nvme/ctrl.c                   |  6 +++---
 hw/nvram/eeprom_at24c.c          |  2 +-
 hw/nvram/fw_cfg.c                |  2 +-
 hw/rtc/exynos4210_rtc.c          |  2 +-
 hw/rx/rx62n.c                    |  2 +-
 hw/scsi/lsi53c895a.c             |  2 +-
 hw/scsi/mfi.h                    |  2 +-
 hw/sh4/sh7750_regs.h             | 26 +++++++++++++-------------
 hw/smbios/smbios.c               |  2 +-
 hw/ssi/xilinx_spips.c            |  6 +++---
 hw/ssi/xlnx-versal-ospi.c        |  2 +-
 hw/timer/etraxfs_timer.c         |  2 +-
 hw/timer/renesas_tmr.c           |  2 +-
 hw/virtio/virtio-crypto.c        |  4 ++--
 hw/virtio/virtio-mem.c           |  2 +-
 hw/virtio/virtio.c               |  2 +-
 48 files changed, 85 insertions(+), 85 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index ea331a20d1..af66bde0f5 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -312,7 +312,7 @@ build_prepend_package_length(GArray *package, unsigned length, bool incl_self)
         /*
          * PkgLength is the length of the inclusive length of the data
          * and PkgLength's length itself when used for terms with
-         * explitit length.
+         * explicit length.
          */
         length += length_bytes;
     }
@@ -680,7 +680,7 @@ Aml *aml_store(Aml *val, Aml *target)
  *   "Op Operand Operand Target"
  * pattern.
  *
- * Returns: The newly allocated and composed according to patter Aml object.
+ * Returns: The newly allocated and composed according to pattern Aml object.
  */
 static Aml *
 build_opcode_2arg_dst(uint8_t op, Aml *arg1, Aml *arg2, Aml *dst)
@@ -2159,7 +2159,7 @@ void build_fadt(GArray *tbl, BIOSLinker *linker, const AcpiFadtData *f,
         /* FADT Minor Version */
         build_append_int_noprefix(tbl, f->minor_ver, 1);
     } else {
-        build_append_int_noprefix(tbl, 0, 3); /* Reserved upto ACPI 5.0 */
+        build_append_int_noprefix(tbl, 0, 3); /* Reserved up to ACPI 5.0 */
     }
     build_append_int_noprefix(tbl, 0, 8); /* X_FIRMWARE_CTRL */
 
diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
index 3a6d51282a..2d5e199ba9 100644
--- a/hw/acpi/hmat.c
+++ b/hw/acpi/hmat.c
@@ -82,7 +82,7 @@ static void build_hmat_lb(GArray *table_data, HMAT_LB_Info *hmat_lb,
     uint32_t base;
     /* Length in bytes for entire structure */
     uint32_t lb_length
-        = 32 /* Table length upto and including Entry Base Unit */
+        = 32 /* Table length up to and including Entry Base Unit */
         + 4 * num_initiator /* Initiator Proximity Domain List */
         + 4 * num_target /* Target Proximity Domain List */
         + 2 * num_initiator * num_target; /* Latency or Bandwidth Entries */
diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 3cbd41629d..9ba90806f2 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -1102,7 +1102,7 @@ static void nvdimm_build_common_dsm(Aml *dev,
      * be treated as an integer. Moreover, the integer size depends on
      * DSDT tables revision number. If revision number is < 2, integer
      * size is 32 bits, otherwise it is 64 bits.
-     * Because of this CreateField() canot be used if RLEN < Integer Size.
+     * Because of this CreateField() cannot be used if RLEN < Integer Size.
      *
      * Also please note that APCI ASL operator SizeOf() doesn't support
      * Integer and there isn't any other way to figure out the Integer
diff --git a/hw/block/hd-geometry.c b/hw/block/hd-geometry.c
index dae13ab14d..2b0af4430f 100644
--- a/hw/block/hd-geometry.c
+++ b/hw/block/hd-geometry.c
@@ -50,7 +50,7 @@ struct partition {
         uint32_t nr_sects;          /* nr of sectors in partition */
 } QEMU_PACKED;
 
-/* try to guess the disk logical geometry from the MSDOS partition table.
+/* try to guess the disk logical geometry from the MS-DOS partition table.
    Return 0 if OK, -1 if could not guess */
 static int guess_disk_lchs(BlockBackend *blk,
                            int *pcylinders, int *pheads, int *psectors)
@@ -66,7 +66,7 @@ static int guess_disk_lchs(BlockBackend *blk,
     if (blk_pread(blk, 0, BDRV_SECTOR_SIZE, buf, 0) < 0) {
         return -1;
     }
-    /* test msdos magic */
+    /* test MS-DOS magic */
     if (buf[510] != 0x55 || buf[511] != 0xaa) {
         return -1;
     }
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 3c066e3405..62056b1d74 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -891,7 +891,7 @@ static Property pflash_cfi01_properties[] = {
     /* num-blocks is the number of blocks actually visible to the guest,
      * ie the total size of the device divided by the sector length.
      * If we're emulating flash devices wired in parallel the actual
-     * number of blocks per indvidual device will differ.
+     * number of blocks per individual device will differ.
      */
     DEFINE_PROP_UINT32("num-blocks", PFlashCFI01, nb_blocs, 0),
     DEFINE_PROP_UINT64("sector-length", PFlashCFI01, sector_len, 0),
diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index eff0304a18..a2ac062b1e 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -575,7 +575,7 @@ static int cadence_uart_pre_load(void *opaque)
 {
     CadenceUARTState *s = opaque;
 
-    /* the frequency will be overriden if the refclk field is present */
+    /* the frequency will be overridden if the refclk field is present */
     clock_set_hz(s->refclk, UART_DEFAULT_REF_CLK);
     return 0;
 }
diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index 1b75a89588..377d1d9773 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -112,7 +112,7 @@ static void imx_serial_reset_at_boot(DeviceState *dev)
     imx_serial_reset(s);
 
     /*
-     * enable the uart on boot, so messages from the linux decompresser
+     * enable the uart on boot, so messages from the linux decompressor
      * are visible.  On real hardware this is done by the boot rom
      * before anything else is loaded.
      */
diff --git a/hw/char/serial.c b/hw/char/serial.c
index f3094f860f..a32eb25f58 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -54,7 +54,7 @@
 #define UART_IIR_RLSI   0x06    /* Receiver line status interrupt */
 #define UART_IIR_CTI    0x0C    /* Character Timeout Indication */
 
-#define UART_IIR_FENF   0x80    /* Fifo enabled, but not functionning */
+#define UART_IIR_FENF   0x80    /* Fifo enabled, but not functioning */
 #define UART_IIR_FE     0xC0    /* Fifo enabled */
 
 /*
diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index 4f4d77908d..d4b5c501d8 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -24,7 +24,7 @@
  * callback that does the memory operations.
 
  * This device allows the user to monkey patch memory. To be able to do
- * this it needs a backend to manage the datas, the same as other
+ * this it needs a backend to manage the data, the same as other
  * memory-related devices. In this case as the backend is so trivial we
  * have merged it with the frontend instead of creating and maintaining a
  * separate backend.
@@ -166,7 +166,7 @@ static void generic_loader_realize(DeviceState *dev, Error **errp)
         }
     }
 
-    /* Convert the data endiannes */
+    /* Convert the data endianness */
     if (s->data_be) {
         s->data = cpu_to_be64(s->data);
     } else {
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 59208e611e..cb38b8cf4c 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1426,7 +1426,7 @@ void machine_run_board_init(MachineState *machine, const char *mem_path, Error *
         for (i = 0; machine_class->valid_cpu_types[i]; i++) {
             if (object_class_dynamic_cast(oc,
                                           machine_class->valid_cpu_types[i])) {
-                /* The user specificed CPU is in the valid field, we are
+                /* The user specified CPU is in the valid field, we are
                  * good to go.
                  */
                 break;
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 6d5d43eda2..41b7e682c7 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -107,7 +107,7 @@ static void set_drive_helper(Object *obj, Visitor *v, const char *name,
     }
 
     if (*ptr) {
-        /* BlockBackend alread exists. So, we want to change attached node */
+        /* BlockBackend already exists. So, we want to change attached node */
         blk = *ptr;
         ctx = blk_get_aio_context(blk);
         bs = bdrv_lookup_bs(NULL, str, errp);
diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
index 774ca9987a..bfd8aa5644 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -161,7 +161,7 @@ static void a15mp_priv_class_init(ObjectClass *klass, void *data)
 
     dc->realize = a15mp_priv_realize;
     device_class_set_props(dc, a15mp_priv_properties);
-    /* We currently have no savable state */
+    /* We currently have no saveable state */
 }
 
 static const TypeInfo a15mp_priv_info = {
diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
index d161d57456..3ddd6369ad 100644
--- a/hw/cxl/cxl-events.c
+++ b/hw/cxl/cxl-events.c
@@ -197,7 +197,7 @@ CXLRetCode cxl_event_clear_records(CXLDeviceState *cxlds, CXLClearEventPayload *
 
     QEMU_LOCK_GUARD(&log->lock);
     /*
-     * Must itterate the queue twice.
+     * Must iterate the queue twice.
      * "The device shall verify the event record handles specified in the input
      * payload are in temporal order. If the device detects an older event
      * record that will not be cleared when Clear Event Records is executed,
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 02f9b5a870..434ccc5f6e 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -39,7 +39,7 @@
  *    fill the output data into cmd->payload (overwriting what was there),
  *    setting the length, and returning a valid return code.
  *
- *  XXX: The handler need not worry about endianess. The payload is read out of
+ *  XXX: The handler need not worry about endianness. The payload is read out of
  *  a register interface that already deals with it.
  */
 
@@ -501,7 +501,7 @@ static CXLRetCode cmd_media_get_poison_list(struct cxl_cmd *cmd,
     uint16_t out_pl_len;
 
     query_start = ldq_le_p(&in->pa);
-    /* 64 byte alignemnt required */
+    /* 64 byte alignment required */
     if (query_start & 0x3f) {
         return CXL_MBOX_INVALID_INPUT;
     }
diff --git a/hw/dma/omap_dma.c b/hw/dma/omap_dma.c
index c6e35ba4b8..77797a67b5 100644
--- a/hw/dma/omap_dma.c
+++ b/hw/dma/omap_dma.c
@@ -247,7 +247,7 @@ static void omap_dma_deactivate_channel(struct omap_dma_s *s,
         return;
     }
 
-    /* Don't deactive the channel if it is synchronized and the DMA request is
+    /* Don't deactivate the channel if it is synchronized and the DMA request is
        active */
     if (ch->sync && ch->enable && (s->dma->drqbmp & (1ULL << ch->sync)))
         return;
@@ -422,7 +422,7 @@ static void omap_dma_transfer_generic(struct soc_dma_ch_s *dma)
 
         if (ch->fs && ch->bs) {
             a->pck_element ++;
-            /* Check if a full packet has beed transferred.  */
+            /* Check if a full packet has been transferred.  */
             if (a->pck_element == a->pck_elements) {
                 a->pck_element = 0;
 
diff --git a/hw/input/hid.c b/hw/input/hid.c
index e7ecebdf8f..a9c7dd1ce1 100644
--- a/hw/input/hid.c
+++ b/hw/input/hid.c
@@ -209,7 +209,7 @@ static void hid_pointer_sync(DeviceState *dev)
         prev->dz += curr->dz;
         curr->dz = 0;
     } else {
-        /* prepate next (clear rel, copy abs + btns) */
+        /* prepare next (clear rel, copy abs + btns) */
         if (hs->kind == HID_MOUSE) {
             next->xdx = 0;
             next->ydy = 0;
diff --git a/hw/input/tsc2005.c b/hw/input/tsc2005.c
index 555b677173..db2b80e35f 100644
--- a/hw/input/tsc2005.c
+++ b/hw/input/tsc2005.c
@@ -157,14 +157,14 @@ static uint16_t tsc2005_read(TSC2005State *s, int reg)
         s->reset = true;
         return ret;
 
-    case 0x8:	/* AUX high treshold */
+    case 0x8:   /* AUX high threshold */
         return s->aux_thr[1];
-    case 0x9:	/* AUX low treshold */
+    case 0x9:   /* AUX low threshold */
         return s->aux_thr[0];
 
-    case 0xa:	/* TEMP high treshold */
+    case 0xa:   /* TEMP high threshold */
         return s->temp_thr[1];
-    case 0xb:	/* TEMP low treshold */
+    case 0xb:   /* TEMP low threshold */
         return s->temp_thr[0];
 
     case 0xc:	/* CFR0 */
@@ -186,17 +186,17 @@ static uint16_t tsc2005_read(TSC2005State *s, int reg)
 static void tsc2005_write(TSC2005State *s, int reg, uint16_t data)
 {
     switch (reg) {
-    case 0x8:	/* AUX high treshold */
+    case 0x8:   /* AUX high threshold */
         s->aux_thr[1] = data;
         break;
-    case 0x9:	/* AUX low treshold */
+    case 0x9:   /* AUX low threshold */
         s->aux_thr[0] = data;
         break;
 
-    case 0xa:	/* TEMP high treshold */
+    case 0xa:   /* TEMP high threshold */
         s->temp_thr[1] = data;
         break;
-    case 0xb:	/* TEMP low treshold */
+    case 0xb:   /* TEMP low threshold */
         s->temp_thr[0] = data;
         break;
 
diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
index af75460643..24fb3af8cc 100644
--- a/hw/intc/loongarch_extioi.c
+++ b/hw/intc/loongarch_extioi.c
@@ -191,7 +191,7 @@ static MemTxResult extioi_writew(void *opaque, hwaddr addr,
         cpu = attrs.requester_id;
         old_data = s->coreisr[cpu][index];
         s->coreisr[cpu][index] = old_data & ~val;
-        /* write 1 to clear interrrupt */
+        /* write 1 to clear interrupt */
         old_data &= val;
         irq = ctz32(old_data);
         while (irq != 32) {
diff --git a/hw/intc/loongson_liointc.c b/hw/intc/loongson_liointc.c
index cc11b544cb..c10fb97a06 100644
--- a/hw/intc/loongson_liointc.c
+++ b/hw/intc/loongson_liointc.c
@@ -1,5 +1,5 @@
 /*
- * QEMU Loongson Local I/O interrupt controler.
+ * QEMU Loongson Local I/O interrupt controller.
  *
  * Copyright (c) 2020 Huacai Chen <chenhc@lemote.com>
  * Copyright (c) 2020 Jiaxun Yang <jiaxun.yang@flygoat.com>
diff --git a/hw/intc/omap_intc.c b/hw/intc/omap_intc.c
index 647bf324a8..435c47600f 100644
--- a/hw/intc/omap_intc.c
+++ b/hw/intc/omap_intc.c
@@ -68,7 +68,7 @@ static void omap_inth_sir_update(OMAPIntcState *s, int is_fiq)
     p_intr = 255;
 
     /* Find the interrupt line with the highest dynamic priority.
-     * Note: 0 denotes the hightest priority.
+     * Note: 0 denotes the highest priority.
      * If all interrupts have the same priority, the default order is IRQ_N,
      * IRQ_N-1,...,IRQ_0. */
     for (j = 0; j < s->nbanks; ++j) {
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index bda3478b1f..da10deceb8 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -988,7 +988,7 @@ static void pnv_xive_ic_reg_write(void *opaque, hwaddr offset,
      */
     case VC_SBC_CONFIG: /* Store EOI configuration */
         /*
-         * Configure store EOI if required by firwmare (skiboot has removed
+         * Configure store EOI if required by firmware (skiboot has removed
          * support recently though)
          */
         if (val & (VC_SBC_CONF_CPLX_CIST | VC_SBC_CONF_CIST_BOTH)) {
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 8bcab2846c..7f701d414b 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -27,7 +27,7 @@
 #include "trace.h"
 
 /*
- * XIVE Virtualization Controller BAR and Thread Managment BAR that we
+ * XIVE Virtualization Controller BAR and Thread Management BAR that we
  * use for the ESB pages and the TIMA pages
  */
 #define SPAPR_XIVE_VC_BASE   0x0006010000000000ull
diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 61fe7bd2d3..5789062379 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -485,7 +485,7 @@ static int kvmppc_xive_get_queues(SpaprXive *xive, Error **errp)
  *
  * Whenever the VM is stopped, the VM change handler sets the source
  * PQs to PENDING to stop the flow of events and to possibly catch a
- * triggered interrupt occuring while the VM is stopped. The previous
+ * triggered interrupt occurring while the VM is stopped. The previous
  * state is saved in anticipation of a migration. The XIVE controller
  * is then synced through KVM to flush any in-flight event
  * notification and stabilize the EQs.
@@ -551,7 +551,7 @@ static void kvmppc_xive_change_state_handler(void *opaque, bool running,
 
         /*
          * PQ is set to PENDING to possibly catch a triggered
-         * interrupt occuring while the VM is stopped (hotplug event
+         * interrupt occurring while the VM is stopped (hotplug event
          * for instance) .
          */
         if (pq != XIVE_ESB_OFF) {
@@ -633,7 +633,7 @@ int kvmppc_xive_post_load(SpaprXive *xive, int version_id)
     /* The KVM XIVE device should be in use */
     assert(xive->fd != -1);
 
-    /* Restore the ENDT first. The targetting depends on it. */
+    /* Restore the ENDT first. The targeting depends on it. */
     for (i = 0; i < xive->nr_ends; i++) {
         if (!xive_end_is_valid(&xive->endt[i])) {
             continue;
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index df3ee0496f..a3585593d8 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1608,7 +1608,7 @@ int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
  *
  * It receives notification requests sent by the IVRE to find one
  * matching NVT (or more) dispatched on the processor threads. In case
- * of a single NVT notification, the process is abreviated and the
+ * of a single NVT notification, the process is abbreviated and the
  * thread is signaled if a match is found. In case of a logical server
  * notification (bits ignored at the end of the NVT identifier), the
  * IVPE and IVRE select a winning thread using different filters. This
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index c37ef25d44..98c0d8ba44 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -542,7 +542,7 @@ static void xive2_router_realize(DeviceState *dev, Error **errp)
 
 /*
  * Notification using the END ESe/ESn bit (Event State Buffer for
- * escalation and notification). Profide futher coalescing in the
+ * escalation and notification). Profide further coalescing in the
  * Router.
  */
 static bool xive2_router_end_es_notify(Xive2Router *xrtr, uint8_t end_blk,
@@ -621,7 +621,7 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
 
     /*
      * Check the END ESn (Event State Buffer for notification) for
-     * even futher coalescing in the Router
+     * even further coalescing in the Router
      */
     if (!xive2_end_is_notify(&end)) {
         /* ESn[Q]=1 : end of notification */
@@ -702,7 +702,7 @@ do_escalation:
 
     /*
      * Check the END ESe (Event State Buffer for escalation) for even
-     * futher coalescing in the Router
+     * further coalescing in the Router
      */
     if (!xive2_end_is_uncond_escalation(&end)) {
         /* ESe[Q]=1 : end of escalation notification */
diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index acf2bab35f..e232d35ba2 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -301,7 +301,7 @@ static void handle_msg(IPMIBmcExtern *ibe)
         ipmi_debug("msg checksum failure\n");
         return;
     } else {
-        ibe->inpos--; /* Remove checkum */
+        ibe->inpos--; /* Remove checksum */
     }
 
     timer_del(ibe->extern_timer);
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 4e314748d3..a98a157065 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -538,7 +538,7 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
                                      FIRST_ERROR_POINTER, cxl_err->type);
             } else {
                 /*
-                 * If no more errors, then follow recomendation of PCI spec
+                 * If no more errors, then follow recommendation of PCI spec
                  * r6.0 6.2.4.2 to set the first error pointer to a status
                  * bit that will never be used.
                  */
@@ -697,7 +697,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
                          PCI_BASE_ADDRESS_MEM_TYPE_64,
                      &ct3d->cxl_dstate.device_registers);
 
-    /* MSI(-X) Initailization */
+    /* MSI(-X) Initialization */
     rc = msix_init_exclusive_bar(pci_dev, msix_num, 4, NULL);
     if (rc) {
         goto err_address_space_free;
@@ -706,7 +706,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
         msix_vector_use(pci_dev, i);
     }
 
-    /* DOE Initailization */
+    /* DOE Initialization */
     pcie_doe_init(pci_dev, &ct3d->doe_cdat, 0x190, doe_cdat_prot, true, 0);
 
     cxl_cstate->cdat.build_cdat_table = ct3_build_cdat_table;
diff --git a/hw/misc/imx7_ccm.c b/hw/misc/imx7_ccm.c
index f135ec7b7e..7539f7fb45 100644
--- a/hw/misc/imx7_ccm.c
+++ b/hw/misc/imx7_ccm.c
@@ -227,7 +227,7 @@ static uint32_t imx7_ccm_get_clock_frequency(IMXCCMState *dev, IMXClk clock)
      * have fixed frequencies and we can provide requested frequency
      * easily. However for CCM provided clocks (like IPG) each GPT
      * timer can have its own clock root.
-     * This means we need additionnal information when calling this
+     * This means we need additional information when calling this
      * function to know the requester's identity.
      */
     uint32_t freq = 0;
diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index 0787a0268d..f84cc68849 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -246,7 +246,7 @@
 #define vT2CL    0x1000  /* [VIA only] Timer two counter low. */
 #define vT2CH    0x1200  /* [VIA only] Timer two counter high. */
 #define vSR      0x1400  /* [VIA only] Shift register. */
-#define vACR     0x1600  /* [VIA only] Auxilary control register. */
+#define vACR     0x1600  /* [VIA only] Auxiliary control register. */
 #define vPCR     0x1800  /* [VIA only] Peripheral control register. */
                          /*
                           *           CHRP sez never ever to *write* this.
diff --git a/hw/misc/stm32f2xx_syscfg.c b/hw/misc/stm32f2xx_syscfg.c
index 04c22c2850..19c1e86424 100644
--- a/hw/misc/stm32f2xx_syscfg.c
+++ b/hw/misc/stm32f2xx_syscfg.c
@@ -94,12 +94,12 @@ static void stm32f2xx_syscfg_write(void *opaque, hwaddr addr,
     switch (addr) {
     case SYSCFG_MEMRMP:
         qemu_log_mask(LOG_UNIMP,
-                      "%s: Changeing the memory mapping isn't supported " \
+                      "%s: Changing the memory mapping isn't supported " \
                       "in QEMU\n", __func__);
         return;
     case SYSCFG_PMC:
         qemu_log_mask(LOG_UNIMP,
-                      "%s: Changeing the memory mapping isn't supported " \
+                      "%s: Changing the memory mapping isn't supported " \
                       "in QEMU\n", __func__);
         return;
     case SYSCFG_EXTICR1:
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index e8b2be14c0..bc87cd3670 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -155,7 +155,7 @@ stm32f4xx_syscfg_read(uint64_t addr) "reg read: addr: 0x%" PRIx64 " "
 stm32f4xx_syscfg_write(uint64_t addr, uint64_t data) "reg write: addr: 0x%" PRIx64 " val: 0x%" PRIx64 ""
 
 # stm32f4xx_exti.c
-stm32f4xx_exti_set_irq(int irq, int leve) "Set EXTI: %d to %d"
+stm32f4xx_exti_set_irq(int irq, int level) "Set EXTI: %d to %d"
 stm32f4xx_exti_read(uint64_t addr) "reg read: addr: 0x%" PRIx64 " "
 stm32f4xx_exti_write(uint64_t addr, uint64_t data) "reg write: addr: 0x%" PRIx64 " val: 0x%" PRIx64 ""
 
diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
index 8b70285961..41f38a98e9 100644
--- a/hw/misc/zynq_slcr.c
+++ b/hw/misc/zynq_slcr.c
@@ -285,7 +285,7 @@ static void zynq_slcr_compute_clocks_internal(ZynqSLCRState *s, uint64_t ps_clk)
 }
 
 /**
- * Compute and set the ouputs clocks periods.
+ * Compute and set the outputs clocks periods.
  * But do not propagate them further. Connected clocks
  * will not receive any updates (See zynq_slcr_compute_clocks())
  */
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 90687b168a..ee00be63f9 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -17,7 +17,7 @@
  * Notes on coding style
  * ---------------------
  * While QEMU coding style prefers lowercase hexadecimals in constants, the
- * NVMe subsystem use thes format from the NVMe specifications in the comments
+ * NVMe subsystem use this format from the NVMe specifications in the comments
  * (i.e. 'h' suffix instead of '0x' prefix).
  *
  * Usage
@@ -730,7 +730,7 @@ static inline void nvme_sg_unmap(NvmeSg *sg)
 }
 
 /*
- * When metadata is transfered as extended LBAs, the DPTR mapped into `sg`
+ * When metadata is transferred as extended LBAs, the DPTR mapped into `sg`
  * holds both data and metadata. This function splits the data and metadata
  * into two separate QSG/IOVs.
  */
@@ -7594,7 +7594,7 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
             /*
              * NVM Express v1.3d, Section 4.1 state: "If host software writes
              * an invalid value to the Submission Queue Tail Doorbell or
-             * Completion Queue Head Doorbell regiter and an Asynchronous Event
+             * Completion Queue Head Doorbell register and an Asynchronous Event
              * Request command is outstanding, then an asynchronous event is
              * posted to the Admin Completion Queue with a status code of
              * Invalid Doorbell Write Value."
diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
index 613c4929e3..3272068663 100644
--- a/hw/nvram/eeprom_at24c.c
+++ b/hw/nvram/eeprom_at24c.c
@@ -51,7 +51,7 @@ struct EEPROMState {
     bool writable;
     /* cells changed since last START? */
     bool changed;
-    /* during WRITE, # of address bytes transfered */
+    /* during WRITE, # of address bytes transferred */
     uint8_t haveaddr;
 
     uint8_t *mem;
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 29a5bef1d5..4e4524673a 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -877,7 +877,7 @@ static struct {
 /*
  * Any sub-page size update to these table MRs will be lost during migration,
  * as we use aligned size in ram_load_precopy() -> qemu_ram_resize() path.
- * In order to avoid the inconsistency in sizes save them seperately and
+ * In order to avoid the inconsistency in sizes save them separately and
  * migrate over in vmstate post_load().
  */
 static void fw_cfg_acpi_mr_save(FWCfgState *s, const char *filename, size_t len)
diff --git a/hw/rtc/exynos4210_rtc.c b/hw/rtc/exynos4210_rtc.c
index 2b8a38a296..cc7101c530 100644
--- a/hw/rtc/exynos4210_rtc.c
+++ b/hw/rtc/exynos4210_rtc.c
@@ -202,7 +202,7 @@ static void exynos4210_rtc_update_freq(Exynos4210RTCState *s,
     uint32_t freq;
 
     freq = s->freq;
-    /* set frequncy for time generator */
+    /* set frequency for time generator */
     s->freq = RTC_BASE_FREQ / (1 << TICCKSEL(reg_value));
 
     if (freq != s->freq) {
diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
index 3e887a0fc7..d00fcb0ef0 100644
--- a/hw/rx/rx62n.c
+++ b/hw/rx/rx62n.c
@@ -114,7 +114,7 @@ static const uint8_t ipr_table[NR_IRQS] = {
 };
 
 /*
- * Level triggerd IRQ list
+ * Level triggered IRQ list
  * Not listed IRQ is Edge trigger.
  * See "11.3.1 Interrupt Vector Table" in hardware manual.
  */
diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index f7d45b0b20..634ed49c2e 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -1321,7 +1321,7 @@ again:
                 }
                 trace_lsi_execute_script_io_selected(id,
                                              insn & (1 << 3) ? " ATN" : "");
-                /* ??? Linux drivers compain when this is set.  Maybe
+                /* ??? Linux drivers complain when this is set.  Maybe
                    it only applies in low-level mode (unimplemented).
                 lsi_script_scsi_interrupt(s, LSI_SIST0_CMP, 0); */
                 s->select_tag = id << 8;
diff --git a/hw/scsi/mfi.h b/hw/scsi/mfi.h
index 0b4ee53dfc..cf7a2d775b 100644
--- a/hw/scsi/mfi.h
+++ b/hw/scsi/mfi.h
@@ -65,7 +65,7 @@
 #define MFI_IQPH        0xc4            /* Inbound queue port (high bytes)  */
 #define MFI_DIAG        0xf8            /* Host diag */
 #define MFI_SEQ         0xfc            /* Sequencer offset */
-#define MFI_1078_EIM    0x80000004      /* 1078 enable intrrupt mask  */
+#define MFI_1078_EIM    0x80000004      /* 1078 enable interrupt mask  */
 #define MFI_RMI         0x2             /* reply message interrupt  */
 #define MFI_1078_RM     0x80000000      /* reply 1078 message interrupt  */
 #define MFI_ODC         0x4             /* outbound doorbell change interrupt */
diff --git a/hw/sh4/sh7750_regs.h b/hw/sh4/sh7750_regs.h
index 94043431e6..edb5d18f00 100644
--- a/hw/sh4/sh7750_regs.h
+++ b/hw/sh4/sh7750_regs.h
@@ -113,7 +113,7 @@
 #define SH7750_TTB            SH7750_P4_REG32(SH7750_TTB_REGOFS)
 #define SH7750_TTB_A7         SH7750_A7_REG32(SH7750_TTB_REGOFS)
 
-/* TLB exeption address register - TEA */
+/* TLB exception address register - TEA */
 #define SH7750_TEA_REGOFS     0x00000c /* offset */
 #define SH7750_TEA            SH7750_P4_REG32(SH7750_TEA_REGOFS)
 #define SH7750_TEA_A7         SH7750_A7_REG32(SH7750_TEA_REGOFS)
@@ -183,19 +183,19 @@
 #define SH7750_TRA_IMM      0x000003fd /* Immediate data operand */
 #define SH7750_TRA_IMM_S    2
 
-/* Exeption event register - EXPEVT */
+/* Exception event register - EXPEVT */
 #define SH7750_EXPEVT_REGOFS  0x000024
 #define SH7750_EXPEVT         SH7750_P4_REG32(SH7750_EXPEVT_REGOFS)
 #define SH7750_EXPEVT_A7      SH7750_A7_REG32(SH7750_EXPEVT_REGOFS)
 
-#define SH7750_EXPEVT_EX      0x00000fff /* Exeption code */
+#define SH7750_EXPEVT_EX      0x00000fff /* Exception code */
 #define SH7750_EXPEVT_EX_S    0
 
 /* Interrupt event register */
 #define SH7750_INTEVT_REGOFS  0x000028
 #define SH7750_INTEVT         SH7750_P4_REG32(SH7750_INTEVT_REGOFS)
 #define SH7750_INTEVT_A7      SH7750_A7_REG32(SH7750_INTEVT_REGOFS)
-#define SH7750_INTEVT_EX    0x00000fff /* Exeption code */
+#define SH7750_INTEVT_EX    0x00000fff /* Exception code */
 #define SH7750_INTEVT_EX_S  0
 
 /*
@@ -1274,15 +1274,15 @@
 /*
  * User Break Controller registers
  */
-#define SH7750_BARA           0x200000 /* Break address regiser A */
-#define SH7750_BAMRA          0x200004 /* Break address mask regiser A */
-#define SH7750_BBRA           0x200008 /* Break bus cycle regiser A */
-#define SH7750_BARB           0x20000c /* Break address regiser B */
-#define SH7750_BAMRB          0x200010 /* Break address mask regiser B */
-#define SH7750_BBRB           0x200014 /* Break bus cycle regiser B */
-#define SH7750_BASRB          0x000018 /* Break ASID regiser B */
-#define SH7750_BDRB           0x200018 /* Break data regiser B */
-#define SH7750_BDMRB          0x20001c /* Break data mask regiser B */
+#define SH7750_BARA           0x200000 /* Break address register A */
+#define SH7750_BAMRA          0x200004 /* Break address mask register A */
+#define SH7750_BBRA           0x200008 /* Break bus cycle register A */
+#define SH7750_BARB           0x20000c /* Break address register B */
+#define SH7750_BAMRB          0x200010 /* Break address mask register B */
+#define SH7750_BBRB           0x200014 /* Break bus cycle register B */
+#define SH7750_BASRB          0x000018 /* Break ASID register B */
+#define SH7750_BDRB           0x200018 /* Break data register B */
+#define SH7750_BDMRB          0x20001c /* Break data mask register B */
 #define SH7750_BRCR           0x200020 /* Break control register */
 
 #define SH7750_BRCR_UDBE        0x0001 /* User break debug enable bit */
diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 10cd22f610..b753705856 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -1110,7 +1110,7 @@ void smbios_get_tables(MachineState *ms,
         dimm_cnt = QEMU_ALIGN_UP(current_machine->ram_size, MAX_DIMM_SZ) / MAX_DIMM_SZ;
 
         /*
-         * The offset determines if we need to keep additional space betweeen
+         * The offset determines if we need to keep additional space between
          * table 17 and table 19 header handle numbers so that they do
          * not overlap. For example, for a VM with larger than 8 TB guest
          * memory and DIMM like chunks of 16 GiB, the default space between
diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index 97009d3a5d..a3955c6c50 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -163,7 +163,7 @@
     FIELD(GQSPI_CNFG, ENDIAN, 26, 1)
     /* Poll timeout not implemented */
     FIELD(GQSPI_CNFG, EN_POLL_TIMEOUT, 20, 1)
-    /* QEMU doesnt care about any of these last three */
+    /* QEMU doesn't care about any of these last three */
     FIELD(GQSPI_CNFG, BR, 3, 3)
     FIELD(GQSPI_CNFG, CPH, 2, 1)
     FIELD(GQSPI_CNFG, CPL, 1, 1)
@@ -469,7 +469,7 @@ static void xlnx_zynqmp_qspips_flush_fifo_g(XlnxZynqMPQSPIPS *s)
 
             imm = ARRAY_FIELD_EX32(s->regs, GQSPI_GF_SNAPSHOT, IMMEDIATE_DATA);
             if (!ARRAY_FIELD_EX32(s->regs, GQSPI_GF_SNAPSHOT, DATA_XFER)) {
-                /* immedate transfer */
+                /* immediate transfer */
                 if (ARRAY_FIELD_EX32(s->regs, GQSPI_GF_SNAPSHOT, TRANSMIT) ||
                     ARRAY_FIELD_EX32(s->regs, GQSPI_GF_SNAPSHOT, RECIEVE)) {
                     s->regs[R_GQSPI_DATA_STS] = 1;
@@ -768,7 +768,7 @@ static void xilinx_spips_check_zero_pump(XilinxSPIPS *s)
      */
     while (s->regs[R_TRANSFER_SIZE] &&
            s->rx_fifo.num + s->tx_fifo.num < RXFF_A_Q - 3) {
-        /* endianess just doesn't matter when zero pumping */
+        /* endianness just doesn't matter when zero pumping */
         tx_data_bytes(&s->tx_fifo, 0, 4, false);
         s->regs[R_TRANSFER_SIZE] &= ~0x03ull;
         s->regs[R_TRANSFER_SIZE] -= 4;
diff --git a/hw/ssi/xlnx-versal-ospi.c b/hw/ssi/xlnx-versal-ospi.c
index c762e0b367..1a61679c2f 100644
--- a/hw/ssi/xlnx-versal-ospi.c
+++ b/hw/ssi/xlnx-versal-ospi.c
@@ -837,7 +837,7 @@ static void ospi_do_ind_read(XlnxVersalOspi *s)
     /* Continue to read flash until we run out of space in sram */
     while (!ospi_ind_op_completed(op) &&
            !fifo8_is_full(&s->rx_sram)) {
-        /* Read reqested number of bytes, max bytes limited to size of sram */
+        /* Read requested number of bytes, max bytes limited to size of sram */
         next_b = ind_op_next_byte(op);
         end_b = next_b + fifo8_num_free(&s->rx_sram);
         end_b = MIN(end_b, ind_op_end_byte(op));
diff --git a/hw/timer/etraxfs_timer.c b/hw/timer/etraxfs_timer.c
index 2d6d92ef93..f035b74560 100644
--- a/hw/timer/etraxfs_timer.c
+++ b/hw/timer/etraxfs_timer.c
@@ -236,7 +236,7 @@ static void watchdog_hit(void *opaque)
 {
     ETRAXTimerState *t = opaque;
     if (t->wd_hits == 0) {
-        /* real hw gives a single tick before reseting but we are
+        /* real hw gives a single tick before resetting but we are
            a bit friendlier to compensate for our slower execution.  */
         ptimer_set_count(t->ptimer_wd, 10);
         ptimer_run(t->ptimer_wd, 1);
diff --git a/hw/timer/renesas_tmr.c b/hw/timer/renesas_tmr.c
index c15f654738..43b31213bc 100644
--- a/hw/timer/renesas_tmr.c
+++ b/hw/timer/renesas_tmr.c
@@ -115,7 +115,7 @@ static int elapsed_time(RTMRState *tmr, int ch, int64_t delta)
         et = tmr->div_round[ch] / divrate;
         tmr->div_round[ch] %= divrate;
     } else {
-        /* disble clock. so no update */
+        /* disable clock. so no update */
         et = 0;
     }
     return et;
diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 13aec771e1..0e2cc8d5a8 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -655,7 +655,7 @@ virtio_crypto_sym_op_helper(VirtIODevice *vdev,
     op_info->len_to_hash = len_to_hash;
     op_info->cipher_start_src_offset = cipher_start_src_offset;
     op_info->len_to_cipher = len_to_cipher;
-    /* Handle the initilization vector */
+    /* Handle the initialization vector */
     if (op_info->iv_len > 0) {
         DPRINTF("iv_len=%" PRIu32 "\n", op_info->iv_len);
         op_info->iv = op_info->data + curr_size;
@@ -1278,7 +1278,7 @@ static void virtio_crypto_instance_init(Object *obj)
 
     /*
      * The default config_size is sizeof(struct virtio_crypto_config).
-     * Can be overriden with virtio_crypto_set_config_size.
+     * Can be overridden with virtio_crypto_set_config_size.
      */
     vcrypto->config_size = sizeof(struct virtio_crypto_config);
 }
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index b6e781741e..da5b09cefc 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -1119,7 +1119,7 @@ static int virtio_mem_mig_sanity_checks_post_load(void *opaque, int version_id)
         return -EINVAL;
     }
     /*
-     * Note: Preparation for resizeable memory regions. The maximum size
+     * Note: Preparation for resizable memory regions. The maximum size
      * of the memory region must not change during migration.
      */
     if (tmp->region_size != new_region_size) {
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 969c25f4cf..4577f3f5b3 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2096,7 +2096,7 @@ void virtio_queue_enable(VirtIODevice *vdev, uint32_t queue_index)
      * being converted to LOG_GUEST_ERROR.
      *
     if (!virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
-        error_report("queue_enable is only suppported in devices of virtio "
+        error_report("queue_enable is only supported in devices of virtio "
                      "1.0 or later.");
     }
     */
-- 
2.39.2


