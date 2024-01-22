Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5167783719D
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 20:02:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRzX8-0005fC-El; Mon, 22 Jan 2024 14:00:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1rRzX7-0005ef-1T; Mon, 22 Jan 2024 14:00:33 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1rRzX5-00024c-22; Mon, 22 Jan 2024 14:00:32 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-559cef15db5so8054606a12.0; 
 Mon, 22 Jan 2024 11:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705950029; x=1706554829; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+OvmjsEOUcoHzwGCXwmbsbs97JD2U8yE+EAWzlHpR9c=;
 b=PU0PVaBw+kXCLPQYCjlD6bzzUqQggivQy/MVYm7cye6vx+X8SFGw1ETGRWc6H2eifN
 xeH9AZJ+/s6bnTgT5l657G5ZSNVbemrZ5Tu6gCTT4UG2IpTfAjFNljvlPDjeZp9btDKP
 00wK9RH3zOHk+bzSKFHYVoSuh7Hqb+1MiwYZf2QYOQXEn7J13XpGIUqG+AK3KcD1zlA+
 znzGoPdn2Vp4pw3Z2wQ/NBxYHvrUX6b/a3tTa2dZCP17DzlKZk+aM2sU4vjWkCppC1Rh
 a1lKjQ1yyqmZWKK8WaInj1bst7XulP0LUDb7L9l7OKrupHoz7RdZ0iSZ0jD3R9ggLozq
 NjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705950029; x=1706554829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+OvmjsEOUcoHzwGCXwmbsbs97JD2U8yE+EAWzlHpR9c=;
 b=QXrj+bKQLLEnqaWjzk9y3+EED5WhCgaj0M53cMbjnBR6ngM8HsVsXDF8oU9C965scR
 leVFVnCYxkdrE9LdQiVp3bfCeM3kpb4XWt3Bb2n++s2AJz4zdPlidPZGibZbuvs9HiVo
 AVyz6AdaKoFHWkwS7aU/aZqZVQZBqWpYGYmnA0Roqqi1nYxoaWg8vTPgLGeJoEWXKijZ
 eaK2udISHxsealgu0Pq+DoPjDJm5Yst120601w/7SiG0hvGElkY9wflrxY/I5rmF58Gi
 Gm6o4Ir5DUAvqGqC3KzquRLItXQW6jWyhHUsrMJXK67Zu7MeAjBG0hcy8E968q1ycmFc
 1Dmw==
X-Gm-Message-State: AOJu0YykyZmYqIt9MFaAE2WIZnNqm8FBV0zS33ecl5+YNIq/06OVDPcO
 KsE8LOLiYOSMcp198Lb92D8Ri1V6wiPcksxwRjEF5ypoZuQV4HO6o4UC/LFNHLA=
X-Google-Smtp-Source: AGHT+IFpvk7tWZpswHIsn7Vwd09dqjZ3xADYWH8+OrTeyFyOWJcBYquxtJen3928eYl5NU5H9nrS/Q==
X-Received: by 2002:a17:906:e297:b0:a2c:aaa5:1a10 with SMTP id
 gg23-20020a170906e29700b00a2caaa51a10mr4820768ejb.5.1705950028646; 
 Mon, 22 Jan 2024 11:00:28 -0800 (PST)
Received: from localhost.localdomain ([2a02:2454:367:1500:fa08:d4d:b569:ac2d])
 by smtp.gmail.com with ESMTPSA id
 k3-20020a170906a38300b00a298d735a1bsm13842413ejz.149.2024.01.22.11.00.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 11:00:28 -0800 (PST)
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
Subject: [RFC v3 4/7] hw/nvme: add blk_get_zone_extension to access
 zd_extensions
Date: Mon, 22 Jan 2024 20:00:10 +0100
Message-Id: <20240122190013.41302-5-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240122190013.41302-1-faithilikerun@gmail.com>
References: <20240122190013.41302-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=faithilikerun@gmail.com; helo=mail-ed1-x533.google.com
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
index c23f2a731b..3bebee12b9 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2431,6 +2431,22 @@ BlockZoneWps *blk_get_zone_wps(BlockBackend *blk)
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


