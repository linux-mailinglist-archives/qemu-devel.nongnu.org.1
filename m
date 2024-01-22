Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF568371A1
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 20:02:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRzX6-0005dU-EG; Mon, 22 Jan 2024 14:00:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1rRzX4-0005Zw-E4; Mon, 22 Jan 2024 14:00:30 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1rRzX2-000244-5i; Mon, 22 Jan 2024 14:00:30 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a2cea0563cbso533052866b.3; 
 Mon, 22 Jan 2024 11:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705950026; x=1706554826; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5hNJ04BBtl/d/n4RMb97rf/4F5jeEcyAbdZoYNre8FU=;
 b=HOaLKCDeBcbeDbZjwYoHUt0AlWSHwbuV5wK9+6NmNiLzd+BkK2bQgGVDL46xP/ypAj
 GrpwQhE27IbxFE/znO5CErfzihPf2P34ypMZRXOiHrBgpv1PlGH+c89Xbc51XWOk+IPs
 Ymsj9fZb1NRmYT3fZW7t61r+zmqvHgNZDGkd/u/p+2e8Hb49YOX4aMISa/egzFkP/Uam
 6EVKnI88WuZfZ/aX/TrckUNyMt83Y4rnORFOD0T+9Iw2S3w7z3HrAEJFa/OPK0cHrBii
 ++sfnfCEq8z2nDlyEkjK7Rkf8R4grWrXV8tMGYJoyleeFDv1H/uSo2hx8qAJMnlNxVzd
 j8+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705950026; x=1706554826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5hNJ04BBtl/d/n4RMb97rf/4F5jeEcyAbdZoYNre8FU=;
 b=xHqp1h1MStzC2fZoXN8IFLPVvGpgKwOtnofNqHbLxVF3Mehn4VMyhglugWam4rpfuk
 fUmxiKWJzGeNEhL9rwdGUfMpavocvNpT4JtzkleBGCxd8e6A+2maYelyt9eI4h6/JBuM
 LtqHvULcYyWfe/5VbKNPxbRdU1iZVZoaCiROWjHwXio04noa6ABb4rwdRHMHLn8TT9Bg
 1T7rJf1qQbzy1dsAypb4lIYhisfyr46yYIrba9kMYVzzrQ1R0yrqGfaJcJphjNIMJ4ZN
 1lnuacG3jUdWvfyhVqwzZKfrbhAyTHnJ/BdkjvfIFYjxDaPuP7226eLTgjg4sL9pv8q8
 i3NQ==
X-Gm-Message-State: AOJu0YxUao0uzR18oKdnYS108sbTfd7kTMbchKOzu1620FsJtuB9Ng3r
 CDI/CvCndBg8uWdAVQ9WGggia2nakZYkT0NAVPGZp5Pe3Aw+d/T8uwXC6IxTCxI=
X-Google-Smtp-Source: AGHT+IH1ssW5/vSpVRxDzxg4eHkIVwWOQqIjrgfeg61KBw7T2MT0MjPO1BcTLkJPiDZomLE1AxaVAg==
X-Received: by 2002:a17:906:66da:b0:a2c:1b17:d267 with SMTP id
 k26-20020a17090666da00b00a2c1b17d267mr2440786ejp.148.1705950025620; 
 Mon, 22 Jan 2024 11:00:25 -0800 (PST)
Received: from localhost.localdomain ([2a02:2454:367:1500:fa08:d4d:b569:ac2d])
 by smtp.gmail.com with ESMTPSA id
 k3-20020a170906a38300b00a298d735a1bsm13842413ejz.149.2024.01.22.11.00.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 11:00:25 -0800 (PST)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, stefanha@redhat.com,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 dmitry.fomichev@wdc.com, hare@suse.de, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 dlemoal@kernel.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Sam Li <faithilikerun@gmail.com>
Subject: [RFC v3 2/7] qcow2: add zd_extension configurations to zoned metadata
Date: Mon, 22 Jan 2024 20:00:08 +0100
Message-Id: <20240122190013.41302-3-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240122190013.41302-1-faithilikerun@gmail.com>
References: <20240122190013.41302-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=faithilikerun@gmail.com; helo=mail-ej1-x634.google.com
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

Zone descriptor extension data is host definied data that is
associated with each zone. Add zone descriptor extensions
to zonedmeta struct.

Signed-off-by: Sam Li <faithilikerun@gmail.com>
---
 block/qcow2.c                    | 70 +++++++++++++++++++++++++++++---
 block/qcow2.h                    |  2 +
 include/block/block_int-common.h |  6 +++
 qapi/block-core.json             |  4 ++
 4 files changed, 76 insertions(+), 6 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index db28585b82..5098edf656 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -448,9 +448,9 @@ qcow2_refresh_zonedmeta(BlockDriverState *bs)
 {
     int ret;
     BDRVQcow2State *s = bs->opaque;
-    uint64_t wps_size = s->zoned_header.zonedmeta_size;
+    uint64_t wps_size = s->zoned_header.zonedmeta_size -
+        s->zded_size;
     g_autofree uint64_t *temp;
-
     temp = g_new(uint64_t, wps_size);
     ret = bdrv_pread(bs->file, s->zoned_header.zonedmeta_offset,
                      wps_size, temp, 0);
@@ -459,7 +459,17 @@ qcow2_refresh_zonedmeta(BlockDriverState *bs)
         return ret;
     }
 
+    g_autofree uint8_t *zded = NULL;
+    zded = g_try_malloc0(s->zded_size);
+    ret = bdrv_pread(bs->file, s->zoned_header.zonedmeta_offset + wps_size,
+                     s->zded_size, zded, 0);
+    if (ret < 0) {
+        error_report("Can not read zded");
+        return ret;
+    }
+
     memcpy(bs->wps->wp, temp, wps_size);
+    memcpy(bs->zd_extensions, zded, s->zded_size);
     return 0;
 }
 
@@ -520,6 +530,19 @@ qcow2_check_zone_options(Qcow2ZonedHeaderExtension *zone_opt)
             zone_opt->max_open_zones = sequential_zones;
         }
 
+        if (zone_opt->zd_extension_size) {
+            if (zone_opt->zd_extension_size & 0x3f) {
+               error_report("zone descriptor extension size must be a "
+                            "multiple of 64B");
+               return false;
+            }
+
+            if ((zone_opt->zd_extension_size >> 6) > 0xff) {
+                error_report("Zone descriptor extension size is too large");
+                return false;
+            }
+        }
+
         return true;
     }
     return false;
@@ -784,6 +807,8 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
             zoned_ext.conventional_zones =
                 be32_to_cpu(zoned_ext.conventional_zones);
             zoned_ext.nr_zones = be32_to_cpu(zoned_ext.nr_zones);
+            zoned_ext.zd_extension_size =
+                be32_to_cpu(zoned_ext.zd_extension_size);
             zoned_ext.max_open_zones = be32_to_cpu(zoned_ext.max_open_zones);
             zoned_ext.max_active_zones =
                 be32_to_cpu(zoned_ext.max_active_zones);
@@ -794,7 +819,8 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
             zoned_ext.zonedmeta_size = be64_to_cpu(zoned_ext.zonedmeta_size);
             s->zoned_header = zoned_ext;
             bs->wps = g_malloc(sizeof(BlockZoneWps)
-                + s->zoned_header.zonedmeta_size);
+                + zoned_ext.zonedmeta_size - s->zded_size);
+            bs->zd_extensions = g_malloc0(s->zded_size);
             ret = qcow2_refresh_zonedmeta(bs);
             if (ret < 0) {
                 return ret;
@@ -2370,6 +2396,7 @@ static void qcow2_refresh_limits(BlockDriverState *bs, Error **errp)
     bs->bl.zone_size = s->zoned_header.zone_size;
     bs->bl.zone_capacity = s->zoned_header.zone_capacity;
     bs->bl.write_granularity = BDRV_SECTOR_SIZE;
+    bs->bl.zd_extension_size = s->zoned_header.zd_extension_size;
 }
 
 static int GRAPH_UNLOCKED
@@ -3621,6 +3648,8 @@ int qcow2_update_header(BlockDriverState *bs)
             .conventional_zones =
                 cpu_to_be32(s->zoned_header.conventional_zones),
             .nr_zones           = cpu_to_be32(s->zoned_header.nr_zones),
+            .zd_extension_size  =
+                cpu_to_be32(s->zoned_header.zd_extension_size),
             .max_open_zones     = cpu_to_be32(s->zoned_header.max_open_zones),
             .max_active_zones   =
                 cpu_to_be32(s->zoned_header.max_active_zones),
@@ -4373,6 +4402,15 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
         }
         s->zoned_header.max_append_bytes = zone_host_managed->max_append_bytes;
 
+        uint64_t zded_size = 0;
+        if (zone_host_managed->has_descriptor_extension_size) {
+            s->zoned_header.zd_extension_size =
+                zone_host_managed->descriptor_extension_size;
+            zded_size = s->zoned_header.zd_extension_size *
+                bs->bl.nr_zones;
+        }
+        s->zded_size = zded_size;
+
         if (!qcow2_check_zone_options(&s->zoned_header)) {
             s->zoned_header.zoned = BLK_Z_NONE;
             ret = -EINVAL;
@@ -4380,7 +4418,7 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
         }
 
         uint32_t nrz = s->zoned_header.nr_zones;
-        zoned_meta_size =  sizeof(uint64_t) * nrz;
+        zoned_meta_size =  sizeof(uint64_t) * nrz + zded_size;
         g_autofree uint64_t *meta = NULL;
         meta = g_new0(uint64_t, nrz);
 
@@ -4412,12 +4450,25 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
             error_setg_errno(errp, -ret, "Could not zero fill zoned metadata");
             goto unlock;
         }
-        ret = bdrv_pwrite(blk_bs(blk)->file, offset, zoned_meta_size, meta, 0);
+
+        ret = bdrv_pwrite(blk_bs(blk)->file, offset,
+                          zoned_meta_size - zded_size, meta, 0);
         if (ret < 0) {
             error_setg_errno(errp, -ret, "Could not write zoned metadata "
                                          "to disk");
             goto unlock;
         }
+
+        if (zone_host_managed->has_descriptor_extension_size) {
+            /* Initialize zone descriptor extensions */
+            ret = bdrv_co_pwrite_zeroes(blk_bs(blk)->file, offset + zded_size,
+                                        zded_size, 0);
+            if (ret < 0) {
+                error_setg_errno(errp, -ret, "Could not write zone descriptor"
+                                             "extensions to disk");
+                goto unlock;
+            }
+        }
     } else {
         s->zoned_header.zoned = BLK_Z_NONE;
     }
@@ -4562,6 +4613,7 @@ qcow2_co_create_opts(BlockDriver *drv, const char *filename, QemuOpts *opts,
         { BLOCK_OPT_MAX_OPEN_ZONES,     "zone.max-open-zones" },
         { BLOCK_OPT_MAX_ACTIVE_ZONES,   "zone.max-active-zones" },
         { BLOCK_OPT_MAX_APPEND_BYTES,   "zone.max-append-bytes" },
+        { BLOCK_OPT_ZD_EXT_SIZE,        "zone.descriptor-extension-size" },
         { NULL, NULL },
     };
 
@@ -7126,7 +7178,13 @@ static QemuOptsList qcow2_create_opts = {
             .name = BLOCK_OPT_MAX_OPEN_ZONES,                           \
             .type = QEMU_OPT_NUMBER,                                    \
             .help = "max open zones",                                   \
-        },
+        },                                                              \
+            {                                                           \
+            .name = BLOCK_OPT_ZD_EXT_SIZE,                              \
+            .type = QEMU_OPT_SIZE,                                      \
+            .help = "zone descriptor extension size (defaults "         \
+                    "to 0, must be a multiple of 64 bytes)",            \
+        },                                                              \
         QCOW_COMMON_OPTIONS,
         { /* end of list */ }
     }
diff --git a/block/qcow2.h b/block/qcow2.h
index 7f37bb4034..b7a8f4f4b6 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -249,6 +249,7 @@ typedef struct Qcow2ZonedHeaderExtension {
     uint32_t max_append_bytes;
     uint64_t zonedmeta_size;
     uint64_t zonedmeta_offset;
+    uint32_t zd_extension_size; /* must be multiple of 64 B */
 } QEMU_PACKED Qcow2ZonedHeaderExtension;
 
 typedef struct Qcow2ZoneListEntry {
@@ -456,6 +457,7 @@ typedef struct BDRVQcow2State {
     uint32_t nr_zones_exp_open;
     uint32_t nr_zones_imp_open;
     uint32_t nr_zones_closed;
+    uint64_t zded_size;
 } BDRVQcow2State;
 
 typedef struct Qcow2COWRegion {
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index d48486f344..825b8dac55 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -64,6 +64,7 @@
 #define BLOCK_OPT_MAX_APPEND_BYTES      "zone.max_append_bytes"
 #define BLOCK_OPT_MAX_ACTIVE_ZONES      "zone.max_active_zones"
 #define BLOCK_OPT_MAX_OPEN_ZONES        "zone.max_open_zones"
+#define BLOCK_OPT_ZD_EXT_SIZE        "zd_extension_size"
 
 #define BLOCK_PROBE_BUF_SIZE        512
 
@@ -912,6 +913,9 @@ typedef struct BlockLimits {
     uint32_t max_active_zones;
 
     uint32_t write_granularity;
+
+    /* size of data that is associated with a zone in bytes */
+    uint32_t zd_extension_size;
 } BlockLimits;
 
 typedef struct BdrvOpBlocker BdrvOpBlocker;
@@ -1268,6 +1272,8 @@ struct BlockDriverState {
 
     /* array of write pointers' location of each zone in the zoned device. */
     BlockZoneWps *wps;
+
+    uint8_t *zd_extensions;
 };
 
 struct BlockBackendRootState {
diff --git a/qapi/block-core.json b/qapi/block-core.json
index e2e0ec21a5..485533546a 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -5077,12 +5077,16 @@
 #     append request that can be issued to the device.  It must be
 #     512-byte aligned and less than the zone capacity.
 #
+# @descriptor-extension-size: The size of zone descriptor extension
+#     data.  Must be a multiple of 64 bytes (default 0)
+#
 # Since 8.2
 ##
 { 'struct': 'Qcow2ZoneHostManaged',
   'data': { '*size':          'size',
             '*capacity':      'size',
             '*conventional-zones': 'uint32',
+            '*descriptor-extension-size':  'size',
             '*max-open-zones':     'uint32',
             '*max-active-zones':   'uint32',
             '*max-append-bytes':   'size' } }
-- 
2.40.1


