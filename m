Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D94AF7E38AB
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:17:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J4g-0002mR-Nr; Tue, 07 Nov 2023 05:12:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J4e-0002m9-VT
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:12:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J4d-0002lX-8q
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:12:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699351962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OvBCdjY+PBjwJoWVkUe/T5ldK9L6FSppXbnkR3Y6SYI=;
 b=aUPu9bQA7GMv6cFzaG52qLNHYLokGifofNzFBQBMzPJVGfrrdN4d18/f5eXuMqgWaywSbs
 fseNck/nNGmOLnOk/bjV8JHDobdcg28+sB//NPeixln14TzFEAdJcvMdpg/vcFTOCuDJre
 bQzOnBgkaRJD7Rnn/Xoci+RZgb5bE2A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-vTPZlkMDP6WAveKqXVCviw-1; Tue, 07 Nov 2023 05:12:36 -0500
X-MC-Unique: vTPZlkMDP6WAveKqXVCviw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4084163ecd9so36077595e9.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:12:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351954; x=1699956754;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OvBCdjY+PBjwJoWVkUe/T5ldK9L6FSppXbnkR3Y6SYI=;
 b=XFnug2qE4++VgYRGGL530GCjcoMnCXeZI7moZf6wJ3SYwnAumK8pYXIYpM9K4WSMBz
 a1yJvCMdPf/PUDaECuM1IbrwYlpDv7p20mEMgJauRPMgzyQRQwuvahlWSyLL4ZjvB54W
 M8XgJO7U+8mT6KtNFeqHJbvsKsxr31ti7adAEVUy28SPTPP7U6VrwkVd1L98MC3aZGOk
 KImevBgTDtkJ1kMFTITdtvYN0Pi9sApq4YzdjPF7RU5pcqHnqDK+mZwoXmmFri3HCU37
 wgPLoVfiQQY8TNhQF/029aPGO+UCv1suBMeFI7GH+fRrqcSpDIeK7nYS6NtoBh/0OTes
 BiHA==
X-Gm-Message-State: AOJu0Yz4OIYUh9FgJsTkxr01w6nVxQY1qgoY2RMT1N9RbAJMdTB17n4Z
 eafSi0EuIOPEr+vF/XDpAVbCRbfMqRtbkuXpj018HKrowFUSNW6vvxy6RcW5B9svq9rUpzrLBSi
 gUkXztzNFKmxKAqvyILA6L9SJjWsJhOtKyuONp7cQX1aHdlDOuxBvKJHOQWvV2q2IWlBM
X-Received: by 2002:a05:600c:198a:b0:407:8e68:4a5b with SMTP id
 t10-20020a05600c198a00b004078e684a5bmr2052073wmq.38.1699351954595; 
 Tue, 07 Nov 2023 02:12:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7CTBPAWDN+cY6yu9WL3LBKMXJL3p3HoIlGxAh5wYbnnWaI/rtnNHp8fP+VKSPQhpIfmitEA==
X-Received: by 2002:a05:600c:198a:b0:407:8e68:4a5b with SMTP id
 t10-20020a05600c198a00b004078e684a5bmr2052055wmq.38.1699351954259; 
 Tue, 07 Nov 2023 02:12:34 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 bd13-20020a05600c1f0d00b004078d71be9csm15270066wmb.13.2023.11.07.02.12.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:12:33 -0800 (PST)
Date: Tue, 7 Nov 2023 05:12:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 41/63] hw/cxl: Use switch statements for read and write of
 cachemem registers
Message-ID: <388d6b574e282b02e8180f4cba428316a404deea.1699351720.git.mst@redhat.com>
References: <cover.1699351720.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1699351720.git.mst@redhat.com>
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Establishing that only register accesses of size 4 and 8 can occur
using these functions requires looking at their callers. Make it
easier to see that by using switch statements.
Assertions are used to enforce that the register storage is of the
matching size, allowing fixed values to be used for divisors of
the array indices.

Suggested-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>

Message-Id: <20231023140210.3089-3-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-component-utils.c | 66 +++++++++++++++++++++++-------------
 1 file changed, 43 insertions(+), 23 deletions(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index f3bbf0fd13..9d4f4bc8d4 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -67,16 +67,24 @@ static uint64_t cxl_cache_mem_read_reg(void *opaque, hwaddr offset,
     CXLComponentState *cxl_cstate = opaque;
     ComponentRegisters *cregs = &cxl_cstate->crb;
 
-    if (size == 8) {
+    switch (size) {
+    case 4:
+        if (cregs->special_ops && cregs->special_ops->read) {
+            return cregs->special_ops->read(cxl_cstate, offset, 4);
+        } else {
+            QEMU_BUILD_BUG_ON(sizeof(*cregs->cache_mem_registers) != 4);
+            return cregs->cache_mem_registers[offset / 4];
+        }
+    case 8:
         qemu_log_mask(LOG_UNIMP,
                       "CXL 8 byte cache mem registers not implemented\n");
         return 0;
-    }
-
-    if (cregs->special_ops && cregs->special_ops->read) {
-        return cregs->special_ops->read(cxl_cstate, offset, size);
-    } else {
-        return cregs->cache_mem_registers[offset / sizeof(*cregs->cache_mem_registers)];
+    default:
+        /*
+         * In line with specifiction limitaions on access sizes, this
+         * routine is not called with other sizes.
+         */
+        g_assert_not_reached();
     }
 }
 
@@ -117,25 +125,37 @@ static void cxl_cache_mem_write_reg(void *opaque, hwaddr offset, uint64_t value,
     ComponentRegisters *cregs = &cxl_cstate->crb;
     uint32_t mask;
 
-    if (size == 8) {
+    switch (size) {
+    case 4: {
+        QEMU_BUILD_BUG_ON(sizeof(*cregs->cache_mem_regs_write_mask) != 4);
+        QEMU_BUILD_BUG_ON(sizeof(*cregs->cache_mem_registers) != 4);
+        mask = cregs->cache_mem_regs_write_mask[offset / 4];
+        value &= mask;
+        /* RO bits should remain constant. Done by reading existing value */
+        value |= ~mask & cregs->cache_mem_registers[offset / 4];
+        if (cregs->special_ops && cregs->special_ops->write) {
+            cregs->special_ops->write(cxl_cstate, offset, value, size);
+            return;
+        }
+
+        if (offset >= A_CXL_HDM_DECODER_CAPABILITY &&
+            offset <= A_CXL_HDM_DECODER3_TARGET_LIST_HI) {
+            dumb_hdm_handler(cxl_cstate, offset, value);
+        } else {
+            cregs->cache_mem_registers[offset / 4] = value;
+        }
+        return;
+    }
+    case 8:
         qemu_log_mask(LOG_UNIMP,
                       "CXL 8 byte cache mem registers not implemented\n");
         return;
-    }
-    mask = cregs->cache_mem_regs_write_mask[offset / sizeof(*cregs->cache_mem_regs_write_mask)];
-    value &= mask;
-    /* RO bits should remain constant. Done by reading existing value */
-    value |= ~mask & cregs->cache_mem_registers[offset / sizeof(*cregs->cache_mem_registers)];
-    if (cregs->special_ops && cregs->special_ops->write) {
-        cregs->special_ops->write(cxl_cstate, offset, value, size);
-        return;
-    }
-
-    if (offset >= A_CXL_HDM_DECODER_CAPABILITY &&
-        offset <= A_CXL_HDM_DECODER3_TARGET_LIST_HI) {
-        dumb_hdm_handler(cxl_cstate, offset, value);
-    } else {
-        cregs->cache_mem_registers[offset / sizeof(*cregs->cache_mem_registers)] = value;
+    default:
+        /*
+         * In line with specifiction limitaions on access sizes, this
+         * routine is not called with other sizes.
+         */
+        g_assert_not_reached();
     }
 }
 
-- 
MST


