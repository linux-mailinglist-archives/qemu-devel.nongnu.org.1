Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C837B9A66
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:48:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFJQ-0000fT-Bd; Wed, 04 Oct 2023 23:46:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFJL-0000Xo-JG
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:46:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFJG-0000pS-2q
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FYiqXRxzTWfTn4i/+SBced8bQTg6zrqu/s2l3fD1Gks=;
 b=U807K68wy35vvmChWOFaV85rxASauTY/WwOQMKEv3oSN2NGEfyHLVMcXsy3RRI5H49WcIM
 tSHGpjPbPzizAvcbAxKm/Fqm3peGD6zqRN7/UPSmkvFM+RtfoXAfJcr80eezVCpF/BYfer
 z2+3+yii3/bwdy27Ong/7EcmEbxcX4o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-ZLW1vzwmOhGlw1RK5w49Dw-1; Wed, 04 Oct 2023 23:45:45 -0400
X-MC-Unique: ZLW1vzwmOhGlw1RK5w49Dw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40647c6f71dso4316005e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:45:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477543; x=1697082343;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FYiqXRxzTWfTn4i/+SBced8bQTg6zrqu/s2l3fD1Gks=;
 b=PQn5jMtA6rkis1x058qQf1U/BCqTiR32VFg6B1LXhI9uVYKukm14B5SUOnHlI5hUWs
 ers+/qFMRdGNK6Vu8pg5SclwTbopYtm/WOZDIi6pEMwPterPe+UQTffGcUOG7TnqmASx
 JYaLAuGh3U5W7shfOImp6EAPqy+t6MeFeZ0GsyKH1WIIezi20tyJym2yWYP/13tYv8sX
 Y3WVtDZ7t+r+pmcm8lWSm8mK2W++rbM4u2bthBuhwj31N1e0+N4hpyE5L2z/Um/GkTae
 LUwgT93m4nW57EuhvbZEt36NUdZnQQYSWcCS/dU5E+7KOXpk9xS/CmE9qPuNA+BTaiGn
 86fw==
X-Gm-Message-State: AOJu0YxxYpwbe5AgEbFe0JJ0mgrLf5kIzzvWhtZmb120anBcJJAbySYn
 M1Pb4dxr2i0w5tdP5Zhmv7MTAKfNKPULEHzI8efdNIgoeR4TUIxMfMYGsE8tRm1rHQAQCioqs3i
 +w8TsIP64rGeouA6KL9O4k/CfYPiZWiof4pscQezde42XwSV55medUU4PtEOBtOrpvvlG
X-Received: by 2002:a05:600c:ac4:b0:406:599f:f934 with SMTP id
 c4-20020a05600c0ac400b00406599ff934mr3961237wmr.12.1696477543557; 
 Wed, 04 Oct 2023 20:45:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFftP7lgNUwMrf0xOVBmqnG01o6rUvgWM+GONrO1aNv77SqA2JyXQeq+uAOpGopYCk6m+9g0A==
X-Received: by 2002:a05:600c:ac4:b0:406:599f:f934 with SMTP id
 c4-20020a05600c0ac400b00406599ff934mr3961222wmr.12.1696477543254; 
 Wed, 04 Oct 2023 20:45:43 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 bd5-20020a05600c1f0500b004030e8ff964sm2815082wmb.34.2023.10.04.20.45.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:45:42 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:45:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ilya Maximets <i.maximets@ovn.org>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL v2 48/53] virtio: remove unnecessary thread fence while
 reading next descriptor
Message-ID: <d501f97d9607eff1750549e0270c034102786d33.1696477105.git.mst@redhat.com>
References: <cover.1696477105.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696477105.git.mst@redhat.com>
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

From: Ilya Maximets <i.maximets@ovn.org>

It was supposed to be a compiler barrier and it was a compiler barrier
initially called 'wmb' when virtio core support was introduced.
Later all the instances of 'wmb' were switched to smp_wmb to fix memory
ordering issues on non-x86 platforms.  However, this one doesn't need
to be an actual barrier, as its only purpose was to ensure that the
value is not read twice.

And since commit aa570d6fb6bd ("virtio: combine the read of a descriptor")
there is no need for a barrier at all, since we're no longer reading
guest memory here, but accessing a local structure.

Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
Message-Id: <20230927140016.2317404-2-i.maximets@ovn.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 2058b838e9..87e8f990c5 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1060,8 +1060,6 @@ static int virtqueue_split_read_next_desc(VirtIODevice *vdev, VRingDesc *desc,
 
     /* Check they're not leading us off end of descriptors. */
     *next = desc->next;
-    /* Make sure compiler knows to grab that: we don't want it changing! */
-    smp_wmb();
 
     if (*next >= max) {
         virtio_error(vdev, "Desc next is %u", *next);
-- 
MST


