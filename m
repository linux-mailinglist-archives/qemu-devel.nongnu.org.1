Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA37474D233
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 11:51:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qInXx-0004I9-2C; Mon, 10 Jul 2023 05:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qInXu-0004BD-RD
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:51:06 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qInXt-00043L-BI
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:51:06 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fbd33a57b6so55139015e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 02:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688982664; x=1691574664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=opfO9q/dSVfV5cAvnirB68cIre+ympAxvZtAmrt5FgM=;
 b=FoGO98yWBxpOqMAqpVEt/T49YC7q5XckNGh60YZcPopoEP1Ht7bMsJjwOkXb/6m/2L
 b5mV07/xWIC4tNm7Ssg35suGEJ5NKRFkc3pEUn7fyPuYCZVt1fF+rLthkNFXYWhaEvim
 6/7dxETS6rAhdvDWdAHz8prBKGUdRyrP9v45kCMMxmkvgEvNouvvLEHNxMGzqZFws6w/
 45G/BRPxJ/kjTc5QOguyuw5zydk9mVVTn/ga22HNiqYAlWE/NfUUKhNg+UN9rSodMinG
 mHleVeT/yGBH6n9Zd4beEibW6dwxW9IR1KchTh8FxJjbvGzcbLjibt9Fc9YW+TIdeMvW
 8hig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688982664; x=1691574664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=opfO9q/dSVfV5cAvnirB68cIre+ympAxvZtAmrt5FgM=;
 b=fAgSowfeUG3h5iNigwsVWbQavqgfrdcjjduL+2C5WFtgFlzZqf5gt5BzvVT11dFl2M
 8ujesQC9Ydy+lFvKE4TG6B34gE8dJJ8MrURRmuhQ07+nfF6DqtDJZXfm/DvWb/6T0/qv
 vo31xW/Pa0h5BjtTak/Iy+qZ8Y9awtKJyhg2LWBHsQyeQgdBb1m1ZNvSNAV6TrPlEod7
 U2+e3T8Jvc464c8b9i5x9Wg1Wk6bFbEXq39qBT+1nI5bEdp1TyBff+rhic5Z1u4HcOls
 6mv2JHfwn2TI6tJHcZvwxoowW+HAfAJVjO4H3cHiR6mba2qlU3ZSz4aa8kp0rWkeOFlQ
 +nbw==
X-Gm-Message-State: ABy/qLZnHFb0d+YhH6KTGnWjOM49xQBulAk+noNLCtHJIOjRoe/T9fwz
 2jRe37i9fh0qZ6U+XSqx/+GZSnGdkRBbtpYRoGb0MQ==
X-Google-Smtp-Source: APBJJlE8WZl0N/y5Cw+7vnT0GNojtR2LuRjKkGkyHeZRcGnVrJBBwPOEz+8ItdRdzrOVNW9vz/hDeg==
X-Received: by 2002:a05:600c:2105:b0:3fc:3e1:7105 with SMTP id
 u5-20020a05600c210500b003fc03e17105mr8628759wml.24.1688982663754; 
 Mon, 10 Jul 2023 02:51:03 -0700 (PDT)
Received: from localhost.localdomain (70.red-88-28-30.dynamicip.rima-tde.net.
 [88.28.30.70]) by smtp.gmail.com with ESMTPSA id
 q5-20020a1ce905000000b003fbc9d178a8sm9919839wmc.4.2023.07.10.02.50.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 02:51:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 3/6] hw/virtio/vhost-vdpa: Inline TARGET_PAGE_ALIGN() macro
Date: Mon, 10 Jul 2023 11:49:28 +0200
Message-Id: <20230710094931.84402-4-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710094931.84402-1-philmd@linaro.org>
References: <20230710094931.84402-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


