Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E61B0818B40
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 16:30:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFc1R-0002za-9X; Tue, 19 Dec 2023 10:28:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rFc1O-0002y5-Dj
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 10:28:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rFc1M-00048n-PS
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 10:28:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702999715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nh0cR65sPswywtceyI2IIIl2ItyyUhcWzRQaZepOBXU=;
 b=CIdsn2uPVlq85pOV7y4iEsmn3FLUHZgYBB1aEJDaAJjEPGWKU/25pdQ4Onr4yrYUCB3Ur5
 DRiUdkRbc4v3PKH9V002ygjoI962hASMxfNbFfhPmOdrGCMiqguwKA1WcnZBPcDz9Snddf
 rkJtHUrCQf8d+xeU/W1aSwbZs7MegIU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-6mtZLgXrPG-ASdwrw9encw-1; Tue,
 19 Dec 2023 10:28:32 -0500
X-MC-Unique: 6mtZLgXrPG-ASdwrw9encw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 05769383A0A1;
 Tue, 19 Dec 2023 15:28:31 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.175])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3201F492BC6;
 Tue, 19 Dec 2023 15:28:26 +0000 (UTC)
Date: Tue, 19 Dec 2023 16:28:25 +0100
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
Message-ID: <ZYG2mSe1JWnC0tq_@redhat.com>
References: <20231205182011.1976568-1-stefanha@redhat.com>
 <20231205182011.1976568-5-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205182011.1976568-5-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
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

Am 05.12.2023 um 19:20 hat Stefan Hajnoczi geschrieben:
> aio_context_acquire()/aio_context_release() has been replaced by
> fine-grained locking to protect state shared by multiple threads. The
> AioContext lock still plays the role of balancing locking in
> AIO_WAIT_WHILE() and many functions in QEMU either require that the
> AioContext lock is held or not held for this reason. In other words, the
> AioContext lock is purely there for consistency with itself and serves
> no real purpose anymore.
> 
> Stop actually acquiring/releasing the lock in
> aio_context_acquire()/aio_context_release() so that subsequent patches
> can remove callers across the codebase incrementally.
> 
> I have performed "make check" and qemu-iotests stress tests across
> x86-64, ppc64le, and aarch64 to confirm that there are no failures as a
> result of eliminating the lock.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Acked-by: Kevin Wolf <kwolf@redhat.com>

I knew why I wasn't confident enough to give a R-b... This crashes
qemu-storage-daemon in the qemu-iotests case graph-changes-while-io.

qemu-storage-daemon: ../nbd/server.c:2542: nbd_co_receive_request: Assertion `client->recv_coroutine == qemu_coroutine_self()' failed.

(gdb) bt
#0  0x00007fdb00529884 in __pthread_kill_implementation () from /lib64/libc.so.6
#1  0x00007fdb004d8afe in raise () from /lib64/libc.so.6
#2  0x00007fdb004c187f in abort () from /lib64/libc.so.6
#3  0x00007fdb004c179b in __assert_fail_base.cold () from /lib64/libc.so.6
#4  0x00007fdb004d1187 in __assert_fail () from /lib64/libc.so.6
#5  0x0000557f9f9534eb in nbd_co_receive_request (errp=0x7fdafc25eec0, request=0x7fdafc25ef10, req=0x7fdaf00159c0) at ../nbd/server.c:2542
#6  nbd_trip (opaque=0x557fa0b33fa0) at ../nbd/server.c:2962
#7  0x0000557f9faa416b in coroutine_trampoline (i0=<optimized out>, i1=<optimized out>) at ../util/coroutine-ucontext.c:177
#8  0x00007fdb004efe90 in ?? () from /lib64/libc.so.6
#9  0x00007fdafc35f680 in ?? ()
#10 0x0000000000000000 in ?? ()
(gdb) p *client
$2 = {refcount = 4, close_fn = 0x557f9f95dc40 <nbd_blockdev_client_closed>, exp = 0x557fa0b30590, tlscreds = 0x0, tlsauthz = 0x0, sioc = 0x557fa0b33d90, ioc = 0x557fa0b33d90,
  recv_coroutine = 0x7fdaf0015eb0, send_lock = {locked = 0, ctx = 0x0, from_push = {slh_first = 0x0}, to_pop = {slh_first = 0x0}, handoff = 0, sequence = 0, holder = 0x0},
  send_coroutine = 0x0, read_yielding = false, quiescing = false, next = {tqe_next = 0x0, tqe_circ = {tql_next = 0x0, tql_prev = 0x557fa0b305e8}}, nb_requests = 1, closing = false,
  check_align = 1, mode = NBD_MODE_EXTENDED, contexts = {exp = 0x557fa0b30590, count = 1, base_allocation = true, allocation_depth = false, bitmaps = 0x0}, opt = 7, optlen = 0}
(gdb) p co_tls_current
$3 = (Coroutine *) 0x7fdaf00061d0

Kevin


