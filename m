Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D357E6E88
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 17:22:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r17mb-0003JW-5G; Thu, 09 Nov 2023 11:21:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r17mX-0003JH-ND
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 11:21:26 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r17mW-00054W-12
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 11:21:25 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4083ac51d8aso7690095e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 08:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699546881; x=1700151681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=I4UeJwJDjARUbk3jdq8RMSZM9NTad63mlPhVrm1Mx84=;
 b=ovrMnKxkVc+c7OGwTmJdK9/VSdEHM795f7mjWcTYysdfmnVD3cgk4+6/5XxSCIenNw
 xMj4YrfXPFENvsqkOQjS/Rjg81p2DTA8P495vMjWMgf5XhUO5yPOmbsyMUB35fkAR0vI
 ectxng0qGUu3c0pYc7l/Yv3lu6K4NRs/SCbsTBgiAZBHRooVfb+Vx+hruPrrQvtDibfv
 GDatZ+h4HoH+25z90UjrX67PmCMKAVet8QmnsZfD1BAhwk9ZJeSAGMbxXfal6XttyNtq
 V9ATtg5/uFPjQ4oVK1B4IbAN83wCGE329zphUt/yUjlAhU5yevr4FuiTmgHq3NcAhzyL
 Sncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699546881; x=1700151681;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I4UeJwJDjARUbk3jdq8RMSZM9NTad63mlPhVrm1Mx84=;
 b=EDZcSs4kF1P74Cxe3mZOiy2MJwLhQsVdE7GPpLq3iox6KjUFBdRdYDP0zzwQLAugcu
 m7h+6Ng9E0UlpgrltHys7h9Dg0Hg9u8G7yicn5tcdlBdrMsGaAYoRBMslbODrFAcg72w
 uZWFpyF6R8oaVR7y8mj+aYRRSfhtrYEOcC4P1+lsxnZO/tdfJ0+OokWzcn4xYbZcTUVv
 BshE/rXO7zSzLGVEZwa098u+UcwFW+YMpv/GpxCHUUukGIiWN9c4+zjWNkIMO5SYCrbF
 Phpo9Orl+zSfbeC1VpqgSuzb2F08tLcF1afs7i3FeXnVJU+eC7Jax1Wpij5166RZaL3h
 mbIQ==
X-Gm-Message-State: AOJu0YyvH342nK/14aZMA1cazn5dOm8jx6gopvXZ64vh/bj9oYMiXjfP
 HwKYw+qPcblRk2gCmsbu2fg6UraG5OW07zXQl14KDA==
X-Google-Smtp-Source: AGHT+IEIrxKlX7wTK1cSttMdH6AzH2Bvofax9fSJp1WWRFWeabJxDG6xqOc5uxCSzCy9kuhCJe/UzQ==
X-Received: by 2002:a05:600c:1992:b0:401:daf2:2737 with SMTP id
 t18-20020a05600c199200b00401daf22737mr4607277wmq.30.1699546881433; 
 Thu, 09 Nov 2023 08:21:21 -0800 (PST)
Received: from localhost.localdomain (adsl-109.37.6.163.tellas.gr.
 [37.6.163.109]) by smtp.gmail.com with ESMTPSA id
 b22-20020a05600c06d600b0040841e79715sm2480519wmn.27.2023.11.09.08.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 08:21:20 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] virtio-snd: check AUD_register_card return value
Date: Thu,  9 Nov 2023 18:20:35 +0200
Message-Id: <20231109162034.2108018-1-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x335.google.com
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

AUD_register_card might fail. Even though errp was passed as an
argument, the call's return value was not checked for failure.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/audio/virtio-snd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index a18a9949a7..ccf5fcf99e 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -1102,7 +1102,9 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    AUD_register_card("virtio-sound", &vsnd->card, errp);
+    if (!AUD_register_card("virtio-sound", &vsnd->card, errp)) {
+        return;
+    }
 
     /* set default params for all streams */
     default_params.features = 0;

base-commit: ad6ef0a42e314a8c6ac6c96d5f6e607a1e5644b5
-- 
2.39.2


