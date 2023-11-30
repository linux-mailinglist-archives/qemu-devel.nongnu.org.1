Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4D67FE9D6
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 08:39:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8bdP-0006WF-JF; Thu, 30 Nov 2023 02:38:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1r8bdJ-0006Pk-Rq
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 02:38:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1r8bdH-0005sp-LI
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 02:38:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701329926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PJ7V3XGg2pJkcRCSQWYobMi9OztoILc07P5ro/6dVfU=;
 b=Rce74pMHWWPh9bcfKNJr3tg3iefiptkiMd9s4IzIwetORvJ51TR+v/+WP+fBFAGGyWeUCq
 SGc014vp/ngbWiX10YPXKgNvbShbEPT6aU1TyVVHc1uxXk36up+OAYMN1gJ3Q+MTe0alba
 XTiCbDmbLiL1E9AjfwBQ86qB+HMuoB0=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-v16eG4Z4PzOI9F4eVoWSOw-1; Thu, 30 Nov 2023 02:38:43 -0500
X-MC-Unique: v16eG4Z4PzOI9F4eVoWSOw-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-5d340a9cf07so7142587b3.3
 for <qemu-devel@nongnu.org>; Wed, 29 Nov 2023 23:38:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701329923; x=1701934723;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PJ7V3XGg2pJkcRCSQWYobMi9OztoILc07P5ro/6dVfU=;
 b=u0GNtPSx7p7Xjo26s6r+3f4+BQmORDVIDo8XDJ3ocLFSOVjYOz/86vSvR1Zr8qEDQ9
 PDHRZEn/aEdS8kflF3iygzBR5WBDar9TWdfRaioyteG/ylXd5dI22PGH12pm7U7ABx3C
 H5MWdBsGVKipf8w29gHoE4E9JM/Wgef3ccqkV18aFX3iZLTQZEJzrMw9o9sSMtQ5DnV+
 n3JhIjAXo5JysQ+09SC55fiNUvp1rKf4NMOC1cDuAxeoYeee36CK9AChHhDM6S71gh9U
 x/SoieNdphYAGG7ykaW8w74qFTZtrvRKcakrwoNj9mkg+NefACdbxk4QOwfv328vHB9V
 uTfA==
X-Gm-Message-State: AOJu0YzlpN3T1lGjmisqKUp75mIg0EDUIzO5X7g43qvBQbfWpERwpFgN
 C1OpEBvBO8W8pL1/2FJqtsrN1bpBy/KWtwibLIdoYuZ6KUlFFJQekeEiSP0eh7UxDS3aPURUsIC
 45rZKs/9xe4A/Op+LIyuFDii8iZjvaPg=
X-Received: by 2002:a05:690c:408c:b0:5ce:eba2:90df with SMTP id
 gb12-20020a05690c408c00b005ceeba290dfmr15055151ywb.3.1701329923281; 
 Wed, 29 Nov 2023 23:38:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGXULb41pJ5TDRR2RvJFkZ3/AAq2ErDVwPIM6d1+ZVTpSML+WbN8WWRpSIc9Lckn4E+ve+jDyieqGRTo2ou/w=
X-Received: by 2002:a05:690c:408c:b0:5ce:eba2:90df with SMTP id
 gb12-20020a05690c408c00b005ceeba290dfmr15055140ywb.3.1701329923018; Wed, 29
 Nov 2023 23:38:43 -0800 (PST)
MIME-Version: 1.0
References: <20231124171430.2964464-1-eperezma@redhat.com>
 <CAPpAL=zdLeiEdNdBBuB1uJPoEdng-G4biLVzq-qrx9XZCut1fg@mail.gmail.com>
In-Reply-To: <CAPpAL=zdLeiEdNdBBuB1uJPoEdng-G4biLVzq-qrx9XZCut1fg@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 30 Nov 2023 08:38:06 +0100
Message-ID: <CAJaqyWf4bxUdzjDFUzXq8saqBqU4RtCH3tx6QNJVMTM7+8bG2w@mail.gmail.com>
Subject: Re: [PATCH 9.0 00/13] Consolidate common vdpa members in
 VhostVDPAShared
To: Lei Yang <leiyang@redhat.com>
Cc: qemu-devel@nongnu.org, Parav Pandit <parav@mellanox.com>,
 si-wei.liu@oracle.com, 
 Stefano Garzarella <sgarzare@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, Laurent Vivier <lvivier@redhat.com>
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

On Thu, Nov 30, 2023 at 4:22=E2=80=AFAM Lei Yang <leiyang@redhat.com> wrote=
:
>
> Hi Eugenio
>
> QE performed regression testing after applying this patch. This series
> patch introduced a qemu core dump bug, for the core dump information
> please review the attached file.
>

Hi Lei, thank you very much for the testing!

Can you describe the test steps that lead to the crash? I think you
removed the vdpa device via QMP, but I'd like to be sure.

Thanks!

> Tested-by: Lei Yang <leiyang@redhat.com>
>
>
>
>
> On Sat, Nov 25, 2023 at 1:14=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redh=
at.com> wrote:
> >
> > Current memory operations like pinning may take a lot of time at the
> > destination.  Currently they are done after the source of the migration=
 is
> > stopped, and before the workload is resumed at the destination.  This i=
s a
> > period where neigher traffic can flow, nor the VM workload can continue
> > (downtime).
> >
> > We can do better as we know the memory layout of the guest RAM at the
> > destination from the moment the migration starts.  Moving that operatio=
n allows
> > QEMU to communicate the kernel the maps while the workload is still run=
ning in
> > the source, so Linux can start mapping them.  Ideally, all IOMMU is con=
figured,
> > but if the vDPA parent driver uses on-chip IOMMU and .set_map we're sti=
ll
> > saving all the pinning time.
> >
> > This is a first required step to consolidate all the members in a commo=
n
> > struct.  This is needed because the destination does not know what vhos=
t_vdpa
> > struct will have the registered listener member, so it is easier to pla=
ce them
> > in a shared struct rather to keep them in vhost_vdpa struct.
> >
> > v1 from RFC:
> > * Fix vhost_vdpa_net_cvq_start checking for always_svq instead of
> >   shadow_data.  This could cause CVQ not being shadowed if
> >   vhost_vdpa_net_cvq_start was called in the middle of a migration.
> >
> > Eugenio P=C3=A9rez (13):
> >   vdpa: add VhostVDPAShared
> >   vdpa: move iova tree to the shared struct
> >   vdpa: move iova_range to vhost_vdpa_shared
> >   vdpa: move shadow_data to vhost_vdpa_shared
> >   vdpa: use vdpa shared for tracing
> >   vdpa: move file descriptor to vhost_vdpa_shared
> >   vdpa: move iotlb_batch_begin_sent to vhost_vdpa_shared
> >   vdpa: move backend_cap to vhost_vdpa_shared
> >   vdpa: remove msg type of vhost_vdpa
> >   vdpa: move iommu_list to vhost_vdpa_shared
> >   vdpa: use VhostVDPAShared in vdpa_dma_map and unmap
> >   vdpa: use dev_shared in vdpa_iommu
> >   vdpa: move memory listener to vhost_vdpa_shared
> >
> >  include/hw/virtio/vhost-vdpa.h |  36 +++++---
> >  hw/virtio/vdpa-dev.c           |   7 +-
> >  hw/virtio/vhost-vdpa.c         | 160 +++++++++++++++++----------------
> >  net/vhost-vdpa.c               | 117 ++++++++++++------------
> >  hw/virtio/trace-events         |  14 +--
> >  5 files changed, 174 insertions(+), 160 deletions(-)
> >
> > --
> > 2.39.3
> >
> >


