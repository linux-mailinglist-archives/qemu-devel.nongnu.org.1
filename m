Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0487B80B689
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Dec 2023 22:29:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rC4sC-0001jj-JM; Sat, 09 Dec 2023 16:28:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoyifan@sjtu.edu.cn>)
 id 1rC2LW-0004Xi-CB; Sat, 09 Dec 2023 13:46:38 -0500
Received: from smtp232.sjtu.edu.cn ([202.120.2.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoyifan@sjtu.edu.cn>)
 id 1rC2LS-0008T9-9Q; Sat, 09 Dec 2023 13:46:38 -0500
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id ACD821008CBD7;
 Sun, 10 Dec 2023 02:39:35 +0800 (CST)
Received: from zhaoyf.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 5F80937C957;
 Sun, 10 Dec 2023 02:39:29 +0800 (CST)
From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	hreitz@redhat.com,
	Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Subject: [RFC PATCH] qemu-img: convert: introduce compression_level option
Date: Sun, 10 Dec 2023 02:39:21 +0800
Message-ID: <20231209183921.467071-1-zhaoyifan@sjtu.edu.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.120.2.232; envelope-from=zhaoyifan@sjtu.edu.cn;
 helo=smtp232.sjtu.edu.cn
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_BL=0.001,
 RCVD_IN_MSPIKE_L4=0.001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 09 Dec 2023 16:28:30 -0500
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

This patch introduces a new parameter to customize the compression level
in qemu-img convert.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1959
Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
---
This patch adds a new compression_level option to qemu-img: convert,
allowing the user to specify the compression level to use.
It resolves an existing issue referenced in the commit message.

However, as a newbie to qemu, I'm not quite sure how to pass this new option
from qcow2_co_create to the compression function qcow2_co_do_compress.
Currently, the compression_level is written directly into the header of the
qcow2 file, which I don't think is appropriate.

I would appreciate getting more suggestions on how to implement this better.

 block/qcow2-threads.c            | 80 ++++++++++++++++++++++++++------
 block/qcow2.c                    | 22 ++++++++-
 block/qcow2.h                    |  8 +++-
 include/block/block_int-common.h |  1 +
 qapi/block-core.json             | 29 ++++++------
 5 files changed, 108 insertions(+), 32 deletions(-)

diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
index d6071a1eae..bc375384a9 100644
--- a/block/qcow2-threads.c
+++ b/block/qcow2-threads.c
@@ -67,7 +67,27 @@ qcow2_co_process(BlockDriverState *bs, ThreadPoolFunc *func, void *arg)
  */
 
 typedef ssize_t (*Qcow2CompressFunc)(void *dest, size_t dest_size,
+                                     const void *src, size_t src_size,
+                                     int compression_level);
+typedef ssize_t (*Qcow2DecompressFunc)(void *dest, size_t dest_size,
                                      const void *src, size_t src_size);
+
+enum Qcow2CompressFuncType {
+    QCOW2_COMPRESS_FUNC,
+    QCOW2_DECOMPRESS_FUNC,
+};
+
+typedef struct Qcow2CompressFuncUnion {
+    enum Qcow2CompressFuncType type;
+    union {
+        struct {
+            Qcow2CompressFunc f;
+            int compression_level;
+        } cfunc;
+        Qcow2DecompressFunc dfunc;
+    } u;
+} Qcow2CompressFuncUnion;
+
 typedef struct Qcow2CompressData {
     void *dest;
     size_t dest_size;
@@ -75,7 +95,7 @@ typedef struct Qcow2CompressData {
     size_t src_size;
     ssize_t ret;
 
-    Qcow2CompressFunc func;
+    Qcow2CompressFuncUnion func;
 } Qcow2CompressData;
 
 /*
@@ -85,20 +105,26 @@ typedef struct Qcow2CompressData {
  *
  * @dest - destination buffer, @dest_size bytes
  * @src - source buffer, @src_size bytes
+ * @level - compression level
  *
  * Returns: compressed size on success
  *          -ENOMEM destination buffer is not enough to store compressed data
  *          -EIO    on any other error
  */
 static ssize_t qcow2_zlib_compress(void *dest, size_t dest_size,
-                                   const void *src, size_t src_size)
+                                   const void *src, size_t src_size, int level)
 {
     ssize_t ret;
     z_stream strm;
 
+    if (level == DEFAULT_COMPRESSION_LEVEL || 
+        level < Z_BEST_SPEED || level > Z_BEST_COMPRESSION) {
+        level = Z_DEFAULT_COMPRESSION;
+    }
+
     /* best compression, small window, no zlib header */
     memset(&strm, 0, sizeof(strm));
-    ret = deflateInit2(&strm, Z_DEFAULT_COMPRESSION, Z_DEFLATED,
+    ret = deflateInit2(&strm, level, Z_DEFLATED,
                        -12, 9, Z_DEFAULT_STRATEGY);
     if (ret != Z_OK) {
         return -EIO;
@@ -180,13 +206,14 @@ static ssize_t qcow2_zlib_decompress(void *dest, size_t dest_size,
  *
  * @dest - destination buffer, @dest_size bytes
  * @src - source buffer, @src_size bytes
+ * @level - compression level
  *
  * Returns: compressed size on success
  *          -ENOMEM destination buffer is not enough to store compressed data
  *          -EIO    on any other error
  */
 static ssize_t qcow2_zstd_compress(void *dest, size_t dest_size,
-                                   const void *src, size_t src_size)
+                                   const void *src, size_t src_size, int level)
 {
     ssize_t ret;
     size_t zstd_ret;
@@ -200,11 +227,22 @@ static ssize_t qcow2_zstd_compress(void *dest, size_t dest_size,
         .size = src_size,
         .pos = 0
     };
-    ZSTD_CCtx *cctx = ZSTD_createCCtx();
+    ZSTD_CCtx *cctx;
 
+    if (level == DEFAULT_COMPRESSION_LEVEL ||
+        level < ZSTD_minCLevel() || level > ZSTD_maxCLevel()) {
+        level = ZSTD_CLEVEL_DEFAULT;
+    }
+
+    cctx = ZSTD_createCCtx();
     if (!cctx) {
         return -EIO;
     }
+
+    zstd_ret = ZSTD_CCtx_setParameter(cctx, ZSTD_c_compressionLevel, level);
+    if (ZSTD_isError(zstd_ret)) {
+        return -EIO;
+    }
     /*
      * Use the zstd streamed interface for symmetry with decompression,
      * where streaming is essential since we don't record the exact
@@ -329,15 +367,22 @@ static int qcow2_compress_pool_func(void *opaque)
 {
     Qcow2CompressData *data = opaque;
 
-    data->ret = data->func(data->dest, data->dest_size,
-                           data->src, data->src_size);
+    if (data->func.type == QCOW2_COMPRESS_FUNC) {
+        data->ret = data->func.u.cfunc.f(data->dest, data->dest_size,
+                                         data->src, data->src_size,
+                                         data->func.u.cfunc.compression_level);
+    } else {
+        data->ret = data->func.u.dfunc(data->dest, data->dest_size,
+                                       data->src, data->src_size);
+    }
 
     return 0;
 }
 
 static ssize_t coroutine_fn
 qcow2_co_do_compress(BlockDriverState *bs, void *dest, size_t dest_size,
-                     const void *src, size_t src_size, Qcow2CompressFunc func)
+                     const void *src, size_t src_size,
+                     Qcow2CompressFuncUnion func)
 {
     Qcow2CompressData arg = {
         .dest = dest,
@@ -366,19 +411,22 @@ qcow2_co_do_compress(BlockDriverState *bs, void *dest, size_t dest_size,
  */
 ssize_t coroutine_fn
 qcow2_co_compress(BlockDriverState *bs, void *dest, size_t dest_size,
-                  const void *src, size_t src_size)
+                  const void *src, size_t src_size, int compression_level)
 {
     BDRVQcow2State *s = bs->opaque;
-    Qcow2CompressFunc fn;
+    Qcow2CompressFuncUnion fn;
+
+    fn.type = QCOW2_COMPRESS_FUNC;
+    fn.u.cfunc.compression_level = compression_level;
 
     switch (s->compression_type) {
     case QCOW2_COMPRESSION_TYPE_ZLIB:
-        fn = qcow2_zlib_compress;
+        fn.u.cfunc.f = qcow2_zlib_compress;
         break;
 
 #ifdef CONFIG_ZSTD
     case QCOW2_COMPRESSION_TYPE_ZSTD:
-        fn = qcow2_zstd_compress;
+        fn.u.cfunc.f = qcow2_zstd_compress;
         break;
 #endif
     default:
@@ -406,16 +454,18 @@ qcow2_co_decompress(BlockDriverState *bs, void *dest, size_t dest_size,
                     const void *src, size_t src_size)
 {
     BDRVQcow2State *s = bs->opaque;
-    Qcow2CompressFunc fn;
+    Qcow2CompressFuncUnion fn;
+
+    fn.type = QCOW2_DECOMPRESS_FUNC;
 
     switch (s->compression_type) {
     case QCOW2_COMPRESSION_TYPE_ZLIB:
-        fn = qcow2_zlib_decompress;
+        fn.u.dfunc = qcow2_zlib_decompress;
         break;
 
 #ifdef CONFIG_ZSTD
     case QCOW2_COMPRESSION_TYPE_ZSTD:
-        fn = qcow2_zstd_decompress;
+        fn.u.dfunc = qcow2_zstd_decompress;
         break;
 #endif
     default:
diff --git a/block/qcow2.c b/block/qcow2.c
index 13e032bd5e..e8d6b84d7f 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1448,6 +1448,12 @@ qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     }
 
+    if (header.header_length > offsetof(QCowHeader, compression_level)) {
+        s->compression_level = header.compression_level;
+    } else {
+        s->compression_level = DEFAULT_COMPRESSION_LEVEL;
+    }
+
     if (s->incompatible_features & ~QCOW2_INCOMPAT_MASK) {
         void *feature_table = NULL;
         qcow2_read_extensions(bs, header.header_length, ext_end,
@@ -2958,6 +2964,7 @@ int qcow2_update_header(BlockDriverState *bs)
         .refcount_order         = cpu_to_be32(s->refcount_order),
         .header_length          = cpu_to_be32(header_length),
         .compression_type       = s->compression_type,
+        .compression_level      = s->compression_level,
     };
 
     /* For older versions, write a shorter header */
@@ -3508,6 +3515,7 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
     uint64_t *refcount_table;
     int ret;
     uint8_t compression_type = QCOW2_COMPRESSION_TYPE_ZLIB;
+    uint8_t compression_level = DEFAULT_COMPRESSION_LEVEL;
 
     assert(create_options->driver == BLOCKDEV_DRIVER_QCOW2);
     qcow2_opts = &create_options->u.qcow2;
@@ -3686,6 +3694,10 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
         compression_type = qcow2_opts->compression_type;
     }
 
+    if (qcow2_opts->has_compression_level) {
+        compression_level = qcow2_opts->compression_level;
+    }
+
     /* Create BlockBackend to write to the image */
     blk = blk_co_new_with_bs(bs, BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL,
                              errp);
@@ -3710,6 +3722,7 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
         .refcount_order             = cpu_to_be32(refcount_order),
         /* don't deal with endianness since compression_type is 1 byte long */
         .compression_type           = compression_type,
+        .compression_level          = compression_level,
         .header_length              = cpu_to_be32(sizeof(*header)),
     };
 
@@ -3930,6 +3943,7 @@ qcow2_co_create_opts(BlockDriver *drv, const char *filename, QemuOpts *opts,
         { BLOCK_OPT_COMPAT_LEVEL,       "version" },
         { BLOCK_OPT_DATA_FILE_RAW,      "data-file-raw" },
         { BLOCK_OPT_COMPRESSION_TYPE,   "compression-type" },
+        { BLOCK_OPT_COMPRESSION_LEVEL,  "compression-level"},
         { NULL, NULL },
     };
 
@@ -4679,7 +4693,7 @@ qcow2_co_pwritev_compressed_task(BlockDriverState *bs,
     out_buf = g_malloc(s->cluster_size);
 
     out_len = qcow2_co_compress(bs, out_buf, s->cluster_size - 1,
-                                buf, s->cluster_size);
+                                buf, s->cluster_size, s->compression_level);
     if (out_len == -ENOMEM) {
         /* could not compress: write normal cluster */
         ret = qcow2_co_pwritev_part(bs, offset, bytes, qiov, qiov_offset, 0);
@@ -6098,6 +6112,12 @@ static QemuOptsList qcow2_create_opts = {
                     "compression",                                      \
             .def_value_str = "zlib"                                     \
         },
+        {
+            .name = BLOCK_OPT_COMPRESSION_LEVEL,
+            .type = QEMU_OPT_NUMBER,
+            .help = "Compression level used for image cluster "
+                    "compression"
+        },
         QCOW_COMMON_OPTIONS,
         { /* end of list */ }
     }
diff --git a/block/qcow2.h b/block/qcow2.h
index a9e3481c6e..771f95cd9c 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -128,6 +128,8 @@
 
 #define DEFAULT_CLUSTER_SIZE 65536
 
+#define DEFAULT_COMPRESSION_LEVEL INT8_MAX
+
 #define QCOW2_OPT_DATA_FILE "data-file"
 #define QCOW2_OPT_LAZY_REFCOUNTS "lazy-refcounts"
 #define QCOW2_OPT_DISCARD_REQUEST "pass-discard-request"
@@ -176,9 +178,10 @@ typedef struct QCowHeader {
 
     /* Additional fields */
     uint8_t compression_type;
+    uint8_t compression_level;
 
     /* header must be a multiple of 8 */
-    uint8_t padding[7];
+    uint8_t padding[6];
 } QEMU_PACKED QCowHeader;
 
 QEMU_BUILD_BUG_ON(!QEMU_IS_ALIGNED(sizeof(QCowHeader), 8));
@@ -422,6 +425,7 @@ typedef struct BDRVQcow2State {
      * is to convert the image with the desired compression type set.
      */
     Qcow2CompressionType compression_type;
+    int compression_level;
 } BDRVQcow2State;
 
 typedef struct Qcow2COWRegion {
@@ -1060,7 +1064,7 @@ uint64_t qcow2_get_persistent_dirty_bitmap_size(BlockDriverState *bs,
 
 ssize_t coroutine_fn
 qcow2_co_compress(BlockDriverState *bs, void *dest, size_t dest_size,
-                  const void *src, size_t src_size);
+                  const void *src, size_t src_size, int compression_level);
 ssize_t coroutine_fn
 qcow2_co_decompress(BlockDriverState *bs, void *dest, size_t dest_size,
                     const void *src, size_t src_size);
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 4e31d161c5..bf947b8cba 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -56,6 +56,7 @@
 #define BLOCK_OPT_DATA_FILE         "data_file"
 #define BLOCK_OPT_DATA_FILE_RAW     "data_file_raw"
 #define BLOCK_OPT_COMPRESSION_TYPE  "compression_type"
+#define BLOCK_OPT_COMPRESSION_LEVEL "compression_level"
 #define BLOCK_OPT_EXTL2             "extended_l2"
 
 #define BLOCK_PROBE_BUF_SIZE        512
diff --git a/qapi/block-core.json b/qapi/block-core.json
index ca390c5700..1957ab6d92 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -5083,20 +5083,21 @@
 # Since: 2.12
 ##
 { 'struct': 'BlockdevCreateOptionsQcow2',
-  'data': { 'file':             'BlockdevRef',
-            '*data-file':       'BlockdevRef',
-            '*data-file-raw':   'bool',
-            '*extended-l2':     'bool',
-            'size':             'size',
-            '*version':         'BlockdevQcow2Version',
-            '*backing-file':    'str',
-            '*backing-fmt':     'BlockdevDriver',
-            '*encrypt':         'QCryptoBlockCreateOptions',
-            '*cluster-size':    'size',
-            '*preallocation':   'PreallocMode',
-            '*lazy-refcounts':  'bool',
-            '*refcount-bits':   'int',
-            '*compression-type':'Qcow2CompressionType' } }
+  'data': { 'file':              'BlockdevRef',
+            '*data-file':        'BlockdevRef',
+            '*data-file-raw':    'bool',
+            '*extended-l2':      'bool',
+            'size':              'size',
+            '*version':          'BlockdevQcow2Version',
+            '*backing-file':     'str',
+            '*backing-fmt':      'BlockdevDriver',
+            '*encrypt':          'QCryptoBlockCreateOptions',
+            '*cluster-size':     'size',
+            '*preallocation':    'PreallocMode',
+            '*lazy-refcounts':   'bool',
+            '*refcount-bits':    'int',
+            '*compression-type': 'Qcow2CompressionType',
+            '*compression-level':'int' } }
 
 ##
 # @BlockdevCreateOptionsQed:
-- 
2.43.0


