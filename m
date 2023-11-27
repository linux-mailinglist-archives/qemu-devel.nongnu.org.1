Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 530B57F986A
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 05:37:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7TN7-0000cC-Td; Sun, 26 Nov 2023 23:37:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1r7TN6-0000by-4N; Sun, 26 Nov 2023 23:37:24 -0500
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1r7TN3-0001Gt-8E; Sun, 26 Nov 2023 23:37:23 -0500
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1f0f94943d9so1879174fac.2; 
 Sun, 26 Nov 2023 20:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701059839; x=1701664639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lm/6hZbLqU/akvQo+DZ6ZMjg7vY+IF0AmnxBmXwiPe4=;
 b=VejXBA7OLoT/LNxHjeOOcBhK0mgN4fsThDzPk9jThYFjsgyW5GdkW6ZUn+UfH9WqUC
 XLX8L8792lWKJIeepB13lWsah+CBWcxZ5ciCOh1+AIK5s6dnBYifkjK2nVJm07mEuy0f
 0UcqZXfCXpfP27AHyTLkPJ99t12OZeix1V6DHsY5YY9QsJ2xIi4cBYWZKw6vq8p3Ubl1
 ZXW0ERgM1R/sZWGQ3bMtalolKA0y2hdnc96GcVOCYeu9eBvEyM323RUdYo4HnW4Tpw0p
 y6kwlQD7V5wS7kmd/chkw5rZUW7SuGQEhJ3PV3RROKueJi0WPksbsVLboo+H+oUtad3i
 GRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701059839; x=1701664639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lm/6hZbLqU/akvQo+DZ6ZMjg7vY+IF0AmnxBmXwiPe4=;
 b=v1s36g2uv+ozmilo9Vp4+VQBjHXXdQ2ZS5VRzUzSPImu9RkY9scRbYpQ392BpDLb/z
 rfzs5HJM9A4+DsYYiTsv81BOdmNyyb7PwLp/6524Zq0Zaady7m9kBpRaF7sz21Ec478y
 aZ0FjxTj8EyL7m/z1b9U1LExsGWL4AxiD3Q241efucZ2Xs9MdnhUIcFuLX+4nHLZXOa6
 SzjmKi1ww/JBTsGkdWgorFL+wrqytarGgOzPi/cGIr0mdXT1DvrKJFIADl3KbEkzrPTW
 f7GVkAg67dXVq4ZyVBf0kaLE3TldBRoDR8GvFSCV3qaORVfVCj8iP2jNX1xpm6iTNG6f
 cB7g==
X-Gm-Message-State: AOJu0Ywdk4NhREN05ws27gh8AUhl0QpnQ2GbvIiojiPYk0ITh0pmPW0q
 R6nxRQ7T1eiN87FOdReKF+nHy9bN9+hFRflR
X-Google-Smtp-Source: AGHT+IGxm/T12B68VZnybtCTT0uIaoOQdsSKqFfVq1k+FYzzkSavS6hUaRZ9jNqdGwxfEC//yffKeA==
X-Received: by 2002:a05:6871:5c9:b0:1fa:1ca1:577a with SMTP id
 v9-20020a05687105c900b001fa1ca1577amr7631884oan.41.1701059837924; 
 Sun, 26 Nov 2023 20:37:17 -0800 (PST)
Received: from fedlinux.. ([106.84.128.244]) by smtp.gmail.com with ESMTPSA id
 u15-20020a62ed0f000000b006c4d86a259csm6280070pfh.28.2023.11.26.20.37.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Nov 2023 20:37:17 -0800 (PST)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: dmitry.fomichev@wdc.com, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, dlemoal@kernel.org, hare@suse.de,
 Hanna Reitz <hreitz@redhat.com>, stefanha@redhat.com,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v6 2/4] qcow2: add configurations for zoned format extension
Date: Mon, 27 Nov 2023 12:37:01 +0800
Message-Id: <20231127043703.49489-3-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231127043703.49489-1-faithilikerun@gmail.com>
References: <20231127043703.49489-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=faithilikerun@gmail.com; helo=mail-oa1-x2a.google.com
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
requires settings as: the device size, zone model, zone size,
zone capacity, number of conventional zones, limits on zone
resources (max append bytes, max open zones, and max_active_zones).

To create a qcow2 image with zoned format feature, use command like
this:
$path/to/qemu-img create -f qcow2 zbc.qcow2 -o size=768M
-o zone.size=64M -o zone.capacity=64M -o zone.conventional_zones=0
-o zone.max_append_bytes=4096 -o zone.max_open_zones=10
-o zone.max_active_zones=12 -o zone.mode=host-managed

Signed-off-by: Sam Li <faithilikerun@gmail.com>
---
 block/qcow2.c                    | 233 ++++++++++++++++++++++++++++++-
 block/qcow2.h                    |  36 ++++-
 docs/interop/qcow2.txt           |  99 ++++++++++++-
 include/block/block_int-common.h |  13 ++
 qapi/block-core.json             |  63 ++++++++-
 5 files changed, 440 insertions(+), 4 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 13e032bd5e..9a92cd242c 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -73,6 +73,7 @@ typedef struct {
 #define  QCOW2_EXT_MAGIC_CRYPTO_HEADER 0x0537be77
 #define  QCOW2_EXT_MAGIC_BITMAPS 0x23852875
 #define  QCOW2_EXT_MAGIC_DATA_FILE 0x44415441
+#define  QCOW2_EXT_MAGIC_ZONED_FORMAT 0x007a6264
 
 static int coroutine_fn
 qcow2_co_preadv_compressed(BlockDriverState *bs,
@@ -194,6 +195,55 @@ qcow2_extract_crypto_opts(QemuOpts *opts, const char *fmt, Error **errp)
     return cryptoopts_qdict;
 }
 
+/*
+ * Passing by the zoned device configurations by a zoned_header struct, check
+ * if the zone device options are under constraints. Return false when some
+ * option is invalid
+ */
+static inline bool
+qcow2_check_zone_options(Qcow2ZonedHeaderExtension *zone_opt)
+{
+    if (zone_opt) {
+        if (zone_opt->zone_size == 0) {
+            error_report("Zoned extension header zone_size field "
+                         "can not be 0");
+            return false;
+        }
+
+        if (zone_opt->zone_capacity > zone_opt->zone_size) {
+            error_report("zone capacity %" PRIu32 "B exceeds zone size "
+                         "%" PRIu32"B", zone_opt->zone_capacity,
+                         zone_opt->zone_size);
+            return false;
+        }
+
+        if (zone_opt->max_active_zones > zone_opt->nr_zones) {
+            error_report("Max_active_zones %" PRIu32 " exceeds "
+                         "nr_zones %" PRIu32". Set it to nr_zones.",
+                         zone_opt->max_active_zones, zone_opt->nr_zones);
+            zone_opt->max_active_zones = zone_opt->nr_zones;
+        }
+
+        if (zone_opt->max_open_zones > zone_opt->max_active_zones) {
+            error_report("Max_open_zones %" PRIu32 " exceeds "
+                         "max_active_zones %" PRIu32". Set it to "
+                         "max_active_zones.",
+                         zone_opt->max_open_zones,
+                         zone_opt->max_active_zones);
+            zone_opt->max_open_zones = zone_opt->max_active_zones;
+        }
+
+        if (zone_opt->max_open_zones > zone_opt->nr_zones) {
+            error_report("Max_open_zones field can not be larger "
+                         "than the number of zones. Set it to nr_zones.");
+            zone_opt->max_open_zones = zone_opt->nr_zones;
+        }
+
+        return true;
+    }
+    return false;
+}
+
 /*
  * read qcow2 extension and fill bs
  * start reading from start_offset
@@ -211,6 +261,7 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
     uint64_t offset;
     int ret;
     Qcow2BitmapHeaderExt bitmaps_ext;
+    Qcow2ZonedHeaderExtension zoned_ext;
 
     if (need_update_header != NULL) {
         *need_update_header = false;
@@ -432,6 +483,51 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
             break;
         }
 
+        case QCOW2_EXT_MAGIC_ZONED_FORMAT:
+        {
+            if (ext.len < sizeof(zoned_ext)) {
+                /* Missing fields */
+                error_setg(errp, "zoned_ext: len=%" PRIu32 " too small "
+                           "(<%zu)", ext.len, sizeof(zoned_ext));
+                return -EINVAL;
+            }
+            ret = bdrv_pread(bs->file, offset, ext.len, &zoned_ext, 0);
+            if (ret < 0) {
+                error_setg_errno(errp, -ret, "zoned_ext: "
+                                 "Could not read ext header");
+                return ret;
+            }
+
+            zoned_ext.zone_size = be32_to_cpu(zoned_ext.zone_size);
+            zoned_ext.zone_capacity = be32_to_cpu(zoned_ext.zone_capacity);
+            zoned_ext.conventional_zones =
+                be32_to_cpu(zoned_ext.conventional_zones);
+            zoned_ext.nr_zones = be32_to_cpu(zoned_ext.nr_zones);
+            zoned_ext.max_open_zones = be32_to_cpu(zoned_ext.max_open_zones);
+            zoned_ext.max_active_zones =
+                be32_to_cpu(zoned_ext.max_active_zones);
+            zoned_ext.max_append_bytes =
+                be32_to_cpu(zoned_ext.max_append_bytes);
+            s->zoned_header = zoned_ext;
+
+            /* refuse to open broken images */
+            if (zoned_ext.nr_zones != DIV_ROUND_UP(bs->total_sectors *
+                BDRV_SECTOR_SIZE, zoned_ext.zone_size)) {
+                error_setg(errp, "Zoned extension header nr_zones field "
+                           "is wrong");
+                return -EINVAL;
+            }
+            if (!qcow2_check_zone_options(&zoned_ext)) {
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
@@ -1968,6 +2064,15 @@ static void qcow2_refresh_limits(BlockDriverState *bs, Error **errp)
     }
     bs->bl.pwrite_zeroes_alignment = s->subcluster_size;
     bs->bl.pdiscard_alignment = s->cluster_size;
+    bs->bl.zoned = s->zoned_header.zoned;
+    bs->bl.nr_zones = s->zoned_header.nr_zones;
+    bs->bl.max_append_sectors = s->zoned_header.max_append_bytes
+        >> BDRV_SECTOR_BITS;
+    bs->bl.max_active_zones = s->zoned_header.max_active_zones;
+    bs->bl.max_open_zones = s->zoned_header.max_open_zones;
+    bs->bl.zone_size = s->zoned_header.zone_size;
+    bs->bl.zone_capacity = s->zoned_header.zone_capacity;
+    bs->bl.write_granularity = BDRV_SECTOR_SIZE;
 }
 
 static int GRAPH_UNLOCKED
@@ -3067,6 +3172,11 @@ int qcow2_update_header(BlockDriverState *bs)
                 .bit  = QCOW2_INCOMPAT_EXTL2_BITNR,
                 .name = "extended L2 entries",
             },
+            {
+                .type = QCOW2_FEAT_TYPE_INCOMPATIBLE,
+                .bit  = QCOW2_INCOMPAT_ZONED_FORMAT_BITNR,
+                .name = "zoned format",
+            },
             {
                 .type = QCOW2_FEAT_TYPE_COMPATIBLE,
                 .bit  = QCOW2_COMPAT_LAZY_REFCOUNTS_BITNR,
@@ -3112,6 +3222,31 @@ int qcow2_update_header(BlockDriverState *bs)
         buflen -= ret;
     }
 
+    /* Zoned devices header extension */
+    if (s->zoned_header.zoned == BLK_Z_HM) {
+        Qcow2ZonedHeaderExtension zoned_header = {
+            .zoned              = s->zoned_header.zoned,
+            .zone_size          = cpu_to_be32(s->zoned_header.zone_size),
+            .zone_capacity      = cpu_to_be32(s->zoned_header.zone_capacity),
+            .conventional_zones =
+                cpu_to_be32(s->zoned_header.conventional_zones),
+            .nr_zones           = cpu_to_be32(s->zoned_header.nr_zones),
+            .max_open_zones     = cpu_to_be32(s->zoned_header.max_open_zones),
+            .max_active_zones   =
+                cpu_to_be32(s->zoned_header.max_active_zones),
+            .max_append_bytes =
+                cpu_to_be32(s->zoned_header.max_append_bytes)
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
@@ -3485,6 +3620,8 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
 {
     BlockdevCreateOptionsQcow2 *qcow2_opts;
     QDict *options;
+    Qcow2ZoneCreateOptions *zone_struct;
+    Qcow2ZoneHostManaged *zone_host_managed;
 
     /*
      * Open the image file and write a minimal qcow2 header.
@@ -3511,6 +3648,8 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
 
     assert(create_options->driver == BLOCKDEV_DRIVER_QCOW2);
     qcow2_opts = &create_options->u.qcow2;
+    zone_struct = create_options->u.qcow2.zone;
+    zone_host_managed = &create_options->u.qcow2.zone->u.host_managed;
 
     bs = bdrv_co_open_blockdev_ref(qcow2_opts->file, errp);
     if (bs == NULL) {
@@ -3724,6 +3863,14 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
         header->incompatible_features |=
             cpu_to_be64(QCOW2_INCOMPAT_DATA_FILE);
     }
+    if (zone_struct->mode == QCOW2_ZONE_MODEL_HOST_MANAGED) {
+        /*
+         * The incompatible bit must be set when the zone model is
+         * host-managed
+         */
+        header->incompatible_features |=
+            cpu_to_be64(QCOW2_INCOMPAT_ZONED_FORMAT);
+    }
     if (qcow2_opts->data_file_raw) {
         header->autoclear_features |=
             cpu_to_be64(QCOW2_AUTOCLEAR_DATA_FILE_RAW);
@@ -3792,11 +3939,56 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
     }
 
     /* Set the external data file if necessary */
+    BDRVQcow2State *s = blk_bs(blk)->opaque;
     if (data_bs) {
-        BDRVQcow2State *s = blk_bs(blk)->opaque;
         s->image_data_file = g_strdup(data_bs->filename);
     }
 
+    if (zone_struct->mode == QCOW2_ZONE_MODEL_HOST_MANAGED) {
+        if (!zone_host_managed->has_size) {
+            error_setg(errp, "Missing zone_size parameter");
+            ret = -EINVAL;
+            goto out;
+        }
+
+        s->zoned_header.zoned = BLK_Z_HM;
+        s->zoned_header.zone_size = zone_host_managed->size;
+        s->zoned_header.nr_zones = DIV_ROUND_UP(qcow2_opts->size,
+                                                zone_host_managed->size);
+        if (zone_host_managed->has_capacity) {
+            s->zoned_header.zone_capacity = zone_host_managed->capacity;
+        } else {
+            s->zoned_header.zone_capacity = zone_host_managed->size;
+        }
+
+        if (zone_host_managed->has_conventional_zones) {
+            s->zoned_header.conventional_zones =
+                zone_host_managed->conventional_zones;
+        }
+
+        if (zone_host_managed->has_max_active_zones) {
+            s->zoned_header.max_active_zones =
+                zone_host_managed->max_active_zones;
+
+            if (zone_host_managed->has_max_open_zones) {
+                s->zoned_header.max_open_zones =
+                    zone_host_managed->max_open_zones;
+            } else {
+                s->zoned_header.max_open_zones =
+                    zone_host_managed->max_active_zones;
+            }
+        }
+        s->zoned_header.max_append_bytes = zone_host_managed->max_append_bytes;
+
+        if (!qcow2_check_zone_options(&s->zoned_header)) {
+            s->zoned_header.zoned = BLK_Z_NONE;
+            ret = -EINVAL;
+            goto out;
+        }
+    } else {
+        s->zoned_header.zoned = BLK_Z_NONE;
+    }
+
     /* Create a full header (including things like feature table) */
     ret = qcow2_update_header(blk_bs(blk));
     bdrv_graph_co_rdunlock();
@@ -3930,6 +4122,10 @@ qcow2_co_create_opts(BlockDriver *drv, const char *filename, QemuOpts *opts,
         { BLOCK_OPT_COMPAT_LEVEL,       "version" },
         { BLOCK_OPT_DATA_FILE_RAW,      "data-file-raw" },
         { BLOCK_OPT_COMPRESSION_TYPE,   "compression-type" },
+        { BLOCK_OPT_CONVENTIONAL_ZONES, "zone.conventional-zones" },
+        { BLOCK_OPT_MAX_OPEN_ZONES,     "zone.max-open-zones" },
+        { BLOCK_OPT_MAX_ACTIVE_ZONES,   "zone.max-active-zones" },
+        { BLOCK_OPT_MAX_APPEND_BYTES,   "zone.max-append-bytes" },
         { NULL, NULL },
     };
 
@@ -6097,6 +6293,41 @@ static QemuOptsList qcow2_create_opts = {
             .help = "Compression method used for image cluster "        \
                     "compression",                                      \
             .def_value_str = "zlib"                                     \
+        },                                                              \
+        {                                                               \
+            .name = BLOCK_OPT_ZONE_MODEL,                               \
+            .type = QEMU_OPT_STRING,                                    \
+            .help = "zone model modes, mode choice: host-managed",      \
+        },                                                              \
+        {                                                               \
+            .name = BLOCK_OPT_ZONE_SIZE,                                \
+            .type = QEMU_OPT_SIZE,                                      \
+            .help = "zone size",                                        \
+        },                                                              \
+        {                                                               \
+            .name = BLOCK_OPT_ZONE_CAPACITY,                            \
+            .type = QEMU_OPT_SIZE,                                      \
+            .help = "zone capacity",                                    \
+        },                                                              \
+        {                                                               \
+            .name = BLOCK_OPT_CONVENTIONAL_ZONES,                       \
+            .type = QEMU_OPT_NUMBER,                                    \
+            .help = "numbers of conventional zones",                    \
+        },                                                              \
+        {                                                               \
+            .name = BLOCK_OPT_MAX_APPEND_BYTES,                         \
+            .type = QEMU_OPT_NUMBER,                                    \
+            .help = "max append bytes",                                 \
+        },                                                              \
+        {                                                               \
+            .name = BLOCK_OPT_MAX_ACTIVE_ZONES,                         \
+            .type = QEMU_OPT_NUMBER,                                    \
+            .help = "max active zones",                                 \
+        },                                                              \
+        {                                                               \
+            .name = BLOCK_OPT_MAX_OPEN_ZONES,                           \
+            .type = QEMU_OPT_NUMBER,                                    \
+            .help = "max open zones",                                   \
         },
         QCOW_COMMON_OPTIONS,
         { /* end of list */ }
diff --git a/block/qcow2.h b/block/qcow2.h
index a9e3481c6e..7f37bb4034 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -236,6 +236,27 @@ typedef struct Qcow2CryptoHeaderExtension {
     uint64_t length;
 } QEMU_PACKED Qcow2CryptoHeaderExtension;
 
+typedef struct Qcow2ZonedHeaderExtension {
+    /* Zoned device attributes */
+    uint8_t zoned;
+    uint8_t reserved[3];
+    uint32_t zone_size;
+    uint32_t zone_capacity;
+    uint32_t conventional_zones;
+    uint32_t nr_zones;
+    uint32_t max_active_zones;
+    uint32_t max_open_zones;
+    uint32_t max_append_bytes;
+    uint64_t zonedmeta_size;
+    uint64_t zonedmeta_offset;
+} QEMU_PACKED Qcow2ZonedHeaderExtension;
+
+typedef struct Qcow2ZoneListEntry {
+    QLIST_ENTRY(Qcow2ZoneListEntry) exp_open_zone_entry;
+    QLIST_ENTRY(Qcow2ZoneListEntry) imp_open_zone_entry;
+    QLIST_ENTRY(Qcow2ZoneListEntry) closed_zone_entry;
+} Qcow2ZoneListEntry;
+
 typedef struct Qcow2UnknownHeaderExtension {
     uint32_t magic;
     uint32_t len;
@@ -256,17 +277,20 @@ enum {
     QCOW2_INCOMPAT_DATA_FILE_BITNR  = 2,
     QCOW2_INCOMPAT_COMPRESSION_BITNR = 3,
     QCOW2_INCOMPAT_EXTL2_BITNR      = 4,
+    QCOW2_INCOMPAT_ZONED_FORMAT_BITNR = 5,
     QCOW2_INCOMPAT_DIRTY            = 1 << QCOW2_INCOMPAT_DIRTY_BITNR,
     QCOW2_INCOMPAT_CORRUPT          = 1 << QCOW2_INCOMPAT_CORRUPT_BITNR,
     QCOW2_INCOMPAT_DATA_FILE        = 1 << QCOW2_INCOMPAT_DATA_FILE_BITNR,
     QCOW2_INCOMPAT_COMPRESSION      = 1 << QCOW2_INCOMPAT_COMPRESSION_BITNR,
     QCOW2_INCOMPAT_EXTL2            = 1 << QCOW2_INCOMPAT_EXTL2_BITNR,
+    QCOW2_INCOMPAT_ZONED_FORMAT     = 1 << QCOW2_INCOMPAT_ZONED_FORMAT_BITNR,
 
     QCOW2_INCOMPAT_MASK             = QCOW2_INCOMPAT_DIRTY
                                     | QCOW2_INCOMPAT_CORRUPT
                                     | QCOW2_INCOMPAT_DATA_FILE
                                     | QCOW2_INCOMPAT_COMPRESSION
-                                    | QCOW2_INCOMPAT_EXTL2,
+                                    | QCOW2_INCOMPAT_EXTL2
+                                    | QCOW2_INCOMPAT_ZONED_FORMAT,
 };
 
 /* Compatible feature bits */
@@ -422,6 +446,16 @@ typedef struct BDRVQcow2State {
      * is to convert the image with the desired compression type set.
      */
     Qcow2CompressionType compression_type;
+
+    /* States of zoned device */
+    Qcow2ZonedHeaderExtension zoned_header;
+    QLIST_HEAD(, Qcow2ZoneListEntry) exp_open_zones;
+    QLIST_HEAD(, Qcow2ZoneListEntry) imp_open_zones;
+    QLIST_HEAD(, Qcow2ZoneListEntry) closed_zones;
+    Qcow2ZoneListEntry *zone_list_entries;
+    uint32_t nr_zones_exp_open;
+    uint32_t nr_zones_imp_open;
+    uint32_t nr_zones_closed;
 } BDRVQcow2State;
 
 typedef struct Qcow2COWRegion {
diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index 2c4618375a..0f1938f056 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -125,7 +125,26 @@ the next fields through header_length.
                                 allows subcluster-based allocation. See the
                                 Extended L2 Entries section for more details.
 
-                    Bits 5-63:  Reserved (set to 0)
+                    Bit 5:      Zoned extension bit. If this bit is set then
+                                the file is an emulated zoned device. The
+                                zoned extension must be present.
+                                Implementations that do not support zoned
+                                emulation cannot open this file because it
+                                generally only make sense to interpret the
+                                data along with the zone information and
+                                write pointers.
+
+                                It is unsafe when any qcow2 user without
+                                knowing the zoned extension reads or edits
+                                a file with the zoned extension. The write
+                                pointer tracking can be corrupted when a
+                                writer edits a file, like overwriting beyond
+                                the write pointer locations. Or a reader tries
+                                to access a file without knowing write
+                                pointers where the software setup will cause
+                                invalid reads.
+
+                    Bits 6-63:  Reserved (set to 0)
 
          80 -  87:  compatible_features
                     Bitmask of compatible features. An implementation can
@@ -249,6 +268,7 @@ be stored. Each extension has a structure like the following:
                         0x23852875 - Bitmaps extension
                         0x0537be77 - Full disk encryption header pointer
                         0x44415441 - External data file name string
+                        0x007a6264 - Zoned extension
                         other      - Unknown header extension, can be safely
                                      ignored
 
@@ -331,6 +351,83 @@ The fields of the bitmaps extension are:
                    Offset into the image file at which the bitmap directory
                    starts. Must be aligned to a cluster boundary.
 
+== Zoned extension ==
+
+The zoned extension must be present if the incompatible bit is set, and
+omitted when the incompatible bit is clear. It contains fields for
+emulating the zoned storage model (https://zonedstorage.io/). When the
+zone model mode is not host-managed, it is regarded as incompatible
+and reports an error to users.
+
+The write pointers for each zone are stored in an area called zonedmeta
+clusters. It is 8 bytes per zone. The offset and size of the zonedmeta
+are kept in the zoned extension header.
+
+The fields of the zoned extension are:
+    Byte       0:  zoned
+                   The bit represents the zoned model of the device. 0 is for
+                   a non-zoned device (all other information in this header
+                   is ignored). 1 is for a host-managed device, which only
+                   allows for sequential writes within each zone. Other
+                   values may be added later, the implementation must refuse
+                   to open a device containing an unknown zone model.
+
+          1 -  3:  Reserved, must be zero.
+
+          4 -  7:  zone_size
+                   Total size of each zone, in bytes. It is less than 4GB
+                   in the qcow2 image for simplicity. The maximum zone size
+                   of real zoned devices are 2TB. If there are usages for
+                   emulating devices whose zone sizes are larger than 4G,
+                   the field needs to be sized bigger then.
+
+                   The value must be power of 2. Linux currently requires
+                   the zone size to be a power of 2 number of LBAs. Qcow2
+                   following this is mainly to allow emulating a real
+                   ZNS drive configuration. It is not relevant to the cluster
+                   size.
+
+          8 - 11:  zone_capacity
+                   The number of writable bytes within the zones. The bytes
+                   between zone capacity and zone size are unusable: reads
+                   will return 0s and writes will fail.
+
+                   A zone capacity is always smaller or equal to the zone
+                   size. It is for emulating a real ZNS drive configuration,
+                   which has the constraint of aligning to some hardware erase
+                   block size.
+
+         12 - 15:  conventional_zones
+                   The number of conventional zones. The conventional zones
+                   allow sequential writes and random writes. While the
+                   sequential zones only allow sequential writes.
+
+         16 - 19:  nr_zones
+                   The number of zones. It is the sum of conventional zones
+                   and sequential zones.
+
+         20 - 23:  max_active_zones
+                   The number of the zones that can be in the implicit open,
+                   explicit open or closed state.
+
+         24 - 27:  max_open_zones
+                   The maximal number of open (implicitly open or explicitly
+                   open) zones.
+
+         28 - 31:  max_append_bytes
+                   The number of bytes of a zone append request that can be
+                   issued to the device. It must be 512-byte aligned.
+
+         32 - 39:  zonedmeta_size
+                   The size of zoned metadata in bytes. It contains no more
+                   than 4GB. The zoned metadata structure is the write
+                   pointers for each zone whose size is the number of zones
+                   multiplied by the zone size.
+
+         40 - 47:  zonedmeta_offset
+                   The offset of zoned metadata structure in the contained
+                   image, in bytes.
+
 == Full disk encryption header pointer ==
 
 The full disk encryption header must be present if, and only if, the
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 4e31d161c5..0d231bd1f7 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -57,6 +57,13 @@
 #define BLOCK_OPT_DATA_FILE_RAW     "data_file_raw"
 #define BLOCK_OPT_COMPRESSION_TYPE  "compression_type"
 #define BLOCK_OPT_EXTL2             "extended_l2"
+#define BLOCK_OPT_ZONE_MODEL        "zone.mode"
+#define BLOCK_OPT_ZONE_SIZE         "zone.size"
+#define BLOCK_OPT_ZONE_CAPACITY     "zone.capacity"
+#define BLOCK_OPT_CONVENTIONAL_ZONES    "zone.conventional_zones"
+#define BLOCK_OPT_MAX_APPEND_BYTES      "zone.max_append_bytes"
+#define BLOCK_OPT_MAX_ACTIVE_ZONES      "zone.max_active_zones"
+#define BLOCK_OPT_MAX_OPEN_ZONES        "zone.max_open_zones"
 
 #define BLOCK_PROBE_BUF_SIZE        512
 
@@ -886,6 +893,12 @@ typedef struct BlockLimits {
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
index ca390c5700..ef98dc83a0 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -5038,6 +5038,64 @@
 { 'enum': 'Qcow2CompressionType',
   'data': [ 'zlib', { 'name': 'zstd', 'if': 'CONFIG_ZSTD' } ] }
 
+##
+# @Qcow2ZoneModel:
+#
+# Zoned device model used in qcow2 image file
+#
+# @host-managed: host-managed model only allows sequential write over the
+#     device zones
+#
+# Since 8.2
+##
+{ 'enum': 'Qcow2ZoneModel',
+  'data': [ 'host-managed'] }
+
+##
+# @Qcow2ZoneHostManaged:
+#
+# The host-managed zone model.  It only allows sequential writes.
+#
+# @size: Total number of bytes within zones
+#
+# @capacity: The number of usable logical blocks within zones
+#     in bytes.  A zone capacity is always smaller or equal to the
+#     zone size
+#
+# @conventional-zones: The number of conventional zones of the
+#     zoned device
+#
+# @max-open-zones: The maximal number of open zones
+#
+# @max-active-zones: The maximal number of zones in the implicit
+#     open, explicit open or closed state
+#
+# @max-append-bytes: The maximal number of bytes of a zone
+#     append request that can be issued to the device.  It must be
+#     512-byte aligned
+#
+# Since 8.2
+##
+{ 'struct': 'Qcow2ZoneHostManaged',
+  'data': { '*size':          'size',
+            '*capacity':      'size',
+            '*conventional-zones': 'uint32',
+            '*max-open-zones':     'uint32',
+            '*max-active-zones':   'uint32',
+            '*max-append-bytes':   'uint32' } }
+
+##
+# @Qcow2ZoneCreateOptions:
+#
+# The zone device model for the qcow2 image.
+#
+# Since 8.2
+##
+{ 'union': 'Qcow2ZoneCreateOptions',
+  'base': { 'mode': 'Qcow2ZoneModel' },
+  'discriminator': 'mode',
+  'data': { 'host-managed': 'Qcow2ZoneHostManaged' } }
+
 ##
 # @BlockdevCreateOptionsQcow2:
 #
@@ -5080,6 +5138,8 @@
 # @compression-type: The image cluster compression method
 #     (default: zlib, since 5.1)
 #
+# @zone: @Qcow2ZoneCreateOptions.  The zone device model modes (since 8.2)
+#
 # Since: 2.12
 ##
 { 'struct': 'BlockdevCreateOptionsQcow2',
@@ -5096,7 +5156,8 @@
             '*preallocation':   'PreallocMode',
             '*lazy-refcounts':  'bool',
             '*refcount-bits':   'int',
-            '*compression-type':'Qcow2CompressionType' } }
+            '*compression-type':'Qcow2CompressionType',
+            '*zone':            'Qcow2ZoneCreateOptions' } }
 
 ##
 # @BlockdevCreateOptionsQed:
-- 
2.40.1


