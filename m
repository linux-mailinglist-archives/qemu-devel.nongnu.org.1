Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA89752B22
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 21:43:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qK2D4-0001MQ-Mz; Thu, 13 Jul 2023 15:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qK2D2-0001Lv-B5
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 15:42:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qK2D0-0000tp-Dy
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 15:42:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689277356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=0ecKY+2hbb9Po0wy4GnfoAUs6cPh0hHtRBDWgSl23E0=;
 b=SZZY+ePbpLCNMfX6g0/LCvNUzmckgSJDU56PH441UfRTModgLjWfPBaqnVPuMKM8wHOnpK
 SxQe/sgCYsYI+HE8ZjcmqjwqD0LB7KTJIF7zxlB5zya4EI4XP4KOm+Yy4aaTHSfL9HN21p
 bFwBfSx6FaBkad3mphR5MHu22n4DCF8=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-67-Fq8i7KbMNb-nc4d4WxruaA-1; Thu, 13 Jul 2023 15:42:34 -0400
X-MC-Unique: Fq8i7KbMNb-nc4d4WxruaA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D8A929DD990
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 19:42:34 +0000 (UTC)
Received: from localhost (unknown [10.39.192.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B68E0492B01;
 Thu, 13 Jul 2023 19:42:33 +0000 (UTC)
Date: Thu, 13 Jul 2023 15:42:26 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: pbonzini@redhat.com, kwolf@redhat.com
Cc: qemu-devel@nongnu.org
Subject: drain_call_rcu() vs nested event loops
Message-ID: <20230713194226.GA335220@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gg/EnxqYa7Ua1q8f"
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--gg/EnxqYa7Ua1q8f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,
I've encountered a bug where two vcpu threads enter a device's MMIO
emulation callback at the same time. This is never supposed to happen
thanks to the Big QEMU Lock (BQL), but drain_call_rcu() and nested event
loops make it possible:

1. A device's MMIO emulation callback invokes AIO_WAIT_WHILE().
2. A device_add monitor command runs in AIO_WAIT_WHILE()'s aio_poll()
   nested event loop.
3. qmp_device_add() -> drain_call_rcu() is called and the BQL is
   temporarily dropped.
4. Another vcpu thread dispatches the same device's MMIO callback
   because it is now able to acquire the BQL.

I've included the backtraces below if you want to see the details. They
are from a RHEL qemu-kvm 6.2.0-35 coredump but I haven't found anything
in qemu.git/master that would fix this.

One fix is to make qmp_device_add() a coroutine and schedule a BH in the
iohandler AioContext. That way the coroutine must wait until the nested
event loop finishes before its BH executes. drain_call_rcu() will never
be called from a nested event loop and the problem does not occur
anymore.

Another possibility is to remove the following in monitor_qmp_dispatcher_co=
():

  /*
   * Move the coroutine from iohandler_ctx to qemu_aio_context for
   * executing the command handler so that it can make progress if it
   * involves an AIO_WAIT_WHILE().
   */
  aio_co_schedule(qemu_get_aio_context(), qmp_dispatcher_co);
  qemu_coroutine_yield();

By executing QMP commands in the iohandler AioContext by default, we can
prevent issues like this in the future. However, there might be some QMP
commands that assume they are running in the qemu_aio_context (e.g.
coroutine commands that yield) and they might need to manually move to
the qemu_aio_context.

What do you think?

Stefan
---
Thread 41 (Thread 0x7fdc3dffb700 (LWP 910296)):
#0  0x00007fde88ac99bd in syscall () from /lib64/libc.so.6
#1  0x000055bd7a2e066f in qemu_futex_wait (val=3D<optimized out>, f=3D<opti=
mized out>) at /usr/src/debug/qemu-kvm-6.2.0-35.module+el8.9.0+19024+8193e2=
ac.x86_64/include/qemu/futex.h:29
#2  qemu_event_wait (ev=3Dev@entry=3D0x7fdc3dffa2d0) at ../util/qemu-thread=
-posix.c:510
#3  0x000055bd7a2e8e54 in drain_call_rcu () at ../util/rcu.c:347
#4  0x000055bd79f63d1e in qmp_device_add (qdict=3D<optimized out>, ret_data=
=3D<optimized out>, errp=3D<optimized out>) at ../softmmu/qdev-monitor.c:863
#5  0x000055bd7a2d420d in do_qmp_dispatch_bh (opaque=3D0x7fde8c22aee0) at .=
=2E/qapi/qmp-dispatch.c:129
#6  0x000055bd7a2ef3bd in aio_bh_call (bh=3D0x7fdc6015cd50) at ../util/asyn=
c.c:174
#7  aio_bh_poll (ctx=3Dctx@entry=3D0x55bd7c910f40) at ../util/async.c:174
#8  0x000055bd7a2dd3b2 in aio_poll (ctx=3D0x55bd7c910f40, blocking=3Dblocki=
ng@entry=3Dtrue) at ../util/aio-posix.c:659
#9  0x000055bd7a2effea in aio_wait_bh_oneshot (ctx=3D0x55bd7ca980e0, cb=3Dc=
b@entry=3D0x55bd7a11a9c0 <virtio_blk_data_plane_stop_bh>, opaque=3Dopaque@e=
ntry=3D0x55bd7e585c40) at ../util/aio-wait.c:85
#10 0x000055bd7a11b30b in virtio_blk_data_plane_stop (vdev=3D<optimized out=
>) at ../hw/block/dataplane/virtio-blk.c:333
#11 0x000055bd7a0591e0 in virtio_bus_stop_ioeventfd (bus=3Dbus@entry=3D0x55=
bd7cb57ba8) at ../hw/virtio/virtio-bus.c:258
#12 0x000055bd7a05995f in virtio_bus_stop_ioeventfd (bus=3Dbus@entry=3D0x55=
bd7cb57ba8) at ../hw/virtio/virtio-bus.c:250
#13 0x000055bd7a05b238 in virtio_pci_stop_ioeventfd (proxy=3D0x55bd7cb4f9a0=
) at ../hw/virtio/virtio-pci.c:1289
#14 virtio_pci_common_write (opaque=3D0x55bd7cb4f9a0, addr=3D<optimized out=
>, val=3D<optimized out>, size=3D<optimized out>) at ../hw/virtio/virtio-pc=
i.c:1289
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#15 0x000055bd7a0f6777 in memory_region_write_accessor (mr=3D0x55bd7cb50410=
, addr=3D<optimized out>, value=3D<optimized out>, size=3D1, shift=3D<optim=
ized out>, mask=3D<optimized out>, attrs=3D...) at ../softmmu/memory.c:492
#16 0x000055bd7a0f320e in access_with_adjusted_size (addr=3Daddr@entry=3D20=
, value=3Dvalue@entry=3D0x7fdc3dffa5c8, size=3Dsize@entry=3D1, access_size_=
min=3D<optimized out>, access_size_max=3D<optimized out>,=20
    access_fn=3D0x55bd7a0f6710 <memory_region_write_accessor>, mr=3D0x55bd7=
cb50410, attrs=3D...) at ../softmmu/memory.c:554
#17 0x000055bd7a0f62a3 in memory_region_dispatch_write (mr=3Dmr@entry=3D0x5=
5bd7cb50410, addr=3D20, data=3D<optimized out>, op=3D<optimized out>, attrs=
=3Dattrs@entry=3D...) at ../softmmu/memory.c:1504
#18 0x000055bd7a0e7f2e in flatview_write_continue (fv=3Dfv@entry=3D0x55bd7d=
17cad0, addr=3Daddr@entry=3D4236247060, attrs=3D..., ptr=3Dptr@entry=3D0x7f=
de84003028, len=3Dlen@entry=3D1, addr1=3D<optimized out>, l=3D<optimized ou=
t>,=20
    mr=3D0x55bd7cb50410) at /usr/src/debug/qemu-kvm-6.2.0-35.module+el8.9.0=
+19024+8193e2ac.x86_64/include/qemu/host-utils.h:165
#19 0x000055bd7a0e8093 in flatview_write (fv=3D0x55bd7d17cad0, addr=3D42362=
47060, attrs=3D..., buf=3D0x7fde84003028, len=3D1) at ../softmmu/physmem.c:=
2856
#20 0x000055bd7a0ebc6f in address_space_write (as=3D<optimized out>, addr=
=3D<optimized out>, attrs=3D..., buf=3D<optimized out>, len=3D<optimized ou=
t>) at ../softmmu/physmem.c:2952
#21 0x000055bd7a1a28b9 in kvm_cpu_exec (cpu=3Dcpu@entry=3D0x55bd7cc32bf0) a=
t ../accel/kvm/kvm-all.c:2995
#22 0x000055bd7a1a36e5 in kvm_vcpu_thread_fn (arg=3D0x55bd7cc32bf0) at ../a=
ccel/kvm/kvm-accel-ops.c:49
#23 0x000055bd7a2dfdd4 in qemu_thread_start (args=3D0x55bd7cc41f20) at ../u=
til/qemu-thread-posix.c:585
#24 0x00007fde88e5d1ca in start_thread () from /lib64/libpthread.so.0
#25 0x00007fde88ac9e73 in clone () from /lib64/libc.so.6

Thread 1 (Thread 0x7fdc6f5fe700 (LWP 910286)):
#0  0x00007fde88adeacf in raise () from /lib64/libc.so.6
#1  0x00007fde88ab1ea5 in abort () from /lib64/libc.so.6
#2  0x00007fde88ab1d79 in __assert_fail_base.cold.0 () from /lib64/libc.so.6
#3  0x00007fde88ad7426 in __assert_fail () from /lib64/libc.so.6
#4  0x000055bd7a1175c8 in virtio_blk_set_status (vdev=3D0x55bd7cb57c30, sta=
tus=3D<optimized out>) at ../hw/block/virtio-blk.c:1043
#5  0x000055bd7a1474e4 in virtio_set_status (vdev=3Dvdev@entry=3D0x55bd7cb5=
7c30, val=3Dval@entry=3D0 '\000') at ../hw/virtio/virtio.c:1945
#6  0x000055bd7a05b243 in virtio_pci_common_write (opaque=3D0x55bd7cb4f9a0,=
 addr=3D<optimized out>, val=3D<optimized out>, size=3D<optimized out>) at =
=2E./hw/virtio/virtio-pci.c:1292
                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#7  0x000055bd7a0f6777 in memory_region_write_accessor (mr=3D0x55bd7cb50410=
, addr=3D<optimized out>, value=3D<optimized out>, size=3D1, shift=3D<optim=
ized out>, mask=3D<optimized out>, attrs=3D...) at ../softmmu/memory.c:492
#8  0x000055bd7a0f320e in access_with_adjusted_size (addr=3Daddr@entry=3D20=
, value=3Dvalue@entry=3D0x7fdc6f5fd5c8, size=3Dsize@entry=3D1, access_size_=
min=3D<optimized out>, access_size_max=3D<optimized out>,=20
    access_fn=3D0x55bd7a0f6710 <memory_region_write_accessor>, mr=3D0x55bd7=
cb50410, attrs=3D...) at ../softmmu/memory.c:554
#9  0x000055bd7a0f62a3 in memory_region_dispatch_write (mr=3Dmr@entry=3D0x5=
5bd7cb50410, addr=3D20, data=3D<optimized out>, op=3D<optimized out>, attrs=
=3Dattrs@entry=3D...) at ../softmmu/memory.c:1504
#10 0x000055bd7a0e7f2e in flatview_write_continue (fv=3Dfv@entry=3D0x7fdad6=
9b4a90, addr=3Daddr@entry=3D4236247060, attrs=3D..., ptr=3Dptr@entry=3D0x7f=
de8c05f028, len=3Dlen@entry=3D1, addr1=3D<optimized out>, l=3D<optimized ou=
t>,=20
    mr=3D0x55bd7cb50410) at /usr/src/debug/qemu-kvm-6.2.0-35.module+el8.9.0=
+19024+8193e2ac.x86_64/include/qemu/host-utils.h:165
#11 0x000055bd7a0e8093 in flatview_write (fv=3D0x7fdad69b4a90, addr=3D42362=
47060, attrs=3D..., buf=3D0x7fde8c05f028, len=3D1) at ../softmmu/physmem.c:=
2856
#12 0x000055bd7a0ebc6f in address_space_write (as=3D<optimized out>, addr=
=3D<optimized out>, attrs=3D..., buf=3D<optimized out>, len=3D<optimized ou=
t>) at ../softmmu/physmem.c:2952
#13 0x000055bd7a1a28b9 in kvm_cpu_exec (cpu=3Dcpu@entry=3D0x55bd7cb953f0) a=
t ../accel/kvm/kvm-all.c:2995
#14 0x000055bd7a1a36e5 in kvm_vcpu_thread_fn (arg=3D0x55bd7cb953f0) at ../a=
ccel/kvm/kvm-accel-ops.c:49
#15 0x000055bd7a2dfdd4 in qemu_thread_start (args=3D0x55bd7cba4420) at ../u=
til/qemu-thread-posix.c:585
#16 0x00007fde88e5d1ca in start_thread () from /lib64/libpthread.so.0
#17 0x00007fde88ac9e73 in clone () from /lib64/libc.so.6

--gg/EnxqYa7Ua1q8f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmSwU6IACgkQnKSrs4Gr
c8gENwgAnLe5a73IV1duZ0RU8YZ2ENEja2sBYkeKwrYsOnMba+ZPFldmT+XcLPFP
UABf67gn1XbfzAcswDZSIgQRxwrI5BHWwUQCj4+3iU6RJIYEp0TNejBTx0PN/Sul
OG4h1Yp/XUXJ3CRW3yDJp/TEm9272/KahyJVLSQdJAp/XKBqAag1K7vdPXeK0SzY
mPkeNfkIZ8VUPVZgET3JD6FRlXIwi2cC2sNvbEk5EB4jpAVdFqKCRmfUpG2lT9vu
h+SXT8T7W0womd3QU62v6LDGApUIVckURNp7jLQsvvaRnSEQqWSQ7dSEL72X3ebb
n8N2FC2k3B/f0mLcW7Eo1Nk0aQ2lEw==
=VtYw
-----END PGP SIGNATURE-----

--gg/EnxqYa7Ua1q8f--


