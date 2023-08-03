Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3854876F5B0
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 00:23:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRghp-000603-Jz; Thu, 03 Aug 2023 18:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRghi-0005y3-W0
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:21:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRghh-0000bW-CW
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691101316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7JJGQmIG8/D9w2B8AamYYdIjwo2ZvijCQld71KYHtag=;
 b=S3yNJbEv3Mg867df1sDAvomfQgUwcc7/AULCslkOqhM6WRWNQVXqLOw6Yg43aB6FZm2yKl
 +tUcWfyiEhr2K0Z3Memv8YMCRM2wHs7aViDUTUiKH3fgDvKDdt3xwQ/PC/78zWjI4QOn3v
 +TzOQESspR4J5KBS88ZCRdChRvIfVDM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-Xs1YYjYCMk-Z6N9xHVPCyg-1; Thu, 03 Aug 2023 18:21:55 -0400
X-MC-Unique: Xs1YYjYCMk-Z6N9xHVPCyg-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-51bef8bb689so3138457a12.1
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 15:21:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691101314; x=1691706114;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7JJGQmIG8/D9w2B8AamYYdIjwo2ZvijCQld71KYHtag=;
 b=VIZsydCPL1NdCTiZJWNwn/IWOiMozdWpim66X38XehECDT1D8XwKdnUW1ntldwHBx6
 ca8bfW/iXt03pZViI3aMTT3YG+uWlgpXXXHRArQ+zuKzgtEetpmISRy30aFcV6OORWno
 /RJOascvL6y6k1bAEKTh6VPeeFj8qZqcpDiY3FE0ZhtnZq4LxARWme4Q4kSmfrmbpDRA
 xyObIUeOKDDPQKd9XD3i+/StrYioJ9FTr4ZVQXqKvT42/WiE2nrt6Zp82oo+12Y7u+fQ
 1S7KqUR+gFXgz/IJJ0yojI77Q4FQO2ymoRF58ut8LhAppx24Tq7dWnYd4YBf4A4r8KKk
 D91g==
X-Gm-Message-State: AOJu0Yya173Icm6xTTwO+JXtroP5+z4FFdV74zfo5X7yNeKdwlUkI+aH
 jsdN10HRpkeq9c2F+JvBiAvW0Z6Yax9VsjFO7AWgj8KiDduw+lSelIz5AWNYUbHIIiBfuNe42sd
 XsxD+w22tEdRiOAJlF3WRw8Ja9TZ6N+f+VJgri8aYLRXzF81y8ZC72HZSZ1nsJv8U2XPn
X-Received: by 2002:a17:907:720a:b0:978:8979:c66c with SMTP id
 dr10-20020a170907720a00b009788979c66cmr64178ejc.18.1691101313889; 
 Thu, 03 Aug 2023 15:21:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVej7J65taYSwtsHM9Uoy9QqmtUBQjxJ/WJ6soD3dxApuLDuGeocbMON3t9scMHQPJLKucgA==
X-Received: by 2002:a17:907:720a:b0:978:8979:c66c with SMTP id
 dr10-20020a170907720a00b009788979c66cmr64163ejc.18.1691101313640; 
 Thu, 03 Aug 2023 15:21:53 -0700 (PDT)
Received: from redhat.com ([2.52.12.104]) by smtp.gmail.com with ESMTPSA id
 lg12-20020a170906f88c00b00992ca779f42sm375300ejb.97.2023.08.03.15.21.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 15:21:53 -0700 (PDT)
Date: Thu, 3 Aug 2023 18:21:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 20/22] include/hw/i386/x86-iommu: Fix struct
 X86IOMMU_MSIMessage for big endian hosts
Message-ID: <e1e56c07d1fa24aa37a7e89e6633768fc8ea8705.1691101215.git.mst@redhat.com>
References: <cover.1691101215.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1691101215.git.mst@redhat.com>
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

From: Thomas Huth <thuth@redhat.com>

The first bitfield here is supposed to be used as a 64-bit equivalent
to the "uint64_t msi_addr" in the union. To make this work correctly
on big endian hosts, too, the __addr_hi field has to be part of the
bitfield, and the the bitfield members must be declared with "uint64_t"
instead of "uint32_t" - otherwise the values are placed in the wrong
bytes on big endian hosts.

Same applies to the 32-bit "msi_data" field: __resved1 must be part
of the bitfield, and the members must be declared with "uint32_t"
instead of "uint16_t".

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20230802135723.178083-7-thuth@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 include/hw/i386/x86-iommu.h | 50 +++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/include/hw/i386/x86-iommu.h b/include/hw/i386/x86-iommu.h
index 8d8d53b18b..bfd21649d0 100644
--- a/include/hw/i386/x86-iommu.h
+++ b/include/hw/i386/x86-iommu.h
@@ -87,40 +87,42 @@ struct X86IOMMU_MSIMessage {
     union {
         struct {
 #if HOST_BIG_ENDIAN
-            uint32_t __addr_head:12; /* 0xfee */
-            uint32_t dest:8;
-            uint32_t __reserved:8;
-            uint32_t redir_hint:1;
-            uint32_t dest_mode:1;
-            uint32_t __not_used:2;
+            uint64_t __addr_hi:32;
+            uint64_t __addr_head:12; /* 0xfee */
+            uint64_t dest:8;
+            uint64_t __reserved:8;
+            uint64_t redir_hint:1;
+            uint64_t dest_mode:1;
+            uint64_t __not_used:2;
 #else
-            uint32_t __not_used:2;
-            uint32_t dest_mode:1;
-            uint32_t redir_hint:1;
-            uint32_t __reserved:8;
-            uint32_t dest:8;
-            uint32_t __addr_head:12; /* 0xfee */
+            uint64_t __not_used:2;
+            uint64_t dest_mode:1;
+            uint64_t redir_hint:1;
+            uint64_t __reserved:8;
+            uint64_t dest:8;
+            uint64_t __addr_head:12; /* 0xfee */
+            uint64_t __addr_hi:32;
 #endif
-            uint32_t __addr_hi;
         } QEMU_PACKED;
         uint64_t msi_addr;
     };
     union {
         struct {
 #if HOST_BIG_ENDIAN
-            uint16_t trigger_mode:1;
-            uint16_t level:1;
-            uint16_t __resved:3;
-            uint16_t delivery_mode:3;
-            uint16_t vector:8;
+            uint32_t __resved1:16;
+            uint32_t trigger_mode:1;
+            uint32_t level:1;
+            uint32_t __resved:3;
+            uint32_t delivery_mode:3;
+            uint32_t vector:8;
 #else
-            uint16_t vector:8;
-            uint16_t delivery_mode:3;
-            uint16_t __resved:3;
-            uint16_t level:1;
-            uint16_t trigger_mode:1;
+            uint32_t vector:8;
+            uint32_t delivery_mode:3;
+            uint32_t __resved:3;
+            uint32_t level:1;
+            uint32_t trigger_mode:1;
+            uint32_t __resved1:16;
 #endif
-            uint16_t __resved1;
         } QEMU_PACKED;
         uint32_t msi_data;
     };
-- 
MST


