Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B124B78502E
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 07:54:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYgot-0007G7-QO; Wed, 23 Aug 2023 01:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qYgon-00075h-5n
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 01:54:13 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qYgoj-0007Vx-1b
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 01:54:12 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6C01F1C3A5
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 08:52:23 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 131D12124D;
 Wed, 23 Aug 2023 08:52:05 +0300 (MSK)
Received: (nullmailer pid 1917526 invoked by uid 1000);
 Wed, 23 Aug 2023 05:52:00 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 24/24] misc/other: spelling fixes
Date: Wed, 23 Aug 2023 08:51:55 +0300
Message-Id: <20230823055155.1917375-25-mjt@tls.msk.ru>
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
 accel/tcg/tb-maint.c       | 2 +-
 backends/tpm/tpm_ioctl.h   | 2 +-
 chardev/char-socket.c      | 6 +++---
 chardev/char.c             | 2 +-
 contrib/plugins/cache.c    | 2 +-
 contrib/plugins/lockstep.c | 2 +-
 crypto/afalg.c             | 2 +-
 crypto/block-luks.c        | 6 +++---
 crypto/der.c               | 2 +-
 crypto/der.h               | 6 +++---
 linux-user/flatload.c      | 2 +-
 linux-user/syscall.c       | 4 ++--
 nbd/client-connection.c    | 2 +-
 net/checksum.c             | 4 ++--
 net/filter.c               | 4 ++--
 net/vhost-vdpa.c           | 8 ++++----
 semihosting/config.c       | 2 +-
 semihosting/syscalls.c     | 4 ++--
 softmmu/icount.c           | 2 +-
 softmmu/ioport.c           | 2 +-
 20 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index c406b2f7b7..32ae8af61c 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -1,4 +1,4 @@
 /*
- * Translation Block Maintaince
+ * Translation Block Maintenance
  *
  *  Copyright (c) 2003 Fabrice Bellard
diff --git a/backends/tpm/tpm_ioctl.h b/backends/tpm/tpm_ioctl.h
index b1d31768a6..1933ab6855 100644
--- a/backends/tpm/tpm_ioctl.h
+++ b/backends/tpm/tpm_ioctl.h
@@ -239,5 +239,5 @@ struct ptm_lockstorage {
         struct {
             ptm_res tpm_result;
-        } resp; /* reponse */
+        } resp; /* response */
     } u;
 };
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index e8e3a743d5..73947da188 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -711,5 +711,5 @@ static void tcp_chr_telnet_init(Chardev *chr)
     if (!s->is_tn3270) {
         init->buflen = 12;
-        /* Prep the telnet negotion to put telnet in binary,
+        /* Prep the telnet negotiation to put telnet in binary,
          * no echo, single char mode */
         IACSET(init->buf, 0xff, 0xfb, 0x01);  /* IAC WILL ECHO */
@@ -719,5 +719,5 @@ static void tcp_chr_telnet_init(Chardev *chr)
     } else {
         init->buflen = 21;
-        /* Prep the TN3270 negotion based on RFC1576 */
+        /* Prep the TN3270 negotiation based on RFC1576 */
         IACSET(init->buf, 0xff, 0xfd, 0x19);  /* IAC DO EOR */
         IACSET(init->buf, 0xff, 0xfb, 0x19);  /* IAC WILL EOR */
@@ -1299,5 +1299,5 @@ static bool qmp_chardev_validate_socket(ChardevSocket *sock,
     }
 
-    /* Validate any options which have a dependancy on client vs server */
+    /* Validate any options which have a dependency on client vs server */
     if (!sock->has_server || sock->server) {
         if (sock->has_reconnect) {
diff --git a/chardev/char.c b/chardev/char.c
index 661ad8176a..996a024c7a 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -1116,5 +1116,5 @@ ChardevReturn *qmp_chardev_change(const char *id, ChardevBackend *backend,
     }
 
-    /* change successfull, clean up */
+    /* change successful, clean up */
     chr_new->handover_yank_instance = false;
 
diff --git a/contrib/plugins/cache.c b/contrib/plugins/cache.c
index 5036213f1b..dea4a56c8d 100644
--- a/contrib/plugins/cache.c
+++ b/contrib/plugins/cache.c
@@ -351,5 +351,5 @@ static int in_cache(Cache *cache, uint64_t addr)
  * @addr: The address of the requested memory location
  *
- * Returns true if the requsted data is hit in the cache and false when missed.
+ * Returns true if the requested data is hit in the cache and false when missed.
  * The cache is updated on miss for the next access.
  */
diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
index 3614c3564c..850f7b2941 100644
--- a/contrib/plugins/lockstep.c
+++ b/contrib/plugins/lockstep.c
@@ -109,5 +109,5 @@ static void report_divergance(ExecState *us, ExecState *them)
     /*
      * If we have diverged before did we get back on track or are we
-     * totally loosing it?
+     * totally losing it?
      */
     if (divergence_log) {
diff --git a/crypto/afalg.c b/crypto/afalg.c
index 348301e703..52a491dbb5 100644
--- a/crypto/afalg.c
+++ b/crypto/afalg.c
@@ -74,5 +74,5 @@ qcrypto_afalg_comm_alloc(const char *type, const char *name,
 
     afalg = g_new0(QCryptoAFAlg, 1);
-    /* initilize crypto API socket */
+    /* initialize crypto API socket */
     afalg->opfd = -1;
     afalg->tfmfd = qcrypto_afalg_socket_bind(type, name, errp);
diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index 2f59c3a625..8430217d6e 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -245,5 +245,5 @@ qcrypto_block_luks_has_format(const uint8_t *buf,
  * When calculating ESSIV IVs, the cipher length used by ESSIV
  * may be different from the cipher length used for the block
- * encryption, becauses dm-crypt uses the hash digest length
+ * encryption, because dm-crypt uses the hash digest length
  * as the key size. ie, if you have AES 128 as the block cipher
  * and SHA 256 as ESSIV hash, then ESSIV will use AES 256 as
@@ -394,5 +394,5 @@ qcrypto_block_luks_from_disk_endian(QCryptoBlockLUKSHeader *hdr)
 
 /*
- * Stores the main LUKS header, taking care of endianess
+ * Stores the main LUKS header, taking care of endianness
  */
 static int
@@ -424,5 +424,5 @@ qcrypto_block_luks_store_header(QCryptoBlock *block,
 
 /*
- * Loads the main LUKS header,and byteswaps it to native endianess
+ * Loads the main LUKS header,and byteswaps it to native endianness
  * And run basic sanity checks on it
  */
diff --git a/crypto/der.c b/crypto/der.c
index dab3fe4f24..ebbecfc3fe 100644
--- a/crypto/der.c
+++ b/crypto/der.c
@@ -77,5 +77,5 @@ enum QCryptoDERTagEnc {
  * qcrypto_der_encode_length:
  * @src_len: the length of source data
- * @dst: distination to save the encoded 'length', if dst is NULL, only compute
+ * @dst: destination to save the encoded 'length', if dst is NULL, only compute
  * the expected buffer size in bytes.
  * @dst_len: output parameter, indicates how many bytes wrote.
diff --git a/crypto/der.h b/crypto/der.h
index 0e895bbeec..f4ba6da28a 100644
--- a/crypto/der.h
+++ b/crypto/der.h
@@ -250,5 +250,5 @@ void qcrypto_der_encode_octet_str(QCryptoEncodeContext *ctx,
  * qcrypto_der_encode_octet_str_begin and qcrypto_der_encode_octet_str_end
  * are encoded as an octet string. This is useful when we need to encode a
- * encoded SEQUNCE as OCTET STRING.
+ * encoded SEQUENCE as OCTET STRING.
  */
 void qcrypto_der_encode_octet_str_begin(QCryptoEncodeContext *ctx);
@@ -261,5 +261,5 @@ void qcrypto_der_encode_octet_str_begin(QCryptoEncodeContext *ctx);
  * qcrypto_der_encode_octet_str_begin and qcrypto_der_encode_octet_str_end
  * are encoded as an octet string. This is useful when we need to encode a
- * encoded SEQUNCE as OCTET STRING.
+ * encoded SEQUENCE as OCTET STRING.
  */
 void qcrypto_der_encode_octet_str_end(QCryptoEncodeContext *ctx);
@@ -276,5 +276,5 @@ size_t qcrypto_der_encode_ctx_buffer_len(QCryptoEncodeContext *ctx);
  * qcrypto_der_encode_ctx_flush_and_free:
  * @ctx: the encode context.
- * @dst: the distination to save the encoded data, the length of dst should
+ * @dst: the destination to save the encoded data, the length of dst should
  * not less than qcrypto_der_encode_cxt_buffer_len
  *
diff --git a/linux-user/flatload.c b/linux-user/flatload.c
index 8f5e9f489b..4331a11bf0 100644
--- a/linux-user/flatload.c
+++ b/linux-user/flatload.c
@@ -781,5 +781,5 @@ int load_flt_binary(struct linux_binprm *bprm, struct image_info *info)
        for all current targets, and excess alignment is harmless.  */
     stack_len = bprm->envc + bprm->argc + 2;
-    stack_len += flat_argvp_envp_on_stack() ? 2 : 0; /* arvg, argp */
+    stack_len += flat_argvp_envp_on_stack() ? 2 : 0; /* argv, argp */
     stack_len += 1; /* argc */
     stack_len *= sizeof(abi_ulong);
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9353268cc1..7ccd3affbe 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1810,5 +1810,5 @@ static inline abi_long target_to_host_cmsg(struct msghdr *msgh,
 
             memcpy(dst, target_data, len);
-            /* fix endianess of first 32-bit word */
+            /* fix endianness of first 32-bit word */
             if (len >= sizeof(uint32_t)) {
                 *dst = tswap32(*dst);
@@ -2921,5 +2921,5 @@ get_timeout:
                 return ret;
             }
-            /* swap host endianess to target endianess. */
+            /* swap host endianness to target endianness. */
             for (i = 0; i < (len / sizeof(uint32_t)); i++) {
                 results[i] = tswap32(results[i]);
diff --git a/nbd/client-connection.c b/nbd/client-connection.c
index 3d14296c04..258ef81ae9 100644
--- a/nbd/client-connection.c
+++ b/nbd/client-connection.c
@@ -198,5 +198,5 @@ static void *connect_thread_func(void *opaque)
          * pointers to our internally allocated strings, which are IN parameters
          * of nbd_receive_negotiate() and therefore nbd_connect(). Caller
-         * shoudn't be interested in these fields.
+         * shouldn't be interested in these fields.
          */
         conn->updated_info.x_dirty_bitmap = NULL;
diff --git a/net/checksum.c b/net/checksum.c
index 68245fd748..1a957e4c0b 100644
--- a/net/checksum.c
+++ b/net/checksum.c
@@ -75,5 +75,5 @@ void net_checksum_calculate(uint8_t *data, int length, int csum_flag)
     }
 
-    /* Handle the optionnal VLAN headers */
+    /* Handle the optional VLAN headers */
     switch (lduw_be_p(&PKT_GET_ETH_HDR(data)->h_proto)) {
     case ETH_P_VLAN:
@@ -97,5 +97,5 @@ void net_checksum_calculate(uint8_t *data, int length, int csum_flag)
     length -= mac_hdr_len;
 
-    /* Now check we have an IP header (with an optionnal VLAN header) */
+    /* Now check we have an IP header (with an optional VLAN header) */
     if (length < sizeof(struct ip_header)) {
         return;
diff --git a/net/filter.c b/net/filter.c
index 3fe88fa43f..3b92e04af0 100644
--- a/net/filter.c
+++ b/net/filter.c
@@ -93,5 +93,5 @@ ssize_t qemu_netfilter_pass_to_next(NetClientState *sender,
         /*
          * if qemu_netfilter_pass_to_next been called, means that
-         * the packet has been hold by filter and has already retured size
+         * the packet has been hold by filter and has already returned size
          * to the sender, so sent_cb shouldn't be called later, just
          * pass NULL to next.
@@ -107,5 +107,5 @@ ssize_t qemu_netfilter_pass_to_next(NetClientState *sender,
     /*
      * We have gone through all filters, pass it to receiver.
-     * Do the valid check again incase sender or receiver been
+     * Do the valid check again in case sender or receiver been
      * deleted while we go through filters.
      */
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 9795306742..34202ca009 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -822,5 +822,5 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
      * on by default.
      *
-     * Addtionally, according to VirtIO standard, "Since there are
+     * Additionally, according to VirtIO standard, "Since there are
      * no guarantees, it can use a hash filter or silently switch to
      * allmulti or promiscuous mode if it is given too many addresses.".
@@ -1131,5 +1131,5 @@ static int vhost_vdpa_net_excessive_mac_filter_cvq_add(VhostVDPAState *s,
      *
      * According to virtio_net_handle_mac(), QEMU doesn't verify the MAC
-     * addresses provieded in CVQ command. Therefore, only the entries
+     * addresses provided in CVQ command. Therefore, only the entries
      * field need to be prepared in the CVQ command.
      */
@@ -1142,5 +1142,5 @@ static int vhost_vdpa_net_excessive_mac_filter_cvq_add(VhostVDPAState *s,
      *
      * According to virtio_net_handle_mac(), QEMU doesn't verify the MAC
-     * addresses provieded in CVQ command. Therefore, only the entries
+     * addresses provided in CVQ command. Therefore, only the entries
      * field need to be prepared in the CVQ command.
      */
@@ -1203,5 +1203,5 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostShadowVirtqueue *svq,
          *
          * Therefore, QEMU must handle this situation instead of sending
-         * the CVQ command direclty.
+         * the CVQ command directly.
          */
         dev_written = vhost_vdpa_net_excessive_mac_filter_cvq_add(s, elem,
diff --git a/semihosting/config.c b/semihosting/config.c
index 89a1759687..8ca569735d 100644
--- a/semihosting/config.c
+++ b/semihosting/config.c
@@ -9,5 +9,5 @@
  * in target/HW/HW-semi.c
  *
- * Semihosting is sightly strange in that it is also supported by some
+ * Semihosting is slightly strange in that it is also supported by some
  * linux-user targets. However in that use case no configuration of
  * the outputs and command lines is supported.
diff --git a/semihosting/syscalls.c b/semihosting/syscalls.c
index 68899ebb1c..d27574a1e2 100644
--- a/semihosting/syscalls.c
+++ b/semihosting/syscalls.c
@@ -721,5 +721,5 @@ void semihost_sys_read_gf(CPUState *cs, gdb_syscall_complete_cb complete,
 {
     /*
-     * Bound length for 64-bit guests on 32-bit hosts, not overlowing ssize_t.
+     * Bound length for 64-bit guests on 32-bit hosts, not overflowing ssize_t.
      * Note the Linux kernel does this with MAX_RW_COUNT, so it's not a bad
      * idea to do this unconditionally.
@@ -762,5 +762,5 @@ void semihost_sys_write_gf(CPUState *cs, gdb_syscall_complete_cb complete,
 {
     /*
-     * Bound length for 64-bit guests on 32-bit hosts, not overlowing ssize_t.
+     * Bound length for 64-bit guests on 32-bit hosts, not overflowing ssize_t.
      * Note the Linux kernel does this with MAX_RW_COUNT, so it's not a bad
      * idea to do this unconditionally.
diff --git a/softmmu/icount.c b/softmmu/icount.c
index a5cef9c60a..144e24829c 100644
--- a/softmmu/icount.c
+++ b/softmmu/icount.c
@@ -326,5 +326,5 @@ void icount_start_warp_timer(void)
              * It is probably a race condition: notification sent
              * to vCPU was processed in advance and vCPU went to sleep.
-             * Therefore we have to wake it up for doing someting.
+             * Therefore we have to wake it up for doing something.
              */
             if (replay_has_event()) {
diff --git a/softmmu/ioport.c b/softmmu/ioport.c
index b66e0a5a8e..1824aa808c 100644
--- a/softmmu/ioport.c
+++ b/softmmu/ioport.c
@@ -23,5 +23,5 @@
  */
 /*
- * splitted out ioport related stuffs from vl.c.
+ * split out ioport related stuffs from vl.c.
  */
 
-- 
2.39.2


