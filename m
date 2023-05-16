Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D511D7047E6
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 10:33:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyq6c-0005Q2-A0; Tue, 16 May 2023 04:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=0500723a60=gmuthukrishn@marvell.com>)
 id 1pyq6Z-0005P9-AP
 for qemu-devel@nongnu.org; Tue, 16 May 2023 04:32:23 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=0500723a60=gmuthukrishn@marvell.com>)
 id 1pyq6U-00052m-4a
 for qemu-devel@nongnu.org; Tue, 16 May 2023 04:32:22 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34G87rvg027636; Tue, 16 May 2023 01:31:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=Qy004BX2Bg5qE7CViMzB1c70IMQHoggNAt6QGQXKph4=;
 b=idQakg/BZ+Sg0TBWYCQUiGh5iGwoXH328nWl6F92F1M80Zz8ThW8GdxCL989CEVYrNZs
 mchCD8b+k2A6WFVtMSMJG5wwRdr//A+CbZCMzLD6X1VamBZg0jLidpwdm9d1oAYKJJHJ
 nNjPVEy/M9jg9+iDOhmRhzHxRXph4L8ZnrIeMwLK1VN+DcVpOm+lfb42MBJcDu4p748F
 qCSIbYjsHX99xYOqwLx4q3gXfWHVG4yJz233YWx1dpt1JyBxQUfbV5kAn5sufcSIyxBX
 6YroSVWAL98lTpmzKKbiX2KifxqDUUgnbqe8iKuOAJwYNFO8/xYU0oJnRltOgbwszVhg pg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3qja2jrfnr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Tue, 16 May 2023 01:31:47 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48;
 Tue, 16 May 2023 01:31:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 16 May 2023 01:31:45 -0700
Received: from localhost.localdomain (unknown [10.28.34.38])
 by maili.marvell.com (Postfix) with ESMTP id 2D29F3F7043;
 Tue, 16 May 2023 01:31:42 -0700 (PDT)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <qemu-devel@nongnu.org>
CC: Gonglei <arei.gonglei@huawei.com>, Zhenwei Pi <pizhenwei@bytedance.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Anoob Joseph <anoobj@marvell.com>,
 Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Subject: [PATCH v2] cryptodev-vhost-user: add asymmetric crypto support
Date: Tue, 16 May 2023 14:01:39 +0530
Message-ID: <20230516083139.2349744-1-gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230514065519.2335265-1-gmuthukrishn@marvell.com>
References: <20230514065519.2335265-1-gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: QTLgMPl06XpQAB9rCP8VHhBEGetKM2qy
X-Proofpoint-ORIG-GUID: QTLgMPl06XpQAB9rCP8VHhBEGetKM2qy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_02,2023-05-05_01,2023-02-09_01
Received-SPF: pass client-ip=67.231.156.173;
 envelope-from=prvs=0500723a60=gmuthukrishn@marvell.com;
 helo=mx0b-0016f401.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Add asymmetric crypto support in vhost_user backend.

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
---
v2:
 - added buffer length check before memcpy.

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
index e5285df4ba..eaac1dc174 100644
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
@@ -173,13 +174,24 @@ typedef struct VhostUserConfig {
 
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
@@ -2366,7 +2378,7 @@ static int vhost_user_crypto_create_session(struct vhost_dev *dev,
     int ret;
     bool crypto_session = virtio_has_feature(dev->protocol_features,
                                        VHOST_USER_PROTOCOL_F_CRYPTO_SESSION);
-    CryptoDevBackendSymSessionInfo *sess_info = session_info;
+    CryptoDevBackendSessionInfo *backend_info = session_info;
     VhostUserMsg msg = {
         .hdr.request = VHOST_USER_CREATE_CRYPTO_SESSION,
         .hdr.flags = VHOST_USER_VERSION,
@@ -2380,16 +2392,53 @@ static int vhost_user_crypto_create_session(struct vhost_dev *dev,
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
+        CryptoDevBackendAsymSessionInfo *sess_info = &backend_info->u.asym_sess_info;
+        size_t keylen;
+
+        memcpy(&msg.payload.session.u.asym.session_setup_data, sess_info,
+               sizeof(CryptoDevBackendAsymSessionInfo));
+        if (sess_info->keylen) {
+            keylen = sizeof(msg.payload.session.u.asym.key);
+            if (sess_info->keylen > keylen) {
+                error_report("Unsupported asymmetric key size");
+                return -ENOTSUP;
+            }
+
+            memcpy(&msg.payload.session.u.asym.key, sess_info->key,
+                   sess_info->keylen);
+        }
+    } else {
+        CryptoDevBackendSymSessionInfo *sess_info = &backend_info->u.sym_sess_info;
+        size_t keylen;
+
+        memcpy(&msg.payload.session.u.sym.session_setup_data, sess_info,
+               sizeof(CryptoDevBackendSymSessionInfo));
+        if (sess_info->key_len) {
+            keylen = sizeof(msg.payload.session.u.sym.key);
+            if (sess_info->key_len > keylen) {
+                error_report("Unsupported cipher key size");
+                return -ENOTSUP;
+            }
+
+            memcpy(&msg.payload.session.u.sym.key, sess_info->cipher_key,
+                   sess_info->key_len);
+        }
+
+        if (sess_info->auth_key_len > 0) {
+            keylen = sizeof(msg.payload.session.u.sym.auth_key);
+            if (sess_info->auth_key_len > keylen) {
+                error_report("Unsupported auth key size");
+                return -ENOTSUP;
+            }
+
+            memcpy(&msg.payload.session.u.sym.auth_key, sess_info->auth_key,
+                   sess_info->auth_key_len);
+        }
     }
+
+    msg.payload.session.op_code = backend_info->op_code;
+    msg.payload.session.session_id = backend_info->session_id;
     ret = vhost_user_write(dev, &msg, NULL, 0);
     if (ret < 0) {
         error_report("vhost_user_write() return %d, create session failed",
-- 
2.25.1


