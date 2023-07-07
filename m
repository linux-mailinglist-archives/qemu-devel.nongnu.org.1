Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2549574B3FA
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 17:19:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHnDO-0000xS-Nc; Fri, 07 Jul 2023 11:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHnDN-0000xK-7S
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 11:17:45 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHnDL-0000fC-Lm
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 11:17:44 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fbea14706eso22198685e9.2
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 08:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688743062; x=1691335062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FzWZerM4O//3gQRZXyrbL/L51wu/EYwT/LPgDLorvzA=;
 b=AcsfCN9Jy3giqdF6SM/yBl+WEoCs1sgZJeDY2DmidLNBZB+LWto25RZi1Umle/1tGv
 W9oEILsO/rY9cwhvv4vycdfjQ+j9rOOQNcHaBlEl06F++qH00UkgwqKKdRIYiTE0aGHU
 wwSJiHdb8BZVV+b0mYS6yG8dUQz40fcMiLz9HP6Bz0EJ2Z+1Tur0riRkicIlXI4naZt4
 4WiiChvLr3BED8nNnEVGKipHz4PHMF2hnDWMwKT9yIgmtij/D845VZXSF9opybZOFmNx
 Xk71CRRDYKk1NYUEocuSs6S2EZ8mfGZ37oggs5dubaDiHkKnjyrvkP/2iLMfFcif8ZEn
 Dmpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688743062; x=1691335062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FzWZerM4O//3gQRZXyrbL/L51wu/EYwT/LPgDLorvzA=;
 b=hGO6u0jkgGBHybyuxvKycjxDveuNh/Ks50x4iIca+XFKG6LNZD/uqc1ksnQ230TXbc
 6EFrAvRtnk/1sILtXEVnAErr+uw7WpsSC0KdMZDIgodPvD+R2pwZTdMqaraMBKKVPmC7
 SNB8qQmfaerqAKb3z5j4mfwk5Z0kL4WXDMoCxyp67QkssiNJbTJwYazTgMeYoTwFjWPm
 hBC10p6LG/5CxnzIVDmPZYXWRjOjYryQe7EawCtm86bg2i+A3JRw5gSDjZ1BFAoOlYLw
 Djnt7MT2r0p1C3XPinSNiPvqu0/WFseV4gcPFdZ4nKhujxPmYNQxxhAvmyO5gG1J7l6t
 LXzQ==
X-Gm-Message-State: ABy/qLbDJLyjfX8Uq5LTuNpfvM+jCTxDZtSckXOr/owdnV3zHc1pQObc
 /x87WkziXtcXOJe9A8FbsxXMpBo3EAkJJOCkJL0=
X-Google-Smtp-Source: APBJJlFvBYzZOoO+4Vb5T3MseHbB5ztYELNvjWNVqyn1YGPN59J91eQS9GYBpaKUbB0SRlUUfkMrbg==
X-Received: by 2002:a7b:c3d7:0:b0:3fb:a6ee:4cec with SMTP id
 t23-20020a7bc3d7000000b003fba6ee4cecmr3994034wmj.33.1688743062102; 
 Fri, 07 Jul 2023 08:17:42 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.215.192])
 by smtp.gmail.com with ESMTPSA id
 n19-20020a7bc5d3000000b003fbca05faa9sm2740976wmk.24.2023.07.07.08.17.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 07 Jul 2023 08:17:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/6] hw/virtio/vhost-vdpa: Inline TARGET_PAGE_ALIGN() macro
Date: Fri,  7 Jul 2023 17:17:16 +0200
Message-Id: <20230707151719.70613-4-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230707151719.70613-1-philmd@linaro.org>
References: <20230707151719.70613-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Use TARGET_PAGE_SIZE to calculate TARGET_PAGE_ALIGN
(see the rationale in previous commits).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/vhost-vdpa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 3040bd8ee8..a3dd7c712a 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -329,7 +329,7 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
         return;
     }
 
-    iova = TARGET_PAGE_ALIGN(section->offset_within_address_space);
+    iova = ROUND_UP(section->offset_within_address_space, TARGET_PAGE_SIZE);
     llend = vhost_vdpa_section_end(section, TARGET_PAGE_MASK);
     if (int128_ge(int128_make64(iova), llend)) {
         return;
@@ -411,7 +411,7 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
         return;
     }
 
-    iova = TARGET_PAGE_ALIGN(section->offset_within_address_space);
+    iova = ROUND_UP(section->offset_within_address_space, TARGET_PAGE_SIZE);
     llend = vhost_vdpa_section_end(section, TARGET_PAGE_MASK);
 
     trace_vhost_vdpa_listener_region_del(v, iova,
-- 
2.38.1


