Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A320D77DAA0
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 08:48:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWAJN-0000sZ-CD; Wed, 16 Aug 2023 02:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qWAJ2-0000oJ-7Q; Wed, 16 Aug 2023 02:47:01 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qWAIz-00086t-3o; Wed, 16 Aug 2023 02:46:59 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bdf7086ae5so13276415ad.0; 
 Tue, 15 Aug 2023 23:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692168415; x=1692773215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CPRNnhdfxUqFe1MV8/rcvlcRFuDBQqjGT/C3sNgciRM=;
 b=DmSvrkFMwc2rVuN3lPfIMvs7ofTE5SbFY/wHHNKcMfxN6gb4KfkCOikg8b61ApVjDp
 fYSusKKZylQ5pa7GJzf4cHcTA/PjGK5eW3TNkPnw1EM1L+KZpgv9luvQFR0oShyyNAv1
 59WHR/cNA9yyW9xYmfIiTGMgh0iBDtN1evHYLNybXgWUVvURsnXOotvdznTZ5XTKRk9N
 zXPNjdA4AFNhCRBJ1yhPUXqV7IGMWoqZzt8/1Z4kxrmL+5z/oVsTGu/bJwOvkbfL2AlZ
 Id7yW1ltkcAa57gTYfX0u/N5mgM4TevmC4NBmlBtq4US5ohe7Oa2LLysVyRUOKG+XZVJ
 l57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692168415; x=1692773215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CPRNnhdfxUqFe1MV8/rcvlcRFuDBQqjGT/C3sNgciRM=;
 b=CmsQBDxjgtXYPaHmAG9ythB/Vn0rnjOVW0uKAcPRLQGovOs7bxVX/B3zygBoddzatU
 bP6UvhzncGcshJmVyKURUHDTQbND62Q/4n7Un2tAYQrg0ttnOyIdE3i3pTr8ixV4zlmb
 Csm3v+9zQK65ElqvIbDRj7DLiJe9WB3UxgR5u9zApRoCC0xmT6PlRToe/O7JUaJtlk2M
 0sd8eWDv0jfcTm3p5P+L7cm0NrULXGgaWVq0aoUlnAJAeOx8Pv2vFXq+8bFJBFnABVy/
 dwBTCOA2iJfnDWeAjWiopnpyu3/TTVktZXlImLchWhHskiHBczCiac67Yq74PP36CPof
 ohAw==
X-Gm-Message-State: AOJu0YyZ/irsULqbF/gQi7IiWxgNnrFtwwB6vambTbxtSMAECa0d00W/
 AAkdk7hJaoupspYBXVi9rgvavHxpXfyx2syRcu0=
X-Google-Smtp-Source: AGHT+IEeYRnB8jOFiUnr3fepPpLgxxeTe/PJOUrvA+tn3Nb/NNc180FtizhJU9yDN24b0uPHUql4/g==
X-Received: by 2002:a17:902:da87:b0:1bc:98dd:e872 with SMTP id
 j7-20020a170902da8700b001bc98dde872mr1448739plx.29.1692168414537; 
 Tue, 15 Aug 2023 23:46:54 -0700 (PDT)
Received: from fedlinux.. ([106.84.130.68]) by smtp.gmail.com with ESMTPSA id
 c6-20020a170902c1c600b001bee782a1desm1329363plc.181.2023.08.15.23.46.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 23:46:54 -0700 (PDT)
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
Subject: [RFC 1/5] hw/nvme: use blk_get_*() to access zone info in the block
 layer
Date: Wed, 16 Aug 2023 14:46:13 +0800
Message-Id: <20230816064617.3310-2-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230816064617.3310-1-faithilikerun@gmail.com>
References: <20230816064617.3310-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=faithilikerun@gmail.com; helo=mail-pl1-x62d.google.com
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

The zone information is contained in the BlockLimits fileds. Add blk_get_*() functions
to access the block layer and update zone info accessing in the NVMe device emulation.

Signed-off-by: Sam Li <faithilikerun@gmail.com>
---
 block/block-backend.c             | 56 ++++++++++++++++++++++++++++
 block/qcow2.c                     | 20 +++++++++-
 hw/nvme/ctrl.c                    | 34 ++++++-----------
 hw/nvme/ns.c                      | 62 ++++++++++---------------------
 hw/nvme/nvme.h                    |  3 --
 include/sysemu/block-backend-io.h |  7 ++++
 6 files changed, 112 insertions(+), 70 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 4009ed5fed..ad410286a0 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2362,6 +2362,62 @@ int blk_get_max_iov(BlockBackend *blk)
     return blk->root->bs->bl.max_iov;
 }
 
+uint8_t blk_get_zone_model(BlockBackend *blk)
+{
+    BlockDriverState *bs = blk_bs(blk);
+    IO_CODE();
+    return bs ? bs->bl.zoned: 0;
+
+}
+
+uint8_t blk_get_zone_profile(BlockBackend *blk)
+{
+    BlockDriverState *bs = blk_bs(blk);
+    IO_CODE();
+    return bs ? bs->bl.zoned_profile: 0;
+
+}
+
+uint32_t blk_get_zone_size(BlockBackend *blk)
+{
+    BlockDriverState *bs = blk_bs(blk);
+    IO_CODE();
+
+    return bs ? bs->bl.zone_size : 0;
+}
+
+uint32_t blk_get_zone_capacity(BlockBackend *blk)
+{
+    BlockDriverState *bs = blk_bs(blk);
+    IO_CODE();
+
+    return bs ? bs->bl.zone_capacity : 0;
+}
+
+uint32_t blk_get_max_open_zones(BlockBackend *blk)
+{
+    BlockDriverState *bs = blk_bs(blk);
+    IO_CODE();
+
+    return bs ? bs->bl.max_open_zones : 0;
+}
+
+uint32_t blk_get_max_active_zones(BlockBackend *blk)
+{
+    BlockDriverState *bs = blk_bs(blk);
+    IO_CODE();
+
+    return bs ? bs->bl.max_active_zones : 0;
+}
+
+uint32_t blk_get_max_append_sectors(BlockBackend *blk)
+{
+    BlockDriverState *bs = blk_bs(blk);
+    IO_CODE();
+
+    return bs ? bs->bl.max_append_sectors : 0;
+}
+
 void *blk_try_blockalign(BlockBackend *blk, size_t size)
 {
     IO_CODE();
diff --git a/block/qcow2.c b/block/qcow2.c
index 5ccf79cbe7..9de90ccc9f 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2172,6 +2172,8 @@ static void qcow2_refresh_limits(BlockDriverState *bs, Error **errp)
     bs->bl.pwrite_zeroes_alignment = s->subcluster_size;
     bs->bl.pdiscard_alignment = s->cluster_size;
     bs->bl.zoned = s->zoned_header.zoned;
+    bs->bl.zoned_profile = s->zoned_header.zoned_profile;
+    bs->bl.zone_capacity = s->zoned_header.zone_capacity;
     bs->bl.nr_zones = s->zoned_header.nr_zones;
     bs->wps = s->wps;
     bs->bl.max_append_sectors = s->zoned_header.max_append_sectors;
@@ -4083,8 +4085,22 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
         s->zoned_header.zoned = BLK_Z_HM;
         s->zoned_header.zone_size = qcow2_opts->zone_size;
         s->zoned_header.zone_nr_conv = qcow2_opts->zone_nr_conv;
-        s->zoned_header.max_open_zones = qcow2_opts->max_open_zones;
-        s->zoned_header.max_active_zones = qcow2_opts->max_active_zones;
+
+        if (!qcow2_opts->max_active_zones) {
+            if (qcow2_opts->max_open_zones > qcow2_opts->max_active_zones) {
+                error_setg(errp, "max_open_zones (%u) exceeds "
+                           "max_active_zones (%u)", qcow2_opts->max_open_zones,
+                           qcow2_opts->max_active_zones);
+                return -1;
+            }
+
+            if (!qcow2_opts->max_open_zones) {
+                s->zoned_header.max_open_zones = qcow2_opts->max_active_zones;
+            }
+            s->zoned_header.max_open_zones = qcow2_opts->max_open_zones;
+            s->zoned_header.max_active_zones = qcow2_opts->max_active_zones;
+        }
+
         s->zoned_header.max_append_sectors = qcow2_opts->max_append_sectors;
         s->zoned_header.nr_zones = qcow2_opts->size / qcow2_opts->zone_size;
 
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 539d273553..4e1608f0c1 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -417,18 +417,6 @@ static void nvme_assign_zone_state(NvmeNamespace *ns, NvmeZone *zone,
 static uint16_t nvme_zns_check_resources(NvmeNamespace *ns, uint32_t act,
                                          uint32_t opn, uint32_t zrwa)
 {
-    if (ns->params.max_active_zones != 0 &&
-        ns->nr_active_zones + act > ns->params.max_active_zones) {
-        trace_pci_nvme_err_insuff_active_res(ns->params.max_active_zones);
-        return NVME_ZONE_TOO_MANY_ACTIVE | NVME_DNR;
-    }
-
-    if (ns->params.max_open_zones != 0 &&
-        ns->nr_open_zones + opn > ns->params.max_open_zones) {
-        trace_pci_nvme_err_insuff_open_res(ns->params.max_open_zones);
-        return NVME_ZONE_TOO_MANY_OPEN | NVME_DNR;
-    }
-
     if (zrwa > ns->zns.numzrwa) {
         return NVME_NOZRWA | NVME_DNR;
     }
@@ -1988,9 +1976,9 @@ static uint16_t nvme_zrm_reset(NvmeNamespace *ns, NvmeZone *zone)
 static void nvme_zrm_auto_transition_zone(NvmeNamespace *ns)
 {
     NvmeZone *zone;
+    int moz = blk_get_max_open_zones(ns->blkconf.blk);
 
-    if (ns->params.max_open_zones &&
-        ns->nr_open_zones == ns->params.max_open_zones) {
+    if (moz && ns->nr_open_zones == moz) {
         zone = QTAILQ_FIRST(&ns->imp_open_zones);
         if (zone) {
             /*
@@ -2165,7 +2153,7 @@ void nvme_rw_complete_cb(void *opaque, int ret)
         block_acct_done(stats, acct);
     }
 
-    if (ns->params.zoned && nvme_is_write(req)) {
+    if (blk_get_zone_model(blk) && nvme_is_write(req)) {
         nvme_finalize_zoned_write(ns, req);
     }
 
@@ -2887,7 +2875,7 @@ static void nvme_copy_out_completed_cb(void *opaque, int ret)
         goto out;
     }
 
-    if (ns->params.zoned) {
+    if (blk_get_zone_model(ns->blkconf.blk)) {
         nvme_advance_zone_wp(ns, iocb->zone, nlb);
     }
 
@@ -2999,7 +2987,7 @@ static void nvme_copy_in_completed_cb(void *opaque, int ret)
         goto invalid;
     }
 
-    if (ns->params.zoned) {
+    if (blk_get_zone_model(ns->blkconf.blk)) {
         status = nvme_check_zone_write(ns, iocb->zone, iocb->slba, nlb);
         if (status) {
             goto invalid;
@@ -3093,7 +3081,7 @@ static void nvme_do_copy(NvmeCopyAIOCB *iocb)
         }
     }
 
-    if (ns->params.zoned) {
+    if (blk_get_zone_model(ns->blkconf.blk)) {
         status = nvme_check_zone_read(ns, slba, nlb);
         if (status) {
             goto invalid;
@@ -3169,7 +3157,7 @@ static uint16_t nvme_copy(NvmeCtrl *n, NvmeRequest *req)
 
     iocb->slba = le64_to_cpu(copy->sdlba);
 
-    if (ns->params.zoned) {
+    if (blk_get_zone_model(ns->blkconf.blk)) {
         iocb->zone = nvme_get_zone_by_slba(ns, iocb->slba);
         if (!iocb->zone) {
             status = NVME_LBA_RANGE | NVME_DNR;
@@ -3440,7 +3428,7 @@ static uint16_t nvme_read(NvmeCtrl *n, NvmeRequest *req)
         goto invalid;
     }
 
-    if (ns->params.zoned) {
+    if (blk_get_zone_model(blk)) {
         status = nvme_check_zone_read(ns, slba, nlb);
         if (status) {
             trace_pci_nvme_err_zone_read_not_ok(slba, nlb, status);
@@ -3555,7 +3543,7 @@ static uint16_t nvme_do_write(NvmeCtrl *n, NvmeRequest *req, bool append,
         goto invalid;
     }
 
-    if (ns->params.zoned) {
+    if (blk_get_zone_model(blk)) {
         zone = nvme_get_zone_by_slba(ns, slba);
         assert(zone);
 
@@ -3673,7 +3661,7 @@ static uint16_t nvme_get_mgmt_zone_slba_idx(NvmeNamespace *ns, NvmeCmd *c,
     uint32_t dw10 = le32_to_cpu(c->cdw10);
     uint32_t dw11 = le32_to_cpu(c->cdw11);
 
-    if (!ns->params.zoned) {
+    if (blk_get_zone_model(ns->blkconf.blk)) {
         trace_pci_nvme_err_invalid_opc(c->opcode);
         return NVME_INVALID_OPCODE | NVME_DNR;
     }
@@ -6534,7 +6522,7 @@ done:
 
 static uint16_t nvme_format_check(NvmeNamespace *ns, uint8_t lbaf, uint8_t pi)
 {
-    if (ns->params.zoned) {
+    if (blk_get_zone_model(ns->blkconf.blk)) {
         return NVME_INVALID_FORMAT | NVME_DNR;
     }
 
diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 44aba8f4d9..f076593ada 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -25,7 +25,6 @@
 #include "trace.h"
 
 #define MIN_DISCARD_GRANULARITY (4 * KiB)
-#define NVME_DEFAULT_ZONE_SIZE   (128 * MiB)
 
 void nvme_ns_init_format(NvmeNamespace *ns)
 {
@@ -177,19 +176,11 @@ static int nvme_ns_init_blk(NvmeNamespace *ns, Error **errp)
 
 static int nvme_ns_zoned_check_calc_geometry(NvmeNamespace *ns, Error **errp)
 {
-    uint64_t zone_size, zone_cap;
+    BlockBackend *blk = ns->blkconf.blk;
+    uint64_t zone_size = blk_get_zone_size(blk);
+    uint64_t zone_cap = blk_get_zone_capacity(blk);
 
     /* Make sure that the values of ZNS properties are sane */
-    if (ns->params.zone_size_bs) {
-        zone_size = ns->params.zone_size_bs;
-    } else {
-        zone_size = NVME_DEFAULT_ZONE_SIZE;
-    }
-    if (ns->params.zone_cap_bs) {
-        zone_cap = ns->params.zone_cap_bs;
-    } else {
-        zone_cap = zone_size;
-    }
     if (zone_cap > zone_size) {
         error_setg(errp, "zone capacity %"PRIu64"B exceeds "
                    "zone size %"PRIu64"B", zone_cap, zone_size);
@@ -266,6 +257,7 @@ static void nvme_ns_zoned_init_state(NvmeNamespace *ns)
 
 static void nvme_ns_init_zoned(NvmeNamespace *ns)
 {
+    BlockBackend *blk = ns->blkconf.blk;
     NvmeIdNsZoned *id_ns_z;
     int i;
 
@@ -274,8 +266,8 @@ static void nvme_ns_init_zoned(NvmeNamespace *ns)
     id_ns_z = g_new0(NvmeIdNsZoned, 1);
 
     /* MAR/MOR are zeroes-based, FFFFFFFFFh means no limit */
-    id_ns_z->mar = cpu_to_le32(ns->params.max_active_zones - 1);
-    id_ns_z->mor = cpu_to_le32(ns->params.max_open_zones - 1);
+    id_ns_z->mar = cpu_to_le32(blk_get_max_active_zones(blk) - 1);
+    id_ns_z->mor = cpu_to_le32(blk_get_max_open_zones(blk) - 1);
     id_ns_z->zoc = 0;
     id_ns_z->ozcs = ns->params.cross_zone_read ?
         NVME_ID_NS_ZONED_OZCS_RAZB : 0x00;
@@ -539,6 +531,7 @@ static bool nvme_ns_init_fdp(NvmeNamespace *ns, Error **errp)
 
 static int nvme_ns_check_constraints(NvmeNamespace *ns, Error **errp)
 {
+    BlockBackend *blk = ns->blkconf.blk;
     unsigned int pi_size;
 
     if (!ns->blkconf.blk) {
@@ -577,25 +570,13 @@ static int nvme_ns_check_constraints(NvmeNamespace *ns, Error **errp)
         return -1;
     }
 
-    if (ns->params.zoned && ns->endgrp && ns->endgrp->fdp.enabled) {
+    if (blk_get_zone_profile(blk) == BLK_ZP_ZNS && ns->endgrp
+    && ns->endgrp->fdp.enabled) {
         error_setg(errp, "cannot be a zoned- in an FDP configuration");
         return -1;
     }
 
-    if (ns->params.zoned) {
-        if (ns->params.max_active_zones) {
-            if (ns->params.max_open_zones > ns->params.max_active_zones) {
-                error_setg(errp, "max_open_zones (%u) exceeds "
-                           "max_active_zones (%u)", ns->params.max_open_zones,
-                           ns->params.max_active_zones);
-                return -1;
-            }
-
-            if (!ns->params.max_open_zones) {
-                ns->params.max_open_zones = ns->params.max_active_zones;
-            }
-        }
-
+    if (blk_get_zone_model(blk)) {
         if (ns->params.zd_extension_size) {
             if (ns->params.zd_extension_size & 0x3f) {
                 error_setg(errp, "zone descriptor extension size must be a "
@@ -630,14 +611,14 @@ static int nvme_ns_check_constraints(NvmeNamespace *ns, Error **errp)
                 return -1;
             }
 
-            if (ns->params.max_active_zones) {
-                if (ns->params.numzrwa > ns->params.max_active_zones) {
+            int maz = blk_get_max_active_zones(blk);
+            if (maz) {
+                if (ns->params.numzrwa > maz) {
                     error_setg(errp, "number of zone random write area "
                                "resources (zoned.numzrwa, %d) must be less "
                                "than or equal to maximum active resources "
                                "(zoned.max_active_zones, %d)",
-                               ns->params.numzrwa,
-                               ns->params.max_active_zones);
+                               ns->params.numzrwa, maz);
                     return -1;
                 }
             }
@@ -660,7 +641,7 @@ int nvme_ns_setup(NvmeNamespace *ns, Error **errp)
     if (nvme_ns_init(ns, errp)) {
         return -1;
     }
-    if (ns->params.zoned) {
+    if (blk_get_zone_model(ns->blkconf.blk)) {
         if (nvme_ns_zoned_check_calc_geometry(ns, errp) != 0) {
             return -1;
         }
@@ -683,15 +664,17 @@ void nvme_ns_drain(NvmeNamespace *ns)
 
 void nvme_ns_shutdown(NvmeNamespace *ns)
 {
-    blk_flush(ns->blkconf.blk);
-    if (ns->params.zoned) {
+
+    BlockBackend *blk = ns->blkconf.blk;
+    blk_flush(blk);
+    if (blk_get_zone_model(blk)) {
         nvme_zoned_ns_shutdown(ns);
     }
 }
 
 void nvme_ns_cleanup(NvmeNamespace *ns)
 {
-    if (ns->params.zoned) {
+    if (blk_get_zone_model(ns->blkconf.blk)) {
         g_free(ns->id_ns_zoned);
         g_free(ns->zone_array);
         g_free(ns->zd_extensions);
@@ -806,11 +789,6 @@ static Property nvme_ns_props[] = {
     DEFINE_PROP_UINT16("mssrl", NvmeNamespace, params.mssrl, 128),
     DEFINE_PROP_UINT32("mcl", NvmeNamespace, params.mcl, 128),
     DEFINE_PROP_UINT8("msrc", NvmeNamespace, params.msrc, 127),
-    DEFINE_PROP_BOOL("zoned", NvmeNamespace, params.zoned, false),
-    DEFINE_PROP_SIZE("zoned.zone_size", NvmeNamespace, params.zone_size_bs,
-                     NVME_DEFAULT_ZONE_SIZE),
-    DEFINE_PROP_SIZE("zoned.zone_capacity", NvmeNamespace, params.zone_cap_bs,
-                     0),
     DEFINE_PROP_BOOL("zoned.cross_read", NvmeNamespace,
                      params.cross_zone_read, false),
     DEFINE_PROP_UINT32("zoned.max_active", NvmeNamespace,
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 5f2ae7b28b..76677a86e9 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -189,10 +189,7 @@ typedef struct NvmeNamespaceParams {
     uint32_t mcl;
     uint8_t  msrc;
 
-    bool     zoned;
     bool     cross_zone_read;
-    uint64_t zone_size_bs;
-    uint64_t zone_cap_bs;
     uint32_t max_active_zones;
     uint32_t max_open_zones;
     uint32_t zd_extension_size;
diff --git a/include/sysemu/block-backend-io.h b/include/sysemu/block-backend-io.h
index be4dcef59d..3be221e752 100644
--- a/include/sysemu/block-backend-io.h
+++ b/include/sysemu/block-backend-io.h
@@ -99,6 +99,13 @@ void blk_error_action(BlockBackend *blk, BlockErrorAction action,
 void blk_iostatus_set_err(BlockBackend *blk, int error);
 int blk_get_max_iov(BlockBackend *blk);
 int blk_get_max_hw_iov(BlockBackend *blk);
+uint8_t blk_get_zone_model(BlockBackend *blk);
+uint8_t blk_get_zone_profile(BlockBackend *blk);
+uint32_t blk_get_zone_size(BlockBackend *blk);
+uint32_t blk_get_zone_capacity(BlockBackend *blk);
+uint32_t blk_get_max_open_zones(BlockBackend *blk);
+uint32_t blk_get_max_active_zones(BlockBackend *blk);
+uint32_t blk_get_max_append_sectors(BlockBackend *blk);
 
 void blk_io_plug(void);
 void blk_io_unplug(void);
-- 
2.40.1


