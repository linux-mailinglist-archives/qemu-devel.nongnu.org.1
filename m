Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B06874B3F7
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 17:19:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHnDJ-0000xC-5W; Fri, 07 Jul 2023 11:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHnDH-0000wp-31
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 11:17:39 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHnDF-0000di-Ih
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 11:17:38 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-992f6d7c7fbso253926666b.3
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 08:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688743055; x=1691335055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NLj6fc0nTXSo2Q6ccqQ2bRaAaaNn/Lom3RgmCaoHH/4=;
 b=GeS3mrXvQSrxuKcn/gQ9cgnPzBIwUn4iInl0fAiL1Y2kEwQJYwJyqEzHQcPJw2JFk+
 79Mq5/zxAyjj+TOMD1dOOSjTGRVjtRvgdXL3AH/ex3B7MWOi9yc9smIDECwB2BilZz0f
 KQHfODngHJXxg89mtvRjjhG1VFlfSB62allue7aXWXI/7HXIZbGS9YkabpU8IDeB8HR1
 G7+yt6UjtRbUoRE/y87PVan4dRlppL0H4Wqo3DJLZPYyKClfnf3QzbqgVLhDCdd7eJXC
 aCRaJyAjqL9ysym8maOzTbsR8emGYzV3QUnGuh4xC+yhhCX95t0mz8p+NwAfx3eh9RFO
 XStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688743055; x=1691335055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NLj6fc0nTXSo2Q6ccqQ2bRaAaaNn/Lom3RgmCaoHH/4=;
 b=VYSlEViKeYUt/rPO/OM11Wb3ZGBcmmMomLkcY7Y7+n3FNg7nvi+FKEXNQbj98sivQm
 98m9Lz+mIHSg6J0wfY0b709E5VXA7g5UJiajxJ7dCG4LHqlLFBekBdrRN+TR9gSL7i3K
 Gqgfyu45eUXqSPu4Zb5g4WrD7JAFbQNN79L4xAkirkX8Aj2DBJqIXSM0OYL8PtLgFjOo
 uA3en2w5Evc4C1vpvEXM9Dt9QZVQfaa3g4qThPzrZ83SGIK7OHbzqvzP7zc9G3wbVu02
 zZjnYokaOx+8W85Dh8mjBhQYqZniUeKMyHQ5Kl3zPFdWz7bzqUUPUvQvRJV4EOLklefB
 nxhQ==
X-Gm-Message-State: ABy/qLYKNIsJgffanYrNJe8RY3Xgllh2t4Ww2bNx+s3ZU9rdsSPyP0TY
 5KEC7PiNUB02qz+N2pcHpz9ynp6iEVPs6P9oeDc=
X-Google-Smtp-Source: APBJJlF71bZlpDpGmx9jhWXzN4LtFerc0E0abN3UHQk7sw4hrXZdojOKxppsTFbS6NjzdJSxKtQMzA==
X-Received: by 2002:a17:906:51d4:b0:987:16c6:6ff3 with SMTP id
 v20-20020a17090651d400b0098716c66ff3mr4158318ejk.38.1688743055541; 
 Fri, 07 Jul 2023 08:17:35 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.215.192])
 by smtp.gmail.com with ESMTPSA id
 q17-20020a17090622d100b009934855d8f1sm2282355eja.34.2023.07.07.08.17.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 07 Jul 2023 08:17:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/6] hw/virtio: Propagate page_mask to
 vhost_vdpa_section_end()
Date: Fri,  7 Jul 2023 17:17:15 +0200
Message-Id: <20230707151719.70613-3-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230707151719.70613-1-philmd@linaro.org>
References: <20230707151719.70613-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

Propagate TARGET_PAGE_MASK (see the previous commit for
rationale).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/vhost-vdpa.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 87653bf841..3040bd8ee8 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -31,11 +31,12 @@
  * Return one past the end of the end of section. Be careful with uint64_t
  * conversions!
  */
-static Int128 vhost_vdpa_section_end(const MemoryRegionSection *section)
+static Int128 vhost_vdpa_section_end(const MemoryRegionSection *section,
+                                     int page_mask)
 {
     Int128 llend = int128_make64(section->offset_within_address_space);
     llend = int128_add(llend, section->size);
-    llend = int128_and(llend, int128_exts64(TARGET_PAGE_MASK));
+    llend = int128_and(llend, int128_exts64(page_mask));
 
     return llend;
 }
@@ -69,7 +70,7 @@ static bool vhost_vdpa_listener_skipped_section(MemoryRegionSection *section,
      */
 
     if (!memory_region_is_iommu(section->mr)) {
-        llend = vhost_vdpa_section_end(section);
+        llend = vhost_vdpa_section_end(section, page_mask);
         if (int128_gt(llend, int128_make64(iova_max))) {
             error_report("RAM section out of device range (max=0x%" PRIx64
                          ", end addr=0x%" PRIx64 ")",
@@ -329,7 +330,7 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
     }
 
     iova = TARGET_PAGE_ALIGN(section->offset_within_address_space);
-    llend = vhost_vdpa_section_end(section);
+    llend = vhost_vdpa_section_end(section, TARGET_PAGE_MASK);
     if (int128_ge(int128_make64(iova), llend)) {
         return;
     }
@@ -411,7 +412,7 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
     }
 
     iova = TARGET_PAGE_ALIGN(section->offset_within_address_space);
-    llend = vhost_vdpa_section_end(section);
+    llend = vhost_vdpa_section_end(section, TARGET_PAGE_MASK);
 
     trace_vhost_vdpa_listener_region_del(v, iova,
         int128_get64(int128_sub(llend, int128_one())));
-- 
2.38.1


