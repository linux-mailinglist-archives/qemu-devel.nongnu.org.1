Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A20788D9D0
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Mar 2024 10:14:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpPLR-0007Cf-MU; Wed, 27 Mar 2024 05:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rpPLO-0007BR-Mr
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:13:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rpPLL-0001gj-Kb
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:13:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711530787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZaLt+zedyBIKSiNXQl7TPHfyfUuoG392mkgSa8xpnP0=;
 b=Esol6g/ARrzbGSxs8XfvgjF9VYptTgXyAad3xtYiLWF9TjE0oZ6up9y4DQhm6veqTyCG41
 vr5+47CwIxZO93BimkkG9dhVRZwU4sfBedtAQOjM69X9mht5z8JJTdqEfXM6nIGcjxPNAN
 ykOpNi94sV7BE1fcZrm2eRmp3tRx+SQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-9FrCX-qINDGihVXFiG-rKg-1; Wed, 27 Mar 2024 05:13:03 -0400
X-MC-Unique: 9FrCX-qINDGihVXFiG-rKg-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2a04aded772so4227817a91.2
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 02:13:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711530782; x=1712135582;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZaLt+zedyBIKSiNXQl7TPHfyfUuoG392mkgSa8xpnP0=;
 b=XX4MCBE+3JFMMwzG4zUCXLygdDrfdFZsxWYnNC12wQtN+S/glwJMD5Zuo+gPrH3h24
 2nzn2ez7nU6oYaOKvhaBSEm+vJAaWwvwje8z7AuhMVdbqmn9+I3eCpqDS5XrFianUZaD
 GkTx73icSUzhiIlGo154qCzEJmpOrBCQiFOPabNlxTlNYOeCjfjjNwpZJnQ5obdtbih/
 9rvhpZA7CXW70hEp0RXpxhgMotYIWMLXBFkKZrrEjNF2EoWadTUrvZW8uVZDFSVl8hsQ
 8Xd7w46mi/E8/zkDc1YhMIi00sIzyVzen68ljBr3kCkQC6+ZzXwUiLR4TvfZEfkCXOgD
 iDWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzB67J3iTn2Ma5YQUtNBGf11Qm0X0T4jux+2MG0i0uiGITtZ/yhiwpnY7tdz1HL43ZT7VknhzStsztymPMQRqqUXdh/gc=
X-Gm-Message-State: AOJu0YyyS1lopSJDEU7gcrfpBKgwkwZRTQ09OyIQSq5uIu3f9eq8WyCS
 b+oREvtFTgCW1CvjNYHiSuMhEcDwJSJoIP7/1r4yO/yI7lpMNUImXaJjzAbL1RWUnqmOppUL9FS
 0xJwdJlSWUHQ340EvoTM89LGVtHlsFp5us6Ax745pUgHUhQDkimDPJPjq7s0V/NpjGpk3TsT+Qi
 f44nL5iqzuEW+eA4CAU9V3FplW/ZqVk5FzhIA=
X-Received: by 2002:a17:90a:53a1:b0:2a0:591:f52b with SMTP id
 y30-20020a17090a53a100b002a00591f52bmr2081078pjh.48.1711530782189; 
 Wed, 27 Mar 2024 02:13:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7kP0o6FPAuvCjJNWEMcKuLXzNtAJrr0z2Nthg08Jndp0AUTyshW63nR+MBFkAlBh9Y0uN409kc0YF0qIFZbI=
X-Received: by 2002:a17:90a:53a1:b0:2a0:591:f52b with SMTP id
 y30-20020a17090a53a100b002a00591f52bmr2081068pjh.48.1711530781927; Wed, 27
 Mar 2024 02:13:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240327012905.70188-1-lulu@redhat.com>
 <CACGkMEt5fTtwmeb18Yj0xDT_bCjsJQM2nB-u1GJDfFKnEtSSHA@mail.gmail.com>
 <CACLfguVY-yNWDAETt6gpUF7Ce5wbmLVXbpocsm7GW2mKRKukqQ@mail.gmail.com>
 <CACGkMEu67pZKApDkcBi4XSuS+ss001GKyapUkNNkwnSRcgPZqw@mail.gmail.com>
 <CACLfguXFn9aNUwh_aBkNsLZ79EWPRnXRNws95t6ySgE7b+4HPQ@mail.gmail.com>
 <CACGkMEuP71EWSC33gj2diABaDk4sYexBbskq9ZfpZMBoB1aBbQ@mail.gmail.com>
In-Reply-To: <CACGkMEuP71EWSC33gj2diABaDk4sYexBbskq9ZfpZMBoB1aBbQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 27 Mar 2024 17:12:51 +0800
Message-ID: <CACGkMEvRo4Q2Of7cwTNmR6mgapMWYQ79D4fErJ8AoqPrsc+ncA@mail.gmail.com>
Subject: Re: [RFC 0/2] disable the configuration interrupt for the unsupported
 device
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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

On Wed, Mar 27, 2024 at 5:12=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Mar 27, 2024 at 4:28=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > On Wed, Mar 27, 2024 at 3:54=E2=80=AFPM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Wed, Mar 27, 2024 at 2:03=E2=80=AFPM Cindy Lu <lulu@redhat.com> wr=
ote:
> > > >
> > > > On Wed, Mar 27, 2024 at 11:05=E2=80=AFAM Jason Wang <jasowang@redha=
t.com> wrote:
> > > > >
> > > > > Hi Cindy:
> > > > >
> > > > > On Wed, Mar 27, 2024 at 9:29=E2=80=AFAM Cindy Lu <lulu@redhat.com=
> wrote:
> > > > > >
> > > > > > we need a crash in Non-standard image, here is the jira for thi=
s https://issues.redhat.com/browse/RHEL-28522
> > > > > > The root cause of the issue is that an IRQFD was used without i=
nitialization..
> > > > > >
> > > > > > During the booting process of the Vyatta image, the behavior of=
 the called function in qemu is as follows:
> > > > > >
> > > > > > 1. vhost_net_stop() was called, this will call the function
> > > > > > virtio_pci_set_guest_notifiers() with assgin=3D false, and
> > > > > > virtio_pci_set_guest_notifiers(=EF=BC=89 will release the irqfd=
 for vector 0
> > > > >
> > > > > Before vhost_net_stop(), do we know which vector is used by which=
 queue?
> > > > >
> > > > before this stop, vdev->config_verctor is get from
> > > > virtio_pci_common_read/virtio_pci_common_write
> > > > it was set to vector 0
> > >
> > > I basically meant if vector 0 is shared with some virtqueues here.
> > >
> > Really sorry for this, vq's vector is 1,2, and will not share with the
> > configure vector
> > > > > >
> > > > > > 2. virtio_reset() was called -->set configure vector to VIRTIO_=
NO_VECTORt
> > > > > >
> > > > > > 3.vhost_net_start() was called (at this time the configure vect=
or is
> > > > > > still VIRTIO_NO_VECTOR) and call virtio_pci_set_guest_notifiers=
() with
> > > > > > assgin=3D true, so the irqfd for vector 0 was not "init" during=
 this process
> > > > >
> > > > > How does the configure vector differ from the virtqueue vector he=
re?
> > > > >
> > > > All the vectors are VIRTIO_NO_VECTOR (including vq). any
> > > > msix_fire_vector_notifier()
> > > > been called will cause the crash at this time.
> > >
> > > Won't virtio_pci_set_guest_notifiers() will try to allocate irqfd whe=
n
> > > the assignment is true?
> > >
> > It will allocate, but  the vector is VIRTIO_NO_VECTOR (0xffff)
> >
> > then it will called kvm_virtio_pci_vector_use_one()
> >
> > in this function, there is a check for
> >
> >     if (vector >=3D msix_nr_vectors_allocated(dev))
> >
> > {         return 0;     }
> >
> > So it will return.
>
> How about let's just fix this?

Btw, another question, how does vDPA work here?

Thanks

>
> Btw, it's better to explain in detail like the above in the next version.
>
> Thanks
>
> >
> > > > So I think this should
> > > > be a bug in this guest image
> > >
> > > The point is Qemu should not crash even if the guest driver is buggy.
> > >
> > > It would be nice if we can have a qtest for this on top.
> > >
> > > Thanks
> > >
> > sure, got it, I have done the Qtest, and it passed
> > here is the result
> >
> > Ok:                 794
> > Expected Fail:      0
> > Fail:               0
> > Unexpected Pass:    0
> > Skipped:            32
> > Timeout:            0
> >
> > > > > >
> > > > > > 4. The system continues to boot and msix_fire_vector_notifier()=
 was
> > > > > > called unmask the vector 0 and then met the crash
> > > > > > [msix_fire_vector_notifier] 112 called vector 0 is_masked 1
> > > > > > [msix_fire_vector_notifier] 112 called vector 0 is_masked 0
> > > > > >
> > > > > > The reason for not reproducing in RHEL/fedora guest image is be=
cause
> > > > > > REHL/Fedora doesn't have the behavior of calling vhost_net_stop=
 and then virtio_reset, and also won't call msix_fire_vector_notifier for v=
ector 0 during system boot.
> > > > > >
> > > > > > The reason for not reproducing before configure interrupt suppo=
rt is because
> > > > > > vector 0 is for configure interrupt,  before the support for co=
nfigure interrupts, the notifier process will not handle vector 0.
> > > > > >
> > > > > > For the device Vyatta using, it doesn't support configure inter=
rupts at all, So we plan to disable the configure interrupts in unsupported=
 device
> > > > >
> > > > > Btw, let's tweak the changelog, it's a little bit hard to underst=
and.
> > > > >
> > > > sure will do
> > > > thanks
> > > > Cindy
> > > > > Thanks
> > > > >
> > > > > >
> > > > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > > >
> > > > > > Cindy Lu (2):
> > > > > >   virtio-net: disable the configure interrupt for not support d=
evice
> > > > > >   virtio-pci: check if the configure interrupt enable
> > > > > >
> > > > > >  hw/net/virtio-net.c        |  5 ++++-
> > > > > >  hw/virtio/virtio-pci.c     | 41 +++++++++++++++++++++---------=
--------
> > > > > >  hw/virtio/virtio.c         |  1 +
> > > > > >  include/hw/virtio/virtio.h |  1 +
> > > > > >  4 files changed, 29 insertions(+), 19 deletions(-)
> > > > > >
> > > > > > --
> > > > > > 2.43.0
> > > > > >
> > > > >
> > > >
> > >
> >


