Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 283B379853F
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 11:57:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeYEA-0007OD-2f; Fri, 08 Sep 2023 05:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qeYE7-0007EZ-H4; Fri, 08 Sep 2023 05:56:35 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qeYE4-0006t8-KP; Fri, 08 Sep 2023 05:56:35 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3C99B200D3;
 Fri,  8 Sep 2023 12:56:47 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 36AC926919;
 Fri,  8 Sep 2023 12:55:58 +0300 (MSK)
Received: (nullmailer pid 275973 invoked by uid 1000);
 Fri, 08 Sep 2023 09:55:56 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Eric Blake <eblake@redhat.com>
Subject: [PULL 11/23] misc/other: spelling fixes
Date: Fri,  8 Sep 2023 12:55:08 +0300
Message-Id: <20230908095520.275866-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230908095520.275866-1-mjt@tls.msk.ru>
References: <20230908095520.275866-1-mjt@tls.msk.ru>
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
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 backends/tpm/tpm_ioctl.h | 2 +-
 chardev/char-socket.c    | 6 +++---
 chardev/char.c           | 2 +-
 crypto/afalg.c           | 2 +-
 crypto/block-luks.c      | 6 +++---
 crypto/der.c             | 2 +-
 crypto/der.h             | 6 +++---
 nbd/client-connection.c  | 2 +-
 net/checksum.c           | 4 ++--
 net/filter.c             | 6 +++---
 net/vhost-vdpa.c         | 8 ++++----
 11 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/backends/tpm/tpm_ioctl.h b/backends/tpm/tpm_ioctl.h
index b1d31768a6..1933ab6855 100644
--- a/backends/tpm/tpm_ioctl.h
+++ b/backends/tpm/tpm_ioctl.h
@@ -238,7 +238,7 @@ struct ptm_lockstorage {
         } req; /* request */
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
@@ -710,7 +710,7 @@ static void tcp_chr_telnet_init(Chardev *chr)
 
     if (!s->is_tn3270) {
         init->buflen = 12;
-        /* Prep the telnet negotion to put telnet in binary,
+        /* Prep the telnet negotiation to put telnet in binary,
          * no echo, single char mode */
         IACSET(init->buf, 0xff, 0xfb, 0x01);  /* IAC WILL ECHO */
         IACSET(init->buf, 0xff, 0xfb, 0x03);  /* IAC WILL Suppress go ahead */
@@ -718,7 +718,7 @@ static void tcp_chr_telnet_init(Chardev *chr)
         IACSET(init->buf, 0xff, 0xfd, 0x00);  /* IAC DO Binary */
     } else {
         init->buflen = 21;
-        /* Prep the TN3270 negotion based on RFC1576 */
+        /* Prep the TN3270 negotiation based on RFC1576 */
         IACSET(init->buf, 0xff, 0xfd, 0x19);  /* IAC DO EOR */
         IACSET(init->buf, 0xff, 0xfb, 0x19);  /* IAC WILL EOR */
         IACSET(init->buf, 0xff, 0xfd, 0x00);  /* IAC DO BINARY */
@@ -1298,7 +1298,7 @@ static bool qmp_chardev_validate_socket(ChardevSocket *sock,
         return false;
     }
 
-    /* Validate any options which have a dependancy on client vs server */
+    /* Validate any options which have a dependency on client vs server */
     if (!sock->has_server || sock->server) {
         if (sock->has_reconnect) {
             error_setg(errp,
diff --git a/chardev/char.c b/chardev/char.c
index 661ad8176a..996a024c7a 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -1115,7 +1115,7 @@ ChardevReturn *qmp_chardev_change(const char *id, ChardevBackend *backend,
         return NULL;
     }
 
-    /* change successfull, clean up */
+    /* change successful, clean up */
     chr_new->handover_yank_instance = false;
 
     /*
diff --git a/crypto/afalg.c b/crypto/afalg.c
index 348301e703..52a491dbb5 100644
--- a/crypto/afalg.c
+++ b/crypto/afalg.c
@@ -73,7 +73,7 @@ qcrypto_afalg_comm_alloc(const char *type, const char *name,
     QCryptoAFAlg *afalg;
 
     afalg = g_new0(QCryptoAFAlg, 1);
-    /* initilize crypto API socket */
+    /* initialize crypto API socket */
     afalg->opfd = -1;
     afalg->tfmfd = qcrypto_afalg_socket_bind(type, name, errp);
     if (afalg->tfmfd == -1) {
diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index 2f59c3a625..fb01ec38bb 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -244,7 +244,7 @@ qcrypto_block_luks_has_format(const uint8_t *buf,
  *
  * When calculating ESSIV IVs, the cipher length used by ESSIV
  * may be different from the cipher length used for the block
- * encryption, becauses dm-crypt uses the hash digest length
+ * encryption, because dm-crypt uses the hash digest length
  * as the key size. ie, if you have AES 128 as the block cipher
  * and SHA 256 as ESSIV hash, then ESSIV will use AES 256 as
  * the cipher since that gets a key length matching the digest
@@ -393,7 +393,7 @@ qcrypto_block_luks_from_disk_endian(QCryptoBlockLUKSHeader *hdr)
 }
 
 /*
- * Stores the main LUKS header, taking care of endianess
+ * Stores the main LUKS header, taking care of endianness
  */
 static int
 qcrypto_block_luks_store_header(QCryptoBlock *block,
@@ -423,7 +423,7 @@ qcrypto_block_luks_store_header(QCryptoBlock *block,
 }
 
 /*
- * Loads the main LUKS header,and byteswaps it to native endianess
+ * Loads the main LUKS header, and byteswaps it to native endianness
  * And run basic sanity checks on it
  */
 static int
diff --git a/crypto/der.c b/crypto/der.c
index dab3fe4f24..ebbecfc3fe 100644
--- a/crypto/der.c
+++ b/crypto/der.c
@@ -76,7 +76,7 @@ enum QCryptoDERTagEnc {
 /**
  * qcrypto_der_encode_length:
  * @src_len: the length of source data
- * @dst: distination to save the encoded 'length', if dst is NULL, only compute
+ * @dst: destination to save the encoded 'length', if dst is NULL, only compute
  * the expected buffer size in bytes.
  * @dst_len: output parameter, indicates how many bytes wrote.
  *
diff --git a/crypto/der.h b/crypto/der.h
index 0e895bbeec..f4ba6da28a 100644
--- a/crypto/der.h
+++ b/crypto/der.h
@@ -249,7 +249,7 @@ void qcrypto_der_encode_octet_str(QCryptoEncodeContext *ctx,
  * Start encoding a octet string, All fields between
  * qcrypto_der_encode_octet_str_begin and qcrypto_der_encode_octet_str_end
  * are encoded as an octet string. This is useful when we need to encode a
- * encoded SEQUNCE as OCTET STRING.
+ * encoded SEQUENCE as OCTET STRING.
  */
 void qcrypto_der_encode_octet_str_begin(QCryptoEncodeContext *ctx);
 
@@ -260,7 +260,7 @@ void qcrypto_der_encode_octet_str_begin(QCryptoEncodeContext *ctx);
  * Finish encoding a octet string, All fields between
  * qcrypto_der_encode_octet_str_begin and qcrypto_der_encode_octet_str_end
  * are encoded as an octet string. This is useful when we need to encode a
- * encoded SEQUNCE as OCTET STRING.
+ * encoded SEQUENCE as OCTET STRING.
  */
 void qcrypto_der_encode_octet_str_end(QCryptoEncodeContext *ctx);
 
@@ -275,7 +275,7 @@ size_t qcrypto_der_encode_ctx_buffer_len(QCryptoEncodeContext *ctx);
 /**
  * qcrypto_der_encode_ctx_flush_and_free:
  * @ctx: the encode context.
- * @dst: the distination to save the encoded data, the length of dst should
+ * @dst: the destination to save the encoded data, the length of dst should
  * not less than qcrypto_der_encode_cxt_buffer_len
  *
  * Flush all encoded data into dst, then free ctx.
diff --git a/nbd/client-connection.c b/nbd/client-connection.c
index 3d14296c04..258ef81ae9 100644
--- a/nbd/client-connection.c
+++ b/nbd/client-connection.c
@@ -197,7 +197,7 @@ static void *connect_thread_func(void *opaque)
          * conn->updated_info will finally be returned to the user. Clear the
          * pointers to our internally allocated strings, which are IN parameters
          * of nbd_receive_negotiate() and therefore nbd_connect(). Caller
-         * shoudn't be interested in these fields.
+         * shouldn't be interested in these fields.
          */
         conn->updated_info.x_dirty_bitmap = NULL;
         conn->updated_info.name = NULL;
diff --git a/net/checksum.c b/net/checksum.c
index 68245fd748..1a957e4c0b 100644
--- a/net/checksum.c
+++ b/net/checksum.c
@@ -74,7 +74,7 @@ void net_checksum_calculate(uint8_t *data, int length, int csum_flag)
         return;
     }
 
-    /* Handle the optionnal VLAN headers */
+    /* Handle the optional VLAN headers */
     switch (lduw_be_p(&PKT_GET_ETH_HDR(data)->h_proto)) {
     case ETH_P_VLAN:
         mac_hdr_len = sizeof(struct eth_header) +
@@ -96,7 +96,7 @@ void net_checksum_calculate(uint8_t *data, int length, int csum_flag)
 
     length -= mac_hdr_len;
 
-    /* Now check we have an IP header (with an optionnal VLAN header) */
+    /* Now check we have an IP header (with an optional VLAN header) */
     if (length < sizeof(struct ip_header)) {
         return;
     }
diff --git a/net/filter.c b/net/filter.c
index 3fe88fa43f..3335908771 100644
--- a/net/filter.c
+++ b/net/filter.c
@@ -91,8 +91,8 @@ ssize_t qemu_netfilter_pass_to_next(NetClientState *sender,
     next = netfilter_next(nf, direction);
     while (next) {
         /*
-         * if qemu_netfilter_pass_to_next been called, means that
-         * the packet has been hold by filter and has already retured size
+         * if qemu_netfilter_pass_to_next has been called, it means that
+         * the packet was held by  a filter and has already returned size
          * to the sender, so sent_cb shouldn't be called later, just
          * pass NULL to next.
          */
@@ -106,7 +106,7 @@ ssize_t qemu_netfilter_pass_to_next(NetClientState *sender,
 
     /*
      * We have gone through all filters, pass it to receiver.
-     * Do the valid check again incase sender or receiver been
+     * Do the valid check again in case sender or receiver been
      * deleted while we go through filters.
      */
     if (sender && sender->peer) {
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 9795306742..34202ca009 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -821,7 +821,7 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
      * According to virtio_net_reset(), device turns promiscuous mode
      * on by default.
      *
-     * Addtionally, according to VirtIO standard, "Since there are
+     * Additionally, according to VirtIO standard, "Since there are
      * no guarantees, it can use a hash filter or silently switch to
      * allmulti or promiscuous mode if it is given too many addresses.".
      * QEMU marks `n->mac_table.uni_overflow` if guest sets too many
@@ -1130,7 +1130,7 @@ static int vhost_vdpa_net_excessive_mac_filter_cvq_add(VhostVDPAState *s,
      * Pack the non-multicast MAC addresses part for fake CVQ command.
      *
      * According to virtio_net_handle_mac(), QEMU doesn't verify the MAC
-     * addresses provieded in CVQ command. Therefore, only the entries
+     * addresses provided in CVQ command. Therefore, only the entries
      * field need to be prepared in the CVQ command.
      */
     mac_ptr = out->iov_base + cursor;
@@ -1141,7 +1141,7 @@ static int vhost_vdpa_net_excessive_mac_filter_cvq_add(VhostVDPAState *s,
      * Pack the multicast MAC addresses part for fake CVQ command.
      *
      * According to virtio_net_handle_mac(), QEMU doesn't verify the MAC
-     * addresses provieded in CVQ command. Therefore, only the entries
+     * addresses provided in CVQ command. Therefore, only the entries
      * field need to be prepared in the CVQ command.
      */
     mac_ptr = out->iov_base + cursor;
@@ -1202,7 +1202,7 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostShadowVirtqueue *svq,
          * rejects the flawed CVQ command.
          *
          * Therefore, QEMU must handle this situation instead of sending
-         * the CVQ command direclty.
+         * the CVQ command directly.
          */
         dev_written = vhost_vdpa_net_excessive_mac_filter_cvq_add(s, elem,
                                                                   &out);
-- 
2.39.2


