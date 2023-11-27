Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF7E7F9C3A
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 10:00:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7XRb-0002lZ-Fp; Mon, 27 Nov 2023 03:58:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1r7XRK-0002g2-Jt; Mon, 27 Nov 2023 03:58:03 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1r7XRA-0000Je-AR; Mon, 27 Nov 2023 03:58:02 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5bcfc508d14so2803268a12.3; 
 Mon, 27 Nov 2023 00:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701075461; x=1701680261; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wxu8fnOR3bRYjaWrjbiEIYAc8Ovilupp+SR6wMFCXwI=;
 b=WXXgysobnQ86E06iUSKcd1Zl+lR+nI7jqX/1DTLeMfZC7vKH+do5oVrjTjXI4MxUiO
 U09D6zhE/bWkSrmZ890UvTRcP5ydqvV94DBMeKwOolI5c8Nkk/YO1v7JxsGgjRJSBeAH
 /VRoHvOZHdp9Gy9fPpms44hWeGH9iVYe/HbJwg6V/mlLO9eGkEO2jEGNFkcHrpw8+iJl
 RSkxXxsuJHY8YnHqpcx10/IXOGL7GKAWaiXRjCblKaP7oCCwxS+6QKjXyfe74emiPZ3M
 cH2FdQ5lbdUxWqXzRpZwy/tzIcBSDHEwActizDzkasckq2wolp46IaqnKx151hjd+bsD
 aU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701075461; x=1701680261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wxu8fnOR3bRYjaWrjbiEIYAc8Ovilupp+SR6wMFCXwI=;
 b=ph80i/sZSTFSikT1KGdQg2ymo4/TMLy9pYT/ZJ9StA6kSa6anFvo5ygyKy3yeZXhT7
 1mxesUvuJkxHHQH5xyedI5tsimEf9uqKiUdPVW+auYcxcYqFYVgxTRZNTwPF77pq6nP1
 UozqtKbMDzugBxp/MVSJHMU1ncG1vYKmjmDVNysJgNn0xsJyq6GHRz0e7hCXJ8U77Cxk
 q1hvu6dIRhT+8BqKJSYDfHkUbYsVuTNvM+OseeZ2V6eNTmBuJOpj/EJpFb9/551ExnXD
 DOS4Djfppebb+oZ87dkGOmz6GsDnE2+nKFYl8E4fNV9rdQCkPN87Oxq5W/zkW+7PaCb9
 38UA==
X-Gm-Message-State: AOJu0YwKjXjcg5+KlL/AWfB6pH+CWTDb0LwZ0gSaRVj7Z45hJZ/OIuAn
 pepycJ5fEy0FX6RMI3vXM+OfwnBvVPlolQ==
X-Google-Smtp-Source: AGHT+IF89SnoeL4yLPhkcef0IyoXE135ulceZtGHIxdwDpRHQC8dN837B6PwWnYS8ijHGxtv3bpdBQ==
X-Received: by 2002:a17:90b:4a0b:b0:283:2873:8882 with SMTP id
 kk11-20020a17090b4a0b00b0028328738882mr12455604pjb.10.1701075460817; 
 Mon, 27 Nov 2023 00:57:40 -0800 (PST)
Received: from fedlinux.. ([106.84.128.244]) by smtp.gmail.com with ESMTPSA id
 ci8-20020a17090afc8800b0027d0adf653bsm6906901pjb.7.2023.11.27.00.57.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 00:57:40 -0800 (PST)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Klaus Jensen <its@irrelevant.dk>,
 qemu-block@nongnu.org, hare@suse.de, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>, Hanna Reitz <hreitz@redhat.com>,
 dmitry.fomichev@wdc.com, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 dlemoal@kernel.org, Sam Li <faithilikerun@gmail.com>
Subject: [RFC v2 2/7] qcow2: add zd_extension configurations to zoned metadata
Date: Mon, 27 Nov 2023 16:56:36 +0800
Message-Id: <20231127085641.3729-3-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231127085641.3729-1-faithilikerun@gmail.com>
References: <20231127085641.3729-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=faithilikerun@gmail.com; helo=mail-pg1-x534.google.com
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

Zone descriptor data is host definied data that is associated with
each zone. Add zone descriptor extensions to zonedmeta struct.

Signed-off-by: Sam Li <faithilikerun@gmail.com>
---
 block/qcow2.c                    | 69 +++++++++++++++++++++++++++++---
 block/qcow2.h                    |  2 +
 include/block/block_int-common.h |  6 +++
 qapi/block-core.json             |  4 ++
 4 files changed, 76 insertions(+), 5 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 26f2bb4a87..75dff27216 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -354,7 +354,8 @@ static inline int qcow2_refresh_zonedmeta(BlockDriverState *bs)
 {
     int ret;
     BDRVQcow2State *s = bs->opaque;
-    uint64_t wps_size = s->zoned_header.zonedmeta_size;
+    uint64_t wps_size = s->zoned_header.zonedmeta_size -
+        s->zded_size;
     g_autofree uint64_t *temp = NULL;
     temp = g_new(uint64_t, wps_size);
     ret = bdrv_pread(bs->file, s->zoned_header.zonedmeta_offset,
@@ -364,7 +365,17 @@ static inline int qcow2_refresh_zonedmeta(BlockDriverState *bs)
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
 
@@ -390,6 +401,19 @@ qcow2_check_zone_options(Qcow2ZonedHeaderExtension *zone_opt)
             return false;
         }
 
+        if (zone_opt->zd_extension_size) {
+            if (zone_opt->zd_extension_size & 0x3f) {
+                error_report("zone descriptor extension size must be a "
+                             "multiple of 64B");
+                return false;
+            }
+
+            if ((zone_opt->zd_extension_size >> 6) > 0xff) {
+                error_report("Zone descriptor extension size is too large");
+                return false;
+            }
+        }
+
         if (zone_opt->max_active_zones > zone_opt->nr_zones) {
             error_report("Max_active_zones %" PRIu32 " exceeds "
                          "nr_zones %" PRIu32". Set it to nr_zones.",
@@ -676,6 +700,8 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
             zoned_ext.conventional_zones =
                 be32_to_cpu(zoned_ext.conventional_zones);
             zoned_ext.nr_zones = be32_to_cpu(zoned_ext.nr_zones);
+            zoned_ext.zd_extension_size =
+                be32_to_cpu(zoned_ext.zd_extension_size);
             zoned_ext.max_open_zones = be32_to_cpu(zoned_ext.max_open_zones);
             zoned_ext.max_active_zones =
                 be32_to_cpu(zoned_ext.max_active_zones);
@@ -686,7 +712,8 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
             zoned_ext.zonedmeta_size = be64_to_cpu(zoned_ext.zonedmeta_size);
             s->zoned_header = zoned_ext;
             bs->wps = g_malloc(sizeof(BlockZoneWps)
-                + s->zoned_header.zonedmeta_size);
+                + zoned_ext.zonedmeta_size - s->zded_size);
+            bs->zd_extensions = g_malloc0(s->zded_size);
             ret = qcow2_refresh_zonedmeta(bs);
             if (ret < 0) {
                 error_setg_errno(errp, -ret, "zonedmeta: "
@@ -2264,6 +2291,7 @@ static void qcow2_refresh_limits(BlockDriverState *bs, Error **errp)
     bs->bl.zone_size = s->zoned_header.zone_size;
     bs->bl.zone_capacity = s->zoned_header.zone_capacity;
     bs->bl.write_granularity = BDRV_SECTOR_SIZE;
+    bs->bl.zd_extension_size = s->zoned_header.zd_extension_size;
 }
 
 static int GRAPH_UNLOCKED
@@ -3534,6 +3562,8 @@ int qcow2_update_header(BlockDriverState *bs)
             .conventional_zones =
                 cpu_to_be32(s->zoned_header.conventional_zones),
             .nr_zones           = cpu_to_be32(s->zoned_header.nr_zones),
+            .zd_extension_size  =
+                cpu_to_be32(s->zoned_header.zd_extension_size),
             .max_open_zones     = cpu_to_be32(s->zoned_header.max_open_zones),
             .max_active_zones   =
                 cpu_to_be32(s->zoned_header.max_active_zones),
@@ -4287,6 +4317,15 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
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
@@ -4294,7 +4333,7 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
         }
 
         uint32_t nrz = s->zoned_header.nr_zones;
-        zoned_meta_size =  sizeof(uint64_t) * nrz;
+        zoned_meta_size =  sizeof(uint64_t) * nrz + zded_size;
         g_autofree uint64_t *meta = NULL;
         meta = g_new0(uint64_t, nrz);
 
@@ -4326,11 +4365,24 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
             error_setg_errno(errp, -ret, "Could not zero fill zoned metadata");
             goto out;
         }
-        ret = bdrv_pwrite(blk_bs(blk)->file, offset, zoned_meta_size, meta, 0);
+
+        ret = bdrv_pwrite(blk_bs(blk)->file, offset,
+                          zoned_meta_size - zded_size, meta, 0);
         if (ret < 0) {
             error_setg_errno(errp, -ret, "Could not write zoned metadata "
                                          "to disk");
         }
+
+        if (zone_host_managed->has_descriptor_extension_size) {
+            /* Initialize zone descriptor extensions */
+            ret = bdrv_co_pwrite_zeroes(blk_bs(blk)->file, offset + zded_size,
+                                        zded_size, 0);
+            if (ret < 0) {
+                error_setg_errno(errp, -ret, "Could not write zone descriptor"
+                                             "extensions to disk");
+                goto out;
+            }
+        }
     } else {
         s->zoned_header.zoned = BLK_Z_NONE;
     }
@@ -4472,6 +4524,7 @@ qcow2_co_create_opts(BlockDriver *drv, const char *filename, QemuOpts *opts,
         { BLOCK_OPT_MAX_OPEN_ZONES,     "zone.max-open-zones" },
         { BLOCK_OPT_MAX_ACTIVE_ZONES,   "zone.max-active-zones" },
         { BLOCK_OPT_MAX_APPEND_BYTES,   "zone.max-append-bytes" },
+        { BLOCK_OPT_ZD_EXT_SIZE,        "zone.descriptor-extension-size" },
         { NULL, NULL },
     };
 
@@ -7061,7 +7114,13 @@ static QemuOptsList qcow2_create_opts = {
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
index 0d231bd1f7..c649f1ca75 100644
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
@@ -1270,6 +1274,8 @@ struct BlockDriverState {
 
     /* array of write pointers' location of each zone in the zoned device. */
     BlockZoneWps *wps;
+
+    uint8_t *zd_extensions;
 };
 
 struct BlockBackendRootState {
diff --git a/qapi/block-core.json b/qapi/block-core.json
index ef98dc83a0..a7f238371c 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -5074,12 +5074,16 @@
 #     append request that can be issued to the device.  It must be
 #     512-byte aligned
 #
+# @descriptor-extension-size: The size of zone descriptor extension
+#     data. Must be a multiple of 64 bytes (since 8.2)
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
             '*max-append-bytes':   'uint32' } }
-- 
2.40.1


