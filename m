Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C427FEA5A
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 09:21:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8cHO-00060v-F9; Thu, 30 Nov 2023 03:20:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1r8cHD-0005yo-4J
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 03:20:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1r8cHB-0005kZ-As
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 03:20:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701332399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vao3xtTTAlcSbq/grqz6O93EWvfGjuoxcyLhVhtbBLc=;
 b=IZUAKevdVcsfIUncEgPAv7h81b/i3+9HBK2hjizJmDaBfev/IYhU6lRfZ64fxhrd3Uaedg
 UqOxzFtxi3xe9OLMGaKNNxEf70QfiVw4qNOwOczOVGBjc2q54heWCxVULFGlUow+teAn9P
 WvGBFjY4hSOUxe+0/mH2YZ9QdQbwUZs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-bpkydpHNNAC2MZPC3E_WyQ-1; Thu, 30 Nov 2023 03:19:58 -0500
X-MC-Unique: bpkydpHNNAC2MZPC3E_WyQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a01a0032b19so62247366b.2
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 00:19:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701332397; x=1701937197;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vao3xtTTAlcSbq/grqz6O93EWvfGjuoxcyLhVhtbBLc=;
 b=t5cYxwBTvT4aO+5Q4IfPTAtGu/mq6sQ6HJV+D72xP0S7hg9WqeYCT9s+/qaSX0JasF
 4qLAlS4Prjw3YsGIl4wwho/yttst2mPJ+B7I2qSkZTGhvc8IYVfEeZdz1FIK4PHMwv0z
 UUlk7deDGwlcFIm87BQ1UYkq//UkoHgmGkVB+n47frOBAp4Icq84fiTwd+rzI+k8Wjix
 LscdZwefe2hwol9VKepU5XddSKqZhDe/djfsTwZU5h2QJ0/gcC642K5E4cpwJ3vnBkQX
 zYu4rb4P3HgRUEfosKybZaG1SnOMxAkqEtb55bv0DAssjmLRMSAgIujHtjKZlHJqLsO7
 nsXQ==
X-Gm-Message-State: AOJu0YyvCY7uDLtU88/N2Uw7O/3f76zHKBIE+zS98drFfNqZmSAhOQ2B
 F8KbacAgK6W8+tr3RlZ9jloP96FP+l8kOKdXzKK7Ow4fFoA6xR/pOYEGuQY7+iQKybn+RXEFkcj
 ndcH03tdeWtkd5efK4DfpQQGSn+DVCks=
X-Received: by 2002:a17:906:3fc3:b0:9f7:b852:f807 with SMTP id
 k3-20020a1709063fc300b009f7b852f807mr12124219ejj.9.1701332397234; 
 Thu, 30 Nov 2023 00:19:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxmgrmwMMT/pb4MOp/QpF6rNcJYkayAA/NozHqFXNQFPsfOqG1ZcPfRb6rLvySuDUEyqhjFPn73lBtQZKZ6K0=
X-Received: by 2002:a17:906:3fc3:b0:9f7:b852:f807 with SMTP id
 k3-20020a1709063fc300b009f7b852f807mr12124212ejj.9.1701332396914; Thu, 30 Nov
 2023 00:19:56 -0800 (PST)
MIME-Version: 1.0
References: <20231124171430.2964464-1-eperezma@redhat.com>
 <CAPpAL=zdLeiEdNdBBuB1uJPoEdng-G4biLVzq-qrx9XZCut1fg@mail.gmail.com>
 <CAJaqyWf4bxUdzjDFUzXq8saqBqU4RtCH3tx6QNJVMTM7+8bG2w@mail.gmail.com>
In-Reply-To: <CAJaqyWf4bxUdzjDFUzXq8saqBqU4RtCH3tx6QNJVMTM7+8bG2w@mail.gmail.com>
From: Lei Yang <leiyang@redhat.com>
Date: Thu, 30 Nov 2023 16:19:20 +0800
Message-ID: <CAPpAL=ybUgSTumBgJzxz_DNbriXv9u7BWzhA17ugEDNYZ0bm6g@mail.gmail.com>
Subject: Re: [PATCH 9.0 00/13] Consolidate common vdpa members in
 VhostVDPAShared
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Parav Pandit <parav@mellanox.com>,
 si-wei.liu@oracle.com, 
 Stefano Garzarella <sgarzare@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Nov 30, 2023 at 3:38=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Thu, Nov 30, 2023 at 4:22=E2=80=AFAM Lei Yang <leiyang@redhat.com> wro=
te:
> >
> > Hi Eugenio
> >
> > QE performed regression testing after applying this patch. This series
> > patch introduced a qemu core dump bug, for the core dump information
> > please review the attached file.
> >
>
> Hi Lei, thank you very much for the testing!
>
Hi Eugenio

> Can you describe the test steps that lead to the crash? I think you
> removed the vdpa device via QMP, but I'd like to be sure.

Yes, you're right, the core dump occurs when hot unplug nic, please
review the following simple test steps:
Test Steps:
1. create two vdpa device(vdpa0 and vdpa1) with multi queues
2. Boot a guest with vdpa0
3. set_link false to vdpa0
4. hotplug vdpa1
5. stop and resume guest via QMP
6. hotunplug vdpa1, hit core dump in this time

Thanks
Lei
>
> Thanks!
>
> > Tested-by: Lei Yang <leiyang@redhat.com>
> >
> >
> >
> >
> > On Sat, Nov 25, 2023 at 1:14=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@re=
dhat.com> wrote:
> > >
> > > Current memory operations like pinning may take a lot of time at the
> > > destination.  Currently they are done after the source of the migrati=
on is
> > > stopped, and before the workload is resumed at the destination.  This=
 is a
> > > period where neigher traffic can flow, nor the VM workload can contin=
ue
> > > (downtime).
> > >
> > > We can do better as we know the memory layout of the guest RAM at the
> > > destination from the moment the migration starts.  Moving that operat=
ion allows
> > > QEMU to communicate the kernel the maps while the workload is still r=
unning in
> > > the source, so Linux can start mapping them.  Ideally, all IOMMU is c=
onfigured,
> > > but if the vDPA parent driver uses on-chip IOMMU and .set_map we're s=
till
> > > saving all the pinning time.
> > >
> > > This is a first required step to consolidate all the members in a com=
mon
> > > struct.  This is needed because the destination does not know what vh=
ost_vdpa
> > > struct will have the registered listener member, so it is easier to p=
lace them
> > > in a shared struct rather to keep them in vhost_vdpa struct.
> > >
> > > v1 from RFC:
> > > * Fix vhost_vdpa_net_cvq_start checking for always_svq instead of
> > >   shadow_data.  This could cause CVQ not being shadowed if
> > >   vhost_vdpa_net_cvq_start was called in the middle of a migration.
> > >
> > > Eugenio P=C3=A9rez (13):
> > >   vdpa: add VhostVDPAShared
> > >   vdpa: move iova tree to the shared struct
> > >   vdpa: move iova_range to vhost_vdpa_shared
> > >   vdpa: move shadow_data to vhost_vdpa_shared
> > >   vdpa: use vdpa shared for tracing
> > >   vdpa: move file descriptor to vhost_vdpa_shared
> > >   vdpa: move iotlb_batch_begin_sent to vhost_vdpa_shared
> > >   vdpa: move backend_cap to vhost_vdpa_shared
> > >   vdpa: remove msg type of vhost_vdpa
> > >   vdpa: move iommu_list to vhost_vdpa_shared
> > >   vdpa: use VhostVDPAShared in vdpa_dma_map and unmap
> > >   vdpa: use dev_shared in vdpa_iommu
> > >   vdpa: move memory listener to vhost_vdpa_shared
> > >
> > >  include/hw/virtio/vhost-vdpa.h |  36 +++++---
> > >  hw/virtio/vdpa-dev.c           |   7 +-
> > >  hw/virtio/vhost-vdpa.c         | 160 +++++++++++++++++--------------=
--
> > >  net/vhost-vdpa.c               | 117 ++++++++++++------------
> > >  hw/virtio/trace-events         |  14 +--
> > >  5 files changed, 174 insertions(+), 160 deletions(-)
> > >
> > > --
> > > 2.39.3
> > >
> > >
>


