Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EC27D03EF
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:24:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtaTx-0005wI-33; Thu, 19 Oct 2023 17:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaTu-0005r5-Tk
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:23:02 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaTr-0001cC-RD
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:23:02 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2c5056059e0so1653571fa.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697750578; x=1698355378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nv3oXKxb944zUzl3WXXH7IJvjD+TPF87yEqv4BjuzRw=;
 b=BeRAsNlfvYPxkzMfcnN/gLLY7KvJNgc8/5ESA9X398IwnjspAJ5cH81GiPRahC7nkA
 sucAqtNMiSnJf7ZzfjqROmf2gQaRO8SFP5xTLHoobsbcQsqnBGxtGde2Joy4B9avEsJD
 lr0ijXUar0+tIoHWx239B5A2gTpVgW9uoQo2g2WQaVWqsr6RVFH2LHcW4YpDXmsBQGkw
 RQ2T7ubeegmpq4lrNJ+6UQFa7eviyXzar6UKk9ZNjUC+TFyz5v8o/quU1YjVyv66PB4m
 0rqzC1FDBPloMjXYsWfds0lW6pIvZ6buqXwmrJYazbob5UJD3Zaty16GfDcVRGebPzEP
 5RqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697750578; x=1698355378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nv3oXKxb944zUzl3WXXH7IJvjD+TPF87yEqv4BjuzRw=;
 b=C9gfNEZHQiqGF5lIRzVdsvURo/Bcz76xbp6/OCUOIqu4jajG1NpjYL6vE2xTkNclLZ
 EoERfHmoR9HIwq41iE6mGV/upA76NQXESIzHf5qIh/tRPJje3lOSAfheKneF0TBMQklp
 fz0JJH3lCrACV0RPgkfoWyLOfwqFJ3aXf3/p5Ri+DLQInuTu07NBEgQvbyTKHKBgfWNW
 x+9Zg65/ZqwWGcTui29+RuLCPcPLyb+fSFBXiDqZpuzSy6uNskrV5mVXZjK+wUbPpFo6
 Fhr4yuZVhBUFz4DzKp6pnIqlDnvDH2nHyFmVFsDIItlx+q0+ZAD/mzLSeBxc4rqoobf0
 C8qg==
X-Gm-Message-State: AOJu0YyE9ZVChnAyATPI5cxIQCdlVgWOl44u7V+j5Ca0EHi9xkPxd7Xg
 DRTqogOmiEmejDW5qRMq3Y1zVG7Q9q/MaFJW555NcA==
X-Google-Smtp-Source: AGHT+IFxk1WYvD1zqsYrCDDPp/ZY4XIJIwKdzFOuGvNcmTnA+VeU325cYvdNOwqMxsrHQDh4Z1Cayg==
X-Received: by 2002:a05:651c:4c6:b0:2c0:14e2:1f5c with SMTP id
 e6-20020a05651c04c600b002c014e21f5cmr114228lji.5.1697750578071; 
 Thu, 19 Oct 2023 14:22:58 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a05600c488600b004080f0376a0sm497964wmp.42.2023.10.19.14.22.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 14:22:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 42/46] hw/display/virtio-gpu: Use VIRTIO_DEVICE() macro
Date: Thu, 19 Oct 2023 23:18:07 +0200
Message-ID: <20231019211814.30576-43-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019211814.30576-1-philmd@linaro.org>
References: <20231019211814.30576-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x229.google.com
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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20231017140150.44995-4-philmd@linaro.org>
---
 hw/display/virtio-gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 6efd15b6ae..4265316cbb 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1128,7 +1128,7 @@ static void virtio_gpu_ctrl_bh(void *opaque)
     VirtIOGPU *g = opaque;
     VirtIOGPUClass *vgc = VIRTIO_GPU_GET_CLASS(g);
 
-    vgc->handle_ctrl(&g->parent_obj.parent_obj, g->ctrl_vq);
+    vgc->handle_ctrl(VIRTIO_DEVICE(g), g->ctrl_vq);
 }
 
 static void virtio_gpu_handle_cursor(VirtIODevice *vdev, VirtQueue *vq)
-- 
2.41.0


