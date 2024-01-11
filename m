Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C123E82A867
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 08:34:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNpZM-0008SB-Lq; Thu, 11 Jan 2024 02:33:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rNpZK-0008Rz-Qs
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 02:33:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rNpZJ-0004Rv-5l
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 02:33:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704958415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r1OCs0j3m/mOgE0zJTxOyNn0ddtwlqYwsDI7UO7zhLA=;
 b=LL31xgNUwjwaDI1zq83w3KpX7UatLGXtWRTcPy8wEYm3VmYD7LzrD87iONArnaBGhrZycF
 mwL+XBhI+R8ko+Eo8whBJ9RPCcy+z0+TNMcsxY03eEWWqcBq2k65h5eaM+hinkGKqErwWv
 wdrfXCI594g2VODBczEaOPy0kL1iVjo=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-CtOqo79vMv6B2dx2TFEoYw-1; Thu, 11 Jan 2024 02:33:33 -0500
X-MC-Unique: CtOqo79vMv6B2dx2TFEoYw-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6d9b8fef16aso3741025b3a.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 23:33:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704958413; x=1705563213;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r1OCs0j3m/mOgE0zJTxOyNn0ddtwlqYwsDI7UO7zhLA=;
 b=vzxiZGtlYYEEHOl3KKraOSg7XLmcZ4VTYZYjJsjqJGCB9i2DFqzEewbtWDLJ0l+ES9
 KG32jw2JGPcprgmkNo2S4i0HBt3xoTY6bci9hpXtmvqJjJ5SX096tGW/Yqn3KKvBaQz7
 U22cXITIJTaAToc2Yaq4T3rbVFwWxqv+RBhowA8kcWGnUwEnJ5HtYCiAjFVSmmNKzbHf
 TOgXlWrEXeQ41nlxEpgLSKw20vRl9H4SIoEOxxMvMO9jkkMpJ8OspYsPDMz5ZFlJPSDy
 0k3atilVQataibXBryRKrj1/EAValnYE39IxSbKb6kshlkGa5cQ6JvwSbjbiyA/Fhu7n
 lYLA==
X-Gm-Message-State: AOJu0YzeV3OMDpxGOPSYnRHGa8f7vQPvp2ZQGnFSSoilKLQFyHMpfprx
 6qgRZLGRsNxxiV/emEMMd8Jw0By3UmU5EdQG5KmvrN+mIa+Ouhb7gRzw4iRvlQ+z/aJgLwczJ5U
 ZgtC+NRoQKm8wW8ng3/iAX4+N30Dj8DO7617Yncw=
X-Received: by 2002:a05:6a00:3c92:b0:6db:984:8783 with SMTP id
 lm18-20020a056a003c9200b006db09848783mr586511pfb.6.1704958412943; 
 Wed, 10 Jan 2024 23:33:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9hzylZpSh2Xl2E6Kvq+aTWVDDwdJ10a5HVnTGGMhBEhfLpNN/PqobFrc49De8SnxM60KmTSO+Kdv5g3sKOVE=
X-Received: by 2002:a05:6a00:3c92:b0:6db:984:8783 with SMTP id
 lm18-20020a056a003c9200b006db09848783mr586504pfb.6.1704958412639; Wed, 10 Jan
 2024 23:33:32 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-8-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-8-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 Jan 2024 15:33:21 +0800
Message-ID: <CACGkMEtKkL4GBekRuqpFpDeN54+_HvQjH4xeYpz2PBdYS4-j9w@mail.gmail.com>
Subject: Re: [PATCH 07/40] vdpa: move around vhost_vdpa_set_address_space_id
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: eperezma@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, boris.ostrovsky@oracle.com, 
 jonah.palmer@oracle.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Dec 8, 2023 at 2:50=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
> Move it a few lines ahead to make function call easier for those
> before it.  No funtional change involved.

Typo for functional.

>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  net/vhost-vdpa.c | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 1a738b2..dbfa192 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -335,6 +335,24 @@ static void vdpa_net_migration_state_notifier(Notifi=
er *notifier, void *data)
>      }
>  }
>
> +static int vhost_vdpa_set_address_space_id(struct vhost_vdpa *v,
> +                                           unsigned vq_group,
> +                                           unsigned asid_num)
> +{
> +    struct vhost_vring_state asid =3D {
> +        .index =3D vq_group,
> +        .num =3D asid_num,
> +    };
> +    int r;
> +
> +    r =3D ioctl(v->shared->device_fd, VHOST_VDPA_SET_GROUP_ASID, &asid);
> +    if (unlikely(r < 0)) {
> +        error_report("Can't set vq group %u asid %u, errno=3D%d (%s)",
> +                     asid.index, asid.num, errno, g_strerror(errno));
> +    }
> +    return r;
> +}
> +
>  static void vhost_vdpa_net_data_start_first(VhostVDPAState *s)
>  {
>      struct vhost_vdpa *v =3D &s->vhost_vdpa;
> @@ -490,24 +508,6 @@ static int64_t vhost_vdpa_get_vring_desc_group(int d=
evice_fd,
>      return state.num;
>  }
>
> -static int vhost_vdpa_set_address_space_id(struct vhost_vdpa *v,
> -                                           unsigned vq_group,
> -                                           unsigned asid_num)
> -{
> -    struct vhost_vring_state asid =3D {
> -        .index =3D vq_group,
> -        .num =3D asid_num,
> -    };
> -    int r;
> -
> -    r =3D ioctl(v->shared->device_fd, VHOST_VDPA_SET_GROUP_ASID, &asid);
> -    if (unlikely(r < 0)) {
> -        error_report("Can't set vq group %u asid %u, errno=3D%d (%s)",
> -                     asid.index, asid.num, errno, g_strerror(errno));
> -    }
> -    return r;
> -}
> -
>  static void vhost_vdpa_cvq_unmap_buf(struct vhost_vdpa *v, void *addr)
>  {
>      VhostIOVATree *tree =3D v->shared->iova_tree;
> --
> 1.8.3.1
>


