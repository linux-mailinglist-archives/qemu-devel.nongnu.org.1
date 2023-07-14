Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E69447539D3
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 13:43:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKH9l-00015v-Vw; Fri, 14 Jul 2023 07:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKH9G-0000bm-H0; Fri, 14 Jul 2023 07:39:46 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKH9D-0004Kw-Jf; Fri, 14 Jul 2023 07:39:46 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7953113D9C;
 Fri, 14 Jul 2023 14:38:57 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 6D08114BAB;
 Fri, 14 Jul 2023 14:38:41 +0300 (MSK)
Received: (nullmailer pid 1186243 invoked by uid 1000);
 Fri, 14 Jul 2023 11:38:38 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH, trivial 16/29] tree-wide spelling fixes in comments and some
 messages: hw/net
Date: Fri, 14 Jul 2023 14:38:21 +0300
Message-Id: <20230714113834.1186117-18-mjt@tls.msk.ru>
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
 hw/net/cadence_gem.c      | 10 +++++-----
 hw/net/dp8393x.c          |  2 +-
 hw/net/e1000_regs.h       |  2 +-
 hw/net/e1000x_regs.h      |  2 +-
 hw/net/fsl_etsec/rings.c  |  2 +-
 hw/net/igb_regs.h         |  4 ++--
 hw/net/mcf_fec.c          |  2 +-
 hw/net/rocker/rocker_fp.c |  2 +-
 hw/net/rtl8139.c          |  2 +-
 hw/net/smc91c111.c        |  2 +-
 hw/net/sungem.c           |  2 +-
 hw/net/sunhme.c           |  2 +-
 hw/net/virtio-net.c       |  6 +++---
 hw/net/vmxnet3.c          |  2 +-
 hw/net/vmxnet3.h          |  2 +-
 15 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 42ea2411a2..f445d8bb5e 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -83,4 +83,4 @@
 #define GEM_MODID         (0x000000FC / 4) /* Module ID reg */
-#define GEM_OCTTXLO       (0x00000100 / 4) /* Octects transmitted Low reg */
-#define GEM_OCTTXHI       (0x00000104 / 4) /* Octects transmitted High reg */
+#define GEM_OCTTXLO       (0x00000100 / 4) /* Octets transmitted Low reg */
+#define GEM_OCTTXHI       (0x00000104 / 4) /* Octets transmitted High reg */
 #define GEM_TXCNT         (0x00000108 / 4) /* Error-free Frames transmitted */
@@ -103,4 +103,4 @@
 #define GEM_CSENSECNT     (0x0000014C / 4) /* Carrier Sense Error Counter */
-#define GEM_OCTRXLO       (0x00000150 / 4) /* Octects Received register Low */
-#define GEM_OCTRXHI       (0x00000154 / 4) /* Octects Received register High */
+#define GEM_OCTRXLO       (0x00000150 / 4) /* Octets Received register Low */
+#define GEM_OCTRXHI       (0x00000154 / 4) /* Octets Received register High */
 #define GEM_RXCNT         (0x00000158 / 4) /* Error-free Frames Received */
@@ -956,3 +956,3 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
     if (maf == GEM_RX_REJECT) {
-        return size;  /* no, drop siliently b/c it's not an error */
+        return size;  /* no, drop silently b/c it's not an error */
     }
diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index a596f7fbc6..c6f5fb7dce 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -553,3 +553,3 @@ static uint64_t dp8393x_read(void *opaque, hwaddr addr, unsigned int size)
         break;
-    /* All other registers have no special contraints */
+    /* All other registers have no special constraints */
     default:
diff --git a/hw/net/e1000_regs.h b/hw/net/e1000_regs.h
index 8a4ce82034..39f4882510 100644
--- a/hw/net/e1000_regs.h
+++ b/hw/net/e1000_regs.h
@@ -132,3 +132,3 @@
 #define E1000_FFLT_DBG  0x05F04 /* Debug Register */
-#define E1000_HICR      0x08F00 /* Host Inteface Control */
+#define E1000_HICR      0x08F00 /* Host Interface Control */
 
diff --git a/hw/net/e1000x_regs.h b/hw/net/e1000x_regs.h
index 13760c66d3..cd896fc0ca 100644
--- a/hw/net/e1000x_regs.h
+++ b/hw/net/e1000x_regs.h
@@ -841,3 +841,3 @@ union e1000_rx_desc_packet_split {
 #define E1000_RXD_STAT_VP       0x08    /* IEEE VLAN Packet */
-#define E1000_RXD_STAT_UDPCS    0x10    /* UDP xsum caculated */
+#define E1000_RXD_STAT_UDPCS    0x10    /* UDP xsum calculated */
 #define E1000_RXD_STAT_TCPCS    0x20    /* TCP xsum calculated */
diff --git a/hw/net/fsl_etsec/rings.c b/hw/net/fsl_etsec/rings.c
index 788463f1b6..e6c3bf5361 100644
--- a/hw/net/fsl_etsec/rings.c
+++ b/hw/net/fsl_etsec/rings.c
@@ -367,3 +367,3 @@ void etsec_walk_tx_ring(eTSEC *etsec, int ring_nbr)
     /* Save the Buffer Descriptor Pointers to last bd that was not
-     * succesfully closed */
+     * successfully closed */
     etsec->regs[TBPTR0 + ring_nbr].value = bd_addr;
diff --git a/hw/net/igb_regs.h b/hw/net/igb_regs.h
index 82ff195dfc..d6e0405d0a 100644
--- a/hw/net/igb_regs.h
+++ b/hw/net/igb_regs.h
@@ -366,3 +366,3 @@ union e1000_adv_rx_desc {
 #define E1000_VT_MSGINFO_SHIFT 16
-/* bits 23:16 are used for exra info for certain messages */
+/* bits 23:16 are used for extra info for certain messages */
 #define E1000_VT_MSGINFO_MASK (0xFF << E1000_VT_MSGINFO_SHIFT)
@@ -492,3 +492,3 @@ union e1000_adv_rx_desc {
 #define E1000_VT_MSGINFO_SHIFT    16
-/* bits 23:16 are used for exra info for certain messages */
+/* bits 23:16 are used for extra info for certain messages */
 #define E1000_VT_MSGINFO_MASK     (0xFF << E1000_VT_MSGINFO_SHIFT)
diff --git a/hw/net/mcf_fec.c b/hw/net/mcf_fec.c
index 8aa27bd322..ec3ddf520a 100644
--- a/hw/net/mcf_fec.c
+++ b/hw/net/mcf_fec.c
@@ -573,3 +573,3 @@ static ssize_t mcf_fec_receive(NetClientState *nc, const uint8_t *buf, size_t si
     crc_ptr = (uint8_t *)&crc;
-    /* Huge frames are truncted.  */
+    /* Huge frames are truncated.  */
     if (size > FEC_MAX_FRAME_SIZE) {
diff --git a/hw/net/rocker/rocker_fp.c b/hw/net/rocker/rocker_fp.c
index cbeed65bd5..9afd0c5e3f 100644
--- a/hw/net/rocker/rocker_fp.c
+++ b/hw/net/rocker/rocker_fp.c
@@ -136,3 +136,3 @@ static ssize_t fp_port_receive_iov(NetClientState *nc, const struct iovec *iov,
     /* If the port is disabled, we want to drop this pkt
-     * now rather than queing it for later.  We don't want
+     * now rather than queueing it for later.  We don't want
      * any stale pkts getting into the device when the port
diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index b4df75b2c9..4525fda383 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -102,3 +102,3 @@ enum RTL8139_registers {
     TxStatus0 = 0x10,/* Transmit status (Four 32bit registers). C mode only */
-                     /* Dump Tally Conter control register(64bit). C+ mode only */
+                     /* Dump Tally Counter control register(64bit). C+ mode only */
     TxAddr0 = 0x20,  /* Tx descriptors (also four 32bit). */
diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index ad778cd8fc..ddbceda967 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -363,3 +363,3 @@ static void smc91c111_writeb(void *opaque, hwaddr offset,
             return;
-        case 10: /* Genral Purpose */
+        case 10: /* General Purpose */
             SET_LOW(gpr, value);
diff --git a/hw/net/sungem.c b/hw/net/sungem.c
index 510b370e5f..c2e2c90668 100644
--- a/hw/net/sungem.c
+++ b/hw/net/sungem.c
@@ -1230,3 +1230,3 @@ static void sungem_mmio_mif_write(void *opaque, hwaddr addr, uint64_t val,
     case MIF_CFG:
-        /* Maintain the RO MDI bits to advertize an MDIO PHY on MDI0 */
+        /* Maintain the RO MDI bits to advertise an MDIO PHY on MDI0 */
         val &= ~MIF_CFG_MDI1;
diff --git a/hw/net/sunhme.c b/hw/net/sunhme.c
index 391d26fb82..64d4ea5850 100644
--- a/hw/net/sunhme.c
+++ b/hw/net/sunhme.c
@@ -903,3 +903,3 @@ static void sunhme_reset(DeviceState *ds)
 
-    /* Advetise auto, 100Mbps FD */
+    /* Advertise auto, 100Mbps FD */
     s->miiregs[MII_ANAR] = MII_ANAR_TXFD;
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 7102ec4817..57a359b7a5 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1309,3 +1309,3 @@ static bool virtio_net_load_ebpf(VirtIONet *n)
     if (!virtio_net_attach_ebpf_to_backend(n->nic, -1)) {
-        /* backend does't support steering ebpf */
+        /* backend doesn't support steering ebpf */
         return false;
@@ -2048,3 +2048,3 @@ static void virtio_net_rsc_extract_unit6(VirtioNetRscChain *chain,
 
-    /* There is a difference between payload lenght in ipv4 and v6,
+    /* There is a difference between payload length in ipv4 and v6,
        ip header is excluded in ipv6 */
@@ -3797,3 +3797,3 @@ static void virtio_net_instance_init(Object *obj)
      * The default config_size is sizeof(struct virtio_net_config).
-     * Can be overriden with virtio_net_set_config_size.
+     * Can be overridden with virtio_net_set_config_size.
      */
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 5dfacb1098..ea9e86476e 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -1886,3 +1886,3 @@ vmxnet3_io_bar1_read(void *opaque, hwaddr addr, unsigned size)
         default:
-            VMW_CBPRN("Unknow read BAR1[%" PRIx64 "], %d bytes", addr, size);
+            VMW_CBPRN("Unknown read BAR1[%" PRIx64 "], %d bytes", addr, size);
             break;
diff --git a/hw/net/vmxnet3.h b/hw/net/vmxnet3.h
index bf4f6de74a..f9283f9e7b 100644
--- a/hw/net/vmxnet3.h
+++ b/hw/net/vmxnet3.h
@@ -735,3 +735,3 @@ struct Vmxnet3_RxQueueDesc {
     struct Vmxnet3_RxQueueConf        conf;
-    /* Driver read after a GET commad */
+    /* Driver read after a GET command */
     struct Vmxnet3_QueueStatus        status;
-- 
2.39.2


