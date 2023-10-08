Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A61BA7BCC3D
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 07:18:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpMAT-0001oz-8v; Sun, 08 Oct 2023 01:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qpMAO-0001oh-0F
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 01:17:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qpMAM-0003Ih-BU
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 01:17:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696742240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pric9/2gMhA80NcDr0VhEaFdOkxcjRAYD/BBjnrHcE4=;
 b=ZGbfmETSX0001u2K73+YgGcJUaKenGGsij4hecwU9hbWR8LzaT0co9qGFJvlTwSGDQ+nYx
 t2Cb/kjblCP0DJBtM6qe9BQEu+CLOxkmm+DGfE5ot5CcBHL4NrdyNXr1D2pucShvYA658X
 0QBx3im12/vOiygjbmt0m7bR0yN37kE=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-JERkHy6pPyukYXjCkxeTOA-1; Sun, 08 Oct 2023 01:17:18 -0400
X-MC-Unique: JERkHy6pPyukYXjCkxeTOA-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-50420b22ff4so2983566e87.1
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 22:17:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696742237; x=1697347037;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pric9/2gMhA80NcDr0VhEaFdOkxcjRAYD/BBjnrHcE4=;
 b=w5m3VHZ74vgHPlAPcJpZ42erEBIV2aOnB1QeB+6k6GwtAoINlfxZmZFAG7waVrKfgd
 T1Ef4lj1TaIOrCwt9cvaHkdiBffsZ9hpptwopifK7iGKvd4jw0UuwVzaHQpet2AiVWhW
 P1/jvSYPhUAqyflOnFgpg1vmv+W0OVIO+PMFH/zjprMGrVev/WNJlJTpznwuM9ZiAMRT
 xOTGaU0jutoymp6OXajIT7rSgkcJAMHar45iwpB5ChuFfZHeeGwZAcoh1oi/NtxR6VC5
 qcQ6lp1ta5++e0y5oYhsmZKahS8jgvqT/MWFOeDUvh3DbIri4w18fz9Sf3U2A4Rs9EAR
 XBsQ==
X-Gm-Message-State: AOJu0Yyp1A3f4sC5G+c0UpwKAvtElKjEF+OEdda+mlpzuhZP+h5OlXDR
 XZTyA5JazTzq3LXLm1dYk0Vr/qmydldSrDgtt4lCsK/VzAMZYTXubMAk3UfZ5gR8uqMjPIePsXe
 NpUF2KVr+clYojTUFdzE1vZ8SR6X7LSI=
X-Received: by 2002:a05:6512:2095:b0:503:5d8:da33 with SMTP id
 t21-20020a056512209500b0050305d8da33mr10184423lfr.20.1696742236949; 
 Sat, 07 Oct 2023 22:17:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6wwwqgY5mp1+kcjCznRJtsUUJKcfBzLpqe6eX1SChHXYtKdlKkQ5GVvkj7PueM5rl4TGBws/F2YEp/Cw1vC8=
X-Received: by 2002:a05:6512:2095:b0:503:5d8:da33 with SMTP id
 t21-20020a056512209500b0050305d8da33mr10184416lfr.20.1696742236622; Sat, 07
 Oct 2023 22:17:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230927135157.2316982-1-i.maximets@ovn.org>
In-Reply-To: <20230927135157.2316982-1-i.maximets@ovn.org>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 8 Oct 2023 13:17:04 +0800
Message-ID: <CACGkMEuODnNT3yowzzJ-zYyKD74_U0vGGtQcm7ohoUMW1AaDQQ@mail.gmail.com>
Subject: Re: [PATCH v2] virtio: use shadow_avail_idx while checking number of
 heads
To: Ilya Maximets <i.maximets@ovn.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
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

On Wed, Sep 27, 2023 at 9:51=E2=80=AFPM Ilya Maximets <i.maximets@ovn.org> =
wrote:
>
> We do not need the most up to date number of heads, we only want to
> know if there is at least one.
>
> Use shadow variable as long as it is not equal to the last available
> index checked.  This avoids expensive qatomic dereference of the
> RCU-protected memory region cache as well as the memory access itself.
>
> The change improves performance of the af-xdp network backend by 2-3%.
>
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>
> Version 2:
>   - Changed to not skip error checks and a barrier.
>   - Added comments about the need for a barrier.
>
>  hw/virtio/virtio.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 4577f3f5b3..8a4c3e95d2 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -999,7 +999,12 @@ void virtqueue_push(VirtQueue *vq, const VirtQueueEl=
ement *elem,
>  /* Called within rcu_read_lock().  */
>  static int virtqueue_num_heads(VirtQueue *vq, unsigned int idx)
>  {
> -    uint16_t num_heads =3D vring_avail_idx(vq) - idx;
> +    uint16_t avail_idx, num_heads;
> +
> +    /* Use shadow index whenever possible. */
> +    avail_idx =3D (vq->shadow_avail_idx !=3D idx) ? vq->shadow_avail_idx
> +                                              : vring_avail_idx(vq);
> +    num_heads =3D avail_idx - idx;
>
>      /* Check it isn't doing very strange things with descriptor numbers.=
 */
>      if (num_heads > vq->vring.num) {
> @@ -1007,8 +1012,15 @@ static int virtqueue_num_heads(VirtQueue *vq, unsi=
gned int idx)
>                       idx, vq->shadow_avail_idx);
>          return -EINVAL;
>      }
> -    /* On success, callers read a descriptor at vq->last_avail_idx.
> -     * Make sure descriptor read does not bypass avail index read. */
> +    /*
> +     * On success, callers read a descriptor at vq->last_avail_idx.
> +     * Make sure descriptor read does not bypass avail index read.
> +     *
> +     * This is necessary even if we are using a shadow index, since
> +     * the shadow index could have been initialized by calling
> +     * vring_avail_idx() outside of this function, i.e., by a guest
> +     * memory read not accompanied by a barrier.
> +     */
>      if (num_heads) {
>          smp_rmb();
>      }
> --
> 2.41.0
>


