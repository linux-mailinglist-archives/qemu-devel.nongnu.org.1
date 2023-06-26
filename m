Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAB673DF67
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 14:37:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlO4-0007fe-RP; Mon, 26 Jun 2023 08:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlMQ-0005Q7-MM
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:30:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlMO-0003Zm-Tf
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MJ9botFGkaoWh8PWyeQFOSjPZov2yyt/c15HeORAvds=;
 b=Kwve6T+S1R6WzEHsdLpleiZrokJVVAXLWfFcPuU1PDLvDTTy1+jBG2MUSWUrj2mZU9xYq0
 FU6CBV/Zk+066JWKgIIdxle9+jf/n80U0Uqe7Rdyjz66u04BMB1YFaaTJI6GA/JN8QxX+G
 0X6a4JZHCJ+FdbDRRzBsdFQ+8PUFMMg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-Vi8nS49hN3aND3Xma93hGA-1; Mon, 26 Jun 2023 08:30:22 -0400
X-MC-Unique: Vi8nS49hN3aND3Xma93hGA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f9bd5c7fdfso18612115e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782621; x=1690374621;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MJ9botFGkaoWh8PWyeQFOSjPZov2yyt/c15HeORAvds=;
 b=GyHSBJDHUqpH3BxFbKoYIZbV9MdZcyP8FMWeNuP/ec3bV+XPGZMYmU7MvQt48k+l4D
 NYDPxqdneklBUpsAb1K9kgdciov7Dod2741NFzFdNvzbfJ2Wr/pdjRQequlb8BGxQ+js
 7T1K58dFnEQPHPj4cVbXPg8SALn/nklIC2F9R6zVasuFp/TM8KNhGnBvFfZpeXPcAel0
 4YgqtQiCiJGf80j+0OapltDpy/oUkkJunv7bhyFyP8cAU3rTsQioXJzw7H0BmdGGd6K0
 rquHsPn+JoyMSB9ZYrBqOhVl5GG/GTLfEetS1a6E3ng9GQ3Oq8IyLuwOqhfHWMglbI0o
 kg3w==
X-Gm-Message-State: AC+VfDwjZKrcAKVophRFCvKLwBdni9fKcQlT0OLz4hpbKIpfZc2ZTAM/
 ZLSwTNXMynoba7KWiYxg6oQgzWKT/L8xRyuYC2XytqDK7NpIgQB59tkxOk93XaP1/8E+BRbLdQT
 nngfOe8dZ+wj3Coy4jfKD/EQMa/4YRls4tOavZvBmJRpb/SqIf5hZqsfemkFOwwz6cunL
X-Received: by 2002:a1c:f603:0:b0:3f8:f80e:7b45 with SMTP id
 w3-20020a1cf603000000b003f8f80e7b45mr22022474wmc.7.1687782621097; 
 Mon, 26 Jun 2023 05:30:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Ih30cCXNPPKlyYgSpGkv31POYM5uIHSsSNrKGP28p6SmlJkRLS+XRCypx/4oLiDIYhQl2CQ==
X-Received: by 2002:a1c:f603:0:b0:3f8:f80e:7b45 with SMTP id
 w3-20020a1cf603000000b003f8f80e7b45mr22022447wmc.7.1687782620756; 
 Mon, 26 Jun 2023 05:30:20 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 z24-20020a05600c221800b003fa96fe2bd9sm2651949wml.22.2023.06.26.05.30.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:30:20 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:30:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 50/53] intel_iommu: Fix flag check in replay
Message-ID: <dc0d0b851aa38b6bc69d4d647d389640e506d80b.1687782442.git.mst@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687782442.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Replay doesn't notify registered notifiers but the one passed
to it. So it's meaningless to check the registered notifier's
synthetic flag.

There is no issue currently as all replay use cases have MAP
flag set, but let's be robust.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <20230615032626.314476-3-zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 34af12f392..f046f85913 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3837,7 +3837,7 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
                                   PCI_FUNC(vtd_as->devfn),
                                   vtd_get_domain_id(s, &ce, vtd_as->pasid),
                                   ce.hi, ce.lo);
-        if (vtd_as_has_map_notifier(vtd_as)) {
+        if (n->notifier_flags & IOMMU_NOTIFIER_MAP) {
             /* This is required only for MAP typed notifiers */
             vtd_page_walk_info info = {
                 .hook_fn = vtd_replay_hook,
-- 
MST


