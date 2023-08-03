Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D456C76F59F
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 00:22:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRggn-0004Hd-LP; Thu, 03 Aug 2023 18:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRggk-0004GH-IJ
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:20:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRggj-0000Ox-27
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691101256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4GzWS5FnIrPDtn2Htg+CctKW805+xbLzE7TTNfE7rtM=;
 b=etWVgu4FvwNQohfgR/SjIToCMx74In6g7spmo14TGye5XOolOz81cRBUBrYH8gyybvDMmM
 /JoXAJ6ldM8kdFwmY5utgFFl5Z1PahNgPItP6osiO7uQUInwkpoRHjpWI2xVtbd3s5+Hu1
 S9m1/99laHQhucN44uHwLOzIOoWEAdU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-hHztSPF9MAqT-PLREt3HQA-1; Thu, 03 Aug 2023 18:20:53 -0400
X-MC-Unique: hHztSPF9MAqT-PLREt3HQA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-99c01c680beso86834766b.2
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 15:20:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691101252; x=1691706052;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4GzWS5FnIrPDtn2Htg+CctKW805+xbLzE7TTNfE7rtM=;
 b=Sb1pbeNeim8UxQbe6ccl7/DjQw4SfPImDOO2+bzBSkskBO2+MSrtk3TKZKX0no8Gvr
 dKTJUrxt96xI+WZ8MAT25NGS7Aul+Ad74YFM6bpd9DVqdNL2vYfYAObZVD0KK/NdkjlQ
 peSB22+TDMQAmgRqrDErhGE9ByWK6wpzRLwvWmRDjp+xefrdM1njc16dRMtNtR8KISvJ
 eCJY73JKQlvnRGZ3EU4ePf2UjXaWfFK294LXbo+kW514jEckQnGTkTq2mZcFQGs/ypYT
 ehswl2FtYi6AiiWUN6JZosFVAIZ8DXSmFGEf527i4ej8Q8/lfuiRb+yAAyzrHa43M8sU
 XyzA==
X-Gm-Message-State: ABy/qLYXN01yGJD8v/EBczzBzLh5i5RXoE//LW0VT30XvBYoBQjkzeKd
 jA+IFMKv+jgC6y6sl4UIhFUVHJ7gSvmGXbftKQJqIAn3h6ctkZvlaBjTz01Omrp8Q/PrMcEOl3d
 +EBUqzeEIo19vf/Iv3OGiGbLgeocs/fuh7xrt0Ao7KiMhxlF0Cdc6s1iot6TPJ3o95MYF
X-Received: by 2002:a17:906:ef8f:b0:99b:6c47:1145 with SMTP id
 ze15-20020a170906ef8f00b0099b6c471145mr8307713ejb.32.1691101252023; 
 Thu, 03 Aug 2023 15:20:52 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGC2RbUh9hRPRFq5l7zep3nZyUxHGMUk6SX+DZSt2/JVgixKXWM7+eJABYxA2CGOuveYyGFkg==
X-Received: by 2002:a17:906:ef8f:b0:99b:6c47:1145 with SMTP id
 ze15-20020a170906ef8f00b0099b6c471145mr8307703ejb.32.1691101251772; 
 Thu, 03 Aug 2023 15:20:51 -0700 (PDT)
Received: from redhat.com ([2.52.12.104]) by smtp.gmail.com with ESMTPSA id
 a1-20020a1709063a4100b0099275c59bc9sm379916ejf.33.2023.08.03.15.20.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 15:20:51 -0700 (PDT)
Date: Thu, 3 Aug 2023 18:20:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 02/22] hw/pci-bridge/cxl_upstream.c: Use g_new0() in
 build_cdat_table()
Message-ID: <503d86dd66625b4bed9484bca71db1678c730dc9.1691101215.git.mst@redhat.com>
References: <cover.1691101215.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1691101215.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

From: Peter Maydell <peter.maydell@linaro.org>

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
Message-Id: <20230718101327.1111374-1-peter.maydell@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/pci-bridge/cxl_upstream.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index ef47e5d625..9159f48a8c 100644
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
MST


