Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1197223B5
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 12:42:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q67eT-00020f-0u; Mon, 05 Jun 2023 06:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1q67eR-00020T-Tb; Mon, 05 Jun 2023 06:41:27 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1q67eP-0006oP-MM; Mon, 05 Jun 2023 06:41:27 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1b01bd7093aso22536655ad.1; 
 Mon, 05 Jun 2023 03:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685961683; x=1688553683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=goJTDxs9Xmuwyx0WBKSy9HD+21mMLbHbT04tNXq0RDo=;
 b=jDa1fy/WXmYDNv5Gf5KiDirJG5luqMfErsyspYykpzsTcEUyT0xKBL4FCogRZBDO6t
 hPfKDQqOK4pH6NMrMe1fndd3MnfDNgnBQRQ6vng6RuaQw7tT19tgIkZ08sSt4HYbLa3y
 WpEiyUhYz7+J4fzTAR/8l4ctAxjVS18mHBBXdrcO5tkc1xmQLi+7jk+VPib3QKrRLRQs
 XNB5IbAfqQZMzjg/V4E8zjmimrcHH6xzw72Vbct+ICZJBfv8zWUnQSkdxavGeFAeq/PF
 pwwHPF4HurVVYj0z+BurNFU+ykmIRUdaEbllrxlc4Zp2jjtF7ZL6JIEcfgfw8hAOmPJY
 9hUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685961683; x=1688553683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=goJTDxs9Xmuwyx0WBKSy9HD+21mMLbHbT04tNXq0RDo=;
 b=Og79puopk4FU2gQc7QJABdh9ZlQacGqfEfkTfLZybaTOR5GdizmhSpn1sGPxP+vaOJ
 q03WLs8HHg/pHV8v73emr4/xgDeWyAiUt8xDcWyLgTPGnvhOSooXqIRGe+Dki7knKsiO
 Sz/imHAM+GkZU9RpSZObAeMuZOU3BWoNGqWVUVaA46j6fw9/+JIL4Xmk0k38B7Z0oZog
 TAGvU2i4zUebbKUISmnuOA8R5/k9q64QzUNIF1xA2X8hf05vzi2uyldkFoOYLM98sabL
 HG7DxIY7x3WPYMFykNdTfSCJ0eJCDMCXg0EAkfBYznirIfFZTRA818k9Z5XDAjyRYIAx
 I6pg==
X-Gm-Message-State: AC+VfDznECrR+U3UzXWSlcbekHS5+QTuMyfMPYCfMia69+J/1stBfJtE
 ZnKfaU9DtLwtHs8ATSATbFjdK/lYJ8UhoNTS
X-Google-Smtp-Source: ACHHUZ6obgohunX4fSDI49eieJ1ibAXItmgzbl+Eokssi05F8atZFxEfLzJyloIjoP7FC9r2DwxUMw==
X-Received: by 2002:a17:902:e74a:b0:1b0:21c4:7272 with SMTP id
 p10-20020a170902e74a00b001b021c47272mr3754732plf.46.1685961683015; 
 Mon, 05 Jun 2023 03:41:23 -0700 (PDT)
Received: from fedlinux.. ([106.84.132.130]) by smtp.gmail.com with ESMTPSA id
 x4-20020a170902a38400b001b0457705e8sm6340141pla.140.2023.06.05.03.41.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 03:41:22 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: dlemoal@kernel.org, dmitry.fomichev@wdc.com, hare@suse.de,
 stefanha@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Sam Li <faithilikerun@gmail.com>
Subject: [RFC 2/4] qcow2: add configurations for zoned format extension
Date: Mon,  5 Jun 2023 18:41:06 +0800
Message-Id: <20230605104108.125270-3-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605104108.125270-1-faithilikerun@gmail.com>
References: <20230605104108.125270-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=faithilikerun@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

To configure the zoned format feature on the qcow2 driver, it
requires following arguments: the device size, zoned profile,
zoned model, zone size, zone capacity, number of conventional
zones, limits on zone resources (max append sectors, max open
zones, and max_active_zones).

To create a qcow2 file with zoned format, use command like this:
$ qemu-img create -f qcow2 test.qcow2 -o size=768M -o
zone_size=64M -o zone_capacity=64M -o zone_nr_conv=0 -o
max_append_sectors=512 -o max_open_zones=0 -o max_active_zones=0
 -o zoned_profile=zbc

Signed-off-by: Sam Li <faithilikerun@gmail.com>
---
 block/qcow2.c                    | 119 +++++++++++++++++++++++++++++++
 block/qcow2.h                    |  21 ++++++
 include/block/block-common.h     |   5 ++
 include/block/block_int-common.h |   8 +++
 qapi/block-core.json             |  46 ++++++++----
 5 files changed, 185 insertions(+), 14 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 7f3948360d..b886dab42b 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -73,6 +73,7 @@ typedef struct {
 #define  QCOW2_EXT_MAGIC_CRYPTO_HEADER 0x0537be77
 #define  QCOW2_EXT_MAGIC_BITMAPS 0x23852875
 #define  QCOW2_EXT_MAGIC_DATA_FILE 0x44415441
+#define  QCOW2_EXT_MAGIC_ZONED_FORMAT 0x7a6264
 
 static int coroutine_fn
 qcow2_co_preadv_compressed(BlockDriverState *bs,
@@ -210,6 +211,7 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
     uint64_t offset;
     int ret;
     Qcow2BitmapHeaderExt bitmaps_ext;
+    Qcow2ZonedHeaderExtension zoned_ext;
 
     if (need_update_header != NULL) {
         *need_update_header = false;
@@ -431,6 +433,37 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
             break;
         }
 
+        case QCOW2_EXT_MAGIC_ZONED_FORMAT:
+        {
+            if (ext.len != sizeof(zoned_ext)) {
+                error_setg_errno(errp, -ret, "zoned_ext: "
+                                             "Invalid extension length");
+                return -EINVAL;
+            }
+            ret = bdrv_pread(bs->file, offset, ext.len, &zoned_ext, 0);
+            if (ret < 0) {
+                error_setg_errno(errp, -ret, "zoned_ext: "
+                                             "Could not read ext header");
+                return ret;
+            }
+
+            zoned_ext.zone_size = be32_to_cpu(zoned_ext.zone_size);
+            zoned_ext.nr_zones = be32_to_cpu(zoned_ext.nr_zones);
+            zoned_ext.zone_nr_conv = be32_to_cpu(zoned_ext.zone_nr_conv);
+            zoned_ext.max_open_zones = be32_to_cpu(zoned_ext.max_open_zones);
+            zoned_ext.max_active_zones =
+                be32_to_cpu(zoned_ext.max_active_zones);
+            zoned_ext.max_append_sectors =
+                be32_to_cpu(zoned_ext.max_append_sectors);
+            s->zoned_header = zoned_ext;
+
+#ifdef DEBUG_EXT
+            printf("Qcow2: Got zoned format extension: "
+                   "offset=%" PRIu32 "\n", offset);
+#endif
+            break;
+        }
+
         default:
             /* unknown magic - save it in case we need to rewrite the header */
             /* If you add a new feature, make sure to also update the fast
@@ -3071,6 +3104,31 @@ int qcow2_update_header(BlockDriverState *bs)
         buflen -= ret;
     }
 
+    /* Zoned devices header extension */
+    if (s->zoned_header.zoned == BLK_Z_HM) {
+        Qcow2ZonedHeaderExtension zoned_header = {
+            .zoned_profile      = s->zoned_header.zoned_profile,
+            .zoned              = s->zoned_header.zoned,
+            .nr_zones           = cpu_to_be32(s->zoned_header.nr_zones),
+            .zone_size          = cpu_to_be32(s->zoned_header.zone_size),
+            .zone_capacity      = cpu_to_be32(s->zoned_header.zone_capacity),
+            .zone_nr_conv       = cpu_to_be32(s->zoned_header.zone_nr_conv),
+            .max_open_zones     = cpu_to_be32(s->zoned_header.max_open_zones),
+            .max_active_zones   =
+                cpu_to_be32(s->zoned_header.max_active_zones),
+            .max_append_sectors =
+                cpu_to_be32(s->zoned_header.max_append_sectors)
+        };
+        ret = header_ext_add(buf, QCOW2_EXT_MAGIC_ZONED_FORMAT,
+                             &zoned_header, sizeof(zoned_header),
+                             buflen);
+        if (ret < 0) {
+            goto fail;
+        }
+        buf += ret;
+        buflen -= ret;
+    }
+
     /* Keep unknown header extensions */
     QLIST_FOREACH(uext, &s->unknown_header_ext, next) {
         ret = header_ext_add(buf, uext->magic, uext->data, uext->len, buflen);
@@ -3755,6 +3813,18 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
         s->image_data_file = g_strdup(data_bs->filename);
     }
 
+    if (!strcmp(qcow2_opts->zoned_profile, "zbc")) {
+        BDRVQcow2State *s = blk_bs(blk)->opaque;
+        s->zoned_header.zoned_profile = BLK_ZP_ZBC;
+        s->zoned_header.zoned = BLK_Z_HM;
+        s->zoned_header.zone_size = qcow2_opts->zone_size;
+        s->zoned_header.zone_capacity = qcow2_opts->zone_capacity;
+        s->zoned_header.zone_nr_conv = qcow2_opts->zone_nr_conv;
+        s->zoned_header.max_open_zones = qcow2_opts->max_open_zones;
+        s->zoned_header.max_active_zones = qcow2_opts->max_active_zones;
+        s->zoned_header.max_append_sectors = qcow2_opts->max_append_sectors;
+    }
+
     /* Create a full header (including things like feature table) */
     ret = qcow2_update_header(blk_bs(blk));
     bdrv_graph_co_rdunlock();
@@ -3873,6 +3943,13 @@ qcow2_co_create_opts(BlockDriver *drv, const char *filename, QemuOpts *opts,
         qdict_put_str(qdict, BLOCK_OPT_COMPAT_LEVEL, "v3");
     }
 
+    /* The available zoned-profile options are zbc, which stands for
+     * ZBC/ZAC standards, and zns following NVMe ZNS spec. */
+    val = qdict_get_try_str(qdict, BLOCK_OPT_Z_PROFILE);
+    if (val) {
+        qdict_put_str(qdict, BLOCK_OPT_Z_PROFILE, val);
+    }
+
     /* Change legacy command line options into QMP ones */
     static const QDictRenames opt_renames[] = {
         { BLOCK_OPT_BACKING_FILE,       "backing-file" },
@@ -3885,6 +3962,13 @@ qcow2_co_create_opts(BlockDriver *drv, const char *filename, QemuOpts *opts,
         { BLOCK_OPT_COMPAT_LEVEL,       "version" },
         { BLOCK_OPT_DATA_FILE_RAW,      "data-file-raw" },
         { BLOCK_OPT_COMPRESSION_TYPE,   "compression-type" },
+        { BLOCK_OPT_Z_PROFILE,          "zoned-profile"},
+        { BLOCK_OPT_Z_NR_COV,           "zone-nr-conv"},
+        { BLOCK_OPT_Z_MOZ,              "max-open-zones"},
+        { BLOCK_OPT_Z_MAZ,              "max-active-zones"},
+        { BLOCK_OPT_Z_MAS,              "max-append-sectors"},
+        { BLOCK_OPT_Z_SIZE,             "zone-size"},
+        { BLOCK_OPT_Z_CAP,              "zone-capacity"},
         { NULL, NULL },
     };
 
@@ -6048,6 +6132,41 @@ static QemuOptsList qcow2_create_opts = {
             .help = "Compression method used for image cluster "        \
                     "compression",                                      \
             .def_value_str = "zlib"                                     \
+        },                                                              \
+            {
+            .name = BLOCK_OPT_Z_PROFILE,                                \
+            .type = QEMU_OPT_STRING,                                    \
+            .help = "zoned format option for the disk img",             \
+        },                                                              \
+            {                                                           \
+            .name = BLOCK_OPT_Z_SIZE,                                   \
+            .type = QEMU_OPT_SIZE,                                      \
+            .help = "zone size",                                        \
+        },                                                              \
+        {                                                           \
+            .name = BLOCK_OPT_Z_CAP,                                    \
+            .type = QEMU_OPT_SIZE,                                      \
+            .help = "zone capacity",                                    \
+        },                                                              \
+        {                                                               \
+                .name = BLOCK_OPT_Z_NR_COV,                             \
+                .type = QEMU_OPT_NUMBER,                                \
+                .help = "numbers of conventional zones",                \
+        },                                                              \
+        {                                                               \
+                .name = BLOCK_OPT_Z_MAS,                                \
+                .type = QEMU_OPT_NUMBER,                                \
+                .help = "max append sectors",                           \
+        },                                                              \
+        {                                                               \
+                .name = BLOCK_OPT_Z_MAZ,                                \
+                .type = QEMU_OPT_NUMBER,                                \
+                .help = "max active zones",                             \
+        },                                                              \
+        {                                                               \
+                .name = BLOCK_OPT_Z_MOZ,                                \
+                .type = QEMU_OPT_NUMBER,                                \
+                .help = "max open zones",                               \
         },
         QCOW_COMMON_OPTIONS,
         { /* end of list */ }
diff --git a/block/qcow2.h b/block/qcow2.h
index 4f67eb912a..fe18dc4d97 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -235,6 +235,20 @@ typedef struct Qcow2CryptoHeaderExtension {
     uint64_t length;
 } QEMU_PACKED Qcow2CryptoHeaderExtension;
 
+typedef struct Qcow2ZonedHeaderExtension {
+    /* Zoned device attributes */
+    BlockZonedProfile zoned_profile;
+    BlockZoneModel zoned;
+    uint32_t zone_size;
+    uint32_t zone_capacity;
+    uint32_t nr_zones;
+    uint32_t zone_nr_conv;
+    uint32_t max_active_zones;
+    uint32_t max_open_zones;
+    uint32_t max_append_sectors;
+    uint8_t padding[3];
+} QEMU_PACKED Qcow2ZonedHeaderExtension;
+
 typedef struct Qcow2UnknownHeaderExtension {
     uint32_t magic;
     uint32_t len;
@@ -419,6 +433,13 @@ typedef struct BDRVQcow2State {
      * is to convert the image with the desired compression type set.
      */
     Qcow2CompressionType compression_type;
+
+    /* States of zoned device */
+    Qcow2ZonedHeaderExtension zoned_header;
+    uint32_t nr_zones_exp_open;
+    uint32_t nr_zones_imp_open;
+    uint32_t nr_zones_closed;
+    BlockZoneWps *wps;
 } BDRVQcow2State;
 
 typedef struct Qcow2COWRegion {
diff --git a/include/block/block-common.h b/include/block/block-common.h
index e15395f2cb..9f04a772f6 100644
--- a/include/block/block-common.h
+++ b/include/block/block-common.h
@@ -108,6 +108,11 @@ typedef enum BlockZoneType {
     BLK_ZT_SWP = 0x3, /* Sequential writes preferred */
 } BlockZoneType;
 
+typedef enum BlockZonedProfile {
+    BLK_ZP_ZBC = 0x1,
+    BLK_ZP_ZNS = 0x2,
+} BlockZonedProfile;
+
 /*
  * Zone descriptor data structure.
  * Provides information on a zone with all position and size values in bytes.
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 74195c3004..4be35feaf8 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -57,6 +57,14 @@
 #define BLOCK_OPT_DATA_FILE_RAW     "data_file_raw"
 #define BLOCK_OPT_COMPRESSION_TYPE  "compression_type"
 #define BLOCK_OPT_EXTL2             "extended_l2"
+#define BLOCK_OPT_Z_PROFILE         "zoned_profile"
+#define BLOCK_OPT_Z_MODEL           "zoned"
+#define BLOCK_OPT_Z_SIZE            "zone_size"
+#define BLOCK_OPT_Z_CAP             "zone_capacity"
+#define BLOCK_OPT_Z_NR_COV          "zone_nr_conv"
+#define BLOCK_OPT_Z_MAS             "max_append_sectors"
+#define BLOCK_OPT_Z_MAZ             "max_active_zones"
+#define BLOCK_OPT_Z_MOZ             "max_open_zones"
 
 #define BLOCK_PROBE_BUF_SIZE        512
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 4bf89171c6..f9a584cbb3 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -5013,24 +5013,42 @@
 #
 # @compression-type: The image cluster compression method
 #     (default: zlib, since 5.1)
+# @zoned-profile: Two zoned device protocol options, zbc or zns
+#                 (default: off, since 8.0)
+# @zone-size: The size of a zone of the zoned device (since 8.0)
+# @zone-capacity: The capacity of a zone of the zoned device (since 8.0)
+# @zone-nr-conv: The number of conventional zones of the zoned device
+#                (since 8.0)
+# @max-open-zones: The maximal allowed open zones (since 8.0)
+# @max-active-zones: The limit of the zones that have the implicit open,
+#                    explicit open or closed state (since 8.0)
+# @max-append-sectors: The maximal sectors that is allowed to append write
+#                      (since 8.0)
 #
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
+  'data': { 'file':                'BlockdevRef',
+            '*data-file':          'BlockdevRef',
+            '*data-file-raw':      'bool',
+            '*extended-l2':        'bool',
+            'size':                'size',
+            '*version':            'BlockdevQcow2Version',
+            '*backing-file':       'str',
+            '*backing-fmt':        'BlockdevDriver',
+            '*encrypt':            'QCryptoBlockCreateOptions',
+            '*cluster-size':       'size',
+            '*preallocation':      'PreallocMode',
+            '*lazy-refcounts':     'bool',
+            '*refcount-bits':      'int',
+            '*compression-type':   'Qcow2CompressionType',
+            '*zoned-profile':      'str',
+            '*zone-size':          'size',
+            '*zone-capacity':      'size',
+            '*zone-nr-conv':       'uint32',
+            '*max-open-zones':     'uint32',
+            '*max-active-zones':   'uint32',
+            '*max-append-sectors': 'uint32'}}
 
 ##
 # @BlockdevCreateOptionsQed:
-- 
2.40.1


