Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8204D8117CF
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 16:44:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDROA-0007by-Uo; Wed, 13 Dec 2023 10:43:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rDRO8-0007bE-OV
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 10:43:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rDRO7-0006Ns-4Q
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 10:43:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702482186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N8CkbzqyLe5ZN8H8a7x/mCnOmeMR5PjAYP6CEKEoxRA=;
 b=ODc1GRbtz+1EyDHjmxyKIKlaEF79qBZSrgrWGMjsHeK1ArkXVgcKaFOEdnndhQeRu+Yf5T
 gW9BzhKJRVHwVGNeOPJEFaf7XOFqN77GDxwVvhno3hlO5AW3qT2Lp1Y34Z31iOOY23z2bo
 j6jNvNtya0SP0EAxNCY8ro6D+4JlEbs=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-dggjhjt-O2mB6h6ctPSX_w-1; Wed, 13 Dec 2023 10:43:04 -0500
X-MC-Unique: dggjhjt-O2mB6h6ctPSX_w-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-5d42c43d8daso48452627b3.0
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 07:43:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702482184; x=1703086984;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N8CkbzqyLe5ZN8H8a7x/mCnOmeMR5PjAYP6CEKEoxRA=;
 b=eVf6muWGEItVUnjeuabXy++e614cJul4yCmtivqHlK9fTA6ulLfZy5C3VXDg2EAi9B
 137yyHvJWGfkKfaCdy6/cWTMuD95XKdbotxisjhyiCz7jT0OFedvKZyjMRIYJLdYZXJQ
 9dnKoX4ezEVPqOXsyfQZ3NQChbWM1AWKWZ2NxHR2WQtqvX72KPZk9i2YaaywQzxEp4Wm
 tzR0FZdOEnQuUTms4gD920y/lIHoykMXiNHDoXtF1wKN0gZ0n83mXCFtN2atc655SCFS
 nOjYNdprCE4RovbDOivAm8DsMQOLrWgwaNbRk94dpz7+rT/kb/DnFKur6smm6oBIrdNb
 hNVg==
X-Gm-Message-State: AOJu0YzYIClMZiTYBRrAalqJzNkGRiG1+Z8CJfiwzhaSInaYBXxDhgyX
 uaz7ZT9CJ3/nQiOQsDUSkIMiAsMm677BSNicCRBykRvsxtOOgVu7Mc2JxXxnl+AX67HRVUAmaRe
 bcyqttK7Te8j4ftwzJYURKI8A8v5xKl3FrfxWd1o=
X-Received: by 2002:a0d:ffc7:0:b0:5e1:84d7:174d with SMTP id
 p190-20020a0dffc7000000b005e184d7174dmr2976497ywf.50.1702482183893; 
 Wed, 13 Dec 2023 07:43:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfnWpoPse1jgImK8+BT+SPN+J/XV3XMa6xV1QmPTqanKg1WyWp94pDCkRRDWrbs3OO8vSzTHFB0grd3p+HJUg=
X-Received: by 2002:a0d:ffc7:0:b0:5e1:84d7:174d with SMTP id
 p190-20020a0dffc7000000b005e184d7174dmr2976486ywf.50.1702482183640; Wed, 13
 Dec 2023 07:43:03 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-30-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-30-git-send-email-si-wei.liu@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 13 Dec 2023 16:42:27 +0100
Message-ID: <CAJaqyWc_Q6sqr9i=bFLBusZdjDjmrAK4r0a1KYAz+JUv==9Cjw@mail.gmail.com>
Subject: Re: [PATCH 29/40] vdpa: expose API vhost_vdpa_dma_batch_once
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

On Thu, Dec 7, 2023 at 7:51=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
> So that the batching API can be called from other file
> externally than the local.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  hw/virtio/vhost-vdpa.c         | 21 +++++++++++++++------
>  include/hw/virtio/vhost-vdpa.h |  3 +++
>  2 files changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index b7896a8..68dc01b 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -187,7 +187,7 @@ static bool vhost_vdpa_map_batch_begin(VhostVDPAShare=
d *s, uint32_t asid)
>      return true;
>  }
>
> -static int vhost_vdpa_dma_batch_begin_once(VhostVDPAShared *s, uint32_t =
asid)
> +int vhost_vdpa_dma_batch_begin_once(VhostVDPAShared *s, uint32_t asid)
>  {
>      if (!(s->backend_cap & (0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH))) {
>          return 0;
> @@ -237,7 +237,7 @@ static bool vhost_vdpa_dma_batch_end(VhostVDPAShared =
*s, uint32_t asid)
>      return true;
>  }
>
> -static int vhost_vdpa_dma_batch_end_once(VhostVDPAShared *s, uint32_t as=
id)
> +int vhost_vdpa_dma_batch_end_once(VhostVDPAShared *s, uint32_t asid)
>  {
>      if (!(s->backend_cap & (0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH))) {
>          return 0;
> @@ -436,7 +436,12 @@ static void vhost_vdpa_listener_region_add(MemoryLis=
tener *listener,
>          iova =3D mem_region.iova;
>      }
>
> -    vhost_vdpa_dma_batch_begin_once(s, VHOST_VDPA_GUEST_PA_ASID);
> +    ret =3D vhost_vdpa_dma_batch_begin_once(s, VHOST_VDPA_GUEST_PA_ASID)=
;
> +    if (unlikely(ret)) {
> +        error_report("Can't batch mapping on asid 0 (%p)", s);

Can we move this error to vhost_vdpa_dma_batch_begin_once?

That way we avoid duplicating the error message later in the patch and
we can tell the expected ASID.

> +        goto fail_map;
> +    }
> +
>      ret =3D vhost_vdpa_dma_map(s, VHOST_VDPA_GUEST_PA_ASID, iova,
>                               int128_get64(llsize), vaddr, section->reado=
nly);
>      if (ret) {
> @@ -518,7 +523,11 @@ static void vhost_vdpa_listener_region_del(MemoryLis=
tener *listener,
>          iova =3D result->iova;
>          vhost_iova_tree_remove(s->iova_tree, *result);
>      }
> -    vhost_vdpa_dma_batch_begin_once(s, VHOST_VDPA_GUEST_PA_ASID);
> +    ret =3D vhost_vdpa_dma_batch_begin_once(s, VHOST_VDPA_GUEST_PA_ASID)=
;
> +    if (ret) {
> +        error_report("Can't batch mapping on asid 0 (%p)", s);
> +    }
> +
>      /*
>       * The unmap ioctl doesn't accept a full 64-bit. need to check it
>       */
> @@ -1396,10 +1405,10 @@ static void *vhost_vdpa_load_map(void *opaque)
>                                       msg->iotlb.size);
>              break;
>          case VHOST_IOTLB_BATCH_BEGIN:
> -            vhost_vdpa_dma_batch_begin_once(shared, msg->asid);
> +            r =3D vhost_vdpa_dma_batch_begin_once(shared, msg->asid);
>              break;
>          case VHOST_IOTLB_BATCH_END:
> -            vhost_vdpa_dma_batch_end_once(shared, msg->asid);
> +            r =3D vhost_vdpa_dma_batch_end_once(shared, msg->asid);
>              break;
>          default:
>              error_report("Invalid IOTLB msg type %d", msg->iotlb.type);
> diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdp=
a.h
> index 219316f..aa13679 100644
> --- a/include/hw/virtio/vhost-vdpa.h
> +++ b/include/hw/virtio/vhost-vdpa.h
> @@ -106,6 +106,9 @@ int vhost_vdpa_dma_map(VhostVDPAShared *s, uint32_t a=
sid, hwaddr iova,
>                         hwaddr size, void *vaddr, bool readonly);
>  int vhost_vdpa_dma_unmap(VhostVDPAShared *s, uint32_t asid, hwaddr iova,
>                           hwaddr size);
> +int vhost_vdpa_dma_batch_begin_once(VhostVDPAShared *s, uint32_t asid);
> +int vhost_vdpa_dma_batch_end_once(VhostVDPAShared *s, uint32_t asid);
> +
>  int vhost_vdpa_load_setup(VhostVDPAShared *s, AddressSpace *dma_as);
>  int vhost_vdpa_load_cleanup(VhostVDPAShared *s, bool vhost_will_start);
>
> --
> 1.8.3.1
>


