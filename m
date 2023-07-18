Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15558757911
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 12:14:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLhiG-000212-Ty; Tue, 18 Jul 2023 06:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLhiE-00020f-QC
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 06:13:47 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLhhy-0001fZ-Cl
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 06:13:44 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fbc5d5746cso55701915e9.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 03:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689675209; x=1692267209;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SxF+adkG9POmfvABIs1cEVjtEat+n4+pscBvBaP5wS0=;
 b=pX5sNz07+nrenfzof5N8GXZZ1+/CDLnEQTcqoEiMmt8kz+Izi7XDfyRFa8m9iHW7TP
 YbJM5mUweil7hj27UZU2WQU90nmE2pYMr5lkAmwQthZJklCtP8+9JzEqzseY0SounDXi
 +y1cm3vWUgkjFtMVFZDP1qoIiSlsFhiWpX+5U3BfAliVo2smXct2uUndxey8OIe2gs52
 hHYoZpvsBhNgDug7qPTzR5PdrKR1DGoTih2mTwLgrNmG0Vp7qwoFOjIDxwB0+4AqvO+D
 OWWd98wNcngQgMqFixpf5iXu1jDtYr1R0I3PEiSjHaMG6HSSlTS1YX8c833tqyDWT7of
 YA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689675209; x=1692267209;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SxF+adkG9POmfvABIs1cEVjtEat+n4+pscBvBaP5wS0=;
 b=a5vSmjvCgmZBUVU2FO/qJp6mbLOb5JL70QmId6uGHVJPasn+PDweV8QqbhQfOkZTuz
 Uaz8jj6MfxwZ1cO7QTXSKbFawgC8XGWxEsQLOcXw5r2knN7ciddEdIxIAmI1bfUsDzGU
 qFjp7igGtFCSh5IDJwUH5ztURqMBTzfHL9xEPWyezPZcmNyZNo4viytzGhRTluGVVqOz
 it3VwA2Rz/Lnyiu/m3iKbq6pCr/4LfoICjp7PLEG8IUncZU1sxJj6MtLm4UMX28T1kcG
 Ht9iHfKjL+f7QIAvVwN97hM+Q+YgHVrnEIsULyQwA+rBx3Eynk7Rwc6p5YEvg20mUGXo
 o5yA==
X-Gm-Message-State: ABy/qLZn6Wc6aRSLuSeLPIXiGMKG1sRkwtYvJB7249MhvQodNJXQGvfU
 c4TmznQFFpR1oPHvqJ3CoS6S4cZnMm7OrATTnOc=
X-Google-Smtp-Source: APBJJlHYD5rlhNoq8y/xJtONXF6Wi45wbeckvcODwRaJ9KcNVxLwsrr0mQqiVmFxSRheK3RMEcQ4tw==
X-Received: by 2002:adf:f452:0:b0:314:2e77:afec with SMTP id
 f18-20020adff452000000b003142e77afecmr12851551wrp.57.1689675208724; 
 Tue, 18 Jul 2023 03:13:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 q4-20020adffec4000000b003144bfbd0b3sm1956529wrs.37.2023.07.18.03.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jul 2023 03:13:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH for-8.1] hw/pci-bridge/cxl_upstream.c: Use g_new0() in
 build_cdat_table()
Date: Tue, 18 Jul 2023 11:13:27 +0100
Message-Id: <20230718101327.1111374-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

In build_cdat_table() we do:
 *cdat_table = g_malloc0(sizeof(*cdat_table) * CXL_USP_CDAT_NUM_ENTRIES);
This is wrong because:
 - cdat_table has type CDATSubHeader ***
 - so *cdat_table has type CDATSubHeader **
 - so the array we're allocating here should be items of type CDATSubHeader *
 - but we pass sizeof(*cdat_table), which is sizeof(CDATSubHeader **),
   implying that we're allocating an array of CDATSubHeader **

It happens that sizeof(CDATSubHeader **) == sizeof(CDATSubHeader *)
so nothing blows up, but this should be sizeof(**cdat_table).

Avoid this excessively hard-to-understand code by using
g_new0() instead, which will do the type checking for us.
While we're here, we can drop the useless check against failure,
as g_malloc0() and g_new0() never fail.

This fixes Coverity issue CID 1508120.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Disclaimer: I have not tested this beyond any testing you
get from 'make check' and 'make check-avocado'.
---
 hw/pci-bridge/cxl_upstream.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index ef47e5d6253..9159f48a8cb 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -274,10 +274,7 @@ static int build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
         };
     }
 
-    *cdat_table = g_malloc0(sizeof(*cdat_table) * CXL_USP_CDAT_NUM_ENTRIES);
-    if (!*cdat_table) {
-        return -ENOMEM;
-    }
+    *cdat_table = g_new0(CDATSubHeader *, CXL_USP_CDAT_NUM_ENTRIES);
 
     /* Header always at start of structure */
     (*cdat_table)[CXL_USP_CDAT_SSLBIS_LAT] = g_steal_pointer(&sslbis_latency);
-- 
2.34.1


