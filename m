Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3687B7B9A6E
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:49:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFJH-0000Co-0L; Wed, 04 Oct 2023 23:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFId-0008CO-Mt
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:45:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFIZ-0000Zt-8s
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+N+lNMpkEjKdJBqhd8tq0zRr/7ZhtN44x4UhMyv0UqU=;
 b=RpSvaogAt+NSKHX1GQVPtlbPtfE43HlY0TDGtMtloSkiapp/0BZhBpFA1THve+mSWevhpw
 dRX+bpKT+a4mq1+l5gfRqAfkwiauUZ476Qe96gOSHrxMkxu31CJnhpkpyHWIYjhMmlt7YL
 RMX4I+yPYDDr4RncD94M9VEdMQDiWxc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-qDqTynlhMuqKIg0xdABTCw-1; Wed, 04 Oct 2023 23:45:06 -0400
X-MC-Unique: qDqTynlhMuqKIg0xdABTCw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31fd48da316so398378f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477505; x=1697082305;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+N+lNMpkEjKdJBqhd8tq0zRr/7ZhtN44x4UhMyv0UqU=;
 b=NDoKVGmW3l38NgsNQr19agoHnL0BIHcLpTLtUO88Skk2DA20ye/lGmzvUbNPWGcIMs
 27XsjAGfBE3HBC+aF5PMjzmHTQG6Mj2tnatvRMehFlty0Am1xyjT9fiCRSYu08jB64Ty
 6qbaICa2O4xIOBppkwJRR/LMc0OyHcMDFrg9r4OeuxVNQfoH/0YzedM11ffX0V2eNn08
 Lnf/hjN6O3yg5JM/1YHT7Qbsu9XxKfA3tUxWGEaLX0q2+4PQGGOnDIlze7uqglXyjTHB
 HE4w6sXi+zPk5cobKzWmxDTcX63Qa6SKLlJLmLkD+m65CnPl9Dc0CDh8DimebQCQIxfv
 263A==
X-Gm-Message-State: AOJu0YwmvbZkO/J5Yk6kF/2o7rcBVp2H1oc52lx633w1jfeY41T7m984
 3Xypcq2qr1NsnhVHz+TTNkMWiBqfTnfoDAcLF5zZ1mtohnAacG3fRStlhReY8BP7hLt5kxGQTlM
 qGFs8KK6v4oDTYf1friVLQq+Dmcgx2cpoNjsQzJWEOltpddskD08utHQKUKsdkO4Ti2Go
X-Received: by 2002:adf:e892:0:b0:31f:f72c:dfa3 with SMTP id
 d18-20020adfe892000000b0031ff72cdfa3mr4094501wrm.68.1696477505054; 
 Wed, 04 Oct 2023 20:45:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdXZU+P3HsBPLdbKwt2L6dOiWbhRD3164R0c/vwVYY+IhB5u6/V7KKuZAXFL1ZLp53DF4wUA==
X-Received: by 2002:adf:e892:0:b0:31f:f72c:dfa3 with SMTP id
 d18-20020adfe892000000b0031ff72cdfa3mr4094490wrm.68.1696477504764; 
 Wed, 04 Oct 2023 20:45:04 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 w11-20020a5d680b000000b0031c6e1ea4c7sm622928wru.90.2023.10.04.20.45.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:45:04 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:45:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL v2 38/53] hw/cxl: Support 4 HDM decoders at all levels of
 topology
Message-ID: <e967413fe0f2f3fe022658bb279aef95d24210ec.1696477105.git.mst@redhat.com>
References: <cover.1696477105.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696477105.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Support these decoders in CXL host bridges (pxb-cxl), CXL Switch USP
and CXL Type 3 end points.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Message-Id: <20230913132523.29780-5-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_component.h | 10 +++-
 hw/cxl/cxl-component-utils.c   |  7 ++-
 hw/cxl/cxl-host.c              | 67 +++++++++++++++--------
 hw/mem/cxl_type3.c             | 98 +++++++++++++++++++++++-----------
 4 files changed, 125 insertions(+), 57 deletions(-)

diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index 7c864d2044..3c795a6278 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -135,6 +135,10 @@ REG32(CXL_RAS_ERR_HEADER0, CXL_RAS_REGISTERS_OFFSET + 0x18)
   REG32(CXL_HDM_DECODER##n##_TARGET_LIST_LO,                                   \
         CXL_HDM_REGISTERS_OFFSET + (0x20 * n) + 0x24)                          \
   REG32(CXL_HDM_DECODER##n##_TARGET_LIST_HI,                                   \
+        CXL_HDM_REGISTERS_OFFSET + (0x20 * n) + 0x28)                          \
+  REG32(CXL_HDM_DECODER##n##_DPA_SKIP_LO,                                      \
+        CXL_HDM_REGISTERS_OFFSET + (0x20 * n) + 0x24)                          \
+  REG32(CXL_HDM_DECODER##n##_DPA_SKIP_HI,                                      \
         CXL_HDM_REGISTERS_OFFSET + (0x20 * n) + 0x28)
 
 REG32(CXL_HDM_DECODER_CAPABILITY, CXL_HDM_REGISTERS_OFFSET)
@@ -147,9 +151,13 @@ REG32(CXL_HDM_DECODER_GLOBAL_CONTROL, CXL_HDM_REGISTERS_OFFSET + 4)
     FIELD(CXL_HDM_DECODER_GLOBAL_CONTROL, POISON_ON_ERR_EN, 0, 1)
     FIELD(CXL_HDM_DECODER_GLOBAL_CONTROL, HDM_DECODER_ENABLE, 1, 1)
 
+/* Support 4 decoders at all levels of topology */
+#define CXL_HDM_DECODER_COUNT 4
+
 HDM_DECODER_INIT(0);
-/* Only used for HDM decoder registers block address increment */
 HDM_DECODER_INIT(1);
+HDM_DECODER_INIT(2);
+HDM_DECODER_INIT(3);
 
 /* 8.2.5.13 - CXL Extended Security Capability Structure (Root complex only) */
 #define EXTSEC_ENTRY_MAX        256
diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index c0630ba5c1..f3bbf0fd13 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -90,6 +90,9 @@ static void dumb_hdm_handler(CXLComponentState *cxl_cstate, hwaddr offset,
 
     switch (offset) {
     case A_CXL_HDM_DECODER0_CTRL:
+    case A_CXL_HDM_DECODER1_CTRL:
+    case A_CXL_HDM_DECODER2_CTRL:
+    case A_CXL_HDM_DECODER3_CTRL:
         should_commit = FIELD_EX32(value, CXL_HDM_DECODER0_CTRL, COMMIT);
         should_uncommit = !should_commit;
         break;
@@ -129,7 +132,7 @@ static void cxl_cache_mem_write_reg(void *opaque, hwaddr offset, uint64_t value,
     }
 
     if (offset >= A_CXL_HDM_DECODER_CAPABILITY &&
-        offset <= A_CXL_HDM_DECODER0_TARGET_LIST_HI) {
+        offset <= A_CXL_HDM_DECODER3_TARGET_LIST_HI) {
         dumb_hdm_handler(cxl_cstate, offset, value);
     } else {
         cregs->cache_mem_registers[offset / sizeof(*cregs->cache_mem_registers)] = value;
@@ -209,7 +212,7 @@ static void ras_init_common(uint32_t *reg_state, uint32_t *write_msk)
 static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
                             enum reg_type type)
 {
-    int decoder_count = 1;
+    int decoder_count = CXL_HDM_DECODER_COUNT;
     int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
     int i;
 
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index 73c5426476..2aa776c79c 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -97,35 +97,58 @@ void cxl_fmws_link_targets(CXLState *cxl_state, Error **errp)
     }
 }
 
-/* TODO: support, multiple hdm decoders */
 static bool cxl_hdm_find_target(uint32_t *cache_mem, hwaddr addr,
                                 uint8_t *target)
 {
     int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
-    uint32_t ctrl;
-    uint32_t ig_enc;
-    uint32_t iw_enc;
-    uint32_t target_idx;
-    int i = 0;
+    unsigned int hdm_count;
+    bool found = false;
+    int i;
+    uint32_t cap;
 
-    ctrl = cache_mem[R_CXL_HDM_DECODER0_CTRL + i * hdm_inc];
-    if (!FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED)) {
-        return false;
+    cap = ldl_le_p(cache_mem + R_CXL_HDM_DECODER_CAPABILITY);
+    hdm_count = cxl_decoder_count_dec(FIELD_EX32(cap,
+                                                 CXL_HDM_DECODER_CAPABILITY,
+                                                 DECODER_COUNT));
+    for (i = 0; i < hdm_count; i++) {
+        uint32_t ctrl, ig_enc, iw_enc, target_idx;
+        uint32_t low, high;
+        uint64_t base, size;
+
+        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_LO + i * hdm_inc);
+        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_HI + i * hdm_inc);
+        base = (low & 0xf0000000) | ((uint64_t)high << 32);
+        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_LO + i * hdm_inc);
+        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_HI + i * hdm_inc);
+        size = (low & 0xf0000000) | ((uint64_t)high << 32);
+        if (addr < base || addr >= base + size) {
+            continue;
+        }
+
+        ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + i * hdm_inc);
+        if (!FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED)) {
+            return false;
+        }
+        found = true;
+        ig_enc = FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IG);
+        iw_enc = FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IW);
+        target_idx = (addr / cxl_decode_ig(ig_enc)) % (1 << iw_enc);
+
+        if (target_idx < 4) {
+            uint32_t val = ldl_le_p(cache_mem +
+                                    R_CXL_HDM_DECODER0_TARGET_LIST_LO +
+                                    i * hdm_inc);
+            *target = extract32(val, target_idx * 8, 8);
+        } else {
+            uint32_t val = ldl_le_p(cache_mem +
+                                    R_CXL_HDM_DECODER0_TARGET_LIST_HI +
+                                    i * hdm_inc);
+            *target = extract32(val, (target_idx - 4) * 8, 8);
+        }
+        break;
     }
 
-    ig_enc = FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IG);
-    iw_enc = FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IW);
-    target_idx = (addr / cxl_decode_ig(ig_enc)) % (1 << iw_enc);
-
-    if (target_idx < 4) {
-        *target = extract32(cache_mem[R_CXL_HDM_DECODER0_TARGET_LIST_LO],
-                            target_idx * 8, 8);
-    } else {
-        *target = extract32(cache_mem[R_CXL_HDM_DECODER0_TARGET_LIST_HI],
-                            (target_idx - 4) * 8, 8);
-    }
-
-    return true;
+    return found;
 }
 
 static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 9f3022189b..c02be4ce45 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -393,8 +393,6 @@ static void hdm_decoder_commit(CXLType3Dev *ct3d, int which)
     uint32_t *cache_mem = cregs->cache_mem_registers;
     uint32_t ctrl;
 
-    assert(which == 0);
-
     ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_inc);
     /* TODO: Sanity checks that the decoder is possible */
     ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, ERR, 0);
@@ -410,8 +408,6 @@ static void hdm_decoder_uncommit(CXLType3Dev *ct3d, int which)
     uint32_t *cache_mem = cregs->cache_mem_registers;
     uint32_t ctrl;
 
-    assert(which == 0);
-
     ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_inc);
 
     ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, ERR, 0);
@@ -500,6 +496,21 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
         should_uncommit = !should_commit;
         which_hdm = 0;
         break;
+    case A_CXL_HDM_DECODER1_CTRL:
+        should_commit = FIELD_EX32(value, CXL_HDM_DECODER0_CTRL, COMMIT);
+        should_uncommit = !should_commit;
+        which_hdm = 1;
+        break;
+    case A_CXL_HDM_DECODER2_CTRL:
+        should_commit = FIELD_EX32(value, CXL_HDM_DECODER0_CTRL, COMMIT);
+        should_uncommit = !should_commit;
+        which_hdm = 2;
+        break;
+    case A_CXL_HDM_DECODER3_CTRL:
+        should_commit = FIELD_EX32(value, CXL_HDM_DECODER0_CTRL, COMMIT);
+        should_uncommit = !should_commit;
+        which_hdm = 3;
+        break;
     case A_CXL_RAS_UNC_ERR_STATUS:
     {
         uint32_t capctrl = ldl_le_p(cache_mem + R_CXL_RAS_ERR_CAP_CTRL);
@@ -771,40 +782,63 @@ static void ct3_exit(PCIDevice *pci_dev)
     }
 }
 
-/* TODO: Support multiple HDM decoders and DPA skip */
 static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64_t *dpa)
 {
     int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
     uint32_t *cache_mem = ct3d->cxl_cstate.crb.cache_mem_registers;
-    uint64_t decoder_base, decoder_size, hpa_offset;
-    uint32_t hdm0_ctrl;
-    int ig, iw;
-    int i = 0;
+    unsigned int hdm_count;
+    uint32_t cap;
+    uint64_t dpa_base = 0;
+    int i;
 
-    decoder_base =
-        (((uint64_t)cache_mem[R_CXL_HDM_DECODER0_BASE_HI + i * hdm_inc] << 32) |
-                    cache_mem[R_CXL_HDM_DECODER0_BASE_LO + i * hdm_inc]);
-    if ((uint64_t)host_addr < decoder_base) {
-        return false;
+    cap = ldl_le_p(cache_mem + R_CXL_HDM_DECODER_CAPABILITY);
+    hdm_count = cxl_decoder_count_dec(FIELD_EX32(cap,
+                                                 CXL_HDM_DECODER_CAPABILITY,
+                                                 DECODER_COUNT));
+
+    for (i = 0; i < hdm_count; i++) {
+        uint64_t decoder_base, decoder_size, hpa_offset, skip;
+        uint32_t hdm_ctrl, low, high;
+        int ig, iw;
+
+        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_LO + i * hdm_inc);
+        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_HI + i * hdm_inc);
+        decoder_base = ((uint64_t)high << 32) | (low & 0xf0000000);
+
+        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_LO + i * hdm_inc);
+        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_HI + i * hdm_inc);
+        decoder_size = ((uint64_t)high << 32) | (low & 0xf0000000);
+
+        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_DPA_SKIP_LO +
+                       i * hdm_inc);
+        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_DPA_SKIP_HI +
+                        i * hdm_inc);
+        skip = ((uint64_t)high << 32) | (low & 0xf0000000);
+        dpa_base += skip;
+
+        hpa_offset = (uint64_t)host_addr - decoder_base;
+
+        hdm_ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + i * hdm_inc);
+        iw = FIELD_EX32(hdm_ctrl, CXL_HDM_DECODER0_CTRL, IW);
+        ig = FIELD_EX32(hdm_ctrl, CXL_HDM_DECODER0_CTRL, IG);
+        if (!FIELD_EX32(hdm_ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED)) {
+            return false;
+        }
+        if (((uint64_t)host_addr < decoder_base) ||
+            (hpa_offset >= decoder_size)) {
+            dpa_base += decoder_size /
+                cxl_interleave_ways_dec(iw, &error_fatal);
+            continue;
+        }
+
+        *dpa = dpa_base +
+            ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
+             ((MAKE_64BIT_MASK(8 + ig + iw, 64 - 8 - ig - iw) & hpa_offset)
+              >> iw));
+
+        return true;
     }
-
-    hpa_offset = (uint64_t)host_addr - decoder_base;
-
-    decoder_size =
-        ((uint64_t)cache_mem[R_CXL_HDM_DECODER0_SIZE_HI + i * hdm_inc] << 32) |
-        cache_mem[R_CXL_HDM_DECODER0_SIZE_LO + i * hdm_inc];
-    if (hpa_offset >= decoder_size) {
-        return false;
-    }
-
-    hdm0_ctrl = cache_mem[R_CXL_HDM_DECODER0_CTRL + i * hdm_inc];
-    iw = FIELD_EX32(hdm0_ctrl, CXL_HDM_DECODER0_CTRL, IW);
-    ig = FIELD_EX32(hdm0_ctrl, CXL_HDM_DECODER0_CTRL, IG);
-
-    *dpa = (MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
-        ((MAKE_64BIT_MASK(8 + ig + iw, 64 - 8 - ig - iw) & hpa_offset) >> iw);
-
-    return true;
+    return false;
 }
 
 static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
-- 
MST


