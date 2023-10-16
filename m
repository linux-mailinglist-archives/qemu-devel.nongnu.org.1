Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8127CA50C
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 12:15:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsKcJ-0006f5-9W; Mon, 16 Oct 2023 06:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qsKcG-0006an-LW
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 06:14:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qsKcF-0000W4-1V
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 06:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697451264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=459nOo0jiH4booaQ99hsclUb8JZKEyC5o0yJJwlwyXs=;
 b=espFs3wxHzQOBAVYsZ7plT3eooggfS06ZqYuofvyKF6k72LFB0x8sfLCgdkRCTziCNPJVI
 q04GmD7Fb59RLy0PaSjDqny/aUPmZTfRcZE+GOT8Hk8CLj5akl/R37LW5DmI1Pr7fhwYjN
 UgvRLs7H3Z6I4r6TLWx9hsvbJVi5BBA=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-pIp4gIVEN6SOcebXwnIuYg-1; Mon, 16 Oct 2023 06:14:23 -0400
X-MC-Unique: pIp4gIVEN6SOcebXwnIuYg-1
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-4a1336527f0so1553134e0c.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 03:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697451261; x=1698056061;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=459nOo0jiH4booaQ99hsclUb8JZKEyC5o0yJJwlwyXs=;
 b=Z1zZlIFCFhembtOwEilJ9veBDc+DbXAqoLyV97nigFYoUlkeWfw/TLIl5c8fPThiRZ
 q15XBMhU6a5FtKmPswLzLP+Fhpiy7thGWqeo+QrBBaabHIMVgwTr8NBRKWAnETdNaqqn
 mLaAo0DvVRxLEzWd3UoTpF+uqbYO8vOiHXQudUsHOgRhYxWFnJXutZaPFmngkrnUlJjJ
 q+9GTImSoyJFZMtATFu/yFIqCzc2KOLhOBM7KZ7rOpK/a4x2MYnG3jhpPGaF+Kj+eV65
 ZsTWu/ZNICuDb5xJzlLPatdRwDz1y3aq2RNQb9shskN+AFYN9HfMHJK06rxA3KkDxZpy
 wfLQ==
X-Gm-Message-State: AOJu0Ywi0RUNBXFz+dFXYQKEjGagAXugYLQOKPA2enM6TGk0iedgRCvj
 Ef9kp7cJcd0WZvygwp2RDwLZjWVpfYDJwc/mbT41JaBK6WjEYou3qJXOs0yKo12aJvNJFI6xwM6
 Wf4IyvHPiZRBH4g0=
X-Received: by 2002:a05:6122:17a6:b0:4a0:6fd4:4332 with SMTP id
 o38-20020a05612217a600b004a06fd44332mr22182354vkf.14.1697451261190; 
 Mon, 16 Oct 2023 03:14:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDYm7VCqw0YeFz5GWKF6XynW+Z7VTaU8gO5Xodh0/nhCnjmyD7YlBPNaqXzu/V/eNc/TtZoA==
X-Received: by 2002:a05:6122:17a6:b0:4a0:6fd4:4332 with SMTP id
 o38-20020a05612217a600b004a06fd44332mr22182340vkf.14.1697451260892; 
 Mon, 16 Oct 2023 03:14:20 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-251.retail.telecomitalia.it.
 [79.46.200.251]) by smtp.gmail.com with ESMTPSA id
 e3-20020ac84903000000b00419732075b4sm2868443qtq.84.2023.10.16.03.14.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 03:14:20 -0700 (PDT)
Date: Mon, 16 Oct 2023 12:13:54 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, 
 Albert Esteve <aesteve@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] vhost-user: Fix protocol feature bit conflict
Message-ID: <ydke4r35n7vkhtkmdrpifdtonru24natzw2hdk2yc5xjtoekiw@oheouca5mv2u>
References: <20231016083201.23736-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231016083201.23736-1-hreitz@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Oct 16, 2023 at 10:32:01AM +0200, Hanna Czenczek wrote:
>The VHOST_USER_PROTOCOL_F_XEN_MMAP feature bit was defined in
>f21e95ee97d, which has been part of qemu's 8.1.0 release.  However, it
>seems it was never added to qemu's code, but it is well possible that it
>is already used by different front-ends outside of qemu (i.e., Xen).

Yep, and also some backends (e.g. we released rust-vmm/vhost v0.8.0 with 
F_XEN_MMAP = 17 defined).

>
>VHOST_USER_PROTOCOL_F_SHARED_OBJECT in contrast was added to qemu's 
>code
>in 16094766627, but never defined in the vhost-user specification.  As a
>consequence, both bits were defined to be 17, which cannot work.
>
>Regardless of whether actual code or the specification should take
>precedence, F_XEN_MMAP is already part of a qemu release, while
>F_SHARED_OBJECT is not.  Therefore, bump the latter to take number 18
>instead of 17, and add this to the specification.
>
>Take the opportunity to add at least a little note on the
>VhostUserShared structure to the specification.  This structure is
>referenced by the new commands introduced in 16094766627, but was not
>defined.
>
>Fixes: 160947666276c5b7f6bca4d746bcac2966635d79
>       ("vhost-user: add shared_object msg")
>Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>---
> docs/interop/vhost-user.rst               | 11 +++++++++++
> include/hw/virtio/vhost-user.h            |  3 ++-
> subprojects/libvhost-user/libvhost-user.h |  3 ++-
> 3 files changed, 15 insertions(+), 2 deletions(-)

Thanks for fixinig this!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
>index 415bb47a19..768fb5c28c 100644
>--- a/docs/interop/vhost-user.rst
>+++ b/docs/interop/vhost-user.rst
>@@ -275,6 +275,16 @@ Inflight description
>
> :queue size: a 16-bit size of virtqueues
>
>+VhostUserShared
>+^^^^^^^^^^^^^^^
>+
>++------+
>+| UUID |
>++------+
>+
>+:UUID: 16 bytes UUID, whose first three components (a 32-bit value, then
>+  two 16-bit values) are stored in big endian.
>+
> C structure
> -----------
>
>@@ -885,6 +895,7 @@ Protocol features
>   #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
>   #define VHOST_USER_PROTOCOL_F_STATUS               16
>   #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
>+  #define VHOST_USER_PROTOCOL_F_SHARED_OBJECT        18
>
> Front-end message types
> -----------------------
>diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
>index 9f9ddf878d..1d4121431b 100644
>--- a/include/hw/virtio/vhost-user.h
>+++ b/include/hw/virtio/vhost-user.h
>@@ -29,7 +29,8 @@ enum VhostUserProtocolFeature {
>     VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS = 14,
>     VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS = 15,
>     VHOST_USER_PROTOCOL_F_STATUS = 16,
>-    VHOST_USER_PROTOCOL_F_SHARED_OBJECT = 17,
>+    /* Feature 17 reserved for VHOST_USER_PROTOCOL_F_XEN_MMAP. */
>+    VHOST_USER_PROTOCOL_F_SHARED_OBJECT = 18,
>     VHOST_USER_PROTOCOL_F_MAX
> };
>
>diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/libvhost-user/libvhost-user.h
>index b36a42a7ca..c2352904f0 100644
>--- a/subprojects/libvhost-user/libvhost-user.h
>+++ b/subprojects/libvhost-user/libvhost-user.h
>@@ -65,7 +65,8 @@ enum VhostUserProtocolFeature {
>     VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS = 14,
>     VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS = 15,
>     /* Feature 16 is reserved for VHOST_USER_PROTOCOL_F_STATUS. */
>-    VHOST_USER_PROTOCOL_F_SHARED_OBJECT = 17,
>+    /* Feature 17 reserved for VHOST_USER_PROTOCOL_F_XEN_MMAP. */
>+    VHOST_USER_PROTOCOL_F_SHARED_OBJECT = 18,
>     VHOST_USER_PROTOCOL_F_MAX
> };
>
>-- 
>2.41.0
>
>


