Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8DA82D35A
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 04:33:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPDi3-0007Mw-MF; Sun, 14 Jan 2024 22:32:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rPDi0-0007MR-AY
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 22:32:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rPDhx-0006Tt-GB
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 22:32:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705289536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=arNJ/7evgL5iACdKwntXY5+QdUvQ4Gps3GXqw6n2fJg=;
 b=D6xsEoKcyDdQBHoMoM+7nOCqrI2+l6SMLYRxapFshC/f33bKheMTlN563yRuLJFu/aI/AH
 AM0fqoWhe3CZW6jd2v/qNdx2DhwBcgoa/iQPbPLni/HT1hhmVvMTqCVaJBFPMKcB2C6J+x
 Ii/bwogAzdrsQXQ6ts6s7fzCy7Zf/3A=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-SoDGab3SMwOL2ghWc6XFhg-1; Sun, 14 Jan 2024 22:32:14 -0500
X-MC-Unique: SoDGab3SMwOL2ghWc6XFhg-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-598e30e7e8cso1279834eaf.3
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 19:32:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705289534; x=1705894334;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=arNJ/7evgL5iACdKwntXY5+QdUvQ4Gps3GXqw6n2fJg=;
 b=KZbZNysc9zLrSKcdXbH8VSt0vNMh6juVUabtbqKWaOeCWt3HGspX2+6dV/8KdXf1I/
 HzWQTePXtSseuXYmF2apPTTTYpr8MtUcBcD9h5LtDOStguA844prx/x7qLaLSjojxJll
 mFDXzzb49j3KlAtn9m1GI23pqvvWNHDLR/V+TJeUks+gQ1vpWO40GNv+PgEtb0FB/TCr
 0LEwxtpO0ddtuhwaHHayq20eou5jUnm03ri86QH+7prmGTZj9psOTgH2YA+a3HC3/YVz
 qc2L8Z/tdqTlOIT3LZHwpTTjPIdhTQoDLZWQ6vF1hlHzvmRXzjXTRw3yAnI3I0HIfjkx
 Z0FA==
X-Gm-Message-State: AOJu0YzKWOJuSeO9RksLlYH5JsZVO2nX6of+WHeCdkPQ6JDcByBSfx4Q
 nFYaXrgKPfvNwlV8ZdP5oTOOpsBSr10HNt/zQC10045KVcPhDKyaX3ujTvKskwKim6UcRFUY/8P
 J9HKd9HhVsBA94W1CLKsf2SJmIN0Ntzcx8osDKXw=
X-Received: by 2002:a05:6358:c107:b0:175:e287:7278 with SMTP id
 fh7-20020a056358c10700b00175e2877278mr503658rwb.45.1705289533946; 
 Sun, 14 Jan 2024 19:32:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkZEOze4L6SFPq6xP5cofDOvb6fHhckTRFmrP/TqwNZCoCt31yWlgBRq+ZOcM83Oi9/HX+FV62QCvuwKMeytg=
X-Received: by 2002:a05:6358:c107:b0:175:e287:7278 with SMTP id
 fh7-20020a056358c10700b00175e2877278mr503647rwb.45.1705289533593; Sun, 14 Jan
 2024 19:32:13 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-30-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-30-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Jan 2024 11:32:02 +0800
Message-ID: <CACGkMEsMv7qTk7+AcHBo1+AQ9ZgB8kHak1xM6NfuANJW7RxZcw@mail.gmail.com>
Subject: Re: [PATCH 29/40] vdpa: expose API vhost_vdpa_dma_batch_once
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: eperezma@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, boris.ostrovsky@oracle.com, 
 jonah.palmer@oracle.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
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

On Fri, Dec 8, 2023 at 2:51=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> w=
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
> +        goto fail_map;
> +    }
> +

This seems like another patch.

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

And this as well.

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

And these.

Thanks

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


