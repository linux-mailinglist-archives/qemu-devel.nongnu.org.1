Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC68B7284A0
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 18:10:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7IBo-0004rz-Mj; Thu, 08 Jun 2023 12:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q7IBX-0004oj-PH
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 12:08:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q7IBU-0002de-4K
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 12:08:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686240501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4T/lqkgxqez4R/eqA0Y2hL/T3Ma44b3y37brHdrLNx8=;
 b=XgH685OozeTMgilbwso0LvwzhtSAFZR0Vtm6j0z4riREi3mlSBsqcn+P9lp/+fMtoqtaiB
 Fp4XkVTPVtHhR1Mdxob0HV3t2La+5ErPIdXIEesX5augMID++zibmtHsV6QhVlmBff09v3
 ErBjtHJYp1B8PdrxhvLtxEuJAQleX0c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-187-csaZvixqMqi0CUJ58SoZkg-1; Thu, 08 Jun 2023 12:08:20 -0400
X-MC-Unique: csaZvixqMqi0CUJ58SoZkg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B2856185A7A5;
 Thu,  8 Jun 2023 16:08:19 +0000 (UTC)
Received: from localhost (unknown [10.39.192.143])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 30EB3C154D1;
 Thu,  8 Jun 2023 16:08:18 +0000 (UTC)
Date: Thu, 8 Jun 2023 12:08:17 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>
Subject: Re: virtio-blk using a single iothread
Message-ID: <20230608160817.GK2138915@fedora>
References: <c206fa1d-077d-ae9b-476f-f43eec36a187@grimberg.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="acsPJ5MNP4a1Cl3v"
Content-Disposition: inline
In-Reply-To: <c206fa1d-077d-ae9b-476f-f43eec36a187@grimberg.me>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


--acsPJ5MNP4a1Cl3v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2023 at 10:40:57AM +0300, Sagi Grimberg wrote:
> Hey Stefan, Paolo,
>=20
> I just had a report from a user experiencing lower virtio-blk
> performance than he expected. This user is running virtio-blk on top of
> nvme-tcp device. The guest is running 12 CPU cores.
>=20
> The guest read/write throughput is capped at around 30% of the available
> throughput from the host (~800MB/s from the guest vs. 2800MB/s from the
> host - 25Gb/s nic). The workload running on the guest is a
> multi-threaded fio workload.
>=20
> What is observed is the fact that virtio-blk is using a single disk-wide
> iothread processing all the vqs. Specifically nvme-tcp (similar to other
> tcp based protocols) is negatively impacted by lack of thread
> concurrency that can distribute I/O requests to different TCP
> connections.
>=20
> We also attempted to move the iothread to a dedicated core, however that
> did yield any meaningful performance improvements). The reason appears
> to be less about CPU utilization on the iothread core, but more around
> single TCP connection serialization.
>=20
> Moving to io=3Dthreads does increase the throughput, however sacrificing
> latency significantly.
>=20
> So the user find itself with available host cpus and TCP connections
> that it could easily use to get maximum throughput, without the ability
> to leverage them. True, other guests will use different
> threads/contexts, however the goal here is to allow the full performance
> from a single device.
>=20
> I've seen several discussions and attempts in the past to allow a
> virtio-blk device leverage multiple iothreads, but around 2 years ago
> the discussions over this paused. So wanted to ask, are there any plans
> or anything in the works to address this limitation?
>=20
> I've seen that the spdk folks are heading in this direction with their
> vhost-blk implementation:
> https://review.spdk.io/gerrit/c/spdk/spdk/+/16068

Hi Sagi,
Yes, there is an ongoing QEMU multi-queue block layer effort to make it
possible for multiple IOThreads to process disk I/O for the same
--blockdev in parallel.

Most of my recent QEMU patches have been part of this effort. There is a
work-in-progress branch that supports mapping virtio-blk virtqueues to
specific IOThreads:
https://gitlab.com/stefanha/qemu/-/commits/virtio-blk-iothread-vq-mapping

The syntax is:

  --device '{"driver":"virtio-blk-pci","iothread-vq-mapping":[{"iothread":"=
iothread0"},{"iothread":"iothread1"}],"drive":"drive0"}'

This says "assign virtqueues round-robin to iothread0 and iothread1".
Half the virtqueues will be processed by iothread0 and the other half by
iothread1. There is also syntax for assigning specific virtqueues to
each IOThread, but usually the automatic round-robin assignment is all
that's needed.

This work is not finished yet. Basic I/O (e.g. fio) works without
crashes, but expect to hit issues if you use blockjobs, hotplug, etc.

Performance optimization work has just begun, so it won't deliver all
the benefits yet. I ran a benchmark yesterday where going from 1 to 2
IOThreads increased performance by 25%. That's much less than we're
aiming for; attaching two independent virtio-blk devices improves the
performance by ~100%. I know we can get there eventually. Some of the
bottlenecks are known (e.g. block statistics collection causes lock
contention) and others are yet to be investigated.

The Ansible playbook, libvirt XML, fio jobs, etc for the benchmark are
available here:
https://gitlab.com/stefanha/virt-playbooks/-/tree/8379665537c47c0901f426f0b=
9333ade8236ac3b

You are welcome to give the QEMU patches a try. I will be away next week
to attend KVM Forum, so I may not respond to emails quickly but am
interested in what you find.

Stefan

--acsPJ5MNP4a1Cl3v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmSB/PEACgkQnKSrs4Gr
c8gKCwf+MqLLA27ftwRKm6LKghDOhyW14UMiq3mmQ2Ar4E6JXr31SqQDvwH/g0PW
HL02pHvA67xGXAfrJ+X9xGYV6MdiU8uw1qYu17IjWgMy1yk054i21+8DzyR4z0M7
4o4ANJn4ZovDs4AVToiVlKn0UKHTBM3XTuVISXiDf8yklgQWStUet1M9HJVAgQfT
FwNToQ4uoR6mOmW0uOcupXJ/XV6RQ26ZBUbduMZauc8zX4wNIseDO0K9ufiffRS7
DSz8heKZJyY15WKPOmz9VDWIgZRFKGFFALrdmRKYmwZUYw+dVuShj63qr0V96vb6
2NnYmQsSpn2wJKonPXSq5hyX6I+O+w==
=MKn1
-----END PGP SIGNATURE-----

--acsPJ5MNP4a1Cl3v--


