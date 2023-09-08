Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 506CF798545
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 11:58:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeYDy-00074p-Sh; Fri, 08 Sep 2023 05:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qeYDw-00074V-V7; Fri, 08 Sep 2023 05:56:24 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qeYDt-0006jf-Kr; Fri, 08 Sep 2023 05:56:24 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 71A7B200CF;
 Fri,  8 Sep 2023 12:56:46 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 675F726915;
 Fri,  8 Sep 2023 12:55:57 +0300 (MSK)
Received: (nullmailer pid 275961 invoked by uid 1000);
 Fri, 08 Sep 2023 09:55:56 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 07/23] include/: spelling fixes
Date: Fri,  8 Sep 2023 12:55:04 +0300
Message-Id: <20230908095520.275866-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230908095520.275866-1-mjt@tls.msk.ru>
References: <20230908095520.275866-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/block/block_int-common.h | 2 +-
 include/chardev/char-fe.h        | 4 ++--
 include/crypto/akcipher.h        | 2 +-
 include/crypto/ivgen.h           | 4 ++--
 include/hw/acpi/aml-build.h      | 2 +-
 include/hw/acpi/pc-hotplug.h     | 2 +-
 include/hw/acpi/vmgenid.h        | 2 +-
 include/hw/boards.h              | 6 +++---
 include/hw/char/avr_usart.h      | 2 +-
 include/hw/clock.h               | 2 +-
 include/hw/cxl/cxl_device.h      | 2 +-
 include/hw/hyperv/vmbus.h        | 2 +-
 include/hw/misc/macio/pmu.h      | 2 +-
 include/hw/net/mii.h             | 2 +-
 include/hw/pci-host/dino.h       | 2 +-
 include/hw/pci/pcie_aer.h        | 2 +-
 include/hw/ssi/xilinx_spips.h    | 2 +-
 include/hw/virtio/virtio-net.h   | 2 +-
 include/sysemu/cryptodev-vhost.h | 2 +-
 include/sysemu/cryptodev.h       | 6 +++---
 include/sysemu/iothread.h        | 2 +-
 include/sysemu/stats.h           | 2 +-
 include/sysemu/tpm_backend.h     | 2 +-
 23 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 74195c3004..e09d277328 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -418,7 +418,7 @@ struct BlockDriver {
 
     /**
      * Called to inform the driver that the set of cumulative set of used
-     * permissions for @bs has changed to @perm, and the set of sharable
+     * permissions for @bs has changed to @perm, and the set of shareable
      * permission to @shared. The driver can use this to propagate changes to
      * its children (i.e. request permissions only if a parent actually needs
      * them).
diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
index 0109602d63..0ff6f87511 100644
--- a/include/chardev/char-fe.h
+++ b/include/chardev/char-fe.h
@@ -78,7 +78,7 @@ bool qemu_chr_fe_backend_open(CharBackend *be);
  *             is not supported and will not be attempted
  * @opaque: an opaque pointer for the callbacks
  * @context: a main loop context or NULL for the default
- * @set_open: whether to call qemu_chr_fe_set_open() implicitely when
+ * @set_open: whether to call qemu_chr_fe_set_open() implicitly when
  * any of the handler is non-NULL
  * @sync_state: whether to issue event callback with updated state
  *
@@ -138,7 +138,7 @@ void qemu_chr_fe_disconnect(CharBackend *be);
 /**
  * qemu_chr_fe_wait_connected:
  *
- * Wait for characted backend to be connected, return < 0 on error or
+ * Wait for character backend to be connected, return < 0 on error or
  * if no associated Chardev.
  */
 int qemu_chr_fe_wait_connected(CharBackend *be, Error **errp);
diff --git a/include/crypto/akcipher.h b/include/crypto/akcipher.h
index 214e58ca47..8756105f22 100644
--- a/include/crypto/akcipher.h
+++ b/include/crypto/akcipher.h
@@ -30,7 +30,7 @@ typedef struct QCryptoAkCipher QCryptoAkCipher;
  * qcrypto_akcipher_supports:
  * @opts: the asymmetric key algorithm and related options
  *
- * Determine if asymmetric key cipher decribed with @opts is
+ * Determine if asymmetric key cipher described with @opts is
  * supported by the current configured build
  *
  * Returns: true if it is supported, false otherwise.
diff --git a/include/crypto/ivgen.h b/include/crypto/ivgen.h
index e41521519c..a09d5732da 100644
--- a/include/crypto/ivgen.h
+++ b/include/crypto/ivgen.h
@@ -32,7 +32,7 @@
  * sector.
  *
  * <example>
- *   <title>Encrypting block data with initialiation vectors</title>
+ *   <title>Encrypting block data with initialization vectors</title>
  *   <programlisting>
  * uint8_t *data = ....data to encrypt...
  * size_t ndata = XXX;
@@ -147,7 +147,7 @@ QCryptoIVGen *qcrypto_ivgen_new(QCryptoIVGenAlgorithm alg,
  * @niv: the number of bytes in @iv
  * @errp: pointer to a NULL-initialized error object
  *
- * Calculate a new initialiation vector for the data
+ * Calculate a new initialization vector for the data
  * to be stored in sector @sector. The IV will be
  * written into the buffer @iv of size @niv.
  *
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index d1fb08514b..ff2a310270 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -277,7 +277,7 @@ void free_aml_allocator(void);
  * @child: element that is copied into @parent_ctx context
  *
  * Joins Aml elements together and helps to construct AML tables
- * Examle of usage:
+ * Example of usage:
  *   Aml *table = aml_def_block("SSDT", ...);
  *   Aml *sb = aml_scope("\\_SB");
  *   Aml *dev = aml_device("PCI0");
diff --git a/include/hw/acpi/pc-hotplug.h b/include/hw/acpi/pc-hotplug.h
index 31bc9191c3..8a654248e9 100644
--- a/include/hw/acpi/pc-hotplug.h
+++ b/include/hw/acpi/pc-hotplug.h
@@ -13,7 +13,7 @@
 #define PC_HOTPLUG_H
 
 /*
- * ONLY DEFINEs are permited in this file since it's shared
+ * ONLY DEFINEs are permitted in this file since it's shared
  * between C and ASL code.
  */
 
diff --git a/include/hw/acpi/vmgenid.h b/include/hw/acpi/vmgenid.h
index dc8bb3433e..fb135d5bcb 100644
--- a/include/hw/acpi/vmgenid.h
+++ b/include/hw/acpi/vmgenid.h
@@ -13,7 +13,7 @@
 
 #define VMGENID_FW_CFG_SIZE      4096 /* Occupy a page of memory */
 #define VMGENID_GUID_OFFSET      40   /* allow space for
-                                       * OVMF SDT Header Probe Supressor
+                                       * OVMF SDT Header Probe Suppressor
                                        */
 
 OBJECT_DECLARE_SIMPLE_TYPE(VmGenIdState, VMGENID)
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 3b541ffd24..6c67af196a 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -158,7 +158,7 @@ typedef struct {
  *    any actions to be performed by hotplug handler.
  * @cpu_index_to_instance_props:
  *    used to provide @cpu_index to socket/core/thread number mapping, allowing
- *    legacy code to perform maping from cpu_index to topology properties
+ *    legacy code to perform mapping from cpu_index to topology properties
  *    Returns: tuple of socket/core/thread ids given cpu_index belongs to.
  *    used to provide @cpu_index to socket number mapping, allowing
  *    a machine to group CPU threads belonging to the same socket/package
@@ -211,10 +211,10 @@ typedef struct {
  *    the rejection.  If the hook is not provided, all hotplug will be
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
  * @fixup_ram_size:
diff --git a/include/hw/char/avr_usart.h b/include/hw/char/avr_usart.h
index 62eaa1528e..0cc599e9b1 100644
--- a/include/hw/char/avr_usart.h
+++ b/include/hw/char/avr_usart.h
@@ -34,7 +34,7 @@
 #define USART_BRRH 0x05
 #define USART_BRRL 0x04
 
-/* Relevant bits in regiters. */
+/* Relevant bits in registers. */
 #define USART_CSRA_RXC    (1 << 7)
 #define USART_CSRA_TXC    (1 << 6)
 #define USART_CSRA_DRE    (1 << 5)
diff --git a/include/hw/clock.h b/include/hw/clock.h
index 5c927cee7f..bb12117f67 100644
--- a/include/hw/clock.h
+++ b/include/hw/clock.h
@@ -204,7 +204,7 @@ static inline bool clock_set_ns(Clock *clk, unsigned ns)
  * Propagate the clock period that has been previously configured using
  * @clock_set(). This will update recursively all connected clocks.
  * It is an error to call this function on a clock which has a source.
- * Note: this function must not be called during device inititialization
+ * Note: this function must not be called during device initialization
  * or migration.
  */
 void clock_propagate(Clock *clk);
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 1978730fba..f717e3f384 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -208,7 +208,7 @@ void cxl_event_set_status(CXLDeviceState *cxl_dstate, CXLEventLogType log_type,
  * > is the maximum access size allowed for these registers. If this rule is not
  * > followed, the behavior is undefined
  *
- * CXL 2.0 Errata F4 states futher that the layouts in the specification are
+ * CXL 2.0 Errata F4 states further that the layouts in the specification are
  * shown as greater than 128 bits, but implementations are expected to
  * use any size of access up to 64 bits.
  *
diff --git a/include/hw/hyperv/vmbus.h b/include/hw/hyperv/vmbus.h
index 8ea660dd8e..5c505852f2 100644
--- a/include/hw/hyperv/vmbus.h
+++ b/include/hw/hyperv/vmbus.h
@@ -51,7 +51,7 @@ struct VMBusDeviceClass {
     uint16_t channel_flags;
     uint16_t mmio_size_mb;
 
-    /* Extentions to standard device callbacks */
+    /* Extensions to standard device callbacks */
     void (*vmdev_realize)(VMBusDevice *vdev, Error **errp);
     void (*vmdev_unrealize)(VMBusDevice *vdev);
     void (*vmdev_reset)(VMBusDevice *vdev);
diff --git a/include/hw/misc/macio/pmu.h b/include/hw/misc/macio/pmu.h
index ba76afb52a..ceb12082ae 100644
--- a/include/hw/misc/macio/pmu.h
+++ b/include/hw/misc/macio/pmu.h
@@ -76,7 +76,7 @@
 #define PMU_INT_WAITING_CHARGER    0x01    /* ??? */
 #define PMU_INT_AUTO_SRQ_POLL      0x02    /* ??? */
 
-/* Bits in the environement message (either obtained via PMU_GET_COVER,
+/* Bits in the environment message (either obtained via PMU_GET_COVER,
  * or via PMU_INT_ENVIRONMENT on core99 */
 #define PMU_ENV_LID_CLOSED     0x01    /* The lid is closed */
 
diff --git a/include/hw/net/mii.h b/include/hw/net/mii.h
index ed1bb52b0f..f7feddac9b 100644
--- a/include/hw/net/mii.h
+++ b/include/hw/net/mii.h
@@ -71,7 +71,7 @@
 #define MII_BMSR_JABBER     (1 << 1)  /* Jabber detected */
 #define MII_BMSR_EXTCAP     (1 << 0)  /* Ext-reg capability */
 
-#define MII_ANAR_PAUSE_ASYM (1 << 11) /* Try for asymetric pause */
+#define MII_ANAR_PAUSE_ASYM (1 << 11) /* Try for asymmetric pause */
 #define MII_ANAR_PAUSE      (1 << 10) /* Try for pause */
 #define MII_ANAR_TXFD       (1 << 8)
 #define MII_ANAR_TX         (1 << 7)
diff --git a/include/hw/pci-host/dino.h b/include/hw/pci-host/dino.h
index a1b0184940..fd7975c798 100644
--- a/include/hw/pci-host/dino.h
+++ b/include/hw/pci-host/dino.h
@@ -1,5 +1,5 @@
 /*
- * HP-PARISC Dino PCI chipset emulation, as in B160L and similiar machines
+ * HP-PARISC Dino PCI chipset emulation, as in B160L and similar machines
  *
  * (C) 2017-2019 by Helge Deller <deller@gmx.de>
  *
diff --git a/include/hw/pci/pcie_aer.h b/include/hw/pci/pcie_aer.h
index 1234fdc4e2..4a9f0ea69d 100644
--- a/include/hw/pci/pcie_aer.h
+++ b/include/hw/pci/pcie_aer.h
@@ -40,7 +40,7 @@ struct PCIEAERLog {
      * The specified value will be clipped down to PCIE_AER_LOG_MAX_LIMIT
      * to avoid unreasonable memory usage.
      * I bet that 128 log size would be big enough, otherwise too many errors
-     * for system to function normaly. But could consecutive errors occur?
+     * for system to function normally. But could consecutive errors occur?
      */
 #define PCIE_AER_LOG_MAX_DEFAULT        8
 #define PCIE_AER_LOG_MAX_LIMIT          128
diff --git a/include/hw/ssi/xilinx_spips.h b/include/hw/ssi/xilinx_spips.h
index 06bfd18312..1386d5ac8f 100644
--- a/include/hw/ssi/xilinx_spips.h
+++ b/include/hw/ssi/xilinx_spips.h
@@ -104,7 +104,7 @@ struct XlnxZynqMPQSPIPS {
 
     uint32_t regs[XLNX_ZYNQMP_SPIPS_R_MAX];
 
-    /* GQSPI has seperate tx/rx fifos */
+    /* GQSPI has separate tx/rx fifos */
     Fifo8 rx_fifo_g;
     Fifo8 tx_fifo_g;
     Fifo32 fifo_g;
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 5f5dcb4572..e07a723027 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -109,7 +109,7 @@ typedef struct VirtioNetRscSeg {
     size_t size;
     uint16_t packets;
     uint16_t dup_ack;
-    bool is_coalesced;      /* need recal ipv4 header checksum, mark here */
+    bool is_coalesced;      /* need recall ipv4 header checksum, mark here */
     VirtioNetRscUnit unit;
     NetClientState *nc;
 } VirtioNetRscSeg;
diff --git a/include/sysemu/cryptodev-vhost.h b/include/sysemu/cryptodev-vhost.h
index e8cab1356e..4c3c22acae 100644
--- a/include/sysemu/cryptodev-vhost.h
+++ b/include/sysemu/cryptodev-vhost.h
@@ -79,7 +79,7 @@ cryptodev_vhost_init(
  * cryptodev_vhost_cleanup:
  * @crypto: the cryptodev backend common vhost object
  *
- * Clean the resouce associated with @crypto that realizaed
+ * Clean the resource associated with @crypto that realizaed
  * by cryptodev_vhost_init()
  *
  */
diff --git a/include/sysemu/cryptodev.h b/include/sysemu/cryptodev.h
index bc021ce847..96d3998b93 100644
--- a/include/sysemu/cryptodev.h
+++ b/include/sysemu/cryptodev.h
@@ -339,7 +339,7 @@ void cryptodev_backend_free_client(
  * @backend: the cryptodev backend object
  * @errp: pointer to a NULL-initialized error object
  *
- * Clean the resouce associated with @backend that realizaed
+ * Clean the resource associated with @backend that realizaed
  * by the specific backend's init() callback
  */
 void cryptodev_backend_cleanup(
@@ -407,7 +407,7 @@ int cryptodev_backend_crypto_operation(
 /**
  * cryptodev_backend_set_used:
  * @backend: the cryptodev backend object
- * @used: ture or false
+ * @used: true or false
  *
  * Set the cryptodev backend is used by virtio-crypto or not
  */
@@ -427,7 +427,7 @@ bool cryptodev_backend_is_used(CryptoDevBackend *backend);
 /**
  * cryptodev_backend_set_ready:
  * @backend: the cryptodev backend object
- * @ready: ture or false
+ * @ready: true or false
  *
  * Set the cryptodev backend is ready or not, which is called
  * by the children of the cryptodev banckend interface.
diff --git a/include/sysemu/iothread.h b/include/sysemu/iothread.h
index 8f8601d6ab..2102a90eca 100644
--- a/include/sysemu/iothread.h
+++ b/include/sysemu/iothread.h
@@ -59,7 +59,7 @@ void iothread_stop(IOThread *iothread);
 void iothread_destroy(IOThread *iothread);
 
 /*
- * Returns true if executing withing IOThread context,
+ * Returns true if executing within IOThread context,
  * false otherwise.
  */
 bool qemu_in_iothread(void);
diff --git a/include/sysemu/stats.h b/include/sysemu/stats.h
index fcf0983154..42c236c795 100644
--- a/include/sysemu/stats.h
+++ b/include/sysemu/stats.h
@@ -34,7 +34,7 @@ void add_stats_schema(StatsSchemaList **, StatsProvider, StatsTarget,
                       StatsSchemaValueList *);
 
 /*
- * True if a string matches the filter passed to the stats_fn callabck,
+ * True if a string matches the filter passed to the stats_fn callback,
  * false otherwise.
  *
  * Note that an empty list means no filtering, i.e. all strings will
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index 8fd3269c11..7fabafefee 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -115,7 +115,7 @@ int tpm_backend_startup_tpm(TPMBackend *s, size_t buffersize);
 
 /**
  * tpm_backend_had_startup_error:
- * @s: the backend to query for a statup error
+ * @s: the backend to query for a startup error
  *
  * Check whether the backend had an error during startup. Returns
  * false if no error occurred and the backend can be used, true
-- 
2.39.2


