Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A5B75392D
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 13:01:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKGWv-0006vz-5X; Fri, 14 Jul 2023 07:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qKGWs-0006vD-Ep
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 07:00:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qKGWn-00059J-Oa
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 07:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689332400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LIaN5QbqMfJRoUfWCwELYAOMsonyWMKqvnsX5ZBOVyo=;
 b=hZsAKdqonjM81OK+eKRX+l/RjqDI/EAjcFgIGDrGjVF5Psij4c7nRLsYNLU1vhQr4kOGD7
 4jB8nyoWHaoOKhYTeEhxi//YCpwfmpMqU3go2+dMBrTced2vwDFps8qE7Xpwjmgat4Ux+4
 iIqvOk33MGd2t9a8ndsWEOe4iv4LBGA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-ptdcfYj0P3qM6e7gLoyBLw-1; Fri, 14 Jul 2023 06:59:59 -0400
X-MC-Unique: ptdcfYj0P3qM6e7gLoyBLw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fa976b8b6fso9719085e9.3
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 03:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689332397; x=1691924397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LIaN5QbqMfJRoUfWCwELYAOMsonyWMKqvnsX5ZBOVyo=;
 b=hrSCkZTo/xSNnor+ZMsmvEUZF+d/WrYhaI5daI2k7sowtbql2tnTdrvV1s8ncPDwdF
 hqKU40d5PQ1iyiSpQYR9eZRRquEKRJ0w9nG0ieja1aqKWQjn6v3ajn/gJDf0TGBUJJEd
 9Z8yT5ft7f2YXQmhVJ/7GLMRoBYW/SqW8Ue8MFP6+4AeSMzmEoQt80mqBZCDgYDIR/4e
 Pe1VnQWxS48VCXo1Tj0s4We5d5lD6HrAURlYsB3yDRxAV/W97V4k6sWycen3W4Slvu1i
 8GX/YqBj5wDRHo9L4AX5ZDwnT4a2rWVv/tfqC2oYxODwibsuCKw/ee+8H1/HdXrmDfrO
 Vrnw==
X-Gm-Message-State: ABy/qLYYTBz9AHRISpOxHATV+sjDYoXKU1eftFQkmJRwwnbf43WOXMyI
 M5acep7k/P+xJMlqPm2uMReObSuh0Dyg73mR7UjjgHLn9LRactyR/ValniEkwReFLbGyPB01KkQ
 2oUV7agnVjiRcw3ulV3tLICi6GxguWPK/xlOBJdGSMrRcZ2C8gWHXT3yjlj0j9E45UKPwgus4rc
 k=
X-Received: by 2002:a05:600c:21c4:b0:3fb:b3f8:506b with SMTP id
 x4-20020a05600c21c400b003fbb3f8506bmr3719983wmj.24.1689332397482; 
 Fri, 14 Jul 2023 03:59:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEKqDmnaK25g9vSJmecSj+4wPjjaoRo5ReIXaKbKFABjCKPAaMTXJ9vGJmChfK/FxpETvF/vw==
X-Received: by 2002:a05:600c:21c4:b0:3fb:b3f8:506b with SMTP id
 x4-20020a05600c21c400b003fbb3f8506bmr3719964wmj.24.1689332397061; 
 Fri, 14 Jul 2023 03:59:57 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 m17-20020a7bce11000000b003fc07e17d4esm1184717wmc.2.2023.07.14.03.59.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jul 2023 03:59:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Olaf Hering <olaf@aepfle.de>, Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/5] hw/ide/piix: properly initialize the BMIBA register
Date: Fri, 14 Jul 2023 12:59:49 +0200
Message-ID: <20230714105953.223485-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714105953.223485-1-pbonzini@redhat.com>
References: <20230714105953.223485-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Olaf Hering <olaf@aepfle.de>

According to the 82371FB documentation (82371FB.pdf, 2.3.9. BMIBA-BUS
MASTER INTERFACE BASE ADDRESS REGISTER, April 1997), the register is
32bit wide. To properly reset it to default values, all 32bit need to be
cleared. Bit #0 "Resource Type Indicator (RTE)" needs to be enabled.

The initial change wrote just the lower 8 bit, leaving parts of the "Bus
Master Interface Base Address" address at bit 15:4 unchanged.

Fixes: e6a71ae327 ("Add support for 82371FB (Step A1) and Improved support for 82371SB (Function 1)")

Signed-off-by: Olaf Hering <olaf@aepfle.de>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230712074721.14728-1-olaf@aepfle.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/ide/piix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ide/piix.c b/hw/ide/piix.c
index 151f206046e..4e5e12935f5 100644
--- a/hw/ide/piix.c
+++ b/hw/ide/piix.c
@@ -117,7 +117,7 @@ static void piix_ide_reset(DeviceState *dev)
     pci_set_word(pci_conf + PCI_COMMAND, 0x0000);
     pci_set_word(pci_conf + PCI_STATUS,
                  PCI_STATUS_DEVSEL_MEDIUM | PCI_STATUS_FAST_BACK);
-    pci_set_byte(pci_conf + 0x20, 0x01);  /* BMIBA: 20-23h */
+    pci_set_long(pci_conf + 0x20, 0x1);  /* BMIBA: 20-23h */
 }
 
 static bool pci_piix_init_bus(PCIIDEState *d, unsigned i, Error **errp)
-- 
2.41.0


