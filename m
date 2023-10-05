Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EC87B9A5D
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:48:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFJF-00009T-KB; Wed, 04 Oct 2023 23:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFIb-00089t-L7
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:45:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFIX-0000Zl-KO
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lIgJ5oPfxO9wyqqBUeBUKavXa8KETRJWhHSgRUqGuy8=;
 b=dNWYTLQgP4jwkbH8F69hiqL4cYOzf+sxzdvaf+Z+CNS+EkMaz/NIeN+UjRRtFvT2+NvOl7
 0poXTbEibzcw7dRr5T8ud5WiycwCDiAChWyVo+J97b5bZHzQgLDabrwH9wvwyBh0BMQBwu
 8ykSOh5kUAo04d2AxuRwAQFa60O+Jgw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-ZQL_T-rxPp-LqlgPDHXl9A-1; Wed, 04 Oct 2023 23:44:55 -0400
X-MC-Unique: ZQL_T-rxPp-LqlgPDHXl9A-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-314256aedcbso478568f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:44:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477494; x=1697082294;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lIgJ5oPfxO9wyqqBUeBUKavXa8KETRJWhHSgRUqGuy8=;
 b=vhRxjqB5NsQ4NHHUgOyyKBnUJ68iy5x5zYzutASaTc5E7aO3RJvGk+gBZrPElxMNkW
 MlyUjTB+C4v1z1I2+bqIR75Pz5kJrTeZJrhFyoUuxS/K0YUDtbZEJDiBphQwc5hoYTam
 1gc6o85ohD8b4/FpI7e76e+GW0dz5gJD9tbSHTi68MK+Od1ZU1KH+nI9LZ6IrHaRX+fY
 hoMEAOTFzCkTArbY72n+3vvA1G3Sy4A5ZguZKP3CKFwtkGbmvZkw236S0kIsOpsK89Ux
 Jmk7AZ5Eer1/cbzafowciCznn8FcHFEeT4tdDLmtVA7QpgIoQyEHYjl8FiYahaU8q02R
 Oqrg==
X-Gm-Message-State: AOJu0YwQvrKX8Jq01ShB1HocEiBx4Tbqcayfkt5diY/15sRZidUASWoA
 HxGxtnD/C2sUwNeJkP9hZSHtWCk2mabX0amDaBZocrL/LBnqwyxqey43VH/Wqn11XxwBpqYOSKI
 PmiP5q6cDD1bxidDNBTnaPfqz4pVxeNCavYZfYms7h5Q2FvoEGMh43XfdlPSYS/fz9G9h
X-Received: by 2002:adf:f48c:0:b0:317:e025:5a5c with SMTP id
 l12-20020adff48c000000b00317e0255a5cmr3783251wro.48.1696477493998; 
 Wed, 04 Oct 2023 20:44:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPn9+2aBUMkDRoU24rvmhwRS4RciPAN8/vylwumUj2KGfQ1hAxVTMRVtu5sFtQ5rVI0igyWw==
X-Received: by 2002:adf:f48c:0:b0:317:e025:5a5c with SMTP id
 l12-20020adff48c000000b00317e0255a5cmr3783239wro.48.1696477493677; 
 Wed, 04 Oct 2023 20:44:53 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 t18-20020a5d49d2000000b0031c6581d55esm626527wrs.91.2023.10.04.20.44.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:44:53 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:44:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fan Ni <fan.ni@samsung.com>
Subject: [PULL v2 35/53] hw/cxl: Push cxl_decoder_count_enc() and
 cxl_decode_ig() into .c
Message-ID: <f5a4e1a697e98c7bd0a663d53a378d8c6918ed72.1696477105.git.mst@redhat.com>
References: <cover.1696477105.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696477105.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

There is no strong justification for keeping these in the header
so push them down into the associated cxl-component-utils.c file.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20230913132523.29780-2-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_component.h | 18 ++----------------
 hw/cxl/cxl-component-utils.c   | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index 42c7e581a7..bdb3881a6b 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -225,26 +225,12 @@ void cxl_component_create_dvsec(CXLComponentState *cxl_cstate,
                                 enum reg_type cxl_dev_type, uint16_t length,
                                 uint16_t type, uint8_t rev, uint8_t *body);
 
-static inline int cxl_decoder_count_enc(int count)
-{
-    switch (count) {
-    case 1: return 0;
-    case 2: return 1;
-    case 4: return 2;
-    case 6: return 3;
-    case 8: return 4;
-    case 10: return 5;
-    }
-    return 0;
-}
+int cxl_decoder_count_enc(int count);
 
 uint8_t cxl_interleave_ways_enc(int iw, Error **errp);
 uint8_t cxl_interleave_granularity_enc(uint64_t gran, Error **errp);
 
-static inline hwaddr cxl_decode_ig(int ig)
-{
-    return 1ULL << (ig + 8);
-}
+hwaddr cxl_decode_ig(int ig);
 
 CXLComponentState *cxl_get_hb_cstate(PCIHostState *hb);
 bool cxl_get_hb_passthrough(PCIHostState *hb);
diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index 378f1082ce..ea2d4770ec 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -13,6 +13,24 @@
 #include "hw/pci/pci.h"
 #include "hw/cxl/cxl.h"
 
+int cxl_decoder_count_enc(int count)
+{
+    switch (count) {
+    case 1: return 0;
+    case 2: return 1;
+    case 4: return 2;
+    case 6: return 3;
+    case 8: return 4;
+    case 10: return 5;
+    }
+    return 0;
+}
+
+hwaddr cxl_decode_ig(int ig)
+{
+    return 1ULL << (ig + 8);
+}
+
 static uint64_t cxl_cache_mem_read_reg(void *opaque, hwaddr offset,
                                        unsigned size)
 {
-- 
MST


