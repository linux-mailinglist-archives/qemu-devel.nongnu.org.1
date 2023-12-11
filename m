Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BDC80D91F
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 19:51:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rClMa-0000hn-Go; Mon, 11 Dec 2023 13:50:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rClMY-0000fr-CW
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 13:50:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rClMW-0002La-JL
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 13:50:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702320639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/CDn2VghOaKvrsm12KBE1NI7gBKOAPVi7xfhaDHYS0Y=;
 b=BB8/dRAkexwRzvO6sVTYwfHg55Dn3jOj0hR51vfZLSccZnuL2xRjEMaBeaDWxbLlc77Km7
 O6Tb/E9KE6FugxwVe8n4cvJsOpXiBzrK/Xz59gq+HoLNGpyXrTPb5OFU4eWCfjHbs7LAKZ
 RK3sTmYygWYvaWRc5d0AjCo05SCqMds=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-wCLUJcCcNsmsUTmg4kwjFg-1; Mon, 11 Dec 2023 13:50:36 -0500
X-MC-Unique: wCLUJcCcNsmsUTmg4kwjFg-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-db54c11887aso5239699276.1
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 10:50:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702320636; x=1702925436;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/CDn2VghOaKvrsm12KBE1NI7gBKOAPVi7xfhaDHYS0Y=;
 b=J6hpTt967+P+MYOCNf/a9e/wSbL27MdMy7DryWMgKVZXeHwbzvmyMAEh3ftlBThHRY
 58e2RHAozUqfqIs7tOZNyxhbwd2Uf4qBPaZIwYZ2B5ZC0VKih46rwru5MMBuY1NHTACj
 Hw86dV5MxvMAUWPLgPBssEiMbli/kjB/oLMDA47324DJD6j9iRasUgNQ2vXAm9YZVD/I
 IOdG2CpHSnGktfL+3ypZDwzCROEPT1BLiUFj3LZwaLrvsphUWfZc3Wck6ZDpJgtdwEbL
 5nuXUTEjcKitg5EPwY2iWXBi+H70s+CVWJ+oie8gPZC4T1D6lGkIMutRP4FaZgazFJhT
 kghA==
X-Gm-Message-State: AOJu0YxUgWm9KcJuA17Xj8d7pWSrk5sPnsHzmD+HVY90NzCTlO5442ST
 2SX/eegPAUA498SV+rd53zTn31Mq+ox7/OKskMDQWMpDFI89N+f+9VghkwgOHCnavRJel7CUdJM
 C5AfhrYmYaUeddMx7BBckx4rv6gfx3DY=
X-Received: by 2002:a25:ad1b:0:b0:daf:b23c:8619 with SMTP id
 y27-20020a25ad1b000000b00dafb23c8619mr3051781ybi.51.1702320635792; 
 Mon, 11 Dec 2023 10:50:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXnQBdiQNFG0jKwEURzXlg02FgQ19CJZ4fADFb7fRaTlUHACDPZzjo4xQOWqTgE9s28fk/1htcefgVMMlUNtA=
X-Received: by 2002:a25:ad1b:0:b0:daf:b23c:8619 with SMTP id
 y27-20020a25ad1b000000b00dafb23c8619mr3051774ybi.51.1702320635455; Mon, 11
 Dec 2023 10:50:35 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-4-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-4-git-send-email-si-wei.liu@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 11 Dec 2023 19:49:59 +0100
Message-ID: <CAJaqyWeScA3_uGqU2LvUawNdZy1oGR5Rc9gdLRyVmxSxH5E1Cg@mail.gmail.com>
Subject: Re: [PATCH 03/40] vdpa: probe descriptor group index for data vqs
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

On Thu, Dec 7, 2023 at 7:53=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
> Getting it ahead at initialization time instead of start time allows
> decision making independent of device status, while reducing failure
> possibility in starting device or during migration.
>
> Adding function vhost_vdpa_probe_desc_group() for that end. This
> function will be used to probe the descriptor group for data vqs.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  net/vhost-vdpa.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 89 insertions(+)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 887c329..0cf3147 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -1688,6 +1688,95 @@ out:
>      return r;
>  }
>
> +static int vhost_vdpa_probe_desc_group(int device_fd, uint64_t features,
> +                                       int vq_index, int64_t *desc_grpid=
x,
> +                                       Error **errp)
> +{
> +    uint64_t backend_features;
> +    int64_t vq_group, desc_group;
> +    uint8_t saved_status =3D 0;
> +    uint8_t status =3D 0;
> +    int r;
> +
> +    ERRP_GUARD();
> +
> +    r =3D ioctl(device_fd, VHOST_GET_BACKEND_FEATURES, &backend_features=
);
> +    if (unlikely(r < 0)) {
> +        error_setg_errno(errp, errno, "Cannot get vdpa backend_features"=
);
> +        return r;
> +    }
> +
> +    if (!(backend_features & BIT_ULL(VHOST_BACKEND_F_IOTLB_ASID))) {
> +        return 0;
> +    }
> +
> +    if (!(backend_features & BIT_ULL(VHOST_BACKEND_F_DESC_ASID))) {
> +        return 0;
> +    }
> +
> +    r =3D ioctl(device_fd, VHOST_VDPA_GET_STATUS, &saved_status);
> +    if (unlikely(r)) {
> +        error_setg_errno(errp, -r, "Cannot get device status");
> +        goto out;

Nit, we could return here directly, can't we?

> +    }
> +
> +    r =3D ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
> +    if (unlikely(r)) {
> +        error_setg_errno(errp, -r, "Cannot reset device");
> +        goto out;
> +    }
> +
> +    r =3D ioctl(device_fd, VHOST_SET_FEATURES, &features);
> +    if (unlikely(r)) {
> +        error_setg_errno(errp, errno, "Cannot set features");

missing goto out?

> +    }
> +
> +    status =3D VIRTIO_CONFIG_S_ACKNOWLEDGE |
> +             VIRTIO_CONFIG_S_DRIVER |
> +             VIRTIO_CONFIG_S_FEATURES_OK;
> +
> +    r =3D ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
> +    if (unlikely(r)) {
> +        error_setg_errno(errp, -r, "Cannot set device status");
> +        goto out;
> +    }
> +
> +    vq_group =3D vhost_vdpa_get_vring_group(device_fd, vq_index, errp);
> +    if (unlikely(vq_group < 0)) {
> +        if (vq_group !=3D -ENOTSUP) {
> +            r =3D vq_group;
> +            goto out;
> +        }
> +
> +        /*
> +         * The kernel report VHOST_BACKEND_F_IOTLB_ASID if the vdpa fron=
tend
> +         * support ASID even if the parent driver does not.
> +         */
> +        error_free(*errp);
> +        *errp =3D NULL;
> +        r =3D 0;
> +        goto out;
> +    }
> +
> +    desc_group =3D vhost_vdpa_get_vring_desc_group(device_fd, vq_index,
> +                                                 errp);
> +    if (unlikely(desc_group < 0)) {
> +        r =3D desc_group;
> +        goto out;
> +    } else if (desc_group !=3D vq_group) {
> +        *desc_grpidx =3D desc_group;
> +    }
> +    r =3D 1;
> +
> +out:
> +    status =3D 0;
> +    ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
> +    if (saved_status) {
> +        ioctl(device_fd, VHOST_VDPA_SET_STATUS, &saved_status);
> +    }
> +    return r;
> +}
> +

It is invalid to add static functions without a caller, I think the
compiler will complain about this.

>  static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
>                                         const char *device,
>                                         const char *name,
> --
> 1.8.3.1
>
>


