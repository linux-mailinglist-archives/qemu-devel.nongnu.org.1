Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2983E75FE99
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 19:57:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNzmb-0003ri-NA; Mon, 24 Jul 2023 13:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qNzmY-0003r6-Pm
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 13:55:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qNzmV-0007Mi-HL
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 13:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690221337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vOGDRPGLhUu9C7CUfOeFlnfTDHq3g1h2vLg1TbQZ/R0=;
 b=NMDS060is7TSECXyrC80Le5ke+21CsEly1xYXyspIGfNltQB9HLXJAto/FMlt+aZBVYqTJ
 wA/omvAJqac/2cDwb0aShBq7lMmHzWpw3zRxlDfC/RjE0Ib417ZXFWbvJhMnjGndYxoqVK
 pcT/53BG3Kqv8Hh85vU2AqINMjHInp8=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-1XRu9KTRMvWFKmcedZ4AcQ-1; Mon, 24 Jul 2023 13:55:35 -0400
X-MC-Unique: 1XRu9KTRMvWFKmcedZ4AcQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E3D801C07242
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 17:55:34 +0000 (UTC)
Received: from localhost (unknown [10.39.192.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 56A9B201EE6E;
 Mon, 24 Jul 2023 17:55:34 +0000 (UTC)
Date: Mon, 24 Jul 2023 13:55:32 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>
Subject: Re: [PATCH 1/6] vhost-user.rst: Add suspend/resume
Message-ID: <20230724175532.GA222590@fedora>
References: <20230711155230.64277-1-hreitz@redhat.com>
 <20230711155230.64277-2-hreitz@redhat.com>
 <20230718142557.GB44841@fedora>
 <a760479a-f623-1fa9-a557-70a857fe8dcf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ycQ+R/7D6MyDxMr5"
Content-Disposition: inline
In-Reply-To: <a760479a-f623-1fa9-a557-70a857fe8dcf@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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


--ycQ+R/7D6MyDxMr5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2023 at 03:59:32PM +0200, Hanna Czenczek wrote:
> On 18.07.23 16:25, Stefan Hajnoczi wrote:
> > On Tue, Jul 11, 2023 at 05:52:23PM +0200, Hanna Czenczek wrote:
> > > When stopping the VM, qemu wants all devices to fully cease any
> > > operation, too.  Currently, we can only have vhost-user back-ends stop
> > > processing vrings, but not background operations.  Add the SUSPEND and
> > > RESUME commands from vDPA, which allow the front-end (qemu) to tell
> > > back-ends to cease all operations, including those running in the
> > > background.
> > >=20
> > > qemu's current work-around for this is to reset the back-end instead =
of
> > > suspending it, which will not work for back-ends that have internal
> > > state that must be preserved across e.g. stop/cont.
> > >=20
> > > Note that the given specification requires the back-end to delay
> > > processing kicks (i.e. starting vrings) until the device is resumed,
> > > instead of requiring the front-end not to send kicks while suspended.
> > > qemu starts devices (and would just resume them) only when the VM is =
in
> > > a running state, so it would be difficult to have qemu delay kicks un=
til
> > > the device is resumed, which is why this patch specifies handling of
> > > kicks as it does.
> > >=20
> > > Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> > > ---
> > >   docs/interop/vhost-user.rst | 35 +++++++++++++++++++++++++++++++++--
> > >   1 file changed, 33 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> > > index 5a070adbc1..ac6be34c4c 100644
> > > --- a/docs/interop/vhost-user.rst
> > > +++ b/docs/interop/vhost-user.rst
> > > @@ -381,6 +381,10 @@ readable) on the descriptor specified by ``VHOST=
_USER_SET_VRING_KICK``
> > >   or receiving the in-band message ``VHOST_USER_VRING_KICK`` if negot=
iated,
> > >   and stop ring upon receiving ``VHOST_USER_GET_VRING_BASE``.
> > > +While the back-end is suspended (via ``VHOST_USER_SUSPEND``), it must
> > > +never process rings, and thus also delay handling kicks until the
> > If you respin this series, I suggest replacing "never" with "not" to
> > emphasize that ring processing is only skipped while the device is
> > suspended (rather than forever). "Never" feels too strong to use when
> > describing a temporary state.
>=20
> Sure.
>=20
> > > +back-end is resumed again.
> > > +
> > >   Rings can be enabled or disabled by ``VHOST_USER_SET_VRING_ENABLE``.
> > >   If ``VHOST_USER_F_PROTOCOL_FEATURES`` has not been negotiated, the
> > > @@ -479,8 +483,9 @@ supplied by ``VhostUserLog``.
> > >   ancillary data, it may be used to inform the front-end that the log=
 has
> > >   been modified.
> > > -Once the source has finished migration, rings will be stopped by the
> > > -source. No further update must be done before rings are restarted.
> > > +Once the source has finished migration, the device will be suspended=
 and
> > > +its rings will be stopped by the source. No further update must be d=
one
> > > +before the device and its rings are resumed.
> > This paragraph is abstract and doesn't directly identify the mechanisms
> > or who does what:
> > - "the device will be suspended" via VHOST_USER_SUSPEND (or reset when
> >    VHOST_USER_SUSPEND is not supported?) or automatically by the device
> >    itself or some other mechanism?
>=20
> OK, I=E2=80=99ll add VHOST_USER_SUSPEND.
>=20
> So far I hadn=E2=80=99t considered making a note of resetting as a fallba=
ck right in
> the specification.=C2=A0 I don=E2=80=99t think I would want it in the spe=
cification, but
> on the other hand, it is probably important for back-end authors to know
> that if they do not implement SUSPEND, their device is going to be reset =
by
> qemu.
>=20
> Can we make that a =E2=80=9Dmay=E2=80=9D, i.e.:
>=20
> ```
> Once the source has finished migration, the device will be suspended via
> VHOST_USER_SUSPEND and its rings will be stopped by the source.

I'm not sure what "its rings will be stopped by the source" means
exactly. Is it summarizing the effect of VHOST_USER_SUSPEND or is there
an additional action after VHOST_USER_SUSPEND that stops rings? And I'm
not sure whether "by the source" means by the front-end or back-end on
the source machine?

> No further
> update must be done before the device and its rings are resumed.

"Update" to what? Guest RAM? Device state? Rings?

I feel like this text is too vague for a spec. People may interpret it
differently. Can you make rephrase this to more concrete?

> If and only
> if the back-end does not support VHOST_USER_SUSPEND, the front-end may re=
set
> it instead (via VHOST_USER_SET_STATUS, VHOST_USER_RESET_DEVICE, or
> VHOST_USER_RESET_OWNER).
> ```
>=20
> I=E2=80=99m unsure about the =E2=80=9CIf and only if=E2=80=9D =E2=80=93 o=
lder qemu versions will break this,
> but I feel like we must promise back-end writers that if they implement
> SUSPEND, their back-end is not going to be reset; if it is, and something
> breaks because of it, it=E2=80=99s the front-end that must be updated to =
match the
> specification.

I this the trick is to say "if and only if VHOST_USER_F_SUSPEND has not
been negotiated". That way really only new front-ends that support
VHOST_USER_SUSPEND are required to use suspend instead of reset and
older versions of QEMU will not violate this statement.

>=20
> > - "before the device and its rings are resumed" via VHOST_USER_RESUME?
> >    And is this referring to the source device?
>=20
> Yes, via VHOST_USER_RESUME, and restarting the rings by starting them (i.=
e.
> a kick).
>=20
> Whether this is referring to the source device=E2=80=A6=C2=A0 Well, the t=
ext as it was
> before begs the exact same question, so honestly, I don=E2=80=99t know fo=
r sure.=C2=A0
> =E2=80=9CRestarting=E2=80=9D only makes sense if the rings were stopped b=
efore, so I assume
> it=E2=80=99s referring to the source, e.g. for the case of a failed migra=
tion.=C2=A0
> RESUME at least definitely will only happen after a prior SUSPEND, so this
> one will definitely only apply on the source side.
>=20
> > Please rephrase the paragraph to identify the vhost-user messages
> > involved.
> >=20
> > >   In postcopy migration the back-end is started before all the memory=
 has
> > >   been received from the source host, and care must be taken to avoid
> > > @@ -885,6 +890,7 @@ Protocol features
> > >     #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
> > >     #define VHOST_USER_PROTOCOL_F_STATUS               16
> > >     #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
> > > +  #define VHOST_USER_PROTOCOL_F_SUSPEND              18
> > >   Front-end message types
> > >   -----------------------
> > > @@ -1440,6 +1446,31 @@ Front-end message types
> > >     query the back-end for its device status as defined in the Virtio
> > >     specification.
> > > +``VHOST_USER_SUSPEND``
> > > +  :id: 41
> > > +  :equivalent ioctl: VHOST_VDPA_SUSPEND
> > > +  :request payload: N/A
> > > +  :reply payload: N/A
> > > +
> > > +  When the ``VHOST_USER_PROTOCOL_F_SUSPEND`` protocol feature has be=
en
> > > +  successfully negotiated, this message is submitted by the front-en=
d to
> > > +  have the back-end cease all operations except for handling vhost-u=
ser
> > > +  requests.  The back-end must stop processing all virt queues, and =
it
> > > +  must not perform any background operations.  It may not resume unt=
il a
> > "background operations" are not defined. What does it mean:
> > - Anything that writes to memory slots
> > - Anything that changes the visible state of the device
> > - Anything that changes the non-visible internal state of the device
> > - etc
> > ?
>=20
> My best answer (honestly) is: You tell me.=C2=A0 This series is introduci=
ng
> SUSPEND/RESUME because qemu wants to reset devices to make them stop
> =E2=80=9Cbackground operations=E2=80=9D, and this would break virtiofsd i=
f any form of reset
> were actually implemented.=C2=A0 The implementation of SUSPEND/RESUME in
> virtiofsd on the other hand is supposed to basically be a no-op (besides
> delaying ring processing until a RESUME, but even if we processed them
> before, i.e. really make SUSPEND/RESUME no-ops, it would most likely work
> out fine), so I have no idea what kind of background operations we are ev=
en
> talking about, or whether any such actually exist in practice.
>=20
> I don=E2=80=99t know what anyone had in mind when introducing the RESET.=
=C2=A0 It comes
> from vDPA (c3716f260bf moved it from vdpa into the common code), and exis=
ts
> since the code was originally added (108a64818e6), so there=E2=80=99s no =
comment
> explaining why it exists.=C2=A0 I can=E2=80=99t explain what the back-end=
 is supposed to
> stop doing, because so far it isn=E2=80=99t explained anywhere in qemu, i=
ts git log,
> or in any documentation (there basically is no vdpa documentation).
>=20
> I can only say what I just completely na=C3=AFvely assumed it to mean so =
far:
> That the back-end basically should stop doing anything besides handling a=
nd
> replying to vhost-user messages.=C2=A0 If such a message requires changin=
g any
> state, visible or not, then this state change is permissible.

Okay, I suggest the following instead of "background operations":

- Changes to the device state produced by SET_DEVICE_STATE_FD.
- Writing to memory regions.
- Signalling that buffers have been used.
- Signalling that the configuration space has changed.

The goal is to ensure the device state and memory regions are stable and
that back-end doesn't trigger activity in the front-end.

Stefan

--ycQ+R/7D6MyDxMr5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmS+uxQACgkQnKSrs4Gr
c8ghogf+Opi05pjkQO/xczPYM1yXWF7KLcdsbvHvRwaa6qRiQkqm2i38ujGWNEUA
/HnNETJflSdQ3r8eXU7vWq7vQL7On5vmTrgBjcmNVeYDw3T2XaVeFWcpIXnRfcHb
y6ItFq0rHAbvnpm5EEIg/0Flr6FEm5Od2OMaCQRLF6QUIsz4QDhIS4NdH7GOQvi8
RF/EGNQIG3NxrfcBPHieyqZXtRYjjH7f0Nw1+In1yccom3oI6dxS9YZWFtLvyrUt
1CbMoRm2FvnIB5e7VXEpoG3656Z9V0sbNHO+FdjCqxzQLF7lbdPjSFWTFwXpbcKz
w31trXwCBcYiCq/c8LrO0DcgQ+MFCA==
=DQd7
-----END PGP SIGNATURE-----

--ycQ+R/7D6MyDxMr5--


