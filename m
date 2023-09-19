Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3E07A663A
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 16:12:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qibRE-0003tn-V6; Tue, 19 Sep 2023 10:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qibRC-0003tb-EA
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 10:10:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qibRA-0007pN-Id
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 10:10:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695132604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cyw2KeoOkZC1APyelXrFOmTZsa2l4yh/uDbdLnv/6jQ=;
 b=iDRzEOmQSoHHcAr59SXdL0Fc+qPVO9px18txU9u+3ef71HmeJr0HV1aPX6YsvQ3cEcUB+N
 rgcvT50B03rJzksRgIzp0tAszqmci6hNNXaiHcg7OFdTWi6pZjr5MnFnFUrxvQorpVTwCc
 QI9VPKRWQeeoPaHT67j4ch+LulJ2GVA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-_S6aIuM9O0-Bx1Qj3OJcVQ-1; Tue, 19 Sep 2023 10:10:02 -0400
X-MC-Unique: _S6aIuM9O0-Bx1Qj3OJcVQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9a9f282713fso409134566b.3
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 07:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695132601; x=1695737401;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyw2KeoOkZC1APyelXrFOmTZsa2l4yh/uDbdLnv/6jQ=;
 b=F+8nFMDu9oFMb4fu3SJhtjnRtBunkHKjxLPt9SAS8bjNKxwMfZsYL+zJd3ewqDhtth
 sTF43UmoXLnLTuP+9Uxd6d3V5hPwVmDMOLzapS43RMaOFOfou4NLaaDkz+TV8kmL+wsG
 cw5n+EI8OU5iFtoTQdfAg/ul4ehYY/2+CsiC+Y91vacEuYBWOQl8jfsQWSjAXgM3eSJn
 4Ahu5zkjEdvBcRZ0CpZizxBYBat4kzOPEPoWzhOoOe1IixaUYGb9CGbuDgy+o3xcmBl8
 RIb6CVyzIUQyxuIU/YuvQZJat1BNHV5uHyXW03xQ7cYn/OoUpeClC0ivdv12tDYqgf81
 9RhQ==
X-Gm-Message-State: AOJu0Yw7D33gDusQx/XV5scD/bpP9nesy6DSlVUVhTnDeXxKZDF/suRC
 j6f60s9WZ/1NmAEvIHBQHlToaYqki/zM3xSr+lq6/hzVzvbX7+KVPL4fq5hMh0kNKCpM84s/t81
 GJ6tOeak5GaLoqVM=
X-Received: by 2002:a17:907:7623:b0:9a2:23cd:f052 with SMTP id
 jy3-20020a170907762300b009a223cdf052mr10399387ejc.7.1695132601308; 
 Tue, 19 Sep 2023 07:10:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpgZEgdyo7v1yx6zWKgETwMn6YOu24MmBn1OYcVRXpT5tbMyU+8/PA2n74zv5NYGjCkSJwZw==
X-Received: by 2002:a17:907:7623:b0:9a2:23cd:f052 with SMTP id
 jy3-20020a170907762300b009a223cdf052mr10399352ejc.7.1695132600992; 
 Tue, 19 Sep 2023 07:10:00 -0700 (PDT)
Received: from redhat.com ([2.52.26.122]) by smtp.gmail.com with ESMTPSA id
 gy18-20020a170906f25200b009a9fbeb15f5sm7793339ejb.46.2023.09.19.07.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 07:10:00 -0700 (PDT)
Date: Tue, 19 Sep 2023 10:09:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Jiqian Chen <Jiqian.Chen@amd.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 David Airlie <airlied@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
 Alex Deucher <Alexander.Deucher@amd.com>,
 Christian Koenig <Christian.Koenig@amd.com>,
 Stewart Hildebrand <Stewart.Hildebrand@amd.com>,
 Xenia Ragiadakou <burzalodowa@gmail.com>,
 Honglei Huang <Honglei1.Huang@amd.com>,
 Julia Zhang <Julia.Zhang@amd.com>, Huang Rui <Ray.Huang@amd.com>
Subject: Re: [VIRTIO PCI PATCH v5 1/1] transport-pci: Add freeze_mode to
 virtio_pci_common_cfg
Message-ID: <20230919100855-mutt-send-email-mst@kernel.org>
References: <20230919114242.2283646-1-Jiqian.Chen@amd.com>
 <20230919114242.2283646-2-Jiqian.Chen@amd.com>
 <PH0PR12MB5481C0BE6E076F4EC077C4DDDCFAA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR12MB5481C0BE6E076F4EC077C4DDDCFAA@PH0PR12MB5481.namprd12.prod.outlook.com>
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

On Tue, Sep 19, 2023 at 12:10:29PM +0000, Parav Pandit wrote:
> Hi Jiqian,
> 
> > From: Jiqian Chen <Jiqian.Chen@amd.com>
> > Sent: Tuesday, September 19, 2023 5:13 PM
> > 
> > When guest vm does S3, Qemu will reset and clear some things of virtio
> > devices, but guest can't aware that, so that may cause some problems.
> It is not true that guest VM is not aware of it.
> As you show in your kernel patch, it is freeze/unfreeze in the guest VM PCI PM driver callback. So please update the commit log.
> 
> > For excample, Qemu calls virtio_reset->virtio_gpu_gl_reset when guest
> s/excample/example
> 
> > resume, that function will destroy render resources of virtio-gpu. As a result,
> > after guest resume, the display can't come back and we only saw a black
> > screen. Due to guest can't re-create all the resources, so we need to let Qemu
> > not to destroy them when S3.
> Above QEMU specific details to go in cover letter, instead of commit log, but no strong opinion.

i feel it does not matter much.

> Explaining the use case is good.
> 
> > 
> > For above purpose, we need a mechanism that allows guests and QEMU to
> > negotiate their reset behavior. So this patch add a new parameter named
> Freeze != reset. :)
> Please fix it to say freeze or suspend.
> 
> > freeze_mode to struct virtio_pci_common_cfg. And when guest suspends, it can
> > write freeze_mode to be FREEZE_S3, and then virtio devices can change their
> > reset behavior on Qemu side according to freeze_mode. What's more,
> Not reset, but suspend behavior.
> 
> > freeze_mode can be used for all virtio devices to affect the behavior of Qemu,
> > not just virtio gpu device.
> > 
> > Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> > ---
> >  transport-pci.tex | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/transport-pci.tex b/transport-pci.tex index a5c6719..2543536 100644
> > --- a/transport-pci.tex
> > +++ b/transport-pci.tex
> > @@ -319,6 +319,7 @@ \subsubsection{Common configuration structure
> > layout}\label{sec:Virtio Transport
> >          le64 queue_desc;                /* read-write */
> >          le64 queue_driver;              /* read-write */
> >          le64 queue_device;              /* read-write */
> > +        le16 freeze_mode;               /* read-write */
> >          le16 queue_notif_config_data;   /* read-only for driver */
> >          le16 queue_reset;               /* read-write */
> > 
> The new field cannot be in the middle of the structure.
> Otherwise, the location of the queue_notif_config_data depends on completely unrelated feature bit, breaking the backward compatibility.
> So please move it at the end.
> 
> > @@ -393,6 +394,12 @@ \subsubsection{Common configuration structure
> > layout}\label{sec:Virtio Transport  \item[\field{queue_device}]
> >          The driver writes the physical address of Device Area here.  See section
> > \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}.
> > 
> > +\item[\field{freeze_mode}]
> > +        The driver writes this to set the freeze mode of virtio pci.
> > +        VIRTIO_PCI_FREEZE_MODE_UNFREEZE - virtio-pci is running;
> > +        VIRTIO_PCI_FREEZE_MODE_FREEZE_S3 - guest vm is doing S3, and virtio-
> For above names, please define the actual values in the spec.
> 
> > pci enters S3 suspension;
> > +        Other values are reserved for future use, like S4, etc.
> > +
> It cannot be just one way communication from driver to device as freezing the device of few hundred MB to GB of gpu memory or other device memory can take several msec.
> Hence driver must poll to get the acknowledgement from the device that freeze functionality is completed.
> 
> Please refer to queue_reset register definition for achieving such scheme and reframe the wording for it.
> 
> Also kindly add the device and driver normative on how/when this register is accessed.
> 
> Also please fix the description to not talk about guest VM. Largely it only exists in theory of operation etc text.
> 
> You need to describe what exactly should happen in the device when its freeze.
> Please refer to my series where infrastructure is added for device migration where the FREEZE mode behavior is defined.
> It is similar to what you define, but its management plane operation controlled outside of the guest VM.
> But it is good direction in terms of what to define in spec language.
> https://lore.kernel.org/virtio-comment/20230909142911.524407-7-parav@nvidia.com/T/#u
> 
> you are missing the feature bit to indicate to the driver that device supports this functionality.
> Please add one.
> 
> >  \item[\field{queue_notif_config_data}]
> >          This field exists only if VIRTIO_F_NOTIF_CONFIG_DATA has been
> > negotiated.
> >          The driver will use this value when driver sends available buffer
> > --
> > 2.34.1


