Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8992F709A7B
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:52:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01Qw-00076O-Nr; Fri, 19 May 2023 10:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01Qt-00074D-BJ
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:50:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01Ql-0003U6-JF
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:50:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684507805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3Uz+rubBMDavSXwC+q/q5QWww1PtBSrKQ33BgEKuCPk=;
 b=e2WyVN/qLHA0xd0GwTBXBHBw+yk/MLJKhg21GbsRTgUWnXg5GfWnOWykxJsy8o34eNo85P
 5fcS8xjQuOPqKQDkzN3dEvVcJJCTIsiFxh+xGS7yUUGtBWkE5hbwNKIWQqTzTezoVXfJOI
 CJBCKOzyVSofA6RZPCZjI4OAhwW6/4A=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-EumRFo64N_KPENZllNbbiw-1; Fri, 19 May 2023 10:50:04 -0400
X-MC-Unique: EumRFo64N_KPENZllNbbiw-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2af1a8b6c38so10036351fa.1
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507802; x=1687099802;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Uz+rubBMDavSXwC+q/q5QWww1PtBSrKQ33BgEKuCPk=;
 b=ZxXXpvo5NesF4bkcGhAR9X1N8d4vR0+A+WE1bjT+UCQXlQ3m9EclYxaff4z6015+Rf
 A2O8/zaoeB1dRtiTXm0dofPBr08LHz8DSQoI4CsyAuuQqOOGe/qNHbqtHv/haNho7lwC
 cnTpLzQA54vMhQTjGPBY+HiKw3V8TYZvAWeeD4SD/OK7hY16+HUjVu3HE/2D4PABEzp6
 PdQAwBXbORf9QRDipidrVzlfbF93oW7xJOMRpe5mGG+Ga5NNcbF0FzeK4k5GCcy7m3EY
 FRGf5d+QItFEz0F7bfNnGks+XjZOqXycDUJfQIPrJFeNJ6+xEeqJOkP4FfG2h3R2EQfI
 TwkA==
X-Gm-Message-State: AC+VfDxoVx+J+GaWt/XVttD5cWxeDPgiYVqWlkCcac1UChFlOOfdCSqB
 EoupkrFYj4MXROJwK/7H5AJQocH+B27XDz7W7y9wT3cWzqYAKeQ3TuyBLJdDUML81CFJk3AHR7L
 Pd6EtUuxjd1XT71h+T5iuKJPntQ/qLr6RmR/azXePPJk/jU7iqx7OKDedGoOUkWG8aP+k
X-Received: by 2002:a2e:8887:0:b0:2af:2686:65f1 with SMTP id
 k7-20020a2e8887000000b002af268665f1mr826970lji.7.1684507802778; 
 Fri, 19 May 2023 07:50:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6BrApu1/3TH67DQntYWdC7bVmEWcNr2nWboJz2Xah4hAk9gmopfboALr09TaGfbN4T6sEVzg==
X-Received: by 2002:a2e:8887:0:b0:2af:2686:65f1 with SMTP id
 k7-20020a2e8887000000b002af268665f1mr826956lji.7.1684507802428; 
 Fri, 19 May 2023 07:50:02 -0700 (PDT)
Received: from redhat.com ([176.12.184.180]) by smtp.gmail.com with ESMTPSA id
 u6-20020a2e8446000000b002ad333df101sm847534ljh.133.2023.05.19.07.49.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 07:50:01 -0700 (PDT)
Date: Fri, 19 May 2023 10:49:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Raghu H <raghuhack78@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Stefan Weil <sw@weilnetz.de>
Subject: [PULL 05/40] docs/cxl: Remove incorrect CXL type 3 size parameter
Message-ID: <9830ea6126c6a3b3ea7af720d98aa7717dba59eb.1684507742.git.mst@redhat.com>
References: <cover.1684507742.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1684507742.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Raghu H <raghuhack78@gmail.com>

cxl-type3 memory size is read directly from the provided memory backed end
device. Remove non existent size option

Signed-off-by: Raghu H <raghuhack78@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20230421134507.26842-3-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/system/devices/cxl.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index 9618becdab..dd1a62bd57 100644
--- a/docs/system/devices/cxl.rst
+++ b/docs/system/devices/cxl.rst
@@ -354,13 +354,13 @@ An example of 4 devices below a switch suitable for 1, 2 or 4 way interleave::
   -device cxl-rp,port=1,bus=cxl.1,id=root_port1,chassis=0,slot=1 \
   -device cxl-upstream,bus=root_port0,id=us0 \
   -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
-  -device cxl-type3,bus=swport0,memdev=cxl-mem0,lsa=cxl-lsa0,id=cxl-pmem0,size=256M \
+  -device cxl-type3,bus=swport0,memdev=cxl-mem0,lsa=cxl-lsa0,id=cxl-pmem0 \
   -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
-  -device cxl-type3,bus=swport1,memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem1,size=256M \
+  -device cxl-type3,bus=swport1,memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem1 \
   -device cxl-downstream,port=2,bus=us0,id=swport2,chassis=0,slot=6 \
-  -device cxl-type3,bus=swport2,memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem2,size=256M \
+  -device cxl-type3,bus=swport2,memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem2 \
   -device cxl-downstream,port=3,bus=us0,id=swport3,chassis=0,slot=7 \
-  -device cxl-type3,bus=swport3,memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem3,size=256M \
+  -device cxl-type3,bus=swport3,memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem3 \
   -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
 
 Kernel Configuration Options
-- 
MST


