Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 761678A4BC5
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Apr 2024 11:43:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwIrd-00052j-Nn; Mon, 15 Apr 2024 05:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1rwIrX-000526-U2
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 05:42:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1rwIrV-0005wZ-HW
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 05:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713174164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y44WESwrPvKb2/7jLN9t57Te23sFFoIGiNTiKgnL++g=;
 b=BEarI59bBcnEvexITYR8oLNOXs8PItBT+RmBn0sHl1cwcEE0aCUkCxdYOBDbkKXXWDjo1Z
 7TbYpVfywWTL7uNPeuI9WSp0vD4gXkbY65+NyCy1MVlvQgcWD6gbUoHAaKKbOaXJbP3UnO
 HIcoQTj5FOsacGnQWuPHsSAlAYOUoew=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-neg0PzYnO3StXZpq361WJA-1; Mon, 15 Apr 2024 05:42:42 -0400
X-MC-Unique: neg0PzYnO3StXZpq361WJA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a52511b783dso150710866b.1
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 02:42:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713174161; x=1713778961;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y44WESwrPvKb2/7jLN9t57Te23sFFoIGiNTiKgnL++g=;
 b=YYxd2Imef6aB5Fx4JPCoVXdu3uulFU+eE5M3SQpgApSNSFt8vCicajsDqKZoQn+Wzu
 AwgCmFTb5q2lwtFQShfMzUAkwpW+oZS4e7Ckw/eLfXD/rtAlllg4+e12cE0uP18kDysZ
 V7tLTk28PQRjpymTzCmOHTqACrgBKnjEPsZlOqDRwN1hNzeCuURyhkwE1Dxxmtr9AHtN
 oL3LhT6BB+Vz6IPRb42jS36Z4ek7t8UNMC/giDQ3B5S5Gk+AXtSxdLJpviToUnJk/YbE
 GotRqQszsATQSDl7tzEmMYnBhMu+qvsZOaTP9lPUOGVJB53A+KFHch7dulPj0OjFi/4w
 t3SQ==
X-Gm-Message-State: AOJu0YyM1u+JvYBMNa91Stqrz0mrRPUGiM+RopNm229gKoeWctBB2eYN
 fgxMhZwDPLlbVXQxHL2ik2qXcSH3xp72lxUUd4OTU6RBEzVcjNS7MuVJEkyR5r+ohMHm0gJyPiZ
 P6QHzScRDmSdL/P+8r6ZeHjlsknuhGhU7/TmFXxAoJ9L6UyQUpRtKCkwFoYMLv2zfLBTYvDIc+n
 cQzG+8MAMvQFxb+F8N11sfEETtLv8=
X-Received: by 2002:a17:907:764c:b0:a52:57ad:63d0 with SMTP id
 kj12-20020a170907764c00b00a5257ad63d0mr2550413ejc.20.1713174161573; 
 Mon, 15 Apr 2024 02:42:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUaN66WcPs1BcJiC55tALTNppAnZdUk67ekFWrAGpQrYpnNQ0klrcgSibX+Ek5QxFvjKqcHvxxwbE1Iiqc0y8=
X-Received: by 2002:a17:907:764c:b0:a52:57ad:63d0 with SMTP id
 kj12-20020a170907764c00b00a5257ad63d0mr2550402ejc.20.1713174161250; Mon, 15
 Apr 2024 02:42:41 -0700 (PDT)
MIME-Version: 1.0
References: <2321ade5f601367efe7380c04e3f61379c59b48f.1713173550.git.mst@redhat.com>
In-Reply-To: <2321ade5f601367efe7380c04e3f61379c59b48f.1713173550.git.mst@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 15 Apr 2024 17:42:04 +0800
Message-ID: <CACLfguXEepZkZw9XzXa1uSdTAZMZX87F7MjcNtW+5qFkZBEiOg@mail.gmail.com>
Subject: Re: [PATCH v8] virtio-pci: fix use of a released vector
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.127,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Apr 15, 2024 at 5:34=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> From: Cindy Lu <lulu@redhat.com>
>
> During the booting process of the non-standard image, the behavior of the
> called function in qemu is as follows:
>
> 1. vhost_net_stop() was triggered by guest image. This will call the func=
tion
> virtio_pci_set_guest_notifiers() with assgin=3D false,
> virtio_pci_set_guest_notifiers(=EF=BC=89 will release the irqfd for vecto=
r 0
>
> 2. virtio_reset() was triggered, this will set configure vector to VIRTIO=
_NO_VECTOR
>
> 3.vhost_net_start() was called (at this time, the configure vector is
> still VIRTIO_NO_VECTOR) and then call virtio_pci_set_guest_notifiers() wi=
th
> assgin=3Dtrue, so the irqfd for vector 0 is still not "init" during this =
process
>
> 4. The system continues to boot and sets the vector back to 0. After that
> msix_fire_vector_notifier() was triggered to unmask the vector 0 and  mee=
t the crash
>
> To fix the issue, we need to support changing the vector after VIRTIO_CON=
FIG_S_DRIVER_OK is set.
>
> (gdb) bt
> 0  __pthread_kill_implementation (threadid=3D<optimized out>, signo=3Dsig=
no@entry=3D6, no_tid=3Dno_tid@entry=3D0)
>     at pthread_kill.c:44
> 1  0x00007fc87148ec53 in __pthread_kill_internal (signo=3D6, threadid=3D<=
optimized out>) at pthread_kill.c:78
> 2  0x00007fc87143e956 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/p=
osix/raise.c:26
> 3  0x00007fc8714287f4 in __GI_abort () at abort.c:79
> 4  0x00007fc87142871b in __assert_fail_base
>     (fmt=3D0x7fc8715bbde0 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", as=
sertion=3D0x5606413efd53 "ret =3D=3D 0", file=3D0x5606413ef87d "../accel/kv=
m/kvm-all.c", line=3D1837, function=3D<optimized out>) at assert.c:92
> 5  0x00007fc871437536 in __GI___assert_fail
>     (assertion=3D0x5606413efd53 "ret =3D=3D 0", file=3D0x5606413ef87d "..=
/accel/kvm/kvm-all.c", line=3D1837, function=3D0x5606413f06f0 <__PRETTY_FUN=
CTION__.19> "kvm_irqchip_commit_routes") at assert.c:101
> 6  0x0000560640f884b5 in kvm_irqchip_commit_routes (s=3D0x560642cae1f0) a=
t ../accel/kvm/kvm-all.c:1837
> 7  0x0000560640c98f8e in virtio_pci_one_vector_unmask
>     (proxy=3D0x560643c65f00, queue_no=3D4294967295, vector=3D0, msg=3D...=
, n=3D0x560643c6e4c8)
>     at ../hw/virtio/virtio-pci.c:1005
> 8  0x0000560640c99201 in virtio_pci_vector_unmask (dev=3D0x560643c65f00, =
vector=3D0, msg=3D...)
>     at ../hw/virtio/virtio-pci.c:1070
> 9  0x0000560640bc402e in msix_fire_vector_notifier (dev=3D0x560643c65f00,=
 vector=3D0, is_masked=3Dfalse)
>     at ../hw/pci/msix.c:120
> 10 0x0000560640bc40f1 in msix_handle_mask_update (dev=3D0x560643c65f00, v=
ector=3D0, was_masked=3Dtrue)
>     at ../hw/pci/msix.c:140
> 11 0x0000560640bc4503 in msix_table_mmio_write (opaque=3D0x560643c65f00, =
addr=3D12, val=3D0, size=3D4)
>     at ../hw/pci/msix.c:231
> 12 0x0000560640f26d83 in memory_region_write_accessor
>     (mr=3D0x560643c66540, addr=3D12, value=3D0x7fc86b7bc628, size=3D4, sh=
ift=3D0, mask=3D4294967295, attrs=3D...)
>     at ../system/memory.c:497
> 13 0x0000560640f270a6 in access_with_adjusted_size
>
>      (addr=3D12, value=3D0x7fc86b7bc628, size=3D4, access_size_min=3D1, a=
ccess_size_max=3D4, access_fn=3D0x560640f26c8d <memory_region_write_accesso=
r>, mr=3D0x560643c66540, attrs=3D...) at ../system/memory.c:573
> 14 0x0000560640f2a2b5 in memory_region_dispatch_write (mr=3D0x560643c6654=
0, addr=3D12, data=3D0, op=3DMO_32, attrs=3D...)
>     at ../system/memory.c:1521
> 15 0x0000560640f37bac in flatview_write_continue
>     (fv=3D0x7fc65805e0b0, addr=3D4273803276, attrs=3D..., ptr=3D0x7fc871e=
9c028, len=3D4, addr1=3D12, l=3D4, mr=3D0x560643c66540)
>     at ../system/physmem.c:2714
> 16 0x0000560640f37d0f in flatview_write
>     (fv=3D0x7fc65805e0b0, addr=3D4273803276, attrs=3D..., buf=3D0x7fc871e=
9c028, len=3D4) at ../system/physmem.c:2756
> 17 0x0000560640f380bf in address_space_write
>     (as=3D0x560642161ae0 <address_space_memory>, addr=3D4273803276, attrs=
=3D..., buf=3D0x7fc871e9c028, len=3D4)
>     at ../system/physmem.c:2863
> 18 0x0000560640f3812c in address_space_rw
>     (as=3D0x560642161ae0 <address_space_memory>, addr=3D4273803276, attrs=
=3D..., buf=3D0x7fc871e9c028, len=3D4, is_write=3Dtrue) at ../system/physme=
m.c:2873
> --Type <RET> for more, q to quit, c to continue without paging--
> 19 0x0000560640f8aa55 in kvm_cpu_exec (cpu=3D0x560642f205e0) at ../accel/=
kvm/kvm-all.c:2915
> 20 0x0000560640f8d731 in kvm_vcpu_thread_fn (arg=3D0x560642f205e0) at ../=
accel/kvm/kvm-accel-ops.c:51
> 21 0x00005606411949f4 in qemu_thread_start (args=3D0x560642f292b0) at ../=
util/qemu-thread-posix.c:541
> 22 0x00007fc87148cdcd in start_thread (arg=3D<optimized out>) at pthread_=
create.c:442
> 23 0x00007fc871512630 in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/c=
lone3.S:81
> (gdb)
>
> MST: coding style and typo fixups
>
> Fixes: f9a09ca3ea ("vhost: add support for configure interrupt")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> Message-Id: <20240412062750.475180-1-lulu@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/virtio/virtio-pci.c | 37 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 35 insertions(+), 2 deletions(-)
>
> v7->v8:
> more cleanups, suggested by Philip
>
> still untested, i just got involved to help address coding style
> issues
>
Really thanks for your help, I will do the qtest and sanity test for this
thanks
cindy
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index cb6940fc0e..cb159fd078 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1424,6 +1424,38 @@ static int virtio_pci_add_mem_cap(VirtIOPCIProxy *=
proxy,
>      return offset;
>  }
>
> +static void virtio_pci_set_vector(VirtIODevice *vdev,
> +                                  VirtIOPCIProxy *proxy,
> +                                  int queue_no, uint16_t old_vector,
> +                                  uint16_t new_vector)
> +{
> +    bool kvm_irqfd =3D (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK) &&
> +        msix_enabled(&proxy->pci_dev) && kvm_msi_via_irqfd_enabled();
> +
> +    if (new_vector =3D=3D old_vector) {
> +        return;
> +    }
> +
> +    /*
> +     * If the device uses irqfd and the vector changes after DRIVER_OK i=
s
> +     * set, we need to release the old vector and set up the new one.
> +     * Otherwise just need to set the new vector on the device.
> +     */
> +    if (kvm_irqfd && old_vector !=3D VIRTIO_NO_VECTOR) {
> +        kvm_virtio_pci_vector_release_one(proxy, queue_no);
> +    }
> +    /* Set the new vector on the device. */
> +    if (queue_no =3D=3D VIRTIO_CONFIG_IRQ_IDX) {
> +        vdev->config_vector =3D new_vector;
> +    } else {
> +        virtio_queue_set_vector(vdev, queue_no, new_vector);
> +    }
> +    /* If the new vector changed need to set it up. */
> +    if (kvm_irqfd && new_vector !=3D VIRTIO_NO_VECTOR) {
> +        kvm_virtio_pci_vector_use_one(proxy, queue_no);
> +    }
> +}
> +
>  int virtio_pci_add_shm_cap(VirtIOPCIProxy *proxy,
>                             uint8_t bar, uint64_t offset, uint64_t length=
,
>                             uint8_t id)
> @@ -1570,7 +1602,8 @@ static void virtio_pci_common_write(void *opaque, h=
waddr addr,
>          } else {
>              val =3D VIRTIO_NO_VECTOR;
>          }
> -        vdev->config_vector =3D val;
> +        virtio_pci_set_vector(vdev, proxy, VIRTIO_CONFIG_IRQ_IDX,
> +                              vdev->config_vector, val);
>          break;
>      case VIRTIO_PCI_COMMON_STATUS:
>          if (!(val & VIRTIO_CONFIG_S_DRIVER_OK)) {
> @@ -1610,7 +1643,7 @@ static void virtio_pci_common_write(void *opaque, h=
waddr addr,
>          } else {
>              val =3D VIRTIO_NO_VECTOR;
>          }
> -        virtio_queue_set_vector(vdev, vdev->queue_sel, val);
> +        virtio_pci_set_vector(vdev, proxy, vdev->queue_sel, vector, val)=
;
>          break;
>      case VIRTIO_PCI_COMMON_Q_ENABLE:
>          if (val =3D=3D 1) {
> --
> MST
>


