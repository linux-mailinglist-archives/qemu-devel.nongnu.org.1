Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DB67CC577
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 16:03:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qskeq-00049V-HZ; Tue, 17 Oct 2023 10:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qskeL-00046a-Cy
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 10:02:21 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qskeI-0008Nv-89
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 10:02:21 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40572aeb673so54835305e9.0
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 07:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697551336; x=1698156136; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eu+I0Mxgw0c1e0TXhFwzYxAgC+Cbp6NkKlE9STdvd/w=;
 b=lCj+YU0egaVlMJub5HB/y8z5CY5Tg2MEJNXVW+M7z2G1uH5XKkEInvV7u1iQrcjd92
 ydVktC3o3FoACsTBxYMy9cxx/LOCVALGBeyTKFF4vSE4MIGP0QD/bxxpiQGlRv4ow1As
 3Jp3gebZP3tb9rWr9NQnR689ufh6Fc4LdqON1nswhPcJNAMG61liN3+XNvSbHEJiUjnH
 Z8pr7Ch+PISFDCmzpKnh6F+Q9KBM0ZRWbteymLafcFrCUoGV9mTyAYo94QgSVXVz6/Cd
 E4FGfznYXtyPQacjHcI4jA8YKTXV7GApxDGfc7ZfAEEGzCDCo09Dmuq4p6Cakwr3TTkB
 hT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697551336; x=1698156136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eu+I0Mxgw0c1e0TXhFwzYxAgC+Cbp6NkKlE9STdvd/w=;
 b=AVVM/OfwvRwQx3ZcMTWA3sZCUNDByl/1mQ7YDN9ewndq2Sj12Tr/u0VCmhNGomEC4H
 +kUl8k4hVAcZZhZDz1QQwYd0KvkMYUP8RHtYB2gFQggl0sr4SJaBCqPU3ZtucsMaCyee
 +rJ/D1zB2PkT7P6S0XRiSJg6xxQs7rxoI/G+/9IvzVcuQ/pVvKx5eLG+nje7XCLhYnfx
 jqv255JL7Xw1IRO3N9AHY++uKIDtphGZUH08CrMXpAxEDsD23Fo0/q2nnIPDyZjW7GtB
 EfBC2/pYKnvaCwunqAJ9x4pgoGakUyI0DnT23bgt9NVD1LnDFd7PQZ9XY0hG/tfECpsl
 vP8g==
X-Gm-Message-State: AOJu0YzPtvpOiC9Xxc0F0eGLRF553uApk3xy7yHj0NBARFBjzOxrOv6N
 J8Dz8Qxm0pHuCx3DZ9SO66ynooydB/eNb/ZPXH7Sjw==
X-Google-Smtp-Source: AGHT+IFbaARDy74BVVXSIQpqq4SairoimZofQ6TdspVQd663r9b28zPw6zCoClWh8TFqXmPNuzgN/A==
X-Received: by 2002:a05:600c:4708:b0:406:3fda:962c with SMTP id
 v8-20020a05600c470800b004063fda962cmr1977009wmo.31.1697551336464; 
 Tue, 17 Oct 2023 07:02:16 -0700 (PDT)
Received: from m1x-phil.lan ([176.172.118.33])
 by smtp.gmail.com with ESMTPSA id
 n35-20020a05600c502300b004064ac107cfsm2006747wmr.39.2023.10.17.07.02.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Oct 2023 07:02:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Fam Zheng <fam@euphon.net>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/7] hw/display/virtio-gpu: Use VIRTIO_DEVICE() macro
Date: Tue, 17 Oct 2023 16:01:46 +0200
Message-ID: <20231017140150.44995-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017140150.44995-1-philmd@linaro.org>
References: <20231017140150.44995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Access QOM parent with the proper QOM VIRTIO_DEVICE() macro.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/virtio-gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 93857ad523..51cb517999 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1132,7 +1132,7 @@ static void virtio_gpu_ctrl_bh(void *opaque)
     VirtIOGPU *g = opaque;
     VirtIOGPUClass *vgc = VIRTIO_GPU_GET_CLASS(g);
 
-    vgc->handle_ctrl(&g->parent_obj.parent_obj, g->ctrl_vq);
+    vgc->handle_ctrl(VIRTIO_DEVICE(g), g->ctrl_vq);
 }
 
 static void virtio_gpu_handle_cursor(VirtIODevice *vdev, VirtQueue *vq)
-- 
2.41.0


