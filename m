Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BEC7E38BC
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:18:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J5s-0005Hp-4B; Tue, 07 Nov 2023 05:14:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J5p-0005Fn-B9
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:13:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J5n-0002yj-EK
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:13:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699352034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KQuD0MNvhUhapxwsPVq4rZ3ip7Xjdt38HGbe4S+/MRk=;
 b=EH1+qhGjn3hHkigzIC5BAwt/b3JkJ5322Rvulcxf14MLDrDhvZvpaWNCpob73mjK6Ywf0K
 WhEtLnLO/P1wWWHanmNX1NszeRxf0zTbmNC8S27aLltje3dEr8R5y9/KdZeFKdJrGRYiBW
 z25fUKLQE69/KWI58GpFgvUFDYbKJSc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-jT3eK_LVNQSe0VV4-g38qg-1; Tue, 07 Nov 2023 05:13:53 -0500
X-MC-Unique: jT3eK_LVNQSe0VV4-g38qg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40839252e81so36871875e9.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:13:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699352032; x=1699956832;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KQuD0MNvhUhapxwsPVq4rZ3ip7Xjdt38HGbe4S+/MRk=;
 b=ZXnqTSR6cOsVVTw86tOs4GUKSvp51fEckW+a4urQ5khiPHtepGOZTGd016gZhnlojd
 +b06IAATKRdzvlDOFCWAIzZ1VGN9vymPovCaE2zB0Bhu9wKRTNVcsHMBfpAGE7gf4/4+
 M488jQVR3sVhlSNI7dXHkmlro0Fw+xL45+nZzkjCVXhmtO+hciPK9dN7MN699cKkvIgP
 JSAs066PiDASU4r8vBLSVJNiTvJCRe0tNpD1CeVqLr2uCMOiEAZV6GaW215JOaOJAw0V
 Ad13oIaP5VsGJjoVWNIhofMWPrBA1UuIfWzKk5ezUP4hDnPGyEIdwaLm4kowdOnwkL53
 6Tqg==
X-Gm-Message-State: AOJu0Ywc4MYaoJ+9XkRzzEnfqcjScLFx/Pe3bI/W18PwO27NV8kp9jAt
 qXgp23EoREM4Y4mzmc6tTAgTNENeCLFhlSA8nb+1DndM2g8ByV0e0H/Zcvn+cIjvvkbPhp9GZFM
 hyx97CxO+Tli8o2nef/yoFusF7LFLa5wwquPqeWBWdAnZVhh+QX2MDqI20IVxbdkb6ssg
X-Received: by 2002:a05:600c:45cd:b0:405:1c14:9227 with SMTP id
 s13-20020a05600c45cd00b004051c149227mr2117701wmo.33.1699352031820; 
 Tue, 07 Nov 2023 02:13:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvm1fwOD13vcdRrDtgyPw7POZHvHsllVAj7jBJIM1xGfjOA1XV6NeFIX+gULVqte23sttNBQ==
X-Received: by 2002:a05:600c:45cd:b0:405:1c14:9227 with SMTP id
 s13-20020a05600c45cd00b004051c149227mr2117682wmo.33.1699352031461; 
 Tue, 07 Nov 2023 02:13:51 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 c2-20020a5d4f02000000b00327de0173f6sm1901463wru.115.2023.11.07.02.13.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:13:50 -0800 (PST)
Date: Tue, 7 Nov 2023 05:13:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gregory Price <gourry.memverge@gmail.com>,
 Gregory Price <gregory.price@memverge.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 59/63] hw/cxl/type3: Cleanup multiple CXL_TYPE3() calls in
 read/write functions
Message-ID: <ede604d505d711e45abcc37dd4389967fda410d7.1699351720.git.mst@redhat.com>
References: <cover.1699351720.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1699351720.git.mst@redhat.com>
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

From: Gregory Price <gourry.memverge@gmail.com>

Call CXL_TYPE3 once at top of function to avoid multiple invocations.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20231023160806.13206-16-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/mem/cxl_type3.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index cc8220592f..a766c64575 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -888,17 +888,18 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
 MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
                            unsigned size, MemTxAttrs attrs)
 {
+    CXLType3Dev *ct3d = CXL_TYPE3(d);
     uint64_t dpa_offset = 0;
     AddressSpace *as = NULL;
     int res;
 
-    res = cxl_type3_hpa_to_as_and_dpa(CXL_TYPE3(d), host_addr, size,
+    res = cxl_type3_hpa_to_as_and_dpa(ct3d, host_addr, size,
                                       &as, &dpa_offset);
     if (res) {
         return MEMTX_ERROR;
     }
 
-    if (sanitize_running(&CXL_TYPE3(d)->cci)) {
+    if (sanitize_running(&ct3d->cci)) {
         qemu_guest_getrandom_nofail(data, size);
         return MEMTX_OK;
     }
@@ -909,17 +910,18 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
 MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
                             unsigned size, MemTxAttrs attrs)
 {
+    CXLType3Dev *ct3d = CXL_TYPE3(d);
     uint64_t dpa_offset = 0;
     AddressSpace *as = NULL;
     int res;
 
-    res = cxl_type3_hpa_to_as_and_dpa(CXL_TYPE3(d), host_addr, size,
+    res = cxl_type3_hpa_to_as_and_dpa(ct3d, host_addr, size,
                                       &as, &dpa_offset);
     if (res) {
         return MEMTX_ERROR;
     }
 
-    if (sanitize_running(&CXL_TYPE3(d)->cci)) {
+    if (sanitize_running(&ct3d->cci)) {
         return MEMTX_OK;
     }
 
-- 
MST


