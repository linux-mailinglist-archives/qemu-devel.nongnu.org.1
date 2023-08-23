Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0373785035
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 07:55:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYgoa-0004pL-Ke; Wed, 23 Aug 2023 01:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qYgoS-0004Id-73
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 01:53:54 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qYgoN-0007SV-El
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 01:53:51 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9A9F61C3A1
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 08:52:22 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 41F3D21249;
 Wed, 23 Aug 2023 08:52:04 +0300 (MSK)
Received: (nullmailer pid 1917513 invoked by uid 1000);
 Wed, 23 Aug 2023 05:52:00 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 20/24] include/: spelling fixes
Date: Wed, 23 Aug 2023 08:51:51 +0300
Message-Id: <20230823055155.1917375-21-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1691405748.git.mjt@tls.msk.ru>
References: <cover.1691405748.git.mjt@tls.msk.ru>
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
---
 include/block/block_int-common.h | 2 +-
 include/chardev/char-fe.h        | 4 ++--
 include/crypto/akcipher.h        | 2 +-
 include/crypto/ivgen.h           | 4 ++--
 include/elf.h                    | 4 ++--
 include/hw/acpi/aml-build.h      | 2 +-
 include/hw/acpi/pc-hotplug.h     | 2 +-
 include/hw/acpi/vmgenid.h        | 2 +-
 include/hw/boards.h              | 6 +++---
 include/hw/char/avr_usart.h      | 2 +-
 include/hw/clock.h               | 2 +-
 include/hw/core/tcg-cpu-ops.h    | 2 +-
 include/hw/cxl/cxl_device.h      | 2 +-
 include/hw/hyperv/vmbus.h        | 2 +-
 include/hw/i2c/npcm7xx_smbus.h   | 2 +-
 include/hw/misc/auxbus.h         | 2 +-
 include/hw/misc/macio/pmu.h      | 2 +-
 include/hw/net/mii.h             | 2 +-
 include/hw/pci-host/dino.h       | 2 +-
 include/hw/pci/pcie_aer.h        | 2 +-
 include/hw/ssi/xilinx_spips.h    | 2 +-
 include/hw/virtio/virtio-net.h   | 2 +-
 include/io/channel-socket.h      | 4 ++--
 include/io/task.h                | 2 +-
 include/qemu/iova-tree.h         | 4 ++--
 include/qemu/yank.h              | 2 +-
 include/sysemu/cryptodev-vhost.h | 2 +-
 include/sysemu/cryptodev.h       | 6 +++---
 include/sysemu/iothread.h        | 2 +-
 include/sysemu/stats.h           | 2 +-
 include/sysemu/tpm_backend.h     | 2 +-
 include/tcg/helper-info.h        | 2 +-
 include/tcg/tcg.h                | 4 ++--
 include/ui/kbd-state.h           | 2 +-
 include/ui/spice-display.h       | 2 +-
 include/user/safe-syscall.h      | 2 +-
 36 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 74195c3004..e09d277328 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -419,5 +419,5 @@ struct BlockDriver {
     /**
      * Called to inform the driver that the set of cumulative set of used
-     * permissions for @bs has changed to @perm, and the set of sharable
+     * permissions for @bs has changed to @perm, and the set of shareable
      * permission to @shared. The driver can use this to propagate changes to
      * its children (i.e. request permissions only if a parent actually needs
diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
index 8c420fa36e..82a2a92602 100644
--- a/include/chardev/char-fe.h
+++ b/include/chardev/char-fe.h
@@ -79,5 +79,5 @@ bool qemu_chr_fe_backend_open(CharBackend *be);
  * @opaque: an opaque pointer for the callbacks
  * @context: a main loop context or NULL for the default
- * @set_open: whether to call qemu_chr_fe_set_open() implicitely when
+ * @set_open: whether to call qemu_chr_fe_set_open() implicitly when
  * any of the handler is non-NULL
  * @sync_state: whether to issue event callback with updated state
@@ -139,5 +139,5 @@ void qemu_chr_fe_disconnect(CharBackend *be);
  * qemu_chr_fe_wait_connected:
  *
- * Wait for characted backend to be connected, return < 0 on error or
+ * Wait for character backend to be connected, return < 0 on error or
  * if no associated Chardev.
  */
diff --git a/include/crypto/akcipher.h b/include/crypto/akcipher.h
index 214e58ca47..8756105f22 100644
--- a/include/crypto/akcipher.h
+++ b/include/crypto/akcipher.h
@@ -31,5 +31,5 @@ typedef struct QCryptoAkCipher QCryptoAkCipher;
  * @opts: the asymmetric key algorithm and related options
  *
- * Determine if asymmetric key cipher decribed with @opts is
+ * Determine if asymmetric key cipher described with @opts is
  * supported by the current configured build
  *
diff --git a/include/crypto/ivgen.h b/include/crypto/ivgen.h
index e41521519c..a09d5732da 100644
--- a/include/crypto/ivgen.h
+++ b/include/crypto/ivgen.h
@@ -33,5 +33,5 @@
  *
  * <example>
- *   <title>Encrypting block data with initialiation vectors</title>
+ *   <title>Encrypting block data with initialization vectors</title>
  *   <programlisting>
  * uint8_t *data = ....data to encrypt...
@@ -148,5 +148,5 @@ QCryptoIVGen *qcrypto_ivgen_new(QCryptoIVGenAlgorithm alg,
  * @errp: pointer to a NULL-initialized error object
  *
- * Calculate a new initialiation vector for the data
+ * Calculate a new initialization vector for the data
  * to be stored in sector @sector. The IV will be
  * written into the buffer @iv of size @niv.
diff --git a/include/elf.h b/include/elf.h
index ec9755e73b..e7259ec366 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -1126,7 +1126,7 @@ typedef struct {
 #define EFA_PARISC_2_0      0x0214 /* PA-RISC 2.0 big-endian.  */
 
-/* Additional section indeces.  */
+/* Additional section indices.  */
 
-#define SHN_PARISC_ANSI_COMMON  0xff00   /* Section for tenatively declared
+#define SHN_PARISC_ANSI_COMMON  0xff00   /* Section for tentatively declared
                                               symbols in ANSI C.  */
 #define SHN_PARISC_HUGE_COMMON  0xff01   /* Common blocks in huge model.  */
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index d1fb08514b..ff2a310270 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -278,5 +278,5 @@ void free_aml_allocator(void);
  *
  * Joins Aml elements together and helps to construct AML tables
- * Examle of usage:
+ * Example of usage:
  *   Aml *table = aml_def_block("SSDT", ...);
  *   Aml *sb = aml_scope("\\_SB");
diff --git a/include/hw/acpi/pc-hotplug.h b/include/hw/acpi/pc-hotplug.h
index 31bc9191c3..8a654248e9 100644
--- a/include/hw/acpi/pc-hotplug.h
+++ b/include/hw/acpi/pc-hotplug.h
@@ -14,5 +14,5 @@
 
 /*
- * ONLY DEFINEs are permited in this file since it's shared
+ * ONLY DEFINEs are permitted in this file since it's shared
  * between C and ASL code.
  */
diff --git a/include/hw/acpi/vmgenid.h b/include/hw/acpi/vmgenid.h
index dc8bb3433e..fb135d5bcb 100644
--- a/include/hw/acpi/vmgenid.h
+++ b/include/hw/acpi/vmgenid.h
@@ -14,5 +14,5 @@
 #define VMGENID_FW_CFG_SIZE      4096 /* Occupy a page of memory */
 #define VMGENID_GUID_OFFSET      40   /* allow space for
-                                       * OVMF SDT Header Probe Supressor
+                                       * OVMF SDT Header Probe Suppressor
                                        */
 
diff --git a/include/hw/boards.h b/include/hw/boards.h
index ed83360198..19a70ec04a 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -159,5 +159,5 @@ typedef struct {
  * @cpu_index_to_instance_props:
  *    used to provide @cpu_index to socket/core/thread number mapping, allowing
- *    legacy code to perform maping from cpu_index to topology properties
+ *    legacy code to perform mapping from cpu_index to topology properties
  *    Returns: tuple of socket/core/thread ids given cpu_index belongs to.
  *    used to provide @cpu_index to socket number mapping, allowing
@@ -212,8 +212,8 @@ typedef struct {
  *    allowed.
  * @default_ram_id:
- *    Specifies inital RAM MemoryRegion name to be used for default backend
+ *    Specifies initial RAM MemoryRegion name to be used for default backend
  *    creation if user explicitly hasn't specified backend with "memory-backend"
  *    property.
- *    It also will be used as a way to optin into "-m" option support.
+ *    It also will be used as a way to option into "-m" option support.
  *    If it's not set by board, '-m' will be ignored and generic code will
  *    not create default RAM MemoryRegion.
diff --git a/include/hw/char/avr_usart.h b/include/hw/char/avr_usart.h
index 62eaa1528e..0cc599e9b1 100644
--- a/include/hw/char/avr_usart.h
+++ b/include/hw/char/avr_usart.h
@@ -35,5 +35,5 @@
 #define USART_BRRL 0x04
 
-/* Relevant bits in regiters. */
+/* Relevant bits in registers. */
 #define USART_CSRA_RXC    (1 << 7)
 #define USART_CSRA_TXC    (1 << 6)
diff --git a/include/hw/clock.h b/include/hw/clock.h
index 5c927cee7f..bb12117f67 100644
--- a/include/hw/clock.h
+++ b/include/hw/clock.h
@@ -205,5 +205,5 @@ static inline bool clock_set_ns(Clock *clk, unsigned ns)
  * @clock_set(). This will update recursively all connected clocks.
  * It is an error to call this function on a clock which has a source.
- * Note: this function must not be called during device inititialization
+ * Note: this function must not be called during device initialization
  * or migration.
  */
diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
index 3e8b1b737a..479713a36e 100644
--- a/include/hw/core/tcg-cpu-ops.h
+++ b/include/hw/core/tcg-cpu-ops.h
@@ -15,5 +15,5 @@
 struct TCGCPUOps {
     /**
-     * @initialize: Initalize TCG state
+     * @initialize: Initialize TCG state
      *
      * Called when the first CPU is realized.
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 1978730fba..f717e3f384 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -209,5 +209,5 @@ void cxl_event_set_status(CXLDeviceState *cxl_dstate, CXLEventLogType log_type,
  * > followed, the behavior is undefined
  *
- * CXL 2.0 Errata F4 states futher that the layouts in the specification are
+ * CXL 2.0 Errata F4 states further that the layouts in the specification are
  * shown as greater than 128 bits, but implementations are expected to
  * use any size of access up to 64 bits.
diff --git a/include/hw/hyperv/vmbus.h b/include/hw/hyperv/vmbus.h
index 8ea660dd8e..5c505852f2 100644
--- a/include/hw/hyperv/vmbus.h
+++ b/include/hw/hyperv/vmbus.h
@@ -52,5 +52,5 @@ struct VMBusDeviceClass {
     uint16_t mmio_size_mb;
 
-    /* Extentions to standard device callbacks */
+    /* Extensions to standard device callbacks */
     void (*vmdev_realize)(VMBusDevice *vdev, Error **errp);
     void (*vmdev_unrealize)(VMBusDevice *vdev);
diff --git a/include/hw/i2c/npcm7xx_smbus.h b/include/hw/i2c/npcm7xx_smbus.h
index 3555e6836f..dc45963c0e 100644
--- a/include/hw/i2c/npcm7xx_smbus.h
+++ b/include/hw/i2c/npcm7xx_smbus.h
@@ -59,5 +59,5 @@ typedef enum NPCM7xxSMBusStatus {
  * @fif_ctl: The FIFO control register.
  * @fif_cts: The FIFO control status register.
- * @fair_per: The fair preriod register.
+ * @fair_per: The fair period register.
  * @txf_ctl: The transmit FIFO control register.
  * @t_out: The SMBus timeout register.
diff --git a/include/hw/misc/auxbus.h b/include/hw/misc/auxbus.h
index b05799d2f7..03cacdee42 100644
--- a/include/hw/misc/auxbus.h
+++ b/include/hw/misc/auxbus.h
@@ -107,5 +107,5 @@ void aux_bus_realize(AUXBus *bus);
  * Returns the reply of the request.
  *
- * @bus Ths bus where the request happen.
+ * @bus The bus where the request happen.
  * @cmd The command requested.
  * @address The 20bits address of the slave.
diff --git a/include/hw/misc/macio/pmu.h b/include/hw/misc/macio/pmu.h
index ba76afb52a..ceb12082ae 100644
--- a/include/hw/misc/macio/pmu.h
+++ b/include/hw/misc/macio/pmu.h
@@ -77,5 +77,5 @@
 #define PMU_INT_AUTO_SRQ_POLL      0x02    /* ??? */
 
-/* Bits in the environement message (either obtained via PMU_GET_COVER,
+/* Bits in the environment message (either obtained via PMU_GET_COVER,
  * or via PMU_INT_ENVIRONMENT on core99 */
 #define PMU_ENV_LID_CLOSED     0x01    /* The lid is closed */
diff --git a/include/hw/net/mii.h b/include/hw/net/mii.h
index ed1bb52b0f..f7feddac9b 100644
--- a/include/hw/net/mii.h
+++ b/include/hw/net/mii.h
@@ -72,5 +72,5 @@
 #define MII_BMSR_EXTCAP     (1 << 0)  /* Ext-reg capability */
 
-#define MII_ANAR_PAUSE_ASYM (1 << 11) /* Try for asymetric pause */
+#define MII_ANAR_PAUSE_ASYM (1 << 11) /* Try for asymmetric pause */
 #define MII_ANAR_PAUSE      (1 << 10) /* Try for pause */
 #define MII_ANAR_TXFD       (1 << 8)
diff --git a/include/hw/pci-host/dino.h b/include/hw/pci-host/dino.h
index a1b0184940..fd7975c798 100644
--- a/include/hw/pci-host/dino.h
+++ b/include/hw/pci-host/dino.h
@@ -1,4 +1,4 @@
 /*
- * HP-PARISC Dino PCI chipset emulation, as in B160L and similiar machines
+ * HP-PARISC Dino PCI chipset emulation, as in B160L and similar machines
  *
  * (C) 2017-2019 by Helge Deller <deller@gmx.de>
diff --git a/include/hw/pci/pcie_aer.h b/include/hw/pci/pcie_aer.h
index 1234fdc4e2..4a9f0ea69d 100644
--- a/include/hw/pci/pcie_aer.h
+++ b/include/hw/pci/pcie_aer.h
@@ -41,5 +41,5 @@ struct PCIEAERLog {
      * to avoid unreasonable memory usage.
      * I bet that 128 log size would be big enough, otherwise too many errors
-     * for system to function normaly. But could consecutive errors occur?
+     * for system to function normally. But could consecutive errors occur?
      */
 #define PCIE_AER_LOG_MAX_DEFAULT        8
diff --git a/include/hw/ssi/xilinx_spips.h b/include/hw/ssi/xilinx_spips.h
index 06bfd18312..1386d5ac8f 100644
--- a/include/hw/ssi/xilinx_spips.h
+++ b/include/hw/ssi/xilinx_spips.h
@@ -105,5 +105,5 @@ struct XlnxZynqMPQSPIPS {
     uint32_t regs[XLNX_ZYNQMP_SPIPS_R_MAX];
 
-    /* GQSPI has seperate tx/rx fifos */
+    /* GQSPI has separate tx/rx fifos */
     Fifo8 rx_fifo_g;
     Fifo8 tx_fifo_g;
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 5f5dcb4572..e07a723027 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -110,5 +110,5 @@ typedef struct VirtioNetRscSeg {
     uint16_t packets;
     uint16_t dup_ack;
-    bool is_coalesced;      /* need recal ipv4 header checksum, mark here */
+    bool is_coalesced;      /* need recall ipv4 header checksum, mark here */
     VirtioNetRscUnit unit;
     NetClientState *nc;
diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
index 513c428fe4..ab15577d38 100644
--- a/include/io/channel-socket.h
+++ b/include/io/channel-socket.h
@@ -125,5 +125,5 @@ void qio_channel_socket_connect_async(QIOChannelSocket *ioc,
  * @ioc: the socket channel object
  * @addr: the address to listen to
- * @num: the expected ammount of connections
+ * @num: the expected amount of connections
  * @errp: pointer to a NULL-initialized error object
  *
@@ -142,5 +142,5 @@ int qio_channel_socket_listen_sync(QIOChannelSocket *ioc,
  * @ioc: the socket channel object
  * @addr: the address to listen to
- * @num: the expected ammount of connections
+ * @num: the expected amount of connections
  * @callback: the function to invoke on completion
  * @opaque: user data to pass to @callback
diff --git a/include/io/task.h b/include/io/task.h
index beec4f5cfd..dc7d32ebd0 100644
--- a/include/io/task.h
+++ b/include/io/task.h
@@ -146,5 +146,5 @@ typedef void (*QIOTaskWorker)(QIOTask *task,
  * in a background thread context, while still reporting the
  * results in the main event thread. This allows code which
- * cannot easily be rewritten to be asychronous (such as DNS
+ * cannot easily be rewritten to be asynchronous (such as DNS
  * lookups) to be easily run non-blocking. Reporting the
  * results in the main thread context means that the caller
diff --git a/include/qemu/iova-tree.h b/include/qemu/iova-tree.h
index 8528e5c98f..2a10a7052e 100644
--- a/include/qemu/iova-tree.h
+++ b/include/qemu/iova-tree.h
@@ -16,5 +16,5 @@
  * information, and no extra user data is allowed for each element.  A
  * benefit is that we can merge adjacent ranges internally within the
- * tree.  It can save a lot of memory when the ranges are splitted but
+ * tree.  It can save a lot of memory when the ranges are split but
  * mostly continuous.
  *
@@ -129,5 +129,5 @@ const DMAMap *iova_tree_find_address(const IOVATree *tree, hwaddr iova);
  *
  * @tree: the iova tree to iterate on
- * @iterator: the interator for the mappings, return true to stop
+ * @iterator: the iterator for the mappings, return true to stop
  *
  * Iterate over the iova tree.
diff --git a/include/qemu/yank.h b/include/qemu/yank.h
index 5375a1f195..1907150933 100644
--- a/include/qemu/yank.h
+++ b/include/qemu/yank.h
@@ -26,5 +26,5 @@ typedef void (YankFn)(void *opaque);
  * @errp: Error object.
  *
- * Returns true on success or false if an error occured.
+ * Returns true on success or false if an error occurred.
  */
 bool yank_register_instance(const YankInstance *instance, Error **errp);
diff --git a/include/sysemu/cryptodev-vhost.h b/include/sysemu/cryptodev-vhost.h
index e8cab1356e..4c3c22acae 100644
--- a/include/sysemu/cryptodev-vhost.h
+++ b/include/sysemu/cryptodev-vhost.h
@@ -80,5 +80,5 @@ cryptodev_vhost_init(
  * @crypto: the cryptodev backend common vhost object
  *
- * Clean the resouce associated with @crypto that realizaed
+ * Clean the resource associated with @crypto that realizaed
  * by cryptodev_vhost_init()
  *
diff --git a/include/sysemu/cryptodev.h b/include/sysemu/cryptodev.h
index bc021ce847..96d3998b93 100644
--- a/include/sysemu/cryptodev.h
+++ b/include/sysemu/cryptodev.h
@@ -340,5 +340,5 @@ void cryptodev_backend_free_client(
  * @errp: pointer to a NULL-initialized error object
  *
- * Clean the resouce associated with @backend that realizaed
+ * Clean the resource associated with @backend that realizaed
  * by the specific backend's init() callback
  */
@@ -408,5 +408,5 @@ int cryptodev_backend_crypto_operation(
  * cryptodev_backend_set_used:
  * @backend: the cryptodev backend object
- * @used: ture or false
+ * @used: true or false
  *
  * Set the cryptodev backend is used by virtio-crypto or not
@@ -428,5 +428,5 @@ bool cryptodev_backend_is_used(CryptoDevBackend *backend);
  * cryptodev_backend_set_ready:
  * @backend: the cryptodev backend object
- * @ready: ture or false
+ * @ready: true or false
  *
  * Set the cryptodev backend is ready or not, which is called
diff --git a/include/sysemu/iothread.h b/include/sysemu/iothread.h
index 8f8601d6ab..2102a90eca 100644
--- a/include/sysemu/iothread.h
+++ b/include/sysemu/iothread.h
@@ -60,5 +60,5 @@ void iothread_destroy(IOThread *iothread);
 
 /*
- * Returns true if executing withing IOThread context,
+ * Returns true if executing within IOThread context,
  * false otherwise.
  */
diff --git a/include/sysemu/stats.h b/include/sysemu/stats.h
index fcf0983154..42c236c795 100644
--- a/include/sysemu/stats.h
+++ b/include/sysemu/stats.h
@@ -35,5 +35,5 @@ void add_stats_schema(StatsSchemaList **, StatsProvider, StatsTarget,
 
 /*
- * True if a string matches the filter passed to the stats_fn callabck,
+ * True if a string matches the filter passed to the stats_fn callback,
  * false otherwise.
  *
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index 8fd3269c11..7fabafefee 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -116,5 +116,5 @@ int tpm_backend_startup_tpm(TPMBackend *s, size_t buffersize);
 /**
  * tpm_backend_had_startup_error:
- * @s: the backend to query for a statup error
+ * @s: the backend to query for a startup error
  *
  * Check whether the backend had an error during startup. Returns
diff --git a/include/tcg/helper-info.h b/include/tcg/helper-info.h
index 4b6c9b43e8..7c27d6164a 100644
--- a/include/tcg/helper-info.h
+++ b/include/tcg/helper-info.h
@@ -1,4 +1,4 @@
 /*
- * TCG Helper Infomation Structure
+ * TCG Helper Information Structure
  *
  * Copyright (c) 2023 Linaro Ltd
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 0875971719..f2b0eaa6da 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -880,5 +880,5 @@ enum {
     TCG_OPF_64BIT        = 0x10,
     /* Instruction is optional and not implemented by the host, or insn
-       is generic and should not be implemened by the host.  */
+       is generic and should not be implemented by the host.  */
     TCG_OPF_NOT_PRESENT  = 0x20,
     /* Instruction operands are vectors.  */
@@ -1124,5 +1124,5 @@ static inline int tcg_can_emit_vec_op(TCGOpcode o, TCGType t, unsigned ve)
 void tcg_expand_vec_op(TCGOpcode, TCGType, unsigned, TCGArg, ...);
 
-/* Replicate a constant C accoring to the log2 of the element size.  */
+/* Replicate a constant C according to the log2 of the element size.  */
 uint64_t dup_const(unsigned vece, uint64_t c);
 
diff --git a/include/ui/kbd-state.h b/include/ui/kbd-state.h
index eb9067dd53..fb79776128 100644
--- a/include/ui/kbd-state.h
+++ b/include/ui/kbd-state.h
@@ -66,5 +66,5 @@ void qkbd_state_key_event(QKbdState *kbd, QKeyCode qcode, bool down);
  *
  * @kbd: state tracker state.
- * @delay_ms: the delay in miliseconds.
+ * @delay_ms: the delay in milliseconds.
  */
 void qkbd_state_set_delay(QKbdState *kbd, int delay_ms);
diff --git a/include/ui/spice-display.h b/include/ui/spice-display.h
index 5aa13664d6..e1a9b36185 100644
--- a/include/ui/spice-display.h
+++ b/include/ui/spice-display.h
@@ -43,5 +43,5 @@
 
 /*
- * Internal enum to differenciate between options for
+ * Internal enum to differentiate between options for
  * io calls that have a sync (old) version and an _async (new)
  * version:
diff --git a/include/user/safe-syscall.h b/include/user/safe-syscall.h
index ddceef12e2..195cedac04 100644
--- a/include/user/safe-syscall.h
+++ b/include/user/safe-syscall.h
@@ -92,5 +92,5 @@
  * The basic setup is that we make the host syscall via a known
  * section of host native assembly. If a signal occurs, our signal
- * handler checks the interrupted host PC against the addresse of that
+ * handler checks the interrupted host PC against the address of that
  * known section. If the PC is before or at the address of the syscall
  * instruction then we change the PC to point at a "return
-- 
2.39.2


