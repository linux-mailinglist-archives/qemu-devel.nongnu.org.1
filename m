Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5FB78B417
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 17:11:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qadsx-0007Ri-7d; Mon, 28 Aug 2023 11:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qadsu-0007R6-EQ; Mon, 28 Aug 2023 11:10:32 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qadsr-000410-4x; Mon, 28 Aug 2023 11:10:32 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bdbf10333bso25928345ad.1; 
 Mon, 28 Aug 2023 08:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693235427; x=1693840227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Jh3mJ+FUx5QLylxleqiZjBv1NH3849HgHmksBcxQTY=;
 b=XzQhy1IlzmOQ24Rtufc1iHfDCktrxxNZdSdwh30E3CKGGq6iuMtxopf0wrsoLL8gyu
 mQLBjhs/i3GIIoPRdQzW8NTolrxWosCQibh/V7+beJm0ZRdPg03dREMfbYkUNE2M8Qsm
 hKOcG1bFp9aH4xuSRbMZHj5cCoQYIczK8uTQAkLkyBed892nmAml+qWfSbBSAVDAfgWH
 fSkYUToNH+1cHP4FZP4fiYChYSlsv4YlsC+8KiSXiGA2Ed9NSBVkbvGLpwfXg484o26N
 dnlvJ3f+7BEy/ck3lD/9DM89a0nXGnaJgXt9k0p608xnCIEJTfkMf7I+rpBVNstwC3VK
 fftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693235427; x=1693840227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Jh3mJ+FUx5QLylxleqiZjBv1NH3849HgHmksBcxQTY=;
 b=iBF6hQilY3NGKub6h2QE2qu5tldZXaVCFtcM7YsX8QCJ1BySBsxv7LJHSan9EekoR5
 tJ+f9kMuTZC+lhuu9gBLXBLdtEldLOlI1rSH/m2M1f7GMo6GeHZVrLCVq8TdD0b+U528
 jV6bV2Nvdbvxov3RaU/SD077XX3356KVaRUbVZ2i+7VB3PWHLBg5bPtGlobq4udXTVkS
 KdUS9aYsip5RgN5q45wLf7DJ/6Tg9Qhi609enlZDjArYBeijVVnaE5F0pmTxhgO19XGt
 r5bOggnjiac/7HAV6jKarTm6QMiOyVeui6LnjU3RWQErftA2EloKLf7aHyCPlYLprcUq
 A7Yw==
X-Gm-Message-State: AOJu0Yz8yH4kCILOgrNcvbJ/FwfxEdCU4HQ7StBn3tFFTQdjefgUaKYA
 EQsGZjYM3j1Y3Znjp5V31KeRNcye7LURVETf5Vg=
X-Google-Smtp-Source: AGHT+IGBzFAbHjvuUCW8YeyFm1xogKkzr+knEDtsOsYzlYYy3dgYZvQXpatYqjg+rY6aw+udTww5PQ==
X-Received: by 2002:a17:903:48a:b0:1c1:e71c:6d00 with SMTP id
 jj10-20020a170903048a00b001c1e71c6d00mr2834227plb.17.1693235426485; 
 Mon, 28 Aug 2023 08:10:26 -0700 (PDT)
Received: from fedlinux.. ([106.84.130.225]) by smtp.gmail.com with ESMTPSA id
 i19-20020a170902eb5300b001b8b26fa6c1sm7427456pli.115.2023.08.28.08.10.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 08:10:25 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, dmitry.fomichev@wdc.com,
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, hare@suse.de, qemu-block@nongnu.org,
 stefanha@redhat.com, dlemoal@kernel.org, Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v3 2/4] qcow2: add configurations for zoned format extension
Date: Mon, 28 Aug 2023 23:09:53 +0800
Message-Id: <20230828150955.3481-3-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230828150955.3481-1-faithilikerun@gmail.com>
References: <20230828150955.3481-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=faithilikerun@gmail.com; helo=mail-pl1-x62f.google.com
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
zone model, zone size, zone capacity, number of conventional
zones, limits on zone resources (max append sectors, max open
zones, and max_active_zones).

To create a qcow2 file with zoned format, use command like this:
$ qemu-img create -f qcow2 test.qcow2 -o size=768M -o
zone_size=64M -o zone_capacity=64M -o nr_conv_zones=0 -o
max_append_sectors=512 -o max_open_zones=0 -o max_active_zones=0
-o zone_model=1

Signed-off-by: Sam Li <faithilikerun@gmail.com>
---
 block/qcow2.c                    | 176 ++++++++++++++++++++++++++++++-
 block/qcow2.h                    |  20 ++++
 docs/interop/qcow2.txt           |  36 +++++++
 include/block/block_int-common.h |  13 +++
 qapi/block-core.json             |  30 +++++-
 5 files changed, 273 insertions(+), 2 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index c51388e99d..7074bfc620 100644
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
@@ -431,6 +433,55 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
             break;
         }
 
+        case QCOW2_EXT_MAGIC_ZONED_FORMAT:
+        {
+            if (ext.len != sizeof(zoned_ext)) {
+                error_setg(errp, "zoned_ext: Invalid extension length");
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
+            zoned_ext.nr_conv_zones = be32_to_cpu(zoned_ext.nr_conv_zones);
+            zoned_ext.nr_zones = be32_to_cpu(zoned_ext.nr_zones);
+            zoned_ext.max_open_zones = be32_to_cpu(zoned_ext.max_open_zones);
+            zoned_ext.max_active_zones =
+                be32_to_cpu(zoned_ext.max_active_zones);
+            zoned_ext.max_append_sectors =
+                be32_to_cpu(zoned_ext.max_append_sectors);
+            s->zoned_header = zoned_ext;
+
+            /* refuse to open broken images */
+            if (zoned_ext.zone_size == 0) {
+                error_setg(errp, "Zoned extension header zone_size field "
+                                 "can not be 0");
+                return -EINVAL;
+            }
+            if (zoned_ext.zone_capacity > zoned_ext.zone_size) {
+                error_setg(errp, "Zoned extension header zone_capacity field "
+                                 "can not be larger that zone_size field");
+                return -EINVAL;
+            }
+            if (zoned_ext.nr_zones != DIV_ROUND_UP(
+                bs->total_sectors * BDRV_SECTOR_SIZE, zoned_ext.zone_size)) {
+                error_setg(errp, "Zoned extension header nr_zones field "
+                                 "gets wrong");
+                return -EINVAL;
+            }
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
@@ -1967,6 +2018,14 @@ static void qcow2_refresh_limits(BlockDriverState *bs, Error **errp)
     }
     bs->bl.pwrite_zeroes_alignment = s->subcluster_size;
     bs->bl.pdiscard_alignment = s->cluster_size;
+    bs->bl.zoned = s->zoned_header.zoned;
+    bs->bl.nr_zones = s->zoned_header.nr_zones;
+    bs->wps = s->wps;
+    bs->bl.max_append_sectors = s->zoned_header.max_append_sectors;
+    bs->bl.max_active_zones = s->zoned_header.max_active_zones;
+    bs->bl.max_open_zones = s->zoned_header.max_open_zones;
+    bs->bl.zone_size = s->zoned_header.zone_size;
+    bs->bl.write_granularity = BDRV_SECTOR_SIZE;
 }
 
 static int qcow2_reopen_prepare(BDRVReopenState *state,
@@ -3089,6 +3148,30 @@ int qcow2_update_header(BlockDriverState *bs)
         buflen -= ret;
     }
 
+    /* Zoned devices header extension */
+    if (s->zoned_header.zoned == BLK_Z_HM) {
+        Qcow2ZonedHeaderExtension zoned_header = {
+            .zoned              = s->zoned_header.zoned,
+            .zone_size          = cpu_to_be32(s->zoned_header.zone_size),
+            .zone_capacity      = cpu_to_be32(s->zoned_header.zone_capacity),
+            .nr_conv_zones      = cpu_to_be32(s->zoned_header.nr_conv_zones),
+            .nr_zones           = cpu_to_be32(s->zoned_header.nr_zones),
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
@@ -3768,11 +3851,60 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
     }
 
     /* Set the external data file if necessary */
+    BDRVQcow2State *s = blk_bs(blk)->opaque;
     if (data_bs) {
-        BDRVQcow2State *s = blk_bs(blk)->opaque;
         s->image_data_file = g_strdup(data_bs->filename);
     }
 
+    if (qcow2_opts->has_zone_model && qcow2_opts->zone_model == BLK_Z_HM) {
+        if (qcow2_opts->has_zone_size && qcow2_opts->zone_size == 0) {
+            s->zoned_header.zoned = BLK_Z_NONE;
+            error_setg(errp, "Zoned devices can not allow a larger-than-zero "
+                             "zone_size");
+            goto out;
+        }
+        s->zoned_header.zoned = qcow2_opts->zone_model;
+        s->zoned_header.zone_size = qcow2_opts->zone_size;
+        s->zoned_header.nr_zones = DIV_ROUND_UP(qcow2_opts->size,
+                                                qcow2_opts->zone_size);
+
+        if (qcow2_opts->has_zone_capacity) {
+            if (qcow2_opts->zone_capacity > qcow2_opts->zone_size) {
+                s->zoned_header.zoned = BLK_Z_NONE;
+                error_setg(errp, "zone capacity %" PRIu64 "B exceeds zone size "
+                           "%" PRIu64"B", qcow2_opts->zone_capacity,
+                           qcow2_opts->zone_size);
+                goto out;
+            }
+            s->zoned_header.zone_capacity = qcow2_opts->zone_capacity;
+        } else {
+            s->zoned_header.zone_capacity = qcow2_opts->zone_size;
+        }
+
+        if (qcow2_opts->has_nr_conv_zones) {
+            s->zoned_header.nr_conv_zones = qcow2_opts->nr_conv_zones;
+        }
+
+        if (qcow2_opts->has_max_active_zones) {
+            if (qcow2_opts->max_open_zones > qcow2_opts->max_active_zones) {
+                s->zoned_header.zoned = BLK_Z_NONE;
+                error_setg(errp, "max_open_zones %" PRIu32 " exceeds "
+                           "max_active_zones %" PRIu32"",
+                           qcow2_opts->max_open_zones,
+                           qcow2_opts->max_active_zones);
+                goto out;
+            }
+            if (qcow2_opts->has_max_open_zones) {
+                s->zoned_header.max_open_zones = qcow2_opts->max_active_zones;
+            } else {
+                s->zoned_header.max_open_zones = qcow2_opts->max_active_zones;
+            }
+        }
+        s->zoned_header.max_append_sectors = qcow2_opts->max_append_sectors;
+    } else {
+        s->zoned_header.zoned = BLK_Z_NONE;
+    }
+
     /* Create a full header (including things like feature table) */
     ret = qcow2_update_header(blk_bs(blk));
     bdrv_graph_co_rdunlock();
@@ -3903,6 +4035,13 @@ qcow2_co_create_opts(BlockDriver *drv, const char *filename, QemuOpts *opts,
         { BLOCK_OPT_COMPAT_LEVEL,       "version" },
         { BLOCK_OPT_DATA_FILE_RAW,      "data-file-raw" },
         { BLOCK_OPT_COMPRESSION_TYPE,   "compression-type" },
+        { BLOCK_OPT_Z_MODEL,            "zone-model"},
+        { BLOCK_OPT_Z_NR_COV,           "nr-conv-zones"},
+        { BLOCK_OPT_Z_MOZ,              "max-open-zones"},
+        { BLOCK_OPT_Z_MAZ,              "max-active-zones"},
+        { BLOCK_OPT_Z_MAS,              "max-append-sectors"},
+        { BLOCK_OPT_Z_SIZE,             "zone-size"},
+        { BLOCK_OPT_Z_CAP,              "zone-capacity"},
         { NULL, NULL },
     };
 
@@ -6066,6 +6205,41 @@ static QemuOptsList qcow2_create_opts = {
             .help = "Compression method used for image cluster "        \
                     "compression",                                      \
             .def_value_str = "zlib"                                     \
+        },                                                              \
+        {                                                               \
+            .name = BLOCK_OPT_Z_MODEL,                                  \
+            .type = QEMU_OPT_NUMBER,                                    \
+            .help = "zone model",                                      \
+        },                                                              \
+        {                                                               \
+            .name = BLOCK_OPT_Z_SIZE,                                   \
+            .type = QEMU_OPT_SIZE,                                      \
+            .help = "zone size",                                        \
+        },                                                              \
+        {                                                               \
+            .name = BLOCK_OPT_Z_CAP,                                    \
+            .type = QEMU_OPT_SIZE,                                      \
+            .help = "zone capacity",                                    \
+        },                                                              \
+        {                                                               \
+            .name = BLOCK_OPT_Z_NR_COV,                                 \
+            .type = QEMU_OPT_NUMBER,                                    \
+            .help = "numbers of conventional zones",                    \
+        },                                                              \
+        {                                                               \
+            .name = BLOCK_OPT_Z_MAS,                                    \
+            .type = QEMU_OPT_NUMBER,                                    \
+            .help = "max append sectors",                               \
+        },                                                              \
+        {                                                               \
+            .name = BLOCK_OPT_Z_MAZ,                                    \
+            .type = QEMU_OPT_NUMBER,                                    \
+            .help = "max active zones",                                 \
+        },                                                              \
+        {                                                               \
+            .name = BLOCK_OPT_Z_MOZ,                                    \
+            .type = QEMU_OPT_NUMBER,                                    \
+            .help = "max open zones",                                   \
         },
         QCOW_COMMON_OPTIONS,
         { /* end of list */ }
diff --git a/block/qcow2.h b/block/qcow2.h
index f789ce3ae0..edb8eebcb3 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -236,6 +236,19 @@ typedef struct Qcow2CryptoHeaderExtension {
     uint64_t length;
 } QEMU_PACKED Qcow2CryptoHeaderExtension;
 
+typedef struct Qcow2ZonedHeaderExtension {
+    /* Zoned device attributes */
+    uint8_t zoned;
+    uint8_t reserved[3];
+    uint32_t zone_size;
+    uint32_t zone_capacity;
+    uint32_t nr_conv_zones;
+    uint32_t nr_zones;
+    uint32_t max_active_zones;
+    uint32_t max_open_zones;
+    uint32_t max_append_sectors;
+} QEMU_PACKED Qcow2ZonedHeaderExtension;
+
 typedef struct Qcow2UnknownHeaderExtension {
     uint32_t magic;
     uint32_t len;
@@ -422,6 +435,13 @@ typedef struct BDRVQcow2State {
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
index 2c4618375a..80ff03a826 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -331,6 +331,42 @@ The fields of the bitmaps extension are:
                    Offset into the image file at which the bitmap directory
                    starts. Must be aligned to a cluster boundary.
 
+== Zoned extension ==
+
+The zoned extension is an optional header extension. It contains fields for
+emulating the zoned stroage model (https://zonedstorage.io/).
+
+The fields of the zoned extension are:
+    Byte        0:  zoned
+                    Zoned model, 1 for host-managed and 0 for non-zoned devices.
+
+            1 - 3:  Reserved, must be zero.
+
+            4 - 7:  zone_size
+                    Total number of logical blocks within the zones in bytes.
+
+           8 - 11:  zone_capacity
+                    The number of writable logical blocks within the zones in
+                    bytes. A zone capacity is always smaller or equal to the
+                    zone size.
+
+          12 - 15:  nr_conv_zones
+                    The number of conventional zones.
+
+          16 - 19:  nr_zones
+                    The number of zones.
+
+          20 - 23:  max_active_zones
+                    The limit of the zones that have the implicit open,
+                    explicit open or closed state.
+
+          24 - 27:  max_open_zones
+                    The maximal allowed open zones.
+
+          28 - 35:  max_append_sectors
+                    The maximal data size in sectors of a zone
+                    append request that can be issued to the device.
+
 == Full disk encryption header pointer ==
 
 The full disk encryption header must be present if, and only if, the
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 74195c3004..332c0c765c 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -57,6 +57,13 @@
 #define BLOCK_OPT_DATA_FILE_RAW     "data_file_raw"
 #define BLOCK_OPT_COMPRESSION_TYPE  "compression_type"
 #define BLOCK_OPT_EXTL2             "extended_l2"
+#define BLOCK_OPT_Z_MODEL           "zone_model"
+#define BLOCK_OPT_Z_SIZE            "zone_size"
+#define BLOCK_OPT_Z_CAP             "zone_capacity"
+#define BLOCK_OPT_Z_NR_COV          "nr_conv_zones"
+#define BLOCK_OPT_Z_MAS             "max_append_sectors"
+#define BLOCK_OPT_Z_MAZ             "max_active_zones"
+#define BLOCK_OPT_Z_MOZ             "max_open_zones"
 
 #define BLOCK_PROBE_BUF_SIZE        512
 
@@ -878,6 +885,12 @@ typedef struct BlockLimits {
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
index 2b1d493d6e..0d8f9e0a88 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -5021,6 +5021,27 @@
 # @compression-type: The image cluster compression method
 #     (default: zlib, since 5.1)
 #
+# @zone-model: Zoned device model, 1 for host-managed and 0 for
+#     non-zoned devices (default: 0, since 8.0)
+#
+# @zone-size: Total number of logical blocks within zones in bytes
+#     (since 8.0)
+#
+# @zone-capacity: The number of usable logical blocks within zones
+#     in bytes. A zone capacity is always smaller or equal to the
+#     zone size. (since 8.0)
+#
+# @nr-conv-zones: The number of conventional zones of the zoned device
+#     (since 8.0)
+#
+# @max-open-zones: The maximal allowed open zones (since 8.0)
+#
+# @max-active-zones: The limit of the zones that have the implicit
+#     open, explicit open or closed state (since 8.0)
+#
+# @max-append-sectors: The maximal data size in sectors of a zone
+#     append request that can be issued to the device. (since 8.0)
+#
 # Since: 2.12
 ##
 { 'struct': 'BlockdevCreateOptionsQcow2',
@@ -5037,7 +5058,14 @@
             '*preallocation':   'PreallocMode',
             '*lazy-refcounts':  'bool',
             '*refcount-bits':   'int',
-            '*compression-type':'Qcow2CompressionType' } }
+            '*compression-type':'Qcow2CompressionType',
+            '*zone-model':         'uint8',
+            '*zone-size':          'size',
+            '*zone-capacity':      'size',
+            '*nr-conv-zones':      'uint32',
+            '*max-open-zones':     'uint32',
+            '*max-active-zones':   'uint32',
+            '*max-append-sectors': 'uint32' } }
 
 ##
 # @BlockdevCreateOptionsQed:
-- 
2.40.1


