Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9857082D339
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 04:05:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPDGt-0005U3-Ai; Sun, 14 Jan 2024 22:04:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rPDGo-0005TZ-6G
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 22:04:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rPDGm-0001Uc-El
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 22:04:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705287850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HeNryQTBjaETwLWZ5iiQ3GPgA72vTDuYwve/POTU65A=;
 b=ctvb9lT3VmqxkOXAoPdEvbwzAtUiD2oOaR6AmsqpOUv8/E6wyF1Z97Byxq3rAb23lBKVg8
 549C1fMz22/TEPJMwbxbvl1/nM70aN4UfiN3mz7AEoo7rnDIqgIxhYfPdsRtEE6w3aGn+r
 Wz1uh2EkKKMqrxt1BP9k0YiQLxoYyyU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-D4qw-sQ0NH-AKJ4CFKxZpg-1; Sun, 14 Jan 2024 22:04:09 -0500
X-MC-Unique: D4qw-sQ0NH-AKJ4CFKxZpg-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-28bcf7f605aso7532266a91.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 19:04:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705287848; x=1705892648;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HeNryQTBjaETwLWZ5iiQ3GPgA72vTDuYwve/POTU65A=;
 b=KnFdUoiAcMqPEUjQHFilHO0+7BPDEXn8LuKf2epRIyk90wRnxiT04lIuakHLExUH2i
 Lv5phGqpPe8YYthQdpADxS81Rr3UCV1g/XmPckSOS+CnG5v5lPyL7jXkDTDPxh2xioaw
 F/+kw2y3vLQfnUiBbNoOEChWwBQcqqTa+4epr2I9CIICLQByqclwZjrd8tq/qdMei8FL
 zrMjF1gBPlJ3609wfM62AH7Y71PjAlFi7TkHTrEMMUdqVecWuOJ+1AlY0PHa7T5tsbBm
 R4pAPkO7G/ecLBixkch6NEij2xvBudKaZeUlkMv8BzXnNI+rQco0G0+uFDaMyjnMpHJd
 BxwA==
X-Gm-Message-State: AOJu0Yy6y5UX5Lem/gUxAxel0/ZhIRGuekK+PIfb7qycDI3QQigcTqpC
 nB0O9nVeabt0oWOBUUoaeySI+by50BQKg1UpIC2omr3zZslbW1SlDLwpqVx2afYo9E0bVf2y0oo
 Vs88yzmyXgewJHlwqO+8Ohta2kX+i4wMO2JlXzb8=
X-Received: by 2002:a17:90b:902:b0:28c:caf1:f80b with SMTP id
 bo2-20020a17090b090200b0028ccaf1f80bmr7204594pjb.26.1705287848352; 
 Sun, 14 Jan 2024 19:04:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTFyE1msFCu95JIRDngqChLijrtCAfBQCvLJ0I9/XRTqF3eIQ7ha5R0QcA4so8cftYIEOGzHjyzzIm+W4FQYo=
X-Received: by 2002:a17:90b:902:b0:28c:caf1:f80b with SMTP id
 bo2-20020a17090b090200b0028ccaf1f80bmr7204586pjb.26.1705287848092; Sun, 14
 Jan 2024 19:04:08 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-24-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-24-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Jan 2024 11:03:57 +0800
Message-ID: <CACGkMEsv6efxKPEpnz42sbTx-my8h5D0c2uaPdFxv16CAQQ-MA@mail.gmail.com>
Subject: Re: [PATCH 23/40] vdpa: vhost_vdpa_dma_batch_begin_once rename
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
> No functional changes. Rename only.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  hw/virtio/vhost-vdpa.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 7a1b7f4..a6c6fe5 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -186,7 +186,7 @@ static bool vhost_vdpa_map_batch_begin(VhostVDPAShare=
d *s)
>      return true;
>  }
>
> -static void vhost_vdpa_iotlb_batch_begin_once(VhostVDPAShared *s)
> +static void vhost_vdpa_dma_batch_begin_once(VhostVDPAShared *s)
>  {
>      if (!(s->backend_cap & (0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH)) ||
>          s->iotlb_batch_begin_sent) {
> @@ -411,7 +411,7 @@ static void vhost_vdpa_listener_region_add(MemoryList=
ener *listener,
>          iova =3D mem_region.iova;
>      }
>
> -    vhost_vdpa_iotlb_batch_begin_once(s);
> +    vhost_vdpa_dma_batch_begin_once(s);
>      ret =3D vhost_vdpa_dma_map(s, VHOST_VDPA_GUEST_PA_ASID, iova,
>                               int128_get64(llsize), vaddr, section->reado=
nly);
>      if (ret) {
> @@ -493,7 +493,7 @@ static void vhost_vdpa_listener_region_del(MemoryList=
ener *listener,
>          iova =3D result->iova;
>          vhost_iova_tree_remove(s->iova_tree, *result);
>      }
> -    vhost_vdpa_iotlb_batch_begin_once(s);
> +    vhost_vdpa_dma_batch_begin_once(s);
>      /*
>       * The unmap ioctl doesn't accept a full 64-bit. need to check it
>       */
> @@ -1371,7 +1371,7 @@ static void *vhost_vdpa_load_map(void *opaque)
>                                       msg->iotlb.size);
>              break;
>          case VHOST_IOTLB_BATCH_BEGIN:
> -            vhost_vdpa_iotlb_batch_begin_once(shared);
> +            vhost_vdpa_dma_batch_begin_once(shared);

Nit: "iotlb" seems to be better than "dma" as there's no guarantee
that the underlayer device is using DMA (e.g simulator or VDUSE).

Thanks

>              break;
>          case VHOST_IOTLB_BATCH_END:
>              vhost_vdpa_dma_batch_end_once(shared);
> --
> 1.8.3.1
>


