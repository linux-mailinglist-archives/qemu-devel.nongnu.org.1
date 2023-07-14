Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEB7753A10
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 13:47:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKHDQ-0006re-8C; Fri, 14 Jul 2023 07:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKHAH-0002al-L3; Fri, 14 Jul 2023 07:40:54 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKHAE-0004fm-8B; Fri, 14 Jul 2023 07:40:48 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EB4A113DA5;
 Fri, 14 Jul 2023 14:38:58 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id E713214BB4;
 Fri, 14 Jul 2023 14:38:42 +0300 (MSK)
Received: (nullmailer pid 1186271 invoked by uid 1000);
 Fri, 14 Jul 2023 11:38:38 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH, trivial 25/29] tree-wide spelling fixes in comments and some
 messages: include/
Date: Fri, 14 Jul 2023 14:38:30 +0300
Message-Id: <20230714113834.1186117-27-mjt@tls.msk.ru>
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
 include/block/block_int-common.h | 2 +-
 include/chardev/char-fe.h        | 4 ++--
 include/crypto/akcipher.h        | 2 +-
 include/crypto/ivgen.h           | 4 ++--
 include/elf.h                    | 4 ++--
 include/exec/memory.h            | 2 +-
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
 include/qemu/timer.h             | 2 +-
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
 38 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 74195c3004..e09d277328 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -420,3 +420,3 @@ struct BlockDriver {
      * Called to inform the driver that the set of cumulative set of used
-     * permissions for @bs has changed to @perm, and the set of sharable
+     * permissions for @bs has changed to @perm, and the set of shareable
      * permission to @shared. The driver can use this to propagate changes to
diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
index 8c420fa36e..82a2a92602 100644
--- a/include/chardev/char-fe.h
+++ b/include/chardev/char-fe.h
@@ -80,3 +80,3 @@ bool qemu_chr_fe_backend_open(CharBackend *be);
  * @context: a main loop context or NULL for the default
- * @set_open: whether to call qemu_chr_fe_set_open() implicitely when
+ * @set_open: whether to call qemu_chr_fe_set_open() implicitly when
  * any of the handler is non-NULL
@@ -140,3 +140,3 @@ void qemu_chr_fe_disconnect(CharBackend *be);
  *
- * Wait for characted backend to be connected, return < 0 on error or
+ * Wait for character backend to be connected, return < 0 on error or
  * if no associated Chardev.
diff --git a/include/crypto/akcipher.h b/include/crypto/akcipher.h
index 214e58ca47..8756105f22 100644
--- a/include/crypto/akcipher.h
+++ b/include/crypto/akcipher.h
@@ -32,3 +32,3 @@ typedef struct QCryptoAkCipher QCryptoAkCipher;
  *
- * Determine if asymmetric key cipher decribed with @opts is
+ * Determine if asymmetric key cipher described with @opts is
  * supported by the current configured build
diff --git a/include/crypto/ivgen.h b/include/crypto/ivgen.h
index e41521519c..a09d5732da 100644
--- a/include/crypto/ivgen.h
+++ b/include/crypto/ivgen.h
@@ -34,3 +34,3 @@
  * <example>
- *   <title>Encrypting block data with initialiation vectors</title>
+ *   <title>Encrypting block data with initialization vectors</title>
  *   <programlisting>
@@ -149,3 +149,3 @@ QCryptoIVGen *qcrypto_ivgen_new(QCryptoIVGenAlgorithm alg,
  *
- * Calculate a new initialiation vector for the data
+ * Calculate a new initialization vector for the data
  * to be stored in sector @sector. The IV will be
diff --git a/include/elf.h b/include/elf.h
index 2f4d0e56d1..7bbd419205 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -1099,5 +1099,5 @@ typedef struct {
 
-/* Additional section indeces.  */
+/* Additional section indices.  */
 
-#define SHN_PARISC_ANSI_COMMON  0xff00   /* Section for tenatively declared
+#define SHN_PARISC_ANSI_COMMON  0xff00   /* Section for tentatively declared
                                               symbols in ANSI C.  */
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 7f5c11a0cc..68284428f8 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -944,3 +944,3 @@ struct MemoryListener {
      * @last_stage: The last stage to synchronize the log during migration.
-     * The caller should gurantee that the synchronization with true for
+     * The caller should guarantee that the synchronization with true for
      * @last_stage is triggered for once after all VCPUs have been stopped.
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index d1fb08514b..ff2a310270 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -279,3 +279,3 @@ void free_aml_allocator(void);
  * Joins Aml elements together and helps to construct AML tables
- * Examle of usage:
+ * Example of usage:
  *   Aml *table = aml_def_block("SSDT", ...);
diff --git a/include/hw/acpi/pc-hotplug.h b/include/hw/acpi/pc-hotplug.h
index 31bc9191c3..8a654248e9 100644
--- a/include/hw/acpi/pc-hotplug.h
+++ b/include/hw/acpi/pc-hotplug.h
@@ -15,3 +15,3 @@
 /*
- * ONLY DEFINEs are permited in this file since it's shared
+ * ONLY DEFINEs are permitted in this file since it's shared
  * between C and ASL code.
diff --git a/include/hw/acpi/vmgenid.h b/include/hw/acpi/vmgenid.h
index dc8bb3433e..fb135d5bcb 100644
--- a/include/hw/acpi/vmgenid.h
+++ b/include/hw/acpi/vmgenid.h
@@ -15,3 +15,3 @@
 #define VMGENID_GUID_OFFSET      40   /* allow space for
-                                       * OVMF SDT Header Probe Supressor
+                                       * OVMF SDT Header Probe Suppressor
                                        */
diff --git a/include/hw/boards.h b/include/hw/boards.h
index ed83360198..19a70ec04a 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -160,3 +160,3 @@ typedef struct {
  *    used to provide @cpu_index to socket/core/thread number mapping, allowing
- *    legacy code to perform maping from cpu_index to topology properties
+ *    legacy code to perform mapping from cpu_index to topology properties
  *    Returns: tuple of socket/core/thread ids given cpu_index belongs to.
@@ -213,6 +213,6 @@ typedef struct {
  * @default_ram_id:
- *    Specifies inital RAM MemoryRegion name to be used for default backend
+ *    Specifies initial RAM MemoryRegion name to be used for default backend
  *    creation if user explicitly hasn't specified backend with "memory-backend"
  *    property.
- *    It also will be used as a way to optin into "-m" option support.
+ *    It also will be used as a way to option into "-m" option support.
  *    If it's not set by board, '-m' will be ignored and generic code will
diff --git a/include/hw/char/avr_usart.h b/include/hw/char/avr_usart.h
index 62eaa1528e..0cc599e9b1 100644
--- a/include/hw/char/avr_usart.h
+++ b/include/hw/char/avr_usart.h
@@ -36,3 +36,3 @@
 
-/* Relevant bits in regiters. */
+/* Relevant bits in registers. */
 #define USART_CSRA_RXC    (1 << 7)
diff --git a/include/hw/clock.h b/include/hw/clock.h
index 5c927cee7f..bb12117f67 100644
--- a/include/hw/clock.h
+++ b/include/hw/clock.h
@@ -206,3 +206,3 @@ static inline bool clock_set_ns(Clock *clk, unsigned ns)
  * It is an error to call this function on a clock which has a source.
- * Note: this function must not be called during device inititialization
+ * Note: this function must not be called during device initialization
  * or migration.
diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
index 3e8b1b737a..479713a36e 100644
--- a/include/hw/core/tcg-cpu-ops.h
+++ b/include/hw/core/tcg-cpu-ops.h
@@ -16,3 +16,3 @@ struct TCGCPUOps {
     /**
-     * @initialize: Initalize TCG state
+     * @initialize: Initialize TCG state
      *
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 1978730fba..f717e3f384 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -210,3 +210,3 @@ void cxl_event_set_status(CXLDeviceState *cxl_dstate, CXLEventLogType log_type,
  *
- * CXL 2.0 Errata F4 states futher that the layouts in the specification are
+ * CXL 2.0 Errata F4 states further that the layouts in the specification are
  * shown as greater than 128 bits, but implementations are expected to
diff --git a/include/hw/hyperv/vmbus.h b/include/hw/hyperv/vmbus.h
index 8ea660dd8e..5c505852f2 100644
--- a/include/hw/hyperv/vmbus.h
+++ b/include/hw/hyperv/vmbus.h
@@ -53,3 +53,3 @@ struct VMBusDeviceClass {
 
-    /* Extentions to standard device callbacks */
+    /* Extensions to standard device callbacks */
     void (*vmdev_realize)(VMBusDevice *vdev, Error **errp);
diff --git a/include/hw/i2c/npcm7xx_smbus.h b/include/hw/i2c/npcm7xx_smbus.h
index 3555e6836f..dc45963c0e 100644
--- a/include/hw/i2c/npcm7xx_smbus.h
+++ b/include/hw/i2c/npcm7xx_smbus.h
@@ -60,3 +60,3 @@ typedef enum NPCM7xxSMBusStatus {
  * @fif_cts: The FIFO control status register.
- * @fair_per: The fair preriod register.
+ * @fair_per: The fair period register.
  * @txf_ctl: The transmit FIFO control register.
diff --git a/include/hw/misc/auxbus.h b/include/hw/misc/auxbus.h
index b05799d2f7..03cacdee42 100644
--- a/include/hw/misc/auxbus.h
+++ b/include/hw/misc/auxbus.h
@@ -108,3 +108,3 @@ void aux_bus_realize(AUXBus *bus);
  *
- * @bus Ths bus where the request happen.
+ * @bus The bus where the request happen.
  * @cmd The command requested.
diff --git a/include/hw/misc/macio/pmu.h b/include/hw/misc/macio/pmu.h
index ba76afb52a..ceb12082ae 100644
--- a/include/hw/misc/macio/pmu.h
+++ b/include/hw/misc/macio/pmu.h
@@ -78,3 +78,3 @@
 
-/* Bits in the environement message (either obtained via PMU_GET_COVER,
+/* Bits in the environment message (either obtained via PMU_GET_COVER,
  * or via PMU_INT_ENVIRONMENT on core99 */
diff --git a/include/hw/net/mii.h b/include/hw/net/mii.h
index ed1bb52b0f..f7feddac9b 100644
--- a/include/hw/net/mii.h
+++ b/include/hw/net/mii.h
@@ -73,3 +73,3 @@
 
-#define MII_ANAR_PAUSE_ASYM (1 << 11) /* Try for asymetric pause */
+#define MII_ANAR_PAUSE_ASYM (1 << 11) /* Try for asymmetric pause */
 #define MII_ANAR_PAUSE      (1 << 10) /* Try for pause */
diff --git a/include/hw/pci-host/dino.h b/include/hw/pci-host/dino.h
index a1b0184940..fd7975c798 100644
--- a/include/hw/pci-host/dino.h
+++ b/include/hw/pci-host/dino.h
@@ -1,3 +1,3 @@
 /*
- * HP-PARISC Dino PCI chipset emulation, as in B160L and similiar machines
+ * HP-PARISC Dino PCI chipset emulation, as in B160L and similar machines
  *
diff --git a/include/hw/pci/pcie_aer.h b/include/hw/pci/pcie_aer.h
index 1234fdc4e2..4a9f0ea69d 100644
--- a/include/hw/pci/pcie_aer.h
+++ b/include/hw/pci/pcie_aer.h
@@ -42,3 +42,3 @@ struct PCIEAERLog {
      * I bet that 128 log size would be big enough, otherwise too many errors
-     * for system to function normaly. But could consecutive errors occur?
+     * for system to function normally. But could consecutive errors occur?
      */
diff --git a/include/hw/ssi/xilinx_spips.h b/include/hw/ssi/xilinx_spips.h
index 06bfd18312..1386d5ac8f 100644
--- a/include/hw/ssi/xilinx_spips.h
+++ b/include/hw/ssi/xilinx_spips.h
@@ -106,3 +106,3 @@ struct XlnxZynqMPQSPIPS {
 
-    /* GQSPI has seperate tx/rx fifos */
+    /* GQSPI has separate tx/rx fifos */
     Fifo8 rx_fifo_g;
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 5f5dcb4572..e07a723027 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -111,3 +111,3 @@ typedef struct VirtioNetRscSeg {
     uint16_t dup_ack;
-    bool is_coalesced;      /* need recal ipv4 header checksum, mark here */
+    bool is_coalesced;      /* need recall ipv4 header checksum, mark here */
     VirtioNetRscUnit unit;
diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
index 513c428fe4..ab15577d38 100644
--- a/include/io/channel-socket.h
+++ b/include/io/channel-socket.h
@@ -126,3 +126,3 @@ void qio_channel_socket_connect_async(QIOChannelSocket *ioc,
  * @addr: the address to listen to
- * @num: the expected ammount of connections
+ * @num: the expected amount of connections
  * @errp: pointer to a NULL-initialized error object
@@ -143,3 +143,3 @@ int qio_channel_socket_listen_sync(QIOChannelSocket *ioc,
  * @addr: the address to listen to
- * @num: the expected ammount of connections
+ * @num: the expected amount of connections
  * @callback: the function to invoke on completion
diff --git a/include/io/task.h b/include/io/task.h
index beec4f5cfd..dc7d32ebd0 100644
--- a/include/io/task.h
+++ b/include/io/task.h
@@ -147,3 +147,3 @@ typedef void (*QIOTaskWorker)(QIOTask *task,
  * results in the main event thread. This allows code which
- * cannot easily be rewritten to be asychronous (such as DNS
+ * cannot easily be rewritten to be asynchronous (such as DNS
  * lookups) to be easily run non-blocking. Reporting the
diff --git a/include/qemu/iova-tree.h b/include/qemu/iova-tree.h
index 8528e5c98f..2a10a7052e 100644
--- a/include/qemu/iova-tree.h
+++ b/include/qemu/iova-tree.h
@@ -17,3 +17,3 @@
  * benefit is that we can merge adjacent ranges internally within the
- * tree.  It can save a lot of memory when the ranges are splitted but
+ * tree.  It can save a lot of memory when the ranges are split but
  * mostly continuous.
@@ -130,3 +130,3 @@ const DMAMap *iova_tree_find_address(const IOVATree *tree, hwaddr iova);
  * @tree: the iova tree to iterate on
- * @iterator: the interator for the mappings, return true to stop
+ * @iterator: the iterator for the mappings, return true to stop
  *
diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 9a91cb1248..d7d1051e81 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -355,3 +355,3 @@ void timerlist_notify(QEMUTimerList *timer_list);
  * called whenever a clock in the timer list group is
- * reenabled or whenever a timer associated with any timer
+ * re-enabled or whenever a timer associated with any timer
  * list is modified. If @cb is specified as null, qemu_notify()
diff --git a/include/qemu/yank.h b/include/qemu/yank.h
index 5375a1f195..1907150933 100644
--- a/include/qemu/yank.h
+++ b/include/qemu/yank.h
@@ -27,3 +27,3 @@ typedef void (YankFn)(void *opaque);
  *
- * Returns true on success or false if an error occured.
+ * Returns true on success or false if an error occurred.
  */
diff --git a/include/sysemu/cryptodev-vhost.h b/include/sysemu/cryptodev-vhost.h
index e8cab1356e..4c3c22acae 100644
--- a/include/sysemu/cryptodev-vhost.h
+++ b/include/sysemu/cryptodev-vhost.h
@@ -81,3 +81,3 @@ cryptodev_vhost_init(
  *
- * Clean the resouce associated with @crypto that realizaed
+ * Clean the resource associated with @crypto that realizaed
  * by cryptodev_vhost_init()
diff --git a/include/sysemu/cryptodev.h b/include/sysemu/cryptodev.h
index bc021ce847..96d3998b93 100644
--- a/include/sysemu/cryptodev.h
+++ b/include/sysemu/cryptodev.h
@@ -341,3 +341,3 @@ void cryptodev_backend_free_client(
  *
- * Clean the resouce associated with @backend that realizaed
+ * Clean the resource associated with @backend that realizaed
  * by the specific backend's init() callback
@@ -409,3 +409,3 @@ int cryptodev_backend_crypto_operation(
  * @backend: the cryptodev backend object
- * @used: ture or false
+ * @used: true or false
  *
@@ -429,3 +429,3 @@ bool cryptodev_backend_is_used(CryptoDevBackend *backend);
  * @backend: the cryptodev backend object
- * @ready: ture or false
+ * @ready: true or false
  *
diff --git a/include/sysemu/iothread.h b/include/sysemu/iothread.h
index 8f8601d6ab..2102a90eca 100644
--- a/include/sysemu/iothread.h
+++ b/include/sysemu/iothread.h
@@ -61,3 +61,3 @@ void iothread_destroy(IOThread *iothread);
 /*
- * Returns true if executing withing IOThread context,
+ * Returns true if executing within IOThread context,
  * false otherwise.
diff --git a/include/sysemu/stats.h b/include/sysemu/stats.h
index fcf0983154..42c236c795 100644
--- a/include/sysemu/stats.h
+++ b/include/sysemu/stats.h
@@ -36,3 +36,3 @@ void add_stats_schema(StatsSchemaList **, StatsProvider, StatsTarget,
 /*
- * True if a string matches the filter passed to the stats_fn callabck,
+ * True if a string matches the filter passed to the stats_fn callback,
  * false otherwise.
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index 8fd3269c11..7fabafefee 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -117,3 +117,3 @@ int tpm_backend_startup_tpm(TPMBackend *s, size_t buffersize);
  * tpm_backend_had_startup_error:
- * @s: the backend to query for a statup error
+ * @s: the backend to query for a startup error
  *
diff --git a/include/tcg/helper-info.h b/include/tcg/helper-info.h
index 4b6c9b43e8..7c27d6164a 100644
--- a/include/tcg/helper-info.h
+++ b/include/tcg/helper-info.h
@@ -1,3 +1,3 @@
 /*
- * TCG Helper Infomation Structure
+ * TCG Helper Information Structure
  *
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 0875971719..f2b0eaa6da 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -881,3 +881,3 @@ enum {
     /* Instruction is optional and not implemented by the host, or insn
-       is generic and should not be implemened by the host.  */
+       is generic and should not be implemented by the host.  */
     TCG_OPF_NOT_PRESENT  = 0x20,
@@ -1125,3 +1125,3 @@ void tcg_expand_vec_op(TCGOpcode, TCGType, unsigned, TCGArg, ...);
 
-/* Replicate a constant C accoring to the log2 of the element size.  */
+/* Replicate a constant C according to the log2 of the element size.  */
 uint64_t dup_const(unsigned vece, uint64_t c);
diff --git a/include/ui/kbd-state.h b/include/ui/kbd-state.h
index eb9067dd53..fb79776128 100644
--- a/include/ui/kbd-state.h
+++ b/include/ui/kbd-state.h
@@ -67,3 +67,3 @@ void qkbd_state_key_event(QKbdState *kbd, QKeyCode qcode, bool down);
  * @kbd: state tracker state.
- * @delay_ms: the delay in miliseconds.
+ * @delay_ms: the delay in milliseconds.
  */
diff --git a/include/ui/spice-display.h b/include/ui/spice-display.h
index 5aa13664d6..e1a9b36185 100644
--- a/include/ui/spice-display.h
+++ b/include/ui/spice-display.h
@@ -44,3 +44,3 @@
 /*
- * Internal enum to differenciate between options for
+ * Internal enum to differentiate between options for
  * io calls that have a sync (old) version and an _async (new)
diff --git a/include/user/safe-syscall.h b/include/user/safe-syscall.h
index ddceef12e2..195cedac04 100644
--- a/include/user/safe-syscall.h
+++ b/include/user/safe-syscall.h
@@ -93,3 +93,3 @@
  * section of host native assembly. If a signal occurs, our signal
- * handler checks the interrupted host PC against the addresse of that
+ * handler checks the interrupted host PC against the address of that
  * known section. If the PC is before or at the address of the syscall
-- 
2.39.2


