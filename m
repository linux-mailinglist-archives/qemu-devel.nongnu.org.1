Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 294F1818FB2
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 19:21:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFehI-0000y7-Cu; Tue, 19 Dec 2023 13:20:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rFehG-0000xg-P0
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:20:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rFehE-0000pX-Ty
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:20:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703010000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kdHrCBh+aFwerdanskMZMdWR+mM1k+MIbCkQXlcqavA=;
 b=eY2jYe+0BFXepB5ND/+a99KSyykuFCt9gwt7G4T41SDKTGM36pMi1c6MsUHMh5Ck/XkvLw
 33pFlf/FUCGtBl7Dm7vrBBu9Rl41SwfKHCbt0o5imgWo5dz6pvzFTf5/J8QUp+Vu2zlTEx
 C4nDiOxuOfbddzCkRC7uh+gmhccBEDk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-ng6tSX5TO9q6N0AkdP052Q-1; Tue, 19 Dec 2023 13:19:54 -0500
X-MC-Unique: ng6tSX5TO9q6N0AkdP052Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9391184B04B;
 Tue, 19 Dec 2023 18:19:53 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.175])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 81F601121306;
 Tue, 19 Dec 2023 18:19:48 +0000 (UTC)
Date: Tue, 19 Dec 2023 19:19:47 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Cleber Rosa <crosa@redhat.com>, Xie Changlong <xiechanglong.d@gmail.com>,
 Paul Durrant <paul@xen.org>, Ari Sundholm <ari@tuxera.com>,
 Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Wen Congyang <wencongyang2@huawei.com>, Alberto Garcia <berto@igalia.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Hanna Reitz <hreitz@redhat.com>,
 Zhang Chen <chen.zhang@intel.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Peter Xu <peterx@redhat.com>,
 Emanuele Giuseppe Esposito <eesposit@redhat.com>,
 Fam Zheng <fam@euphon.net>, Leonardo Bras <leobras@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 04/14] aio: make
 aio_context_acquire()/aio_context_release() a no-op
Message-ID: <ZYHew2poxuJJRyhC@redhat.com>
References: <20231205182011.1976568-1-stefanha@redhat.com>
 <20231205182011.1976568-5-stefanha@redhat.com>
 <ZYG2mSe1JWnC0tq_@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYG2mSe1JWnC0tq_@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Am 19.12.2023 um 16:28 hat Kevin Wolf geschrieben:
> Am 05.12.2023 um 19:20 hat Stefan Hajnoczi geschrieben:
> > aio_context_acquire()/aio_context_release() has been replaced by
> > fine-grained locking to protect state shared by multiple threads. The
> > AioContext lock still plays the role of balancing locking in
> > AIO_WAIT_WHILE() and many functions in QEMU either require that the
> > AioContext lock is held or not held for this reason. In other words, the
> > AioContext lock is purely there for consistency with itself and serves
> > no real purpose anymore.
> > 
> > Stop actually acquiring/releasing the lock in
> > aio_context_acquire()/aio_context_release() so that subsequent patches
> > can remove callers across the codebase incrementally.
> > 
> > I have performed "make check" and qemu-iotests stress tests across
> > x86-64, ppc64le, and aarch64 to confirm that there are no failures as a
> > result of eliminating the lock.
> > 
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > Acked-by: Kevin Wolf <kwolf@redhat.com>
> 
> I knew why I wasn't confident enough to give a R-b... This crashes
> qemu-storage-daemon in the qemu-iotests case graph-changes-while-io.
> 
> qemu-storage-daemon: ../nbd/server.c:2542: nbd_co_receive_request: Assertion `client->recv_coroutine == qemu_coroutine_self()' failed.
> 
> (gdb) bt
> #0  0x00007fdb00529884 in __pthread_kill_implementation () from /lib64/libc.so.6
> #1  0x00007fdb004d8afe in raise () from /lib64/libc.so.6
> #2  0x00007fdb004c187f in abort () from /lib64/libc.so.6
> #3  0x00007fdb004c179b in __assert_fail_base.cold () from /lib64/libc.so.6
> #4  0x00007fdb004d1187 in __assert_fail () from /lib64/libc.so.6
> #5  0x0000557f9f9534eb in nbd_co_receive_request (errp=0x7fdafc25eec0, request=0x7fdafc25ef10, req=0x7fdaf00159c0) at ../nbd/server.c:2542
> #6  nbd_trip (opaque=0x557fa0b33fa0) at ../nbd/server.c:2962
> #7  0x0000557f9faa416b in coroutine_trampoline (i0=<optimized out>, i1=<optimized out>) at ../util/coroutine-ucontext.c:177
> #8  0x00007fdb004efe90 in ?? () from /lib64/libc.so.6
> #9  0x00007fdafc35f680 in ?? ()
> #10 0x0000000000000000 in ?? ()
> (gdb) p *client
> $2 = {refcount = 4, close_fn = 0x557f9f95dc40 <nbd_blockdev_client_closed>, exp = 0x557fa0b30590, tlscreds = 0x0, tlsauthz = 0x0, sioc = 0x557fa0b33d90, ioc = 0x557fa0b33d90,
>   recv_coroutine = 0x7fdaf0015eb0, send_lock = {locked = 0, ctx = 0x0, from_push = {slh_first = 0x0}, to_pop = {slh_first = 0x0}, handoff = 0, sequence = 0, holder = 0x0},
>   send_coroutine = 0x0, read_yielding = false, quiescing = false, next = {tqe_next = 0x0, tqe_circ = {tql_next = 0x0, tql_prev = 0x557fa0b305e8}}, nb_requests = 1, closing = false,
>   check_align = 1, mode = NBD_MODE_EXTENDED, contexts = {exp = 0x557fa0b30590, count = 1, base_allocation = true, allocation_depth = false, bitmaps = 0x0}, opt = 7, optlen = 0}
> (gdb) p co_tls_current
> $3 = (Coroutine *) 0x7fdaf00061d0

This one isn't easy to debug...

The first problem here is that two nbd_trip() coroutines are scheduled
in the same iothread, and creating the second one overwrites
client->recv_coroutine, which triggers the assertion in the first one.

This can be fixed by introducing a new mutex in NBDClient and taking it
in nbd_client_receive_next_request() so that there is no race between
checking client->recv_coroutine != NULL and setting it to a new
coroutine. (Not entirely sure why two different threads are doing this,
maybe the main thread reentering in drained_end and the iothread waiting
for the next request?)

However, I'm seeing new assertion failures when I do that:
client->quiescing isn't set in the -EAGAIN case in nbd_trip(). I haven't
really figured out yet where this comes from. Taking the new NBDClient
lock in the drain functions and in nbd_trip() doesn't seem to be enough
to fix it anyway. Or maybe I didn't quite find the right places to take
it.

I'm not sure if the list of NBD clients needs a lock, too, or if it is
only ever accessed in the main thread, but that should be unrelated to
the assertion failures I'm seeing.

Kevin


