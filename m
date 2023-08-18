Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7D2780EA0
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 17:10:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX168-0005P0-De; Fri, 18 Aug 2023 11:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qX166-0005Or-OD
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:09:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qX162-000729-BL
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:09:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692371343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oCV+tHb5LszMayQQb6kFs9nte1NI2JXx4ahg9ajsYUs=;
 b=Nc8UfJ7qmrc/d4cdvG+j4yZlhsB4pnOOWJ1qEbl8s39f/5719EV3DzHRym3rfabZa6Zrfh
 o/TwHSg/kMMU3cnvz2tOy0JMlGZaLjszUcXZe3+k3/1FXHTnwimt2VImEGG8xBK9xXqZWm
 6ZKUa/Z2ARF7RSjoyqyGGmi3ctFpHUA=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-22qOkMklOMO3snHypZFMqA-1; Fri, 18 Aug 2023 11:09:01 -0400
X-MC-Unique: 22qOkMklOMO3snHypZFMqA-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-6b9d3ce1a56so1151467a34.1
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 08:09:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692371341; x=1692976141;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oCV+tHb5LszMayQQb6kFs9nte1NI2JXx4ahg9ajsYUs=;
 b=ADADQz708iO+4umRxHfb4JAWPNtc3tITbgJsRII7ZrelVAgzMtDxQBSHiCqWCSBDPb
 2xKWODA/Xf7rsL4UfiET8fvuzl3G3dWx9SWPvwxDrNOPA7tNc8Fa1dt496BwWTf+pKyl
 NntBjAhDPu178SfrrCMjOoZkr+h8DQbJxhKzY7vjhvMlY3Gz9EgNAMzdHCY8SUOkXO8Y
 6imZT9FNLuLb77VKvr5wOeTWt1LuRnltBSpTwNoMu82bqy81OYe3mn5+/xciWe+rIzJr
 hP6PuRfK3P9IyYm/GRyxxYFfU2ay8GGaExT1J1Cl+PwLKLE9GIRpBSzwhCWREb2aW/yU
 +nNA==
X-Gm-Message-State: AOJu0YxFdQImHtn0JDwl8VtRwZbRMa3uNqhF7oL68IK+DftQHn7+BRTw
 hR8T2uuQZnGDhndfxQmiYMPfTOb2s93/OJyiukVgLeWBYpHTycL+Qf8wzCCUixGUSk4QgA9XDCF
 2S+Cmes8RV8NqU2RyTY6/OASbQ8u5fTM=
X-Received: by 2002:a9d:7658:0:b0:6b9:9de6:2cc with SMTP id
 o24-20020a9d7658000000b006b99de602ccmr2735224otl.25.1692371340851; 
 Fri, 18 Aug 2023 08:09:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvVzqb4N673W1oSNaF2odAEeiu7mcrPvP+MvICB2HU4jk/9Tlos/24a+PLt8sfemIRWeDrlrhpQT/AEsMgacw=
X-Received: by 2002:a9d:7658:0:b0:6b9:9de6:2cc with SMTP id
 o24-20020a9d7658000000b006b99de602ccmr2735208otl.25.1692371340592; Fri, 18
 Aug 2023 08:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689748694.git.yin31149@gmail.com>
 <77c1d8b358644b49992e6dbca55a5c9e62c941a8.1689748694.git.yin31149@gmail.com>
In-Reply-To: <77c1d8b358644b49992e6dbca55a5c9e62c941a8.1689748694.git.yin31149@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 18 Aug 2023 17:08:24 +0200
Message-ID: <CAJaqyWeq=-WCfJX9=6SyQwGtRsrtyUzytjMeReJScfMLKFHc0A@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] vhost: Add argument to vhost_svq_poll()
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
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

On Wed, Jul 19, 2023 at 9:54=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.com>=
 wrote:
>

The subject could be more explicit. What about "add count argument to
vhost_svq_poll"?

Apart from that:
Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Next patches in this series will no longer perform an
> immediate poll and check of the device's used buffers
> for each CVQ state load command. Instead, they will
> send CVQ state load commands in parallel by polling
> multiple pending buffers at once.
>
> To achieve this, this patch refactoring vhost_svq_poll()
> to accept a new argument `num`, which allows vhost_svq_poll()
> to wait for the device to use multiple elements,
> rather than polling for a single element.
>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> ---
>  hw/virtio/vhost-shadow-virtqueue.c | 36 ++++++++++++++++++------------
>  hw/virtio/vhost-shadow-virtqueue.h |  2 +-
>  net/vhost-vdpa.c                   |  2 +-
>  3 files changed, 24 insertions(+), 16 deletions(-)
>
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-=
virtqueue.c
> index 49e5aed931..e731b1d2ea 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -514,29 +514,37 @@ static void vhost_svq_flush(VhostShadowVirtqueue *s=
vq,
>  }
>
>  /**
> - * Poll the SVQ for one device used buffer.
> + * Poll the SVQ to wait for the device to use the specified number
> + * of elements and return the total length written by the device.
>   *
>   * This function race with main event loop SVQ polling, so extra
>   * synchronization is needed.
>   *
> - * Return the length written by the device.
> + * @svq: The svq
> + * @num: The number of elements that need to be used
>   */
> -size_t vhost_svq_poll(VhostShadowVirtqueue *svq)
> +size_t vhost_svq_poll(VhostShadowVirtqueue *svq, size_t num)
>  {
> -    int64_t start_us =3D g_get_monotonic_time();
> -    uint32_t len =3D 0;
> +    size_t len =3D 0;
> +    uint32_t r;
>
> -    do {
> -        if (vhost_svq_more_used(svq)) {
> -            break;
> -        }
> +    while (num--) {
> +        int64_t start_us =3D g_get_monotonic_time();
>
> -        if (unlikely(g_get_monotonic_time() - start_us > 10e6)) {
> -            return 0;
> -        }
> -    } while (true);
> +        do {
> +            if (vhost_svq_more_used(svq)) {
> +                break;
> +            }
> +
> +            if (unlikely(g_get_monotonic_time() - start_us > 10e6)) {
> +                return len;
> +            }
> +        } while (true);
> +
> +        vhost_svq_get_buf(svq, &r);
> +        len +=3D r;
> +    }
>
> -    vhost_svq_get_buf(svq, &len);
>      return len;
>  }
>
> diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-=
virtqueue.h
> index 6efe051a70..5bce67837b 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.h
> +++ b/hw/virtio/vhost-shadow-virtqueue.h
> @@ -119,7 +119,7 @@ void vhost_svq_push_elem(VhostShadowVirtqueue *svq,
>  int vhost_svq_add(VhostShadowVirtqueue *svq, const struct iovec *out_sg,
>                    size_t out_num, const struct iovec *in_sg, size_t in_n=
um,
>                    VirtQueueElement *elem);
> -size_t vhost_svq_poll(VhostShadowVirtqueue *svq);
> +size_t vhost_svq_poll(VhostShadowVirtqueue *svq, size_t num);
>
>  void vhost_svq_set_svq_kick_fd(VhostShadowVirtqueue *svq, int svq_kick_f=
d);
>  void vhost_svq_set_svq_call_fd(VhostShadowVirtqueue *svq, int call_fd);
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index dfd271c456..d1dd140bf6 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -625,7 +625,7 @@ static ssize_t vhost_vdpa_net_cvq_add(VhostVDPAState =
*s, size_t out_len,
>       * descriptor. Also, we need to take the answer before SVQ pulls by =
itself,
>       * when BQL is released
>       */
> -    return vhost_svq_poll(svq);
> +    return vhost_svq_poll(svq, 1);
>  }
>
>  static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t class,
> --
> 2.25.1
>


