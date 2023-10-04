Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6517F7B7ABE
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:52:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxXo-00028W-Op; Wed, 04 Oct 2023 04:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxWf-0000TX-Vy
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:46:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxW8-0002Qi-7y
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:46:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kyfnCvsIX4E7yWhRK6zqkwHetRbe30XKve0rXp69lrk=;
 b=I9CPlzG901bgLcTP+SCB+wckywCMiwS4ao5E63JXqLdVoxUgeYkdCGHKDs3JZPdv1ssNl5
 8HGp7VVzeF9lzggxbPUhaVq6Mx5cblCx2CLAUSr2+vDBHN58i+xwhHcAJviQ9Ne3ZUiV+a
 y5UCsbZGn5mpHxTl2dsUO0Nus76wf+I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-_RWVp9R-MRexOctDa5vmOw-1; Wed, 04 Oct 2023 04:45:47 -0400
X-MC-Unique: _RWVp9R-MRexOctDa5vmOw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-323306960e3so1346544f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:45:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409145; x=1697013945;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kyfnCvsIX4E7yWhRK6zqkwHetRbe30XKve0rXp69lrk=;
 b=pUvVadjZT+CempiEwUH7Jb4jAOOXX7E3hPRO+4EPur+z4wDQWPXYiM4ZH0VzgJIyeu
 l+AiBL62LweinIeafkZOy5l6WMlznKPmJyVyY8OOhRbt7EmIfYczcV/5gcseM2eFcZAT
 jjn6Ko8Fd5WPc1qYmme+1T33YxU1dCFcIn93hey77PEo7CaLdTyV3pt2FT5fA9WOuY6h
 tLfAJcJLUFQ0u6QuduXuLACMxZXAdaJmhwEyi5+Qd3fD5D4mJ/YEEUZNeJf2jyFyi4sd
 0MrNhB2bzH39ZEqXG/qak0lyaCDfH0QX17EsMU063GsV89e3+lAthQL19wb5ait8qHRE
 DWPw==
X-Gm-Message-State: AOJu0YxELzNQmyE+ydfFuxZkSctGMCrxrv92KKRqmKLnIr2bUPBKSpIy
 D0SDMyNWRBZWlE6eeuRK3UuXyc7vt+aeJzZj6IE1DIvW3EO18vYtNrgqhcwYQMs7ik4K90MoiGQ
 q5QvnTk8Gxrc6IN21BFGbBzSWTBhlbLjVi/iFzQEv7T7wsdrvop7bPWd7QPFuSAqgyRy1
X-Received: by 2002:a05:6000:14e:b0:324:8700:6421 with SMTP id
 r14-20020a056000014e00b0032487006421mr1479583wrx.3.1696409145404; 
 Wed, 04 Oct 2023 01:45:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhwLW+BtZlh162Cdnh4UI9a66SZlOZgcNqQYo4t/VOlDfGymOE4w6mhuPQ1JK5jqCZbXZOIg==
X-Received: by 2002:a05:6000:14e:b0:324:8700:6421 with SMTP id
 r14-20020a056000014e00b0032487006421mr1479562wrx.3.1696409145083; 
 Wed, 04 Oct 2023 01:45:45 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 f14-20020adff44e000000b0032318649b21sm3468393wrp.31.2023.10.04.01.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:45:44 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:45:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 47/63] hw/cxl: Fix and use same calculation for HDM decoder
 block size everywhere
Message-ID: <1fa7342c24fe57b100e0b87ad30113ed65e5eaf1.1696408966.git.mst@redhat.com>
References: <cover.1696408966.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696408966.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
--
v3:
New patch to separate this out from the addition of HDM decoders.
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


