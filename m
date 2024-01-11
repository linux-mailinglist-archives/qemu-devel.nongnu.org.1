Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEDD82A807
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 08:09:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNpC7-0008SK-UD; Thu, 11 Jan 2024 02:09:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rNpC6-0008SB-FU
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 02:09:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rNpC4-0006cE-Dw
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 02:09:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704956975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=19S4R4DOVv498gkh5yT5SIY8549tdDVSJe6kpxp7huc=;
 b=Bm+BCuI2ANGycmi4r4MGFthu64VdEVKwEbPP+lHYj3cmfnpZWE648s8ZT4m25v1O/Yd9Bs
 XEJZfS11ZiWw1hEcprh7drOFSuRtn6XaJGIApNm8WUJjlbwpp4uvdn2NjpEl6aqgjO1RW5
 HoQfx+GCLEuTbtniEPgDpuh/lbsgNMI=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-TO_kkBsVOXGDLBI85zzINg-1; Thu, 11 Jan 2024 02:09:33 -0500
X-MC-Unique: TO_kkBsVOXGDLBI85zzINg-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3bd24849608so6879499b6e.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 23:09:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704956972; x=1705561772;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=19S4R4DOVv498gkh5yT5SIY8549tdDVSJe6kpxp7huc=;
 b=nobqG963YsSz0WIgCg51U/GbgmMHAqCYIQaa66SP0UDhcrpVEY0fM/oB+l0Zo3Yks7
 rN06fkg54P15EqFmNPF/IABqlcM/4au/gWNmTNGwyZRLbQ/WOPdUyjjqmEyidCnTCur9
 J1QXvqdfJqbCHs7uTULhlVkgVGtRHWVNlm6znMBxUdZPjB6A7RjvvAeSOFQ41qIdCS5i
 0juGOfjvN2BDJkCGZ8ydBamrT33nWZJ3obKgePVdSelcOb7vUKau/0CR7rBU2pTRjigy
 PizziSyGQfPP4BpMSYAEcxTnX6/OF+N2jMI+PjXM4AiTDTAK/Qef6k7mbiMWwco9OWCT
 BjRg==
X-Gm-Message-State: AOJu0YyFcOziO1UEQmssKhSUIG7meK/+i4fviKpHPCrTBsWv/08Ngz5h
 R/SfzFdVza8Cf2cHkGWsCqFx5xnyuD/QzBftsaS19GUM4P8qtx0C4Ba6FO1H/ZfJLdA1H8kxViB
 Ab4XSwd5Ynuew+Sf4uolxnd4UNcvUx3Ofvm5enBQ=
X-Received: by 2002:a05:6808:2112:b0:3bd:4838:527d with SMTP id
 r18-20020a056808211200b003bd4838527dmr975347oiw.46.1704956972337; 
 Wed, 10 Jan 2024 23:09:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG++0jmgOqwQrvC/lP0i8QlPhgmFBtU7iWcxJ7/xyvpywwYaTqFbXNZRa6laUc1Roe1QVDdUUdmKkxR0Fr4tGg=
X-Received: by 2002:a05:6808:2112:b0:3bd:4838:527d with SMTP id
 r18-20020a056808211200b003bd4838527dmr975340oiw.46.1704956972141; Wed, 10 Jan
 2024 23:09:32 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-6-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-6-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 Jan 2024 15:09:20 +0800
Message-ID: <CACGkMEtVDF-qDoEeq9VNN1ooRKvJ9VF+MsGZTd=NXdt4_Chnhw@mail.gmail.com>
Subject: Re: [PATCH 05/40] vdpa: populate desc_group from net_vhost_vdpa_init
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: eperezma@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, boris.ostrovsky@oracle.com, 
 jonah.palmer@oracle.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
> Add the desc_group field to struct vhost_vdpa, and get it
> populated when the corresponding vq is initialized at
> net_vhost_vdpa_init. If the vq does not have descriptor
> group capability, or it doesn't have a dedicated ASID
> group to host descriptors other than the data buffers,
> desc_group will be set to a negative value -1.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  include/hw/virtio/vhost-vdpa.h |  1 +
>  net/vhost-vdpa.c               | 15 +++++++++++++--
>  2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdp=
a.h
> index 6533ad2..63493ff 100644
> --- a/include/hw/virtio/vhost-vdpa.h
> +++ b/include/hw/virtio/vhost-vdpa.h
> @@ -87,6 +87,7 @@ typedef struct vhost_vdpa {
>      Error *migration_blocker;
>      VhostVDPAHostNotifier notifier[VIRTIO_QUEUE_MAX];
>      IOMMUNotifier n;
> +    int64_t desc_group;
>  } VhostVDPA;
>
>  int vhost_vdpa_get_iova_range(int fd, struct vhost_vdpa_iova_range *iova=
_range);
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index cb5705d..1a738b2 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -1855,11 +1855,22 @@ static NetClientState *net_vhost_vdpa_init(NetCli=
entState *peer,
>
>      ret =3D vhost_vdpa_add(nc, (void *)&s->vhost_vdpa, queue_pair_index,=
 nvqs);
>      if (ret) {
> -        qemu_del_net_client(nc);
> -        return NULL;
> +        goto err;

This part of introducing the "err" label looks more like a cleanup.

Others look good.

Thanks

>      }
>
> +    if (is_datapath) {
> +        ret =3D vhost_vdpa_probe_desc_group(vdpa_device_fd, features,
> +                                          0, &desc_group, errp);
> +        if (unlikely(ret < 0)) {
> +            goto err;
> +        }
> +    }
> +    s->vhost_vdpa.desc_group =3D desc_group;
>      return nc;
> +
> +err:
> +    qemu_del_net_client(nc);
> +    return NULL;
>  }
>
>  static int vhost_vdpa_get_features(int fd, uint64_t *features, Error **e=
rrp)
> --
> 1.8.3.1
>


