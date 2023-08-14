Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D36E77B4EC
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 10:59:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVTPM-0001sv-7z; Mon, 14 Aug 2023 04:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qVTPK-0001si-5V; Mon, 14 Aug 2023 04:58:38 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qVTPH-0007BW-61; Mon, 14 Aug 2023 04:58:37 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68730bafa6bso3404968b3a.1; 
 Mon, 14 Aug 2023 01:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692003513; x=1692608313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7SHw78VTolU7FuXMEG0SFCxx4sItHo6ExGcM5qJSCn8=;
 b=WYcu5/GCLwW+tScyXashm3nxPNYVtOmZWgg4mRXEyeu7utwxWVWNVQorcUfRk4Vylg
 cAdo3tsqMv63YuHFwRSvXN61gfYyBr6kXTTqErBjnewV6a/sHlSBJsW4aITwezmEljgP
 Wj2MJCXePHAEEYzY3vp2T4UgrBX94Jf5ewmTBFsJYHEoeOUCbXEUEarT6rT6Vhm0tCtE
 hsqx9ydyeb192x33Ye92lskpB7z+f+t2kyxOeE4Apg1pgdvSVmfNc4xxF9dnhX8jTUdJ
 hkIDxeGIklJdOLWZ5B9W+DBJ4FGa22A+cA33usGxYIy/J2TlYedc1OiADB1ArW4eUVeQ
 yj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692003513; x=1692608313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7SHw78VTolU7FuXMEG0SFCxx4sItHo6ExGcM5qJSCn8=;
 b=TmmWdv0ncRCvvJ3/2FIpipR/m1Qh8PExGwfvMzA/7fAFKGfKinjAPd0wP40yPU+8+e
 YDxBVhBDRznzpKiVeFbPJWjqtyQa6y6QEg1EFv9A7porh8AqRG+jdLRLhADzgYBOvgvy
 imfOJ3Fy02F6sv+tiYkxKYEncXEUTuV0Xzm9BFWH7CIxGTIw/O8jyn3G0JiaHosuD50G
 UtRaAvmT6xN6Kc1G/yZMDzjcMYs3HMjCfCv2RcJ9y6J+254yyjy2NI90L7KZgUvZfkqQ
 Uc/4xAqTVCtVogIQughAUCx+Az39BWUWKQekESm8wAuDfY2UU2YSY1QFhRFz0aQBz3qJ
 BKsw==
X-Gm-Message-State: AOJu0Ywm/HIkzDI4xa0Zt1KRGYB0dxrcqysPP72uVEoyhvpQlC2YuHQG
 KIxVB5TbFLORMMzXrgwaOYZ+/rxO42UGHnJ0pAc=
X-Google-Smtp-Source: AGHT+IHhiP7OEyqCtYwNT05POP4VX21G5rUJ/noXLebZ/zB1PkWglhT5ak3cmOmTvimEjOsVll9SzA==
X-Received: by 2002:a05:6a00:1393:b0:67a:52a7:b278 with SMTP id
 t19-20020a056a00139300b0067a52a7b278mr11566761pfg.9.1692003512654; 
 Mon, 14 Aug 2023 01:58:32 -0700 (PDT)
Received: from fedlinux.. ([106.84.134.250]) by smtp.gmail.com with ESMTPSA id
 bt24-20020a632918000000b00528db73ed70sm8238890pgb.3.2023.08.14.01.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 01:58:32 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: hare@suse.de, Hanna Reitz <hreitz@redhat.com>, dmitry.fomichev@wdc.com,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 stefanha@redhat.com, dlemoal@kernel.org, Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v2 2/4] qcow2: add configurations for zoned format extension
Date: Mon, 14 Aug 2023 16:58:00 +0800
Message-Id: <20230814085802.61459-3-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230814085802.61459-1-faithilikerun@gmail.com>
References: <20230814085802.61459-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=faithilikerun@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
zones, and max_active_zones). The zoned profile option is set
to zns when using the qcow2 file as a ZNS drive.

To create a qcow2 file with zoned format, use command like this:
$ qemu-img create -f qcow2 test.qcow2 -o size=768M -o
zone_size=64M -o zone_capacity=64M -o zone_nr_conv=0 -o
max_append_sectors=512 -o max_open_zones=0 -o max_active_zones=0
 -o zoned_profile=zbc/zns

Signed-off-by: Sam Li <faithilikerun@gmail.com>
---
 block/qcow2.c                    | 125 +++++++++++++++++++++++++++++++
 block/qcow2.h                    |  21 ++++++
 docs/interop/qcow2.txt           |  24 ++++++
 include/block/block-common.h     |   5 ++
 include/block/block_int-common.h |  16 ++++
 qapi/block-core.json             |  46 ++++++++----
 6 files changed, 223 insertions(+), 14 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index c51388e99d..c1077c4a4a 100644
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
@@ -431,6 +433,38 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
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
+            zoned_ext.zone_capacity = be32_to_cpu(zoned_ext.zone_capacity);
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
@@ -3089,6 +3123,31 @@ int qcow2_update_header(BlockDriverState *bs)
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
@@ -3773,6 +3832,23 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
         s->image_data_file = g_strdup(data_bs->filename);
     }
 
+    if (qcow2_opts->zoned_profile) {
+        BDRVQcow2State *s = blk_bs(blk)->opaque;
+        if (!strcmp(qcow2_opts->zoned_profile, "zbc")) {
+            s->zoned_header.zoned_profile = BLK_ZP_ZBC;
+            s->zoned_header.zone_capacity = qcow2_opts->zone_size;
+        } else if (!strcmp(qcow2_opts->zoned_profile, "zns")) {
+            s->zoned_header.zoned_profile = BLK_ZP_ZNS;
+            s->zoned_header.zone_capacity = qcow2_opts->zone_capacity;
+        }
+        s->zoned_header.zoned = BLK_Z_HM;
+        s->zoned_header.zone_size = qcow2_opts->zone_size;
+        s->zoned_header.zone_nr_conv = qcow2_opts->zone_nr_conv;
+        s->zoned_header.max_open_zones = qcow2_opts->max_open_zones;
+        s->zoned_header.max_active_zones = qcow2_opts->max_active_zones;
+        s->zoned_header.max_append_sectors = qcow2_opts->max_append_sectors;
+    }
+
     /* Create a full header (including things like feature table) */
     ret = qcow2_update_header(blk_bs(blk));
     bdrv_graph_co_rdunlock();
@@ -3891,6 +3967,13 @@ qcow2_co_create_opts(BlockDriver *drv, const char *filename, QemuOpts *opts,
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
@@ -3903,6 +3986,13 @@ qcow2_co_create_opts(BlockDriver *drv, const char *filename, QemuOpts *opts,
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
 
@@ -6066,6 +6156,41 @@ static QemuOptsList qcow2_create_opts = {
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
index f789ce3ae0..3694c8d217 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -236,6 +236,20 @@ typedef struct Qcow2CryptoHeaderExtension {
     uint64_t length;
 } QEMU_PACKED Qcow2CryptoHeaderExtension;
 
+typedef struct Qcow2ZonedHeaderExtension {
+    /* Zoned device attributes */
+    uint8_t zoned_profile;
+    uint8_t zoned;
+    uint16_t reserved16;
+    uint32_t zone_size;
+    uint32_t zone_capacity;
+    uint32_t nr_zones;
+    uint32_t zone_nr_conv;
+    uint32_t max_active_zones;
+    uint32_t max_open_zones;
+    uint32_t max_append_sectors;
+} QEMU_PACKED Qcow2ZonedHeaderExtension;
+
 typedef struct Qcow2UnknownHeaderExtension {
     uint32_t magic;
     uint32_t len;
@@ -422,6 +436,13 @@ typedef struct BDRVQcow2State {
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
diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index 2c4618375a..ef2ba6f670 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -331,6 +331,30 @@ The fields of the bitmaps extension are:
                    Offset into the image file at which the bitmap directory
                    starts. Must be aligned to a cluster boundary.
 
+== Zoned extension ==
+
+The zoned extension is an optional header extension. It is required when
+using the qcow2 file as the backing image for zoned device.
+
+The fields of the zoned extension are:
+    Byte  0:  zoned_profile
+              Type of zoned format. Must be `zbc` or `zns`.
+                  1: `zbc`
+                  2: `zns`
+
+          1:  zoned
+              Type of zone.
+
+          2 - 3:  Reserved, must be zero.
+
+          4 - 7:  zone_size
+          8 - 11:  zone_capacity
+          12 - 15:  nr_zones
+          16 - 19:  zone_nr_conv
+          20 - 23:  max_active_zones
+          24 - 27:  max_open_zones
+          28 - 31:  max_append_sectors
+
 == Full disk encryption header pointer ==
 
 The full disk encryption header must be present if, and only if, the
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
index 74195c3004..1dbe820a9b 100644
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
 
@@ -872,12 +880,20 @@ typedef struct BlockLimits {
      */
     bool has_variable_length;
 
+    BlockZonedProfile zoned_profile;
+
     /* device zone model */
     BlockZoneModel zoned;
 
     /* zone size expressed in bytes */
     uint32_t zone_size;
 
+    /*
+     * the number of usable logical blocks within the zone, expressed
+     * in bytes. A zone capacity is smaller or equal to the zone size.
+     */
+    uint32_t zone_capacity;
+
     /* total number of zones */
     uint32_t nr_zones;
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 2b1d493d6e..0c97ae678b 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -5020,24 +5020,42 @@
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


