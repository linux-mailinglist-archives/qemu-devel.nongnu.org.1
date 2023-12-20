Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D748197D2
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 05:32:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFoF1-0000e9-LG; Tue, 19 Dec 2023 23:31:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rFoEx-0000ch-3P
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 23:31:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rFoEv-00042Q-Lq
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 23:31:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703046684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nJc17jCqClqXbrg9t13BvDN+6HeiP71wIMRTtTDfplI=;
 b=W7AQf/m+0DGXt+Kmzsh/cmaA8/o7IiyOWL7xBzTfrGI6zH4RaB/ZZile3U07qTnBgyXg3j
 40I4xg5snculxWa8nEIT0sDW0V7KHpzPjWFSXc7qPANug/wpJm0tZ+kb4S5oVV9s1gWwgT
 cKQi/8xiwdgifECVAnNqEbB9QISqk5g=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-X9mEGFAhMO-1ilGUELHIYg-1; Tue, 19 Dec 2023 23:31:23 -0500
X-MC-Unique: X9mEGFAhMO-1ilGUELHIYg-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5c668dc7f7bso4745470a12.3
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 20:31:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703046682; x=1703651482;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nJc17jCqClqXbrg9t13BvDN+6HeiP71wIMRTtTDfplI=;
 b=EXXuO+vqFS4NtyEO2KmAh7C2FuGfAGVRi6ciZdXSj2ZakxPYLHFb8s3SsoODx0Tm+8
 KPCz18UdI9gJE6v2m2z6HNz47W73jrU0S6QPVijIS7qVp0AYu5r11P3TxXF1K+hqLftR
 ND6crT/bBYAci5mPjCHZjrz2xN89EsPf1meh8+TdmNXOsolhros1vct0iS5/zXkTO0i9
 Qt5o46IFcOjC/YrRS+mz13u1Cut27lu4JJwu6+lonAEa20DR5Re0w/BcvaOWuSWTnSR5
 81oJhiQbPxf4GjMNApHhyruSGsGCktnIX9bX4AW1m3l7tXznvrCfyXz40Zj5YqrbNfPb
 2d1g==
X-Gm-Message-State: AOJu0Yzr/0ITt7XOQEYpERYKx+2C2z40Nl9/lofou7qV5pMZ4lo0VPFc
 bcVkpP0lidJm24oSd81elmcrzZzVL5C6MtO/AqyVFPzTbbaHwGKb5R0wbl6Q1UfiZ/+9JAMSX+1
 kenmYDTZQ19Klt+aC9LUezCXx/RltWxM=
X-Received: by 2002:a05:6a20:8410:b0:18f:a271:31ac with SMTP id
 c16-20020a056a20841000b0018fa27131acmr24287153pzd.85.1703046682379; 
 Tue, 19 Dec 2023 20:31:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHak/94oLP9eIc0vpyYAPQXMCzR8ncYGvtEobbeHHFiXd1U6BMbLTzpcUDBqKrQlPD1H9z+oaxGKqMS5mww3Zw=
X-Received: by 2002:a05:6a20:8410:b0:18f:a271:31ac with SMTP id
 c16-20020a056a20841000b0018fa27131acmr24287140pzd.85.1703046682102; Tue, 19
 Dec 2023 20:31:22 -0800 (PST)
MIME-Version: 1.0
References: <20231215172830.2540987-1-eperezma@redhat.com>
 <20231215172830.2540987-5-eperezma@redhat.com>
In-Reply-To: <20231215172830.2540987-5-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Dec 2023 12:31:11 +0800
Message-ID: <CACGkMEv1vfutqRwpBS-vpXHDA25yCFC3EiYjx467GHjZ3ihhnQ@mail.gmail.com>
Subject: Re: [PATCH for 9.0 04/12] vdpa: extract out _dma_end_batch from
 _listener_commit
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
> So we can call out vhost_vdpa_dma_end_batch out of the listener
> callbacks.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  hw/virtio/vhost-vdpa.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index a533fc5bc7..57a8043cd4 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -164,9 +164,8 @@ static void vhost_vdpa_iotlb_batch_begin_once(VhostVD=
PAShared *s)
>      s->iotlb_batch_begin_sent =3D true;
>  }
>
> -static void vhost_vdpa_listener_commit(MemoryListener *listener)
> +static void vhost_vdpa_dma_end_batch(VhostVDPAShared *s)
>  {
> -    VhostVDPAShared *s =3D container_of(listener, VhostVDPAShared, liste=
ner);
>      struct vhost_msg_v2 msg =3D {};
>      int fd =3D s->device_fd;
>
> @@ -190,6 +189,13 @@ static void vhost_vdpa_listener_commit(MemoryListene=
r *listener)
>      s->iotlb_batch_begin_sent =3D false;
>  }
>
> +static void vhost_vdpa_listener_commit(MemoryListener *listener)
> +{
> +    VhostVDPAShared *s =3D container_of(listener, VhostVDPAShared, liste=
ner);
> +
> +    vhost_vdpa_dma_end_batch(s);
> +}
> +
>  static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry =
*iotlb)
>  {
>      struct vdpa_iommu *iommu =3D container_of(n, struct vdpa_iommu, n);
> --
> 2.39.3
>


