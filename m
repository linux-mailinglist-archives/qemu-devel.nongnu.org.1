Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 595E48A619A
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Apr 2024 05:22:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwZNj-00016a-4S; Mon, 15 Apr 2024 23:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rwZNb-00015e-OW
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 23:21:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rwZNW-0008G1-T0
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 23:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713237661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3KjuPR+naV9p6QJUY3TL0pwD7BT3oka/57qz9WKDxFw=;
 b=KlN4wkfh6NDMbAkDIbaGuz2642xeXCceQ5PFUXmzeBrjO6Ep9pPeXzjc/YCdB4M0WQ8zOB
 oddk7XjKXr4pgzzKVRMJds2iAQfaXdCaG9bfannG3GfTniqpMuVw457uknNyKpgcSVwTs2
 CMOl+Dsi6upwuM1Sf6G7yNu09O9Zr0E=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-In91illbMM-yn0Txa9dZcQ-1; Mon, 15 Apr 2024 23:20:59 -0400
X-MC-Unique: In91illbMM-yn0Txa9dZcQ-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5cdfd47de98so3104182a12.1
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 20:20:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713237659; x=1713842459;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3KjuPR+naV9p6QJUY3TL0pwD7BT3oka/57qz9WKDxFw=;
 b=uBM6skG3s36yjtfIa0erImimyjb1b4scFl7GCAswkq9f9v7nYzwUXWQTxJSs7IMsFT
 RylILB3+vUJnbcGOkkituUrtRIIP4FFAc24i6yCDogI8zSwOSv27nyYRdT41G4qm8fWM
 +I8PwHP9mm5DQOVt0a/Jl9CtNTs5S1C8dOyovle3EJEQb24bRQp9JApbo8Ma1Gg11uqf
 S3ApG5SCKBm6dnO91fuoIKDB70wzhwFgVGgUj6+PLffkFd65VwPCHUTOwD5JBb5T6RSe
 g6YsLZvwFBUJJVs4QW6uTJxTnzTTia2I1FM4lmr8uWbj4qcVdDEh1zo7BTbccOx7GhP0
 z9rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgT24HQmJiGTRXDUyzlkPawaDryk9pUVETU3Z6XvwZl2dGgAtA65Cy8HIncSoUWlp8wLC3H4IzJwPuq1pt9tZxBZc8nUk=
X-Gm-Message-State: AOJu0YwYKQtH99jyEQxJ9j7R1hpwZqbYmMqPwWP0j4pQw63i4IuPYYPv
 exHMKjclAe4jKXl7kTeu5Ng6UG56gJPCckGztDIF0Pz9fAW5NOynKAB+Z1HYjiFRfEILbib52MY
 7g43s22hqkuMv9vQC1xhi400NLtvrvVEqjKOJyyTg1kSND9ej+UcqUnn75ZGqForMjyiNcRZgPU
 +sheyMgHgJrIMZPkeiDsXm2sbalzI=
X-Received: by 2002:a05:6a20:bf2a:b0:1a3:afdc:fe5 with SMTP id
 gc42-20020a056a20bf2a00b001a3afdc0fe5mr8587331pzb.42.1713237658839; 
 Mon, 15 Apr 2024 20:20:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4zGHCyqEmlFzX++v8an7WI6oAU7ZGm3MxBaSfWN7+4UldPDkK3d43uj1J4vUKSizbeP1kGRjyo64NaLWIwW4=
X-Received: by 2002:a05:6a20:bf2a:b0:1a3:afdc:fe5 with SMTP id
 gc42-20020a056a20bf2a00b001a3afdc0fe5mr8587324pzb.42.1713237658485; Mon, 15
 Apr 2024 20:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <2321ade5f601367efe7380c04e3f61379c59b48f.1713173550.git.mst@redhat.com>
 <CACLfguWX-3nmEySF0wKnTb3bivduiHd7kBPKZ4AyNE6LVE==iw@mail.gmail.com>
In-Reply-To: <CACLfguWX-3nmEySF0wKnTb3bivduiHd7kBPKZ4AyNE6LVE==iw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 16 Apr 2024 11:20:47 +0800
Message-ID: <CACGkMEvi7CdXy-xwNi80UuD8K-Y4X0mRdFBbYqxvMYHzfzctEw@mail.gmail.com>
Subject: Re: [PATCH v8] virtio-pci: fix use of a released vector
To: Cindy Lu <lulu@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, Lei Yang <leiyang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
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

On Mon, Apr 15, 2024 at 6:41=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> On Mon, Apr 15, 2024 at 5:34=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > From: Cindy Lu <lulu@redhat.com>
> >
> > During the booting process of the non-standard image, the behavior of t=
he
> > called function in qemu is as follows:
> >
> > 1. vhost_net_stop() was triggered by guest image. This will call the fu=
nction
> > virtio_pci_set_guest_notifiers() with assgin=3D false,
> > virtio_pci_set_guest_notifiers(=EF=BC=89 will release the irqfd for vec=
tor 0
> >
> > 2. virtio_reset() was triggered, this will set configure vector to VIRT=
IO_NO_VECTOR
> >
> > 3.vhost_net_start() was called (at this time, the configure vector is
> > still VIRTIO_NO_VECTOR) and then call virtio_pci_set_guest_notifiers() =
with
> > assgin=3Dtrue, so the irqfd for vector 0 is still not "init" during thi=
s process
> >
> > 4. The system continues to boot and sets the vector back to 0. After th=
at
> > msix_fire_vector_notifier() was triggered to unmask the vector 0 and  m=
eet the crash
> >
> > To fix the issue, we need to support changing the vector after VIRTIO_C=
ONFIG_S_DRIVER_OK is set.
> >
> > (gdb) bt
> > 0  __pthread_kill_implementation (threadid=3D<optimized out>, signo=3Ds=
igno@entry=3D6, no_tid=3Dno_tid@entry=3D0)
> >     at pthread_kill.c:44
> > 1  0x00007fc87148ec53 in __pthread_kill_internal (signo=3D6, threadid=
=3D<optimized out>) at pthread_kill.c:78
> > 2  0x00007fc87143e956 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps=
/posix/raise.c:26
> > 3  0x00007fc8714287f4 in __GI_abort () at abort.c:79
> > 4  0x00007fc87142871b in __assert_fail_base
> >     (fmt=3D0x7fc8715bbde0 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", =
assertion=3D0x5606413efd53 "ret =3D=3D 0", file=3D0x5606413ef87d "../accel/=
kvm/kvm-all.c", line=3D1837, function=3D<optimized out>) at assert.c:92
> > 5  0x00007fc871437536 in __GI___assert_fail
> >     (assertion=3D0x5606413efd53 "ret =3D=3D 0", file=3D0x5606413ef87d "=
../accel/kvm/kvm-all.c", line=3D1837, function=3D0x5606413f06f0 <__PRETTY_F=
UNCTION__.19> "kvm_irqchip_commit_routes") at assert.c:101
> > 6  0x0000560640f884b5 in kvm_irqchip_commit_routes (s=3D0x560642cae1f0)=
 at ../accel/kvm/kvm-all.c:1837
> > 7  0x0000560640c98f8e in virtio_pci_one_vector_unmask
> >     (proxy=3D0x560643c65f00, queue_no=3D4294967295, vector=3D0, msg=3D.=
.., n=3D0x560643c6e4c8)
> >     at ../hw/virtio/virtio-pci.c:1005
> > 8  0x0000560640c99201 in virtio_pci_vector_unmask (dev=3D0x560643c65f00=
, vector=3D0, msg=3D...)
> >     at ../hw/virtio/virtio-pci.c:1070
> > 9  0x0000560640bc402e in msix_fire_vector_notifier (dev=3D0x560643c65f0=
0, vector=3D0, is_masked=3Dfalse)
> >     at ../hw/pci/msix.c:120
> > 10 0x0000560640bc40f1 in msix_handle_mask_update (dev=3D0x560643c65f00,=
 vector=3D0, was_masked=3Dtrue)
> >     at ../hw/pci/msix.c:140
> > 11 0x0000560640bc4503 in msix_table_mmio_write (opaque=3D0x560643c65f00=
, addr=3D12, val=3D0, size=3D4)
> >     at ../hw/pci/msix.c:231
> > 12 0x0000560640f26d83 in memory_region_write_accessor
> >     (mr=3D0x560643c66540, addr=3D12, value=3D0x7fc86b7bc628, size=3D4, =
shift=3D0, mask=3D4294967295, attrs=3D...)
> >     at ../system/memory.c:497
> > 13 0x0000560640f270a6 in access_with_adjusted_size
> >
> >      (addr=3D12, value=3D0x7fc86b7bc628, size=3D4, access_size_min=3D1,=
 access_size_max=3D4, access_fn=3D0x560640f26c8d <memory_region_write_acces=
sor>, mr=3D0x560643c66540, attrs=3D...) at ../system/memory.c:573
> > 14 0x0000560640f2a2b5 in memory_region_dispatch_write (mr=3D0x560643c66=
540, addr=3D12, data=3D0, op=3DMO_32, attrs=3D...)
> >     at ../system/memory.c:1521
> > 15 0x0000560640f37bac in flatview_write_continue
> >     (fv=3D0x7fc65805e0b0, addr=3D4273803276, attrs=3D..., ptr=3D0x7fc87=
1e9c028, len=3D4, addr1=3D12, l=3D4, mr=3D0x560643c66540)
> >     at ../system/physmem.c:2714
> > 16 0x0000560640f37d0f in flatview_write
> >     (fv=3D0x7fc65805e0b0, addr=3D4273803276, attrs=3D..., buf=3D0x7fc87=
1e9c028, len=3D4) at ../system/physmem.c:2756
> > 17 0x0000560640f380bf in address_space_write
> >     (as=3D0x560642161ae0 <address_space_memory>, addr=3D4273803276, att=
rs=3D..., buf=3D0x7fc871e9c028, len=3D4)
> >     at ../system/physmem.c:2863
> > 18 0x0000560640f3812c in address_space_rw
> >     (as=3D0x560642161ae0 <address_space_memory>, addr=3D4273803276, att=
rs=3D..., buf=3D0x7fc871e9c028, len=3D4, is_write=3Dtrue) at ../system/phys=
mem.c:2873
> > --Type <RET> for more, q to quit, c to continue without paging--
> > 19 0x0000560640f8aa55 in kvm_cpu_exec (cpu=3D0x560642f205e0) at ../acce=
l/kvm/kvm-all.c:2915
> > 20 0x0000560640f8d731 in kvm_vcpu_thread_fn (arg=3D0x560642f205e0) at .=
./accel/kvm/kvm-accel-ops.c:51
> > 21 0x00005606411949f4 in qemu_thread_start (args=3D0x560642f292b0) at .=
./util/qemu-thread-posix.c:541
> > 22 0x00007fc87148cdcd in start_thread (arg=3D<optimized out>) at pthrea=
d_create.c:442
> > 23 0x00007fc871512630 in clone3 () at ../sysdeps/unix/sysv/linux/x86_64=
/clone3.S:81
> > (gdb)
> >
> > MST: coding style and typo fixups
> >
> > Fixes: f9a09ca3ea ("vhost: add support for configure interrupt")
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > Message-Id: <20240412062750.475180-1-lulu@redhat.com>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  hw/virtio/virtio-pci.c | 37 +++++++++++++++++++++++++++++++++++--
> >  1 file changed, 35 insertions(+), 2 deletions(-)
> >
> > v7->v8:
> > more cleanups, suggested by Philip
> >
> > still untested, i just got involved to help address coding style
> > issues
> >
> qtest and sanity test are all passed
>
> Tested-by: Cindy Lu <lulu@redhat.com>

Btw, in the future, it would be better to have a dedicated qtest to
test MSI-X confugation after DRIVER_OK.

Thanks

>
> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > index cb6940fc0e..cb159fd078 100644
> > --- a/hw/virtio/virtio-pci.c
> > +++ b/hw/virtio/virtio-pci.c
> > @@ -1424,6 +1424,38 @@ static int virtio_pci_add_mem_cap(VirtIOPCIProxy=
 *proxy,
> >      return offset;
> >  }
> >
> > +static void virtio_pci_set_vector(VirtIODevice *vdev,
> > +                                  VirtIOPCIProxy *proxy,
> > +                                  int queue_no, uint16_t old_vector,
> > +                                  uint16_t new_vector)
> > +{
> > +    bool kvm_irqfd =3D (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK) &&
> > +        msix_enabled(&proxy->pci_dev) && kvm_msi_via_irqfd_enabled();
> > +
> > +    if (new_vector =3D=3D old_vector) {
> > +        return;
> > +    }
> > +
> > +    /*
> > +     * If the device uses irqfd and the vector changes after DRIVER_OK=
 is
> > +     * set, we need to release the old vector and set up the new one.
> > +     * Otherwise just need to set the new vector on the device.
> > +     */
> > +    if (kvm_irqfd && old_vector !=3D VIRTIO_NO_VECTOR) {
> > +        kvm_virtio_pci_vector_release_one(proxy, queue_no);
> > +    }
> > +    /* Set the new vector on the device. */
> > +    if (queue_no =3D=3D VIRTIO_CONFIG_IRQ_IDX) {
> > +        vdev->config_vector =3D new_vector;
> > +    } else {
> > +        virtio_queue_set_vector(vdev, queue_no, new_vector);
> > +    }
> > +    /* If the new vector changed need to set it up. */
> > +    if (kvm_irqfd && new_vector !=3D VIRTIO_NO_VECTOR) {
> > +        kvm_virtio_pci_vector_use_one(proxy, queue_no);
> > +    }
> > +}
> > +
> >  int virtio_pci_add_shm_cap(VirtIOPCIProxy *proxy,
> >                             uint8_t bar, uint64_t offset, uint64_t leng=
th,
> >                             uint8_t id)
> > @@ -1570,7 +1602,8 @@ static void virtio_pci_common_write(void *opaque,=
 hwaddr addr,
> >          } else {
> >              val =3D VIRTIO_NO_VECTOR;
> >          }
> > -        vdev->config_vector =3D val;
> > +        virtio_pci_set_vector(vdev, proxy, VIRTIO_CONFIG_IRQ_IDX,
> > +                              vdev->config_vector, val);
> >          break;
> >      case VIRTIO_PCI_COMMON_STATUS:
> >          if (!(val & VIRTIO_CONFIG_S_DRIVER_OK)) {
> > @@ -1610,7 +1643,7 @@ static void virtio_pci_common_write(void *opaque,=
 hwaddr addr,
> >          } else {
> >              val =3D VIRTIO_NO_VECTOR;
> >          }
> > -        virtio_queue_set_vector(vdev, vdev->queue_sel, val);
> > +        virtio_pci_set_vector(vdev, proxy, vdev->queue_sel, vector, va=
l);
> >          break;
> >      case VIRTIO_PCI_COMMON_Q_ENABLE:
> >          if (val =3D=3D 1) {
> > --
> > MST
> >
>


