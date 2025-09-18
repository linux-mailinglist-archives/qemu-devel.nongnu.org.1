Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF027B385E3
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Aug 2025 17:13:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urHoJ-0006jw-D6; Wed, 27 Aug 2025 11:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHl7-0000S7-TY; Wed, 27 Aug 2025 11:08:29 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHkz-0005qj-8e; Wed, 27 Aug 2025 11:08:15 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0C3D114C55D;
 Wed, 27 Aug 2025 18:03:00 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id EE6BE269864;
 Wed, 27 Aug 2025 18:03:26 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.4 52/59] rbd: Fix .bdrv_get_specific_info implementation
Date: Wed, 27 Aug 2025 18:02:57 +0300
Message-ID: <20250827150323.2694101-52-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
References: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Kevin Wolf <kwolf@redhat.com>

qemu_rbd_get_specific_info() has at least two problems:

The first is that it issues a blocking rbd_read() call in order to probe
the encryption format for the image while querying the node. This means
that if the connection to the server goes down, not only I/O is stuck
(which is unavoidable), but query-names-block-nodes will actually make
the whole QEMU instance unresponsive. .bdrv_get_specific_info
implementations shouldn't perform blocking operations, but only return
what is already known.

The second is that the information returned isn't even correct. If the
image is already opened with encryption enabled at the RBD level, we'll
probe for "double encryption", i.e. if the encrypted data contains
another encryption header. If it doesn't (which is the normal case), we
won't return the encryption format. If it does, we return misleading
information because it looks like we're talking about the outer level
(the encryption format of the image itself) while the information is
about an encryption header in the guest data.

Fix this by storing the encryption format in BDRVRBDState when the image
is opened (and we do blocking operations anyway) and returning only the
stored information in qemu_rbd_get_specific_info().

The information we'll store is either the actual encryption format that
we enabled on the RBD level, or if the image is unencrypted, the result
of the same probing as we previously did when querying the node. Probing
image formats based on content that can be modified by the guest has
long been known as problematic, but as long as we only output it to the
user instead of making decisions based on it, it should be okay. It is
undoubtedly useful in the context of 'qemu-img info' when you're trying
to figure out which encryption options you have to use to open the
image successfully.

Fixes: 42e4ac9ef5a6 ("block/rbd: Add support for rbd image encryption")
Buglink: https://issues.redhat.com/browse/RHEL-105440
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20250811134010.81787-1-kwolf@redhat.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 4af976ef398e4e823addc00bf1c58787ba4952fe)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/rbd.c b/block/rbd.c
index af984fb7db..446e90d34c 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -99,6 +99,14 @@ typedef struct BDRVRBDState {
     char *namespace;
     uint64_t image_size;
     uint64_t object_size;
+
+    /*
+     * If @bs->encrypted is true, this is the encryption format actually loaded
+     * at the librbd level. If it is false, it is the result of probing.
+     * RBD_IMAGE_ENCRYPTION_FORMAT__MAX means that encryption is not enabled and
+     * probing didn't find any known encryption header either.
+     */
+    RbdImageEncryptionFormat encryption_format;
 } BDRVRBDState;
 
 typedef struct RBDTask {
@@ -471,10 +479,12 @@ static int qemu_rbd_encryption_format(rbd_image_t image,
     return 0;
 }
 
-static int qemu_rbd_encryption_load(rbd_image_t image,
+static int qemu_rbd_encryption_load(BlockDriverState *bs,
+                                    rbd_image_t image,
                                     RbdEncryptionOptions *encrypt,
                                     Error **errp)
 {
+    BDRVRBDState *s = bs->opaque;
     int r = 0;
     g_autofree char *passphrase = NULL;
     rbd_encryption_luks1_format_options_t luks_opts;
@@ -545,15 +555,19 @@ static int qemu_rbd_encryption_load(rbd_image_t image,
         error_setg_errno(errp, -r, "encryption load fail");
         return r;
     }
+    bs->encrypted = true;
+    s->encryption_format = encrypt->format;
 
     return 0;
 }
 
 #ifdef LIBRBD_SUPPORTS_ENCRYPTION_LOAD2
-static int qemu_rbd_encryption_load2(rbd_image_t image,
+static int qemu_rbd_encryption_load2(BlockDriverState *bs,
+                                     rbd_image_t image,
                                      RbdEncryptionOptions *encrypt,
                                      Error **errp)
 {
+    BDRVRBDState *s = bs->opaque;
     int r = 0;
     int encrypt_count = 1;
     int i;
@@ -639,6 +653,8 @@ static int qemu_rbd_encryption_load2(rbd_image_t image,
         error_setg_errno(errp, -r, "layered encryption load fail");
         goto exit;
     }
+    bs->encrypted = true;
+    s->encryption_format = encrypt->format;
 
 exit:
     for (i = 0; i < encrypt_count; ++i) {
@@ -672,6 +688,45 @@ exit:
 #endif
 #endif
 
+/*
+ * For an image without encryption enabled on the rbd layer, probe the start of
+ * the image if it could be opened as an encrypted image so that we can display
+ * it when the user queries the node (most importantly in qemu-img).
+ *
+ * If the guest writes an encryption header to its disk after this probing, this
+ * won't be reflected when queried, but that's okay. There is no reason why the
+ * user should want to apply encryption at the rbd level while the image is
+ * still in use. This is just guest data.
+ */
+static void qemu_rbd_encryption_probe(BlockDriverState *bs)
+{
+    BDRVRBDState *s = bs->opaque;
+    char buf[RBD_ENCRYPTION_LUKS_HEADER_VERIFICATION_LEN] = {0};
+    int r;
+
+    assert(s->encryption_format == RBD_IMAGE_ENCRYPTION_FORMAT__MAX);
+
+    r = rbd_read(s->image, 0,
+                 RBD_ENCRYPTION_LUKS_HEADER_VERIFICATION_LEN, buf);
+    if (r < RBD_ENCRYPTION_LUKS_HEADER_VERIFICATION_LEN) {
+        return;
+    }
+
+    if (memcmp(buf, rbd_luks_header_verification,
+               RBD_ENCRYPTION_LUKS_HEADER_VERIFICATION_LEN) == 0) {
+        s->encryption_format = RBD_IMAGE_ENCRYPTION_FORMAT_LUKS;
+    } else if (memcmp(buf, rbd_luks2_header_verification,
+               RBD_ENCRYPTION_LUKS_HEADER_VERIFICATION_LEN) == 0) {
+        s->encryption_format = RBD_IMAGE_ENCRYPTION_FORMAT_LUKS2;
+    } else if (memcmp(buf, rbd_layered_luks_header_verification,
+               RBD_ENCRYPTION_LUKS_HEADER_VERIFICATION_LEN) == 0) {
+        s->encryption_format = RBD_IMAGE_ENCRYPTION_FORMAT_LUKS;
+    } else if (memcmp(buf, rbd_layered_luks2_header_verification,
+               RBD_ENCRYPTION_LUKS_HEADER_VERIFICATION_LEN) == 0) {
+        s->encryption_format = RBD_IMAGE_ENCRYPTION_FORMAT_LUKS2;
+    }
+}
+
 /* FIXME Deprecate and remove keypairs or make it available in QMP. */
 static int qemu_rbd_do_create(BlockdevCreateOptions *options,
                               const char *keypairs, const char *password_secret,
@@ -1134,17 +1189,18 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
         goto failed_open;
     }
 
+    s->encryption_format = RBD_IMAGE_ENCRYPTION_FORMAT__MAX;
     if (opts->encrypt) {
 #ifdef LIBRBD_SUPPORTS_ENCRYPTION
         if (opts->encrypt->parent) {
 #ifdef LIBRBD_SUPPORTS_ENCRYPTION_LOAD2
-            r = qemu_rbd_encryption_load2(s->image, opts->encrypt, errp);
+            r = qemu_rbd_encryption_load2(bs, s->image, opts->encrypt, errp);
 #else
             r = -ENOTSUP;
             error_setg(errp, "RBD library does not support layered encryption");
 #endif
         } else {
-            r = qemu_rbd_encryption_load(s->image, opts->encrypt, errp);
+            r = qemu_rbd_encryption_load(bs, s->image, opts->encrypt, errp);
         }
         if (r < 0) {
             goto failed_post_open;
@@ -1154,6 +1210,8 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
         error_setg(errp, "RBD library does not support image encryption");
         goto failed_post_open;
 #endif
+    } else {
+        qemu_rbd_encryption_probe(bs);
     }
 
     r = rbd_stat(s->image, &info, sizeof(info));
@@ -1413,17 +1471,6 @@ static ImageInfoSpecific *qemu_rbd_get_specific_info(BlockDriverState *bs,
 {
     BDRVRBDState *s = bs->opaque;
     ImageInfoSpecific *spec_info;
-    char buf[RBD_ENCRYPTION_LUKS_HEADER_VERIFICATION_LEN] = {0};
-    int r;
-
-    if (s->image_size >= RBD_ENCRYPTION_LUKS_HEADER_VERIFICATION_LEN) {
-        r = rbd_read(s->image, 0,
-                     RBD_ENCRYPTION_LUKS_HEADER_VERIFICATION_LEN, buf);
-        if (r < 0) {
-            error_setg_errno(errp, -r, "cannot read image start for probe");
-            return NULL;
-        }
-    }
 
     spec_info = g_new(ImageInfoSpecific, 1);
     *spec_info = (ImageInfoSpecific){
@@ -1431,28 +1478,13 @@ static ImageInfoSpecific *qemu_rbd_get_specific_info(BlockDriverState *bs,
         .u.rbd.data = g_new0(ImageInfoSpecificRbd, 1),
     };
 
-    if (memcmp(buf, rbd_luks_header_verification,
-               RBD_ENCRYPTION_LUKS_HEADER_VERIFICATION_LEN) == 0) {
-        spec_info->u.rbd.data->encryption_format =
-                RBD_IMAGE_ENCRYPTION_FORMAT_LUKS;
-        spec_info->u.rbd.data->has_encryption_format = true;
-    } else if (memcmp(buf, rbd_luks2_header_verification,
-               RBD_ENCRYPTION_LUKS_HEADER_VERIFICATION_LEN) == 0) {
-        spec_info->u.rbd.data->encryption_format =
-                RBD_IMAGE_ENCRYPTION_FORMAT_LUKS2;
-        spec_info->u.rbd.data->has_encryption_format = true;
-    } else if (memcmp(buf, rbd_layered_luks_header_verification,
-               RBD_ENCRYPTION_LUKS_HEADER_VERIFICATION_LEN) == 0) {
-        spec_info->u.rbd.data->encryption_format =
-                RBD_IMAGE_ENCRYPTION_FORMAT_LUKS;
-        spec_info->u.rbd.data->has_encryption_format = true;
-    } else if (memcmp(buf, rbd_layered_luks2_header_verification,
-               RBD_ENCRYPTION_LUKS_HEADER_VERIFICATION_LEN) == 0) {
-        spec_info->u.rbd.data->encryption_format =
-                RBD_IMAGE_ENCRYPTION_FORMAT_LUKS2;
-        spec_info->u.rbd.data->has_encryption_format = true;
+    if (s->encryption_format == RBD_IMAGE_ENCRYPTION_FORMAT__MAX) {
+        assert(!bs->encrypted);
     } else {
-        spec_info->u.rbd.data->has_encryption_format = false;
+        ImageInfoSpecificRbd *rbd_info = spec_info->u.rbd.data;
+
+        rbd_info->has_encryption_format = true;
+        rbd_info->encryption_format = s->encryption_format;
     }
 
     return spec_info;
diff --git a/qapi/block-core.json b/qapi/block-core.json
index b1937780e1..807efd27fd 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -158,7 +158,14 @@
 ##
 # @ImageInfoSpecificRbd:
 #
-# @encryption-format: Image encryption format
+# @encryption-format: Image encryption format. If encryption is enabled for the
+#     image (see encrypted in BlockNodeInfo), this is the actual format in which the
+#     image is accessed. If encryption is not enabled, this is the result of
+#     probing when the image was opened, to give a suggestion which encryption
+#     format could be enabled. Note that probing results can be changed by the
+#     guest by writing a (possibly partial) encryption format header to the
+#     image, so don't treat this information as trusted if the guest is not
+#     trusted.
 #
 # Since: 6.1
 ##
-- 
2.47.2


