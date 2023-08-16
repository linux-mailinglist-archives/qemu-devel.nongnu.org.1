Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B1777DAF2
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 09:09:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWAeV-0007bo-76; Wed, 16 Aug 2023 03:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qWAeT-0007bH-3L; Wed, 16 Aug 2023 03:09:09 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qWAeQ-0004gF-LF; Wed, 16 Aug 2023 03:09:08 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6887918ed20so715611b3a.2; 
 Wed, 16 Aug 2023 00:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692169744; x=1692774544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SkovOXGRt2vR87i/uRJorqMFrEuKu7r1DpRh9lBafx8=;
 b=fuZZ6YsGUgr+L6rP1r1xoGmWdXKV4IX4cxJNMB13Im/T0QgzsJNhMuBrs72wTAYOsy
 sZAwk7Qqb6T+r+HM339g+3KRKhp12Rd8rM0vIWOzuKYFpyT6kzDuwmIVzTqNQKWYaCpu
 EYPgE2B10EAwoJOmBNrLqvObe3nZJPyBgfVY/VB4LDhPKgJzeavrc2XxL5wSndvL9DcS
 r4qOYi4iolOqMeKrzgovftWGXj05jdSM6N77J8rE11KQ1DPLXRw3wYaYRxlQK4O7NhiI
 gnNmmh0BjkL/o+ofHxtmd6V9Gz/GGqN8vp1glhhlY1JoAKSLdKL64vd7IjY8tX0sUgqH
 f/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692169744; x=1692774544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SkovOXGRt2vR87i/uRJorqMFrEuKu7r1DpRh9lBafx8=;
 b=aQ1F+KhzcvV2GzTW4Y3CI6SiXjHqbYJcLUhCq8B1VZ59UQ9rAUEILE+/s9qKcs2rlZ
 XmFsoDwFc7+TyFMQRa4AOG3COkZx2vzfJjmbEWxH+zAU733ekFeU7FWOjwW/q+jEycRF
 BAmYPBnByBWNKy/KJ629xeNe2ttE/QvsVfIrXAikAwgfGlCDg1QKfLRq974y+ZmJk0Sw
 4qkW1QbgrM5XdhQfpvp0fVDT5mCzQ+yHQ5Q+fmvzMbn/mYsC9FZ18nCgK76zsxYGH6pM
 DSyF8J376o6npoGlGHReZDrRvOWnbo4Nch4+b2PbNBNw1aoOAbTQeFtUTla3WaqXzNCe
 fGjA==
X-Gm-Message-State: AOJu0YwZf2yQSABZX/pPLkpYVUq2cxjE4iNYtm/1fgZm1miwfj7XOu9n
 DtR3hkNZrf1nMJ07TEhSjc+OeQeRni71irj7EMI=
X-Google-Smtp-Source: AGHT+IGBdnBRe3avDoCxYF3qbS7cNAWXF5TOXFC5G0542dP8Y2H6Tw56s9zd5C2gHndewtTacKU+9g==
X-Received: by 2002:a05:6a20:325b:b0:135:4858:683 with SMTP id
 hm27-20020a056a20325b00b0013548580683mr1323502pzc.48.1692169743773; 
 Wed, 16 Aug 2023 00:09:03 -0700 (PDT)
Received: from fedlinux.. ([106.84.130.68]) by smtp.gmail.com with ESMTPSA id
 bm17-20020a056a00321100b00640ddad2e0dsm10421065pfb.47.2023.08.16.00.08.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 00:09:03 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Klaus Jensen <its@irrelevant.dk>,
 Markus Armbruster <armbru@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 dlemoal@kernel.org, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, hare@suse.de,
 Kevin Wolf <kwolf@redhat.com>, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, dmitry.fomichev@wdc.com,
 Sam Li <faithilikerun@gmail.com>
Subject: [RFC 5/5] hw/nvme: make ZDED persistent
Date: Wed, 16 Aug 2023 15:08:42 +0800
Message-Id: <20230816070842.5423-2-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230816070842.5423-1-faithilikerun@gmail.com>
References: <20230816070842.5423-1-faithilikerun@gmail.com>
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

Zone descriptor extension data (ZDED) is not persistent across QEMU
restarts. The zone descriptor extension valid bit (ZDEV) is part of
zone attributes, which sets to one when the ZDED is associated with
the zone.

With the qcow2-ZNS file as the backing file, the NVMe ZNS device stores
the zone attributes at the following eight bit of zoned bit of write
pointers for each zone. The ZDED is stored as part of zoned metadata as
write pointers.

Signed-off-by: Sam Li <faithilikerun@gmail.com>
---
 block/qcow2.c                | 44 +++++++++++++++++++++++++++++++++++-
 hw/nvme/ctrl.c               |  6 +----
 include/block/block-common.h |  1 +
 3 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 5a038792f1..ac5ecef559 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 
 #include "block/qdict.h"
+#include "block/nvme.h"
 #include "sysemu/block-backend.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
@@ -214,6 +215,17 @@ static inline void qcow2_set_wp(uint64_t *wp, BlockZoneState zs)
     *wp = addr;
 }
 
+static inline void qcow2_set_za(uint64_t *wp, uint8_t za)
+{
+    /*
+     * The zone attribute takes up one byte. Store it after the zoned
+     * bit.
+     */
+    uint64_t addr = *wp;
+    addr |= ((uint64_t)za << 51);
+    *wp = addr;
+}
+
 /*
  * File wp tracking: reset zone, finish zone and append zone can
  * change the value of write pointer. All zone operations will change
@@ -308,7 +320,7 @@ static int qcow2_check_open(BlockDriverState *bs)
 
 /*
  * The zoned device has limited zone resources of open, closed, active
- * zones.
+ * zones. Check if we can manage a zone without exceeding those limits.
  */
 static int qcow2_check_zone_resources(BlockDriverState *bs,
                                       BlockZoneState zs)
@@ -4801,6 +4813,33 @@ unlock:
     return ret;
 }
 
+static int qcow2_zns_set_zded(BlockDriverState *bs, uint32_t index)
+{
+    BDRVQcow2State *s = bs->opaque;
+    int ret;
+
+    qemu_co_mutex_lock(&s->wps->colock);
+    uint64_t *wp = &s->wps->wp[index];
+    BlockZoneState zs = qcow2_get_zs(*wp);
+    if (zs == BLK_ZS_EMPTY) {
+        ret = qcow2_check_zone_resources(bs, zs);
+        if (ret < 0) {
+            return ret;
+        }
+
+        qcow2_set_za(wp, NVME_ZA_ZD_EXT_VALID);
+        ret = qcow2_write_wp_at(bs, wp, index, BLK_ZO_CLOSE);
+        if (ret < 0) {
+            error_report("Failed to set zone extension at 0x%" PRIx64 "", *wp);
+            return ret;
+        }
+        s->nr_zones_closed++;
+        return ret;
+    }
+
+    return NVME_ZONE_INVAL_TRANSITION;
+}
+
 static int coroutine_fn qcow2_co_zone_mgmt(BlockDriverState *bs, BlockZoneOp op,
                                            int64_t offset, int64_t len)
 {
@@ -4857,6 +4896,9 @@ static int coroutine_fn qcow2_co_zone_mgmt(BlockDriverState *bs, BlockZoneOp op,
     case BLK_ZO_OFFLINE:
         ret = qcow2_write_wp_at(bs, &wps->wp[index], index, BLK_ZO_OFFLINE);
         break;
+    case BLK_ZO_SET_ZDED:
+        ret = qcow2_zns_set_zded(bs, index);
+        break;
     default:
         error_report("Unsupported zone op: 0x%x", op);
         ret = -ENOTSUP;
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 3932b516ed..fcd774e3f7 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -3425,11 +3425,6 @@ static uint16_t nvme_zone_mgmt_send(NvmeCtrl *n, NvmeRequest *req)
     NvmeNamespace *ns = req->ns;
     NvmeZoneMgmtAIOCB *iocb;
     uint64_t slba = 0;
-    uint64_t offset;
-    BlockBackend *blk = ns->blkconf.blk;
-    uint32_t zone_size = blk_get_zone_size(blk);
-    uint64_t size = zone_size * blk_get_nr_zones(blk);
-    int64_t len;
     uint32_t zone_idx = 0;
     uint16_t status;
     uint8_t action = cmd->zsa;
@@ -3485,6 +3480,7 @@ static uint16_t nvme_zone_mgmt_send(NvmeCtrl *n, NvmeRequest *req)
         break;
 
     case NVME_ZONE_ACTION_SET_ZD_EXT:
+        op = BLK_ZO_SET_ZDED;
         int zd_ext_size = blk_get_zd_ext_size(blk);
         trace_pci_nvme_set_descriptor_extension(slba, zone_idx);
         if (all || !zd_ext_size) {
diff --git a/include/block/block-common.h b/include/block/block-common.h
index 0cbed607a8..b369e77607 100644
--- a/include/block/block-common.h
+++ b/include/block/block-common.h
@@ -84,6 +84,7 @@ typedef enum BlockZoneOp {
     BLK_ZO_FINISH,
     BLK_ZO_RESET,
     BLK_ZO_OFFLINE,
+    BLK_ZO_SET_ZDED,
 } BlockZoneOp;
 
 typedef enum BlockZoneModel {
-- 
2.40.1


