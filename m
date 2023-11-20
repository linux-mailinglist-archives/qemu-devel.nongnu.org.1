Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E2F7F1F41
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 22:36:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Bu5-0001K4-BJ; Mon, 20 Nov 2023 16:34:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5Bu3-0001J3-IJ
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:33:59 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5Bu0-0003Iy-IU
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:33:59 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4084de32db5so23400665e9.0
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 13:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700516035; x=1701120835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q5q8QrKQWuc5ZJauQIVd7Hh9PAH4SP4rAcWXs3pwmqE=;
 b=jCWV1wbkyERg6hF35VqiCyW8CUpdsYYaWQBOV9YfJziIQCJ3CPACMs4bhVDav5Lp7b
 wFXvwevdIgCfNyG+ok/+nk4vdfXfPfDHOixuqlDuAw4MsfTGxshHhMSg+xR7f3QpSCF1
 uEVK95K4NOiRw+TSfx7wJP5Ut6lZm5duCixsDu8c6FEuEDts84a+na6qbT4X4wU3DSUJ
 3hcoMjzt8yqlLSEeva2+kOsa3tJVXbMC8XG7UymB2xcx0hpW7aDldYSYdjMY2INq9UmZ
 UDI3fvrRb1O+FK+zDMrZpVroo7b+6Dy0x2s0UM+wL4G23JuMRasssW6MEpNrchorOFwK
 OYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700516035; x=1701120835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q5q8QrKQWuc5ZJauQIVd7Hh9PAH4SP4rAcWXs3pwmqE=;
 b=LUqQNspU+uWy+Tmfhm4cclpW3fO1KX1/MQ02+dYxpc61wkROETEiPL9NuReJjmrYXq
 Xh4iXk4K5qfjo3aTu9f57pR0JIfpqmFxjXiMhUZIiaWw6gwb7XmPZAr3Lx0dMglGukZb
 /MbPZ6xNNNUUDS9DujKOX36dusi8ys/02cOIZxZKZ/Z2q6jWXQ0RdVZoTKj/cVgQ+kNT
 2RTO+qS4g5dK04AK3hzRTlk36LwTSYYaI9ZyM2WUrNYn/CtTJUDTwhIgAu7IE/PqnNtc
 uklnP04BrHfyb4ro9BsneB6XHudZ1txe8WdkutqKZkE2sIBpNSTPuJp0rYNUxdkkqQ+g
 0rHQ==
X-Gm-Message-State: AOJu0Yzqc+h9llRU13UroxmpV0GBcHWAWTjOQAUNBkO3ujDIvEVZG6vS
 bX8XuMfmq3jPDw4XDW9D+LQj9yAIJEn8N8VG8v0=
X-Google-Smtp-Source: AGHT+IFtChFCcJ1xXKeaT07FMhkAl1Yfp8nNYMMp/8/9C/tFefF/sI10PcAYlvV5dQpfoLRA6l1ciQ==
X-Received: by 2002:a7b:cd14:0:b0:408:3804:2a20 with SMTP id
 f20-20020a7bcd14000000b0040838042a20mr6807648wmj.22.1700516035088; 
 Mon, 20 Nov 2023 13:33:55 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.190])
 by smtp.gmail.com with ESMTPSA id
 a3-20020a05600c348300b0040a5e69482esm19351694wmq.11.2023.11.20.13.33.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Nov 2023 13:33:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH-for-9.0 05/25] memory: Simplify
 memory_region_init_ram_from_fd() calls
Date: Mon, 20 Nov 2023 22:32:39 +0100
Message-ID: <20231120213301.24349-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231120213301.24349-1-philmd@linaro.org>
References: <20231120213301.24349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Mechanical change using the following coccinelle script:

@@
expression mr, owner, arg3, arg4, arg5, arg6, arg7, errp;
@@
-   memory_region_init_ram_from_fd(mr, owner, arg3, arg4, arg5, arg6, arg7, &errp);
    if (
-       errp
+       !memory_region_init_ram_from_fd(mr, owner, arg3, arg4, arg5, arg6, arg7, &errp)
    ) {
        ...
        return;
    }

and removing the local Error variable.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/memory.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 2fe4c3861b..ca05c4defa 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3604,11 +3604,8 @@ void memory_region_init_ram(MemoryRegion *mr,
                             Error **errp)
 {
     DeviceState *owner_dev;
-    Error *err = NULL;
 
-    memory_region_init_ram_nomigrate(mr, owner, name, size, &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!memory_region_init_ram_nomigrate(mr, owner, name, size, errp)) {
         return;
     }
     /* This will assert if owner is neither NULL nor a DeviceState.
-- 
2.41.0


