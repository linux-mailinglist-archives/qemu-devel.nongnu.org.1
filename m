Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EB9709AAF
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:58:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01T6-0004pO-SJ; Fri, 19 May 2023 10:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01SY-00042F-PX
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:52:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01SS-0003hA-9S
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:51:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684507911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TieozOKcq7wNxJeAelFrvx+KwG5hCz5Or4GbbfSJris=;
 b=XceUkZAsGIxPQVK2hrY9buknPqoSjcQrAJSQPHx39LnA0Q1HlmS3JqQefsnOLTIxnyWJXN
 AtcNEw17QQ3Br/MTQTqL7YDCPvu5e1mrfA1ndQi4iclcBbFz8ipeOkzIOhi4PoVDV6tqem
 tKReYslw4LvOBMwLfUw3xyNXKRoHF5o=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-oz5GEdu2OHStbLX_mSLNcQ-1; Fri, 19 May 2023 10:51:49 -0400
X-MC-Unique: oz5GEdu2OHStbLX_mSLNcQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4edc7406cbaso2113003e87.2
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:51:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507908; x=1687099908;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TieozOKcq7wNxJeAelFrvx+KwG5hCz5Or4GbbfSJris=;
 b=aYVlS/vRMBSobI1qruPvEzUe3IZNL/iAFS8UgMx7r0SFGDaZaSQOtCAqGVcHHw6q76
 of/9zV95oXzIR2v1fQ+hqyJYjCbRvTuIcjJJjZHZiHJ/77+t7f4HrNwjybFV7x61Fwaa
 lEdIBSKWKI+qjHpnjVklr/ddsfIqEptM2t8ejmLCuEF9qov1Wxv3oMVrCis1wgTyPwHu
 +bwVPja4R/RSUSV77+X7IjmaUpyuw28USnWqYqnjW1l1cAUlJNqvFhutji071xvdgX9R
 z50PnrNnWPcBJW92V8ZNaF6GiuCJZHZL4rCnliTL71A34JKVyQmCw1gVzLzsEDRLDwtz
 b3MA==
X-Gm-Message-State: AC+VfDyYWE2FrPZX3T3J6x9UkOwZn1FrssTtHb0/pvKa1yMkn7GpoU2q
 pLUbDUnN2DeZsduCCX1MtXhmcYLhojd1UAN9Ot7HOSw9Ucea1pN/sy6D0+rBsIgtM7m3iJ0Ex+r
 WPbwyLz1eIfru+5knZt8QSZLL2lNHS3pGfMIWcE6LvsESUIQ/zkAlswoE3KiUZwXoycG6
X-Received: by 2002:ac2:4c90:0:b0:4f1:95cf:11eb with SMTP id
 d16-20020ac24c90000000b004f195cf11ebmr863338lfl.6.1684507908137; 
 Fri, 19 May 2023 07:51:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ70d5Hk6XdNaYu5md0QYr42yWC+kmwqzuiO2+yu30oSfJzkZXlDUMeK/ZXCe6pNboEk7FGY6A==
X-Received: by 2002:ac2:4c90:0:b0:4f1:95cf:11eb with SMTP id
 d16-20020ac24c90000000b004f195cf11ebmr863333lfl.6.1684507907880; 
 Fri, 19 May 2023 07:51:47 -0700 (PDT)
Received: from redhat.com ([176.12.184.180]) by smtp.gmail.com with ESMTPSA id
 z1-20020ac24181000000b004f11e965308sm634868lfh.20.2023.05.19.07.51.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 07:51:47 -0700 (PDT)
Date: Fri, 19 May 2023 10:51:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Cindy Lu <lulu@redhat.com>
Subject: [PULL 24/40] vhost: expose function vhost_dev_has_iommu()
Message-ID: <74b5d2b56c85515f1559ee0dfa8289bbb9832d51.1684507742.git.mst@redhat.com>
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

From: Cindy Lu <lulu@redhat.com>

To support vIOMMU in vdpa, need to exposed the function
vhost_dev_has_iommu, vdpa will use this function to check
if vIOMMU enable.

Signed-off-by: Cindy Lu <lulu@redhat.com>
Message-Id: <20230510054631.2951812-2-lulu@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost.h | 1 +
 hw/virtio/vhost.c         | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index a52f273347..f7f10c8fb7 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -336,4 +336,5 @@ int vhost_dev_set_inflight(struct vhost_dev *dev,
                            struct vhost_inflight *inflight);
 int vhost_dev_get_inflight(struct vhost_dev *dev, uint16_t queue_size,
                            struct vhost_inflight *inflight);
+bool vhost_dev_has_iommu(struct vhost_dev *dev);
 #endif
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 746d130c74..23da579ce2 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -107,7 +107,7 @@ static void vhost_dev_sync_region(struct vhost_dev *dev,
     }
 }
 
-static bool vhost_dev_has_iommu(struct vhost_dev *dev)
+bool vhost_dev_has_iommu(struct vhost_dev *dev)
 {
     VirtIODevice *vdev = dev->vdev;
 
-- 
MST


