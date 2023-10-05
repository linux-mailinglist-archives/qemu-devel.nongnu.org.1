Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2567B9A6A
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:48:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFJC-0008J8-Bl; Wed, 04 Oct 2023 23:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFIX-00088G-Qw
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:45:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFIM-0000NF-C7
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:45:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iIows2pa7XiHA3IFb00/fM9UuGPbHhq3xJctrR09FOQ=;
 b=IrhYMfQJd23g03Vsjdax56pax/vLvD9uu5xidWiJacc0RJOBx2MSJ8K4T+QqvcRLZm0332
 UAtcTbkrEtbRqUnPWtFD3jukrLLamaBJhvmTVGdjC2evg9vshxz0SRd5DBMUeJnhfXmzSj
 ARV0UsRTleVIS76YJbbOldbsB84HKI4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-ifZqWjjzPS-OQoWkFrQ3yw-1; Wed, 04 Oct 2023 23:45:00 -0400
X-MC-Unique: ifZqWjjzPS-OQoWkFrQ3yw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40524bc3c5cso3346965e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:44:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477498; x=1697082298;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iIows2pa7XiHA3IFb00/fM9UuGPbHhq3xJctrR09FOQ=;
 b=p1rC4DFWGB8KZ6vbuE972f8zjTU5LOiPV4kmZUoL8kjzJdD6tDIY+bsEb4fBa9xE03
 Sele/MUEX3v7iWvT9tUWLJWnZ7R5m+nkKyRlOmT0wwCNnP7PFWpB3GSGW7CWHEWc0qUE
 TmwKn0zkSyTeq1vuw4XQkeAWByhoiM6hQF24o7Kn4gM+pyFmWNMzSFqAnCLULSoYGUIE
 ZG1lpJzvsf8AYh1Jp8lY3TqXDZy/IMdHnAlqeJ8P4tNJsLQnXrpSpBNfuwV3JDL7r2ly
 xsfFDDJRdSK4wqrAXJyC9uLXjng9c2w5CxVWEOF46bY+1n+veOaVd7+/1R4QgYbw6OGN
 VC2w==
X-Gm-Message-State: AOJu0Yx7/GjympUbcxIrhR30BKN3sSF1eW3ztUOJXdfq84XnsxsneWr/
 6S3+ESVrJfdTbBteeDx1rDvLukLX9MvGNJqYt9qncuqX+9e4gdFblkKMDIH6LFXPLvYJt3x2xV2
 c/zYDxwrwg6+WBrlIewXzXW8yDjlOr6FJTCUAnD3iVeBAoFfSBdNy/lS6ZThiXGi+yyEk
X-Received: by 2002:a05:600c:2242:b0:401:2fab:43e8 with SMTP id
 a2-20020a05600c224200b004012fab43e8mr3698522wmm.15.1696477498216; 
 Wed, 04 Oct 2023 20:44:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzFDofEJajpUvKeQrmXUxWBQ+Ofz78k7OpptlOvImgD+vnvzq+AZQ1IBgFcFy9R74jv1BLJg==
X-Received: by 2002:a05:600c:2242:b0:401:2fab:43e8 with SMTP id
 a2-20020a05600c224200b004012fab43e8mr3698510wmm.15.1696477497874; 
 Wed, 04 Oct 2023 20:44:57 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 f19-20020a7bc8d3000000b00405959469afsm549223wml.3.2023.10.04.20.44.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:44:57 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:44:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fan Ni <fan.ni@samsung.com>
Subject: [PULL v2 36/53] hw/cxl: Add utility functions decoder interleave
 ways and target count.
Message-ID: <87de174ac49acaa37264e38129596c9819e4a2c5.1696477105.git.mst@redhat.com>
References: <cover.1696477105.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696477105.git.mst@redhat.com>
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


