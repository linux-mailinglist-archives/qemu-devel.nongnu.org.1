Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 656D176F5A8
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 00:23:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRghe-0005MQ-2O; Thu, 03 Aug 2023 18:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRghb-00057m-Ub
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:21:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRgha-0000Zv-DL
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:21:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691101309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M3GPlmcjnFZlSHkWXzkRW1s0JmfHVO7cSpboUgzOa3Y=;
 b=h8PHxk0FBEHvVTCnrExbqMa6tgT0cHWSfOfwF+qNdTw3ajBRrs39lEHiU9/nMCkOePDXqc
 LArmuPzi/QMLfvE5eTSPbvJ4e97iscZrK9eyed4Z28Rwfl8YGFOPQCxaQgdIX9cUA5ThTT
 RQ5WMATXob9+LS5EnfLgskviy/Nnqwc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-6lfav-HjP2qPQOG89QfkMQ-1; Thu, 03 Aug 2023 18:21:48 -0400
X-MC-Unique: 6lfav-HjP2qPQOG89QfkMQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-94a34d3e5ebso91692266b.3
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 15:21:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691101307; x=1691706107;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M3GPlmcjnFZlSHkWXzkRW1s0JmfHVO7cSpboUgzOa3Y=;
 b=ZCn1K2FuILbJKausZQGAGw/Br0+GT/PWy2vlnKMyVCoZ9/dEk54v5KfEtoBCbBnIK+
 MVFfXB28U5pgp+VOoHn13va3vjIZBMrWn3tgyxRlwNWr9Px8IkmSboI2PR+T2JVuTGTk
 rm3cD8MOITb5FM2PCRkO0ieiYXbGkvvibFwi0VlJJDdT4fz0yEcDi3mYUw6pFWTBbC2D
 qRVGA9n0ZljldD7Pp+9+IyLxoD3AcmVBdXjYHhiCE62a2xPWhHK02cONHkTJJPxwGV1A
 iZdETrgpc0Ja5AjjynRJSsisOfYu5WXSTvt1+MAcp8Fa2W73gE708SDpp1ByRSdsdNEb
 bwRw==
X-Gm-Message-State: ABy/qLZCZS+k2DQnHoVbicLp5cysECtzivXK9Vtz2Fq+cBB9Wt/Ycsly
 LzRV8YzvJ+gFm5lNA7FgRvUugbnSbWrBb7eIuXTh0ZPg1XFp4Ae3x1JJJViQkBSu7OMMuSm/lwC
 mGS0O9Vm937V7skNoPPZFoN9i8krdj3f1K5RyPAe/frRJUs1ehdhIXX4XOkU5H+zjsiWe
X-Received: by 2002:a17:906:74d7:b0:991:b834:af83 with SMTP id
 z23-20020a17090674d700b00991b834af83mr9065365ejl.59.1691101307241; 
 Thu, 03 Aug 2023 15:21:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH5EPDU5LAhnxkSdjn/1WT0wJF3/isCMAeHRWCvichcP3upMM0976tSooPCLBRzrJy++VrV6w==
X-Received: by 2002:a17:906:74d7:b0:991:b834:af83 with SMTP id
 z23-20020a17090674d700b00991b834af83mr9065349ejl.59.1691101307059; 
 Thu, 03 Aug 2023 15:21:47 -0700 (PDT)
Received: from redhat.com ([2.52.12.104]) by smtp.gmail.com with ESMTPSA id
 rl2-20020a170907216200b00992e51fecfbsm379998ejb.64.2023.08.03.15.21.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 15:21:46 -0700 (PDT)
Date: Thu, 3 Aug 2023 18:21:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 18/22] hw/i386/intel_iommu: Fix index calculation in
 vtd_interrupt_remap_msi()
Message-ID: <fcd8027423300b201b37842b88393dc5c6c8ee9e.1691101215.git.mst@redhat.com>
References: <cover.1691101215.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

The values in "addr" are populated locally in this function in host
endian byte order, so we must not swap the index_l field here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20230802135723.178083-5-thuth@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 4028e32701..3ca71df369 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3459,7 +3459,7 @@ static int vtd_interrupt_remap_msi(IntelIOMMUState *iommu,
         goto out;
     }
 
-    index = addr.addr.index_h << 15 | le16_to_cpu(addr.addr.index_l);
+    index = addr.addr.index_h << 15 | addr.addr.index_l;
 
 #define  VTD_IR_MSI_DATA_SUBHANDLE       (0x0000ffff)
 #define  VTD_IR_MSI_DATA_RESERVED        (0xffff0000)
-- 
MST


