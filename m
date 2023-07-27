Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD11765728
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 17:15:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP2fQ-0003St-I8; Thu, 27 Jul 2023 11:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qP2eo-0003Ad-Qw
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 11:12:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qP2em-0003GH-KN
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 11:12:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690470718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L1Wdr80lFy8xWJzdSMWF9g9/DZ8SqyMTrl/vKTMkVCU=;
 b=DZlPTE3MN0iROpIQ7OjnGhKEsqF9vRy4T6ZYSWfDi1cbiVDF+aA5aNVWxa5mGtUetIJMIC
 Ceom2J3V2Um+X5i/xYaIst9yFOk7oNKx8CdbaPuUjVvewzXlBRWHFcXi0d0zhY4gVAt80N
 WFC9UeYasFizn0CCFy9MPK5N6zzxoTg=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-ad2RvigDMXO-y8vHdJhTiQ-1; Thu, 27 Jul 2023 11:11:54 -0400
X-MC-Unique: ad2RvigDMXO-y8vHdJhTiQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F5B11C09055;
 Thu, 27 Jul 2023 15:11:54 +0000 (UTC)
Received: from localhost (unknown [10.39.193.84])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A6C6B492B02;
 Thu, 27 Jul 2023 15:11:53 +0000 (UTC)
Date: Thu, 27 Jul 2023 11:11:51 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>
Subject: Re: virtio-blk using a single iothread
Message-ID: <20230727151151.GA970709@fedora>
References: <c206fa1d-077d-ae9b-476f-f43eec36a187@grimberg.me>
 <20230608160817.GK2138915@fedora>
 <d8028f17-8d33-790b-8d3e-fa1170108774@grimberg.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bWutyjHoDF/0zi9I"
Content-Disposition: inline
In-Reply-To: <d8028f17-8d33-790b-8d3e-fa1170108774@grimberg.me>
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


--bWutyjHoDF/0zi9I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 11, 2023 at 03:27:57PM +0300, Sagi Grimberg wrote:
>=20
>=20
> On 6/8/23 19:08, Stefan Hajnoczi wrote:
> > On Thu, Jun 08, 2023 at 10:40:57AM +0300, Sagi Grimberg wrote:
> > > Hey Stefan, Paolo,
> > >=20
> > > I just had a report from a user experiencing lower virtio-blk
> > > performance than he expected. This user is running virtio-blk on top =
of
> > > nvme-tcp device. The guest is running 12 CPU cores.
> > >=20
> > > The guest read/write throughput is capped at around 30% of the availa=
ble
> > > throughput from the host (~800MB/s from the guest vs. 2800MB/s from t=
he
> > > host - 25Gb/s nic). The workload running on the guest is a
> > > multi-threaded fio workload.
> > >=20
> > > What is observed is the fact that virtio-blk is using a single disk-w=
ide
> > > iothread processing all the vqs. Specifically nvme-tcp (similar to ot=
her
> > > tcp based protocols) is negatively impacted by lack of thread
> > > concurrency that can distribute I/O requests to different TCP
> > > connections.
> > >=20
> > > We also attempted to move the iothread to a dedicated core, however t=
hat
> > > did yield any meaningful performance improvements). The reason appears
> > > to be less about CPU utilization on the iothread core, but more around
> > > single TCP connection serialization.
> > >=20
> > > Moving to io=3Dthreads does increase the throughput, however sacrific=
ing
> > > latency significantly.
> > >=20
> > > So the user find itself with available host cpus and TCP connections
> > > that it could easily use to get maximum throughput, without the abili=
ty
> > > to leverage them. True, other guests will use different
> > > threads/contexts, however the goal here is to allow the full performa=
nce
> > > from a single device.
> > >=20
> > > I've seen several discussions and attempts in the past to allow a
> > > virtio-blk device leverage multiple iothreads, but around 2 years ago
> > > the discussions over this paused. So wanted to ask, are there any pla=
ns
> > > or anything in the works to address this limitation?
> > >=20
> > > I've seen that the spdk folks are heading in this direction with their
> > > vhost-blk implementation:
> > > https://review.spdk.io/gerrit/c/spdk/spdk/+/16068
> >=20
> > Hi Sagi,
> > Yes, there is an ongoing QEMU multi-queue block layer effort to make it
> > possible for multiple IOThreads to process disk I/O for the same
> > --blockdev in parallel.
>=20
> Great to know.
>=20
> > Most of my recent QEMU patches have been part of this effort. There is a
> > work-in-progress branch that supports mapping virtio-blk virtqueues to
> > specific IOThreads:
> > https://gitlab.com/stefanha/qemu/-/commits/virtio-blk-iothread-vq-mappi=
ng
>=20
> Thanks for the pointer.
>=20
> > The syntax is:
> >=20
> >    --device '{"driver":"virtio-blk-pci","iothread-vq-mapping":[{"iothre=
ad":"iothread0"},{"iothread":"iothread1"}],"drive":"drive0"}'
> >=20
> > This says "assign virtqueues round-robin to iothread0 and iothread1".
> > Half the virtqueues will be processed by iothread0 and the other half by
> > iothread1. There is also syntax for assigning specific virtqueues to
> > each IOThread, but usually the automatic round-robin assignment is all
> > that's needed.
> >=20
> > This work is not finished yet. Basic I/O (e.g. fio) works without
> > crashes, but expect to hit issues if you use blockjobs, hotplug, etc.
> >=20
> > Performance optimization work has just begun, so it won't deliver all
> > the benefits yet. I ran a benchmark yesterday where going from 1 to 2
> > IOThreads increased performance by 25%. That's much less than we're
> > aiming for; attaching two independent virtio-blk devices improves the
> > performance by ~100%. I know we can get there eventually. Some of the
> > bottlenecks are known (e.g. block statistics collection causes lock
> > contention) and others are yet to be investigated.
>=20
> Hmm, I rebased this branch on top of mainline master and ran a naive
> test, and it seems that performance regressed quite a bit :(
>=20
> I'm running this test on my laptop (Intel(R) Core(TM) i7-8650U CPU
> @1.90GHz), so this is more qualitative test for BW only.
> I use null_blk as the host device.
>=20
> With mainline master I get ~9GB/s 64k randread, and with your branch
> I get ~5GB/s, this is regardless of assigning iothreads (one or
> two) or not.
>=20
> my qemu command:
> taskset -c 0-3 build/qemu-system-x86_64 -cpu host -m 1G -enable-kvm -smp 4
> -drive
> file=3D/var/lib/libvirt/images/ubuntu-22/root-disk-clone.qcow2,format=3Dq=
cow2
> -drive if=3Dnone,id=3Ddrive0,cache=3Dnone,aio=3Dnative,format=3Draw,file=
=3D/dev/nullb0
> -device virtio-blk-pci,drive=3Ddrive0,scsi=3Doff -nographic
>=20
> my guest fio jobfile:
> --
> [global]
> group_reporting
> runtime=3D3000
> time_based
> loops=3D1
> direct=3D1
> invalidate=3D1
> randrepeat=3D0
> norandommap
> exitall
> cpus_allowed=3D0-3
> cpus_allowed_policy=3Dsplit
>=20
> [read]
> filename=3D/dev/vda
> numjobs=3D4
> iodepth=3D32
> bs=3D64k
> rw=3Drandread
> ioengine=3Dio_uring

Hi Sagi,
I have some news and pushed new code to my repo:
https://gitlab.com/stefanha/qemu/-/commits/virtio-blk-iothread-vq-mapping

This branch changes virtio-blk emulation to process requests in
coroutines. The reason for this change was to reduce the number of
coroutines created per request and minimize nested event loops
(AIO_WAIT_WHILE() -> aio_poll()). However, I found a performance issue
with the implementation: request coroutines were yielding and thereby
deferring request processing until later in the event loop.

The new code I pushed yesterday works around this by skipping request
serialization/tracking (bs->tracked_requests) for read requests. I only
modified the code for read requests because that's what I benchmark.
bs->tracked_requests and its lock, bs->reqs_lock, was causing contention
and coroutine yields.

A proper solution that keeps request tracking but makes it SMP-friendly
will need to be implemented, but for now this may solve the issues you
were seeing.

On my system 4 KB randread iodepth=3D64 numjobs=3D8 now achieves the same
IOPS on bare metal and in a VM. I'm not sure if this addresses the
performance issue you were seeing but there's a good chance it does.

I'll run your fio jobs and compare against qemu.git/master without my
patches.

(I also added the --device virtio-blk-pci,stats-enabled=3Doff,... option
to skip block I/O statistics collection. The statistics data is
protected by a lock that can cause contention when multiple IOThreads
process requests for the same device. In my testing it doesn't have much
of an effect on IOPS but I can see the difference in traces of futex
syscalls.)

Thanks,
Stefan

--bWutyjHoDF/0zi9I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTCiTcACgkQnKSrs4Gr
c8iw/wf7B6KVbhYULS4QrZL86/8nahh5D+LUCWwsblXZDwKK0HxjZ1O0ESewNu0w
3xb4v9GMofmkl8qo3NeSOc3WK+PkXXFBWwoAHY0GnqtGNl4s/qlcVmj6b7wIBGPT
2XECqGIRzxjgQ95LnMi2s7x0BkvBlvYTTnxaHJ+JbqxwwFU6CwghS4yjLpHNrp8t
a8IyYda2N6Ek/X6rjFmwQJexTv5wV6nirWBDRPepYgtdHJ60tS9FZjCrfvXtt7zL
7MT4PdjtFeKnII+mYgwxtiueHhchjRvhgg0IqgYe1MKT9Nm4AiDy621m+raLvFbN
LYY1Erl4RFpy9m6e9PZgCn6ilw2nGA==
=gzeg
-----END PGP SIGNATURE-----

--bWutyjHoDF/0zi9I--


