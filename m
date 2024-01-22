Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C8C8371AE
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 20:02:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRzXD-0005hE-OS; Mon, 22 Jan 2024 14:00:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1rRzXB-0005gd-Qg; Mon, 22 Jan 2024 14:00:37 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1rRzX9-00025P-PO; Mon, 22 Jan 2024 14:00:37 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a2821884a09so264049966b.2; 
 Mon, 22 Jan 2024 11:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705950033; x=1706554833; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yX93vARGE4EZ8dVsl+J/Ugdwgba6V1YzNVL4jgpJfRk=;
 b=P4OxwImrrls8c1M/n7Pw/t/0L0doFOnDPJqJuBwUPMMLsQX3Smj4cRhv+XLpKoAG46
 to9QB4UITrT5Y+snzIm8wZToOFRocGegR299DLVNojYvzPD1cLjeLamY2YkCOhmekspy
 iIiCk31NJdQsk+Exx3jT4XdvIuytajaoqbJv4MaYSADU3bR0/AA6kUelgaYBizhHLufa
 ZNjQnQYQrNx8JwX1IQF7aeeF3xCZrg4z2JBEKfjYZuSU2BfE8TFhjD1YSLQ4KvrnJ6ea
 pYZgxSyut0a4F3aIbG6257NUaeLSzNS8MTWx1uLkuTL+I7fWMw01zaGT8LCPyOGm5iPB
 NjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705950033; x=1706554833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yX93vARGE4EZ8dVsl+J/Ugdwgba6V1YzNVL4jgpJfRk=;
 b=TeUmVnVdXYyE1a6FB+9K+Zf7gIG8r+L0xlQfmbDGy+8IZfQk+0HOXm9Nvxp4J8LT0S
 JyQVx+y/llhsg4DD6BbRs/UHQ31FqALR4KoA0Nj55Umed+CyAfY+G/kIKE03pUz5bvEw
 4msDCDUUcOjcUcFT7ztmLWy6XTKj9BxqleTFVW5Q+aDRIagGlOIU3pStaqNcWCcxtuLk
 M+gtAkGLrDJ39Apt5ZGCAjvvp3qd4B5Vr2UKR6UAGufihVcIboIUdZqaChg0lYHeZio/
 rMDparAhrCQbEndc/Jv9VwrYuC+JssZsc896hxYnuXt0ZdTjP70jIqfSI0Q4kxbGPZ/t
 0H9A==
X-Gm-Message-State: AOJu0Yw/PqZT41B4JwFb04uXY9VxWi7HsAa+W+B/SQkHj/bbOIgIGfUP
 cUeTnQDw/cIEKBLSUdcR3pg+zWh8AP5t+laQHdTBZnCGL7gJ8TpgJnt+v2UlZ4k=
X-Google-Smtp-Source: AGHT+IE42KsObPWWVwtqZfQZbkSl3qEB2yLz+M/xoPEcqzhATBev0VdaQ3FX8OwE7mvBMlyfQ3VZSw==
X-Received: by 2002:a17:906:1913:b0:a26:c376:d1dc with SMTP id
 a19-20020a170906191300b00a26c376d1dcmr2742328eje.70.1705950033257; 
 Mon, 22 Jan 2024 11:00:33 -0800 (PST)
Received: from localhost.localdomain ([2a02:2454:367:1500:fa08:d4d:b569:ac2d])
 by smtp.gmail.com with ESMTPSA id
 k3-20020a170906a38300b00a298d735a1bsm13842413ejz.149.2024.01.22.11.00.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 11:00:32 -0800 (PST)
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
Subject: [RFC v3 7/7] hw/nvme: make ZDED persistent
Date: Mon, 22 Jan 2024 20:00:13 +0100
Message-Id: <20240122190013.41302-8-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240122190013.41302-1-faithilikerun@gmail.com>
References: <20240122190013.41302-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=faithilikerun@gmail.com; helo=mail-ej1-x633.google.com
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
index 43ee0f47b9..f2d58d86c4 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 
 #include "block/qdict.h"
+#include "block/nvme.h"
 #include "sysemu/block-backend.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
@@ -197,6 +198,17 @@ qcow2_extract_crypto_opts(QemuOpts *opts, const char *fmt, Error **errp)
 
 #define QCOW2_ZT_IS_CONV(wp)    (wp & 1ULL << 59)
 
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
  * To emulate a real zoned device, closed, empty and full states are
  * preserved after a power cycle. The open states are in-memory and will
@@ -5053,6 +5065,36 @@ unlock:
     return ret;
 }
 
+static int coroutine_fn GRAPH_RDLOCK
+qcow2_zns_set_zded(BlockDriverState *bs, uint32_t index)
+{
+    BDRVQcow2State *s = bs->opaque;
+    int ret;
+
+    qemu_co_mutex_lock(&bs->wps->colock);
+    uint64_t *wp = &bs->wps->wp[index];
+    BlockZoneState zs = qcow2_get_zone_state(bs, index);
+    if (zs == BLK_ZS_EMPTY) {
+        if (!qcow2_can_activate_zone(bs)) {
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
 static int coroutine_fn GRAPH_RDLOCK
 qcow2_co_zone_mgmt(BlockDriverState *bs, BlockZoneOp op,
                                            int64_t offset, int64_t len)
@@ -5110,6 +5152,9 @@ qcow2_co_zone_mgmt(BlockDriverState *bs, BlockZoneOp op,
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
index de41d8bac8..2799a3ac31 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -3465,6 +3465,7 @@ static uint16_t nvme_zone_mgmt_send(NvmeCtrl *n, NvmeRequest *req)
         break;
 
     case NVME_ZONE_ACTION_SET_ZD_EXT:
+        op = BLK_ZO_SET_ZDED;
         int zd_ext_size = blk_get_zd_ext_size(blk);
         trace_pci_nvme_set_descriptor_extension(slba, zone_idx);
         if (all || !zd_ext_size) {
diff --git a/include/block/block-common.h b/include/block/block-common.h
index 7690b05149..7c501e053e 100644
--- a/include/block/block-common.h
+++ b/include/block/block-common.h
@@ -88,6 +88,7 @@ typedef enum BlockZoneOp {
     BLK_ZO_FINISH,
     BLK_ZO_RESET,
     BLK_ZO_OFFLINE,
+    BLK_ZO_SET_ZDED,
 } BlockZoneOp;
 
 typedef enum BlockZoneModel {
-- 
2.40.1


