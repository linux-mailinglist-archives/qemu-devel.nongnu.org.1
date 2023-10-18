Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB047CDD5A
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:32:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6eJ-0008Gh-5M; Wed, 18 Oct 2023 09:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt6eG-0008B6-NO
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:31:45 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt6eD-0004my-3a
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:31:43 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4083f613272so3856005e9.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 06:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697635899; x=1698240699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2n8IpqQIL5F84eyb1MGuQCyy0ZKYgEpFAxkwPCfg6VQ=;
 b=zQwo1CmzriR2TvsqqAml3/Xh0j3lSIX08ZtFs4XggEuGFrz6X2PcWx0F+GtrYWER6p
 GWn8MrD0ZJlr8A02+q3vilaXwRJ5eNLaHuIFtEqo3nLln1DfSDfRsvD25XAJMRMCX68z
 dT/jfvxrRsURivYaal5KfTF1n5Q2ScZnDj/w9bC33jucSuLc9FO2pX1BMCeh9kluGdK+
 q6TH2n/ske3kld0et/rO6DbVsiUd0NBZCnQhnxKnEPDr1iu7TtqQ5NHhJC7UAaHyNFOJ
 joIvSat8kauk75WWad7375YDRPNISK2gHtDsiKgYGGWoXvayTbNhEY/qTPHD4EUoWmOa
 xTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697635899; x=1698240699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2n8IpqQIL5F84eyb1MGuQCyy0ZKYgEpFAxkwPCfg6VQ=;
 b=nPZLaiJBntqS2BMezJt30gH65a5dzDfeYO4b1d/5E8wOAGbzal3g43ZatVqy/hxdTU
 YK7KQgVCIAe0A15w44XAlQSEFqMMZs8fo3bscoFBZgnfWpwr8RLjKh667QgiE0k3srMj
 Kmp3tDEAuQNrtUoYvNmXcqnAWzcCRxuPfQ4If0MtEnU1hSPoVPUGYwMABKPyO427tkW/
 m8Km+rT+0+l7vQny97wcL7wLDJNMUJiQeQHc2YLdya62YVH/WGE5tkPkslYYVgZUN6S5
 A9Mp3Q/TRFkuRya/yjJV9YJTDp2I1Y/lhdGix5b0O0KX66+zzOyr3uFjNZb2z909gjyp
 IEwA==
X-Gm-Message-State: AOJu0Yy46uPUbJSCWU1H5Nu+vf5L8Wj+/loKMMG1sQOnJg/GM7d2Xo2+
 z2zLs47UcVgnASntQK2Xtwle9bdWIqwdusMMEXA=
X-Google-Smtp-Source: AGHT+IHMkcWk3Ns01tOkZd1QYaErFwYIcllHtNRi9UrqJvyWps1z2vlDKxsazzamcbSjd+jthh+ihA==
X-Received: by 2002:a05:600c:4fd2:b0:402:f07c:4b48 with SMTP id
 o18-20020a05600c4fd200b00402f07c4b48mr3998659wmq.28.1697635899276; 
 Wed, 18 Oct 2023 06:31:39 -0700 (PDT)
Received: from m1x-phil.lan (gyl59-h01-176-171-218-149.dsl.sta.abo.bbox.fr.
 [176.171.218.149]) by smtp.gmail.com with ESMTPSA id
 q1-20020adffec1000000b00326b8a0e817sm2126646wrs.84.2023.10.18.06.31.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Oct 2023 06:31:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/6] hw/intc/spapr_xive: Do not use SysBus API to map local
 MMIO region
Date: Wed, 18 Oct 2023 15:30:59 +0200
Message-ID: <20231018133059.85765-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018133059.85765-1-philmd@linaro.org>
References: <20231018133059.85765-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

There is no point in exposing an internal MMIO region via
SysBus and directly mapping it in the very same device.

Just map it without using the SysBus API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/spapr_xive.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 12057ffe5b..199c261b07 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -350,12 +350,12 @@ static void spapr_xive_realize(DeviceState *dev, Error **errp)
      * Map all regions. These will be enabled or disabled at reset and
      * can also be overridden by KVM memory regions if active
      */
-    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xsrc->esb_mmio);
-    sysbus_mmio_map(SYS_BUS_DEVICE(xive), 0, xive->vc_base);
-    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &end_xsrc->esb_mmio);
-    sysbus_mmio_map(SYS_BUS_DEVICE(xive), 1, xive->end_base);
-    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xive->tm_mmio);
-    sysbus_mmio_map(SYS_BUS_DEVICE(xive), 2, xive->tm_base);
+    memory_region_add_subregion(get_system_memory(), xive->vc_base,
+                                &xsrc->esb_mmio);
+    memory_region_add_subregion(get_system_memory(), xive->end_base,
+                                &end_xsrc->esb_mmio);
+    memory_region_add_subregion(get_system_memory(), xive->tm_base,
+                                &xive->tm_mmio);
 }
 
 static int spapr_xive_get_eas(XiveRouter *xrtr, uint8_t eas_blk,
-- 
2.41.0


