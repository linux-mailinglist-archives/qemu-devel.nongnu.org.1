Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7AD7F9C33
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 09:59:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7XRT-0002i5-Sr; Mon, 27 Nov 2023 03:58:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1r7XRK-0002g6-Qz; Mon, 27 Nov 2023 03:58:03 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1r7XRH-0000K4-NB; Mon, 27 Nov 2023 03:58:02 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2859551886cso1817908a91.2; 
 Mon, 27 Nov 2023 00:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701075470; x=1701680270; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=190vkjgCxGMhvXwETkOEV/Shk2N4Lwz/fIZUv3lxyK8=;
 b=Y3lJ+cOZoz1d+TVyH3DWz0hTwquAu3F+QrKQzrDabBKuop/Hn009v+vrwQxH8FeEh4
 hXy7yQbBdj6SVPxt3nIFxhF0O1r5yeGTzXgpIaM5YDJJwcOSmWwUAKHZZ2l84gspdfnP
 VfEcCphlu87QeQhQ30FN44EB2ydEuPLF+AP9obMprpr79rok67AtjejnsZtpR1I29fUa
 hZELq0p13OBuG44wSmblZjlHTZqnBRiQ4t23pgJIB+wFXnVg8u+pAgWuU1qGK6jPPd7v
 lAqCBDGNfCcYd4ed/HlijQ5brkNisl5Yky391qeiFXpKQJJIG9tGYG+XRWgoNNB+paMy
 G+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701075470; x=1701680270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=190vkjgCxGMhvXwETkOEV/Shk2N4Lwz/fIZUv3lxyK8=;
 b=BhCaJWspg90jY3iJFZDkI0GknXE7XG4RuvwRqsfsDHJWc5IYMrHEf8qsPIms3qbM5v
 AqT0YXrdZUpSuOA8u/sWrOVWnRXbrlYd0OrK7yaCpMbntx7kXX8J+NRYTyzG8emYHRZz
 Zqt78PbXZAgtjwNm7IIvZVjd15mvwTGf1goHiC703MJ386iTKANWgRDh+P3Ogqn/BQRy
 ApuFSMwXRIq9uUqgnKgn/gbo0o2snIexidnwU4wso4+3pwRNOWZ7wFmkV5UQh/MySmFz
 fJ60CSJ6qWX3a7CTCinNAgg5KoTk/6mNNg88E3tWEXchHhvCLDfa7uZEku6rRsoVhvBY
 sg1w==
X-Gm-Message-State: AOJu0YyHevGPLpfjGRWQXvZIuM+XG4e/AuCNTmYONEqo5McENcpqiDjg
 uXS+GiZ1Lfd5VoQTbNMsn05j0fY2MnzcCw==
X-Google-Smtp-Source: AGHT+IFRFaMMkn00TNvh0M/whhFsJIjwsEuFxpgDEZTh97b8yfX8TSbKoP3XnQUZCi6TpxGT2yw0EQ==
X-Received: by 2002:a17:90b:1e10:b0:285:b800:fbe0 with SMTP id
 pg16-20020a17090b1e1000b00285b800fbe0mr5929466pjb.16.1701075469406; 
 Mon, 27 Nov 2023 00:57:49 -0800 (PST)
Received: from fedlinux.. ([106.84.128.244]) by smtp.gmail.com with ESMTPSA id
 ci8-20020a17090afc8800b0027d0adf653bsm6906901pjb.7.2023.11.27.00.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 00:57:48 -0800 (PST)
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
Subject: [RFC v2 3/7] hw/nvme: use blk_get_*() to access zone info in the
 block layer
Date: Mon, 27 Nov 2023 16:56:37 +0800
Message-Id: <20231127085641.3729-4-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231127085641.3729-1-faithilikerun@gmail.com>
References: <20231127085641.3729-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=faithilikerun@gmail.com; helo=mail-pj1-x1035.google.com
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

The zone information is contained in the BlockLimits fileds. Add blk_get_*() functions
to access the block layer and update zone info accessing in the NVMe device emulation.

Signed-off-by: Sam Li <faithilikerun@gmail.com>
---
 block/block-backend.c             | 72 +++++++++++++++++++++++++++++++
 hw/nvme/ctrl.c                    | 34 +++++----------
 hw/nvme/ns.c                      | 61 ++++++++------------------
 hw/nvme/nvme.h                    |  3 --
 include/sysemu/block-backend-io.h |  9 ++++
 5 files changed, 111 insertions(+), 68 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index ec21148806..666df9cfea 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2380,6 +2380,78 @@ int blk_get_max_iov(BlockBackend *blk)
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
+uint32_t blk_get_nr_zones(BlockBackend *blk)
+{
+    BlockDriverState *bs = blk_bs(blk);
+    IO_CODE();
+
+    return bs ? bs->bl.nr_zones : 0;
+}
+
+uint32_t blk_get_write_granularity(BlockBackend *blk)
+{
+    BlockDriverState *bs = blk_bs(blk);
+    IO_CODE();
+
+    return bs ? bs->bl.write_granularity : 0;
+}
+
+BlockZoneWps *blk_get_zone_wps(BlockBackend *blk)
+{
+    BlockDriverState *bs = blk_bs(blk);
+    IO_CODE();
+
+    return bs ? bs->wps : NULL;
+}
+
 void *blk_try_blockalign(BlockBackend *blk, size_t size)
 {
     IO_CODE();
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index f026245d1e..e64b021454 100644
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
@@ -2160,7 +2148,7 @@ void nvme_rw_complete_cb(void *opaque, int ret)
         block_acct_done(stats, acct);
     }
 
-    if (ns->params.zoned && nvme_is_write(req)) {
+    if (blk_get_zone_model(blk) && nvme_is_write(req)) {
         nvme_finalize_zoned_write(ns, req);
     }
 
@@ -2882,7 +2870,7 @@ static void nvme_copy_out_completed_cb(void *opaque, int ret)
         goto out;
     }
 
-    if (ns->params.zoned) {
+    if (blk_get_zone_model(ns->blkconf.blk)) {
         nvme_advance_zone_wp(ns, iocb->zone, nlb);
     }
 
@@ -2994,7 +2982,7 @@ static void nvme_copy_in_completed_cb(void *opaque, int ret)
         goto invalid;
     }
 
-    if (ns->params.zoned) {
+    if (blk_get_zone_model(ns->blkconf.blk)) {
         status = nvme_check_zone_write(ns, iocb->zone, iocb->slba, nlb);
         if (status) {
             goto invalid;
@@ -3088,7 +3076,7 @@ static void nvme_do_copy(NvmeCopyAIOCB *iocb)
         }
     }
 
-    if (ns->params.zoned) {
+    if (blk_get_zone_model(ns->blkconf.blk)) {
         status = nvme_check_zone_read(ns, slba, nlb);
         if (status) {
             goto invalid;
@@ -3164,7 +3152,7 @@ static uint16_t nvme_copy(NvmeCtrl *n, NvmeRequest *req)
 
     iocb->slba = le64_to_cpu(copy->sdlba);
 
-    if (ns->params.zoned) {
+    if (blk_get_zone_model(ns->blkconf.blk)) {
         iocb->zone = nvme_get_zone_by_slba(ns, iocb->slba);
         if (!iocb->zone) {
             status = NVME_LBA_RANGE | NVME_DNR;
@@ -3434,7 +3422,7 @@ static uint16_t nvme_read(NvmeCtrl *n, NvmeRequest *req)
         goto invalid;
     }
 
-    if (ns->params.zoned) {
+    if (blk_get_zone_model(blk)) {
         status = nvme_check_zone_read(ns, slba, nlb);
         if (status) {
             trace_pci_nvme_err_zone_read_not_ok(slba, nlb, status);
@@ -3549,7 +3537,7 @@ static uint16_t nvme_do_write(NvmeCtrl *n, NvmeRequest *req, bool append,
         goto invalid;
     }
 
-    if (ns->params.zoned) {
+    if (blk_get_zone_model(blk)) {
         zone = nvme_get_zone_by_slba(ns, slba);
         assert(zone);
 
@@ -3667,7 +3655,7 @@ static uint16_t nvme_get_mgmt_zone_slba_idx(NvmeNamespace *ns, NvmeCmd *c,
     uint32_t dw10 = le32_to_cpu(c->cdw10);
     uint32_t dw11 = le32_to_cpu(c->cdw11);
 
-    if (!ns->params.zoned) {
+    if (blk_get_zone_model(ns->blkconf.blk)) {
         trace_pci_nvme_err_invalid_opc(c->opcode);
         return NVME_INVALID_OPCODE | NVME_DNR;
     }
@@ -6527,7 +6515,7 @@ done:
 
 static uint16_t nvme_format_check(NvmeNamespace *ns, uint8_t lbaf, uint8_t pi)
 {
-    if (ns->params.zoned) {
+    if (blk_get_zone_model(ns->blkconf.blk)) {
         return NVME_INVALID_FORMAT | NVME_DNR;
     }
 
diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 0eabcf5cf5..82d4f7932d 100644
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
@@ -577,25 +570,12 @@ static int nvme_ns_check_constraints(NvmeNamespace *ns, Error **errp)
         return -1;
     }
 
-    if (ns->params.zoned && ns->endgrp && ns->endgrp->fdp.enabled) {
+    if (blk_get_zone_model(blk) && ns->endgrp && ns->endgrp->fdp.enabled) {
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
@@ -630,14 +610,14 @@ static int nvme_ns_check_constraints(NvmeNamespace *ns, Error **errp)
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
@@ -660,7 +640,7 @@ int nvme_ns_setup(NvmeNamespace *ns, Error **errp)
     if (nvme_ns_init(ns, errp)) {
         return -1;
     }
-    if (ns->params.zoned) {
+    if (blk_get_zone_model(ns->blkconf.blk)) {
         if (nvme_ns_zoned_check_calc_geometry(ns, errp) != 0) {
             return -1;
         }
@@ -683,15 +663,17 @@ void nvme_ns_drain(NvmeNamespace *ns)
 
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
@@ -806,11 +788,6 @@ static Property nvme_ns_props[] = {
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
index d174275a5c..44e44954fa 100644
--- a/include/sysemu/block-backend-io.h
+++ b/include/sysemu/block-backend-io.h
@@ -99,6 +99,15 @@ void blk_error_action(BlockBackend *blk, BlockErrorAction action,
 void blk_iostatus_set_err(BlockBackend *blk, int error);
 int blk_get_max_iov(BlockBackend *blk);
 int blk_get_max_hw_iov(BlockBackend *blk);
+uint8_t blk_get_zone_model(BlockBackend *blk);
+uint32_t blk_get_zone_size(BlockBackend *blk);
+uint32_t blk_get_zone_capacity(BlockBackend *blk);
+uint32_t blk_get_max_open_zones(BlockBackend *blk);
+uint32_t blk_get_max_active_zones(BlockBackend *blk);
+uint32_t blk_get_max_append_sectors(BlockBackend *blk);
+uint32_t blk_get_nr_zones(BlockBackend *blk);
+uint32_t blk_get_write_granularity(BlockBackend *blk);
+BlockZoneWps *blk_get_zone_wps(BlockBackend *blk);
 
 AioContext *blk_get_aio_context(BlockBackend *blk);
 BlockAcctStats *blk_get_stats(BlockBackend *blk);
-- 
2.40.1


