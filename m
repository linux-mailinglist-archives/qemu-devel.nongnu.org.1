Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CA17539D9
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 13:44:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKHCj-0005kE-4x; Fri, 14 Jul 2023 07:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKHAp-0002yv-80; Fri, 14 Jul 2023 07:41:25 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKHAj-0004jN-PN; Fri, 14 Jul 2023 07:41:19 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BCA3E13DA9;
 Fri, 14 Jul 2023 14:38:59 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id B46AC14BB8;
 Fri, 14 Jul 2023 14:38:43 +0300 (MSK)
Received: (nullmailer pid 1186283 invoked by uid 1000);
 Fri, 14 Jul 2023 11:38:38 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH, trivial 29/29] tree-wide spelling fixes in comments and some
 messages: other
Date: Fri, 14 Jul 2023 14:38:34 +0300
Message-Id: <20230714113834.1186117-31-mjt@tls.msk.ru>
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
 linux-user/elfload.c       | 2 +-
 linux-user/flatload.c      | 2 +-
 linux-user/syscall.c       | 6 +++---
 nbd/client-connection.c    | 2 +-
 net/checksum.c             | 4 ++--
 net/filter.c               | 4 ++--
 net/vhost-vdpa.c           | 8 ++++----
 semihosting/config.c       | 2 +-
 semihosting/syscalls.c     | 4 ++--
 softmmu/icount.c           | 2 +-
 softmmu/ioport.c           | 2 +-
 stubs/colo.c               | 2 +-
 22 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 9566224d18..9ed86a6b0a 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -1,3 +1,3 @@
 /*
- * Translation Block Maintaince
+ * Translation Block Maintenance
  *
diff --git a/backends/tpm/tpm_ioctl.h b/backends/tpm/tpm_ioctl.h
index b1d31768a6..1933ab6855 100644
--- a/backends/tpm/tpm_ioctl.h
+++ b/backends/tpm/tpm_ioctl.h
@@ -240,3 +240,3 @@ struct ptm_lockstorage {
             ptm_res tpm_result;
-        } resp; /* reponse */
+        } resp; /* response */
     } u;
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 8c58532171..fbe5716e57 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -712,3 +712,3 @@ static void tcp_chr_telnet_init(Chardev *chr)
         init->buflen = 12;
-        /* Prep the telnet negotion to put telnet in binary,
+        /* Prep the telnet negotiation to put telnet in binary,
          * no echo, single char mode */
@@ -720,3 +720,3 @@ static void tcp_chr_telnet_init(Chardev *chr)
         init->buflen = 21;
-        /* Prep the TN3270 negotion based on RFC1576 */
+        /* Prep the TN3270 negotiation based on RFC1576 */
         IACSET(init->buf, 0xff, 0xfd, 0x19);  /* IAC DO EOR */
@@ -1292,3 +1292,3 @@ static bool qmp_chardev_validate_socket(ChardevSocket *sock,
 
-    /* Validate any options which have a dependancy on client vs server */
+    /* Validate any options which have a dependency on client vs server */
     if (!sock->has_server || sock->server) {
diff --git a/chardev/char.c b/chardev/char.c
index 661ad8176a..996a024c7a 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -1117,3 +1117,3 @@ ChardevReturn *qmp_chardev_change(const char *id, ChardevBackend *backend,
 
-    /* change successfull, clean up */
+    /* change successful, clean up */
     chr_new->handover_yank_instance = false;
diff --git a/contrib/plugins/cache.c b/contrib/plugins/cache.c
index 5036213f1b..dea4a56c8d 100644
--- a/contrib/plugins/cache.c
+++ b/contrib/plugins/cache.c
@@ -352,3 +352,3 @@ static int in_cache(Cache *cache, uint64_t addr)
  *
- * Returns true if the requsted data is hit in the cache and false when missed.
+ * Returns true if the requested data is hit in the cache and false when missed.
  * The cache is updated on miss for the next access.
diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
index 3614c3564c..850f7b2941 100644
--- a/contrib/plugins/lockstep.c
+++ b/contrib/plugins/lockstep.c
@@ -110,3 +110,3 @@ static void report_divergance(ExecState *us, ExecState *them)
      * If we have diverged before did we get back on track or are we
-     * totally loosing it?
+     * totally losing it?
      */
diff --git a/crypto/afalg.c b/crypto/afalg.c
index 348301e703..52a491dbb5 100644
--- a/crypto/afalg.c
+++ b/crypto/afalg.c
@@ -75,3 +75,3 @@ qcrypto_afalg_comm_alloc(const char *type, const char *name,
     afalg = g_new0(QCryptoAFAlg, 1);
-    /* initilize crypto API socket */
+    /* initialize crypto API socket */
     afalg->opfd = -1;
diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index 5688783ab1..d5dadb7892 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -246,3 +246,3 @@ qcrypto_block_luks_has_format(const uint8_t *buf,
  * may be different from the cipher length used for the block
- * encryption, becauses dm-crypt uses the hash digest length
+ * encryption, because dm-crypt uses the hash digest length
  * as the key size. ie, if you have AES 128 as the block cipher
@@ -395,3 +395,3 @@ qcrypto_block_luks_from_disk_endian(QCryptoBlockLUKSHeader *hdr)
 /*
- * Stores the main LUKS header, taking care of endianess
+ * Stores the main LUKS header, taking care of endianness
  */
@@ -425,3 +425,3 @@ qcrypto_block_luks_store_header(QCryptoBlock *block,
 /*
- * Loads the main LUKS header,and byteswaps it to native endianess
+ * Loads the main LUKS header,and byteswaps it to native endianness
  * And run basic sanity checks on it
diff --git a/crypto/der.c b/crypto/der.c
index dab3fe4f24..ebbecfc3fe 100644
--- a/crypto/der.c
+++ b/crypto/der.c
@@ -78,3 +78,3 @@ enum QCryptoDERTagEnc {
  * @src_len: the length of source data
- * @dst: distination to save the encoded 'length', if dst is NULL, only compute
+ * @dst: destination to save the encoded 'length', if dst is NULL, only compute
  * the expected buffer size in bytes.
diff --git a/crypto/der.h b/crypto/der.h
index 0e895bbeec..f4ba6da28a 100644
--- a/crypto/der.h
+++ b/crypto/der.h
@@ -251,3 +251,3 @@ void qcrypto_der_encode_octet_str(QCryptoEncodeContext *ctx,
  * are encoded as an octet string. This is useful when we need to encode a
- * encoded SEQUNCE as OCTET STRING.
+ * encoded SEQUENCE as OCTET STRING.
  */
@@ -262,3 +262,3 @@ void qcrypto_der_encode_octet_str_begin(QCryptoEncodeContext *ctx);
  * are encoded as an octet string. This is useful when we need to encode a
- * encoded SEQUNCE as OCTET STRING.
+ * encoded SEQUENCE as OCTET STRING.
  */
@@ -277,3 +277,3 @@ size_t qcrypto_der_encode_ctx_buffer_len(QCryptoEncodeContext *ctx);
  * @ctx: the encode context.
- * @dst: the distination to save the encoded data, the length of dst should
+ * @dst: the destination to save the encoded data, the length of dst should
  * not less than qcrypto_der_encode_cxt_buffer_len
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index d3d1352c4e..4353ac011e 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2719,3 +2719,3 @@ static void pgb_static(const char *image_name, abi_ulong orig_loaddr,
          * For a 64-bit host, this is just 4GiB; for a 32-bit host we
-         * need to ensure there is space bellow the guest_base so we
+         * need to ensure there is space below the guest_base so we
          * can map the commpage in the place needed when the address
diff --git a/linux-user/flatload.c b/linux-user/flatload.c
index 5efec2630e..5943a68c52 100644
--- a/linux-user/flatload.c
+++ b/linux-user/flatload.c
@@ -782,3 +782,3 @@ int load_flt_binary(struct linux_binprm *bprm, struct image_info *info)
     stack_len = bprm->envc + bprm->argc + 2;
-    stack_len += flat_argvp_envp_on_stack() ? 2 : 0; /* arvg, argp */
+    stack_len += flat_argvp_envp_on_stack() ? 2 : 0; /* argv, argp */
     stack_len += 1; /* argc */
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 420bab7c68..3dc6bbc846 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -838,3 +838,3 @@ abi_long do_brk(abi_ulong brk_val)
 
-    /* Release heap if necesary */
+    /* Release heap if necessary */
     if (new_brk < target_brk) {
@@ -1847,3 +1847,3 @@ static inline abi_long target_to_host_cmsg(struct msghdr *msgh,
             memcpy(dst, target_data, len);
-            /* fix endianess of first 32-bit word */
+            /* fix endianness of first 32-bit word */
             if (len >= sizeof(uint32_t)) {
@@ -2958,3 +2958,3 @@ get_timeout:
             }
-            /* swap host endianess to target endianess. */
+            /* swap host endianness to target endianness. */
             for (i = 0; i < (len / sizeof(uint32_t)); i++) {
diff --git a/nbd/client-connection.c b/nbd/client-connection.c
index 3d14296c04..258ef81ae9 100644
--- a/nbd/client-connection.c
+++ b/nbd/client-connection.c
@@ -199,3 +199,3 @@ static void *connect_thread_func(void *opaque)
          * of nbd_receive_negotiate() and therefore nbd_connect(). Caller
-         * shoudn't be interested in these fields.
+         * shouldn't be interested in these fields.
          */
diff --git a/net/checksum.c b/net/checksum.c
index 68245fd748..1a957e4c0b 100644
--- a/net/checksum.c
+++ b/net/checksum.c
@@ -76,3 +76,3 @@ void net_checksum_calculate(uint8_t *data, int length, int csum_flag)
 
-    /* Handle the optionnal VLAN headers */
+    /* Handle the optional VLAN headers */
     switch (lduw_be_p(&PKT_GET_ETH_HDR(data)->h_proto)) {
@@ -98,3 +98,3 @@ void net_checksum_calculate(uint8_t *data, int length, int csum_flag)
 
-    /* Now check we have an IP header (with an optionnal VLAN header) */
+    /* Now check we have an IP header (with an optional VLAN header) */
     if (length < sizeof(struct ip_header)) {
diff --git a/net/filter.c b/net/filter.c
index 3fe88fa43f..3b92e04af0 100644
--- a/net/filter.c
+++ b/net/filter.c
@@ -94,3 +94,3 @@ ssize_t qemu_netfilter_pass_to_next(NetClientState *sender,
          * if qemu_netfilter_pass_to_next been called, means that
-         * the packet has been hold by filter and has already retured size
+         * the packet has been hold by filter and has already returned size
          * to the sender, so sent_cb shouldn't be called later, just
@@ -108,3 +108,3 @@ ssize_t qemu_netfilter_pass_to_next(NetClientState *sender,
      * We have gone through all filters, pass it to receiver.
-     * Do the valid check again incase sender or receiver been
+     * Do the valid check again in case sender or receiver been
      * deleted while we go through filters.
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 9795306742..34202ca009 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -823,3 +823,3 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
      *
-     * Addtionally, according to VirtIO standard, "Since there are
+     * Additionally, according to VirtIO standard, "Since there are
      * no guarantees, it can use a hash filter or silently switch to
@@ -1132,3 +1132,3 @@ static int vhost_vdpa_net_excessive_mac_filter_cvq_add(VhostVDPAState *s,
      * According to virtio_net_handle_mac(), QEMU doesn't verify the MAC
-     * addresses provieded in CVQ command. Therefore, only the entries
+     * addresses provided in CVQ command. Therefore, only the entries
      * field need to be prepared in the CVQ command.
@@ -1143,3 +1143,3 @@ static int vhost_vdpa_net_excessive_mac_filter_cvq_add(VhostVDPAState *s,
      * According to virtio_net_handle_mac(), QEMU doesn't verify the MAC
-     * addresses provieded in CVQ command. Therefore, only the entries
+     * addresses provided in CVQ command. Therefore, only the entries
      * field need to be prepared in the CVQ command.
@@ -1204,3 +1204,3 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostShadowVirtqueue *svq,
          * Therefore, QEMU must handle this situation instead of sending
-         * the CVQ command direclty.
+         * the CVQ command directly.
          */
diff --git a/semihosting/config.c b/semihosting/config.c
index 89a1759687..8ca569735d 100644
--- a/semihosting/config.c
+++ b/semihosting/config.c
@@ -10,3 +10,3 @@
  *
- * Semihosting is sightly strange in that it is also supported by some
+ * Semihosting is slightly strange in that it is also supported by some
  * linux-user targets. However in that use case no configuration of
diff --git a/semihosting/syscalls.c b/semihosting/syscalls.c
index 68899ebb1c..d27574a1e2 100644
--- a/semihosting/syscalls.c
+++ b/semihosting/syscalls.c
@@ -722,3 +722,3 @@ void semihost_sys_read_gf(CPUState *cs, gdb_syscall_complete_cb complete,
     /*
-     * Bound length for 64-bit guests on 32-bit hosts, not overlowing ssize_t.
+     * Bound length for 64-bit guests on 32-bit hosts, not overflowing ssize_t.
      * Note the Linux kernel does this with MAX_RW_COUNT, so it's not a bad
@@ -763,3 +763,3 @@ void semihost_sys_write_gf(CPUState *cs, gdb_syscall_complete_cb complete,
     /*
-     * Bound length for 64-bit guests on 32-bit hosts, not overlowing ssize_t.
+     * Bound length for 64-bit guests on 32-bit hosts, not overflowing ssize_t.
      * Note the Linux kernel does this with MAX_RW_COUNT, so it's not a bad
diff --git a/softmmu/icount.c b/softmmu/icount.c
index a5cef9c60a..144e24829c 100644
--- a/softmmu/icount.c
+++ b/softmmu/icount.c
@@ -327,3 +327,3 @@ void icount_start_warp_timer(void)
              * to vCPU was processed in advance and vCPU went to sleep.
-             * Therefore we have to wake it up for doing someting.
+             * Therefore we have to wake it up for doing something.
              */
diff --git a/softmmu/ioport.c b/softmmu/ioport.c
index b66e0a5a8e..1824aa808c 100644
--- a/softmmu/ioport.c
+++ b/softmmu/ioport.c
@@ -24,3 +24,3 @@
 /*
- * splitted out ioport related stuffs from vl.c.
+ * split out ioport related stuffs from vl.c.
  */
diff --git a/stubs/colo.c b/stubs/colo.c
index f33379d0fd..08c9f982d5 100644
--- a/stubs/colo.c
+++ b/stubs/colo.c
@@ -23,3 +23,3 @@ void migrate_start_colo_process(MigrationState *s)
 {
-    error_report("Impossible happend: trying to start COLO when COLO "
+    error_report("Impossible happened: trying to start COLO when COLO "
                  "module is not built in");
-- 
2.39.2


