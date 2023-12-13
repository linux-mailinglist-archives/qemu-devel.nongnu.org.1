Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E48318117CE
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 16:43:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDRO1-0007aO-FT; Wed, 13 Dec 2023 10:43:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rDRNz-0007aA-FW
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 10:42:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rDRNx-0006Md-UU
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 10:42:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702482177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=avW1iJFADqxomXg2zsUWlg5wOJUqIcmW9S6e5Y7qxCg=;
 b=MvbJPOltZgL19qUgE73eVq162/4GYfQWL2AxnlMTUW6D6M9R2Rb943WxJIndhO3oLms7Bz
 F0PdpLxFBxJoGkwmVep0XB+B2xzpZJC5XvzAx1ChPdlic514NMj/ETyBssT2YqvqH1dKsf
 pcaIf8kRIm7xo0zsUeJ9Luu2cc4Mwww=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-UFfTEjITN0CWxa5IO8iXyA-1; Wed, 13 Dec 2023 10:42:55 -0500
X-MC-Unique: UFfTEjITN0CWxa5IO8iXyA-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-dbcc8f895daso1341964276.2
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 07:42:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702482175; x=1703086975;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=avW1iJFADqxomXg2zsUWlg5wOJUqIcmW9S6e5Y7qxCg=;
 b=sSF2eid36WeQqStaNMUAWRKR7/TgnoJ8RoT1dmIQSVWONtNzs4AONsL8TKBu4AUyDL
 7amh437zNdQ4APw2ivPsjgujesQgD05Ix66vWHhDMRnUMQ5Bd1YzUTPF9iLNxP1Ehh+V
 X/Oy2fWkt1Cw3enDuRhIbz126nZOZNt/qcreKeDx5WeU4BMic2GFAiLfUvy9Oysctv8m
 PKeTF/adj/KAbkAi4aQIa5lzcwAesERl6BRRtjzeEsUomIfxBiq6J3vQzKHjarQP87rH
 zMHju0eiyx6w9RN2nBhl3nYResO67w4MJvtYZLtFzSaqF7Ws5xFtFydSvUNQzhJbOrKt
 azCA==
X-Gm-Message-State: AOJu0Yxk0o+RlLDjTIc1H34+3HoZt9T+/RQbQ2WSkOYlcZ2V28J6O3h1
 tvh02dhUoLlFUz1RJ+6xAFpyHJRxtNA0moHJsKYWF6aPFCRVvZVcPUgXj3c+6BDe4TP4CNSe73A
 5QQephzG3gSsAJZ57jU2C911N9Idqku8=
X-Received: by 2002:a5b:82:0:b0:db7:dad0:76ce with SMTP id
 b2-20020a5b0082000000b00db7dad076cemr4884035ybp.106.1702482175119; 
 Wed, 13 Dec 2023 07:42:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/khN9ZfYJk0rpsGOWHxoM1EFVjPc/iCEVQ45viietWPVTpNjHqOlBYHWV3/VvRXcD2NkazMEX6wgvfj5hMKw=
X-Received: by 2002:a5b:82:0:b0:db7:dad0:76ce with SMTP id
 b2-20020a5b0082000000b00db7dad076cemr4884018ybp.106.1702482174866; 
 Wed, 13 Dec 2023 07:42:54 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-29-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-29-git-send-email-si-wei.liu@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 13 Dec 2023 16:42:19 +0100
Message-ID: <CAJaqyWeDBkW=LhdY4gVtrK2nN0he+s=XJkokPdQDkqf4Qec-mw@mail.gmail.com>
Subject: Re: [PATCH 28/40] vdpa: support iotlb_batch_asid
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
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Dec 7, 2023 at 7:51=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
> Then it's possible to specify ASID when calling the DMA
> batching API. If the ASID to work on doesn't align with
> the ASID for ongoing transaction, the API will fail the
> request and return negative, and the transaction will
> remain intact as if no failed request ever had occured.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  hw/virtio/vhost-vdpa.c         | 25 +++++++++++++++++++------
>  include/hw/virtio/vhost-vdpa.h |  1 +
>  net/vhost-vdpa.c               |  1 +
>  3 files changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index d3f5721..b7896a8 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -189,15 +189,25 @@ static bool vhost_vdpa_map_batch_begin(VhostVDPASha=
red *s, uint32_t asid)
>
>  static int vhost_vdpa_dma_batch_begin_once(VhostVDPAShared *s, uint32_t =
asid)
>  {
> -    if (!(s->backend_cap & (0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH)) ||
> -        s->iotlb_batch_begin_sent) {
> +    if (!(s->backend_cap & (0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH))) {
>          return 0;
>      }
>
> -    if (vhost_vdpa_map_batch_begin(s, asid)) {
> -        s->iotlb_batch_begin_sent =3D true;
> +    if (s->iotlb_batch_begin_sent && s->iotlb_batch_asid !=3D asid) {
> +        return -1;
> +    }
> +
> +    if (s->iotlb_batch_begin_sent) {
> +        return 0;
>      }
>
> +    if (!vhost_vdpa_map_batch_begin(s, asid)) {
> +        return 0;
> +    }
> +
> +    s->iotlb_batch_begin_sent =3D true;
> +    s->iotlb_batch_asid =3D asid;
> +
>      return 0;
>  }
>
> @@ -237,10 +247,13 @@ static int vhost_vdpa_dma_batch_end_once(VhostVDPAS=
hared *s, uint32_t asid)
>          return 0;
>      }
>
> -    if (vhost_vdpa_dma_batch_end(s, asid)) {
> -        s->iotlb_batch_begin_sent =3D false;
> +    if (!vhost_vdpa_dma_batch_end(s, asid)) {
> +        return 0;
>      }
>
> +    s->iotlb_batch_begin_sent =3D false;
> +    s->iotlb_batch_asid =3D -1;

If we define -1 as "not in batch", iotlb_batch_begin_sent is
redundant. Can we "#define IOTLB_NOT_IN_BATCH -1" and remove
iotlb_batch_begin_sent?

> +
>      return 0;
>  }
>
> diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdp=
a.h
> index 0fe0f60..219316f 100644
> --- a/include/hw/virtio/vhost-vdpa.h
> +++ b/include/hw/virtio/vhost-vdpa.h
> @@ -61,6 +61,7 @@ typedef struct vhost_vdpa_shared {
>      bool map_thread_enabled;
>
>      bool iotlb_batch_begin_sent;
> +    uint32_t iotlb_batch_asid;
>
>      /*
>       * The memory listener has been registered, so DMA maps have been se=
nt to
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index e9b96ed..bc72345 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -1933,6 +1933,7 @@ static NetClientState *net_vhost_vdpa_init(NetClien=
tState *peer,
>          s->vhost_vdpa.shared->device_fd =3D vdpa_device_fd;
>          s->vhost_vdpa.shared->iova_range =3D iova_range;
>          s->vhost_vdpa.shared->shadow_data =3D svq;
> +        s->vhost_vdpa.shared->iotlb_batch_asid =3D -1;
>          s->vhost_vdpa.shared->refcnt++;
>      } else if (!is_datapath) {
>          s->cvq_cmd_out_buffer =3D mmap(NULL, vhost_vdpa_net_cvq_cmd_page=
_len(),
> --
> 1.8.3.1
>


