Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA4174D232
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 11:51:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qInXV-00023P-I7; Mon, 10 Jul 2023 05:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qInXB-00022D-SY
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:50:22 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qInXA-0003pF-6l
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:50:21 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-31441dfbf97so4898556f8f.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 02:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688982618; x=1691574618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ufBOjc9SeZsogN9rwEOZ+B47n6rE09TymenxbvkIAQo=;
 b=if41VYgY9HRpi/UF+rX9jd2ntN8W88hbcyzYqEqrd0BgWJhl+aCqQLaEyGJbERWNBn
 PWnZU5cT8MKWutksHQ/gtGFPJGfTKVs6IquodXklRBm8aXAGAjJP7ZCcqp4bXtrEJ7fK
 pqn0qaLbZYtxECfZl3PH9ktSvbmSUIi+vABPyoiq8nWlcNg1B5VcjzREiufcLfnlT3F0
 CyPOX+XNXIGuUfsb9E2dh9dnYLYCpA3mlQU6E7S9G9ZeVd/TQHQvSSeeEmpb4XJ3o5eV
 1aZKbNsGho/wFxdnipUhkftjRrMl87xwPnP60ytPIPFjbQYZY8fqsW/DAYtVO76Q3Snu
 pasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688982618; x=1691574618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ufBOjc9SeZsogN9rwEOZ+B47n6rE09TymenxbvkIAQo=;
 b=epEKhhpmt6y+P/1q5aATV/rsi6I2LpNlL0HmQ46DhhX4ZQnYuLcuIiOpCRRsQt/Jsb
 ZZw3AtkNPLqh66MdUrnfWAXoGeslO+I7KLSqY0gbWfRNBBMbptFzuZswCLrjIXDV7zaz
 JDDACAFxttQd1fIplsvoQ9mlR/XNYWFxVSP0EhLXCbECNAp0pTZw+kUeyFxs2ApPobnp
 uLk7rPokbnRnMeCM5tmanMNvsn087DhJYUZuxL/lXfQBwGEnAYsMrN9DDyLSjRWVjioM
 kbtcuW/BJ7KUPBWb2crNCU0gH2XPHt3JrI/Un5s0pH0tKWbTkVYzw+1WHO2FgN9dMsnO
 RZ7Q==
X-Gm-Message-State: ABy/qLaPBbRkqRChTJ3YSjud3F8qENrs6b3huU4OYYZkzkZyEp+SzOqH
 0an5ywuzCP90QA2K+k39Vy2RuEPcOJcwh7rypqWjqw==
X-Google-Smtp-Source: APBJJlGq/uGNrVtmHAOEhIbGcbU2s5JRD9vDI78fDd/iAWTJTRkLgnTkg0aJfxB6qhKwk2UP/LwnhA==
X-Received: by 2002:a5d:49cb:0:b0:313:ef24:6feb with SMTP id
 t11-20020a5d49cb000000b00313ef246febmr12334865wrs.3.1688982618115; 
 Mon, 10 Jul 2023 02:50:18 -0700 (PDT)
Received: from localhost.localdomain (70.red-88-28-30.dynamicip.rima-tde.net.
 [88.28.30.70]) by smtp.gmail.com with ESMTPSA id
 k6-20020a05600c0b4600b003fc00892c13sm8617369wmr.35.2023.07.10.02.50.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 02:50:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 1/6] hw/virtio: Propagate page_mask to
 vhost_vdpa_listener_skipped_section()
Date: Mon, 10 Jul 2023 11:49:26 +0200
Message-Id: <20230710094931.84402-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710094931.84402-1-philmd@linaro.org>
References: <20230710094931.84402-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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
TARGET_PAGE_MASK.

Having the following call tree:

  vhost_vdpa_listener_region_del()
    -> vhost_vdpa_listener_skipped_section()
       -> vhost_vdpa_section_end()

The first step is to propagate TARGET_PAGE_MASK to
vhost_vdpa_listener_skipped_section().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


