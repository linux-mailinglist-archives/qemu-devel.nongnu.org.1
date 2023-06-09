Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66697728E79
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 05:19:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Se6-000238-DU; Thu, 08 Jun 2023 23:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q7Se3-00022V-Vl
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 23:18:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q7Se2-00005a-3O
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 23:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686280713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lnAdG5gz2YP/8csSYd/5w262BTtMWvmGWMy10fROmxw=;
 b=ftE97aW7tB5W/f6HMepAya6JylajKhl1Uo1SRbPtb6k90moCLGUUYv29kybMH2WkPY9ZhU
 YUEzaIA8Txl6dJOkr1x/jMYle+eXJO5or0lGCAD3vdT+JLF74sMKVu9iqgrsQh8h08tNH4
 +MebWXCc2mvjcVFRu9ALML933fmIE+4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-k8iS9REJOtmg3zJC64xDag-1; Thu, 08 Jun 2023 23:18:31 -0400
X-MC-Unique: k8iS9REJOtmg3zJC64xDag-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4f6461620fcso1268292e87.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 20:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686280710; x=1688872710;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lnAdG5gz2YP/8csSYd/5w262BTtMWvmGWMy10fROmxw=;
 b=azK9/T7QcQ5eE3NFRdecjVNTbXTy0QRYlq2wnTSQTwkRXzj50+LPy66rG7pDoolCUr
 GyFK1C2aRNe4JOGAxPS/Da909Zi8xNf1pHRk5xu8+gIusxO8CXoNQ8bsVsrY3/ANfKwB
 fUk8s2ubc1NtfgGJNHDfgBl/3af9Rmq4RN7evjvxi10pzpdUfVIkT0Dj2igA3ct+bogZ
 BgI2hCi/5tWr8fuglgcu5mx9/PhhqesBOGNQFmjGAwr/Wdk8elOjktQvFjenD41gr4kJ
 HHbyMvWKI4iIKI7K7rrqheDcziE4/hrH4HMUu3XlEtl+eeqElC7iEYH85RgI7RNQKeqU
 G3Pw==
X-Gm-Message-State: AC+VfDyH+dJFCKiQiHADRMat3MLDaCUaXXXK3ElSTWluPReL3sNcCqKD
 PZNqMT5JYNQHqIJGlyNG8E+ahjaGzCJae0rDLFH7s6krY573EkqEqBJNnev6wUM65XbudRFdeAb
 7FNu4RxeC7OZ3TudkX9nUOjWGbzMysh1E50bBnss=
X-Received: by 2002:a05:6512:551:b0:4ee:e0c7:434d with SMTP id
 h17-20020a056512055100b004eee0c7434dmr72266lfl.51.1686280709834; 
 Thu, 08 Jun 2023 20:18:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4/JJFYRuYRVVzZ1zS2kkdYLuWFXkn9CYRomm2X2J3HVf+n+VPK0mQgsLZ+kVGbevvpmDT7iKGRYdRwvKqrpSE=
X-Received: by 2002:a05:6512:551:b0:4ee:e0c7:434d with SMTP id
 h17-20020a056512055100b004eee0c7434dmr72254lfl.51.1686280709466; Thu, 08 Jun
 2023 20:18:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAJaqyWdV6pKP0SVZciMiu_HN86aJriZh0HBiwHNkO7+yErXnBA@mail.gmail.com>
 <c59d2d67-d31a-b6e6-54c5-5b81c18d9547@oracle.com>
 <CAJaqyWegsVHEVZt2_mf4wA8MuF7UXmU=UbHJfwyzURDRxfRgmg@mail.gmail.com>
 <bff286b8-0103-1698-c77d-736417396405@oracle.com>
In-Reply-To: <bff286b8-0103-1698-c77d-736417396405@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 9 Jun 2023 11:18:18 +0800
Message-ID: <CACGkMEtFDPbJuSMUjrTKctJ8MpogeKPi3PXxNsQJA0fZO77k1w@mail.gmail.com>
Subject: Re: Reducing vdpa migration downtime because of memory pin / maps
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>, 
 Michael Tsirkin <mst@redhat.com>, Longpeng <longpeng2@huawei.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, Eli Cohen <elic@nvidia.com>, 
 Parav Pandit <parav@nvidia.com>, Juan Quintela <quintela@redhat.com>, 
 David Gilbert <dgilbert@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jun 9, 2023 at 6:39=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
>
> On 6/7/23 01:08, Eugenio Perez Martin wrote:
> > On Wed, Jun 7, 2023 at 12:43=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.c=
om> wrote:
> >> Sorry for reviving this old thread, I lost the best timing to follow u=
p
> >> on this while I was on vacation. I have been working on this and found
> >> out some discrepancy, please see below.
> >>
> >> On 4/5/23 04:37, Eugenio Perez Martin wrote:
> >>> Hi!
> >>>
> >>> As mentioned in the last upstream virtio-networking meeting, one of
> >>> the factors that adds more downtime to migration is the handling of
> >>> the guest memory (pin, map, etc). At this moment this handling is
> >>> bound to the virtio life cycle (DRIVER_OK, RESET). In that sense, the
> >>> destination device waits until all the guest memory / state is
> >>> migrated to start pinning all the memory.
> >>>
> >>> The proposal is to bind it to the char device life cycle (open vs
> >>> close),
> >> Hmmm, really? If it's the life cycle for char device, the next guest /
> >> qemu launch on the same vhost-vdpa device node won't make it work.
> >>
> > Maybe my sentence was not accurate, but I think we're on the same page =
here.
> >
> > Two qemu instances opening the same char device at the same time are
> > not allowed, and vhost_vdpa_release clean all the maps. So the next
> > qemu that opens the char device should see a clean device anyway.
>
> I mean the pin can't be done at the time of char device open, where the
> user address space is not known/bound yet. The earliest point possible
> for pinning would be until the vhost_attach_mm() call from SET_OWNER is
> done. Actually I think the counterpart vhost_detach_mm() only gets
> handled in vhost_vdpa_release() at device close time is a resulting
> artifact and amiss of today's vhost protocol - the opposite RESET_OWNER
> call is not made mandatory hence only seen implemented in vhost-net
> device today. One qemu instance could well exec(3) another new qemu
> instance to live upgrade itself while keeping all emulated devices and
> guest alive. The current vhost design simply prohibits this from happenin=
g.

I'm not sure I fully understand the issue you mention here. What is
missed and can iommufd help anyhow?

>
>
> >
> >>>    so all the guest memory can be pinned for all the guest / qemu
> >>> lifecycle.
> >> I think to tie pinning to guest / qemu process life cycle makes more
> >> sense. Essentially this pinning part needs to be decoupled from the
> >> iotlb mapping abstraction layer, and can / should work as a standalone
> >> uAPI. Such that QEMU at the destination may launch and pin all guest's
> >> memory as needed without having to start the device, while awaiting an=
y
> >> incoming migration request. Though problem is, there's no existing vho=
st
> >> uAPI that could properly serve as the vehicle for that. SET_OWNER /
> >> SET_MEM_TABLE / RESET_OWNER seems a remote fit.. Any objection against
> >> introducing a new but clean vhost uAPI for pinning guest pages, subjec=
t
> >> to guest's life cycle?
> >>
> > I think that to pin or not pin memory maps should be a kernel
> > decision, not to be driven by qemu.
>
> It's kernel decision for sure. I am with this part.
>
> > I'm not against it if needed, but
> > let me know if the current "clean at close" address your concerns.
>
> To better facilitate QEMU exec (live update) case, I propose we add new
> vhost uAPI pair for explicit pinning request - which would live with
> user mm's, or more precisely qemu instance's lifecycle.

Is this something similar to iommufd?

Btw, I'm not sure whether or not it's good to expose pinning to the
userspace. For example, vhost allows virtual mapping instead of dma
mapping which doesn't require pinning at all.

Thanks

>
> >
> >> Another concern is the use_va stuff, originally it tags to the device
> >> level and is made static at the time of device instantiation, which is
> >> fine. But others to come just find a new home at per-group level or
> >> per-vq level struct. Hard to tell whether or not pinning is actually
> >> needed for the latter use_va friends, as they are essentially tied to
> >> the virtio life cycle or feature negotiation. While guest / Qemu start=
s
> >> way earlier than that. Perhaps just ignore those sub-device level use_=
va
> >> usages? Presumably !use_va at the device level is sufficient to infer
> >> the need of pinning for device?
> >>
> > I don't follow this. But I have the feeling that the subject of my
> > original mail is way more accurate if I would have said just "memory
> > maps".
>
> I think the iotlb layer in vhost-vdpa just provides the abstraction for
> mapping, not pinning. Although in some case mapping implicitly relies on
> pinning for DMA purpose, it doesn't have to tie to that in uAPI
> semantics. We can do explicit on-demand pinning for cases for e.g.
> warming up device at live migration destination.
>
>
> >
> > I still consider the way to fix it is to actually delegate that to the
> > kernel vdpa, so it can choose if a particular ASID needs the pin or
> > not. But let me know if I missed something.
>
> You can disregard this for now. I will discuss that further with you
> guys while bind_mm and per-group use_va stuffs are landed.
>
> Thanks!
> -Siwei
>
>
>
> >
> > Thanks!
> >
> >> Regards,
> >> -Siwei
> >>
> >>
> >>> This has two main problems:
> >>> * At this moment the reset semantics forces the vdpa device to unmap
> >>> all the memory. So this change needs a vhost vdpa feature flag.
> >>> * This may increase the initialization time. Maybe we can delay it if
> >>> qemu is not the destination of a LM. Anyway I think this should be
> >>> done as an optimization on top.
> >>>
> >>> Any ideas or comments in this regard?
> >>>
> >>> Thanks!
> >>>
>


