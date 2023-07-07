Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE0774B3FC
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 17:19:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHnDZ-00013z-Ow; Fri, 07 Jul 2023 11:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHnDY-00013q-OP
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 11:17:56 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHnDX-0000h7-3i
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 11:17:56 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4f76a0a19d4so3097962e87.2
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 08:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688743073; x=1691335073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aWI/6gGfjRPtDVKiMDrKPzVxOvluZG91V1TrcTp6oHQ=;
 b=NyeQ4dMRbWn/YUkvk1FsWkyAaQkj1jIJpKpJevZmg0hz8vbFHxr03fLrP//b24TBtJ
 2XvpeGk2KTosfWJYHsNWsFYFmiNHBnYRPgQLPFEo1Yxa6rBWxl3tNWHld0xe7JZbI0Vh
 vjWMMhvMvw9u+ecUTaq6NFSh6O2OcGQbx8dU+oixf2xEbYddfjglAHxUGfY5neE/mtGB
 oIRxsZoj3DxgVPhxMskREaKJx+8mM5cVki54nKtSVrw1GVr40nWENC7lyCjgnFLEqdmA
 IobAwcpoN7u+lT/bhlqMgrllUOhFvvc1tquRvhX/vd4m4O/5Ij6QGH/rAdSWWIDu9eaQ
 cBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688743073; x=1691335073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aWI/6gGfjRPtDVKiMDrKPzVxOvluZG91V1TrcTp6oHQ=;
 b=V3SN0SUisja6Bz2mDzQa1yGG+sU8cFaSnuhkVsiL7mZLbwoZaHh5w1CJfDqVtWUrOd
 JuRWAr2nJHmWILQGPZ8JQNNHN0vNSmUkNzNychb/pgI0Ygq/ZlHC9U8As4Opig4AXMWG
 whM37mqH16XgmA3kbKHuKiAgdjGJAx649vrozSvFEoqPPgS5vIoWR/bh/eRnJVxJDnXj
 ZJah8CZV/yhfLaO7e++Y62xgmMLZB+Bg43bZGrYP0vpXjoCWGlSraj6TwzGGaKsJdvC9
 2ed9ZrfKlSLyPyyrZfep5NoUGbxVry9ZAoPdgSgEXhh/58MjtJtN18ByQIRVymkCITaL
 uCRw==
X-Gm-Message-State: ABy/qLZQFLXJ0dzZqxxeFspU+umlBb4YWq6wEF83JthuHoQ67+WVDyE4
 qDChQM+q/N2P06v3vVB5Aez5G1xVJEk2E+528/Y=
X-Google-Smtp-Source: APBJJlGHJxu075AuVhC/LwytBXEJU9Mg4Uw7ddwnUhlrMIiQ9cN5C9CMAFmf9ll85hwsS3nIk2zOvQ==
X-Received: by 2002:a05:6512:33ce:b0:4f8:5600:9e5e with SMTP id
 d14-20020a05651233ce00b004f856009e5emr4878565lfg.47.1688743073156; 
 Fri, 07 Jul 2023 08:17:53 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.215.192])
 by smtp.gmail.com with ESMTPSA id
 v2-20020a5d6102000000b003144bfbd0b3sm4695435wrt.37.2023.07.07.08.17.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 07 Jul 2023 08:17:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/6] hw/virtio/vhost-vdpa: Use target-agnostic
 qemu_target_page_mask()
Date: Fri,  7 Jul 2023 17:17:17 +0200
Message-Id: <20230707151719.70613-5-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230707151719.70613-1-philmd@linaro.org>
References: <20230707151719.70613-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
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

Similarly to commit e414ed2c47 ("virtio-iommu: Use
target-agnostic qemu_target_page_mask"), Replace the
target-specific TARGET_PAGE_SIZE and TARGET_PAGE_MASK
definitions by a call to the runtime qemu_target_page_size()
helper which is target agnostic.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/vhost-vdpa.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index a3dd7c712a..456a0afe2e 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -14,6 +14,7 @@
 #include <linux/vfio.h>
 #include <sys/eventfd.h>
 #include <sys/ioctl.h>
+#include "exec/target_page.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-backend.h"
 #include "hw/virtio/virtio-net.h"
@@ -23,7 +24,6 @@
 #include "migration/blocker.h"
 #include "qemu/cutils.h"
 #include "qemu/main-loop.h"
-#include "cpu.h"
 #include "trace.h"
 #include "qapi/error.h"
 
@@ -313,9 +313,11 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
     Int128 llend, llsize;
     void *vaddr;
     int ret;
+    int page_size = qemu_target_page_size();
+    int page_mask = page_size - 1;
 
     if (vhost_vdpa_listener_skipped_section(section, v->iova_range.first,
-                                            v->iova_range.last, TARGET_PAGE_MASK)) {
+                                            v->iova_range.last, page_mask)) {
         return;
     }
     if (memory_region_is_iommu(section->mr)) {
@@ -323,14 +325,14 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
         return;
     }
 
-    if (unlikely((section->offset_within_address_space & ~TARGET_PAGE_MASK) !=
-                 (section->offset_within_region & ~TARGET_PAGE_MASK))) {
+    if (unlikely((section->offset_within_address_space & ~page_mask) !=
+                 (section->offset_within_region & ~page_mask))) {
         error_report("%s received unaligned region", __func__);
         return;
     }
 
-    iova = ROUND_UP(section->offset_within_address_space, TARGET_PAGE_SIZE);
-    llend = vhost_vdpa_section_end(section, TARGET_PAGE_MASK);
+    iova = ROUND_UP(section->offset_within_address_space, page_size);
+    llend = vhost_vdpa_section_end(section, page_mask);
     if (int128_ge(int128_make64(iova), llend)) {
         return;
     }
@@ -396,23 +398,25 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
     hwaddr iova;
     Int128 llend, llsize;
     int ret;
+    int page_size = qemu_target_page_size();
+    int page_mask = page_size - 1;
 
     if (vhost_vdpa_listener_skipped_section(section, v->iova_range.first,
-                                            v->iova_range.last, TARGET_PAGE_MASK)) {
+                                            v->iova_range.last, page_mask)) {
         return;
     }
     if (memory_region_is_iommu(section->mr)) {
         vhost_vdpa_iommu_region_del(listener, section);
     }
 
-    if (unlikely((section->offset_within_address_space & ~TARGET_PAGE_MASK) !=
-                 (section->offset_within_region & ~TARGET_PAGE_MASK))) {
+    if (unlikely((section->offset_within_address_space & ~page_mask) !=
+                 (section->offset_within_region & ~page_mask))) {
         error_report("%s received unaligned region", __func__);
         return;
     }
 
-    iova = ROUND_UP(section->offset_within_address_space, TARGET_PAGE_SIZE);
-    llend = vhost_vdpa_section_end(section, TARGET_PAGE_MASK);
+    iova = ROUND_UP(section->offset_within_address_space, page_size);
+    llend = vhost_vdpa_section_end(section, page_mask);
 
     trace_vhost_vdpa_listener_region_del(v, iova,
         int128_get64(int128_sub(llend, int128_one())));
-- 
2.38.1


