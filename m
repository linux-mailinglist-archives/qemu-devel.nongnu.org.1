Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA617AA744
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 05:19:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjWg0-000227-Tc; Thu, 21 Sep 2023 23:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qjWfz-00021l-CT
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 23:17:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qjWfx-0004Lr-AX
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 23:17:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695352671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VKRFydK7gHJIGc1An0jO34UIyrf6X6QxSb8Wda3PFS4=;
 b=SLqm9b9JeLb5cLUaGKGSDCESjE/sQwdFHMzBCIpS8m6nJaiWBvWuLRunn6sTtQdi2z44sj
 QRi+tB/VnZXVQcQg1ERfJ822Qf+/7YWeaYIV/XmiyA9IVDklpdTgOdJvKK7PB9VWPCLYMG
 puz2Ua6xnfVnpPDxLDrqqHyD3nqXE+g=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-1UikpufSMZuvckqg-AI1Tg-1; Thu, 21 Sep 2023 23:17:49 -0400
X-MC-Unique: 1UikpufSMZuvckqg-AI1Tg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-50433ca6d81so914652e87.3
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 20:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695352668; x=1695957468;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VKRFydK7gHJIGc1An0jO34UIyrf6X6QxSb8Wda3PFS4=;
 b=IxmeLh2AYM9hLI3wwC6Sf7e3qmePDMQTiSTi3m7EcwS2n0sXrA0ydj4aHXwFZI1M2h
 f9EVdtIJ9cAOpK7JJ9baxacry7U1dD0D3PrpwN6hnnZ/8+Ee2p0azgPHJYKoTxmS6JbN
 pJ2ZhagYh13HvyRDH/iqVZGKOPLhtoUjggaNMpjP0x7773Ofs9drBafo3IhKN3SHk1cf
 rTVgFmCOKDKxpDKTwPnNgBVdu4E5e3bKBYbG0reXL4EVoKUmJHJu4OrQv6CmstH03o7K
 butyPQUhyKuspJE9wwyR42IhK7MO2Pi9DPhG0zFithGiOJb4aDbg+gc9i617/KEa5Oo4
 RlpA==
X-Gm-Message-State: AOJu0Yx/eOOqn43ySX0F1myGz1rtf6AvxzgNEBTkZMkSYgezsFGhvXr3
 vvknpnn3yUjxZupj8YtS/3oiYLF76+2fesfQGASlfHR5Nz/aNf4f9MV5ZkT22Yk4QMtuiLkC14I
 UlfC502CL3yQZL+CA8y3aKyObPbqWp0k=
X-Received: by 2002:a05:6512:b21:b0:503:3278:3221 with SMTP id
 w33-20020a0565120b2100b0050332783221mr7377465lfu.69.1695352667964; 
 Thu, 21 Sep 2023 20:17:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6jLFAWQobQu7YJsr0/J9NeK5RMThuSKcfHKr41/y/dxVLwUK0Y97f/SS/vWZNDHC+0xxpwdioFz9c/eyEV7A=
X-Received: by 2002:a05:6512:b21:b0:503:3278:3221 with SMTP id
 w33-20020a0565120b2100b0050332783221mr7377433lfu.69.1695352667519; Thu, 21
 Sep 2023 20:17:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230919114242.2283646-1-Jiqian.Chen@amd.com>
 <20230919114242.2283646-2-Jiqian.Chen@amd.com>
 <CACGkMEuEXk2UzXU7sFUk-nHEeE7QoB3kbjnHgktY7KWuK71Xrg@mail.gmail.com>
 <BL1PR12MB58490A484087B2B2C37B6E43E7F8A@BL1PR12MB5849.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB58490A484087B2B2C37B6E43E7F8A@BL1PR12MB5849.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Sep 2023 11:17:35 +0800
Message-ID: <CACGkMEtx-i_9dgdONFzEmmWYNRhaoJQZX7a5OmLfDvGoUaajPQ@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [VIRTIO PCI PATCH v5 1/1] transport-pci: Add
 freeze_mode to virtio_pci_common_cfg
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, David Airlie <airlied@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, 
 Robert Beckett <bob.beckett@collabora.com>, 
 Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
 Parav Pandit <parav@nvidia.com>, 
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, 
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Stefano Stabellini <sstabellini@kernel.org>, 
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, 
 "Hildebrand, Stewart" <Stewart.Hildebrand@amd.com>,
 Xenia Ragiadakou <burzalodowa@gmail.com>, 
 "Huang, Honglei1" <Honglei1.Huang@amd.com>, "Zhang,
 Julia" <Julia.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Sep 21, 2023 at 2:28=E2=80=AFPM Chen, Jiqian <Jiqian.Chen@amd.com> =
wrote:
>
> Hi Jason,
>
> On 2023/9/21 12:22, Jason Wang wrote:
> > On Tue, Sep 19, 2023 at 7:43=E2=80=AFPM Jiqian Chen <Jiqian.Chen@amd.co=
m> wrote:
> >>
> >> When guest vm does S3, Qemu will reset and clear some things of virtio
> >> devices, but guest can't aware that, so that may cause some problems.
> >> For excample, Qemu calls virtio_reset->virtio_gpu_gl_reset when guest
> >> resume, that function will destroy render resources of virtio-gpu. As
> >> a result, after guest resume, the display can't come back and we only
> >> saw a black screen. Due to guest can't re-create all the resources, so
> >> we need to let Qemu not to destroy them when S3.
> >>
> >> For above purpose, we need a mechanism that allows guests and QEMU to
> >> negotiate their reset behavior. So this patch add a new parameter
> >> named freeze_mode to struct virtio_pci_common_cfg. And when guest
> >> suspends, it can write freeze_mode to be FREEZE_S3, and then virtio
> >> devices can change their reset behavior on Qemu side according to
> >> freeze_mode. What's more, freeze_mode can be used for all virtio
> >> devices to affect the behavior of Qemu, not just virtio gpu device.
> >
> > A simple question, why is this issue specific to pci?
> I thought you possibly missed the previous version patches. At the beginn=
ing, I just wanted to add a new feature flag VIRTIO_GPU_F_FREEZE_S3 for vir=
tio-gpu since I encountered virtio-gpu issue during guest S3, so that the g=
uest and qemu can negotiate and change the reset behavior during S3. But Pa=
rav and Mikhail hoped me can improve the feature to a pci level, then other=
 virtio devices can also benefit from it. Although I am not sure if expandi=
ng its influence is appropriate, I have not received any feedback from othe=
rs, so I change it to the pci level and made this version.
> If you are interested, please see the previous version: https://lists.oas=
is-open.org/archives/virtio-comment/202307/msg00209.html, thank you.

This is not a good answer. Let me ask you differently, why don't you
see it in other forms of transport like virtio-gpu-mmio?

Thanks

>
> >
> > Thanks
> >
> >
> >>
> >> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> >> ---
> >>  transport-pci.tex | 7 +++++++
> >>  1 file changed, 7 insertions(+)
> >>
> >> diff --git a/transport-pci.tex b/transport-pci.tex
> >> index a5c6719..2543536 100644
> >> --- a/transport-pci.tex
> >> +++ b/transport-pci.tex
> >> @@ -319,6 +319,7 @@ \subsubsection{Common configuration structure layo=
ut}\label{sec:Virtio Transport
> >>          le64 queue_desc;                /* read-write */
> >>          le64 queue_driver;              /* read-write */
> >>          le64 queue_device;              /* read-write */
> >> +        le16 freeze_mode;               /* read-write */
> >>          le16 queue_notif_config_data;   /* read-only for driver */
> >>          le16 queue_reset;               /* read-write */
> >>
> >> @@ -393,6 +394,12 @@ \subsubsection{Common configuration structure lay=
out}\label{sec:Virtio Transport
> >>  \item[\field{queue_device}]
> >>          The driver writes the physical address of Device Area here.  =
See section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}.
> >>
> >> +\item[\field{freeze_mode}]
> >> +        The driver writes this to set the freeze mode of virtio pci.
> >> +        VIRTIO_PCI_FREEZE_MODE_UNFREEZE - virtio-pci is running;
> >> +        VIRTIO_PCI_FREEZE_MODE_FREEZE_S3 - guest vm is doing S3, and =
virtio-pci enters S3 suspension;
> >> +        Other values are reserved for future use, like S4, etc.
> >> +
> >>  \item[\field{queue_notif_config_data}]
> >>          This field exists only if VIRTIO_F_NOTIF_CONFIG_DATA has been=
 negotiated.
> >>          The driver will use this value when driver sends available bu=
ffer
> >> --
> >> 2.34.1
> >>
> >
> >
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> >
>
> --
> Best regards,
> Jiqian Chen.


