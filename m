Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DBD7E38B1
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:18:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J4r-0003FJ-Fg; Tue, 07 Nov 2023 05:12:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J4p-00036s-4q
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:12:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J4n-0002mk-5J
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:12:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699351972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PzmxxvQVtCQlxrdp90CZq+87N/MZN/GaNdzZqugBwa8=;
 b=MxIT/cZF4FhlwkRn8bZYLlQUfRpxLpetp2m9tCS68K8Nf4uZPDv83tqo/0VRpR3tEROTBg
 weGiNcXv8WRqz+4hBfkoqnPogv+UNQ025Txq/Zan8h2VLC8gkIpEl3sdkGevspLKI7xXGR
 vzGGx1G2VOaAqUbBA6OwAnupl5zt7xg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-jbMubMeFMHGgBCMlT_jJlw-1; Tue, 07 Nov 2023 05:12:41 -0500
X-MC-Unique: jbMubMeFMHGgBCMlT_jJlw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32f8371247fso2815000f8f.2
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:12:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351959; x=1699956759;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PzmxxvQVtCQlxrdp90CZq+87N/MZN/GaNdzZqugBwa8=;
 b=NmndJRTjTTEd9hM+00ynGLb7S/oHDROVHbDYeoAagWZd9igokCnJV+u4g6rZY51MFl
 RgxUMgFSccJgsRyoj/BZe/osgUAwe+/yFNUYV6178JZukE7CztG/R2mbRFbZc3Py1o1c
 vQbPU+sUY5wnyqX8WnB9s0xWCmuVjzgdxCn/ykuzoDhTVIyw3V9nSsf7djw4Xec3ykFj
 qc0+AKeysGPuyjCW6TLJpdO3UXGNK6AhXH1Bv3Fu4H/b4W+PhIgfySi4igfJS+7bFZin
 RHu4ruCja2chnaVYCwHXOMgQDT/eEl/vh2038Kc8gEvSlceh1zqkHVhWPkUAdkI7KAAP
 1VzA==
X-Gm-Message-State: AOJu0YwOuefpX6aSH9jWCzRDAzs6L2qm+Qqufkrvu4CpmJNaKcVT7Fdl
 JT0IOwvwj/qtxnsyPigUhrmECUlnqrghi17Lm63GXnARGukIoCD6ecFlyivOPJXQBMAzWE87pdp
 2fcuBUCmRvVHOMU8egKz01EievSwr8O++RGeIS5Wno+3P5al6phIkrw3ovcEGhLqVvjIx
X-Received: by 2002:adf:f946:0:b0:319:8a66:f695 with SMTP id
 q6-20020adff946000000b003198a66f695mr22193052wrr.55.1699351959445; 
 Tue, 07 Nov 2023 02:12:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHGrLzdXxciCTBlykEjMCo/ycNySW9hVBTkgOi3CBzqR55FMzYpHPAi/LueBMrVzKcejCitg==
X-Received: by 2002:adf:f946:0:b0:319:8a66:f695 with SMTP id
 q6-20020adff946000000b003198a66f695mr22193034wrr.55.1699351959115; 
 Tue, 07 Nov 2023 02:12:39 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 m28-20020a056000181c00b0032f78feb826sm1914482wrh.104.2023.11.07.02.12.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:12:38 -0800 (PST)
Date: Tue, 7 Nov 2023 05:12:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fan Ni <fan.ni@samsung.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 42/63] hw/cxl: CXLDVSECPortExtensions renamed to CXLDVSECPortExt
Message-ID: <b34ae3c9064a976e718dc96e454d32c1d8409eba.1699351720.git.mst@redhat.com>
References: <cover.1699351720.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1699351720.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Done to reduce line lengths where this is used.
Ext seems sufficiently obvious that it need not be spelt out
fully.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Message-Id: <20231023140210.3089-4-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_pci.h       |  6 ++---
 hw/cxl/cxl-component-utils.c   | 49 ++++++++++++++++++++--------------
 hw/pci-bridge/cxl_downstream.c |  2 +-
 hw/pci-bridge/cxl_root_port.c  |  2 +-
 hw/pci-bridge/cxl_upstream.c   |  2 +-
 5 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/include/hw/cxl/cxl_pci.h b/include/hw/cxl/cxl_pci.h
index 407be95b9e..ddf01a543b 100644
--- a/include/hw/cxl/cxl_pci.h
+++ b/include/hw/cxl/cxl_pci.h
@@ -86,7 +86,7 @@ typedef struct CXLDVSECDevice {
 QEMU_BUILD_BUG_ON(sizeof(CXLDVSECDevice) != 0x38);
 
 /* CXL 2.0 - 8.1.5 (ID 0003) */
-typedef struct CXLDVSECPortExtensions {
+typedef struct CXLDVSECPortExt {
     DVSECHeader hdr;
     uint16_t status;
     uint16_t control;
@@ -100,8 +100,8 @@ typedef struct CXLDVSECPortExtensions {
     uint32_t alt_prefetch_limit_high;
     uint32_t rcrb_base;
     uint32_t rcrb_base_high;
-} CXLDVSECPortExtensions;
-QEMU_BUILD_BUG_ON(sizeof(CXLDVSECPortExtensions) != 0x28);
+} CXLDVSECPortExt;
+QEMU_BUILD_BUG_ON(sizeof(CXLDVSECPortExt) != 0x28);
 
 #define PORT_CONTROL_OFFSET          0xc
 #define PORT_CONTROL_UNMASK_SBR      1
diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index 9d4f4bc8d4..1f4ea11640 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -393,26 +393,35 @@ void cxl_component_create_dvsec(CXLComponentState *cxl,
     case NON_CXL_FUNCTION_MAP_DVSEC:
         break; /* Not yet implemented */
     case EXTENSIONS_PORT_DVSEC:
-        wmask[offset + offsetof(CXLDVSECPortExtensions, control)] = 0x0F;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, control) + 1] = 0x40;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_bus_base)] = 0xFF;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_bus_limit)] = 0xFF;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_memory_base)] = 0xF0;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_memory_base) + 1] = 0xFF;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_memory_limit)] = 0xF0;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_memory_limit) + 1] = 0xFF;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_base)] = 0xF0;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_base) + 1] = 0xFF;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_limit)] = 0xF0;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_limit) + 1] = 0xFF;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_base_high)] = 0xFF;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_base_high) + 1] = 0xFF;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_base_high) + 2] = 0xFF;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_base_high) + 3] = 0xFF;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_limit_high)] = 0xFF;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_limit_high) + 1] = 0xFF;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_limit_high) + 2] = 0xFF;
-        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_limit_high) + 3] = 0xFF;
+        wmask[offset + offsetof(CXLDVSECPortExt, control)] = 0x0F;
+        wmask[offset + offsetof(CXLDVSECPortExt, control) + 1] = 0x40;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_bus_base)] = 0xFF;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_bus_limit)] = 0xFF;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_memory_base)] = 0xF0;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_memory_base) + 1] = 0xFF;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_memory_limit)] = 0xF0;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_memory_limit) + 1] = 0xFF;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_base)] = 0xF0;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_base) + 1] = 0xFF;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_limit)] = 0xF0;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_limit) + 1] =
+            0xFF;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_base_high)] =
+            0xFF;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_base_high) + 1] =
+            0xFF;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_base_high) + 2] =
+            0xFF;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_base_high) + 3] =
+            0xFF;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_limit_high)] =
+            0xFF;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_limit_high) + 1] =
+            0xFF;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_limit_high) + 2] =
+            0xFF;
+        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_limit_high) + 3] =
+            0xFF;
         break;
     case GPF_PORT_DVSEC:
         wmask[offset + offsetof(CXLDVSECPortGPF, phase1_ctrl)] = 0x0F;
diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index 5a2b749c8e..8c0f759add 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -98,7 +98,7 @@ static void build_dvsecs(CXLComponentState *cxl)
 {
     uint8_t *dvsec;
 
-    dvsec = (uint8_t *)&(CXLDVSECPortExtensions){ 0 };
+    dvsec = (uint8_t *)&(CXLDVSECPortExt){ 0 };
     cxl_component_create_dvsec(cxl, CXL2_DOWNSTREAM_PORT,
                                EXTENSIONS_PORT_DVSEC_LENGTH,
                                EXTENSIONS_PORT_DVSEC,
diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
index 7dfd20aa67..8f97697631 100644
--- a/hw/pci-bridge/cxl_root_port.c
+++ b/hw/pci-bridge/cxl_root_port.c
@@ -107,7 +107,7 @@ static void build_dvsecs(CXLComponentState *cxl)
 {
     uint8_t *dvsec;
 
-    dvsec = (uint8_t *)&(CXLDVSECPortExtensions){ 0 };
+    dvsec = (uint8_t *)&(CXLDVSECPortExt){ 0 };
     cxl_component_create_dvsec(cxl, CXL2_ROOT_PORT,
                                EXTENSIONS_PORT_DVSEC_LENGTH,
                                EXTENSIONS_PORT_DVSEC,
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index a57806fb31..b81bb5fec9 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -116,7 +116,7 @@ static void build_dvsecs(CXLComponentState *cxl)
 {
     uint8_t *dvsec;
 
-    dvsec = (uint8_t *)&(CXLDVSECPortExtensions){
+    dvsec = (uint8_t *)&(CXLDVSECPortExt){
         .status = 0x1, /* Port Power Management Init Complete */
     };
     cxl_component_create_dvsec(cxl, CXL2_UPSTREAM_PORT,
-- 
MST


