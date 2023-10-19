Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C73367CFA70
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:10:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtSn2-0005Qa-Rv; Thu, 19 Oct 2023 09:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtSmg-0004Nz-KK
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:09:55 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtSmf-0007l7-0g
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:09:54 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-507c78d258fso2896871e87.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697720991; x=1698325791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IrXKI6jVLRlYzi/YxZFiozSO1YVRsr5CmuAToS28wAk=;
 b=JahDwffL68LEt9Uk5iYJov1n9unlLPEk/J3is+0Nc19fPd1w75kQ+Kmax+XVGG2z+6
 Zlu6TWtbdMKeELOhR8mXXQz0WJ1F5QGyr0r7mrbVy9ZcR5Jya8gFmrC8sOhc42Q7fiY8
 W25Z+TTdj94I0j2qHBgih1NoN8aXqNqoX4bGFy+z3LbKLuEYGjS+dXEceOqp8+Ax+dpE
 XPP671FVDyXtvwD30+OSYvpKiOmiQrjvPSIbjzEwdQ9k/nt0dZ8qYQ4Bu/FyBIpUNmPA
 l2QVxGDOvq1YM7DgR2WefMA3/AXtpSYW8d1AewBbjcmZf+FjxjByOVD1rJy/471geRrr
 i4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697720991; x=1698325791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IrXKI6jVLRlYzi/YxZFiozSO1YVRsr5CmuAToS28wAk=;
 b=Ofgd/GAgH+Q2BGl8N7KkEEIuEIHPXPe40JsYEfq+YdGEXoD7stZINDHZlwu1JfscTM
 1pJfarSRBbUZWrlTD96i3stw/gX+vMYhXgG9NWqEFiAMcHy5uPIhg6uc3xk3ssN5u8Bs
 6cz+YFFkYJRWtIhtkG7Qd7YLIa62xpKN7tovYXeVSiWErd13kkDpGkh4UxHb879tVA42
 3KSLBwhXdlHvIxScVQv/GPMbGgMqcelQMx/m4r/g0J5w7Mcun4CF/BsWjV+E0KiJiw3a
 HezGHCjWBb8s8LUqWEKyZsJuEpSyZcKXhyvC+YEt3b0ZirXhofqXqe2ypcSs3aZSD2CH
 BdQg==
X-Gm-Message-State: AOJu0YzXPFE814mhN4PchxvSHA3yn0741U4+jQP7moyXS5RqNtRRQxPz
 Lu1WqoI53FFa59diKFGzv5CTYiUKVetmxpjtMzx7ow==
X-Google-Smtp-Source: AGHT+IGtnYm/bucD6PIZ9L5SiyjKCk93yo+q2A3lOYCcx7Ine6wA028rxOSE6LRiWAgRZ6YswzeNgg==
X-Received: by 2002:a05:6512:3d25:b0:507:a0d7:bd19 with SMTP id
 d37-20020a0565123d2500b00507a0d7bd19mr1989067lfv.13.1697720990921; 
 Thu, 19 Oct 2023 06:09:50 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 e38-20020a05600c4ba600b004075d5664basm4324622wmp.8.2023.10.19.06.09.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 06:09:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/9] hw/pcmcia/pxa2xx: Do not open-code
 sysbus_create_simple()
Date: Thu, 19 Oct 2023 15:09:19 +0200
Message-ID: <20231019130925.18744-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019130925.18744-1-philmd@linaro.org>
References: <20231019130925.18744-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pcmcia/pxa2xx.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/hw/pcmcia/pxa2xx.c b/hw/pcmcia/pxa2xx.c
index e7264feb45..a2ab96d749 100644
--- a/hw/pcmcia/pxa2xx.c
+++ b/hw/pcmcia/pxa2xx.c
@@ -141,13 +141,7 @@ static void pxa2xx_pcmcia_set_irq(void *opaque, int line, int level)
 PXA2xxPCMCIAState *pxa2xx_pcmcia_init(MemoryRegion *sysmem,
                                       hwaddr base)
 {
-    DeviceState *dev;
-
-    dev = qdev_new(TYPE_PXA2XX_PCMCIA);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
-
-    return PXA2XX_PCMCIA(dev);
+    return PXA2XX_PCMCIA(sysbus_create_simple(TYPE_PXA2XX_PCMCIA, base, NULL));
 }
 
 static void pxa2xx_pcmcia_initfn(Object *obj)
-- 
2.41.0


