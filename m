Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E77867D9BFB
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:46:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwO0e-0007Uj-Dm; Fri, 27 Oct 2023 10:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0F-0007IN-6F
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:39:59 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0B-0008AF-Rh
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:39:58 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-31fa15f4cc6so1488326f8f.2
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698417594; x=1699022394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ooIxHMi95VXio8x/IzvnYifgViPdiDgXLTDa5pp5B1I=;
 b=M30YwRnTo5KnoQN8I1Lcsu/mEomArVNHgezrYAi1qhAkc4LFjCttqu+84Od0ScaKfa
 m7a6x7tiDkLfrTKPRoCGJIHA0M7tZcR6vorbMTroJl0U/JiENrLm/UokZ20coztDOeK/
 Je7HKa3Wj1OkoAISBNZxz53AiKWXCbn0CmzQlU5uT402o/6q/toMLMxNw7tdnCoMwZ4S
 ZcgFoKu8ISne0lPVQAuvuokJyhVtpxpgpcdDRn28nSTw29pq1Z2geDw04AKGnEVy9H43
 usEbhs4M8fw6lz1b5fP9C6nkwwdE3AcdZ5zTehweCXu/4JarX7oyTYkaLL9S17oh5ruM
 rTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698417594; x=1699022394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ooIxHMi95VXio8x/IzvnYifgViPdiDgXLTDa5pp5B1I=;
 b=Lss7xMyiNtM7okC4NOQq5ZNuJ82jAYzlxMoFS6Cteqsj8jjNch7Hp5bAWSZYTRyD/O
 vdHLUWnt54z4mjca5QJEYNAtw8I+zUd7QwNuh+++NnZHu0k4F+ZVx4VAjHAQQpgRdfkD
 wb+OgIMPEO6lrJshxpTxyxOPsreN+uHm4T0jrQ0grzONKbmEVN683cdlWYhULNbscVcE
 QlN0l40e1tKFl4EO9YyEANudss5sWaVXAngVTQD0p2ugla4O3C2FhlEyKEellFYwl2PM
 cSrn3O8tQAEhCXK+9DvVelI3dVq/TQ2X2UCKCzLARd1bdF/noSzpd7nP0vXP47l+gaw/
 S57g==
X-Gm-Message-State: AOJu0Yywh963QoMD45rCErWv4NWxUKAeYq1k9E2dEVNhdAs4dma3dXpA
 mQbQpgJZMmR8xvVf8APJkzSb80W8x0yHXl5MQJo=
X-Google-Smtp-Source: AGHT+IGkKBe+K8xV/B9dRK2rSSObAjdq6qPVY+fSELwRLTHV2rRpsXv+qcTW5l68esGseWG/klUlhA==
X-Received: by 2002:adf:ed84:0:b0:32d:a2cd:ad0c with SMTP id
 c4-20020adfed84000000b0032da2cdad0cmr2128329wro.50.1698417594563; 
 Fri, 27 Oct 2023 07:39:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d5002000000b0031c6581d55esm1874123wrt.91.2023.10.27.07.39.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 07:39:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/41] hw/pcmcia/pxa2xx: Realize sysbus device before accessing
 it
Date: Fri, 27 Oct 2023 15:39:23 +0100
Message-Id: <20231027143942.3413881-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027143942.3413881-1-peter.maydell@linaro.org>
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

sysbus_mmio_map() should not be called on unrealized device.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20231020130331.50048-4-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/pcmcia/pxa2xx.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/pcmcia/pxa2xx.c b/hw/pcmcia/pxa2xx.c
index fcca7e571b2..e7264feb455 100644
--- a/hw/pcmcia/pxa2xx.c
+++ b/hw/pcmcia/pxa2xx.c
@@ -142,15 +142,12 @@ PXA2xxPCMCIAState *pxa2xx_pcmcia_init(MemoryRegion *sysmem,
                                       hwaddr base)
 {
     DeviceState *dev;
-    PXA2xxPCMCIAState *s;
 
     dev = qdev_new(TYPE_PXA2XX_PCMCIA);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
-    s = PXA2XX_PCMCIA(dev);
-
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
 
-    return s;
+    return PXA2XX_PCMCIA(dev);
 }
 
 static void pxa2xx_pcmcia_initfn(Object *obj)
-- 
2.34.1


