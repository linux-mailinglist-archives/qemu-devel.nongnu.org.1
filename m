Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE2F7B7A69
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:44:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxTf-0002BP-3G; Wed, 04 Oct 2023 04:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxTc-00026i-90
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:43:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxTZ-0000tJ-G1
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZPz4GnJfkENcst/YvbRzP3MUYaB7CKMx8l9nJBdXF6s=;
 b=RGCKn3Qhq9MnHS2HLhKMIfUBQprb0Z42dv0QO06764zPGGrxtEHFQ4/rZdAN4y5aRm7qNc
 bUTzTTILzpGyueiIRtwVa69vHVvAcIfqELNeglxek9EoTpTNyRglvh/kSYhsp9UU99L3cT
 X4mR1VzJn+SMsRT0KmvE1/IWGk3WUh0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-AeRNtOT2PyCWU9xULHPEyA-1; Wed, 04 Oct 2023 04:43:23 -0400
X-MC-Unique: AeRNtOT2PyCWU9xULHPEyA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40554735995so13642665e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:43:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409001; x=1697013801;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZPz4GnJfkENcst/YvbRzP3MUYaB7CKMx8l9nJBdXF6s=;
 b=VG8mMO3rmnBpzmGod7m26FnmCJnAaqcOCb+I/2G4hLN4/Sl9iJp1YcbOyWr/3Y5fLI
 hLqt5lzAdUM9p4Uc3ViY05SnQHYE84+BvqNopg9nfjhtMoj9uM333FCMTj7ZWEZUPc1y
 yuT/tZxPCJaZZUvZ0AQYWRUF5P3hJTReuaDX3nR5GvlAFU9Cfx1R5RsZvRCw7SrnA5u5
 gDZtQmOJRawCANrQitRSHYdPEyWAGfj3QmAoVfg09YoEJ/4JZFwQy2RstcXGlKETgYWF
 IOXfIn7fah6smuWyBCzFy8tz/FgjrKOD7PgUlfJ1Rq8R4sgrvldBN8dOGRx73q9bHssZ
 ET9w==
X-Gm-Message-State: AOJu0YwAQSRTwS7lgD+dXfLEni6Bn+/1W4icG6eVPwngVzYh+htwj8D4
 0Qkp/PUE4mASkiOq/vRjiYw+RKAE35ipeRxN34O4rZ3QCWHr9e0P+EZWCou0rIyZc+Y9YAxyQGi
 RQXTLbVEAgg12l1/IzBkw2/iD9N9me9rzqYC+xaQBDeRHI0z+RNBL5AcldUCepPt3CFIB
X-Received: by 2002:a05:600c:1d9c:b0:406:8494:f684 with SMTP id
 p28-20020a05600c1d9c00b004068494f684mr951996wms.23.1696409001533; 
 Wed, 04 Oct 2023 01:43:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2nknIKAs+qObSKx5kwl8kpMpede0Pnc+KMx9MPbWgTGS42x5GNiU+g8fkb23XpCvbusnT5A==
X-Received: by 2002:a05:600c:1d9c:b0:406:8494:f684 with SMTP id
 p28-20020a05600c1d9c00b004068494f684mr951983wms.23.1696409001269; 
 Wed, 04 Oct 2023 01:43:21 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 r7-20020a5d6c67000000b00327df8fcbd9sm3274619wrz.9.2023.10.04.01.43.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:43:20 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:43:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 03/63] hw/virtio: Propagate page_mask to
 vhost_vdpa_section_end()
Message-ID: <7867e42e54e7721ef944e8b767b6b1965096be82.1696408966.git.mst@redhat.com>
References: <cover.1696408966.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696408966.git.mst@redhat.com>
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Propagate TARGET_PAGE_MASK (see the previous commit for
rationale).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230710094931.84402-3-philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 118c588205..3ab0dc0b5b 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -31,11 +31,12 @@
  * Return one past the end of the end of section. Be careful with uint64_t
  * conversions!
  */
-static Int128 vhost_vdpa_section_end(const MemoryRegionSection *section)
+static Int128 vhost_vdpa_section_end(const MemoryRegionSection *section,
+                                     int page_mask)
 {
     Int128 llend = int128_make64(section->offset_within_address_space);
     llend = int128_add(llend, section->size);
-    llend = int128_and(llend, int128_exts64(TARGET_PAGE_MASK));
+    llend = int128_and(llend, int128_exts64(page_mask));
 
     return llend;
 }
@@ -69,7 +70,7 @@ static bool vhost_vdpa_listener_skipped_section(MemoryRegionSection *section,
      */
 
     if (!memory_region_is_iommu(section->mr)) {
-        llend = vhost_vdpa_section_end(section);
+        llend = vhost_vdpa_section_end(section, page_mask);
         if (int128_gt(llend, int128_make64(iova_max))) {
             error_report("RAM section out of device range (max=0x%" PRIx64
                          ", end addr=0x%" PRIx64 ")",
@@ -331,7 +332,7 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
     }
 
     iova = TARGET_PAGE_ALIGN(section->offset_within_address_space);
-    llend = vhost_vdpa_section_end(section);
+    llend = vhost_vdpa_section_end(section, TARGET_PAGE_MASK);
     if (int128_ge(int128_make64(iova), llend)) {
         return;
     }
@@ -415,7 +416,7 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
     }
 
     iova = TARGET_PAGE_ALIGN(section->offset_within_address_space);
-    llend = vhost_vdpa_section_end(section);
+    llend = vhost_vdpa_section_end(section, TARGET_PAGE_MASK);
 
     trace_vhost_vdpa_listener_region_del(v, iova,
         int128_get64(int128_sub(llend, int128_one())));
-- 
MST


