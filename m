Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8607DB9C6
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 13:21:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxREv-0005ec-R1; Mon, 30 Oct 2023 08:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qxREq-0005da-7t; Mon, 30 Oct 2023 08:19:24 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qxREm-0006ET-My; Mon, 30 Oct 2023 08:19:23 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1cc34c3420bso6575695ad.3; 
 Mon, 30 Oct 2023 05:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698668358; x=1699273158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O1bNYmfcnXdBjlRzPOZMlrrzOqpF37vHFP+aGLUFfgk=;
 b=B14fJbUg5kI7AW9ayK5Fd+xuenR5n5AlnRzoSNaMhRshDYb631/ICut2ftCYvayyv0
 W4/9HaIy91lxxVVui9+xFzK/o8ssoaF3VaE0xI8cJtq3SJHLIyzyId1Np2p+451G7NRv
 FisIQ4Cc0LmxhqX6EyonahKJVkqLNeIlxz6UPGjLgrfiSI4PaTkIr8bjzmUp4nx5r1Kr
 L+jMg1eHrjLAZWQY032OKQp+lsL1SN0Kv6MvsvuwsAA+w0a/7Sa2Po8P4xOxBU6RgePk
 IvikdMoXrb05lkiVIeZgB723ykMcZHM5nyr2yYNCLwPI/CiLYKzxCjbMgR5LkkEhBRyF
 mlqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698668358; x=1699273158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O1bNYmfcnXdBjlRzPOZMlrrzOqpF37vHFP+aGLUFfgk=;
 b=I+AO2DZh9pVCakjQLHpNFCaqyCSmAWNf/K4fUDr5PLTACrf1UvLow00judw4DtrfFZ
 kDmPRUpuTOSRw8tCam7sM7NMy6qttlYk8m87FZv4pRf+afbmMifcHDVpajUk/n4qj89q
 9OsR5GqRgtkSimiERpB74bKE5G+acUh7G8IKIPW1nRsSZhK7oWNPeG8M2nCW3V25rqts
 zhuCAyDbLM4RKQY38MUMaapDypYN8DMHxA5WS6NMAggfo8F/+TctQO2c3PDfFB25qKKw
 sNoyNJkUc3oRpGSl4o3TbI1ertnYFpqIH3CGZYy3WfqSkvgINfPqhBtbVvlljRBi06vi
 r8fg==
X-Gm-Message-State: AOJu0YwIsOS9ttyFBuaI7OVSLgAGYgMff1BjIJZLDUiBTZY8qR9iaAdF
 UtK11jZvls5JJ5zJea+sPR+JQ2jYzFOyOBDs
X-Google-Smtp-Source: AGHT+IFyVaezSHyOwGFVKj5iC8BOYL1s4ItfX9HNLL27KaL3KcNhpj0bBgRtz+gSNIq2Ym3kKTKu4w==
X-Received: by 2002:a17:902:e1cd:b0:1c9:9e33:3a7d with SMTP id
 t13-20020a170902e1cd00b001c99e333a7dmr6087724pla.20.1698668357015; 
 Mon, 30 Oct 2023 05:19:17 -0700 (PDT)
Received: from fedlinux.. ([106.84.131.249]) by smtp.gmail.com with ESMTPSA id
 f12-20020a170902684c00b001b9f032bb3dsm6362339pln.3.2023.10.30.05.19.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 05:19:16 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>, dlemoal@kernel.org, hare@suse.de,
 dmitry.fomichev@wdc.com, stefanha@redhat.com, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v5 2/4] qcow2: add configurations for zoned format extension
Date: Mon, 30 Oct 2023 20:18:45 +0800
Message-Id: <20231030121847.4522-3-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231030121847.4522-1-faithilikerun@gmail.com>
References: <20231030121847.4522-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=faithilikerun@gmail.com; helo=mail-pl1-x633.google.com
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
resources (max append bytes, max open zones, and max_active_zones).

To create a qcow2 file with zoned format, use command like this:
$ qemu-img create -f qcow2 test.qcow2 -o size=768M -o
zone_size=64M -o zone_capacity=64M -o conventional_zones=0 -o
max_append_bytes=4096 -o max_open_zones=0 -o max_active_zones=0
-o zone_model=host-managed

Signed-off-by: Sam Li <faithilikerun@gmail.com>

fix config?
---
 block/qcow2.c                    | 205 ++++++++++++++++++++++++++++++-
 block/qcow2.h                    |  37 +++++-
 docs/interop/qcow2.txt           |  67 +++++++++-
 include/block/block_int-common.h |  13 ++
 qapi/block-core.json             |  45 ++++++-
 5 files changed, 362 insertions(+), 5 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index aa01d9e7b5..cd53268ca7 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -73,6 +73,7 @@ typedef struct {
 #define  QCOW2_EXT_MAGIC_CRYPTO_HEADER 0x0537be77
 #define  QCOW2_EXT_MAGIC_BITMAPS 0x23852875
 #define  QCOW2_EXT_MAGIC_DATA_FILE 0x44415441
+#define  QCOW2_EXT_MAGIC_ZONED_FORMAT 0x007a6264
 
 static int coroutine_fn
 qcow2_co_preadv_compressed(BlockDriverState *bs,
@@ -210,6 +211,7 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
     uint64_t offset;
     int ret;
     Qcow2BitmapHeaderExt bitmaps_ext;
+    Qcow2ZonedHeaderExtension zoned_ext;
 
     if (need_update_header != NULL) {
         *need_update_header = false;
@@ -431,6 +433,63 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
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
+            if (s->incompatible_features & QCOW2_INCOMPAT_ZONED_FORMAT) {
+                warn_report("A program lacking zoned format support "
+                           "may modify this file and zoned metadata are "
+                           "now considered inconsistent");
+                error_printf("The zoned metadata is corrupted.\n");
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
@@ -1967,6 +2026,15 @@ static void qcow2_refresh_limits(BlockDriverState *bs, Error **errp)
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
@@ -3062,6 +3130,11 @@ int qcow2_update_header(BlockDriverState *bs)
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
@@ -3107,6 +3180,31 @@ int qcow2_update_header(BlockDriverState *bs)
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
@@ -3718,6 +3816,10 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
         header->incompatible_features |=
             cpu_to_be64(QCOW2_INCOMPAT_DATA_FILE);
     }
+    if (qcow2_opts->zone_model != QCOW2_ZONE_MODEL_HOST_MANAGED) {
+        header->incompatible_features |=
+            cpu_to_be64(QCOW2_INCOMPAT_ZONED_FORMAT);
+    }
     if (qcow2_opts->data_file_raw) {
         header->autoclear_features |=
             cpu_to_be64(QCOW2_AUTOCLEAR_DATA_FILE_RAW);
@@ -3786,11 +3888,70 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
     }
 
     /* Set the external data file if necessary */
+    BDRVQcow2State *s = blk_bs(blk)->opaque;
     if (data_bs) {
-        BDRVQcow2State *s = blk_bs(blk)->opaque;
         s->image_data_file = g_strdup(data_bs->filename);
     }
 
+    if (qcow2_opts->zone_model == QCOW2_ZONE_MODEL_HOST_MANAGED) {
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
+        s->zoned_header.zoned = BLK_Z_HM;
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
+        if (qcow2_opts->has_conventional_zones) {
+            s->zoned_header.conventional_zones = qcow2_opts->conventional_zones;
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
+        s->zoned_header.max_append_bytes = qcow2_opts->max_append_bytes;
+    } else {
+        s->zoned_header.zoned = BLK_Z_NONE;
+    }
+
     /* Create a full header (including things like feature table) */
     ret = qcow2_update_header(blk_bs(blk));
     bdrv_graph_co_rdunlock();
@@ -3921,6 +4082,13 @@ qcow2_co_create_opts(BlockDriver *drv, const char *filename, QemuOpts *opts,
         { BLOCK_OPT_COMPAT_LEVEL,       "version" },
         { BLOCK_OPT_DATA_FILE_RAW,      "data-file-raw" },
         { BLOCK_OPT_COMPRESSION_TYPE,   "compression-type" },
+        { BLOCK_OPT_ZONE_MODEL,         "zone-model"},
+        { BLOCK_OPT_CONVENTIONAL_ZONES, "conventional-zones"},
+        { BLOCK_OPT_MAX_OPEN_ZONES,     "max-open-zones"},
+        { BLOCK_OPT_MAX_ACTIVE_ZONES,   "max-active-zones"},
+        { BLOCK_OPT_MAX_APPEND_BYTES,   "max-append-bytes"},
+        { BLOCK_OPT_ZONE_SIZE,          "zone-size"},
+        { BLOCK_OPT_ZONE_CAPACITY,      "zone-capacity"},
         { NULL, NULL },
     };
 
@@ -6087,6 +6255,41 @@ static QemuOptsList qcow2_create_opts = {
             .help = "Compression method used for image cluster "        \
                     "compression",                                      \
             .def_value_str = "zlib"                                     \
+        },                                                              \
+        {                                                               \
+            .name = BLOCK_OPT_ZONE_MODEL,                               \
+            .type = QEMU_OPT_STRING,                                    \
+            .help = "zone model",                                       \
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
index 29958c512b..6e5d90afd2 100644
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
@@ -285,7 +309,6 @@ enum {
     QCOW2_AUTOCLEAR_DATA_FILE_RAW       = 1 << QCOW2_AUTOCLEAR_DATA_FILE_RAW_BITNR,
 
     QCOW2_AUTOCLEAR_MASK                = QCOW2_AUTOCLEAR_BITMAPS
-                                        | QCOW2_AUTOCLEAR_DATA_FILE_RAW,
 };
 
 enum qcow2_discard_type {
@@ -422,6 +445,16 @@ typedef struct BDRVQcow2State {
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
index 2c4618375a..b210bc4580 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -125,7 +125,18 @@ the next fields through header_length.
                                 allows subcluster-based allocation. See the
                                 Extended L2 Entries section for more details.
 
-                    Bits 5-63:  Reserved (set to 0)
+                    Bit 5:      Zoned extension bit. If this bit is set then
+                                the file is a zoned device file with
+                                host-managed model.
+
+                                It is unsafe when any qcow2 writer which does
+                                not understand zone information edits a file
+                                with the zoned extension. The write pointer
+                                tracking is corrupted between different version
+                                of qcow2 writes. In such cases, the file can
+                                no longer be seen as a zoned device.
+
+                    Bits 6-63:  Reserved (set to 0)
 
          80 -  87:  compatible_features
                     Bitmask of compatible features. An implementation can
@@ -249,6 +260,7 @@ be stored. Each extension has a structure like the following:
                         0x23852875 - Bitmaps extension
                         0x0537be77 - Full disk encryption header pointer
                         0x44415441 - External data file name string
+                        0x007a6264 - Zoned extension
                         other      - Unknown header extension, can be safely
                                      ignored
 
@@ -331,6 +343,59 @@ The fields of the bitmaps extension are:
                    Offset into the image file at which the bitmap directory
                    starts. Must be aligned to a cluster boundary.
 
+== Zoned extension ==
+
+The zoned extension is an optional header extension. It contains fields for
+emulating the zoned stroage model (https://zonedstorage.io/).
+
+When the device model is not recognized as host-managed, it is regared as
+incompatible and report an error to users.
+
+The fields of the zoned extension are:
+    Byte       0:  zoned
+                   This bit represents zone model of devices. 1 is for
+                   host-managed, which only allows sequential writes.
+                   And 0 is for non-zoned devices without such constraints.
+
+          1 -  3:  Reserved, must be zero.
+
+          4 -  7:  zone_size
+                   Total size of each zones, in bytes. It is less than 4GB
+                   in the contained image for simplicity.
+
+          8 - 11:  zone_capacity
+                   The number of writable bytes within the zones.
+                   A zone capacity is always smaller or equal to the
+                   zone size.
+
+         12 - 15:  conventional_zones
+                   The number of conventional zones.
+
+         16 - 19:  nr_zones
+                   The number of zones. It is the sum of conventional zones
+                   and sequential zones.
+
+         20 - 23:  max_active_zones
+                   The number of the zones that are in the implicit open,
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
+                   pointers for each zone.
+
+         40 - 47:  zonedmeta_offset
+                   The offset of zoned metadata structure in the contained
+                   image, in bytes.
+
 == Full disk encryption header pointer ==
 
 The full disk encryption header must be present if, and only if, the
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index b8d9d24f39..4b94e55eb4 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -57,6 +57,13 @@
 #define BLOCK_OPT_DATA_FILE_RAW     "data_file_raw"
 #define BLOCK_OPT_COMPRESSION_TYPE  "compression_type"
 #define BLOCK_OPT_EXTL2             "extended_l2"
+#define BLOCK_OPT_ZONE_MODEL        "zone_model"
+#define BLOCK_OPT_ZONE_SIZE         "zone_size"
+#define BLOCK_OPT_ZONE_CAPACITY     "zone_capacity"
+#define BLOCK_OPT_CONVENTIONAL_ZONES    "conventional_zones"
+#define BLOCK_OPT_MAX_APPEND_BYTES      "max_append_bytes"
+#define BLOCK_OPT_MAX_ACTIVE_ZONES      "max_active_zones"
+#define BLOCK_OPT_MAX_OPEN_ZONES        "max_open_zones"
 
 #define BLOCK_PROBE_BUF_SIZE        512
 
@@ -883,6 +890,12 @@ typedef struct BlockLimits {
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
index 89751d81f2..884e058046 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4981,6 +4981,21 @@
 { 'enum': 'Qcow2CompressionType',
   'data': [ 'zlib', { 'name': 'zstd', 'if': 'CONFIG_ZSTD' } ] }
 
+##
+# @Qcow2ZoneModel:
+#
+# Zoned device model used in qcow2 image file
+#
+# @non-zoned: non-zoned model is for regular block devices
+#
+# @host-managed: host-managed model only allows sequential write over the
+#     device zones
+#
+# Since 8.2
+##
+{ 'enum': 'Qcow2ZoneModel',
+  'data': ['non-zoned', 'host-managed'] }
+
 ##
 # @BlockdevCreateOptionsQcow2:
 #
@@ -5023,6 +5038,27 @@
 # @compression-type: The image cluster compression method
 #     (default: zlib, since 5.1)
 #
+# @zone-model: @Qcow2ZoneModel.  The zone device model.
+#     (default: non-zoned, since 8.2)
+#
+# @zone-size: Total number of bytes within zones (since 8.2)
+#
+# @zone-capacity: The number of usable logical blocks within zones
+#     in bytes.  A zone capacity is always smaller or equal to the
+#     zone size (since 8.2)
+#
+# @conventional-zones: The number of conventional zones of the
+#     zoned device (since 8.2)
+#
+# @max-open-zones: The maximal number of open zones (since 8.2)
+#
+# @max-active-zones: The maximal number of zones in the implicit
+#     open, explicit open or closed state (since 8.2)
+#
+# @max-append-bytes: The maximal number of bytes of a zone
+#     append request that can be issued to the device.  It must be
+#     512-byte aligned (since 8.2)
+#
 # Since: 2.12
 ##
 { 'struct': 'BlockdevCreateOptionsQcow2',
@@ -5039,7 +5075,14 @@
             '*preallocation':   'PreallocMode',
             '*lazy-refcounts':  'bool',
             '*refcount-bits':   'int',
-            '*compression-type':'Qcow2CompressionType' } }
+            '*compression-type':'Qcow2CompressionType',
+            '*zone-model':         'Qcow2ZoneModel',
+            '*zone-size':          'size',
+            '*zone-capacity':      'size',
+            '*conventional-zones': 'uint32',
+            '*max-open-zones':     'uint32',
+            '*max-active-zones':   'uint32',
+            '*max-append-bytes':   'uint32' } }
 
 ##
 # @BlockdevCreateOptionsQed:
-- 
2.40.1


