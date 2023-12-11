Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7771E80C7CA
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 12:19:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCeJW-0004Vk-Dl; Mon, 11 Dec 2023 06:19:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rCeJN-0004RP-JJ
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 06:18:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rCeJL-0001bT-2a
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 06:18:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702293534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C+wyA2In23f9zQYLG1G+WC433QPceWHTXPdrUQ+VUVo=;
 b=IPJxeHOp5wUKf0nKkDIhZY1GO7RrhJX9mQvswwly11PsaII/L2QSz9NVcEPYtQ3KHZDgko
 V05tnVs+kEdZJkt7MXRFGxxqu3LCIEOtnyvlgACJH6uhiMqmcGXKn+fmXYAdYHduej7EZY
 tDh9rCP6d1lBxTQ63PMNP3mW+MjhQgs=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-PwebOFhmOIaS7YjI1DRcKg-1; Mon, 11 Dec 2023 06:18:52 -0500
X-MC-Unique: PwebOFhmOIaS7YjI1DRcKg-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-d9a541b720aso4724734276.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 03:18:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702293532; x=1702898332;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C+wyA2In23f9zQYLG1G+WC433QPceWHTXPdrUQ+VUVo=;
 b=nXsXtH6KXERnwTiDkw2uqiY78ys8KorEFg7mkJSdv1Y+P0nl7ZVNXf/E8LIYGH9WkD
 1D1XVI1hwVF784dkfPNgS2JNOAeV0CBFVM2vDqQpfLxD3Jt7gtKv780D1s50LaaxcVvd
 wMn6FT3YthQqAjBmv87gBHLi2NnJE9kLaM03AQudbElckXQi1a2gdAa56Y6Xa574RTb6
 Cxqoii4enyeVszbMRkWz3HiqJjpTDOGxfKhDkxg6EJvqrSHbetJO1p7oHcRSXPCF9Xlu
 qMsK9+mlP2YtRdurWorBfrX1NM9irBta3Pv6EqOj9jIeWwFyDaNAkDfKEVQYvvY4JAi1
 idaw==
X-Gm-Message-State: AOJu0YxnQwEnGuzRY+b03B+LpTWqFQaFvjVRWBgOBgCZCLapq7LGfLAe
 iV2qfCxOJjm5h7cwoZdynnknXaR7qQ/ZbLNTCXIzGMobi6nxoOpUmqwCYXtddVt3ub3gR8BON1o
 RNguOpaE1M2BOXKKQgh0FowMAHrt+8K4=
X-Received: by 2002:a25:fb02:0:b0:db5:4e2d:8bb2 with SMTP id
 j2-20020a25fb02000000b00db54e2d8bb2mr2610733ybe.1.1702293532382; 
 Mon, 11 Dec 2023 03:18:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH05eEKzLq306JwS88YyhYIS0+i5dHN0wAoToGDzjeZPQaF4I04PXU7AX8C8bYTJ18Bo+xtSgFV5CJvB/W0Jl4=
X-Received: by 2002:a25:fb02:0:b0:db5:4e2d:8bb2 with SMTP id
 j2-20020a25fb02000000b00db54e2d8bb2mr2610719ybe.1.1702293532081; Mon, 11 Dec
 2023 03:18:52 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-8-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-8-git-send-email-si-wei.liu@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 11 Dec 2023 12:18:16 +0100
Message-ID: <CAJaqyWcgmesBPaei0RtsEw+bV+6mnfi3DxixVS08LCgEOyDr3Q@mail.gmail.com>
Subject: Re: [PATCH 07/40] vdpa: move around vhost_vdpa_set_address_space_id
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: jasowang@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, boris.ostrovsky@oracle.com, 
 jonah.palmer@oracle.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Thu, Dec 7, 2023 at 7:50=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
> Move it a few lines ahead to make function call easier for those
> before it.  No funtional change involved.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

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


