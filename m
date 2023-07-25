Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B887610C7
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 12:26:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOFEd-0000RF-Hl; Tue, 25 Jul 2023 06:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qOFE6-0000Ge-UO
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 06:25:11 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qOFE4-0007V3-MI
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 06:25:10 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-4fdfefdf5abso1234618e87.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 03:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690280705; x=1690885505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1Jm/TnD4O7VFYNm2su9Cb/vD/nMW66SkothMb1GxbsM=;
 b=VWSJ3nR/xVwi9T59lWXCEp41Dpkk8vZ6zqhcsrryL5CEoLRPcpAG2Hk7BoqLjRAaXI
 o2QdrLn3E0CqcSvi0mggkLMGMlUb10s8NTzZko/DX20imaVDGOiY3Wtl/YDpw+u8nrpl
 ZEW/VXuGJ/ZNHZFtlZ5NRjnDPWFpV2ZhiHscMUAuyW0dxUq0+hE/uo6mtQ9q4efkMjgA
 6mQBubu2y896guVPy0XfeGFw6Wxi6sJ8Ap8w5Wv26wwoFVfEUSycZ7suBpksWQO7mcXl
 NKsPiXLLY217TJN2SH3xunDMwRxqzkb3KgvEE/qqGWn3XJLcJVT8l28afR8CWB0rSwsO
 cwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690280705; x=1690885505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Jm/TnD4O7VFYNm2su9Cb/vD/nMW66SkothMb1GxbsM=;
 b=E0FybhT8YjKUY12OC0D0h/1rwQoz/eQMn9oaq6jshf67ulY+eVtu+XPqFVgCLCSGIT
 AQELuP6b9T9rnZCKMx2DDsMOtROHRu3sB6UGE1JeJrwSRZf1CX2shofKsGvZCH4VSyAV
 KbYhzmRIbZcYMVq9EpovgEvuNCL4zBoRYqWXDxRsZV3sWP16/gQRY5tMtffis1LHzJxQ
 Ylp6hW5shtYcw7m2RoaGb4XKwt1XaiS5CSq2Q2Ll6/fKRnNSuYehtHOjZ/hJE8IAs7Rs
 pOt88pjZzEnb36E8aY5HPASL8/DPQ8vHlh1e4inumFR5wSk7ALdBtaww8jlX2oKUw/07
 1U6w==
X-Gm-Message-State: ABy/qLYkEVjt00waPTakWjAtYyfwpXsE4I2vLPDb99zN4XqmkWcilp4k
 shyK3bRz3Mx+72gsdEu4zdFyKvLc3hBrRg++Zw8=
X-Google-Smtp-Source: APBJJlHoeXQREd0vC9uVBiJWgpIaO/nz05o/LfRpCT+BS3KHMxRhKexiDNLezkT3fK6Z0PcPZEsOtA==
X-Received: by 2002:ac2:5e7b:0:b0:4f9:5711:2eb8 with SMTP id
 a27-20020ac25e7b000000b004f957112eb8mr6364981lfr.33.1690280705568; 
 Tue, 25 Jul 2023 03:25:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 u19-20020a05600c211300b003fbc30825fbsm12567185wml.39.2023.07.25.03.25.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jul 2023 03:25:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/5] hw/arm/smmu: Handle big-endian hosts correctly
Date: Tue, 25 Jul 2023 11:24:59 +0100
Message-Id: <20230725102503.2283907-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230725102503.2283907-1-peter.maydell@linaro.org>
References: <20230725102503.2283907-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The implementation of the SMMUv3 has multiple places where it reads a
data structure from the guest and directly operates on it without
doing a guest-to-host endianness conversion.  Since all SMMU data
structures are little-endian, this means that the SMMU doesn't work
on a big-endian host.  In particular, this causes the Avocado test
  machine_aarch64_virt.py:Aarch64VirtMachine.test_alpine_virt_tcg_gic_max
to fail on an s390x host.

Add appropriate byte-swapping on reads and writes of guest in-memory
data structures so that the device works correctly on big-endian
hosts.

As part of this we constrain queue_read() to operate only on Cmd
structs and queue_write() on Evt structs, because in practice these
are the only data structures the two functions are used with, and we
need to know what the data structure is to be able to byte-swap its
parts correctly.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20230717132641.764660-1-peter.maydell@linaro.org
Cc: qemu-stable@nongnu.org
---
 hw/arm/smmu-common.c |  3 +--
 hw/arm/smmuv3.c      | 39 +++++++++++++++++++++++++++++++--------
 2 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 5ab9d45d58a..f35ae9aa22c 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -216,8 +216,7 @@ static int get_pte(dma_addr_t baseaddr, uint32_t index, uint64_t *pte,
     dma_addr_t addr = baseaddr + index * sizeof(*pte);
 
     /* TODO: guarantee 64-bit single-copy atomicity */
-    ret = dma_memory_read(&address_space_memory, addr, pte, sizeof(*pte),
-                          MEMTXATTRS_UNSPECIFIED);
+    ret = ldq_le_dma(&address_space_memory, addr, pte, MEMTXATTRS_UNSPECIFIED);
 
     if (ret != MEMTX_OK) {
         info->type = SMMU_PTW_ERR_WALK_EABT;
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 932f0096974..1e9be8e89af 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -102,20 +102,34 @@ static void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t new_gerrorn)
     trace_smmuv3_write_gerrorn(toggled & pending, s->gerrorn);
 }
 
-static inline MemTxResult queue_read(SMMUQueue *q, void *data)
+static inline MemTxResult queue_read(SMMUQueue *q, Cmd *cmd)
 {
     dma_addr_t addr = Q_CONS_ENTRY(q);
+    MemTxResult ret;
+    int i;
 
-    return dma_memory_read(&address_space_memory, addr, data, q->entry_size,
-                           MEMTXATTRS_UNSPECIFIED);
+    ret = dma_memory_read(&address_space_memory, addr, cmd, sizeof(Cmd),
+                          MEMTXATTRS_UNSPECIFIED);
+    if (ret != MEMTX_OK) {
+        return ret;
+    }
+    for (i = 0; i < ARRAY_SIZE(cmd->word); i++) {
+        le32_to_cpus(&cmd->word[i]);
+    }
+    return ret;
 }
 
-static MemTxResult queue_write(SMMUQueue *q, void *data)
+static MemTxResult queue_write(SMMUQueue *q, Evt *evt_in)
 {
     dma_addr_t addr = Q_PROD_ENTRY(q);
     MemTxResult ret;
+    Evt evt = *evt_in;
+    int i;
 
-    ret = dma_memory_write(&address_space_memory, addr, data, q->entry_size,
+    for (i = 0; i < ARRAY_SIZE(evt.word); i++) {
+        cpu_to_le32s(&evt.word[i]);
+    }
+    ret = dma_memory_write(&address_space_memory, addr, &evt, sizeof(Evt),
                            MEMTXATTRS_UNSPECIFIED);
     if (ret != MEMTX_OK) {
         return ret;
@@ -298,7 +312,7 @@ static void smmuv3_init_regs(SMMUv3State *s)
 static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
                         SMMUEventInfo *event)
 {
-    int ret;
+    int ret, i;
 
     trace_smmuv3_get_ste(addr);
     /* TODO: guarantee 64-bit single-copy atomicity */
@@ -311,6 +325,9 @@ static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
         event->u.f_ste_fetch.addr = addr;
         return -EINVAL;
     }
+    for (i = 0; i < ARRAY_SIZE(buf->word); i++) {
+        le32_to_cpus(&buf->word[i]);
+    }
     return 0;
 
 }
@@ -320,7 +337,7 @@ static int smmu_get_cd(SMMUv3State *s, STE *ste, uint32_t ssid,
                        CD *buf, SMMUEventInfo *event)
 {
     dma_addr_t addr = STE_CTXPTR(ste);
-    int ret;
+    int ret, i;
 
     trace_smmuv3_get_cd(addr);
     /* TODO: guarantee 64-bit single-copy atomicity */
@@ -333,6 +350,9 @@ static int smmu_get_cd(SMMUv3State *s, STE *ste, uint32_t ssid,
         event->u.f_ste_fetch.addr = addr;
         return -EINVAL;
     }
+    for (i = 0; i < ARRAY_SIZE(buf->word); i++) {
+        le32_to_cpus(&buf->word[i]);
+    }
     return 0;
 }
 
@@ -569,7 +589,7 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
         return -EINVAL;
     }
     if (s->features & SMMU_FEATURE_2LVL_STE) {
-        int l1_ste_offset, l2_ste_offset, max_l2_ste, span;
+        int l1_ste_offset, l2_ste_offset, max_l2_ste, span, i;
         dma_addr_t l1ptr, l2ptr;
         STEDesc l1std;
 
@@ -593,6 +613,9 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
             event->u.f_ste_fetch.addr = l1ptr;
             return -EINVAL;
         }
+        for (i = 0; i < ARRAY_SIZE(l1std.word); i++) {
+            le32_to_cpus(&l1std.word[i]);
+        }
 
         span = L1STD_SPAN(&l1std);
 
-- 
2.34.1


