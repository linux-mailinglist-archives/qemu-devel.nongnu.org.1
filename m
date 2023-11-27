Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BE07F9C3B
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 10:00:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7XRQ-0002hX-Nx; Mon, 27 Nov 2023 03:58:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1r7XRL-0002gI-GN; Mon, 27 Nov 2023 03:58:03 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1r7XRI-0000Ka-AW; Mon, 27 Nov 2023 03:58:03 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5c1a75a4b6cso2087469a12.2; 
 Mon, 27 Nov 2023 00:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701075478; x=1701680278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ch81WmdoCU80VhQYuy/fZ682t/gWb6AufUA3SdAdaV0=;
 b=nX/HHJZP0UbeiKAVX0zefAb2qadMl4T5pXjzlGFPKiOcRDYSX4SPY6ixEPSEPVLshl
 a2xVBTsSlf4Epu0tXrucWNaMAgBOqLVpAMNchCBMhj7W4Q0FyWAgtsPg2Esb4M/+ZyMh
 UQIQ4HdtH53NkntaIk0m9c1DU4G106RJ1uwSnJv47/HZqpedHcu5OsU0v6sykeW/aHwL
 l16Ehlg0ssIYRCdx2L6pTj6MagvLy9TVqyAH2uo7t7wDAGXFnbLxRlkCkRF+oRbpcu7q
 sm3pPXNbycxS2j0PR0BxtYwJV7lQnqK8TVfP6nkRsypfuBTDoUQTFo0NN/jK2lR5iQ+G
 BQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701075478; x=1701680278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ch81WmdoCU80VhQYuy/fZ682t/gWb6AufUA3SdAdaV0=;
 b=GqNJ8Jm07O54Fpi2qKhtun6uRjdhMq4r938DdrShIRglxjliCERoW1dcrt0R4NHl+B
 Z8cve+RMj8rr01nVTJ2xk1l9QRgwNYWbF4zaGe430LIdtZiPTy1ZXjy0muO2jLYGg2Rr
 ewVIjmJt5fjWb4nQhG70IJHqqQb8stnCXh/i30iMkuS6zanADQBeflPjymT32hOrML6P
 um3aWQBpinu3mlYUvndcQ2bmso6eeF/UXK0VDN6cZnEk9uiJvFyuXvt16U4pwSi0OC6+
 8oHe6Os5HDpExYwC7TcMNn4HU0+IfZzCDjlzWyWOXHSyv4qgfSuJ32pwPFapLKntBrIP
 2ftQ==
X-Gm-Message-State: AOJu0YxCogfIRTF664JDL9nYgjH3Sp7rX235ZO8EPfIKE7uM1zhjESZm
 UmDz7pkJylIZiz/pe6FI4sHtUhDiEy9iLQ==
X-Google-Smtp-Source: AGHT+IGx1CsvU1uNUAIYI90qb1rdcmLRZyfvIU2khleiLn/0kqnrsxEFu0qh+JSGW4G0CYjnCaRLpg==
X-Received: by 2002:a17:90a:1a5d:b0:280:24c7:509 with SMTP id
 29-20020a17090a1a5d00b0028024c70509mr8864273pjl.46.1701075477259; 
 Mon, 27 Nov 2023 00:57:57 -0800 (PST)
Received: from fedlinux.. ([106.84.128.244]) by smtp.gmail.com with ESMTPSA id
 ci8-20020a17090afc8800b0027d0adf653bsm6906901pjb.7.2023.11.27.00.57.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 00:57:56 -0800 (PST)
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
Subject: [RFC v2 4/7] hw/nvme: add blk_get_zone_extension to access
 zd_extensions
Date: Mon, 27 Nov 2023 16:56:38 +0800
Message-Id: <20231127085641.3729-5-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231127085641.3729-1-faithilikerun@gmail.com>
References: <20231127085641.3729-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=faithilikerun@gmail.com; helo=mail-pg1-x532.google.com
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

Signed-off-by: Sam Li <faithilikerun@gmail.com>
---
 block/block-backend.c             | 16 ++++++++++++++++
 hw/nvme/ctrl.c                    | 20 ++++++++++++++------
 hw/nvme/ns.c                      | 24 ++++--------------------
 hw/nvme/nvme.h                    |  7 -------
 include/sysemu/block-backend-io.h |  2 ++
 5 files changed, 36 insertions(+), 33 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 666df9cfea..fcdcbe28bf 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2452,6 +2452,22 @@ BlockZoneWps *blk_get_zone_wps(BlockBackend *blk)
     return bs ? bs->wps : NULL;
 }
 
+uint8_t *blk_get_zone_extension(BlockBackend *blk)
+{
+    BlockDriverState *bs = blk_bs(blk);
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
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index e64b021454..dae6f00e4f 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -4004,6 +4004,12 @@ static uint16_t nvme_zone_mgmt_send_zrwa_flush(NvmeCtrl *n, NvmeZone *zone,
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
@@ -4088,11 +4094,11 @@ static uint16_t nvme_zone_mgmt_send(NvmeCtrl *n, NvmeRequest *req)
 
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
@@ -4183,7 +4189,8 @@ static uint16_t nvme_zone_mgmt_recv(NvmeCtrl *n, NvmeRequest *req)
     if (zra != NVME_ZONE_REPORT && zra != NVME_ZONE_REPORT_EXTENDED) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
-    if (zra == NVME_ZONE_REPORT_EXTENDED && !ns->params.zd_extension_size) {
+    if (zra == NVME_ZONE_REPORT_EXTENDED &&
+        !blk_get_zd_ext_size(ns->blkconf.blk)) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
@@ -4205,7 +4212,7 @@ static uint16_t nvme_zone_mgmt_recv(NvmeCtrl *n, NvmeRequest *req)
 
     zone_entry_sz = sizeof(NvmeZoneDescr);
     if (zra == NVME_ZONE_REPORT_EXTENDED) {
-        zone_entry_sz += ns->params.zd_extension_size;
+        zone_entry_sz += blk_get_zd_ext_size(ns->blkconf.blk) ;
     }
 
     max_zones = (data_size - sizeof(NvmeZoneReportHeader)) / zone_entry_sz;
@@ -4243,11 +4250,12 @@ static uint16_t nvme_zone_mgmt_recv(NvmeCtrl *n, NvmeRequest *req)
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
index 82d4f7932d..45c08391f5 100644
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
@@ -576,19 +576,6 @@ static int nvme_ns_check_constraints(NvmeNamespace *ns, Error **errp)
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
@@ -676,7 +663,6 @@ void nvme_ns_cleanup(NvmeNamespace *ns)
     if (blk_get_zone_model(ns->blkconf.blk)) {
         g_free(ns->id_ns_zoned);
         g_free(ns->zone_array);
-        g_free(ns->zd_extensions);
     }
 
     if (ns->endgrp && ns->endgrp->fdp.enabled) {
@@ -794,8 +780,6 @@ static Property nvme_ns_props[] = {
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
diff --git a/include/sysemu/block-backend-io.h b/include/sysemu/block-backend-io.h
index 44e44954fa..ab388801b1 100644
--- a/include/sysemu/block-backend-io.h
+++ b/include/sysemu/block-backend-io.h
@@ -108,6 +108,8 @@ uint32_t blk_get_max_append_sectors(BlockBackend *blk);
 uint32_t blk_get_nr_zones(BlockBackend *blk);
 uint32_t blk_get_write_granularity(BlockBackend *blk);
 BlockZoneWps *blk_get_zone_wps(BlockBackend *blk);
+uint8_t *blk_get_zone_extension(BlockBackend *blk);
+uint32_t blk_get_zd_ext_size(BlockBackend *blk);
 
 AioContext *blk_get_aio_context(BlockBackend *blk);
 BlockAcctStats *blk_get_stats(BlockBackend *blk);
-- 
2.40.1


