Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B93D8A47CF
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Apr 2024 08:10:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwFWn-0000yn-1J; Mon, 15 Apr 2024 02:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rwFWk-0000yO-Ff
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 02:09:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rwFWi-0005ip-O0
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 02:09:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713161351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xsHZLrC6wEE1KRnqBuzwaqLmYg1cCUGWX3AIA/356Aw=;
 b=QpFKA46X77BI4PoQxb4aa+V6iiwSGXLggug9rt2AZx2ckl68N0zVPPO1Vk2UKkaLXK8IBV
 3za0F9AIR/rhz9XID/TZOVy0I/eA4pJxRYNthrKVWr9UALWOJtVZrYxqHrP+MGeACNsMTR
 eJ9XsvLlLUuzSetWVu5WtGn6MYbKMmU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-jxtJgrunOvauUE93y63OiA-1; Mon, 15 Apr 2024 02:09:09 -0400
X-MC-Unique: jxtJgrunOvauUE93y63OiA-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2a2d197ac0aso2646778a91.2
 for <qemu-devel@nongnu.org>; Sun, 14 Apr 2024 23:09:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713161347; x=1713766147;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xsHZLrC6wEE1KRnqBuzwaqLmYg1cCUGWX3AIA/356Aw=;
 b=h+deKTztGA6kMCLeaZOnnzJSlF27tvWhiSfevimZN+a7iJ5JDYi3onisb47wJBg7fI
 IxJ5mNwQTzp2Nm+6MdFwnbPySRRvN/7CjsayeDBakuAIyWLxAONoeYVoTr5PLaUIgjvl
 p0gl469CcBRdgPSSz/Kmv0Mh8Bp5edug2V+8hGoTgM352H0Vi+sCxImaPma4oUFhNNd+
 lfA1Y4R8yU7FTT6CGdz01P7YqBqp2384Qo/l8JdOy6w/TVZwq22v1Ulix+inQ0127NJz
 trmIQYamAV6LqsNNLDdcfIL40f98vgKq84DZ0sR1k5h7ez+Rz54onqX1apXbEPdiN0IO
 u4og==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMxc6GPEK7A7czONnyjO4YWTO5GWzkULp+jELBFVDMhpUO5MHTKLS7J4QRqVFiuhAejWrfEsKuJkSGXAR9CNHVzkVKSS8=
X-Gm-Message-State: AOJu0YzE+TjB/NyyGF7hvUmZroG+MrX5UE7/EWEFdpDXDX527TPvLw9y
 9edJgvonK82UubZhIpCgVnmhmmLep1Pmlrs4LnrmjjIXy56xMyIPvJMWKUUG79Ju8+4MSROJrpY
 JrTp3BuEdDA62CkpB8AvXgqe9XkXIgaTlsb+FN7K2M7+goQuCCa4LqhmxC0nh/5vGiH4FxDhN1I
 vSsF0nFhWLsdgY+CsibN4zo0Shw0iSmYW5JBI=
X-Received: by 2002:a17:90a:e44e:b0:29c:7566:a1d6 with SMTP id
 jp14-20020a17090ae44e00b0029c7566a1d6mr6606452pjb.25.1713161347540; 
 Sun, 14 Apr 2024 23:09:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF88yfxyHx4kCwAWZVWOK8SBeW/1pgXz5bmNdkv9lpR5Kj+MeT5CkPcpxG0rgX6l+9f7NoVpGCRpO6rr0oQ05I=
X-Received: by 2002:a17:90a:e44e:b0:29c:7566:a1d6 with SMTP id
 jp14-20020a17090ae44e00b0029c7566a1d6mr6606436pjb.25.1713161347261; Sun, 14
 Apr 2024 23:09:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240412062750.475180-1-lulu@redhat.com>
In-Reply-To: <20240412062750.475180-1-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Apr 2024 14:08:55 +0800
Message-ID: <CACGkMEvKLan8fUUm8P5isMABWOTwsuHxugbaiLokzzadg4qrdg@mail.gmail.com>
Subject: Re: [PATCH v6] virtio-pci: Fix the crash that the vector was used
 after released.
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
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

On Fri, Apr 12, 2024 at 2:28=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
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
> Fixes: f9a09ca3ea ("vhost: add support for configure interrupt")
> Cc: qemu-stable@nongnu.org
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


