Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AA28197CD
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 05:27:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFoBJ-0007VC-9U; Tue, 19 Dec 2023 23:27:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rFoBH-0007Ul-JH
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 23:27:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rFoBG-0002jL-10
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 23:27:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703046456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xKNdW7amYtQ9aevrvhmoNntr92LvC661LzOWUcY5o5o=;
 b=UeUKoF/yP1OEnMuNaqJODSS5jprIGohcWnr6PLwbp8Cwywb9408ySR0+xpHTk3HqRciE9t
 bDu+c4m4/6To+3Czo29N0RXgD+ucUsrbI4uPb3NfVwrgX9rst7PiTrEQDleKpDAq9TeUX2
 MNCyyKODZb76MYF/O3WXWH8o8NMC4Vw=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-p_tNpe-XNO6NeB49E4OVYw-1; Tue, 19 Dec 2023 23:27:34 -0500
X-MC-Unique: p_tNpe-XNO6NeB49E4OVYw-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3b9eeff9f7bso7289236b6e.1
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 20:27:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703046454; x=1703651254;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xKNdW7amYtQ9aevrvhmoNntr92LvC661LzOWUcY5o5o=;
 b=wK4Ct2p+FWAoqWrDaLTxTiv9tXTUcxcTgp8V3Ybm1RNihftoLSU0v0DcZbffk0Krju
 pcOM+L5pd5d0PqwLSIPQYKRKVMvKEdDxqlPCt5jrFBvGOkBOdvqAQmRFOW5UPFarHCtR
 9aqj9kWpuAq86s1m+MQReXsDdKiiWCbNj0GMnmmjz6fAd0zEsHHddkVbeA66wJvBH43Z
 e5zR2kMVpBV+84kMWGihtUmys2MyfgFovjYy9X/n4RgujpiwB7aCVFM2muFQUjAoGBqe
 iAoBexBudkQw+Gdnvxg51WLjAkpg8ZVSGaWdzFj3tF8CjYNxQnij5VjN2adIBDvhGe5L
 8kLg==
X-Gm-Message-State: AOJu0YyrUeApl8yq94/92puJD+1Qu/317rYyHta7g3lL/6SVagc+51+I
 zwNcDTeFjPLM8jxO4ZbTQKxkGL3z6V1VxTm+LjIEPirbEsX/WyLmvnhj6JcZ2rkntT1MJEUNwUF
 l5fwHoIJK3NLkIEB7mLrwzrgDLencmvs=
X-Received: by 2002:a05:6808:1312:b0:3b9:da28:fed6 with SMTP id
 y18-20020a056808131200b003b9da28fed6mr23909836oiv.71.1703046454083; 
 Tue, 19 Dec 2023 20:27:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHW0ATmpuGbqNa/VQ0FnG6KYx/T4xOGUYE/T5NlGlCZto5/ZrrRt2oNmJ/y8khwXJfCJAEph5KmTvmyNGPULMU=
X-Received: by 2002:a05:6808:1312:b0:3b9:da28:fed6 with SMTP id
 y18-20020a056808131200b003b9da28fed6mr23909815oiv.71.1703046453856; Tue, 19
 Dec 2023 20:27:33 -0800 (PST)
MIME-Version: 1.0
References: <20231215172830.2540987-1-eperezma@redhat.com>
 <20231215172830.2540987-3-eperezma@redhat.com>
In-Reply-To: <20231215172830.2540987-3-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Dec 2023 12:27:22 +0800
Message-ID: <CACGkMEsGcQ4OGY6iOBL4AEDyfF02t4weA1Y65jT0GZRmEnzAuw@mail.gmail.com>
Subject: Re: [PATCH for 9.0 02/12] vdpa: make batch_begin_once early return
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 si-wei.liu@oracle.com, 
 Lei Yang <leiyang@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
 Zhu Lingshan <lingshan.zhu@intel.com>, Parav Pandit <parav@mellanox.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
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

On Sat, Dec 16, 2023 at 1:28=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> Prefer early return so it is easier to merge
> vhost_vdpa_listener_begin_batch here and make iotlb baches begin and end
> symmetrical.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  hw/virtio/vhost-vdpa.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index cc252fc2d8..bf9771870a 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -160,11 +160,12 @@ static void vhost_vdpa_listener_begin_batch(VhostVD=
PAShared *s)
>
>  static void vhost_vdpa_iotlb_batch_begin_once(VhostVDPAShared *s)
>  {
> -    if (s->backend_cap & (0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH) &&
> -        !s->iotlb_batch_begin_sent) {
> -        vhost_vdpa_listener_begin_batch(s);
> +    if (!(s->backend_cap & (0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH)) ||
> +        s->iotlb_batch_begin_sent) {
> +        return;
>      }
>
> +    vhost_vdpa_listener_begin_batch(s);
>      s->iotlb_batch_begin_sent =3D true;
>  }
>
> --
> 2.39.3
>


