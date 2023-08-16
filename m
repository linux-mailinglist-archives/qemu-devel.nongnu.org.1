Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EB477DA9F
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 08:48:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWAJh-0000vs-E4; Wed, 16 Aug 2023 02:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qWAJJ-0000ty-Dm; Wed, 16 Aug 2023 02:47:19 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qWAJC-000893-RN; Wed, 16 Aug 2023 02:47:16 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-564b8e60ce9so3560583a12.2; 
 Tue, 15 Aug 2023 23:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692168426; x=1692773226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sb5qE0PjZPClWCUTwMHC1op8L5ZY4+0925rtvOL/gZ8=;
 b=BzY586Yt1m7q+WmNrRwTp9myyAafH0/V3aRKBUyD5Bu/hSpI17Y+zCEvVI59q26JjI
 sonB960UhL4I6lJnF8Kp31pQuRcScNqgIN7ZFdr7VKXT1J7uWVZnuwneJ3Uqes2pZMJA
 50jGvRqV0UOMcsBdtXDGUQVO0t0TUjRZVVtjYkQhF5PnanRButz9aEy8sU/iGEruyxGu
 W88eCbPsUYLrWU5kXMMwwFEoHsnGZuGwYw2s5rTUyGomHN9RMPdF6XVsJtGmg5iVOjvT
 UhT5bUvRbSIeMnE91RfD+vf53riujE0WWOQX/eDykUtJPO/IXMLyMdimAv2+4QSn44XM
 G6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692168426; x=1692773226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sb5qE0PjZPClWCUTwMHC1op8L5ZY4+0925rtvOL/gZ8=;
 b=OuT8C+y/GTm3RCB7lqCxp1ZPQNg2ovk3mk97pPp5TOtzeTi/qaE28HdD/cw/g/XxxX
 +L4a4Ljs9U5QA59CHgJwMEdN8Vm1mkbfaGn8ft9oKrZEvfylRC6mSdk9vfIBWUbx2vI7
 Xd8Suzu6q/oUOX1fviK2xGnI1zxxsVPLmuWkY85HL1VQKRMDk+6aA2zGHWGXpsB3Myu4
 qUcg1hEohzCsKy22dWtUPDmsxmztghBtmKxxcDVniORvMndq7nKDFVtwaSbWjC9dS6Xd
 ijC/thiI8bcINXzhVSiLha1rVSSeaUrnBiiNi70rFtNAGuISefEyuXPVg3+M0lm2eZVD
 jSFg==
X-Gm-Message-State: AOJu0YxxsejH94gWw/7u0DUNavf5nEmKKw1T7aBCfgEbMPVFh0dKPXV1
 Z6njCUZX6THNOZoQ0IGvn0C23rs/3TXNFDFysgE=
X-Google-Smtp-Source: AGHT+IFZHuuGkmYzvem0+xjms25qHaPcIY+XqM0E0E5hM9qOEScjxpxCX1LTKvag+xkIYYLd99Z4mw==
X-Received: by 2002:a05:6a20:3d94:b0:13f:9cee:ff2b with SMTP id
 s20-20020a056a203d9400b0013f9ceeff2bmr1000389pzi.17.1692168425956; 
 Tue, 15 Aug 2023 23:47:05 -0700 (PDT)
Received: from fedlinux.. ([106.84.130.68]) by smtp.gmail.com with ESMTPSA id
 c6-20020a170902c1c600b001bee782a1desm1329363plc.181.2023.08.15.23.46.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 23:47:05 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, stefanha@redhat.com,
 David Hildenbrand <david@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Hanna Reitz <hreitz@redhat.com>, dmitry.fomichev@wdc.com,
 Eric Blake <eblake@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 dlemoal@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, hare@suse.de,
 qemu-block@nongnu.org, Sam Li <faithilikerun@gmail.com>
Subject: [RFC 2/5] qcow2: add zone device metadata with zd_extension
Date: Wed, 16 Aug 2023 14:46:14 +0800
Message-Id: <20230816064617.3310-3-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230816064617.3310-1-faithilikerun@gmail.com>
References: <20230816064617.3310-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=faithilikerun@gmail.com; helo=mail-pg1-x534.google.com
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

Zone descriptor data is host definied data that is associated with
each zone. Add zone descriptor extensions to zonedmeta and
blk_get_zone_extension to access zd_extensions.

Signed-off-by: Sam Li <faithilikerun@gmail.com>
---
 block/block-backend.c             | 15 ++++++
 block/qcow2.c                     | 86 ++++++++++++++++++++++++++-----
 block/qcow2.h                     |  3 ++
 docs/interop/qcow2.txt            |  2 +
 hw/nvme/ctrl.c                    | 19 ++++---
 hw/nvme/ns.c                      | 24 ++-------
 hw/nvme/nvme.h                    |  7 ---
 include/block/block_int-common.h  |  6 +++
 include/sysemu/block-backend-io.h |  2 +
 qapi/block-core.json              |  3 ++
 10 files changed, 121 insertions(+), 46 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index ad410286a0..f68c5263f3 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2418,6 +2418,21 @@ uint32_t blk_get_max_append_sectors(BlockBackend *blk)
     return bs ? bs->bl.max_append_sectors : 0;
 }
 
+uint8_t *blk_get_zone_extension(BlockBackend *blk) {
+    BlockDriverState * bs = blk_bs(blk);
+    IO_CODE();
+
+    return bs ? bs->zd_extensions : NULL;
+}
+
+uint32_t blk_get_zd_ext_size(BlockBackend *blk)
+{
+    BlockDriverState *bs = blk_bs(blk);
+    IO_CODE();
+
+    return bs ? bs->bl.zd_extension_size : 0;
+}
+
 void *blk_try_blockalign(BlockBackend *blk, size_t size)
 {
     IO_CODE();
diff --git a/block/qcow2.c b/block/qcow2.c
index 9de90ccc9f..fce1fe83a7 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -340,15 +340,28 @@ static inline int qcow2_refresh_zonedmeta(BlockDriverState *bs)
 {
     int ret;
     BDRVQcow2State *s = bs->opaque;
-    uint64_t *temp = g_malloc(s->zoned_header.zonedmeta_size);
+    uint64_t wps_size = s->zoned_header.zonedmeta_size -
+        s->zded_size;
+    g_autofree uint64_t *temp = NULL;
+    temp = g_new(uint64_t, wps_size);
     ret = bdrv_pread(bs->file, s->zoned_header.zonedmeta_offset,
-                     s->zoned_header.zonedmeta_size, temp, 0);
+                     wps_size, temp, 0);
     if (ret < 0) {
-        error_report("Can not read metadata\n");
+        error_report("Can not read metadata");
         return ret;
     }
 
-    memcpy(s->wps->wp, temp, s->zoned_header.zonedmeta_size);
+    g_autofree uint8_t *zded = NULL;
+    zded = g_try_malloc0(s->zded_size);
+    ret = bdrv_pread(bs->file, s->zoned_header.zonedmeta_offset + wps_size,
+                     s->zded_size, zded, 0);
+    if (ret < 0) {
+        error_report("Can not read zded");
+        return ret;
+    }
+
+    memcpy(s->wps->wp, temp, wps_size);
+    memcpy(bs->zd_extensions, zded, s->zded_size);
     return 0;
 }
 
@@ -607,6 +620,8 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
 
             zoned_ext.zone_size = be32_to_cpu(zoned_ext.zone_size);
             zoned_ext.zone_capacity = be32_to_cpu(zoned_ext.zone_capacity);
+            zoned_ext.zd_extension_size =
+                be32_to_cpu(zoned_ext.zd_extension_size);
             zoned_ext.nr_zones = be32_to_cpu(zoned_ext.nr_zones);
             zoned_ext.zone_nr_conv = be32_to_cpu(zoned_ext.zone_nr_conv);
             zoned_ext.max_open_zones = be32_to_cpu(zoned_ext.max_open_zones);
@@ -618,8 +633,10 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
                 be64_to_cpu(zoned_ext.zonedmeta_offset);
             zoned_ext.zonedmeta_size = be64_to_cpu(zoned_ext.zonedmeta_size);
             s->zoned_header = zoned_ext;
+
             s->wps = g_malloc(sizeof(BlockZoneWps)
-                    + s->zoned_header.zonedmeta_size);
+                + zoned_ext.zonedmeta_size - s->zded_size);
+            bs->zd_extensions = g_malloc0(s->zded_size);
             ret = qcow2_refresh_zonedmeta(bs);
             if (ret < 0) {
                 error_setg_errno(errp, -ret, "zonedmeta: "
@@ -2174,6 +2191,7 @@ static void qcow2_refresh_limits(BlockDriverState *bs, Error **errp)
     bs->bl.zoned = s->zoned_header.zoned;
     bs->bl.zoned_profile = s->zoned_header.zoned_profile;
     bs->bl.zone_capacity = s->zoned_header.zone_capacity;
+    bs->bl.zd_extension_size = s->zoned_header.zd_extension_size;
     bs->bl.nr_zones = s->zoned_header.nr_zones;
     bs->wps = s->wps;
     bs->bl.max_append_sectors = s->zoned_header.max_append_sectors;
@@ -3369,6 +3387,8 @@ int qcow2_update_header(BlockDriverState *bs)
             .nr_zones           = cpu_to_be32(s->zoned_header.nr_zones),
             .zone_size          = cpu_to_be32(s->zoned_header.zone_size),
             .zone_capacity      = cpu_to_be32(s->zoned_header.zone_capacity),
+            .zd_extension_size  =
+                cpu_to_be32(s->zoned_header.zd_extension_size),
             .zone_nr_conv       = cpu_to_be32(s->zoned_header.zone_nr_conv),
             .max_open_zones     = cpu_to_be32(s->zoned_header.max_open_zones),
             .max_active_zones   =
@@ -4075,13 +4095,8 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
 
     if (qcow2_opts->zoned_profile) {
         BDRVQcow2State *s = blk_bs(blk)->opaque;
-        if (!strcmp(qcow2_opts->zoned_profile, "zbc")) {
-            s->zoned_header.zoned_profile = BLK_ZP_ZBC;
-            s->zoned_header.zone_capacity = qcow2_opts->zone_size;
-        } else if (!strcmp(qcow2_opts->zoned_profile, "zns")) {
-            s->zoned_header.zoned_profile = BLK_ZP_ZNS;
-            s->zoned_header.zone_capacity = qcow2_opts->zone_capacity;
-        }
+        uint64_t zded_size = 0;
+
         s->zoned_header.zoned = BLK_Z_HM;
         s->zoned_header.zone_size = qcow2_opts->zone_size;
         s->zoned_header.zone_nr_conv = qcow2_opts->zone_nr_conv;
@@ -4119,6 +4134,33 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
             meta[i] |= ((uint64_t)BLK_ZS_EMPTY << 60);
         }
 
+        if (!g_strcmp0(qcow2_opts->zoned_profile, "zbc")) {
+            s->zoned_header.zoned_profile = BLK_ZP_ZBC;
+            s->zoned_header.zone_capacity = qcow2_opts->zone_size;
+        } else if (!g_strcmp0(qcow2_opts->zoned_profile, "zns")) {
+            s->zoned_header.zoned_profile = BLK_ZP_ZNS;
+            s->zoned_header.zone_capacity = qcow2_opts->zone_capacity;
+
+            if (qcow2_opts->zd_extension_size) {
+                if (qcow2_opts->zd_extension_size & 0x3f) {
+                    error_setg(errp, "zone descriptor extension size must be a "
+                               "multiple of 64B");
+                    return -1;
+                }
+                if ((qcow2_opts->zd_extension_size >> 6) > 0xff) {
+                    error_setg(errp,
+                               "zone descriptor extension size is too large");
+                    return -1;
+                }
+            }
+            s->zoned_header.zd_extension_size = qcow2_opts->zd_extension_size;
+
+            zded_size = s->zoned_header.zd_extension_size *
+                s->zoned_header.nr_zones;
+        }
+        s->zded_size = zded_size;
+        zoned_meta_size += zded_size;
+
         offset = qcow2_alloc_clusters(blk_bs(blk), zoned_meta_size);
         if (offset < 0) {
             error_setg_errno(errp, -offset, "Could not allocate clusters "
@@ -4138,12 +4180,23 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
             error_setg_errno(errp, -ret, "Could not zero fill zoned metadata");
             goto out;
         }
-        ret = bdrv_pwrite(blk_bs(blk)->file, offset, zoned_meta_size, meta, 0);
+        ret = bdrv_pwrite(blk_bs(blk)->file, offset,
+                          zoned_meta_size - zded_size, meta, 0);
         if (ret < 0) {
             error_setg_errno(errp, -ret, "Could not write zoned metadata "
                                          "to disk");
             goto out;
         }
+        if (s->zoned_header.zoned_profile == BLK_ZP_ZNS) {
+            /* Initialize zone descriptor extensions */
+            ret = bdrv_co_pwrite_zeroes(blk_bs(blk)->file, offset + zded_size,
+                                        zded_size, 0);
+            if (ret < 0) {
+                error_setg_errno(errp, -ret, "Could not write zone descriptor"
+                                             "extensions to disk");
+                goto out;
+            }
+        }
     }
 
     /* Create a full header (including things like feature table) */
@@ -4290,6 +4343,7 @@ qcow2_co_create_opts(BlockDriver *drv, const char *filename, QemuOpts *opts,
         { BLOCK_OPT_Z_MAS,              "max-append-sectors"},
         { BLOCK_OPT_Z_SIZE,             "zone-size"},
         { BLOCK_OPT_Z_CAP,              "zone-capacity"},
+        { BLOCK_OPT_Z_DEXTSIZE,          "zd-extension-size"},
         { NULL, NULL },
     };
 
@@ -6856,6 +6910,12 @@ static QemuOptsList qcow2_create_opts = {
             .type = QEMU_OPT_SIZE,                                      \
             .help = "zone capacity",                                    \
         },                                                              \
+        {                                                               \
+                .name = BLOCK_OPT_Z_DEXTSIZE,                           \
+                .type = QEMU_OPT_SIZE,                                  \
+                .help = "zone descriptor extension size (defaults "     \
+                        "to 0, must be a multiple of 64 bytes)",        \
+        },                                                              \
         {                                                               \
                 .name = BLOCK_OPT_Z_NR_COV,                             \
                 .type = QEMU_OPT_NUMBER,                                \
diff --git a/block/qcow2.h b/block/qcow2.h
index 38b779ae32..254295cfce 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -250,6 +250,8 @@ typedef struct Qcow2ZonedHeaderExtension {
     uint32_t max_append_sectors;
     uint64_t zonedmeta_offset;
     uint64_t zonedmeta_size;
+    uint32_t zd_extension_size; /* must be multiple of 64 B */
+    uint32_t reserved32;
 } QEMU_PACKED Qcow2ZonedHeaderExtension;
 
 typedef struct Qcow2UnknownHeaderExtension {
@@ -445,6 +447,7 @@ typedef struct BDRVQcow2State {
     uint32_t nr_zones_imp_open;
     uint32_t nr_zones_closed;
     BlockZoneWps *wps;
+    uint64_t zded_size;
 } BDRVQcow2State;
 
 typedef struct Qcow2COWRegion {
diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index 739e2c62c6..beb4ead094 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -356,6 +356,8 @@ The fields of the zoned extension are:
           28 - 31:  max_append_sectors
           32 - 39:  zonedmeta_offset
           40 - 47:  zonedmeta_size
+          48 - 51:  zd_extension_size
+          52 - 55:  Reserved, must be zero.
 
 == Full disk encryption header pointer ==
 
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 4e1608f0c1..4320f3a15c 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -4010,6 +4010,12 @@ static uint16_t nvme_zone_mgmt_send_zrwa_flush(NvmeCtrl *n, NvmeZone *zone,
     return NVME_SUCCESS;
 }
 
+static inline uint8_t *nvme_get_zd_extension(NvmeNamespace *ns,
+                                        uint32_t zone_idx)
+{
+    return &ns->zd_extensions[zone_idx * blk_get_zd_ext_size(ns->blkconf.blk)];
+}
+
 static uint16_t nvme_zone_mgmt_send(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeZoneSendCmd *cmd = (NvmeZoneSendCmd *)&req->cmd;
@@ -4094,11 +4100,11 @@ static uint16_t nvme_zone_mgmt_send(NvmeCtrl *n, NvmeRequest *req)
 
     case NVME_ZONE_ACTION_SET_ZD_EXT:
         trace_pci_nvme_set_descriptor_extension(slba, zone_idx);
-        if (all || !ns->params.zd_extension_size) {
+        if (all || !blk_get_zd_ext_size(ns->blkconf.blk)) {
             return NVME_INVALID_FIELD | NVME_DNR;
         }
         zd_ext = nvme_get_zd_extension(ns, zone_idx);
-        status = nvme_h2c(n, zd_ext, ns->params.zd_extension_size, req);
+        status = nvme_h2c(n, zd_ext, blk_get_zd_ext_size(ns->blkconf.blk), req);
         if (status) {
             trace_pci_nvme_err_zd_extension_map_error(zone_idx);
             return status;
@@ -4189,7 +4195,7 @@ static uint16_t nvme_zone_mgmt_recv(NvmeCtrl *n, NvmeRequest *req)
     if (zra != NVME_ZONE_REPORT && zra != NVME_ZONE_REPORT_EXTENDED) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
-    if (zra == NVME_ZONE_REPORT_EXTENDED && !ns->params.zd_extension_size) {
+    if (zra == NVME_ZONE_REPORT_EXTENDED && !blk_get_zd_ext_size(ns->blkconf.blk)){
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
@@ -4211,7 +4217,7 @@ static uint16_t nvme_zone_mgmt_recv(NvmeCtrl *n, NvmeRequest *req)
 
     zone_entry_sz = sizeof(NvmeZoneDescr);
     if (zra == NVME_ZONE_REPORT_EXTENDED) {
-        zone_entry_sz += ns->params.zd_extension_size;
+        zone_entry_sz += blk_get_zd_ext_size(ns->blkconf.blk) ;
     }
 
     max_zones = (data_size - sizeof(NvmeZoneReportHeader)) / zone_entry_sz;
@@ -4249,11 +4255,12 @@ static uint16_t nvme_zone_mgmt_recv(NvmeCtrl *n, NvmeRequest *req)
             }
 
             if (zra == NVME_ZONE_REPORT_EXTENDED) {
+                int zd_ext_size = blk_get_zd_ext_size(ns->blkconf.blk);
                 if (zone->d.za & NVME_ZA_ZD_EXT_VALID) {
                     memcpy(buf_p, nvme_get_zd_extension(ns, zone_idx),
-                           ns->params.zd_extension_size);
+                           zd_ext_size);
                 }
-                buf_p += ns->params.zd_extension_size;
+                buf_p += zd_ext_size;
             }
 
             max_zones--;
diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index f076593ada..c9c3a54d36 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -218,15 +218,15 @@ static int nvme_ns_zoned_check_calc_geometry(NvmeNamespace *ns, Error **errp)
 
 static void nvme_ns_zoned_init_state(NvmeNamespace *ns)
 {
+    BlockBackend *blk = ns->blkconf.blk;
     uint64_t start = 0, zone_size = ns->zone_size;
     uint64_t capacity = ns->num_zones * zone_size;
     NvmeZone *zone;
     int i;
 
     ns->zone_array = g_new0(NvmeZone, ns->num_zones);
-    if (ns->params.zd_extension_size) {
-        ns->zd_extensions = g_malloc0(ns->params.zd_extension_size *
-                                      ns->num_zones);
+    if (blk_get_zone_extension(blk)) {
+        ns->zd_extensions = blk_get_zone_extension(blk);
     }
 
     QTAILQ_INIT(&ns->exp_open_zones);
@@ -275,7 +275,7 @@ static void nvme_ns_init_zoned(NvmeNamespace *ns)
     for (i = 0; i <= ns->id_ns.nlbaf; i++) {
         id_ns_z->lbafe[i].zsze = cpu_to_le64(ns->zone_size);
         id_ns_z->lbafe[i].zdes =
-            ns->params.zd_extension_size >> 6; /* Units of 64B */
+            blk_get_zd_ext_size(blk) >> 6; /* Units of 64B */
     }
 
     if (ns->params.zrwas) {
@@ -577,19 +577,6 @@ static int nvme_ns_check_constraints(NvmeNamespace *ns, Error **errp)
     }
 
     if (blk_get_zone_model(blk)) {
-        if (ns->params.zd_extension_size) {
-            if (ns->params.zd_extension_size & 0x3f) {
-                error_setg(errp, "zone descriptor extension size must be a "
-                           "multiple of 64B");
-                return -1;
-            }
-            if ((ns->params.zd_extension_size >> 6) > 0xff) {
-                error_setg(errp,
-                           "zone descriptor extension size is too large");
-                return -1;
-            }
-        }
-
         if (ns->params.zrwas) {
             if (ns->params.zrwas % ns->blkconf.logical_block_size) {
                 error_setg(errp, "zone random write area size (zoned.zrwas "
@@ -677,7 +664,6 @@ void nvme_ns_cleanup(NvmeNamespace *ns)
     if (blk_get_zone_model(ns->blkconf.blk)) {
         g_free(ns->id_ns_zoned);
         g_free(ns->zone_array);
-        g_free(ns->zd_extensions);
     }
 
     if (ns->endgrp && ns->endgrp->fdp.enabled) {
@@ -795,8 +781,6 @@ static Property nvme_ns_props[] = {
                        params.max_active_zones, 0),
     DEFINE_PROP_UINT32("zoned.max_open", NvmeNamespace,
                        params.max_open_zones, 0),
-    DEFINE_PROP_UINT32("zoned.descr_ext_size", NvmeNamespace,
-                       params.zd_extension_size, 0),
     DEFINE_PROP_UINT32("zoned.numzrwa", NvmeNamespace, params.numzrwa, 0),
     DEFINE_PROP_SIZE("zoned.zrwas", NvmeNamespace, params.zrwas, 0),
     DEFINE_PROP_SIZE("zoned.zrwafg", NvmeNamespace, params.zrwafg, -1),
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 76677a86e9..37007952fc 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -192,7 +192,6 @@ typedef struct NvmeNamespaceParams {
     bool     cross_zone_read;
     uint32_t max_active_zones;
     uint32_t max_open_zones;
-    uint32_t zd_extension_size;
 
     uint32_t numzrwa;
     uint64_t zrwas;
@@ -315,12 +314,6 @@ static inline bool nvme_wp_is_valid(NvmeZone *zone)
            st != NVME_ZONE_STATE_OFFLINE;
 }
 
-static inline uint8_t *nvme_get_zd_extension(NvmeNamespace *ns,
-                                             uint32_t zone_idx)
-{
-    return &ns->zd_extensions[zone_idx * ns->params.zd_extension_size];
-}
-
 static inline void nvme_aor_inc_open(NvmeNamespace *ns)
 {
     assert(ns->nr_open_zones >= 0);
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 1dbe820a9b..e16dfe8581 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -61,6 +61,7 @@
 #define BLOCK_OPT_Z_MODEL           "zoned"
 #define BLOCK_OPT_Z_SIZE            "zone_size"
 #define BLOCK_OPT_Z_CAP             "zone_capacity"
+#define BLOCK_OPT_Z_DEXTSIZE        "zd_extension_size"
 #define BLOCK_OPT_Z_NR_COV          "zone_nr_conv"
 #define BLOCK_OPT_Z_MAS             "max_append_sectors"
 #define BLOCK_OPT_Z_MAZ             "max_active_zones"
@@ -907,6 +908,9 @@ typedef struct BlockLimits {
     uint32_t max_active_zones;
 
     uint32_t write_granularity;
+
+    /* size of data that is associated with a zone in bytes */
+    uint32_t zd_extension_size;
 } BlockLimits;
 
 typedef struct BdrvOpBlocker BdrvOpBlocker;
@@ -1265,6 +1269,8 @@ struct BlockDriverState {
 
     /* array of write pointers' location of each zone in the zoned device. */
     BlockZoneWps *wps;
+
+    uint8_t *zd_extensions;
 };
 
 struct BlockBackendRootState {
diff --git a/include/sysemu/block-backend-io.h b/include/sysemu/block-backend-io.h
index 3be221e752..c56ed29c8f 100644
--- a/include/sysemu/block-backend-io.h
+++ b/include/sysemu/block-backend-io.h
@@ -106,6 +106,8 @@ uint32_t blk_get_zone_capacity(BlockBackend *blk);
 uint32_t blk_get_max_open_zones(BlockBackend *blk);
 uint32_t blk_get_max_active_zones(BlockBackend *blk);
 uint32_t blk_get_max_append_sectors(BlockBackend *blk);
+uint8_t *blk_get_zone_extension(BlockBackend *blk);
+uint32_t blk_get_zd_ext_size(BlockBackend *blk);
 
 void blk_io_plug(void);
 void blk_io_unplug(void);
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 0c97ae678b..f71dd18fc3 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -5024,6 +5024,8 @@
 #                 (default: off, since 8.0)
 # @zone-size: The size of a zone of the zoned device (since 8.0)
 # @zone-capacity: The capacity of a zone of the zoned device (since 8.0)
+# @zd-extension-size: Zone descriptor extension size. Must be a multiple of
+#                     64 bytes (since 8.0)
 # @zone-nr-conv: The number of conventional zones of the zoned device
 #                (since 8.0)
 # @max-open-zones: The maximal allowed open zones (since 8.0)
@@ -5052,6 +5054,7 @@
             '*zoned-profile':      'str',
             '*zone-size':          'size',
             '*zone-capacity':      'size',
+            '*zd-extension-size':  'size',
             '*zone-nr-conv':       'uint32',
             '*max-open-zones':     'uint32',
             '*max-active-zones':   'uint32',
-- 
2.40.1


