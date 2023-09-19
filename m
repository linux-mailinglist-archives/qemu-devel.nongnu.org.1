Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88ED07A630A
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 14:32:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiZt0-0005Gu-4e; Tue, 19 Sep 2023 08:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qiZsx-0005Fh-0v
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 08:31:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qiZsv-00084l-5T
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 08:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695126680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=foEuGHpN02cZZRHgVG6c0QInXgm/KQsAjoIQJjUhPEM=;
 b=AVFiLqXrgTsI4Ysbsa7Do2cHKkSp7DDim9cMo6ytztdNnYNdATtI0WUdlVg+RBlxy7Sc3f
 YQqOzuJpr3s8OV+Q8E6wrzOFBzFP2CGTtcB0lxIODQzg4MTaS81OSJEs+YjTytKpUPWnj3
 RFc8vO6uoYX1swpBuwl56aUzB27f+Fw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-t9ZSJbEOPJmrw-mZ0U6T1w-1; Tue, 19 Sep 2023 08:31:18 -0400
X-MC-Unique: t9ZSJbEOPJmrw-mZ0U6T1w-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9a9e3f703dfso410298666b.1
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 05:31:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695126677; x=1695731477;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=foEuGHpN02cZZRHgVG6c0QInXgm/KQsAjoIQJjUhPEM=;
 b=EL65mVLCJnVLvz75Sd7juyYvMr4UXNx0e4e2djSiEkSpieq6a0bkvfaDK9WQYvRamD
 mIZPIQltP3DAyUNkF07JmxTgVmX9ClxgijXtmatT5Ae34ole761z15jiov3gSiCSiGqq
 dnXgOT6WxigmJDTF7rD0XJEIn5tte6oSf8sTncjMiJTUZy2941XBwItHbwwtN9Ge9Egt
 fhN1gdlweED89qNagK1L1BvnjpKip0cVRxFP62ctlZU/NptlBnEDVUKtSYM8IlsXW6hW
 +0WgdGvpmV30ZTO+osQHO7KD9nFMRPRs+IgJoGOYB5QAqu2n0zyV6kiIX4sXpkb7gLcm
 tM+g==
X-Gm-Message-State: AOJu0YwEKZXOKqYpjGs503ki883QKcsuGi3GoLJNdSj3ld5n/EuCIw7t
 XEoFzgrXf6lFFTO60SXGakH6j120qKiLFPS6K93CfwHC7ZGfhQ/fp6wkIc81NzTzZmgh34mfSNC
 RS163XKOTTauQ950=
X-Received: by 2002:a17:907:7622:b0:9a1:e994:3444 with SMTP id
 jy2-20020a170907762200b009a1e9943444mr9781228ejc.3.1695126677426; 
 Tue, 19 Sep 2023 05:31:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEb3B61aTdbbapBWgqBDzul7TRECZ9JfP3c02/1NZo6uc1VdIFZ3t0h1Xm1oeTneoLXE2/ODQ==
X-Received: by 2002:a17:907:7622:b0:9a1:e994:3444 with SMTP id
 jy2-20020a170907762200b009a1e9943444mr9781216ejc.3.1695126677126; 
 Tue, 19 Sep 2023 05:31:17 -0700 (PDT)
Received: from redhat.com ([2.52.26.122]) by smtp.gmail.com with ESMTPSA id
 e7-20020a1709067e0700b0099bd0b5a2bcsm7759563ejr.101.2023.09.19.05.31.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 05:31:16 -0700 (PDT)
Date: Tue, 19 Sep 2023 08:31:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiqian Chen <Jiqian.Chen@amd.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, David Airlie <airlied@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
 Parav Pandit <parav@nvidia.com>, virtio-comment@lists.oasis-open.org,
 virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
 linux-kernel@vger.kernel.org, Stefano Stabellini <sstabellini@kernel.org>,
 Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
 Alex Deucher <Alexander.Deucher@amd.com>,
 Christian Koenig <Christian.Koenig@amd.com>,
 Stewart Hildebrand <Stewart.Hildebrand@amd.com>,
 Xenia Ragiadakou <burzalodowa@gmail.com>,
 Honglei Huang <Honglei1.Huang@amd.com>,
 Julia Zhang <Julia.Zhang@amd.com>, Huang Rui <Ray.Huang@amd.com>
Subject: Re: [VIRTIO PCI PATCH v5 1/1] transport-pci: Add freeze_mode to
 virtio_pci_common_cfg
Message-ID: <20230919082802-mutt-send-email-mst@kernel.org>
References: <20230919114242.2283646-1-Jiqian.Chen@amd.com>
 <20230919114242.2283646-2-Jiqian.Chen@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919114242.2283646-2-Jiqian.Chen@amd.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Tue, Sep 19, 2023 at 07:42:42PM +0800, Jiqian Chen wrote:
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
> @@ -319,6 +319,7 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>          le64 queue_desc;                /* read-write */
>          le64 queue_driver;              /* read-write */
>          le64 queue_device;              /* read-write */
> +        le16 freeze_mode;               /* read-write */
>          le16 queue_notif_config_data;   /* read-only for driver */
>          le16 queue_reset;               /* read-write */
>

we can't add fields in the middle of the structure like this -
offset of queue_notif_config_data and queue_reset changes.

  
> @@ -393,6 +394,12 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>  \item[\field{queue_device}]
>          The driver writes the physical address of Device Area here.  See section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}.
>  
> +\item[\field{freeze_mode}]
> +        The driver writes this to set the freeze mode of virtio pci.
> +        VIRTIO_PCI_FREEZE_MODE_UNFREEZE - virtio-pci is running;
> +        VIRTIO_PCI_FREEZE_MODE_FREEZE_S3 - guest vm is doing S3, and virtio-pci enters S3 suspension;
> +        Other values are reserved for future use, like S4, etc.
> +

we need to specify these values then.

we also need
- feature bit to detect support for S3
- conformance statements documenting behavious under S3


>  \item[\field{queue_notif_config_data}]
>          This field exists only if VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated.
>          The driver will use this value when driver sends available buffer
> -- 
> 2.34.1


