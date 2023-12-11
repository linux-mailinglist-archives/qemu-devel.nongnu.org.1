Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7817780C7D0
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 12:21:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCeLF-0005Re-CA; Mon, 11 Dec 2023 06:20:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rCeLD-0005RV-R2
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 06:20:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rCeL9-0001uT-2r
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 06:20:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702293646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lDggFZsV2dimMJRn2gc06unKpbOO6GCYne1P5Gw7Qzw=;
 b=ZO7QbIaMMgsyEHGaM40hVUf4kom3NGjdUX5iRXg/4E/fRwlNV95g3fHXq3Ppu9yzA8OSyT
 l8Ft/wnDFd3PqI3sAMsvPrMccezYrMD9dngjc3/VqZSSvn8igGDXvg5eZiROLLO4pI9mB+
 mPPBFkkJcwmT0uBZAyaVKJYAtfKGWsU=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-zHOfRPG3PdGa81OUIByiJA-1; Mon, 11 Dec 2023 06:20:45 -0500
X-MC-Unique: zHOfRPG3PdGa81OUIByiJA-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-dbcad3c1b70so90158276.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 03:20:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702293625; x=1702898425;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lDggFZsV2dimMJRn2gc06unKpbOO6GCYne1P5Gw7Qzw=;
 b=SF79N7+yxh6jlgt37iI6GDXLo+wddtihnjfUW+fchkNrYfJH9uZRiJyUXksHmnl90E
 PDsgdBfh2M/LNxYHU4VJtdtph9KCxy3ofSuhHqsIh/hqUPLLhu/ObP00cfrJmqlipPYa
 Kzs/63kelsN7KPL/XVbLgFc1b0vFGsufQxJ5I4GWcRvCJqiPdpiBrGnpXJ/MPMy00Al4
 dX5j3/RCVCk2p1Yu/ftso1vGqIKmZ9I6pLlCdk8lIbipjOXbNyhCi1MDWZdFfR4F80Sz
 xYG2CB0ht7rxGIq95wtvmy7KpVsHVpWgDzE6/FFGHfIbvb84uE+CT7lDoVYAUnqdGgCT
 Tixg==
X-Gm-Message-State: AOJu0Yx+LKPm3i3qxUwtaj4s6mgemlkIaye3QVeuctCYT8nhVfFRdYYj
 FgyWrh8E4hCxjw7Dopjd2Dxwg+RXiVeYlqaoVQRb3IDGviY84DV1FAll218U0nQ8LQcyNGQq5pz
 8rNDE+m/HBfAruGkkJ4x704eIvExpHM8=
X-Received: by 2002:a25:8185:0:b0:db7:dacf:2f2e with SMTP id
 p5-20020a258185000000b00db7dacf2f2emr2698351ybk.117.1702293625501; 
 Mon, 11 Dec 2023 03:20:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+R00Yo2RhVuleeN2Up+ZQAf8CUVklv7JyhQy26Q2fhWVg8Xu3PeRWtLrFYj/QLjVbTPNUXL1EP4/jF4ZNOUE=
X-Received: by 2002:a25:8185:0:b0:db7:dacf:2f2e with SMTP id
 p5-20020a258185000000b00db7dacf2f2emr2698345ybk.117.1702293625274; Mon, 11
 Dec 2023 03:20:25 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-9-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-9-git-send-email-si-wei.liu@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 11 Dec 2023 12:19:49 +0100
Message-ID: <CAJaqyWfKsrGeSziF01kxr76wHSswtTshhzWKzyEFJAtsAQ5cfQ@mail.gmail.com>
Subject: Re: [PATCH 08/40] vdpa: add back vhost_vdpa_net_first_nc_vdpa
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: jasowang@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, boris.ostrovsky@oracle.com, 
 jonah.palmer@oracle.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Dec 7, 2023 at 7:52=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
> Previous commits had it removed. Now adding it back because
> this function will be needed by next patches.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  net/vhost-vdpa.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index dbfa192..c9bfc6f 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -287,6 +287,16 @@ static ssize_t vhost_vdpa_receive(NetClientState *nc=
, const uint8_t *buf,
>      return size;
>  }
>
> +

Extra newline.

> +/** From any vdpa net client, get the netclient of the first queue pair =
*/
> +static VhostVDPAState *vhost_vdpa_net_first_nc_vdpa(VhostVDPAState *s)
> +{
> +    NICState *nic =3D qemu_get_nic(s->nc.peer);
> +    NetClientState *nc0 =3D qemu_get_peer(nic->ncs, 0);
> +
> +    return DO_UPCAST(VhostVDPAState, nc, nc0);
> +}
> +
>  static void vhost_vdpa_net_log_global_enable(VhostVDPAState *s, bool ena=
ble)
>  {
>      struct vhost_vdpa *v =3D &s->vhost_vdpa;
> @@ -566,7 +576,7 @@ dma_map_err:
>
>  static int vhost_vdpa_net_cvq_start(NetClientState *nc)
>  {
> -    VhostVDPAState *s;
> +    VhostVDPAState *s, *s0;
>      struct vhost_vdpa *v;
>      int64_t cvq_group;
>      int r;
> @@ -577,7 +587,8 @@ static int vhost_vdpa_net_cvq_start(NetClientState *n=
c)
>      s =3D DO_UPCAST(VhostVDPAState, nc, nc);
>      v =3D &s->vhost_vdpa;
>
> -    v->shadow_vqs_enabled =3D v->shared->shadow_data;
> +    s0 =3D vhost_vdpa_net_first_nc_vdpa(s);
> +    v->shadow_vqs_enabled =3D s0->vhost_vdpa.shadow_vqs_enabled;
>      s->vhost_vdpa.address_space_id =3D VHOST_VDPA_GUEST_PA_ASID;

I'm wondering if shared->shadow_data is more correct now.

Either way:

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

>
>      if (v->shared->shadow_data) {
> --
> 1.8.3.1
>
>


