Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F2A82A8CA
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 09:14:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNqBE-0003CT-9t; Thu, 11 Jan 2024 03:12:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rNqB9-0003AQ-5a
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 03:12:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rNqB6-0006Jn-9Q
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 03:12:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704960758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rg7Ao1Tlb+e0EAKKgDqHLM3yNC/FThl66zCeDT+EIsA=;
 b=OR7JJXobSh/hqB33MtcygMtSiLTq/hlpj0geuZcbYWY/6/Mk77YLnXZxYLg/0AdcXntjNo
 cJvf+LjBZcUhMnumN+DoKzxWgaChd/shDCpRJKWJtLAwvB8xS7JLkMWC+AGf9h/S686tgN
 RBomLIsCxaR5CFVCr5FRlg5RLYw2X34=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-oAiMMjXcO3W4YVfinTitXA-1; Thu, 11 Jan 2024 03:12:37 -0500
X-MC-Unique: oAiMMjXcO3W4YVfinTitXA-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-6d9b8ff5643so2923664b3a.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 00:12:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704960756; x=1705565556;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rg7Ao1Tlb+e0EAKKgDqHLM3yNC/FThl66zCeDT+EIsA=;
 b=Ni9jUfDx8y0mQ66krQxy5PcxlD/ePaTEfBepZCAyvd5ldIMR9hr8jHFG5BhMpv0cIz
 24rXsvmfJ3j4cOVfer09StFcmBXLI4yWDuVHx2lcoYOkxkpdZwZ3CNTgEc3esojv+ZBF
 4f/9ucVol8GPyaF4CbMVWTkOdn/Hgb8hr5/EaYUd4qL002Qbu2jmIkc+vwXh83uywO4e
 vRRWBctHiGxweFZaEoHy8lvoXyStuB65xe5rZIn1nReHGKlsIOpZ3UKnnYyNIMq4ORIS
 MdqqEwdozLYGKvnG4DGKGiU6T5e4a9cIBosaZIGMv+VfL38sKTX5sn/jLebRktN7ABFs
 yslA==
X-Gm-Message-State: AOJu0Yxt12KPACj33qZpwOoX+M0Q2RE1G3wmkA9vJDt4QSEFKXeac9Ua
 RPVGxVToL7TB4/4m07nZG5u+jqaEnt4qJxRULN2z2Q5rFA/qYllgsUiiiThjkddN7eeZqVYZ3v3
 8stP4gYQv66HA0AyMdb0XUuJ4iIO/w09GYna4e14=
X-Received: by 2002:aa7:8a09:0:b0:6d9:bb7c:a56a with SMTP id
 m9-20020aa78a09000000b006d9bb7ca56amr738948pfa.36.1704960755915; 
 Thu, 11 Jan 2024 00:12:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGE4k8xSLKdeHXYlorFH+fyD11DPujTw6aY3EAe4dezuNdeyjgmDvNEdmjrbk0hq5pScJHHCTcFs/vmCVVvC8U=
X-Received: by 2002:aa7:8a09:0:b0:6d9:bb7c:a56a with SMTP id
 m9-20020aa78a09000000b006d9bb7ca56amr738935pfa.36.1704960755605; Thu, 11 Jan
 2024 00:12:35 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-14-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-14-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 Jan 2024 16:12:24 +0800
Message-ID: <CACGkMEuJjb8st2PZAWENF2xd-Xj_PaAKTgbLTCO7w7ZDQKPbJg@mail.gmail.com>
Subject: Re: [PATCH 13/40] vdpa: ref counting VhostVDPAShared
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: eperezma@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, boris.ostrovsky@oracle.com, 
 jonah.palmer@oracle.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> Subsequent patches attempt to release VhostVDPAShared resources,
> for example iova tree to free and memory listener to unregister,
> in vdpa_dev_cleanup(). Instead of checking against the vq index,
> which is not always available in all of the callers, counting
> the usage by reference. Then it'll be easy to free resource
> upon the last deref.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  include/hw/virtio/vhost-vdpa.h |  2 ++
>  net/vhost-vdpa.c               | 14 ++++++++++----
>  2 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdp=
a.h
> index 63493ff..7b8d3bf 100644
> --- a/include/hw/virtio/vhost-vdpa.h
> +++ b/include/hw/virtio/vhost-vdpa.h
> @@ -70,6 +70,8 @@ typedef struct vhost_vdpa_shared {
>
>      /* Vdpa must send shadow addresses as IOTLB key for data queues, not=
 GPA */
>      bool shadow_data;
> +
> +    unsigned refcnt;
>  } VhostVDPAShared;
>
>  typedef struct vhost_vdpa {
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index aebaa53..a126e5c 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -236,11 +236,11 @@ static void vhost_vdpa_cleanup(NetClientState *nc)
>          g_free(s->vhost_net);
>          s->vhost_net =3D NULL;
>      }
> -    if (s->vhost_vdpa.index !=3D 0) {
> -        return;
> +    if (--s->vhost_vdpa.shared->refcnt =3D=3D 0) {
> +        qemu_close(s->vhost_vdpa.shared->device_fd);
> +        g_free(s->vhost_vdpa.shared);
>      }

I'd suggest having a get and put helper, then we can check and do
cleanup in the put when refcnt is zero.

Thanks

> -    qemu_close(s->vhost_vdpa.shared->device_fd);
> -    g_free(s->vhost_vdpa.shared);
> +    s->vhost_vdpa.shared =3D NULL;
>  }
>
>  /** Dummy SetSteeringEBPF to support RSS for vhost-vdpa backend  */
> @@ -1896,6 +1896,7 @@ static NetClientState *net_vhost_vdpa_init(NetClien=
tState *peer,
>          s->vhost_vdpa.shared->device_fd =3D vdpa_device_fd;
>          s->vhost_vdpa.shared->iova_range =3D iova_range;
>          s->vhost_vdpa.shared->shadow_data =3D svq;
> +        s->vhost_vdpa.shared->refcnt++;
>      } else if (!is_datapath) {
>          s->cvq_cmd_out_buffer =3D mmap(NULL, vhost_vdpa_net_cvq_cmd_page=
_len(),
>                                       PROT_READ | PROT_WRITE,
> @@ -1910,6 +1911,7 @@ static NetClientState *net_vhost_vdpa_init(NetClien=
tState *peer,
>      }
>      if (queue_pair_index !=3D 0) {
>          s->vhost_vdpa.shared =3D shared;
> +        s->vhost_vdpa.shared->refcnt++;
>      }
>
>      ret =3D vhost_vdpa_add(nc, (void *)&s->vhost_vdpa, queue_pair_index,=
 nvqs);
> @@ -1928,6 +1930,10 @@ static NetClientState *net_vhost_vdpa_init(NetClie=
ntState *peer,
>      return nc;
>
>  err:
> +    if (--s->vhost_vdpa.shared->refcnt =3D=3D 0) {
> +        g_free(s->vhost_vdpa.shared);
> +    }
> +    s->vhost_vdpa.shared =3D NULL;
>      qemu_del_net_client(nc);
>      return NULL;
>  }
> --
> 1.8.3.1
>


