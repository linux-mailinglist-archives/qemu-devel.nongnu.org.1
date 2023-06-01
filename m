Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAB871967E
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 11:11:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4eFV-0004R2-Sx; Thu, 01 Jun 2023 05:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q4eFN-0004Li-9u
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:05:29 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q4eFL-0001u5-G6
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:05:29 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2af2c7f2883so8078161fa.3
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 02:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685610325; x=1688202325;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Rlh/W45Vljqm7i1FF8k1di11zxjfzH92w/tMkvnt15M=;
 b=DtH3CsTdjscMFMfOjJHV+XdZVlTgKVl1wbTb6tm9NiqiIGpu6xvy/j3aVIwstjPSvN
 ma3dDkgSoInqILBAz/hOuEhLzhUOLb008HY7TtGK6JhPNO4c8NbWfiXiZSzRy42FkbQi
 zCwCQu7aYH7Sv17fP/IgaVAl3pZVnAWnLu3PYCZ2lhnd9OTM4T1ZDy7oRyLi6gPmsQa3
 Nq6Ozc04Ki1EWQrEvpF6CNxXglcJqvVQxE20Vm2bnJoeFR2jjiBIjmcTd+2qLWp97PUB
 wYeLbCjMcfKLhxgCoFKRHx7XI6VcFjYvDPnTEc+KcyV4OtWh2BQuUKgui/KyMvL7Xc9/
 5mmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685610325; x=1688202325;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rlh/W45Vljqm7i1FF8k1di11zxjfzH92w/tMkvnt15M=;
 b=lFu7Ljx6N1JHUFKT0IQNSzrvqZ49xUiApWBrnCZ7uuPkt5wZHTqcdymnXAyfXJ85W6
 B65QdP557At4gcRWuXhqkjl1cJyVhu9WTDzYqOtOkqagnschAR2+NOfkGkK3vYCDHcma
 Kkw34Y5cTq9ZzHqU7lmohaTB19Z0T+YH+Ok1EspySa0yZj+rsq2V9CGSu/i4a2hDs4nv
 WeteVGr8K6Rmi8DgjGD2LqiaDcEhG4GUO/kru8jAyNUh+OMI/lXjilqfMKNVJCFuPOk4
 mLtb2vgxuJrXO+boKTpjlO249DOtqn47j99P6WkZH9D5yLr12kJAhUfeNr0eE692Nphs
 BrOQ==
X-Gm-Message-State: AC+VfDyEGivKcUkjp5+l8JTjstht4r4xvynm2DkoHqmtVT/vuhErhDoc
 B6zUP0m1xdvvH/9Jbq+QXp+vozy2UEWVOlxCmTc=
X-Google-Smtp-Source: ACHHUZ60T8SKYQRIUo+xx1M7GOaW2h1TpqLeF6kF0tW3H+P2MFffsQe9ybkYuO/C52qBkLvXx0eXj+V6aGcjUXNYZ3I=
X-Received: by 2002:a2e:9cd8:0:b0:2a8:ac69:bfe with SMTP id
 g24-20020a2e9cd8000000b002a8ac690bfemr4395750ljj.42.1685610324202; Thu, 01
 Jun 2023 02:05:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685584543.git.yin31149@gmail.com>
 <39fddc462ad4c7619843a4cd7cba92e0bbc48c45.1685584543.git.yin31149@gmail.com>
In-Reply-To: <39fddc462ad4c7619843a4cd7cba92e0bbc48c45.1685584543.git.yin31149@gmail.com>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Thu, 1 Jun 2023 17:05:12 +0800
Message-ID: <CAKrof1OyEL5RGTWgHjgfMSkMC-afiWW8VAF5qirCy3juErWSqA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] virtio-net: expose
 virtio_net_supported_guest_offloads()
To: jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=yin31149@gmail.com; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, 1 Jun 2023 at 16:48, Hawkins Jiawei <yin31149@gmail.com> wrote:
>
> To support restoring offloads state in vdpa, need to expose
> the function virtio_net_supported_guest_offloads(), then vdpa
> uses this function to get the guest supported offloads.

Here it should be changed to "then QEMU uses this function
to get the guest supported offloads.". I will correct the commit
message in the v3 patch.

Thanks!

>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> ---
>  hw/net/virtio-net.c            | 2 +-
>  include/hw/virtio/virtio-net.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 7b27dad6c4..7e8897a8bc 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -874,7 +874,7 @@ static uint64_t virtio_net_guest_offloads_by_features(uint32_t features)
>      return guest_offloads_mask & features;
>  }
>
> -static inline uint64_t virtio_net_supported_guest_offloads(const VirtIONet *n)
> +uint64_t virtio_net_supported_guest_offloads(const VirtIONet *n)
>  {
>      VirtIODevice *vdev = VIRTIO_DEVICE(n);
>      return virtio_net_guest_offloads_by_features(vdev->guest_features);
> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
> index ef234ffe7e..5f5dcb4572 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -227,5 +227,6 @@ size_t virtio_net_handle_ctrl_iov(VirtIODevice *vdev,
>                                    unsigned out_num);
>  void virtio_net_set_netclient_name(VirtIONet *n, const char *name,
>                                     const char *type);
> +uint64_t virtio_net_supported_guest_offloads(const VirtIONet *n);
>
>  #endif
> --
> 2.25.1
>

