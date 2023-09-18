Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 295397A466C
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 11:54:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiAwr-0002ST-7T; Mon, 18 Sep 2023 05:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qiAwp-0002S4-06; Mon, 18 Sep 2023 05:53:43 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qiAwm-0002I2-EM; Mon, 18 Sep 2023 05:53:42 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-68fbb10dea4so3210551b3a.3; 
 Mon, 18 Sep 2023 02:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695030818; x=1695635618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ih8AyOmnr3CyfcQasIsV2Iv3XHJed5/SL+/5cdvy8yo=;
 b=L2yk5U+jJ8Wx2t/MBwkEBW0WgnHiaXHeQa1GHSLYzH71y3kMphRwd1HySHLoOVDcHi
 QubsjP+TO5/vfdmE2f2UwMbwFxqM3YeQ2D67UwHgMm0ax/XwSCNqAwcI6WKMY4QTHVsW
 iz8oFHkIcgHF4OMQTzMpN3MABeZ1DZsQ1pKW0uiA1W3G/YLDZiqiyYdsofI+yNgR89K+
 GBZSs4WY7vGjIPqSDUISzyd+escvHMjc/Eper054GFzaRNDrmUTmtuiwAriWxe8l3lba
 HtqDdYOYUemiOaUCyFLtCTxbioAfy7UEd1PO7Jzw6OTc8mbad22kfwJf2HBYH2+HF+pe
 Vf0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695030818; x=1695635618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ih8AyOmnr3CyfcQasIsV2Iv3XHJed5/SL+/5cdvy8yo=;
 b=enBuzuu7DwtWpfrKNNlBkzu6xHfGOAsLvk7AKyW13jeEBWZzSMJl9ePtNoRpo42e40
 asYoFZtqdSpN6aA0aDaJWGNj116UddtufNWvkn1ZZqBbiLs0ejpYvtraXZIt6JSOmYKg
 y9wjfyFeVBlUUtj1axYsMHZuUGKMHCWNBXK6M2iAqoOhTCUaB2iIvONcanY7Rws2Qmg2
 6rYn+qrf0a4N14Cev0/yJ8GBDuP9wYI6o2EQLmzVzoePYA/lIyR9P1cKBkL8aRYxqgwA
 z9twf6HAoqB5sq1/37OFMLm2iPTVp9frAY0+0QjKyVgOxx6tcqvbbdsPyEhLfgdNHKK0
 dUmg==
X-Gm-Message-State: AOJu0YzuEPTzfOMNQcngCw30gYho0mF+Fxq8RFfEd4ejmNhGAn9va7fM
 m6VFusktEBRmLzC5YBlySx9KXLNJAfVU6t0zcoA=
X-Google-Smtp-Source: AGHT+IHBHcoR7fQjjitznIDAmSgBwUu2Ebkr2WtCVvPbPATlPFbSUa7074+9boVic8sq6TaQAEDNtg==
X-Received: by 2002:a05:6a00:1ac6:b0:690:45cc:bd37 with SMTP id
 f6-20020a056a001ac600b0069045ccbd37mr8414944pfv.18.1695030817928; 
 Mon, 18 Sep 2023 02:53:37 -0700 (PDT)
Received: from fedlinux.. ([106.84.131.213]) by smtp.gmail.com with ESMTPSA id
 y24-20020aa78558000000b0068fb8080939sm6780553pfn.65.2023.09.18.02.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Sep 2023 02:53:37 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: dmitry.fomichev@wdc.com, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, dlemoal@kernel.org,
 Hanna Reitz <hreitz@redhat.com>, stefanha@redhat.com, hare@suse.de,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v4 2/4] qcow2: add configurations for zoned format extension
Date: Mon, 18 Sep 2023 17:53:11 +0800
Message-Id: <20230918095313.5492-3-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918095313.5492-1-faithilikerun@gmail.com>
References: <20230918095313.5492-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=faithilikerun@gmail.com; helo=mail-pf1-x432.google.com
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
requires settings as: the device size, zone model, zone size,
zone capacity, number of conventional zones, limits on zone
resources (max append sectors, max open zones, and max_active_zones).

To create a qcow2 file with zoned format, use command like this:
$ qemu-img create -f qcow2 test.qcow2 -o size=768M -o
zone_size=64M -o zone_capacity=64M -o nr_conv_zones=0 -o
max_append_sectors=512 -o max_open_zones=0 -o max_active_zones=0
-o zone_model=1

Signed-off-by: Sam Li <faithilikerun@gmail.com>
---
 block/qcow2.c                    | 186 ++++++++++++++++++++++++++++++-
 block/qcow2.h                    |  28 +++++
 docs/interop/qcow2.txt           |  36 ++++++
 include/block/block_int-common.h |  13 +++
 qapi/block-core.json             |  30 ++++-
 5 files changed, 291 insertions(+), 2 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index b48cd9ce63..521276fc51 100644
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
+                                 "is wrong");
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
+    bs->bl.max_append_sectors = s->zoned_header.max_append_sectors;
+    bs->bl.max_active_zones = s->zoned_header.max_active_zones;
+    bs->bl.max_open_zones = s->zoned_header.max_open_zones;
+    bs->bl.zone_size = s->zoned_header.zone_size;
+    bs->bl.zone_capacity = s->zoned_header.zone_capacity;
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
@@ -3768,11 +3851,70 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
     }
 
     /* Set the external data file if necessary */
+    BDRVQcow2State *s = blk_bs(blk)->opaque;
     if (data_bs) {
-        BDRVQcow2State *s = blk_bs(blk)->opaque;
         s->image_data_file = g_strdup(data_bs->filename);
     }
 
+    if (qcow2_opts->has_zone_model && qcow2_opts->zone_model == BLK_Z_HM) {
+        if (!qcow2_opts->has_zone_size) {
+            error_setg(errp, "Missing zone_size parameter");
+            ret = -EINVAL;
+            goto out;
+        }
+
+        if (qcow2_opts->zone_size == 0) {
+            s->zoned_header.zoned = BLK_Z_NONE;
+            error_setg(errp, "Zoned devices can not allow a larger-than-zero "
+                             "zone_size");
+            ret = -EINVAL;
+            goto out;
+        }
+
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
+                ret = -EINVAL;
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
+                ret = -EINVAL;
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
@@ -3903,6 +4045,13 @@ qcow2_co_create_opts(BlockDriver *drv, const char *filename, QemuOpts *opts,
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
 
@@ -6067,6 +6216,41 @@ static QemuOptsList qcow2_create_opts = {
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
index f789ce3ae0..1929788494 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -236,6 +236,25 @@ typedef struct Qcow2CryptoHeaderExtension {
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
+typedef struct Qcow2Wp {
+    uint64_t wp;
+    QLIST_ENTRY(Qcow2Wp) exp_open_zone_entry;
+    QLIST_ENTRY(Qcow2Wp) imp_open_zone_entry;
+} Qcow2Wp;
+
 typedef struct Qcow2UnknownHeaderExtension {
     uint32_t magic;
     uint32_t len;
@@ -422,6 +441,15 @@ typedef struct BDRVQcow2State {
      * is to convert the image with the desired compression type set.
      */
     Qcow2CompressionType compression_type;
+
+    /* States of zoned device */
+    Qcow2ZonedHeaderExtension zoned_header;
+    QLIST_HEAD(, Qcow2Wp) exp_open_zones;
+    QLIST_HEAD(, Qcow2Wp) imp_open_zones;
+    Qcow2Wp *wp;
+    uint32_t nr_zones_exp_open;
+    uint32_t nr_zones_imp_open;
+    uint32_t nr_zones_closed;
 } BDRVQcow2State;
 
 typedef struct Qcow2COWRegion {
diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index 2c4618375a..80314614aa 100644
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
+                    The maximal number of 512-byte sectors of a zone
+                    append request that can be issued to the device.
+
 == Full disk encryption header pointer ==
 
 The full disk encryption header must be present if, and only if, the
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 85be256c09..d169d15dd6 100644
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
index 2b1d493d6e..2aad82c399 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -5021,6 +5021,27 @@
 # @compression-type: The image cluster compression method
 #     (default: zlib, since 5.1)
 #
+# @zone-model: Zoned device model, 1 for host-managed and 0 for
+#     non-zoned devices (default: 0, since 8.2)
+#
+# @zone-size: Total number of logical blocks within zones in bytes
+#     (since 8.2)
+#
+# @zone-capacity: The number of usable logical blocks within zones
+#     in bytes.  A zone capacity is always smaller or equal to the
+#     zone size. (since 8.2)
+#
+# @nr-conv-zones: The number of conventional zones of the zoned device
+#     (since 8.2)
+#
+# @max-open-zones: The maximal number of open zones (since 8.2)
+#
+# @max-active-zones: The limit of the zones that have the implicit
+#     open, explicit open or closed state (since 8.2)
+#
+# @max-append-sectors: The maximal number of 512-byte sectors of a zone
+#     append request that can be issued to the device. (since 8.2)
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


