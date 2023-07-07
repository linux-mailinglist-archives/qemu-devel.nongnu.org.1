Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BC774B3F9
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 17:19:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHnDG-0000wh-5J; Fri, 07 Jul 2023 11:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHnDD-0000vW-DB
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 11:17:35 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHnDA-0000cp-UW
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 11:17:34 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-98377c5d53eso250651466b.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 08:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688743049; x=1691335049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tEOl601lp/glMFLXL/Pb6sc13gALwOrVo4hgtvYuZtU=;
 b=Kll5WQn67GmCtCbgfLbz0kZBHaf3DtxlBXW26nBe5Yjus3MKNiDMnx8CBTJwTz1XVi
 MkjlFtpS+4WOLEXopN/+krO56C/G+3TG6Kf8KY5yK9IU0Q7FQrA1Su/7dMZSpNpfTbIL
 oFyqjh8H+KbZLKRyVNIHmu3N0m8dKMsd+ZmpqaIoOYKCeOQGoSMgo0DgGDvENd9qfXT/
 yQaPHAo19xXg8nQdQCrEPIbFvMlKJVChBeaGLdISqg283RHnIH1njEC9H7/Tl1mGSqr2
 8pLqTXWHrc5i08/95Ne2dmYEn2t+kAallPfQIKf4sKPwBoxjp+k2Ax5vECrZovyjQ0PZ
 bS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688743049; x=1691335049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tEOl601lp/glMFLXL/Pb6sc13gALwOrVo4hgtvYuZtU=;
 b=SB5Brh5YPyzi1TpUuU80VNqUhwzPc2kRG6fsFd8tnX0ItwsGxi/zcKgW3WM/bEkj2o
 AZXbRCD5ulo3Vcts0Keso+RooWHz6I7nF13x3+3laaMspEXXH5Lp+uXRsuHiEEnUyzAh
 3Q//xrgsmx8G5EixabnOZTpNCrO7FfmzQVFi6BARJ59KxgIz9Hx9y0TjQZySLgiIIFNz
 LIxi+DdyEoZJ654uoerWXUTaHqsJFnKLOBSl2s6C1qxUXFAyb0ezfZnh6IPW9HYtP0Kl
 IzuWNjBlaUPXGeJjpGGNBdznuen8mLHVDNE3IZaBsXLtCcYB98swFHtKODKfeWoW7Eit
 gsAg==
X-Gm-Message-State: ABy/qLaJWPusGbFSQhYkHKo9+8RhSjleON3xF7v9s5gU0Xsk1u+a68GO
 XM/khgSzKtowdKi+00tlMYlqAMoH0eM+yj4pnwc=
X-Google-Smtp-Source: APBJJlGP6v/u5trbYJwUq8PMrtqyY1qkLOLkAcgSly8JkY5S1GCSRyqlg1VQNrgQmSE6AJRBgvZc7Q==
X-Received: by 2002:a17:906:57da:b0:98f:ab82:8893 with SMTP id
 u26-20020a17090657da00b0098fab828893mr3762991ejr.73.1688743049834; 
 Fri, 07 Jul 2023 08:17:29 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.215.192])
 by smtp.gmail.com with ESMTPSA id
 t3-20020a170906268300b0098e42bef736sm2322459ejc.176.2023.07.07.08.17.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 07 Jul 2023 08:17:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/6] hw/virtio: Propagate page_mask to
 vhost_vdpa_listener_skipped_section()
Date: Fri,  7 Jul 2023 17:17:14 +0200
Message-Id: <20230707151719.70613-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230707151719.70613-1-philmd@linaro.org>
References: <20230707151719.70613-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

In order to make vhost-vdpa.c a target-agnostic source unit,
we need to remove the TARGET_PAGE_SIZE / TARGET_PAGE_MASK /
TARGET_PAGE_ALIGN uses. TARGET_PAGE_SIZE will be replaced by
the runtime qemu_target_page_size(). The other ones will be
deduced from TARGET_PAGE_SIZE.

Since the 3 macros are used in 3 related functions (sharing
the same call tree), we'll refactor them to only depend on
TARGET_PAGE_SIZE.

Having the following call tree:

  vhost_vdpa_listener_region_del()
    -> vhost_vdpa_listener_skipped_section()
       -> vhost_vdpa_section_end()

The first step is to propagate TARGET_PAGE_MASK to
vhost_vdpa_listener_skipped_section().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/vhost-vdpa.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 3c575a9a6e..87653bf841 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -42,7 +42,8 @@ static Int128 vhost_vdpa_section_end(const MemoryRegionSection *section)
 
 static bool vhost_vdpa_listener_skipped_section(MemoryRegionSection *section,
                                                 uint64_t iova_min,
-                                                uint64_t iova_max)
+                                                uint64_t iova_max,
+                                                int page_mask)
 {
     Int128 llend;
 
@@ -313,7 +314,7 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
     int ret;
 
     if (vhost_vdpa_listener_skipped_section(section, v->iova_range.first,
-                                            v->iova_range.last)) {
+                                            v->iova_range.last, TARGET_PAGE_MASK)) {
         return;
     }
     if (memory_region_is_iommu(section->mr)) {
@@ -396,7 +397,7 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
     int ret;
 
     if (vhost_vdpa_listener_skipped_section(section, v->iova_range.first,
-                                            v->iova_range.last)) {
+                                            v->iova_range.last, TARGET_PAGE_MASK)) {
         return;
     }
     if (memory_region_is_iommu(section->mr)) {
-- 
2.38.1


