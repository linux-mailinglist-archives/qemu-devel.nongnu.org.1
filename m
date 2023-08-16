Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D74977EB8C
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 23:18:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWNsy-0005lC-EN; Wed, 16 Aug 2023 17:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qWNsp-0005kf-C5
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 17:16:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qWNsl-0000Hc-FR
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 17:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692220606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bp6pJfdTKkRTTmGllxZ5SZIB8BjMtuHMHRs8hGSriFk=;
 b=bxsr9UZYgzI86vNBajsl0Hv+xBg/htVyamN/DBT7RAbB9ACNh3xT0zvitbLzOdVcKZlcZX
 FhH40rJGUMk7y6S0ztu8m+m1C+Jf2PlahsIOx78tUAiD5BT7g73tTa5d7AhN+Wwob2FFda
 PB/6BB/GhbM0XsQo6Xy7nafAzhxd75o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-56-tJ0e5KQgNUivMZhemznXyw-1; Wed, 16 Aug 2023 17:16:42 -0400
X-MC-Unique: tJ0e5KQgNUivMZhemznXyw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 255F08015AA;
 Wed, 16 Aug 2023 21:16:42 +0000 (UTC)
Received: from localhost (unknown [10.39.193.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 05620568FF;
 Wed, 16 Aug 2023 21:16:40 +0000 (UTC)
Date: Wed, 16 Aug 2023 17:16:39 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Julia Suvorova <jusual@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/2] virtio: use blk_io_plug_call() in
 virtio_irqfd_notify()
Message-ID: <20230816211639.GD3454448@fedora>
References: <20230815120805.3235166-1-stefanha@redhat.com>
 <20230815120805.3235166-2-stefanha@redhat.com>
 <c086667a-1d52-a62f-577c-e13fdd7504e1@ovn.org>
 <20230816153010.GA3437291@fedora>
 <3e2c2433-df5c-152e-70de-7c6cfe7ea4af@ovn.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="89i+u35cOmgPCQOP"
Content-Disposition: inline
In-Reply-To: <3e2c2433-df5c-152e-70de-7c6cfe7ea4af@ovn.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--89i+u35cOmgPCQOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2023 at 08:30:58PM +0200, Ilya Maximets wrote:
> On 8/16/23 17:30, Stefan Hajnoczi wrote:
> > On Wed, Aug 16, 2023 at 03:36:32PM +0200, Ilya Maximets wrote:
> >> On 8/15/23 14:08, Stefan Hajnoczi wrote:
> >>> virtio-blk and virtio-scsi invoke virtio_irqfd_notify() to send Used
> >>> Buffer Notifications from an IOThread. This involves an eventfd
> >>> write(2) syscall. Calling this repeatedly when completing multiple I/O
> >>> requests in a row is wasteful.
> >>
> >> Hi, Stefan.  This is an interesting change!
> >>
> >> There is more or less exactly the same problem with fast network backe=
nds
> >> and I was playing around with similar ideas in this area while working=
 on
> >> af-xdp network backend recently.  Primarily, implementation of the Rx =
BH
> >> for virtio-net device and locking the RCU before passing packets from =
the
> >> backend to the device one by one.
> >>
> >>>
> >>> Use the blk_io_plug_call() API to batch together virtio_irqfd_notify()
> >>> calls made during Linux AIO (aio=3Dnative) or io_uring (aio=3Dio_urin=
g)
> >>> completion processing. Do not modify the thread pool (aio=3Dthreads) =
to
> >>> avoid introducing a dependency from util/ onto the block layer.
> >>
> >> But you're introducing a dependency from generic virtio code onto the
> >> block layer in this patch.  This seem to break the module abstraction.
> >>
> >> It looks like there are 2 options to resolve the semantics issue here:
> >=20
> > Yes, it's a layering violation.
> >=20
> >>
> >> 1. Move virtio_notify_irqfd() from virtio.c down to the block layer.
> >>    Block layer is the only user, so that may be justified, but it
> >>    doesn't seem like a particularly good solution.  (I'm actually not
> >>    sure why block devices are the only ones using this function...)
> >=20
> > Yes, this is the easiest way to avoid the layering violation for now.
> >=20
> > The virtio_notify_irqfd() API is necessary when running in an IOThread
> > because the normal QEMU irq API must run under the Big QEMU Lock. Block
> > devices are the only ones that raise interrupts from IOThreads at the
> > moment.
>=20
> Ack.  Thanks for explanation!
>=20
> >=20
> >>
> >> 2. Move and rename the block/plug library somewhere generic.  The plug
> >>    library seems to not have any dependencies on a block layer, other
> >>    than a name, so it should not be hard to generalize it (well, the
> >>    naming might be hard).
> >=20
> > Yes, it should be possible to make it generic quite easily. I will give
> > this a try in the next version of the patch.
>=20
> OK.  Sounds good to me.
>=20
> >=20
> >> In general, while looking at the plug library, it seems to do what is
> >> typically implemented via RCU frameworks - the delayed function call.
> >> The only difference is that RCU doesn't check for duplicates and the
> >> callbacks are global.  Should not be hard to add some new functionality
> >> to RCU framework in order to address these, e.g. rcu_call_local() for
> >> calls that should be executed once the current thread exits its own
> >> critical section.
> >=20
> > This rcu_call_local() idea is unrelated to Read Copy Update, so I don't
> > think it should be part of the RCU API.
>=20
> Agreed.
>=20
> > Another deferred function call mechanism is QEMUBH. It already supports
> > coalescing. However, BHs are invoked once per AioContext event loop
> > iteration and there is no way invoke the BH earlier. Also the BH pointer
> > needs to be passed to every function that wishes to schedule a deferred
> > call, which can be tedious (e.g. block/linux-aio.c should defer the
> > io_submit(2) syscall until the end of virtio-blk request processing -
> > there are a lot of layers of code between those two components).
> >=20
> >>
> >> Using RCU for non-RCU-protected things might be considered as an abuse.
> >> However, we might solve two issues in one shot if instead of entering
> >> blk_io_plug/unplug section we will enter an RCU critical section and
> >> call callbacks at the exit.  The first issue is the notification batch=
ing
> >> that this patch is trying to fix, the second is an excessive number of
> >> thread fences on RCU exits every time virtio_notify_irqfd() and other
> >> virtio functions are invoked.  The second issue can be avoided by using
> >> RCU_READ_LOCK_GUARD() in completion functions.  Not sure if that will
> >> improve performance, but it definitely removes a lot of noise from the
> >> perf top for network backends.  This makes the code a bit less explicit
> >> though, the lock guard will definitely need a comment.  Though, the re=
ason
> >> for blk_io_plug() calls is not fully clear for a module code alone eit=
her.
> >=20
> > util/aio-posix.c:run_poll_handlers() has a top-level
> > RCU_READ_LOCK_GUARD() for this reason.
>=20
> Nice, didn't know that.
>=20
> > Maybe we should do the same
> > around aio_bh_poll() + aio_dispatch_ready_handlers() in
> > util/aio-posix.c:aio_poll()? The downside is that latency-sensitive
> > call_rcu() callbacks perform worse.
>=20
> "latency-sensitive call_rcu() callback" is a bit of an oxymoron.
> There is no real way to tell when the other thread will exit the
> critical section.  But I'm not familiar with the code enough to
> make a decision here.

I see your point :).

Another issue occurred to me: drain_call_rcu() is invoked by some QEMU
monitor commands and the monitor runs in QEMU's event loop.
drain_call_rcu() waits for the call_rcu thread, which needs
synchronize_rcu() to finish, so I guess it will hang if called with the
RCU read lock held. There is the potential for a deadlock here. It might
be solvable.

>=20
> >>
> >> I'm not sure what is the best way forward.  I'm trying to figure out
> >> that myself, since a similar solution will in the end be needed for
> >> network backends and so it might be better to have something more gene=
ric.
> >> What do you think?
> >=20
> > I suggest moving blk_io_plug() to util/ and renaming it to
> > defer_begin/defer_end()/defer_call(). The interface and implementation
> > can also be improved as needed for other users.
>=20
> Sounds good to me.
>=20
> >=20
> >>
> >>>
> >>> Behavior is unchanged for emulated devices that do not use blk_io_plu=
g()
> >>> since blk_io_plug_call() immediately invokes the callback when called
> >>> outside a blk_io_plug()/blk_io_unplug() region.
> >>>
> >>> fio rw=3Drandread bs=3D4k iodepth=3D64 numjobs=3D8 IOPS increases by =
~9% with a
> >>> single IOThread and 8 vCPUs. iodepth=3D1 decreases by ~1% but this co=
uld
> >>> be noise. Detailed performance data and configuration specifics are
> >>> available here:
> >>> https://gitlab.com/stefanha/virt-playbooks/-/tree/blk_io_plug-irqfd
> >>>
> >>> This duplicates the BH that virtio-blk uses for batching. The next
> >>> commit will remove it.
> >>
> >> I'm likely missing something, but could you explain why it is safe to
> >> batch unconditionally here?  The current BH code, as you mentioned in
> >> the second patch, is only batching if EVENT_IDX is not set.
> >> Maybe worth adding a few words in the commit message for people like
> >> me, who are a bit rusty on QEMU/virtio internals. :)
> >=20
> > The BH is condition on EVENT_IDX not for correctness/safety, but for
> > performance.
>=20
> I see.  Thanks!
> Do you think using deferred call in the non-irqfd virtio_notify()
> will make sense?  Not in this patch set, but in general, e.g. for
> a future use from a network backend.

Yes, a deferred call may improve performance in the non-irqfd case too.

> > Commit 12c1c7d7cefb4dbffeb5712e75a33e4692f0a76b
> > ("virtio-blk: dataplane: Don't batch notifications if EVENT_IDX is
> > present") argued that VIRTIO's EVENT_IDX feature already provides
> > batching so the BH is not needed in that case.
> >=20
> > Actually I'm not sure exactly why deferring virtio_notify_irqfd() helps,
> > but IOPS improves on my machine. One theory:
> >=20
> > Linux drivers/virtio/virtio_ring.c:virtqueue_get_buf_ctx_split() (or the
> > end of the irq handler function) updates EVENT_IDX so that QEMU will
> > inject an interrupt again when the next request is completed. If the
> > vCPU and QEMU are running in parallel, then N requests could result in N
> > interrupts when the vCPU updates EVENT_IDX before QEMU completes the
> > next request. Maybe that's why I see better performance when deferring
> > virtio_notify_irqfd().
>=20
> Sounds very plausible.  I actually see only latency and interrupt
> count measurements in either 12c1c7d7cefb ("virtio-blk: dataplane:
> Don't batch notifications if EVENT_IDX is present") or 5b2ffbe4d998
> ("virtio-blk: dataplane: notify guest as a batch") as well as in
> mailing list discussions about these changes.  So, it's possible that
> impact of batching on throughput in terms of IOPS was not actually
> measured before (it porobably was, but not published).
>=20
> >=20
> > (I'm thinking of experimenting with rate limiting irq injection so that
> > it's possible to batch even more efficienctly but I worry that it will
> > be hard to avoid latency vs throughput regressions.)
> >=20
> > Stefan
> >=20
> >>
> >> Best regards, Ilya Maximets.
> >>
> >>>
> >>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> >>> ---
> >>>  block/io_uring.c   |  6 ++++++
> >>>  block/linux-aio.c  |  4 ++++
> >>>  hw/virtio/virtio.c | 10 +++++++++-
> >>>  3 files changed, 19 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/block/io_uring.c b/block/io_uring.c
> >>> index 69d9820928..749cf83934 100644
> >>> --- a/block/io_uring.c
> >>> +++ b/block/io_uring.c
> >>> @@ -124,6 +124,9 @@ static void luring_process_completions(LuringStat=
e *s)
> >>>  {
> >>>      struct io_uring_cqe *cqes;
> >>>      int total_bytes;
> >>> +
> >>> +    blk_io_plug();
> >>> +
> >>>      /*
> >>>       * Request completion callbacks can run the nested event loop.
> >>>       * Schedule ourselves so the nested event loop will "see" remain=
ing
> >>> @@ -216,7 +219,10 @@ end:
> >>>              aio_co_wake(luringcb->co);
> >>>          }
> >>>      }
> >>> +
> >>>      qemu_bh_cancel(s->completion_bh);
> >>> +
> >>> +    blk_io_unplug();
> >>>  }
> >>> =20
> >>>  static int ioq_submit(LuringState *s)
> >>> diff --git a/block/linux-aio.c b/block/linux-aio.c
> >>> index 561c71a9ae..cef3d6b1c7 100644
> >>> --- a/block/linux-aio.c
> >>> +++ b/block/linux-aio.c
> >>> @@ -204,6 +204,8 @@ static void qemu_laio_process_completions(LinuxAi=
oState *s)
> >>>  {
> >>>      struct io_event *events;
> >>> =20
> >>> +    blk_io_plug();
> >>> +
> >>>      /* Reschedule so nested event loops see currently pending comple=
tions */
> >>>      qemu_bh_schedule(s->completion_bh);
> >>> =20
> >>> @@ -230,6 +232,8 @@ static void qemu_laio_process_completions(LinuxAi=
oState *s)
> >>>       * own `for` loop.  If we are the last all counters droped to ze=
ro. */
> >>>      s->event_max =3D 0;
> >>>      s->event_idx =3D 0;
> >>> +
> >>> +    blk_io_unplug();
> >>>  }
> >>> =20
> >>>  static void qemu_laio_process_completions_and_submit(LinuxAioState *=
s)
> >>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> >>> index 309038fd46..a691e8526b 100644
> >>> --- a/hw/virtio/virtio.c
> >>> +++ b/hw/virtio/virtio.c
> >>> @@ -28,6 +28,7 @@
> >>>  #include "hw/virtio/virtio-bus.h"
> >>>  #include "hw/qdev-properties.h"
> >>>  #include "hw/virtio/virtio-access.h"
> >>> +#include "sysemu/block-backend.h"
> >>>  #include "sysemu/dma.h"
> >>>  #include "sysemu/runstate.h"
> >>>  #include "virtio-qmp.h"
> >>> @@ -2426,6 +2427,13 @@ static bool virtio_should_notify(VirtIODevice =
*vdev, VirtQueue *vq)
> >>>      }
> >>>  }
> >>> =20
> >>> +/* Batch irqs while inside a blk_io_plug()/blk_io_unplug() section */
> >>> +static void virtio_notify_irqfd_unplug_fn(void *opaque)
> >>> +{
> >>> +    EventNotifier *notifier =3D opaque;
> >>> +    event_notifier_set(notifier);
> >>> +}
> >>> +
> >>>  void virtio_notify_irqfd(VirtIODevice *vdev, VirtQueue *vq)
> >>>  {
> >>>      WITH_RCU_READ_LOCK_GUARD() {
> >>> @@ -2452,7 +2460,7 @@ void virtio_notify_irqfd(VirtIODevice *vdev, Vi=
rtQueue *vq)
> >>>       * to an atomic operation.
> >>>       */
> >>>      virtio_set_isr(vq->vdev, 0x1);
> >>> -    event_notifier_set(&vq->guest_notifier);
> >>> +    blk_io_plug_call(virtio_notify_irqfd_unplug_fn, &vq->guest_notif=
ier);
>=20
> There is a trace call in this function.  Should we move it or add a new
> trace call to the callback?  The trace was printed right before the
> actual notification before, and now the actual notification is delayed
> potentially reducing the usefulness of the trace.
>=20
> >>>  }
> >>> =20
> >>>  static void virtio_irq(VirtQueue *vq)
> >>
>=20

--89i+u35cOmgPCQOP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTdPLcACgkQnKSrs4Gr
c8jYQAf6A65Yna+pSaE9k1l50/eXwR8ah9UAV55MhnDVTaxG6JfEXK8O73MV0WzL
bLopDCeueFkNPEWy9nRE4JXbnov4HocfroNfcvG0NTkdH8lisU5YWArusmJ9Q9ua
xzzFEbvZH6XspZkOCnDNOzbnxlfbXzZo3uNgZylaJ+J/Nc3QPy8hBzsPFNK0Oiyl
T+BbBmPpo14ubvZRwYUE0NIXJfJxCw+U/0fs8bZ8P87YPACpgxvKkO+NsbS2JJjC
ulgIyUhXAbr5jOs2/N/X0YYA1kvWXqX3WuY6+mEqoUJ/e0k3F83mReBoHF+fQE68
cICKxGSJopurghp5qRA+47q9JDfilw==
=LKod
-----END PGP SIGNATURE-----

--89i+u35cOmgPCQOP--


