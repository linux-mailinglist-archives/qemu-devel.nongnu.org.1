Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0965803AA1
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 17:44:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAC2l-0005fJ-4h; Mon, 04 Dec 2023 11:43:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rAC2h-0005eX-LN
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 11:43:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rAC2e-0003eI-Vl
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 11:43:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701708211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3YLm9n3XqPtvjQkcHAh7uIb8gn9roUG29FXjHLYkd/I=;
 b=MVO/Mmk3mH/vRZPU9uCv3HeMtpLC7LsP4JZQQYYYh2z4UyzJKnUKn6DZq1vYVSpI9UrnBw
 4yAihWeF8sprOcrvCH+ZkC/eyDmKcSK2wuqbEfWTIXtTZSZlb0vCuhO2HoMXmYEXzK2yC1
 bj/MLG5Wx83B9P+v8QwcBSef9FbnDvQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-dkZ0IOFZO0yaKNgXPg_guw-1; Mon, 04 Dec 2023 11:43:28 -0500
X-MC-Unique: dkZ0IOFZO0yaKNgXPg_guw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E3F6C812C2C;
 Mon,  4 Dec 2023 16:43:27 +0000 (UTC)
Received: from localhost (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 48A11493113;
 Mon,  4 Dec 2023 16:43:27 +0000 (UTC)
Date: Mon, 4 Dec 2023 11:30:02 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH 1/4] scsi: only access SCSIDevice->requests from one thread
Message-ID: <20231204163002.GI1492005@fedora>
References: <20231123194931.171598-1-stefanha@redhat.com>
 <20231123194931.171598-2-stefanha@redhat.com>
 <ZWoDwd-EeuAKyDE2@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zLGaBeEKlGOXjyl6"
Content-Disposition: inline
In-Reply-To: <ZWoDwd-EeuAKyDE2@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
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


--zLGaBeEKlGOXjyl6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 01, 2023 at 05:03:13PM +0100, Kevin Wolf wrote:
> Am 23.11.2023 um 20:49 hat Stefan Hajnoczi geschrieben:
> > Stop depending on the AioContext lock and instead access
> > SCSIDevice->requests from only one thread at a time:
> > - When the VM is running only the BlockBackend's AioContext may access
> >   the requests list.
> > - When the VM is stopped only the main loop may access the requests
> >   list.
> >=20
> > These constraints protect the requests list without the need for locking
> > in the I/O code path.
> >=20
> > Note that multiple IOThreads are not supported yet because the code
> > assumes all SCSIRequests are executed from a single AioContext. Leave
> > that as future work.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  include/hw/scsi/scsi.h |   7 +-
> >  hw/scsi/scsi-bus.c     | 174 ++++++++++++++++++++++++++++-------------
> >  2 files changed, 124 insertions(+), 57 deletions(-)
> >=20
> > diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
> > index 3692ca82f3..10c4e8288d 100644
> > --- a/include/hw/scsi/scsi.h
> > +++ b/include/hw/scsi/scsi.h
> > @@ -69,14 +69,19 @@ struct SCSIDevice
> >  {
> >      DeviceState qdev;
> >      VMChangeStateEntry *vmsentry;
> > -    QEMUBH *bh;
> >      uint32_t id;
> >      BlockConf conf;
> >      SCSISense unit_attention;
> >      bool sense_is_ua;
> >      uint8_t sense[SCSI_SENSE_BUF_SIZE];
> >      uint32_t sense_len;
> > +
> > +    /*
> > +     * The requests list is only accessed from the AioContext that exe=
cutes
> > +     * requests or from the main loop when IOThread processing is stop=
ped.
> > +     */
> >      QTAILQ_HEAD(, SCSIRequest) requests;
> > +
> >      uint32_t channel;
> >      uint32_t lun;
> >      int blocksize;
> > diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
> > index fc4b77fdb0..b8bfde9565 100644
> > --- a/hw/scsi/scsi-bus.c
> > +++ b/hw/scsi/scsi-bus.c
> > @@ -85,6 +85,82 @@ SCSIDevice *scsi_device_get(SCSIBus *bus, int channe=
l, int id, int lun)
> >      return d;
> >  }
> > =20
> > +/*
> > + * Invoke @fn() for each enqueued request in device @s. Must be called=
 from the
> > + * main loop thread while the guest is stopped. This is only suitable =
for
> > + * vmstate ->put(), use scsi_device_for_each_req_async() for other cas=
es.
> > + */
> > +static void scsi_device_for_each_req_sync(SCSIDevice *s,
> > +                                          void (*fn)(SCSIRequest *, vo=
id *),
> > +                                          void *opaque)
> > +{
> > +    SCSIRequest *req;
> > +    SCSIRequest *next_req;
> > +
> > +    assert(!runstate_is_running());
> > +    assert(qemu_in_main_thread());
> > +
> > +    QTAILQ_FOREACH_SAFE(req, &s->requests, next, next_req) {
> > +        fn(req, opaque);
> > +    }
> > +}
> > +
> > +typedef struct {
> > +    SCSIDevice *s;
> > +    void (*fn)(SCSIRequest *, void *);
> > +    void *fn_opaque;
> > +} SCSIDeviceForEachReqAsyncData;
> > +
> > +static void scsi_device_for_each_req_async_bh(void *opaque)
> > +{
> > +    g_autofree SCSIDeviceForEachReqAsyncData *data =3D opaque;
> > +    SCSIDevice *s =3D data->s;
> > +    SCSIRequest *req;
> > +    SCSIRequest *next;
> > +
> > +    /*
> > +     * It is unlikely that the AioContext will change before this BH i=
s called,
> > +     * but if it happens then ->requests must not be accessed from this
> > +     * AioContext.
> > +     */
>=20
> What is the scenario where this happens? I would have expected that
> switching the AioContext of a node involves draining the node first,
> which would execute this BH before the context changes.

I don't think aio_poll() is invoked by bdrv_drained_begin() when there
are no requests in flight. In that case the BH could remain pending
across bdrv_drained_begin()/bdrv_drained_end().

> The other option I see is an empty BlockBackend, which can change its
> AioContext without polling BHs, but in that case there is no connection
> to other users, so the only change could come from virtio-scsi itself.
> If there is such a case, it would probably be helpful to be specific in
> the comment.
>
> > +    if (blk_get_aio_context(s->conf.blk) =3D=3D qemu_get_current_aio_c=
ontext()) {
> > +        QTAILQ_FOREACH_SAFE(req, &s->requests, next, next) {
> > +            data->fn(req, data->fn_opaque);
> > +        }
> > +    }
>=20
> Of course, if the situation does happen, the question is why just doing
> nothing is correct. Wouldn't that mean that the guest still sees stuck
> requests?
>=20
> Would rescheduling the BH in the new context be better?

In the case where there are no requests it is correct to do nothing, but
it's not a general solution.

> > +
> > +    /* Drop the reference taken by scsi_device_for_each_req_async() */
> > +    object_unref(OBJECT(s));
> > +}
> > +
> > +/*
> > + * Schedule @fn() to be invoked for each enqueued request in device @s=
=2E @fn()
> > + * runs in the AioContext that is executing the request.
> > + */
> > +static void scsi_device_for_each_req_async(SCSIDevice *s,
> > +                                           void (*fn)(SCSIRequest *, v=
oid *),
> > +                                           void *opaque)
>=20
> If we keep the behaviour above (doesn't do anything if the AioContext
> changes), then I think it needs to be documented for this function and
> callers should be explicit about why it's okay.

I think your suggestion to reschedule in the new AioContext is best.

Stefan

--zLGaBeEKlGOXjyl6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVt/ooACgkQnKSrs4Gr
c8jqVwf/QPSd/gbtzBYeFVZGgEXaYpfEvE0YFSnu1+nS95axBB7kKpId6e11mTib
CySQQrwd/dDQ/3YRp5oxLyqmKneeVqqwonY/S5U3LgF8OqjcEUGrJOA0Nt2WLyIH
N19E6fOUho4bAZFAwxdLCmJQKtgH19OyR5XSA0RD2RfKA6ccMfh6KK8crrISKaez
MQjJXsfpD2EEvlauBl8PBlVw1C94htYl3t4wvLQ6Ste44x+H4zTAqX3nclxKF03t
pz8gFJPj1rvnlUNWo4BbNSmi3ET8VNDLS4bIMfWwrFhkFOh+BjWbI0jot0DIWgLa
BvcIRd8dwU0AQQYdWyn+79RbgQr4ug==
=XrIZ
-----END PGP SIGNATURE-----

--zLGaBeEKlGOXjyl6--


