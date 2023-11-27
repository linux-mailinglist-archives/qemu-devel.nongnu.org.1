Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DCE7F9C34
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 09:59:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7XRr-0002u6-19; Mon, 27 Nov 2023 03:58:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1r7XRk-0002tC-Ve; Mon, 27 Nov 2023 03:58:29 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1r7XRi-0000RQ-Hv; Mon, 27 Nov 2023 03:58:28 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-285d32c6f07so422643a91.1; 
 Mon, 27 Nov 2023 00:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701075504; x=1701680304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qlLcGE49x20put7Po+TMfj+/AujYOwf5FbyhtttvTBI=;
 b=XU0jbsJ6AZrBsVjPlvagEhKO5/At8Jwwx66s+1zsSaRuBa/atS7if5exceJMgk3sIZ
 DyT2GY14KNgS0f+VtN3tWCU1TVG3+J9XjaiUmQyqNvfWRTkZm0j5dF2G8y/EUwJeTtIH
 XUvLK4GlbMGLt6rK/AcqHPrE9jgJqNMbH5ePsMDlsVgg/RGMNhZ5dZVlYlA3LZSToE/Y
 IyBW9gm/LxssQW9xDArrSieYqTElDGBgAjhgg3DpP16ETWdTfqq/Bu1HKdscJS4ODU3z
 FP4F7BXwuovcFvZQsQI0tFvkj4IqOcX8AMuYxq/Xoxae+/a+4TwcirepGVq0a9Ew9k9U
 /tnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701075504; x=1701680304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qlLcGE49x20put7Po+TMfj+/AujYOwf5FbyhtttvTBI=;
 b=erxyeP6aG2vkMgVPHXsQDP8PjSSt0jcgG8q+/fjZjvgfU6AFx24vcwpw+/DX/Zjrnz
 hmJ2Qb0LMu3LUA80opceVNSZ51CeTLAIZXjNo0DywgFLt1vrRQGORYL3iIecnzHHqb8T
 I4XdccOYXLgkWatPGbbJd+Y32jEwS2lgIqmh05fcgB5q3toAMr3dX7d0mJmmnDeWSbTS
 cM1jLiVfwU7HTX762wSVuFzjislBp604ZXkej2f5ozXmCTnfSSg4YFVU9KMsRvY82jZw
 /ZgUGZm8kcvGkYt/Jl1geUk3saEi/bJ3JQ/nwD4zWxrtwn+sKcQ+lnSI7G6uYLche5oJ
 gHsw==
X-Gm-Message-State: AOJu0YzTp28fJrWSdPsiOuafurtSivmsndYSLc8b2pDaITEHEKTxPNak
 qIN3rN5rJ1Ou8bU27SmMAHfyx3WM87cLjg==
X-Google-Smtp-Source: AGHT+IHaZ+bkJCMYqjqqwssV8Y9lc+WNyeVkf5iZQ+1tEUNTh9jpNefJVkMH02JturbWrhLnPRXkVg==
X-Received: by 2002:a17:90b:1d0f:b0:285:a2af:31aa with SMTP id
 on15-20020a17090b1d0f00b00285a2af31aamr4838294pjb.37.1701075504087; 
 Mon, 27 Nov 2023 00:58:24 -0800 (PST)
Received: from fedlinux.. ([106.84.128.244]) by smtp.gmail.com with ESMTPSA id
 ci8-20020a17090afc8800b0027d0adf653bsm6906901pjb.7.2023.11.27.00.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 00:58:23 -0800 (PST)
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
Subject: [RFC v2 7/7] hw/nvme: make ZDED persistent
Date: Mon, 27 Nov 2023 16:56:41 +0800
Message-Id: <20231127085641.3729-8-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231127085641.3729-1-faithilikerun@gmail.com>
References: <20231127085641.3729-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=faithilikerun@gmail.com; helo=mail-pj1-x1032.google.com
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

Zone descriptor extension data (ZDED) is not persistent across QEMU
restarts. The zone descriptor extension valid bit (ZDEV) is part of
zone attributes, which sets to one when the ZDED is associated with
the zone.

With the qcow2 img as the backing file, the NVMe ZNS device stores
the zone attributes at the following eight bit of zone type bit of write
pointers for each zone. The ZDED is stored as part of zoned metadata as
write pointers.

Signed-off-by: Sam Li <faithilikerun@gmail.com>
---
 block/qcow2.c                | 45 ++++++++++++++++++++++++++++++++++++
 hw/nvme/ctrl.c               |  1 +
 include/block/block-common.h |  1 +
 3 files changed, 47 insertions(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index 74d2e2bf39..861a8f9f06 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 
 #include "block/qdict.h"
+#include "block/nvme.h"
 #include "sysemu/block-backend.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
@@ -235,6 +236,17 @@ static inline BlockZoneState qcow2_get_zone_state(BlockDriverState *bs,
     return BLK_ZS_NOT_WP;
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
  * Write the new wp value to the dedicated location of the image file.
  */
@@ -4990,6 +5002,36 @@ unlock:
     return ret;
 }
 
+static int qcow2_zns_set_zded(BlockDriverState *bs, uint32_t index)
+{
+    BDRVQcow2State *s = bs->opaque;
+    int ret;
+
+    qemu_co_mutex_lock(&bs->wps->colock);
+    uint64_t *wp = &bs->wps->wp[index];
+    BlockZoneState zs = qcow2_get_zone_state(bs, index);
+    if (zs == BLK_ZS_EMPTY) {
+        ret = qcow2_check_zone_resources(bs, zs);
+        if (ret < 0) {
+            goto unlock;
+        }
+
+        qcow2_set_za(wp, NVME_ZA_ZD_EXT_VALID);
+        ret = qcow2_write_wp_at(bs, wp, index);
+        if (ret < 0) {
+            error_report("Failed to set zone extension at 0x%" PRIx64 "", *wp);
+            goto unlock;
+        }
+        s->nr_zones_closed++;
+        qemu_co_mutex_unlock(&bs->wps->colock);
+        return ret;
+    }
+
+unlock:
+    qemu_co_mutex_unlock(&bs->wps->colock);
+    return NVME_ZONE_INVAL_TRANSITION;
+}
+
 static int coroutine_fn qcow2_co_zone_mgmt(BlockDriverState *bs, BlockZoneOp op,
                                            int64_t offset, int64_t len)
 {
@@ -5046,6 +5088,9 @@ static int coroutine_fn qcow2_co_zone_mgmt(BlockDriverState *bs, BlockZoneOp op,
     case BLK_ZO_OFFLINE:
         /* There are no transitions from the offline state to any other state */
         break;
+    case BLK_ZO_SET_ZDED:
+        ret = qcow2_zns_set_zded(bs, index);
+        break;
     default:
         error_report("Unsupported zone op: 0x%x", op);
         ret = -ENOTSUP;
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index f65a87646e..c33e24e303 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -3474,6 +3474,7 @@ static uint16_t nvme_zone_mgmt_send(NvmeCtrl *n, NvmeRequest *req)
         break;
 
     case NVME_ZONE_ACTION_SET_ZD_EXT:
+        op = BLK_ZO_SET_ZDED;
         int zd_ext_size = blk_get_zd_ext_size(blk);
         trace_pci_nvme_set_descriptor_extension(slba, zone_idx);
         if (all || !zd_ext_size) {
diff --git a/include/block/block-common.h b/include/block/block-common.h
index ea213c3887..b61541599f 100644
--- a/include/block/block-common.h
+++ b/include/block/block-common.h
@@ -91,6 +91,7 @@ typedef enum BlockZoneOp {
     BLK_ZO_FINISH,
     BLK_ZO_RESET,
     BLK_ZO_OFFLINE,
+    BLK_ZO_SET_ZDED,
 } BlockZoneOp;
 
 typedef enum BlockZoneModel {
-- 
2.40.1


