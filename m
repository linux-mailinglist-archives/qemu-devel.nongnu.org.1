Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CAC7CAAF1
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 16:04:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsOC4-0000Wa-Q3; Mon, 16 Oct 2023 10:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qsOBw-0000Nh-Qj
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 10:03:32 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qsOBt-0007ym-D6
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 10:03:32 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-57e3c2adbf0so2551091eaf.2
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 07:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697465008; x=1698069808; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gIaoSI3+iOcXplz5Z0b1C4fcILplDx3W7kOsX22ULiQ=;
 b=EijYRfWsB96m/kG2MS8Yjqw0bQiWWy/T282gyBzvtXikzw5omIFqM4CBwzoa8O92IN
 +y50Fo3dmvQNFYe/AP/SldKL7nBmX/Q/ly1GZ0ec7eC3JLXHbQjMoHyEPVNym4NpvTon
 YRh+4g+kPDHZVt7fbKXBZVqaX69e+qqOx1ZV93vKOp8+0XaZ3ZrikPBY60DzbZ7G6Czh
 4HWcya0j0DtgoUVpBw+shB8zVRlRaz5Vq/MBAAiq/gB2YDuk2FP8z4MLQ7SjIpH8QgNE
 iudSpBo7hvsNz9p2pWNpRtigOOjDFeRXvuAQUq2wz7RKm4hPMt7wJbhYU5Cvq5xH4qrf
 FujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697465008; x=1698069808;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gIaoSI3+iOcXplz5Z0b1C4fcILplDx3W7kOsX22ULiQ=;
 b=TtoqWjYjmufAD060dK2UDVDECMMEiC4tsxVB0F7RP1rwk7owhZYJysRtS+L0iYFS5l
 pGULZc3iFwRsQXRXO6L7NZ1Iq+FXkjWeBAdAu6smCNu96saAEqNTmF50sAbLnDmHvqpl
 tgx3vhDMgGzMX+0MOTi7BZ8eR97wn3fLYolcqAd+AegFqQSETF6R9xLc19W15+9KZ0KZ
 DB9NZAbIpjQce21xKdZj0KieqN3TLTQlT2khTmZuyy9vCP0NMj3ucaN9qkWHXwtoQajw
 JOQ05ziFepQjigMeuoYzftwYInXNlYE3TUEIwVJmh4zlgXK3hP6KlDRMfqnFY+mVYWFY
 pY1w==
X-Gm-Message-State: AOJu0YzYYqbsM6yo50k1c97t4g3EWDZ5bwanebBttlESBHbs+Cdaf1c6
 CCmkf2nEviBXC6ckjXqvxu/1M9XQUTvHFKLR+QY=
X-Google-Smtp-Source: AGHT+IFLpWGzLdv5ka1mPLdSgWxqCYEKHFW1oCUvs8rd5XfeDMDcfCNaOVcHZJTbV7R7Ka7uE8+WCBcoWGR/cR3WOxQ=
X-Received: by 2002:a4a:cb89:0:b0:57b:cbc2:79ff with SMTP id
 y9-20020a4acb89000000b0057bcbc279ffmr32649867ooq.4.1697465007951; Mon, 16 Oct
 2023 07:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231016083201.23736-1-hreitz@redhat.com>
In-Reply-To: <20231016083201.23736-1-hreitz@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 16 Oct 2023 10:03:16 -0400
Message-ID: <CAJSP0QWTAyQ5UTvnEJS0jbfqfrFuG89L7UgBBOEFVes-DHX+Zg@mail.gmail.com>
Subject: Re: [PATCH] vhost-user: Fix protocol feature bit conflict
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, 
 Albert Esteve <aesteve@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

On Mon, 16 Oct 2023 at 04:33, Hanna Czenczek <hreitz@redhat.com> wrote:
>
> The VHOST_USER_PROTOCOL_F_XEN_MMAP feature bit was defined in
> f21e95ee97d, which has been part of qemu's 8.1.0 release.  However, it
> seems it was never added to qemu's code, but it is well possible that it
> is already used by different front-ends outside of qemu (i.e., Xen).
>
> VHOST_USER_PROTOCOL_F_SHARED_OBJECT in contrast was added to qemu's code
> in 16094766627, but never defined in the vhost-user specification.  As a
> consequence, both bits were defined to be 17, which cannot work.
>
> Regardless of whether actual code or the specification should take
> precedence, F_XEN_MMAP is already part of a qemu release, while
> F_SHARED_OBJECT is not.  Therefore, bump the latter to take number 18
> instead of 17, and add this to the specification.
>
> Take the opportunity to add at least a little note on the
> VhostUserShared structure to the specification.  This structure is
> referenced by the new commands introduced in 16094766627, but was not
> defined.
>
> Fixes: 160947666276c5b7f6bca4d746bcac2966635d79
>        ("vhost-user: add shared_object msg")
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  docs/interop/vhost-user.rst               | 11 +++++++++++
>  include/hw/virtio/vhost-user.h            |  3 ++-
>  subprojects/libvhost-user/libvhost-user.h |  3 ++-
>  3 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index 415bb47a19..768fb5c28c 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -275,6 +275,16 @@ Inflight description
>
>  :queue size: a 16-bit size of virtqueues
>
> +VhostUserShared
> +^^^^^^^^^^^^^^^
> +
> ++------+
> +| UUID |
> ++------+
> +
> +:UUID: 16 bytes UUID, whose first three components (a 32-bit value, then
> +  two 16-bit values) are stored in big endian.
> +
>  C structure
>  -----------
>
> @@ -885,6 +895,7 @@ Protocol features
>    #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
>    #define VHOST_USER_PROTOCOL_F_STATUS               16
>    #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
> +  #define VHOST_USER_PROTOCOL_F_SHARED_OBJECT        18
>
>  Front-end message types
>  -----------------------
> diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
> index 9f9ddf878d..1d4121431b 100644
> --- a/include/hw/virtio/vhost-user.h
> +++ b/include/hw/virtio/vhost-user.h
> @@ -29,7 +29,8 @@ enum VhostUserProtocolFeature {
>      VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS = 14,
>      VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS = 15,
>      VHOST_USER_PROTOCOL_F_STATUS = 16,
> -    VHOST_USER_PROTOCOL_F_SHARED_OBJECT = 17,
> +    /* Feature 17 reserved for VHOST_USER_PROTOCOL_F_XEN_MMAP. */
> +    VHOST_USER_PROTOCOL_F_SHARED_OBJECT = 18,
>      VHOST_USER_PROTOCOL_F_MAX
>  };
>
> diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/libvhost-user/libvhost-user.h
> index b36a42a7ca..c2352904f0 100644
> --- a/subprojects/libvhost-user/libvhost-user.h
> +++ b/subprojects/libvhost-user/libvhost-user.h
> @@ -65,7 +65,8 @@ enum VhostUserProtocolFeature {
>      VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS = 14,
>      VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS = 15,
>      /* Feature 16 is reserved for VHOST_USER_PROTOCOL_F_STATUS. */
> -    VHOST_USER_PROTOCOL_F_SHARED_OBJECT = 17,
> +    /* Feature 17 reserved for VHOST_USER_PROTOCOL_F_XEN_MMAP. */
> +    VHOST_USER_PROTOCOL_F_SHARED_OBJECT = 18,
>      VHOST_USER_PROTOCOL_F_MAX
>  };
>
> --
> 2.41.0
>
>

