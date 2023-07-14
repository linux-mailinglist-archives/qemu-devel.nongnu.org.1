Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7789D753A00
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 13:46:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKHBK-0002zU-Qn; Fri, 14 Jul 2023 07:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKHAC-0002VU-Th; Fri, 14 Jul 2023 07:40:47 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKHA7-0004bz-OG; Fri, 14 Jul 2023 07:40:44 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9A02013DA3;
 Fri, 14 Jul 2023 14:38:58 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 996B814BB2;
 Fri, 14 Jul 2023 14:38:42 +0300 (MSK)
Received: (nullmailer pid 1186265 invoked by uid 1000);
 Fri, 14 Jul 2023 11:38:38 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH, trivial 23/29] tree-wide spelling fixes in comments and some
 messages: hw/
Date: Fri, 14 Jul 2023 14:38:28 +0300
Message-Id: <20230714113834.1186117-25-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230714113834.1186117-1-mjt@tls.msk.ru>
References: <20230714113834.1186117-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
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
 hw/core/loader.c                 |  4 ++--
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
 hw/sd/sd.c                       |  2 +-
 hw/sd/sdhci.c                    |  2 +-
 hw/sensor/isl_pmbus_vr.c         |  2 +-
 hw/sensor/max34451.c             |  2 +-
 hw/sh4/sh7750_regs.h             | 26 +++++++++++++-------------
 hw/smbios/smbios.c               |  2 +-
 hw/ssi/xilinx_spips.c            |  6 +++---
 hw/ssi/xlnx-versal-ospi.c        |  2 +-
 hw/timer/etraxfs_timer.c         |  2 +-
 hw/timer/i8254.c                 |  2 +-
 hw/timer/renesas_tmr.c           |  2 +-
 hw/virtio/virtio-crypto.c        |  4 ++--
 hw/virtio/virtio-mem.c           |  2 +-
 hw/virtio/virtio.c               |  2 +-
 54 files changed, 92 insertions(+), 92 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index ea331a20d1..af66bde0f5 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -314,3 +314,3 @@ build_prepend_package_length(GArray *package, unsigned length, bool incl_self)
          * and PkgLength's length itself when used for terms with
-         * explitit length.
+         * explicit length.
          */
@@ -682,3 +682,3 @@ Aml *aml_store(Aml *val, Aml *target)
  *
- * Returns: The newly allocated and composed according to patter Aml object.
+ * Returns: The newly allocated and composed according to pattern Aml object.
  */
@@ -2161,3 +2161,3 @@ void build_fadt(GArray *tbl, BIOSLinker *linker, const AcpiFadtData *f,
     } else {
-        build_append_int_noprefix(tbl, 0, 3); /* Reserved upto ACPI 5.0 */
+        build_append_int_noprefix(tbl, 0, 3); /* Reserved up to ACPI 5.0 */
     }
diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
index 3a6d51282a..2d5e199ba9 100644
--- a/hw/acpi/hmat.c
+++ b/hw/acpi/hmat.c
@@ -84,3 +84,3 @@ static void build_hmat_lb(GArray *table_data, HMAT_LB_Info *hmat_lb,
     uint32_t lb_length
-        = 32 /* Table length upto and including Entry Base Unit */
+        = 32 /* Table length up to and including Entry Base Unit */
         + 4 * num_initiator /* Initiator Proximity Domain List */
diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index a3b25a92f3..fe03ce87e0 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -1099,3 +1099,3 @@ static void nvdimm_build_common_dsm(Aml *dev,
      * size is 32 bits, otherwise it is 64 bits.
-     * Because of this CreateField() canot be used if RLEN < Integer Size.
+     * Because of this CreateField() cannot be used if RLEN < Integer Size.
      *
diff --git a/hw/block/hd-geometry.c b/hw/block/hd-geometry.c
index dae13ab14d..2b0af4430f 100644
--- a/hw/block/hd-geometry.c
+++ b/hw/block/hd-geometry.c
@@ -52,3 +52,3 @@ struct partition {
 
-/* try to guess the disk logical geometry from the MSDOS partition table.
+/* try to guess the disk logical geometry from the MS-DOS partition table.
    Return 0 if OK, -1 if could not guess */
@@ -68,3 +68,3 @@ static int guess_disk_lchs(BlockBackend *blk,
     }
-    /* test msdos magic */
+    /* test MS-DOS magic */
     if (buf[510] != 0x55 || buf[511] != 0xaa) {
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 3c066e3405..62056b1d74 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -893,3 +893,3 @@ static Property pflash_cfi01_properties[] = {
      * If we're emulating flash devices wired in parallel the actual
-     * number of blocks per indvidual device will differ.
+     * number of blocks per individual device will differ.
      */
diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index 807e398541..5dffd61b98 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -577,3 +577,3 @@ static int cadence_uart_pre_load(void *opaque)
 
-    /* the frequency will be overriden if the refclk field is present */
+    /* the frequency will be overridden if the refclk field is present */
     clock_set_hz(s->refclk, UART_DEFAULT_REF_CLK);
diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index 1b75a89588..377d1d9773 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -114,3 +114,3 @@ static void imx_serial_reset_at_boot(DeviceState *dev)
     /*
-     * enable the uart on boot, so messages from the linux decompresser
+     * enable the uart on boot, so messages from the linux decompressor
      * are visible.  On real hardware this is done by the boot rom
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 270e1b1094..880b632177 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -56,3 +56,3 @@
 
-#define UART_IIR_FENF   0x80    /* Fifo enabled, but not functionning */
+#define UART_IIR_FENF   0x80    /* Fifo enabled, but not functioning */
 #define UART_IIR_FE     0xC0    /* Fifo enabled */
diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index 4f4d77908d..d4b5c501d8 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -26,3 +26,3 @@
  * This device allows the user to monkey patch memory. To be able to do
- * this it needs a backend to manage the datas, the same as other
+ * this it needs a backend to manage the data, the same as other
  * memory-related devices. In this case as the backend is so trivial we
@@ -168,3 +168,3 @@ static void generic_loader_realize(DeviceState *dev, Error **errp)
 
-    /* Convert the data endiannes */
+    /* Convert the data endianness */
     if (s->data_be) {
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 8b7fd9e9e5..4dd5a71fb7 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -865,3 +865,3 @@ ssize_t load_image_gzipped(const char *filename, hwaddr addr, uint64_t max_sz)
  * The Linux header magic number for a EFI PE/COFF
- * image targetting an unspecified architecture.
+ * image targeting an unspecified architecture.
  */
@@ -1494,3 +1494,3 @@ RomGap rom_find_largest_gap_between(hwaddr base, size_t size)
         }
-        /* ignore anything finishing bellow base */
+        /* ignore anything finishing below base */
         if (rom->addr + rom->romsize <= base) {
diff --git a/hw/core/machine.c b/hw/core/machine.c
index f0d35c6401..ac33799c1b 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1416,3 +1416,3 @@ void machine_run_board_init(MachineState *machine, const char *mem_path, Error *
                                           machine_class->valid_cpu_types[i])) {
-                /* The user specificed CPU is in the valid field, we are
+                /* The user specified CPU is in the valid field, we are
                  * good to go.
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 6d5d43eda2..41b7e682c7 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -109,3 +109,3 @@ static void set_drive_helper(Object *obj, Visitor *v, const char *name,
     if (*ptr) {
-        /* BlockBackend alread exists. So, we want to change attached node */
+        /* BlockBackend already exists. So, we want to change attached node */
         blk = *ptr;
diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
index 774ca9987a..bfd8aa5644 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -163,3 +163,3 @@ static void a15mp_priv_class_init(ObjectClass *klass, void *data)
     device_class_set_props(dc, a15mp_priv_properties);
-    /* We currently have no savable state */
+    /* We currently have no saveable state */
 }
diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
index d161d57456..3ddd6369ad 100644
--- a/hw/cxl/cxl-events.c
+++ b/hw/cxl/cxl-events.c
@@ -199,3 +199,3 @@ CXLRetCode cxl_event_clear_records(CXLDeviceState *cxlds, CXLClearEventPayload *
     /*
-     * Must itterate the queue twice.
+     * Must iterate the queue twice.
      * "The device shall verify the event record handles specified in the input
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 02f9b5a870..434ccc5f6e 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -41,3 +41,3 @@
  *
- *  XXX: The handler need not worry about endianess. The payload is read out of
+ *  XXX: The handler need not worry about endianness. The payload is read out of
  *  a register interface that already deals with it.
@@ -503,3 +503,3 @@ static CXLRetCode cmd_media_get_poison_list(struct cxl_cmd *cmd,
     query_start = ldq_le_p(&in->pa);
-    /* 64 byte alignemnt required */
+    /* 64 byte alignment required */
     if (query_start & 0x3f) {
diff --git a/hw/dma/omap_dma.c b/hw/dma/omap_dma.c
index c6e35ba4b8..77797a67b5 100644
--- a/hw/dma/omap_dma.c
+++ b/hw/dma/omap_dma.c
@@ -249,3 +249,3 @@ static void omap_dma_deactivate_channel(struct omap_dma_s *s,
 
-    /* Don't deactive the channel if it is synchronized and the DMA request is
+    /* Don't deactivate the channel if it is synchronized and the DMA request is
        active */
@@ -424,3 +424,3 @@ static void omap_dma_transfer_generic(struct soc_dma_ch_s *dma)
             a->pck_element ++;
-            /* Check if a full packet has beed transferred.  */
+            /* Check if a full packet has been transferred.  */
             if (a->pck_element == a->pck_elements) {
diff --git a/hw/input/hid.c b/hw/input/hid.c
index e7ecebdf8f..a9c7dd1ce1 100644
--- a/hw/input/hid.c
+++ b/hw/input/hid.c
@@ -211,3 +211,3 @@ static void hid_pointer_sync(DeviceState *dev)
     } else {
-        /* prepate next (clear rel, copy abs + btns) */
+        /* prepare next (clear rel, copy abs + btns) */
         if (hs->kind == HID_MOUSE) {
diff --git a/hw/input/tsc2005.c b/hw/input/tsc2005.c
index 555b677173..a4f23705b5 100644
--- a/hw/input/tsc2005.c
+++ b/hw/input/tsc2005.c
@@ -159,10 +159,10 @@ static uint16_t tsc2005_read(TSC2005State *s, int reg)
 
-    case 0x8:	/* AUX high treshold */
+    case 0x8:	/* AUX high threshold */
         return s->aux_thr[1];
-    case 0x9:	/* AUX low treshold */
+    case 0x9:	/* AUX low threshold */
         return s->aux_thr[0];
 
-    case 0xa:	/* TEMP high treshold */
+    case 0xa:	/* TEMP high threshold */
         return s->temp_thr[1];
-    case 0xb:	/* TEMP low treshold */
+    case 0xb:	/* TEMP low threshold */
         return s->temp_thr[0];
@@ -188,6 +188,6 @@ static void tsc2005_write(TSC2005State *s, int reg, uint16_t data)
     switch (reg) {
-    case 0x8:	/* AUX high treshold */
+    case 0x8:	/* AUX high threshold */
         s->aux_thr[1] = data;
         break;
-    case 0x9:	/* AUX low treshold */
+    case 0x9:	/* AUX low threshold */
         s->aux_thr[0] = data;
@@ -195,6 +195,6 @@ static void tsc2005_write(TSC2005State *s, int reg, uint16_t data)
 
-    case 0xa:	/* TEMP high treshold */
+    case 0xa:	/* TEMP high threshold */
         s->temp_thr[1] = data;
         break;
-    case 0xb:	/* TEMP low treshold */
+    case 0xb:	/* TEMP low threshold */
         s->temp_thr[0] = data;
diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
index af75460643..24fb3af8cc 100644
--- a/hw/intc/loongarch_extioi.c
+++ b/hw/intc/loongarch_extioi.c
@@ -193,3 +193,3 @@ static MemTxResult extioi_writew(void *opaque, hwaddr addr,
         s->coreisr[cpu][index] = old_data & ~val;
-        /* write 1 to clear interrrupt */
+        /* write 1 to clear interrupt */
         old_data &= val;
diff --git a/hw/intc/loongson_liointc.c b/hw/intc/loongson_liointc.c
index cc11b544cb..c10fb97a06 100644
--- a/hw/intc/loongson_liointc.c
+++ b/hw/intc/loongson_liointc.c
@@ -1,3 +1,3 @@
 /*
- * QEMU Loongson Local I/O interrupt controler.
+ * QEMU Loongson Local I/O interrupt controller.
  *
diff --git a/hw/intc/omap_intc.c b/hw/intc/omap_intc.c
index 647bf324a8..435c47600f 100644
--- a/hw/intc/omap_intc.c
+++ b/hw/intc/omap_intc.c
@@ -70,3 +70,3 @@ static void omap_inth_sir_update(OMAPIntcState *s, int is_fiq)
     /* Find the interrupt line with the highest dynamic priority.
-     * Note: 0 denotes the hightest priority.
+     * Note: 0 denotes the highest priority.
      * If all interrupts have the same priority, the default order is IRQ_N,
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index e536b3ec26..6b6b42eb14 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -945,3 +945,3 @@ static void pnv_xive_ic_reg_write(void *opaque, hwaddr offset,
         /*
-         * Configure store EOI if required by firwmare (skiboot has removed
+         * Configure store EOI if required by firmware (skiboot has removed
          * support recently though)
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 8bcab2846c..7f701d414b 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -29,3 +29,3 @@
 /*
- * XIVE Virtualization Controller BAR and Thread Managment BAR that we
+ * XIVE Virtualization Controller BAR and Thread Management BAR that we
  * use for the ESB pages and the TIMA pages
diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 61fe7bd2d3..5789062379 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -487,3 +487,3 @@ static int kvmppc_xive_get_queues(SpaprXive *xive, Error **errp)
  * PQs to PENDING to stop the flow of events and to possibly catch a
- * triggered interrupt occuring while the VM is stopped. The previous
+ * triggered interrupt occurring while the VM is stopped. The previous
  * state is saved in anticipation of a migration. The XIVE controller
@@ -553,3 +553,3 @@ static void kvmppc_xive_change_state_handler(void *opaque, bool running,
          * PQ is set to PENDING to possibly catch a triggered
-         * interrupt occuring while the VM is stopped (hotplug event
+         * interrupt occurring while the VM is stopped (hotplug event
          * for instance) .
@@ -635,3 +635,3 @@ int kvmppc_xive_post_load(SpaprXive *xive, int version_id)
 
-    /* Restore the ENDT first. The targetting depends on it. */
+    /* Restore the ENDT first. The targeting depends on it. */
     for (i = 0; i < xive->nr_ends; i++) {
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 56670b2cac..9cdf2b56b3 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1603,3 +1603,3 @@ int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
  * matching NVT (or more) dispatched on the processor threads. In case
- * of a single NVT notification, the process is abreviated and the
+ * of a single NVT notification, the process is abbreviated and the
  * thread is signaled if a match is found. In case of a logical server
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index c37ef25d44..98c0d8ba44 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -544,3 +544,3 @@ static void xive2_router_realize(DeviceState *dev, Error **errp)
  * Notification using the END ESe/ESn bit (Event State Buffer for
- * escalation and notification). Profide futher coalescing in the
+ * escalation and notification). Profide further coalescing in the
  * Router.
@@ -623,3 +623,3 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
      * Check the END ESn (Event State Buffer for notification) for
-     * even futher coalescing in the Router
+     * even further coalescing in the Router
      */
@@ -704,3 +704,3 @@ do_escalation:
      * Check the END ESe (Event State Buffer for escalation) for even
-     * futher coalescing in the Router
+     * further coalescing in the Router
      */
diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index acf2bab35f..e232d35ba2 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -303,3 +303,3 @@ static void handle_msg(IPMIBmcExtern *ibe)
     } else {
-        ibe->inpos--; /* Remove checkum */
+        ibe->inpos--; /* Remove checksum */
     }
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 4e314748d3..a98a157065 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -540,3 +540,3 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
                 /*
-                 * If no more errors, then follow recomendation of PCI spec
+                 * If no more errors, then follow recommendation of PCI spec
                  * r6.0 6.2.4.2 to set the first error pointer to a status
@@ -699,3 +699,3 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
 
-    /* MSI(-X) Initailization */
+    /* MSI(-X) Initialization */
     rc = msix_init_exclusive_bar(pci_dev, msix_num, 4, NULL);
@@ -708,3 +708,3 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
 
-    /* DOE Initailization */
+    /* DOE Initialization */
     pcie_doe_init(pci_dev, &ct3d->doe_cdat, 0x190, doe_cdat_prot, true, 0);
diff --git a/hw/misc/imx7_ccm.c b/hw/misc/imx7_ccm.c
index f135ec7b7e..7539f7fb45 100644
--- a/hw/misc/imx7_ccm.c
+++ b/hw/misc/imx7_ccm.c
@@ -229,3 +229,3 @@ static uint32_t imx7_ccm_get_clock_frequency(IMXCCMState *dev, IMXClk clock)
      * timer can have its own clock root.
-     * This means we need additionnal information when calling this
+     * This means we need additional information when calling this
      * function to know the requester's identity.
diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index 0787a0268d..f84cc68849 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -248,3 +248,3 @@
 #define vSR      0x1400  /* [VIA only] Shift register. */
-#define vACR     0x1600  /* [VIA only] Auxilary control register. */
+#define vACR     0x1600  /* [VIA only] Auxiliary control register. */
 #define vPCR     0x1800  /* [VIA only] Peripheral control register. */
diff --git a/hw/misc/stm32f2xx_syscfg.c b/hw/misc/stm32f2xx_syscfg.c
index 04c22c2850..19c1e86424 100644
--- a/hw/misc/stm32f2xx_syscfg.c
+++ b/hw/misc/stm32f2xx_syscfg.c
@@ -96,3 +96,3 @@ static void stm32f2xx_syscfg_write(void *opaque, hwaddr addr,
         qemu_log_mask(LOG_UNIMP,
-                      "%s: Changeing the memory mapping isn't supported " \
+                      "%s: Changing the memory mapping isn't supported " \
                       "in QEMU\n", __func__);
@@ -101,3 +101,3 @@ static void stm32f2xx_syscfg_write(void *opaque, hwaddr addr,
         qemu_log_mask(LOG_UNIMP,
-                      "%s: Changeing the memory mapping isn't supported " \
+                      "%s: Changing the memory mapping isn't supported " \
                       "in QEMU\n", __func__);
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 4d1a0e17af..bfd56ce9e2 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -157,3 +157,3 @@ stm32f4xx_syscfg_write(uint64_t addr, uint64_t data) "reg write: addr: 0x%" PRIx
 # stm32f4xx_exti.c
-stm32f4xx_exti_set_irq(int irq, int leve) "Set EXTI: %d to %d"
+stm32f4xx_exti_set_irq(int irq, int level) "Set EXTI: %d to %d"
 stm32f4xx_exti_read(uint64_t addr) "reg read: addr: 0x%" PRIx64 " "
diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
index 8b70285961..41f38a98e9 100644
--- a/hw/misc/zynq_slcr.c
+++ b/hw/misc/zynq_slcr.c
@@ -287,3 +287,3 @@ static void zynq_slcr_compute_clocks_internal(ZynqSLCRState *s, uint64_t ps_clk)
 /**
- * Compute and set the ouputs clocks periods.
+ * Compute and set the outputs clocks periods.
  * But do not propagate them further. Connected clocks
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 8e8e870b9a..c3e2f31c6c 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -19,3 +19,3 @@
  * While QEMU coding style prefers lowercase hexadecimals in constants, the
- * NVMe subsystem use thes format from the NVMe specifications in the comments
+ * NVMe subsystem use this format from the NVMe specifications in the comments
  * (i.e. 'h' suffix instead of '0x' prefix).
@@ -732,3 +732,3 @@ static inline void nvme_sg_unmap(NvmeSg *sg)
 /*
- * When metadata is transfered as extended LBAs, the DPTR mapped into `sg`
+ * When metadata is transferred as extended LBAs, the DPTR mapped into `sg`
  * holds both data and metadata. This function splits the data and metadata
@@ -7615,3 +7615,3 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
              * an invalid value to the Submission Queue Tail Doorbell or
-             * Completion Queue Head Doorbell regiter and an Asynchronous Event
+             * Completion Queue Head Doorbell register and an Asynchronous Event
              * Request command is outstanding, then an asynchronous event is
diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
index 613c4929e3..3272068663 100644
--- a/hw/nvram/eeprom_at24c.c
+++ b/hw/nvram/eeprom_at24c.c
@@ -53,3 +53,3 @@ struct EEPROMState {
     bool changed;
-    /* during WRITE, # of address bytes transfered */
+    /* during WRITE, # of address bytes transferred */
     uint8_t haveaddr;
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 29a5bef1d5..4e4524673a 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -879,3 +879,3 @@ static struct {
  * as we use aligned size in ram_load_precopy() -> qemu_ram_resize() path.
- * In order to avoid the inconsistency in sizes save them seperately and
+ * In order to avoid the inconsistency in sizes save them separately and
  * migrate over in vmstate post_load().
diff --git a/hw/rtc/exynos4210_rtc.c b/hw/rtc/exynos4210_rtc.c
index 2b8a38a296..cc7101c530 100644
--- a/hw/rtc/exynos4210_rtc.c
+++ b/hw/rtc/exynos4210_rtc.c
@@ -204,3 +204,3 @@ static void exynos4210_rtc_update_freq(Exynos4210RTCState *s,
     freq = s->freq;
-    /* set frequncy for time generator */
+    /* set frequency for time generator */
     s->freq = RTC_BASE_FREQ / (1 << TICCKSEL(reg_value));
diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
index 3e887a0fc7..d00fcb0ef0 100644
--- a/hw/rx/rx62n.c
+++ b/hw/rx/rx62n.c
@@ -116,3 +116,3 @@ static const uint8_t ipr_table[NR_IRQS] = {
 /*
- * Level triggerd IRQ list
+ * Level triggered IRQ list
  * Not listed IRQ is Edge trigger.
diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index f7d45b0b20..634ed49c2e 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -1323,3 +1323,3 @@ again:
                                              insn & (1 << 3) ? " ATN" : "");
-                /* ??? Linux drivers compain when this is set.  Maybe
+                /* ??? Linux drivers complain when this is set.  Maybe
                    it only applies in low-level mode (unimplemented).
diff --git a/hw/scsi/mfi.h b/hw/scsi/mfi.h
index 0b4ee53dfc..cf7a2d775b 100644
--- a/hw/scsi/mfi.h
+++ b/hw/scsi/mfi.h
@@ -67,3 +67,3 @@
 #define MFI_SEQ         0xfc            /* Sequencer offset */
-#define MFI_1078_EIM    0x80000004      /* 1078 enable intrrupt mask  */
+#define MFI_1078_EIM    0x80000004      /* 1078 enable interrupt mask  */
 #define MFI_RMI         0x2             /* reply message interrupt  */
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 77a717d355..43c374e829 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1226,3 +1226,3 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
-    /* Block read commands (Classs 2) */
+    /* Block read commands (Class 2) */
     case 16:  /* CMD16:  SET_BLOCKLEN */
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 6811f0f1a8..dda4c4c438 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1807,3 +1807,3 @@ usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
          * We don't want to call sdhci_write(.., SDHC_TRNMOD, ...)
-         * here becuase it will result in a call to
+         * here because it will result in a call to
          * sdhci_send_command(s) which we don't want.
diff --git a/hw/sensor/isl_pmbus_vr.c b/hw/sensor/isl_pmbus_vr.c
index eb344dd5a9..e51269f6b8 100644
--- a/hw/sensor/isl_pmbus_vr.c
+++ b/hw/sensor/isl_pmbus_vr.c
@@ -103,3 +103,3 @@ static void isl_pmbus_vr_exit_reset(Object *obj)
 
-/* The raa228000 uses different direct mode coefficents from most isl devices */
+/* The raa228000 uses different direct mode coefficients from most isl devices */
 static void raa228000_exit_reset(Object *obj)
diff --git a/hw/sensor/max34451.c b/hw/sensor/max34451.c
index a91d8bd487..9db52ef677 100644
--- a/hw/sensor/max34451.c
+++ b/hw/sensor/max34451.c
@@ -736,3 +736,3 @@ static void max34451_init(Object *obj)
      * get and set the temperature of the internal temperature sensor in
-     * centidegrees Celcius i.e.: 2500 -> 25.00 C, max is 327.67 C
+     * centidegrees Celsius i.e.: 2500 -> 25.00 C, max is 327.67 C
      */
diff --git a/hw/sh4/sh7750_regs.h b/hw/sh4/sh7750_regs.h
index 94043431e6..edb5d18f00 100644
--- a/hw/sh4/sh7750_regs.h
+++ b/hw/sh4/sh7750_regs.h
@@ -115,3 +115,3 @@
 
-/* TLB exeption address register - TEA */
+/* TLB exception address register - TEA */
 #define SH7750_TEA_REGOFS     0x00000c /* offset */
@@ -185,3 +185,3 @@
 
-/* Exeption event register - EXPEVT */
+/* Exception event register - EXPEVT */
 #define SH7750_EXPEVT_REGOFS  0x000024
@@ -190,3 +190,3 @@
 
-#define SH7750_EXPEVT_EX      0x00000fff /* Exeption code */
+#define SH7750_EXPEVT_EX      0x00000fff /* Exception code */
 #define SH7750_EXPEVT_EX_S    0
@@ -197,3 +197,3 @@
 #define SH7750_INTEVT_A7      SH7750_A7_REG32(SH7750_INTEVT_REGOFS)
-#define SH7750_INTEVT_EX    0x00000fff /* Exeption code */
+#define SH7750_INTEVT_EX    0x00000fff /* Exception code */
 #define SH7750_INTEVT_EX_S  0
@@ -1276,11 +1276,11 @@
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
diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 10cd22f610..b753705856 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -1112,3 +1112,3 @@ void smbios_get_tables(MachineState *ms,
         /*
-         * The offset determines if we need to keep additional space betweeen
+         * The offset determines if we need to keep additional space between
          * table 17 and table 19 header handle numbers so that they do
diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index 97009d3a5d..a3955c6c50 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -165,3 +165,3 @@
     FIELD(GQSPI_CNFG, EN_POLL_TIMEOUT, 20, 1)
-    /* QEMU doesnt care about any of these last three */
+    /* QEMU doesn't care about any of these last three */
     FIELD(GQSPI_CNFG, BR, 3, 3)
@@ -471,3 +471,3 @@ static void xlnx_zynqmp_qspips_flush_fifo_g(XlnxZynqMPQSPIPS *s)
             if (!ARRAY_FIELD_EX32(s->regs, GQSPI_GF_SNAPSHOT, DATA_XFER)) {
-                /* immedate transfer */
+                /* immediate transfer */
                 if (ARRAY_FIELD_EX32(s->regs, GQSPI_GF_SNAPSHOT, TRANSMIT) ||
@@ -770,3 +770,3 @@ static void xilinx_spips_check_zero_pump(XilinxSPIPS *s)
            s->rx_fifo.num + s->tx_fifo.num < RXFF_A_Q - 3) {
-        /* endianess just doesn't matter when zero pumping */
+        /* endianness just doesn't matter when zero pumping */
         tx_data_bytes(&s->tx_fifo, 0, 4, false);
diff --git a/hw/ssi/xlnx-versal-ospi.c b/hw/ssi/xlnx-versal-ospi.c
index c762e0b367..1a61679c2f 100644
--- a/hw/ssi/xlnx-versal-ospi.c
+++ b/hw/ssi/xlnx-versal-ospi.c
@@ -839,3 +839,3 @@ static void ospi_do_ind_read(XlnxVersalOspi *s)
            !fifo8_is_full(&s->rx_sram)) {
-        /* Read reqested number of bytes, max bytes limited to size of sram */
+        /* Read requested number of bytes, max bytes limited to size of sram */
         next_b = ind_op_next_byte(op);
diff --git a/hw/timer/etraxfs_timer.c b/hw/timer/etraxfs_timer.c
index 2d6d92ef93..f035b74560 100644
--- a/hw/timer/etraxfs_timer.c
+++ b/hw/timer/etraxfs_timer.c
@@ -238,3 +238,3 @@ static void watchdog_hit(void *opaque)
     if (t->wd_hits == 0) {
-        /* real hw gives a single tick before reseting but we are
+        /* real hw gives a single tick before resetting but we are
            a bit friendlier to compensate for our slower execution.  */
diff --git a/hw/timer/i8254.c b/hw/timer/i8254.c
index c235496fc9..dd13bdfa42 100644
--- a/hw/timer/i8254.c
+++ b/hw/timer/i8254.c
@@ -297,3 +297,3 @@ static void pit_reset(DeviceState *dev)
 /* When HPET is operating in legacy mode, suppress the ignored timer IRQ,
- * reenable it when legacy mode is left again. */
+ * re-enable it when legacy mode is left again. */
 static void pit_irq_control(void *opaque, int n, int enable)
diff --git a/hw/timer/renesas_tmr.c b/hw/timer/renesas_tmr.c
index c15f654738..43b31213bc 100644
--- a/hw/timer/renesas_tmr.c
+++ b/hw/timer/renesas_tmr.c
@@ -117,3 +117,3 @@ static int elapsed_time(RTMRState *tmr, int ch, int64_t delta)
     } else {
-        /* disble clock. so no update */
+        /* disable clock. so no update */
         et = 0;
diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 44faf5a522..e9bc5695cf 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -652,3 +652,3 @@ virtio_crypto_sym_op_helper(VirtIODevice *vdev,
     op_info->len_to_cipher = len_to_cipher;
-    /* Handle the initilization vector */
+    /* Handle the initialization vector */
     if (op_info->iv_len > 0) {
@@ -1275,3 +1275,3 @@ static void virtio_crypto_instance_init(Object *obj)
      * The default config_size is sizeof(struct virtio_crypto_config).
-     * Can be overriden with virtio_crypto_set_config_size.
+     * Can be overridden with virtio_crypto_set_config_size.
      */
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index b6e781741e..da5b09cefc 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -1121,3 +1121,3 @@ static int virtio_mem_mig_sanity_checks_post_load(void *opaque, int version_id)
     /*
-     * Note: Preparation for resizeable memory regions. The maximum size
+     * Note: Preparation for resizable memory regions. The maximum size
      * of the memory region must not change during migration.
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 295a603e58..c85ce8ac47 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2098,3 +2098,3 @@ void virtio_queue_enable(VirtIODevice *vdev, uint32_t queue_index)
     if (!virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
-        error_report("queue_enable is only suppported in devices of virtio "
+        error_report("queue_enable is only supported in devices of virtio "
                      "1.0 or later.");
-- 
2.39.2


