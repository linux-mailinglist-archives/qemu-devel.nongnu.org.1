Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C8981B037
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 09:21:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGEJ1-0007JA-SF; Thu, 21 Dec 2023 03:21:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rGEJ0-0007J2-6f
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 03:21:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rGEIy-00005k-9d
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 03:21:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703146879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bfbAUrbJDj1ev6ga85HtR44TX08+YxNj4+3zH/3B/Bo=;
 b=WWy2mCWIzv2pTLufK7ndqFXaYNY7+6PHv1mI7JvST3ayt3aAXrjSQ67UkRHdcFOCc+iDo2
 yRHJLMC+bfqtTDU1iY30IP3AZkIl8Gm4WdIIzzg+PNy1jmkOUj1QhPzWzP5CJaUjj3ClX7
 l4/puZN734YGXkHZhMfAu450HbbyheY=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-LRY7mfXgMESL-tGslxum2w-1; Thu, 21 Dec 2023 03:21:17 -0500
X-MC-Unique: LRY7mfXgMESL-tGslxum2w-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-dbdb0a29f8cso640530276.3
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 00:21:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703146877; x=1703751677;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bfbAUrbJDj1ev6ga85HtR44TX08+YxNj4+3zH/3B/Bo=;
 b=sXcw6FF1esg5hNtjgB/lossbztlSzlPZVo7QchXGuBOKwnBdXjJObO/4R7FJevBRxC
 F9LBNC05GjVAkngNqeRW20p9hTnDcs2JzJ22BOQZGw9V0mMyHgvseECyiLspcOV1475W
 RJMfG4bfIW+rTSFHdJgPkQafM9VynMe5JVyPtCVlEUOqfq6AZilbERbMnnieixi3t3S6
 lEZ+RAPoOHJIecd1kmTx2ks6o/99JLjinR0po4PXgrNSHlUpsTdYfgv6leBHfdgGiRtY
 emNBFrd0Gyffj4ZjXW3AznyttmeIyxIcYuJwzDpoAo3rAQSgVxBbVVm6WJ8epfmoMJui
 Ma9g==
X-Gm-Message-State: AOJu0YwH3hh/E+EpPRjhK8vq8/McWyyNnMfdwaTVttp/tZQHBHEyFNGi
 PttxPLaUcCTGsby6n/tG7833pZ39/AULjV9vlHl9PiBFwaNx+bnICUEpxXvpph7FK8acYR3GWNY
 OPv5pDsPbgV+pmZ8VH1lo11kCo3XSbME=
X-Received: by 2002:a25:c792:0:b0:dbd:ae2d:d5f3 with SMTP id
 w140-20020a25c792000000b00dbdae2dd5f3mr869595ybe.39.1703146877084; 
 Thu, 21 Dec 2023 00:21:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKfFQRh8iftOGVpKazwWg8ENw8LM0rND32jxfnx1uOMx5VwIqrsx7wrqHtHhJKQcAcllXOiF8mCC7MOddgG+g=
X-Received: by 2002:a25:c792:0:b0:dbd:ae2d:d5f3 with SMTP id
 w140-20020a25c792000000b00dbdae2dd5f3mr869581ybe.39.1703146876813; Thu, 21
 Dec 2023 00:21:16 -0800 (PST)
MIME-Version: 1.0
References: <20231215172830.2540987-1-eperezma@redhat.com>
 <20231215172830.2540987-9-eperezma@redhat.com>
 <CACGkMEvH=uU4QxMHVHTo5tQiuML2+NTE3gZssfz84-+4kGHa1Q@mail.gmail.com>
 <CAJaqyWczW+uwYBsWas97JY6OgiSurnvNQnnTYPFWv5La55GOOg@mail.gmail.com>
 <CACGkMEukZNUnXRSwpVAROe7U7GzkubP9i37ev+qOSQvWxLEK_Q@mail.gmail.com>
In-Reply-To: <CACGkMEukZNUnXRSwpVAROe7U7GzkubP9i37ev+qOSQvWxLEK_Q@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 21 Dec 2023 09:20:40 +0100
Message-ID: <CAJaqyWfGkboB4sN0PSukKx1kAV-QQ_YSWXWvksPScBD9OgHRsQ@mail.gmail.com>
Subject: Re: [PATCH for 9.0 08/12] vdpa: add vhost_vdpa_load_setup
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 si-wei.liu@oracle.com, 
 Lei Yang <leiyang@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
 Zhu Lingshan <lingshan.zhu@intel.com>, Parav Pandit <parav@mellanox.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
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

On Thu, Dec 21, 2023 at 3:17=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Dec 20, 2023 at 3:07=E2=80=AFPM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Wed, Dec 20, 2023 at 6:22=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Sat, Dec 16, 2023 at 1:28=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@=
redhat.com> wrote:
> > > >
> > > > Callers can use this function to setup the incoming migration threa=
d.
> > > >
> > > > This thread is able to map the guest memory while the migration is
> > > > ongoing, without blocking QMP or other important tasks. While this
> > > > allows the destination QEMU not to block, it expands the mapping ti=
me
> > > > during migration instead of making it pre-migration.
> > >
> > > If it's just QMP, can we simply use bh with a quota here?
> > >
> >
> > Because QEMU cannot guarantee the quota at write(fd,
> > VHOST_IOTLB_UPDATE, ...).
>
> So you mean the delay may be caused by a single syscall?
>

Mostly yes, the iotlb write() that maps of all the guest memory.

> > Also, synchronization with
> > vhost_vdpa_dev_start would complicate as it would need to be
> > re-scheduled too.
>
> Just a flush of the bh, or not?
>

Let me put it differently: to map the guest memory, vhost_vdpa_dma_map
is called because the guest starts the device by a PCI write to the
device status:
#0  vhost_vdpa_dma_map (s=3D0x5555570e0e60, asid=3D0, iova=3D0, size=3D7864=
32,
vaddr=3D0x7fff40000000, readonly=3Dfalse)
    at ../hw/virtio/vhost-vdpa.c:93
#1  0x0000555555979451 in vhost_vdpa_listener_region_add
(listener=3D0x5555570e0e68, section=3D0x7fffee5bc0d0) at
../hw/virtio/vhost-vdpa.c:415
#2  0x0000555555b3c543 in listener_add_address_space
(listener=3D0x5555570e0e68, as=3D0x555556db72e0 <address_space_memory>)
    at ../system/memory.c:3011
#3  0x0000555555b3c996 in memory_listener_register
(listener=3D0x5555570e0e68, as=3D0x555556db72e0 <address_space_memory>)
    at ../system/memory.c:3081
#4  0x000055555597be03 in vhost_vdpa_dev_start (dev=3D0x5555570e1310,
started=3Dtrue) at ../hw/virtio/vhost-vdpa.c:1460
#5  0x00005555559734c2 in vhost_dev_start (hdev=3D0x5555570e1310,
vdev=3D0x5555584b2c80, vrings=3Dfalse) at ../hw/virtio/vhost.c:2058
#6  0x0000555555854ec8 in vhost_net_start_one (net=3D0x5555570e1310,
dev=3D0x5555584b2c80) at ../hw/net/vhost_net.c:274
#7  0x00005555558554ca in vhost_net_start (dev=3D0x5555584b2c80,
ncs=3D0x5555584c8278, data_queue_pairs=3D1, cvq=3D1) at
../hw/net/vhost_net.c:415
#8  0x0000555555ace7a5 in virtio_net_vhost_status (n=3D0x5555584b2c80,
status=3D15 '\017') at ../hw/net/virtio-net.c:310
#9  0x0000555555acea50 in virtio_net_set_status (vdev=3D0x5555584b2c80,
status=3D15 '\017') at ../hw/net/virtio-net.c:391
#10 0x0000555555b06fee in virtio_set_status (vdev=3D0x5555584b2c80,
val=3D15 '\017') at ../hw/virtio/virtio.c:2048
#11 0x000055555595d667 in virtio_pci_common_write
(opaque=3D0x5555584aa8b0, addr=3D20, val=3D15, size=3D1) at
../hw/virtio/virtio-pci.c:1580
#12 0x0000555555b351c1 in memory_region_write_accessor
(mr=3D0x5555584ab3f0, addr=3D20, value=3D0x7fffee5bc4c8, size=3D1, shift=3D=
0,
mask=3D255,
    attrs=3D...) at ../system/memory.c:497
#13 0x0000555555b354c5 in access_with_adjusted_size (addr=3D20,
value=3D0x7fffee5bc4c8, size=3D1, access_size_min=3D1, access_size_max=3D4,
    access_fn=3D0x555555b350cf <memory_region_write_accessor>,
mr=3D0x5555584ab3f0, attrs=3D...) at ../system/memory.c:573
#14 0x0000555555b3856f in memory_region_dispatch_write
(mr=3D0x5555584ab3f0, addr=3D20, data=3D15, op=3DMO_8, attrs=3D...) at
../system/memory.c:1521
#15 0x0000555555b45885 in flatview_write_continue (fv=3D0x7fffd8122b80,
addr=3D4227858452, attrs=3D..., ptr=3D0x7ffff7ff0028, len=3D1, addr1=3D20,
    l=3D1, mr=3D0x5555584ab3f0) at ../system/physmem.c:2714
#16 0x0000555555b459e8 in flatview_write (fv=3D0x7fffd8122b80,
addr=3D4227858452, attrs=3D..., buf=3D0x7ffff7ff0028, len=3D1)
    at ../system/physmem.c:2756
#17 0x0000555555b45d9a in address_space_write (as=3D0x555556db72e0
<address_space_memory>, addr=3D4227858452, attrs=3D...,
buf=3D0x7ffff7ff0028,
    len=3D1) at ../system/physmem.c:2863
#18 0x0000555555b45e07 in address_space_rw (as=3D0x555556db72e0
<address_space_memory>, addr=3D4227858452, attrs=3D...,
buf=3D0x7ffff7ff0028,
    len=3D1, is_write=3Dtrue) at ../system/physmem.c:2873
#19 0x0000555555b5eb30 in kvm_cpu_exec (cpu=3D0x5555571258f0) at
../accel/kvm/kvm-all.c:2915
#20 0x0000555555b61798 in kvm_vcpu_thread_fn (arg=3D0x5555571258f0) at
../accel/kvm/kvm-accel-ops.c:51
#21 0x0000555555d384b7 in qemu_thread_start (args=3D0x55555712c390) at
../util/qemu-thread-posix.c:541
#22 0x00007ffff580814a in start_thread () from /lib64/libpthread.so.0
#23 0x00007ffff54fcf23 in clone () from /lib64/libc.so.6

Can we reschedule that map to a bh without returning the control to the vCP=
U?

> But another question. How to synchronize with the memory API in this
> case. Currently the updating (without vIOMMU) is done under the
> listener callback.
>
> Usually after the commit, Qemu may think the memory topology has been
> updated. If it is done asynchronously, would we have any problem?
>

The function vhost_vdpa_process_iotlb_msg in the kernel has its own
lock. So two QEMU threads can map memory independently and they get
serialized.

For the write() caller, it is like the call takes more time, but there
are no deadlocks or similar.

> >
> > As a half-baked idea, we can split the mapping chunks in manageable
> > sizes, but I don't like that idea a lot.
> >
> > > Btw, have you measured the hotspot that causes such slowness? Is it
> > > pinning or vendor specific mapping that slows down the progress? Or i=
f
> > > VFIO has a similar issue?
> > >
> >
> > Si-Wei did the actual profiling as he is the one with the 128G guests,
> > but most of the time was spent in the memory pinning. Si-Wei, please
> > correct me if I'm wrong.
> >
> > I didn't check VFIO, but I think it just maps at realize phase with
> > vfio_realize -> vfio_attach_device -> vfio_connect_container(). In
> > previous testings, this delayed the VM initialization by a lot, as
> > we're moving that 20s of blocking to every VM start.
> >
> > Investigating a way to do it only in the case of being the destination
> > of a live migration, I think the right place is .load_setup migration
> > handler. But I'm ok to move it for sure.
>
> Adding Peter for more ideas.
>

Appreciated :).

Thanks!

> >
> > > >
> > > > This thread joins at vdpa backend device start, so it could happen =
that
> > > > the guest memory is so large that we still have guest memory to map
> > > > before this time.
> > >
> > > So we would still hit the QMP stall in this case?
> > >
> >
> > This paragraph is kind of outdated, sorry. I can only cause this if I
> > don't enable switchover_ack migration capability and if I artificially
> > make memory pinning in the kernel artificially slow. But I didn't
> > check QMP to be honest, so I can try to test it, yes.
> >
> > If QMP is not responsive, that means QMP is not responsive in QEMU
> > master in that period actually. So we're only improving anyway.
> >
> > Thanks!
> >
>
> Thanks
>


