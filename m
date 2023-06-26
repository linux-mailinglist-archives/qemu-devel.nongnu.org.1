Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF8673DF3B
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 14:30:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlKr-0001vO-Pg; Mon, 26 Jun 2023 08:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlKc-0001q6-LJ
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:28:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlKa-0002mm-JN
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:28:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HpijCPbqmV8/82Yuz6YLQPDKA9gyZY4F7fQYMz5NMV0=;
 b=fVlpWfKt8ZE9yVs6IDeUlnRnRtyo0YASW72CQOYmtnSdbxgcuKQtaRP+O/joPrRTXh6uGM
 IzBx0KjaTQ+54v4bUVOZZGgNbrubsY2A2dFEY0ccNTBUTzhsI0UXdX7cauU2hCuJoL9FLF
 EI2/QpHWT5ap4gWvNohdg+gu5I6NG6o=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-eGjlKC-aNMSauQY3Q1qmnw-1; Mon, 26 Jun 2023 08:28:30 -0400
X-MC-Unique: eGjlKC-aNMSauQY3Q1qmnw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4f3932e595dso2516089e87.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782508; x=1690374508;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HpijCPbqmV8/82Yuz6YLQPDKA9gyZY4F7fQYMz5NMV0=;
 b=j/NB5ycTc1QGARV+7rUNhYBehe91uVL5RJUcDCJB8cyamK0b5Z1gK4PDkC8IStE8Rb
 L+aw8fCi477SUshEJNgsUsjlobLmlnS+ahN1AB9JcTmy5SeL0e7xRgkTqMF77D6TjIu3
 CfcmURZioul9Z/kWvcSRI5F+alykjntCUrlCt0+UfnpyGZsQnksiDMUQigKvkXl2uG3G
 aloaiZCXTNl4GuvdcOyE9+CrzytQw/QVogYMkEwztDwxUCTDjUm2PUstxxM4x177Ru3/
 rROLQkYYd0ORvs3Cnjbut9JoPkLY2mqtauLh+KmXYTrFP7VaMfHwhkSw4p0MrfaJnuF0
 XMMw==
X-Gm-Message-State: AC+VfDxe2J4r9e20RpDAdlF4mm/3beBoZygmnlSUued4Xz6GSiBpuhid
 1EJpivfZC17urSeiW76fepl6bXdfzwYqzQ6VEukH7OAM1PKOqD23aRLZDVUAZ/m95dzdbAWl3t5
 7s3KzKkE+rh7+WA41WEhlTT7BB78Xo2+hwxQWMfhuG5ETWXVX9QRD7mvxmOi9Qo27AptU
X-Received: by 2002:a19:6918:0:b0:4f8:7556:23eb with SMTP id
 e24-20020a196918000000b004f8755623ebmr11807974lfc.39.1687782508473; 
 Mon, 26 Jun 2023 05:28:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ61JZ9npbgcU5MTbby1wX0cl8dcdczPPgkuF6YipqAl4OLXwLheXyvPKXkBlkvPaGKtCl8Iow==
X-Received: by 2002:a19:6918:0:b0:4f8:7556:23eb with SMTP id
 e24-20020a196918000000b004f8755623ebmr11807951lfc.39.1687782508135; 
 Mon, 26 Jun 2023 05:28:28 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 z7-20020a05600c220700b003fa999cefc0sm1874055wml.36.2023.06.26.05.28.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:28:27 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:28:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>
Subject: [PULL 12/53] cryptodev-vhost-user: add asymmetric crypto support
Message-ID: <5c33f9783ace0b5e077060b220978d94fecb3e81.1687782442.git.mst@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687782442.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>

Add asymmetric crypto support in vhost_user backend.

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Message-Id: <20230516083139.2349744-1-gmuthukrishn@marvell.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 backends/cryptodev-vhost-user.c |  9 ++--
 hw/virtio/vhost-user.c          | 75 +++++++++++++++++++++++++++------
 2 files changed, 66 insertions(+), 18 deletions(-)

diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-user.c
index b1d9eb735f..c3283ba84a 100644
--- a/backends/cryptodev-vhost-user.c
+++ b/backends/cryptodev-vhost-user.c
@@ -232,9 +232,9 @@ static void cryptodev_vhost_user_init(
     backend->conf.max_auth_key_len = VHOST_USER_MAX_AUTH_KEY_LEN;
 }
 
-static int64_t cryptodev_vhost_user_sym_create_session(
+static int64_t cryptodev_vhost_user_crypto_create_session(
            CryptoDevBackend *backend,
-           CryptoDevBackendSymSessionInfo *sess_info,
+           CryptoDevBackendSessionInfo *sess_info,
            uint32_t queue_index, Error **errp)
 {
     CryptoDevBackendClient *cc =
@@ -266,18 +266,17 @@ static int cryptodev_vhost_user_create_session(
            void *opaque)
 {
     uint32_t op_code = sess_info->op_code;
-    CryptoDevBackendSymSessionInfo *sym_sess_info;
     int64_t ret;
     Error *local_error = NULL;
     int status;
 
     switch (op_code) {
     case VIRTIO_CRYPTO_CIPHER_CREATE_SESSION:
+    case VIRTIO_CRYPTO_AKCIPHER_CREATE_SESSION:
     case VIRTIO_CRYPTO_HASH_CREATE_SESSION:
     case VIRTIO_CRYPTO_MAC_CREATE_SESSION:
     case VIRTIO_CRYPTO_AEAD_CREATE_SESSION:
-        sym_sess_info = &sess_info->u.sym_sess_info;
-        ret = cryptodev_vhost_user_sym_create_session(backend, sym_sess_info,
+        ret = cryptodev_vhost_user_crypto_create_session(backend, sess_info,
                    queue_index, &local_error);
         break;
 
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 74a2a28663..2ad75a7964 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -11,6 +11,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/virtio/vhost.h"
+#include "hw/virtio/virtio-crypto.h"
 #include "hw/virtio/vhost-user.h"
 #include "hw/virtio/vhost-backend.h"
 #include "hw/virtio/virtio.h"
@@ -163,13 +164,24 @@ typedef struct VhostUserConfig {
 
 #define VHOST_CRYPTO_SYM_HMAC_MAX_KEY_LEN    512
 #define VHOST_CRYPTO_SYM_CIPHER_MAX_KEY_LEN  64
+#define VHOST_CRYPTO_ASYM_MAX_KEY_LEN  1024
 
 typedef struct VhostUserCryptoSession {
+    uint64_t op_code;
+    union {
+        struct {
+            CryptoDevBackendSymSessionInfo session_setup_data;
+            uint8_t key[VHOST_CRYPTO_SYM_CIPHER_MAX_KEY_LEN];
+            uint8_t auth_key[VHOST_CRYPTO_SYM_HMAC_MAX_KEY_LEN];
+        } sym;
+        struct {
+            CryptoDevBackendAsymSessionInfo session_setup_data;
+            uint8_t key[VHOST_CRYPTO_ASYM_MAX_KEY_LEN];
+        } asym;
+    } u;
+
     /* session id for success, -1 on errors */
     int64_t session_id;
-    CryptoDevBackendSymSessionInfo session_setup_data;
-    uint8_t key[VHOST_CRYPTO_SYM_CIPHER_MAX_KEY_LEN];
-    uint8_t auth_key[VHOST_CRYPTO_SYM_HMAC_MAX_KEY_LEN];
 } VhostUserCryptoSession;
 
 static VhostUserConfig c __attribute__ ((unused));
@@ -2357,7 +2369,7 @@ static int vhost_user_crypto_create_session(struct vhost_dev *dev,
     int ret;
     bool crypto_session = virtio_has_feature(dev->protocol_features,
                                        VHOST_USER_PROTOCOL_F_CRYPTO_SESSION);
-    CryptoDevBackendSymSessionInfo *sess_info = session_info;
+    CryptoDevBackendSessionInfo *backend_info = session_info;
     VhostUserMsg msg = {
         .hdr.request = VHOST_USER_CREATE_CRYPTO_SESSION,
         .hdr.flags = VHOST_USER_VERSION,
@@ -2371,16 +2383,53 @@ static int vhost_user_crypto_create_session(struct vhost_dev *dev,
         return -ENOTSUP;
     }
 
-    memcpy(&msg.payload.session.session_setup_data, sess_info,
-              sizeof(CryptoDevBackendSymSessionInfo));
-    if (sess_info->key_len) {
-        memcpy(&msg.payload.session.key, sess_info->cipher_key,
-               sess_info->key_len);
-    }
-    if (sess_info->auth_key_len > 0) {
-        memcpy(&msg.payload.session.auth_key, sess_info->auth_key,
-               sess_info->auth_key_len);
+    if (backend_info->op_code == VIRTIO_CRYPTO_AKCIPHER_CREATE_SESSION) {
+        CryptoDevBackendAsymSessionInfo *sess = &backend_info->u.asym_sess_info;
+        size_t keylen;
+
+        memcpy(&msg.payload.session.u.asym.session_setup_data, sess,
+               sizeof(CryptoDevBackendAsymSessionInfo));
+        if (sess->keylen) {
+            keylen = sizeof(msg.payload.session.u.asym.key);
+            if (sess->keylen > keylen) {
+                error_report("Unsupported asymmetric key size");
+                return -ENOTSUP;
+            }
+
+            memcpy(&msg.payload.session.u.asym.key, sess->key,
+                   sess->keylen);
+        }
+    } else {
+        CryptoDevBackendSymSessionInfo *sess = &backend_info->u.sym_sess_info;
+        size_t keylen;
+
+        memcpy(&msg.payload.session.u.sym.session_setup_data, sess,
+               sizeof(CryptoDevBackendSymSessionInfo));
+        if (sess->key_len) {
+            keylen = sizeof(msg.payload.session.u.sym.key);
+            if (sess->key_len > keylen) {
+                error_report("Unsupported cipher key size");
+                return -ENOTSUP;
+            }
+
+            memcpy(&msg.payload.session.u.sym.key, sess->cipher_key,
+                   sess->key_len);
+        }
+
+        if (sess->auth_key_len > 0) {
+            keylen = sizeof(msg.payload.session.u.sym.auth_key);
+            if (sess->auth_key_len > keylen) {
+                error_report("Unsupported auth key size");
+                return -ENOTSUP;
+            }
+
+            memcpy(&msg.payload.session.u.sym.auth_key, sess->auth_key,
+                   sess->auth_key_len);
+        }
     }
+
+    msg.payload.session.op_code = backend_info->op_code;
+    msg.payload.session.session_id = backend_info->session_id;
     ret = vhost_user_write(dev, &msg, NULL, 0);
     if (ret < 0) {
         error_report("vhost_user_write() return %d, create session failed",
-- 
MST


