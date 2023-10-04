Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B30FD7B7ACC
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:53:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxYM-0003sH-Jc; Wed, 04 Oct 2023 04:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxVy-0008JZ-V2
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:46:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxVv-0002N9-Kk
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iIows2pa7XiHA3IFb00/fM9UuGPbHhq3xJctrR09FOQ=;
 b=d7DXlhS1IcBkVe7yflQRBUPufVIGb0EthkoLEbjruAFnuqIZdSQ7gqDGpCnJNtnosANz1R
 nhxxdPsVaU4tzTXpTRXnyAC9oo1dAeamhuGSPh73whgmKu446oNGnyBi6BF/3KIs2XUw/U
 zM4oHmI/wFPSZABMsZVD4cKiy8cdNeE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-K5yajtuwNm-lknCCRX16BA-1; Wed, 04 Oct 2023 04:45:44 -0400
X-MC-Unique: K5yajtuwNm-lknCCRX16BA-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-503317b8d26so1750220e87.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:45:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409142; x=1697013942;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iIows2pa7XiHA3IFb00/fM9UuGPbHhq3xJctrR09FOQ=;
 b=SJWRpYJhva/bsJMIOWiAcSD2e1zQj/gH41EsMbwEJXcpL43bk+pW2b2W4YTvk6xy40
 jerJf3pS2OV5SJYe04YVCn3dRW2IYCxY5o+8M4J1OZYiC9YJj4K6Asck35S7WmSp3koK
 LRhPWXaS6EQttB61J8LPgJjrZS41M7b1iJDQ1ZlC8q//dIKEiUd1hWsNlfRc4iD6+iar
 FXlsmPyUTp849u0HTR73YNRbV5KeAe6z/QrmRwd1z9pDYBxEc8ocUV95jNGixn/bc6pX
 2Yp+Oehi2Ttua0f00uxn85dFU2bhSzaZZ7XCC1N1kyYd7QnbCZio2C1qorPG4uOF0EKP
 Ajpw==
X-Gm-Message-State: AOJu0YyEC+FrfDN6TsBMkUnwA8ccChJ80Rpn/WhDmNm98OSZEbmN3oxz
 xqoB9DfO7Uxk3d0sCM32LhBHv0G06yv3te5kAttWCnEW27PIp2k4jP+x3Vmpfbez5AY0PH5mxQG
 RI1NG17s0aaayJVeraX/MaXO6N9IQn3QqFjjcJNZ2kVTQ5AQFlVqd1PMgeABvz27ByjlT
X-Received: by 2002:ac2:44cb:0:b0:4fe:279b:8a02 with SMTP id
 d11-20020ac244cb000000b004fe279b8a02mr1311991lfm.67.1696409142275; 
 Wed, 04 Oct 2023 01:45:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfZTqupX7ltWmxDngAb0/Imca/wHlBpGtdMSNAdcQQJQxfqxDW0XVLDhMiJcc9YzzeJWaUwg==
X-Received: by 2002:ac2:44cb:0:b0:4fe:279b:8a02 with SMTP id
 d11-20020ac244cb000000b004fe279b8a02mr1311974lfm.67.1696409141891; 
 Wed, 04 Oct 2023 01:45:41 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 az41-20020a05600c602900b004068495910csm843702wmb.23.2023.10.04.01.45.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:45:41 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:45:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fan Ni <fan.ni@samsung.com>
Subject: [PULL 46/63] hw/cxl: Add utility functions decoder interleave ways
 and target count.
Message-ID: <0464596068ea56aa8d2bfc2c53f9efd0a0d604bf.1696408966.git.mst@redhat.com>
References: <cover.1696408966.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696408966.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

As an encoded version of these key configuration parameters is available
in a register, provide functions to extract it again so as to avoid
the need for duplicating the storage.

Whilst here update the _enc() function to include additional values
as defined in the CXL 3.0 specification. Whilst they are not
currently used in the emulation, they may be in future and it is
easier to compare with the specification if all values are covered.

Add a spec reference for cxl_interleave_ways_enc() for consistency
with the target count equivalent (and because it's nice to know where
the magic numbers come from).

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20230913132523.29780-3-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_component.h |  2 ++
 hw/cxl/cxl-component-utils.c   | 60 ++++++++++++++++++++++++++++++----
 2 files changed, 56 insertions(+), 6 deletions(-)

diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index bdb3881a6b..ef9e033919 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -226,8 +226,10 @@ void cxl_component_create_dvsec(CXLComponentState *cxl_cstate,
                                 uint16_t type, uint8_t rev, uint8_t *body);
 
 int cxl_decoder_count_enc(int count);
+int cxl_decoder_count_dec(int enc_cnt);
 
 uint8_t cxl_interleave_ways_enc(int iw, Error **errp);
+int cxl_interleave_ways_dec(uint8_t iw_enc, Error **errp);
 uint8_t cxl_interleave_granularity_enc(uint64_t gran, Error **errp);
 
 hwaddr cxl_decode_ig(int ig);
diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index ea2d4770ec..5f38f2016f 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -13,15 +13,45 @@
 #include "hw/pci/pci.h"
 #include "hw/cxl/cxl.h"
 
+/* CXL r3.0 Section 8.2.4.19.1 CXL HDM Decoder Capability Register */
 int cxl_decoder_count_enc(int count)
 {
     switch (count) {
-    case 1: return 0;
-    case 2: return 1;
-    case 4: return 2;
-    case 6: return 3;
-    case 8: return 4;
-    case 10: return 5;
+    case 1: return 0x0;
+    case 2: return 0x1;
+    case 4: return 0x2;
+    case 6: return 0x3;
+    case 8: return 0x4;
+    case 10: return 0x5;
+    /* Switches and Host Bridges may have more than 10 decoders */
+    case 12: return 0x6;
+    case 14: return 0x7;
+    case 16: return 0x8;
+    case 20: return 0x9;
+    case 24: return 0xa;
+    case 28: return 0xb;
+    case 32: return 0xc;
+    }
+    return 0;
+}
+
+int cxl_decoder_count_dec(int enc_cnt)
+{
+    switch (enc_cnt) {
+    case 0x0: return 1;
+    case 0x1: return 2;
+    case 0x2: return 4;
+    case 0x3: return 6;
+    case 0x4: return 8;
+    case 0x5: return 10;
+    /* Switches and Host Bridges may have more than 10 decoders */
+    case 0x6: return 12;
+    case 0x7: return 14;
+    case 0x8: return 16;
+    case 0x9: return 20;
+    case 0xa: return 24;
+    case 0xb: return 28;
+    case 0xc: return 32;
     }
     return 0;
 }
@@ -393,6 +423,7 @@ void cxl_component_create_dvsec(CXLComponentState *cxl,
     cxl->dvsec_offset += length;
 }
 
+/* CXL r3.0 Section 8.2.4.19.7 CXL HDM Decoder n Control Register */
 uint8_t cxl_interleave_ways_enc(int iw, Error **errp)
 {
     switch (iw) {
@@ -410,6 +441,23 @@ uint8_t cxl_interleave_ways_enc(int iw, Error **errp)
     }
 }
 
+int cxl_interleave_ways_dec(uint8_t iw_enc, Error **errp)
+{
+    switch (iw_enc) {
+    case 0x0: return 1;
+    case 0x1: return 2;
+    case 0x2: return 4;
+    case 0x3: return 8;
+    case 0x4: return 16;
+    case 0x8: return 3;
+    case 0x9: return 6;
+    case 0xa: return 12;
+    default:
+        error_setg(errp, "Encoded interleave ways: %d not supported", iw_enc);
+        return 0;
+    }
+}
+
 uint8_t cxl_interleave_granularity_enc(uint64_t gran, Error **errp)
 {
     switch (gran) {
-- 
MST


