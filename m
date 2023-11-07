Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF857E47EC
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:11:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0QXD-0004Y1-Mp; Tue, 07 Nov 2023 13:10:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1r0QX7-0004GR-Nm
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:10:37 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1r0QWt-0002jX-KN
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:10:37 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1cc9784dbc1so36416225ad.2
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 10:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699380619; x=1699985419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lerGkvWs+2MRxdzE0DMBKiSOqV9ui2+nfnjyOq/W8aE=;
 b=Hg7oBFpFydTXSwDPBqQJ1H+8+J4Za4lOPO4UkYudRbeHUvvfbNlN0yCHxFf4AgeECV
 ChhUEuMLKo0rfMjy8bc8kfehEY7EETEX6Ovz1UJ2Cn5jRNqYxiBuX0UYYRFW/vNqMEQI
 ruhjpD61rjioPTt7fcB6wgNSipFi9IDcaquJLuni/b2i4Ah4NkzDcRYr6kQz6gcquodz
 6J3VKUpTM5PaLN2pCKu6sNB4xAcbOhF9gLIQK9mW5UXpPH1wsveWm0k7y2nxRl8cqnYw
 8SfvLdSNjN2z5qgEosu51lyQ3+qVibrDd+xk0eVLxEff/KgF3eVWbvlUmtRX8NO4+t+k
 BGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699380619; x=1699985419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lerGkvWs+2MRxdzE0DMBKiSOqV9ui2+nfnjyOq/W8aE=;
 b=FzFX8po+LYLsYbAN504qHTubb/WFeFuVbIJczwQLPIKnOIba5hHMYrvcBbuZiF2M+6
 kHaf00sN17d2GcLIY/KU8+nLOKilx1fytBgVfleqGPFepuq0KHJ4T0gHOVXjwnzTz5uv
 5E04rP/GwcWyVXJUdlB8mPIrNWaEgEue0MwSQdqMN4p17MR8e4l2aG7wyigpVuppPrM6
 opEsZ/6WtZ6cKTX0mYy1VgUL14mJBzsidRPLReGWDmGUtJ1nyxJ+xJMhU71DnbA+UIr1
 JZXeYlYOcXW6g58BwCMR56fzGKSYrTjDBCQoc+JS3v79KBS/S8QdcsTEKXMzLseX/7p4
 XEIg==
X-Gm-Message-State: AOJu0YyY3hylDvw/FgpuxA35jexTmqxCNAcR6acvL5p6xFlNdOH3n6j5
 0Byl9ugJ32nUz/vWKBjLIPL7rLzIBdg=
X-Google-Smtp-Source: AGHT+IE9CVDa0uPYwQ3dK4HiagUY1Wab+0CtaMHuuj9jitAwMCnxS1Hx84mPVFs+ql161c+jSgZwkA==
X-Received: by 2002:a17:903:245:b0:1c5:d8a3:8789 with SMTP id
 j5-20020a170903024500b001c5d8a38789mr32291748plh.4.1699380618992; 
 Tue, 07 Nov 2023 10:10:18 -0800 (PST)
Received: from DT.local (c-71-202-158-162.hsd1.ca.comcast.net.
 [71.202.158.162]) by smtp.gmail.com with ESMTPSA id
 az10-20020a170902a58a00b001cc615e6850sm131924plb.90.2023.11.07.10.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 10:10:18 -0800 (PST)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 ira.weiny@intel.com, dan.j.williams@intel.com, a.manzanares@samsung.com,
 dave@stgolabs.net, nmtadam.samsung@gmail.com, nifan@outlook.com,
 jim.harris@samsung.com, Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v3 3/9] include/hw/cxl/cxl_device: Rename mem_size as
 static_mem_size for type3 memory devices
Date: Tue,  7 Nov 2023 10:07:07 -0800
Message-ID: <20231107180907.553451-4-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107180907.553451-1-nifan.cxl@gmail.com>
References: <20231107180907.553451-1-nifan.cxl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x62f.google.com
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

From: Fan Ni <fan.ni@samsung.com>

Rename mem_size as static_mem_size for type3 memdev to cover static RAM and
pmem capacity, preparing for the introduction of dynamic capacity to support
dynamic capacity devices.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 4 ++--
 hw/mem/cxl_type3.c          | 8 ++++----
 include/hw/cxl/cxl_device.h | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index f80dd6474f..707fd9fe7f 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -774,7 +774,7 @@ static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
     snprintf(id->fw_revision, 0x10, "BWFW VERSION %02d", 0);
 
     stq_le_p(&id->total_capacity,
-             cxl_dstate->mem_size / CXL_CAPACITY_MULTIPLIER);
+            cxl_dstate->static_mem_size / CXL_CAPACITY_MULTIPLIER);
     stq_le_p(&id->persistent_capacity,
              cxl_dstate->pmem_size / CXL_CAPACITY_MULTIPLIER);
     stq_le_p(&id->volatile_capacity,
@@ -1149,7 +1149,7 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
     struct clear_poison_pl *in = (void *)payload_in;
 
     dpa = ldq_le_p(&in->dpa);
-    if (dpa + CXL_CACHE_LINE_SIZE > cxl_dstate->mem_size) {
+    if (dpa + CXL_CACHE_LINE_SIZE > cxl_dstate->static_mem_size) {
         return CXL_MBOX_INVALID_PA;
     }
 
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 6c1ccda159..754c885cd1 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -762,7 +762,7 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
         }
         address_space_init(&ct3d->hostvmem_as, vmr, v_name);
         ct3d->cxl_dstate.vmem_size = memory_region_size(vmr);
-        ct3d->cxl_dstate.mem_size += memory_region_size(vmr);
+        ct3d->cxl_dstate.static_mem_size += memory_region_size(vmr);
         g_free(v_name);
     }
 
@@ -785,7 +785,7 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
         }
         address_space_init(&ct3d->hostpmem_as, pmr, p_name);
         ct3d->cxl_dstate.pmem_size = memory_region_size(pmr);
-        ct3d->cxl_dstate.mem_size += memory_region_size(pmr);
+        ct3d->cxl_dstate.static_mem_size += memory_region_size(pmr);
         g_free(p_name);
     }
 
@@ -1008,7 +1008,7 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
         return -EINVAL;
     }
 
-    if (*dpa_offset > ct3d->cxl_dstate.mem_size) {
+    if (*dpa_offset > ct3d->cxl_dstate.static_mem_size) {
         return -EINVAL;
     }
 
@@ -1188,7 +1188,7 @@ static bool set_cacheline(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data)
         return false;
     }
 
-    if (dpa_offset + CXL_CACHE_LINE_SIZE > ct3d->cxl_dstate.mem_size) {
+    if (dpa_offset + CXL_CACHE_LINE_SIZE > ct3d->cxl_dstate.static_mem_size) {
         return false;
     }
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 334c51fddb..de6469eef7 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -232,7 +232,7 @@ typedef struct cxl_device_state {
     } timestamp;
 
     /* memory region size, HDM */
-    uint64_t mem_size;
+    uint64_t static_mem_size;
     uint64_t pmem_size;
     uint64_t vmem_size;
     bool is_dcd;
-- 
2.42.0


