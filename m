Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3A474D22F
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 11:51:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qInXZ-0002Ju-Qt; Mon, 10 Jul 2023 05:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qInXV-0002F0-8I
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:50:41 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qInXT-0003yw-Ib
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:50:41 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3143798f542so4617760f8f.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 02:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688982637; x=1691574637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kP8qzfTD4vvJGBfBeZEZ5IO8iCCDKAKq4Fv9p6to8AE=;
 b=HK/Z3WrLTFw4bZuyhsk899uskPGomjEDJ0qbyz8GfAwhxYOJANDU3RCPlelD3/DU2V
 fQFmeqk0oN7RnM9NVhk942NyDKb9PMrTSfNQrFSnHlceRF+YmEPtrMAHLRcqfhVnEge1
 ZpnzzGm2sKbCYbdDBOJcPRaR5u8CxwqCT+DYYMsCZ57SHv01zPoJoOTOuesCHE1ol2b1
 FaE+x7ADnw1MNQO2rB2bDMBgX6OW5jDgV69B/9UOCrqYeOCgAmT/L1B7MryGgm4js6bB
 x9NGCRkR9xRMvW+gW0aAhUPV/HOm91LS9C1Mi0TqEwXtwShF2WGd+IEnhQP1pmJvnSwu
 6VTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688982637; x=1691574637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kP8qzfTD4vvJGBfBeZEZ5IO8iCCDKAKq4Fv9p6to8AE=;
 b=McFhaW30SRd07Qmnh6q+fHWSt4sj1M8colCw5jfMUbyfnqH+FGV7OOvsbdJiuhxGzJ
 tge+nT4dABjWlkHwVR+IBiuRZpMsZpRN9dArBRlDunMi1NPoUYSdgFRx0FTyPXrv7qiQ
 aFw9rmAyCajTmCSkcfkLEktH+wpmlrZ4XNd5rvPXyhK120mnbpZu3Z1670BXqfW76Fe8
 iUXKpCK5+ELhrfK64H0Nd/o9QpeZQ8J3xtJzuXcoP2TS+liLyeXohhOX0mPeL1gvNdzF
 wi8I9wQ8z1O+5Km8oqMknriDrfWHzEXAIkdu07fd2aUzvjV7uKeFLxPXW8nX/NiVpy8n
 4v+A==
X-Gm-Message-State: ABy/qLZ0rW1zQN+5O0Wg4vnl0PQb4ifs0lZD010bsIbjZHwd7wxB3uj7
 W2cs8/Oll2dtWf7IxNKxgjGkvj05HkutlQQulHql6Q==
X-Google-Smtp-Source: APBJJlGh81J9N30hQz02CtgzwUu1r0JQTa2mT706gU5bShoUyheV6a5z6WHO41MZJUY+W2GAW6gI6A==
X-Received: by 2002:adf:e649:0:b0:314:3ac8:c277 with SMTP id
 b9-20020adfe649000000b003143ac8c277mr11209848wrn.9.1688982637321; 
 Mon, 10 Jul 2023 02:50:37 -0700 (PDT)
Received: from localhost.localdomain (70.red-88-28-30.dynamicip.rima-tde.net.
 [88.28.30.70]) by smtp.gmail.com with ESMTPSA id
 d5-20020adfe885000000b003143ba62cf4sm11258044wrm.86.2023.07.10.02.50.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 02:50:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 2/6] hw/virtio: Propagate page_mask to
 vhost_vdpa_section_end()
Date: Mon, 10 Jul 2023 11:49:27 +0200
Message-Id: <20230710094931.84402-3-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710094931.84402-1-philmd@linaro.org>
References: <20230710094931.84402-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


