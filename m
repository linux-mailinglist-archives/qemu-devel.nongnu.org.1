Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E57F77DF655
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 16:26:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyZZC-00032z-Uo; Thu, 02 Nov 2023 11:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qyZZA-00031g-Pf
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 11:25:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qyZZ8-0006Cf-V0
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 11:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698938701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4jVS1+KEDnc3ZVRXTN8ZvGC4Xwr/qKSsvqw6tI/5aVQ=;
 b=NKvteU+OUBbUoyIItKFS9maNqMlQSUivI3YHbalSVcTIIXDyXJ5SIAF8eVtNXqKWnGo7Ku
 dvfZUbvZ6cgkr4zba2Rye5z9vHMT/+ogMI1rHYp9AfLSYA/QP4WGk3gHNfHUvgImaM6A45
 0rfhCQ4DPTXA0+bFvP9Z/dTN4kd/L+s=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-VdtFse8mOjeF1fQiY8iKhQ-1; Thu, 02 Nov 2023 11:25:00 -0400
X-MC-Unique: VdtFse8mOjeF1fQiY8iKhQ-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-5a7b9e83b70so8641237b3.0
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 08:25:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698938700; x=1699543500;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4jVS1+KEDnc3ZVRXTN8ZvGC4Xwr/qKSsvqw6tI/5aVQ=;
 b=X6m6pWt5Hwmyg3iOwZk8lIRG9iz4iF/qOfPkYOl+6o7/kPEwVCGeHa8KzFrLTorbUi
 KTueOJS87UglSz2oIaoEG3Ssnq4IoeksNo157wz7G5wHXDoGUOr3n0KTNPGeswnoRodY
 HPW3594mpic7gKztSLELKjvmosc4grFnQ+u2GVbIvj9XzZglrESjGfRBB2BkztC1U/tD
 m/ry1OxSrH63fmYc8Y1cA2ZTBZCnasi72/KlLsHnLohAOQbMgiVFQC4iFbxYYw8kFl+C
 0+fQ2LnYX/IMmT5sY/hxAd7nexrdDYEym7S/hHc2mEVMw4FPCZ5gE2TH/3pQjd5gfST9
 N2dA==
X-Gm-Message-State: AOJu0Yzx50JBzW75qFzLlt7GrYJnrzaiJ72nWtv71+7gBpmAU97gLKCJ
 /Wl7VSsMRYnp8PiDes45RdqjSdF7ObfT6hMGXlygEBeUIIgSmKXTd3Gn/o/4mffe9ie6TmyMkiI
 ktSWH7hU3tOUh3mOn76fpQQmVc3fscBk=
X-Received: by 2002:a81:6c90:0:b0:5a7:bc0e:8ce9 with SMTP id
 h138-20020a816c90000000b005a7bc0e8ce9mr25449ywc.24.1698938699609; 
 Thu, 02 Nov 2023 08:24:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGc9u+FJ3i1JZ/WE6jDg6NBKLc6lzOJSbOzwwK7bvp9sNAY6EuJepXQvSJMypuRiMzMA+5puKIplsiGTHWUaU=
X-Received: by 2002:a81:6c90:0:b0:5a7:bc0e:8ce9 with SMTP id
 h138-20020a816c90000000b005a7bc0e8ce9mr25436ywc.24.1698938699383; Thu, 02 Nov
 2023 08:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231019143455.2377694-1-eperezma@redhat.com>
 <20231019143455.2377694-16-eperezma@redhat.com>
 <00fe0c0b-267c-4d1f-8f0c-efdd8c166002@oracle.com>
In-Reply-To: <00fe0c0b-267c-4d1f-8f0c-efdd8c166002@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 2 Nov 2023 16:24:23 +0100
Message-ID: <CAJaqyWeopEAcM6_pA3=wpYujEXZnzYi=N1=AD8qHznZPY+Awjw@mail.gmail.com>
Subject: Re: [RFC PATCH 15/18] vdpa: add vhost_vdpa_load_setup
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: qemu-devel@nongnu.org, Shannon <shannon.nelson@amd.com>, 
 Parav Pandit <parav@mellanox.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, yin31149@gmail.com,
 Jason Wang <jasowang@redhat.com>, 
 Yajun Wu <yajunw@nvidia.com>, Zhu Lingshan <lingshan.zhu@intel.com>, 
 Lei Yang <leiyang@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
 Juan Quintela <quintela@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Gautam Dawar <gdawar@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
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

On Thu, Nov 2, 2023 at 9:49=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
>
>
> On 10/19/2023 7:34 AM, Eugenio P=C3=A9rez wrote:
> > Callers can use this function to setup the incoming migration.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >   include/hw/virtio/vhost-vdpa.h |  7 +++++++
> >   hw/virtio/vhost-vdpa.c         | 17 ++++++++++++++++-
> >   2 files changed, 23 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-v=
dpa.h
> > index 8f54e5edd4..edc08b7a02 100644
> > --- a/include/hw/virtio/vhost-vdpa.h
> > +++ b/include/hw/virtio/vhost-vdpa.h
> > @@ -45,6 +45,12 @@ typedef struct vhost_vdpa_shared {
> >
> >       bool iotlb_batch_begin_sent;
> >
> > +    /*
> > +     * The memory listener has been registered, so DMA maps have been =
sent to
> > +     * the device.
> > +     */
> > +    bool listener_registered;
> > +
> >       /* Vdpa must send shadow addresses as IOTLB key for data queues, =
not GPA */
> >       bool shadow_data;
> >   } VhostVDPAShared;
> > @@ -73,6 +79,7 @@ int vhost_vdpa_dma_map(VhostVDPAShared *s, uint32_t a=
sid, hwaddr iova,
> >                          hwaddr size, void *vaddr, bool readonly);
> >   int vhost_vdpa_dma_unmap(VhostVDPAShared *s, uint32_t asid, hwaddr io=
va,
> >                            hwaddr size);
> > +int vhost_vdpa_load_setup(VhostVDPAShared *s, AddressSpace *dma_as);
> >
> >   typedef struct vdpa_iommu {
> >       VhostVDPAShared *dev_shared;
> > diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> > index cc252fc2d8..bfbe4673af 100644
> > --- a/hw/virtio/vhost-vdpa.c
> > +++ b/hw/virtio/vhost-vdpa.c
> > @@ -1325,7 +1325,9 @@ static int vhost_vdpa_dev_start(struct vhost_dev =
*dev, bool started)
> >                            "IOMMU and try again");
> >               return -1;
> >           }
> > -        memory_listener_register(&v->shared->listener, dev->vdev->dma_=
as);
> > +        if (!v->shared->listener_registered) {
> > +            memory_listener_register(&v->shared->listener, dev->vdev->=
dma_as);
> > +        }
> Set listener_registered to true after registration; in addition, it
> looks like the memory_listener_unregister in vhost_vdpa_reset_status
> doesn't clear the listener_registered flag after unregistration. This
> code path can be called during SVQ switching, if not doing so mapping
> can't be added back after a couple rounds of SVQ switching or live
> migration.
>

That's right, it should be also set to false in the unregister. Thanks
for the catch!

> -Siwei
>
> >
> >           return vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
> >       }
> > @@ -1528,3 +1530,16 @@ const VhostOps vdpa_ops =3D {
> >           .vhost_set_config_call =3D vhost_vdpa_set_config_call,
> >           .vhost_reset_status =3D vhost_vdpa_reset_status,
> >   };
> > +
> > +int vhost_vdpa_load_setup(VhostVDPAShared *shared, AddressSpace *dma_a=
s)
> > +{
> > +    uint8_t s =3D VIRTIO_CONFIG_S_ACKNOWLEDGE | VIRTIO_CONFIG_S_DRIVER=
;
> > +    int r =3D ioctl(shared->device_fd, VHOST_VDPA_SET_STATUS, &s);
> > +    if (unlikely(r < 0)) {
> > +        return r;
> > +    }
> > +
> > +    memory_listener_register(&shared->listener, dma_as);
> > +    shared->listener_registered =3D true;
> > +    return 0;
> > +}
>


