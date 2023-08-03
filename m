Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4345076F59C
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 00:22:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRghJ-0004Q8-7g; Thu, 03 Aug 2023 18:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRghG-0004Pg-Ts
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:21:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRghF-0000Va-CT
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:21:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691101288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HIYdHtiBYjd2FsFQPPoQ8yirjasX+58jJpzdJ4zKBQE=;
 b=MKxtd5E3TfxLrKvkSa2oYu3/v+2wX+1pFK0hRkOVeq20CH3HinFpEgNGhm00Bk/hyHU3c3
 OpsNs8njt0LNXxXcVrBfTMbpjFAHHdxkNuBoQFsExEmdkF3he3tVOMjyA0CQX7FE81ovM9
 HP71y7KW5Uf5QbkY6Vq8qJYJtuBsbSw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-SrI1rp7XMD-ZEJa5hzKvdA-1; Thu, 03 Aug 2023 18:21:27 -0400
X-MC-Unique: SrI1rp7XMD-ZEJa5hzKvdA-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b9fa64dba8so13893561fa.0
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 15:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691101286; x=1691706086;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HIYdHtiBYjd2FsFQPPoQ8yirjasX+58jJpzdJ4zKBQE=;
 b=h2SyebTqpHUHgSQdoCp+qrIV3RfMAjwHxZPlj4yNr0PALJd4brjgdIHGaS94nbCmMm
 2UUfNrYvIphYZKwFyENo2VeqAhXcf+kZExN0+GoU48ChJuggW4PSfC15pZTuCGjZhZLP
 p2dnYc4N0gdwNaJNjLHQDX2gRhWtBZgZ9iVOfNRrjgkbF9n+6mZIdWpJIsQO3VfTwI41
 zHJWezb2tOZJb8HFBDq8FRCzJneu0UoECDM4vlBT15QSRW1gFx/2TfxpNr4QSVrI6OPK
 PvjsFJAnBuwWClZ2WUFJc9jjtbJNj0nKSYnANx0wGqyrkNbVobgxIaSg1EwegNaVdrE3
 1J0g==
X-Gm-Message-State: AOJu0YzAxKh2cE2Q69JO5SwSvi5pPZ8mxNTnS2c8sOsdzNkVfMJSLomv
 H+HrmkFyr1Th3xVH6zRN3BdOY+zDXQRU/zhS3WTDJyH4/lIaei9qov3oSNEgPh1Oa7MPsbMyhhu
 WejkVlpO8ovplo70qVx0htOZiANpaLLGmW1C9jARQ6rHCm6aq7zXV/kMhL7gCXaiJaDjO
X-Received: by 2002:a2e:b617:0:b0:2b9:ea6b:64f with SMTP id
 r23-20020a2eb617000000b002b9ea6b064fmr76580ljn.37.1691101285795; 
 Thu, 03 Aug 2023 15:21:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbmUQ7fU5RzQxo3+v1YjTtMVJK6sQAUiDC/ZJeGk9zFe0eSWKZtC2QkHHygyaEr/LvfbsNjg==
X-Received: by 2002:a2e:b617:0:b0:2b9:ea6b:64f with SMTP id
 r23-20020a2eb617000000b002b9ea6b064fmr76569ljn.37.1691101285504; 
 Thu, 03 Aug 2023 15:21:25 -0700 (PDT)
Received: from redhat.com ([2.52.12.104]) by smtp.gmail.com with ESMTPSA id
 re8-20020a170906d8c800b00992076f4a01sm369306ejb.190.2023.08.03.15.21.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 15:21:25 -0700 (PDT)
Date: Thu, 3 Aug 2023 18:21:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hanna Czenczek <hreitz@redhat.com>, German Maglione <gmaglione@redhat.com>
Subject: [PULL 12/22] virtio: Fix packed virtqueue used_idx mask
Message-ID: <c92f4fcafa14890524945073b494937e97112677.1691101215.git.mst@redhat.com>
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

From: Hanna Czenczek <hreitz@redhat.com>

virtio_queue_packed_set_last_avail_idx() is used by vhost devices to set
the internal queue indices to what has been reported by the vhost
back-end through GET_VRING_BASE.  For packed virtqueues, this
32-bit value is expected to contain both the device's internal avail and
used indices, as well as their respective wrap counters.

To get the used index, we shift the 32-bit value right by 16, and then
apply a mask of 0x7ffff.  That seems to be a typo, because it should be
0x7fff; first of all, the virtio specification says that the maximum
queue size for packed virt queues is 2^15, so the indices cannot exceed
2^15 - 1 anyway, making 0x7fff the correct mask.  Second, the mask
clearly is wrong from context, too, given that (A) `idx & 0x70000` must
be 0 at this point (`idx` is 32 bit and was shifted to the right by 16
already), (B) `idx & 0x8000` is the used_wrap_counter, so should not be
part of the used index, and (C) `vq->used_idx` is a `uint16_t`, so
cannot fit the 0x70000 part of the mask anyway.

This most likely never produced any guest-visible bugs, though, because
for a vhost device, qemu will probably not evaluate the used index
outside of virtio_queue_packed_get_last_avail_idx(), where we
reconstruct the 32-bit value from avail and used indices and their wrap
counters again.  There, it does not matter whether the highest bit of
the used_idx is the used index wrap counter, because we put the wrap
counter exactly in that position anyway.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-Id: <20230721134945.26967-1-hreitz@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: German Maglione <gmaglione@redhat.com>
---
 hw/virtio/virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 295a603e58..309038fd46 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3321,7 +3321,7 @@ static void virtio_queue_packed_set_last_avail_idx(VirtIODevice *vdev,
     vq->last_avail_wrap_counter =
         vq->shadow_avail_wrap_counter = !!(idx & 0x8000);
     idx >>= 16;
-    vq->used_idx = idx & 0x7ffff;
+    vq->used_idx = idx & 0x7fff;
     vq->used_wrap_counter = !!(idx & 0x8000);
 }
 
-- 
MST


