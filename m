Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 535F07B9A67
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:48:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFJN-0000WR-BC; Wed, 04 Oct 2023 23:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFIb-00089x-Ld
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:45:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFIT-0000ZM-PM
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0W6Fdc0oix3rjcRdzJQ1BiHNbQ66pyOxf8XxOBiZdcE=;
 b=LiYbrt9LKAcYm2YYa6PQoth1trX0JL4V1OvzJix9HYuNvAIBQUdD75oCRb5gb2HyUCAORc
 pm0RyV6/2CYo52qD5n38MTHddL/SrAtZVtAYAaoqX+S4hHoaLyFvc/TlbXISDpd3Ng46w3
 PyIxaSTEnWsB8Jdr6MZRkrdux7AYY4c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-xt5o0OC_P_qyrtP_pZMAqw-1; Wed, 04 Oct 2023 23:45:03 -0400
X-MC-Unique: xt5o0OC_P_qyrtP_pZMAqw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3232c3df248so394597f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477501; x=1697082301;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0W6Fdc0oix3rjcRdzJQ1BiHNbQ66pyOxf8XxOBiZdcE=;
 b=Bz3gYG25feQuWdGKgU2JhXsgd1Njt6loO4NduBojYGM8NTXTknvkbXu2NwL6yG5XGi
 F57cEd7tfqJ/Tp5txljW3PNLdgx5eaq8WeZx87RulyrETkB0wnbfq2Qh1Em3O8+lKmR4
 jrywFwDFnkDoImv7dmSnrZ2WUmP6nfEunrV1Gra4jz2UF1u0fdw+IFn8g0aRWSHkN7j+
 /tfR1AtRD/pIG6ao/3E7JoUO6GiCJFVJCDWKQVh7/KWUKZwnMk5YOn0Vty9JbtMTxdMK
 ZImQ2ukesEPIXc3rkMkKOdZHVC3KdwgJ1X5E1kPkqQe760VOPGtXXQLEJr51iK9kfyy3
 kwJw==
X-Gm-Message-State: AOJu0YxsUSYDSkW+kl4EaGQ/YKMu4LzMvSzJTrwoZHok8ArWM/7PPv9B
 PTcP2BXquDzfKZWOmym5lUAACiFkPH2jR6UfpP1kWkO7rfAdSYjIM5r3dEPKDUqWLSg0cO+tIXW
 Hp72rDwZypqI5AoCXS73GrKbOBVLflKCJmqiq3BJJDekeXfprfSiE8awrf5Uj1nExe8pW
X-Received: by 2002:a5d:46c8:0:b0:323:117b:9780 with SMTP id
 g8-20020a5d46c8000000b00323117b9780mr3466328wrs.66.1696477501627; 
 Wed, 04 Oct 2023 20:45:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaO0vMjcYp8uojAdkFUe4RbHVjqtrZdzGqpAqQOoVoHhFhSSH2pwvJl+L8Iuxcth4Ma7LDHg==
X-Received: by 2002:a5d:46c8:0:b0:323:117b:9780 with SMTP id
 g8-20020a5d46c8000000b00323117b9780mr3466316wrs.66.1696477501226; 
 Wed, 04 Oct 2023 20:45:01 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 k8-20020a5d5188000000b003197869bcd7sm635012wrv.13.2023.10.04.20.44.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:45:00 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:44:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 37/53] hw/cxl: Fix and use same calculation for HDM decoder
 block size everywhere
Message-ID: <61c44bcf510f4db51c28d0288e528cfdf0ebabc3.1696477105.git.mst@redhat.com>
References: <cover.1696477105.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

In order to avoid having the size of the per HDM decoder register block
repeated in lots of places, create the register definitions for HDM
decoder 1 and use the offset between the first registers in HDM decoder 0 and
HDM decoder 1 to establish the offset.

Calculate in each function as this is more obvious and leads to shorter
line lengths than a single #define which would need a long name
to be specific enough.

Note that the code currently only supports one decoder, so the bugs this
fixes don't actually affect anything.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230913132523.29780-4-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_component.h |  2 ++
 hw/cxl/cxl-component-utils.c   | 19 +++++++++++--------
 hw/cxl/cxl-host.c              |  4 +++-
 hw/mem/cxl_type3.c             | 24 +++++++++++++++---------
 4 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index ef9e033919..7c864d2044 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -148,6 +148,8 @@ REG32(CXL_HDM_DECODER_GLOBAL_CONTROL, CXL_HDM_REGISTERS_OFFSET + 4)
     FIELD(CXL_HDM_DECODER_GLOBAL_CONTROL, HDM_DECODER_ENABLE, 1, 1)
 
 HDM_DECODER_INIT(0);
+/* Only used for HDM decoder registers block address increment */
+HDM_DECODER_INIT(1);
 
 /* 8.2.5.13 - CXL Extended Security Capability Structure (Root complex only) */
 #define EXTSEC_ENTRY_MAX        256
diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index 5f38f2016f..c0630ba5c1 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -210,6 +210,7 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
                             enum reg_type type)
 {
     int decoder_count = 1;
+    int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
     int i;
 
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, DECODER_COUNT,
@@ -222,19 +223,21 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
                      HDM_DECODER_ENABLE, 0);
     write_msk[R_CXL_HDM_DECODER_GLOBAL_CONTROL] = 0x3;
     for (i = 0; i < decoder_count; i++) {
-        write_msk[R_CXL_HDM_DECODER0_BASE_LO + i * 0x20] = 0xf0000000;
-        write_msk[R_CXL_HDM_DECODER0_BASE_HI + i * 0x20] = 0xffffffff;
-        write_msk[R_CXL_HDM_DECODER0_SIZE_LO + i * 0x20] = 0xf0000000;
-        write_msk[R_CXL_HDM_DECODER0_SIZE_HI + i * 0x20] = 0xffffffff;
-        write_msk[R_CXL_HDM_DECODER0_CTRL + i * 0x20] = 0x13ff;
+        write_msk[R_CXL_HDM_DECODER0_BASE_LO + i * hdm_inc] = 0xf0000000;
+        write_msk[R_CXL_HDM_DECODER0_BASE_HI + i * hdm_inc] = 0xffffffff;
+        write_msk[R_CXL_HDM_DECODER0_SIZE_LO + i * hdm_inc] = 0xf0000000;
+        write_msk[R_CXL_HDM_DECODER0_SIZE_HI + i * hdm_inc] = 0xffffffff;
+        write_msk[R_CXL_HDM_DECODER0_CTRL + i * hdm_inc] = 0x13ff;
         if (type == CXL2_DEVICE ||
             type == CXL2_TYPE3_DEVICE ||
             type == CXL2_LOGICAL_DEVICE) {
-            write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_LO + i * 0x20] = 0xf0000000;
+            write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_LO + i * hdm_inc] =
+                0xf0000000;
         } else {
-            write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_LO + i * 0x20] = 0xffffffff;
+            write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_LO + i * hdm_inc] =
+                0xffffffff;
         }
-        write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_HI + i * 0x20] = 0xffffffff;
+        write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_HI + i * hdm_inc] = 0xffffffff;
     }
 }
 
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index f0920da956..73c5426476 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -101,12 +101,14 @@ void cxl_fmws_link_targets(CXLState *cxl_state, Error **errp)
 static bool cxl_hdm_find_target(uint32_t *cache_mem, hwaddr addr,
                                 uint8_t *target)
 {
+    int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
     uint32_t ctrl;
     uint32_t ig_enc;
     uint32_t iw_enc;
     uint32_t target_idx;
+    int i = 0;
 
-    ctrl = cache_mem[R_CXL_HDM_DECODER0_CTRL];
+    ctrl = cache_mem[R_CXL_HDM_DECODER0_CTRL + i * hdm_inc];
     if (!FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED)) {
         return false;
     }
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 4cdcb3f7e7..9f3022189b 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -388,34 +388,36 @@ static void build_dvsecs(CXLType3Dev *ct3d)
 
 static void hdm_decoder_commit(CXLType3Dev *ct3d, int which)
 {
+    int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
     ComponentRegisters *cregs = &ct3d->cxl_cstate.crb;
     uint32_t *cache_mem = cregs->cache_mem_registers;
     uint32_t ctrl;
 
     assert(which == 0);
 
-    ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL);
+    ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_inc);
     /* TODO: Sanity checks that the decoder is possible */
     ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, ERR, 0);
     ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED, 1);
 
-    stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL, ctrl);
+    stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_inc, ctrl);
 }
 
 static void hdm_decoder_uncommit(CXLType3Dev *ct3d, int which)
 {
+    int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
     ComponentRegisters *cregs = &ct3d->cxl_cstate.crb;
     uint32_t *cache_mem = cregs->cache_mem_registers;
     uint32_t ctrl;
 
     assert(which == 0);
 
-    ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL);
+    ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_inc);
 
     ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, ERR, 0);
     ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED, 0);
 
-    stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL, ctrl);
+    stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_inc, ctrl);
 }
 
 static int ct3d_qmp_uncor_err_to_cxl(CxlUncorErrorType qmp_err)
@@ -772,26 +774,30 @@ static void ct3_exit(PCIDevice *pci_dev)
 /* TODO: Support multiple HDM decoders and DPA skip */
 static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64_t *dpa)
 {
+    int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
     uint32_t *cache_mem = ct3d->cxl_cstate.crb.cache_mem_registers;
     uint64_t decoder_base, decoder_size, hpa_offset;
     uint32_t hdm0_ctrl;
     int ig, iw;
+    int i = 0;
 
-    decoder_base = (((uint64_t)cache_mem[R_CXL_HDM_DECODER0_BASE_HI] << 32) |
-                    cache_mem[R_CXL_HDM_DECODER0_BASE_LO]);
+    decoder_base =
+        (((uint64_t)cache_mem[R_CXL_HDM_DECODER0_BASE_HI + i * hdm_inc] << 32) |
+                    cache_mem[R_CXL_HDM_DECODER0_BASE_LO + i * hdm_inc]);
     if ((uint64_t)host_addr < decoder_base) {
         return false;
     }
 
     hpa_offset = (uint64_t)host_addr - decoder_base;
 
-    decoder_size = ((uint64_t)cache_mem[R_CXL_HDM_DECODER0_SIZE_HI] << 32) |
-        cache_mem[R_CXL_HDM_DECODER0_SIZE_LO];
+    decoder_size =
+        ((uint64_t)cache_mem[R_CXL_HDM_DECODER0_SIZE_HI + i * hdm_inc] << 32) |
+        cache_mem[R_CXL_HDM_DECODER0_SIZE_LO + i * hdm_inc];
     if (hpa_offset >= decoder_size) {
         return false;
     }
 
-    hdm0_ctrl = cache_mem[R_CXL_HDM_DECODER0_CTRL];
+    hdm0_ctrl = cache_mem[R_CXL_HDM_DECODER0_CTRL + i * hdm_inc];
     iw = FIELD_EX32(hdm0_ctrl, CXL_HDM_DECODER0_CTRL, IW);
     ig = FIELD_EX32(hdm0_ctrl, CXL_HDM_DECODER0_CTRL, IG);
 
-- 
MST


