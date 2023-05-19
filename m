Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69596709AB8
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:58:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01RN-0000H3-Rr; Fri, 19 May 2023 10:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01RJ-0008Rk-Kb
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:50:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01RI-0003Z5-0P
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684507839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d8Vso+Qj5ywaim6O4xRNK9ALzOFtW4T9mhpU0PHW6Hs=;
 b=aJQHzbu2y7g3e+EJPy8PvWuKAJrMQBU3DRZmWC8CHlTLH+W+8nkCi1ywanrjlMohhwg1k1
 NS0qVr3LDxrvGakEq3WsNyHKFukEYBng6S8dcz99GQURySxOBSgpqqrZd2+vjXkiXjJeSr
 YBgNWuYPgVweIdjZfigzk26jMYDFmVQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-tc1rH6rmNYe7wOaycsHHQw-1; Fri, 19 May 2023 10:50:38 -0400
X-MC-Unique: tc1rH6rmNYe7wOaycsHHQw-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2af1589c75aso13513011fa.2
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:50:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507836; x=1687099836;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d8Vso+Qj5ywaim6O4xRNK9ALzOFtW4T9mhpU0PHW6Hs=;
 b=Ow/O1THLAnY4nE12/sBJk9KJ34CltQvlFKU0OhJhUthlQFSEd7kySCzBVJYlajQn8O
 SQF8bduHLv0iX0I0Rkl6mULSGBpBBuUltDBk6eZQUVfKoWGDOcg2eIEtjkJm6dgF4f4q
 lSqiIk8Kfs3ck94Z7uCEIeM4PQw1RxqlXXd6zwQmIr5Lw/CNUthEpewd9FMso8x6fY/L
 Og//rpHo0Xxf52jtExWfVBPxNJyONeEL2GdNjtt67dTkVEAZHfOr0UJxgs0QjOMPWAsQ
 mKMaQGp8/JyLsqgJv2nXoWcds1zVhad7lEfG9hVPB6UZCHR54dXkaNjtSybeOiIueaZ1
 u47w==
X-Gm-Message-State: AC+VfDx7jcWgt2vH+uR1oLWQWlTE+fCmduyjTqAZBwLq4UmSQp/5A/0g
 3/+uDbc4ROcuRqAAiskukjcoLMQoppLi7RrqNaJpLosIqSxq9gBTcYMPifitEjYU+/xycQzGInX
 DZkWPogZTZINLXlSAEi4Gewstr6vVw8J0WtJSpo5xxzmJ2r4G7FJxqP/o1c2dcEzFOAds
X-Received: by 2002:a2e:8456:0:b0:2af:1d3b:accd with SMTP id
 u22-20020a2e8456000000b002af1d3baccdmr1040842ljh.33.1684507836175; 
 Fri, 19 May 2023 07:50:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ799TimEDBb5fq5ccEJVcm8ehOqhOS7r4ow2oignp2+1Lieojm+y0PaGgmPyZk35vuLd1A35w==
X-Received: by 2002:a2e:8456:0:b0:2af:1d3b:accd with SMTP id
 u22-20020a2e8456000000b002af1d3baccdmr1040833ljh.33.1684507835912; 
 Fri, 19 May 2023 07:50:35 -0700 (PDT)
Received: from redhat.com ([176.12.184.180]) by smtp.gmail.com with ESMTPSA id
 d26-20020a2e361a000000b002ab397f1b0bsm860993lja.3.2023.05.19.07.50.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 07:50:35 -0700 (PDT)
Date: Fri, 19 May 2023 10:50:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Gregory Price <gregory.price@memverge.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 11/40] hw/mem: Use memory_region_size() in cxl_type3
Message-ID: <3521176526a901bd2a8418ce6470df0e38ca4e11.1684507742.git.mst@redhat.com>
References: <cover.1684507742.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1684507742.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Accessors prefered over direct use of int128_get64() as they
clamp out of range values.  None are expected here but
cleaner to always use the accessor than mix and match.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Message-Id: <20230421160827.2227-3-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Gregory Price <gregory.price@memverge.com>
---
 hw/mem/cxl_type3.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 1bd5963a3f..2db756851c 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -52,7 +52,7 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
         .DSMADhandle = dsmad_handle,
         .flags = CDAT_DSMAS_FLAG_NV,
         .DPA_base = 0,
-        .DPA_length = int128_get64(mr->size),
+        .DPA_length = memory_region_size(mr),
     };
 
     /* For now, no memory side cache, plausiblish numbers */
@@ -133,7 +133,7 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
         /* Reserved - the non volatile from DSMAS matters */
         .EFI_memory_type_attr = 2,
         .DPA_offset = 0,
-        .DPA_length = int128_get64(mr->size),
+        .DPA_length = memory_region_size(mr),
     };
 
     /* Header always at start of structure */
@@ -698,7 +698,7 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
         return MEMTX_ERROR;
     }
 
-    if (dpa_offset > int128_get64(mr->size)) {
+    if (dpa_offset > memory_region_size(mr)) {
         return MEMTX_ERROR;
     }
 
@@ -721,7 +721,7 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
         return MEMTX_OK;
     }
 
-    if (dpa_offset > int128_get64(mr->size)) {
+    if (dpa_offset > memory_region_size(mr)) {
         return MEMTX_OK;
     }
     return address_space_write(&ct3d->hostmem_as, dpa_offset, attrs,
-- 
MST


