Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0BF804FAD
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 11:01:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rASED-0003DW-5F; Tue, 05 Dec 2023 05:00:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rASE1-0003DC-HL
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 05:00:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rASDy-0007Zl-6x
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 05:00:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701770417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P29+OP8mtK4lYCsIjQ5WcTRc6MzmwNvNSuJmgm4Cx4E=;
 b=aUSO7avtuIgyiJwBbC3z5jIrUGA0Tn+gC9gV1kPfj4x5GNZVh7YEukZOljxtvjP7DofAzZ
 sMDPLeIs3DDE6xKOVnfd5OuhwOZ1jzNX4ncxMC//tkYmynrRJiAJjIoOgHIJ717aPmOr6R
 w2+jWZvVScbqgH2+5UDTUFkjZXxBGls=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-g-OAht1UPrW02mYyWsQMng-1; Tue, 05 Dec 2023 05:00:12 -0500
X-MC-Unique: g-OAht1UPrW02mYyWsQMng-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A093101A551;
 Tue,  5 Dec 2023 10:00:12 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.43])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A304140C6EB9;
 Tue,  5 Dec 2023 10:00:10 +0000 (UTC)
Date: Tue, 5 Dec 2023 11:00:09 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH 1/4] scsi: only access SCSIDevice->requests from one thread
Message-ID: <ZW70qXZ-xn5LSY67@redhat.com>
References: <20231123194931.171598-1-stefanha@redhat.com>
 <20231123194931.171598-2-stefanha@redhat.com>
 <ZWoDwd-EeuAKyDE2@redhat.com> <20231204163002.GI1492005@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="x7fWRZBeOjyImcXF"
Content-Disposition: inline
In-Reply-To: <20231204163002.GI1492005@fedora>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


--x7fWRZBeOjyImcXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 04.12.2023 um 17:30 hat Stefan Hajnoczi geschrieben:
> On Fri, Dec 01, 2023 at 05:03:13PM +0100, Kevin Wolf wrote:
> > Am 23.11.2023 um 20:49 hat Stefan Hajnoczi geschrieben:
> > > Stop depending on the AioContext lock and instead access
> > > SCSIDevice->requests from only one thread at a time:
> > > - When the VM is running only the BlockBackend's AioContext may access
> > >   the requests list.
> > > - When the VM is stopped only the main loop may access the requests
> > >   list.
> > >=20
> > > These constraints protect the requests list without the need for lock=
ing
> > > in the I/O code path.
> > >=20
> > > Note that multiple IOThreads are not supported yet because the code
> > > assumes all SCSIRequests are executed from a single AioContext. Leave
> > > that as future work.
> > >=20
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > ---
> > >  include/hw/scsi/scsi.h |   7 +-
> > >  hw/scsi/scsi-bus.c     | 174 ++++++++++++++++++++++++++++-----------=
--
> > >  2 files changed, 124 insertions(+), 57 deletions(-)
> > >=20
> > > diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
> > > index 3692ca82f3..10c4e8288d 100644
> > > --- a/include/hw/scsi/scsi.h
> > > +++ b/include/hw/scsi/scsi.h
> > > @@ -69,14 +69,19 @@ struct SCSIDevice
> > >  {
> > >      DeviceState qdev;
> > >      VMChangeStateEntry *vmsentry;
> > > -    QEMUBH *bh;
> > >      uint32_t id;
> > >      BlockConf conf;
> > >      SCSISense unit_attention;
> > >      bool sense_is_ua;
> > >      uint8_t sense[SCSI_SENSE_BUF_SIZE];
> > >      uint32_t sense_len;
> > > +
> > > +    /*
> > > +     * The requests list is only accessed from the AioContext that e=
xecutes
> > > +     * requests or from the main loop when IOThread processing is st=
opped.
> > > +     */
> > >      QTAILQ_HEAD(, SCSIRequest) requests;
> > > +
> > >      uint32_t channel;
> > >      uint32_t lun;
> > >      int blocksize;
> > > diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
> > > index fc4b77fdb0..b8bfde9565 100644
> > > --- a/hw/scsi/scsi-bus.c
> > > +++ b/hw/scsi/scsi-bus.c
> > > @@ -85,6 +85,82 @@ SCSIDevice *scsi_device_get(SCSIBus *bus, int chan=
nel, int id, int lun)
> > >      return d;
> > >  }
> > > =20
> > > +/*
> > > + * Invoke @fn() for each enqueued request in device @s. Must be call=
ed from the
> > > + * main loop thread while the guest is stopped. This is only suitabl=
e for
> > > + * vmstate ->put(), use scsi_device_for_each_req_async() for other c=
ases.
> > > + */
> > > +static void scsi_device_for_each_req_sync(SCSIDevice *s,
> > > +                                          void (*fn)(SCSIRequest *, =
void *),
> > > +                                          void *opaque)
> > > +{
> > > +    SCSIRequest *req;
> > > +    SCSIRequest *next_req;
> > > +
> > > +    assert(!runstate_is_running());
> > > +    assert(qemu_in_main_thread());
> > > +
> > > +    QTAILQ_FOREACH_SAFE(req, &s->requests, next, next_req) {
> > > +        fn(req, opaque);
> > > +    }
> > > +}
> > > +
> > > +typedef struct {
> > > +    SCSIDevice *s;
> > > +    void (*fn)(SCSIRequest *, void *);
> > > +    void *fn_opaque;
> > > +} SCSIDeviceForEachReqAsyncData;
> > > +
> > > +static void scsi_device_for_each_req_async_bh(void *opaque)
> > > +{
> > > +    g_autofree SCSIDeviceForEachReqAsyncData *data =3D opaque;
> > > +    SCSIDevice *s =3D data->s;
> > > +    SCSIRequest *req;
> > > +    SCSIRequest *next;
> > > +
> > > +    /*
> > > +     * It is unlikely that the AioContext will change before this BH=
 is called,
> > > +     * but if it happens then ->requests must not be accessed from t=
his
> > > +     * AioContext.
> > > +     */
> >=20
> > What is the scenario where this happens? I would have expected that
> > switching the AioContext of a node involves draining the node first,
> > which would execute this BH before the context changes.
>=20
> I don't think aio_poll() is invoked by bdrv_drained_begin() when there
> are no requests in flight. In that case the BH could remain pending
> across bdrv_drained_begin()/bdrv_drained_end().

Hm, I wonder if that is actually a bug. Without executing pending BHs,
you can't be sure that nothing touches the node any more.

Before commit 5e8ac217, we always polled at least once, though I think
that was an unintentional side effect.

> > The other option I see is an empty BlockBackend, which can change its
> > AioContext without polling BHs, but in that case there is no connection
> > to other users, so the only change could come from virtio-scsi itself.
> > If there is such a case, it would probably be helpful to be specific in
> > the comment.
> >
> > > +    if (blk_get_aio_context(s->conf.blk) =3D=3D qemu_get_current_aio=
_context()) {
> > > +        QTAILQ_FOREACH_SAFE(req, &s->requests, next, next) {
> > > +            data->fn(req, data->fn_opaque);
> > > +        }
> > > +    }
> >=20
> > Of course, if the situation does happen, the question is why just doing
> > nothing is correct. Wouldn't that mean that the guest still sees stuck
> > requests?
> >=20
> > Would rescheduling the BH in the new context be better?
>=20
> In the case where there are no requests it is correct to do nothing,
> but it's not a general solution.

Why is it correct when there are no requests? I can see this for
scsi_device_purge_requests() because it only cancels in-flight requests,
but scsi_dma_restart_cb() is about requests queued at the device level
that are not in flight in the block layer. Not restarting them if there
aren't any other requests in flight seems wrong.

> > > +
> > > +    /* Drop the reference taken by scsi_device_for_each_req_async() =
*/
> > > +    object_unref(OBJECT(s));
> > > +}
> > > +
> > > +/*
> > > + * Schedule @fn() to be invoked for each enqueued request in device =
@s. @fn()
> > > + * runs in the AioContext that is executing the request.
> > > + */
> > > +static void scsi_device_for_each_req_async(SCSIDevice *s,
> > > +                                           void (*fn)(SCSIRequest *,=
 void *),
> > > +                                           void *opaque)
> >=20
> > If we keep the behaviour above (doesn't do anything if the AioContext
> > changes), then I think it needs to be documented for this function and
> > callers should be explicit about why it's okay.
>=20
> I think your suggestion to reschedule in the new AioContext is best.

Ok, then the answer for the above is less important.

Kevin

--x7fWRZBeOjyImcXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAmVu9KkACgkQfwmycsiP
L9Y9Pw/+KVtWecD3XyrQB0GCRc5YjDbEpsMtIBo8XqbZ8LL4d6pR+63Y7+AlWRIx
rBoDfek09hY2uE3hIviv7tPwG49Vg6e6f5Yv1VecDQaFNJZuawF7kebFf3PtI7vl
xiK0EJN48Fhb11aYkT5CH7GBy+cQudcc4YCGw71NA4hdH7y5tf49xfSBwiN3a0MX
lSs4hegf9HT8G0/OSovKFvJ7mn4+q7o9nujnDbTZZ1zOfRl9RMdjRfRXiJK0DICn
dDzbiDKzgTX4qa6LrWCpcfi4DDWMFYCeJUxilFSkmqeHadx2bHc6cJe3YwpBZgId
GAyA8ZIS6OYlSdKD5fWVj10MkkvqurMBe70ZlG+1kz80ETet/Hnb9Qh/EFJVunUs
hizfliHjk09n8TIFz8uSny/B5Hd8x3wKZaxRVjQ0ybf4OI8t0Ti1mB27LF7ZYZ3r
LUy1OvRC297SjOeFli1tkCJwF5s734/kD9wPJSekVmmGuH951MLG/4RBXvFv/1lf
fCSHZP02ktYzJ/EHip4O/1lAc1IbPCxV8/TKLrbr0X7R79OCG04vfEwMG5ETvudh
c9lHJ0HTg//dLHz0AKz+bAGQto7aGH+WqxArnrf4bXqjsRfTHFSI4Cfj3Nh4aVWh
F+Gz++X6CDvuk56y3YMiijzdMqOR6GyNQmDLi4zo1fZzlO/muN0=
=BlnZ
-----END PGP SIGNATURE-----

--x7fWRZBeOjyImcXF--


