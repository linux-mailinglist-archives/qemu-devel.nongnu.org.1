Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF7D7A9171
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 06:24:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjBDf-0004FR-1m; Thu, 21 Sep 2023 00:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qjBDc-0004F4-Oe
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 00:23:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qjBDa-0005ZY-UY
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 00:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695270189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a/TUqywb80X2AZJMzYZES4VoyIivqwNd2hjQ6BBMthY=;
 b=NgE/Pq3HmvXWIEibosUoMKqitTpWWzEX6uCtwzN+ydDtSX7B/KC0x7XZXnB+WT/jdRm3+e
 21Rm0fqmrr/Mt/lCjKErLwZlL3Kcb4wd7DFtPj0+pNTjhWoc2LUWzFSc+52kkERYH2MsH8
 vYOWXM7bFE+ETVkqWgxES9e2qKL+Eso=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-JtoPYH40PhquC1iP2cKHOA-1; Thu, 21 Sep 2023 00:23:07 -0400
X-MC-Unique: JtoPYH40PhquC1iP2cKHOA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5041bddcedaso692403e87.3
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 21:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695270186; x=1695874986;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a/TUqywb80X2AZJMzYZES4VoyIivqwNd2hjQ6BBMthY=;
 b=gkNM2UWQ7P15XjuhdFZDbJ2bIahdPtfoYOXR6A6zF51fIdNGh0PuSCWRnALGvzePrb
 iochVs2QPPmFvCaLXi2pqRgMj7DEkp0BZYDcKxXtwVDl24hMTczKhENZGZ+SymyE6GOA
 A7Rbc/4zHB7EovazGsx2RmS2VZJFoK1CWz3TNBB4pAECBET9AKZP85s0yTMx1WglNVhG
 JixY2n5BtM6/HV3JkmQjy6evqmYe2zyL+JeAs42tgxNl97XIkYe+5UN9G26yIM6mwZ2q
 rwyWppRZJMUzZ7ehu9PThpzcdEsg5a6cavdI9fWYeUU99HH3puvZP1F9TFZqp70f/aFH
 GGJA==
X-Gm-Message-State: AOJu0YxS+0d6YH0evSnAnQeo9erT5fjNUtab8uExm34iHFrshd5/NYEM
 x1alJ3yZ7BMVAc3rsPXkxiDQUyiUIAQcFL53ph8kZj31FPF42iu2+sVCeHOx4aVl+uL/jqp0/U5
 i0A2kmrYYaxj1Oe9Cw5u1NKFPkiPBzuA=
X-Received: by 2002:a05:6512:20c7:b0:500:7696:200 with SMTP id
 u7-20020a05651220c700b0050076960200mr3691372lfr.59.1695270185948; 
 Wed, 20 Sep 2023 21:23:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBGVyyX13pZa+3Ktq9xbUVd38RjeljW6H0syjIQrHGw1bASMEAYrUUNaIJURxjwOkNsl2CINr8g7Gw+zy70OM=
X-Received: by 2002:a05:6512:20c7:b0:500:7696:200 with SMTP id
 u7-20020a05651220c700b0050076960200mr3691353lfr.59.1695270185578; Wed, 20 Sep
 2023 21:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230919114242.2283646-1-Jiqian.Chen@amd.com>
 <20230919114242.2283646-2-Jiqian.Chen@amd.com>
In-Reply-To: <20230919114242.2283646-2-Jiqian.Chen@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 21 Sep 2023 12:22:54 +0800
Message-ID: <CACGkMEuEXk2UzXU7sFUk-nHEeE7QoB3kbjnHgktY7KWuK71Xrg@mail.gmail.com>
Subject: Re: [VIRTIO PCI PATCH v5 1/1] transport-pci: Add freeze_mode to
 virtio_pci_common_cfg
To: Jiqian Chen <Jiqian.Chen@amd.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, David Airlie <airlied@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, 
 Robert Beckett <bob.beckett@collabora.com>, 
 Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
 Parav Pandit <parav@nvidia.com>, 
 virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, 
 qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, 
 Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Alex Deucher <Alexander.Deucher@amd.com>,
 Christian Koenig <Christian.Koenig@amd.com>, 
 Stewart Hildebrand <Stewart.Hildebrand@amd.com>,
 Xenia Ragiadakou <burzalodowa@gmail.com>, 
 Honglei Huang <Honglei1.Huang@amd.com>, Julia Zhang <Julia.Zhang@amd.com>, 
 Huang Rui <Ray.Huang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 19, 2023 at 7:43=E2=80=AFPM Jiqian Chen <Jiqian.Chen@amd.com> w=
rote:
>
> When guest vm does S3, Qemu will reset and clear some things of virtio
> devices, but guest can't aware that, so that may cause some problems.
> For excample, Qemu calls virtio_reset->virtio_gpu_gl_reset when guest
> resume, that function will destroy render resources of virtio-gpu. As
> a result, after guest resume, the display can't come back and we only
> saw a black screen. Due to guest can't re-create all the resources, so
> we need to let Qemu not to destroy them when S3.
>
> For above purpose, we need a mechanism that allows guests and QEMU to
> negotiate their reset behavior. So this patch add a new parameter
> named freeze_mode to struct virtio_pci_common_cfg. And when guest
> suspends, it can write freeze_mode to be FREEZE_S3, and then virtio
> devices can change their reset behavior on Qemu side according to
> freeze_mode. What's more, freeze_mode can be used for all virtio
> devices to affect the behavior of Qemu, not just virtio gpu device.

A simple question, why is this issue specific to pci?

Thanks


>
> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> ---
>  transport-pci.tex | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/transport-pci.tex b/transport-pci.tex
> index a5c6719..2543536 100644
> --- a/transport-pci.tex
> +++ b/transport-pci.tex
> @@ -319,6 +319,7 @@ \subsubsection{Common configuration structure layout}=
\label{sec:Virtio Transport
>          le64 queue_desc;                /* read-write */
>          le64 queue_driver;              /* read-write */
>          le64 queue_device;              /* read-write */
> +        le16 freeze_mode;               /* read-write */
>          le16 queue_notif_config_data;   /* read-only for driver */
>          le16 queue_reset;               /* read-write */
>
> @@ -393,6 +394,12 @@ \subsubsection{Common configuration structure layout=
}\label{sec:Virtio Transport
>  \item[\field{queue_device}]
>          The driver writes the physical address of Device Area here.  See=
 section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}.
>
> +\item[\field{freeze_mode}]
> +        The driver writes this to set the freeze mode of virtio pci.
> +        VIRTIO_PCI_FREEZE_MODE_UNFREEZE - virtio-pci is running;
> +        VIRTIO_PCI_FREEZE_MODE_FREEZE_S3 - guest vm is doing S3, and vir=
tio-pci enters S3 suspension;
> +        Other values are reserved for future use, like S4, etc.
> +
>  \item[\field{queue_notif_config_data}]
>          This field exists only if VIRTIO_F_NOTIF_CONFIG_DATA has been ne=
gotiated.
>          The driver will use this value when driver sends available buffe=
r
> --
> 2.34.1
>


