Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C505765E53
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 23:39:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP8HV-0004Nb-E6; Thu, 27 Jul 2023 17:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qP8HT-0004NS-Nt
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 17:12:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qP8HR-0000Xq-2T
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 17:12:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690492335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mP9hVOCJttouNhle/faeJoWuiZwk9fKSqUBeJLK/VbU=;
 b=KoDoLG1nNXZnd9FhxbriAxL6hgvT7UV4dGQqjfmRI0gcfK/6AOip//Tet8EuSkgP37Oait
 zkbim+Aukb5Jt3BO1g23n7vYEzcg5Z5mZixBn0rCO/9p6v9E/PQUsC5PRbU89YHvBZeILd
 elMoLOE5POEuHVemqNxuKXl4H2muXWM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-w42ZdyT4NSKeDvr4duCUFw-1; Thu, 27 Jul 2023 17:12:11 -0400
X-MC-Unique: w42ZdyT4NSKeDvr4duCUFw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A51B81DA29
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 21:12:10 +0000 (UTC)
Received: from localhost (unknown [10.39.193.84])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 50ADA1121330;
 Thu, 27 Jul 2023 21:12:09 +0000 (UTC)
Date: Thu, 27 Jul 2023 17:12:07 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>
Subject: Re: [PATCH 1/6] vhost-user.rst: Add suspend/resume
Message-ID: <20230727211207.GC986673@fedora>
References: <20230711155230.64277-1-hreitz@redhat.com>
 <20230711155230.64277-2-hreitz@redhat.com>
 <20230718142557.GB44841@fedora>
 <a760479a-f623-1fa9-a557-70a857fe8dcf@redhat.com>
 <20230724175532.GA222590@fedora>
 <370fc01d-a090-e400-6ebe-a3e8df5b02b6@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bqWjiJzgy8dJQDiX"
Content-Disposition: inline
In-Reply-To: <370fc01d-a090-e400-6ebe-a3e8df5b02b6@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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


--bqWjiJzgy8dJQDiX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2023 at 10:30:49AM +0200, Hanna Czenczek wrote:
> On 24.07.23 19:55, Stefan Hajnoczi wrote:
> > On Wed, Jul 19, 2023 at 03:59:32PM +0200, Hanna Czenczek wrote:
> > > On 18.07.23 16:25, Stefan Hajnoczi wrote:
> > > > On Tue, Jul 11, 2023 at 05:52:23PM +0200, Hanna Czenczek wrote:
> > > > > When stopping the VM, qemu wants all devices to fully cease any
> > > > > operation, too.  Currently, we can only have vhost-user back-ends=
 stop
> > > > > processing vrings, but not background operations.  Add the SUSPEN=
D and
> > > > > RESUME commands from vDPA, which allow the front-end (qemu) to te=
ll
> > > > > back-ends to cease all operations, including those running in the
> > > > > background.
> > > > >=20
> > > > > qemu's current work-around for this is to reset the back-end inst=
ead of
> > > > > suspending it, which will not work for back-ends that have intern=
al
> > > > > state that must be preserved across e.g. stop/cont.
> > > > >=20
> > > > > Note that the given specification requires the back-end to delay
> > > > > processing kicks (i.e. starting vrings) until the device is resum=
ed,
> > > > > instead of requiring the front-end not to send kicks while suspen=
ded.
> > > > > qemu starts devices (and would just resume them) only when the VM=
 is in
> > > > > a running state, so it would be difficult to have qemu delay kick=
s until
> > > > > the device is resumed, which is why this patch specifies handling=
 of
> > > > > kicks as it does.
> > > > >=20
> > > > > Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> > > > > ---
> > > > >    docs/interop/vhost-user.rst | 35 +++++++++++++++++++++++++++++=
++++--
> > > > >    1 file changed, 33 insertions(+), 2 deletions(-)
> > > > >=20
> > > > > diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-use=
r.rst
> > > > > index 5a070adbc1..ac6be34c4c 100644
> > > > > --- a/docs/interop/vhost-user.rst
> > > > > +++ b/docs/interop/vhost-user.rst
> > > > > @@ -381,6 +381,10 @@ readable) on the descriptor specified by ``V=
HOST_USER_SET_VRING_KICK``
> > > > >    or receiving the in-band message ``VHOST_USER_VRING_KICK`` if =
negotiated,
> > > > >    and stop ring upon receiving ``VHOST_USER_GET_VRING_BASE``.
> > > > > +While the back-end is suspended (via ``VHOST_USER_SUSPEND``), it=
 must
> > > > > +never process rings, and thus also delay handling kicks until the
> > > > If you respin this series, I suggest replacing "never" with "not" to
> > > > emphasize that ring processing is only skipped while the device is
> > > > suspended (rather than forever). "Never" feels too strong to use wh=
en
> > > > describing a temporary state.
> > > Sure.
> > >=20
> > > > > +back-end is resumed again.
> > > > > +
> > > > >    Rings can be enabled or disabled by ``VHOST_USER_SET_VRING_ENA=
BLE``.
> > > > >    If ``VHOST_USER_F_PROTOCOL_FEATURES`` has not been negotiated,=
 the
> > > > > @@ -479,8 +483,9 @@ supplied by ``VhostUserLog``.
> > > > >    ancillary data, it may be used to inform the front-end that th=
e log has
> > > > >    been modified.
> > > > > -Once the source has finished migration, rings will be stopped by=
 the
> > > > > -source. No further update must be done before rings are restarte=
d.
> > > > > +Once the source has finished migration, the device will be suspe=
nded and
> > > > > +its rings will be stopped by the source. No further update must =
be done
> > > > > +before the device and its rings are resumed.
> > > > This paragraph is abstract and doesn't directly identify the mechan=
isms
> > > > or who does what:
> > > > - "the device will be suspended" via VHOST_USER_SUSPEND (or reset w=
hen
> > > >     VHOST_USER_SUSPEND is not supported?) or automatically by the d=
evice
> > > >     itself or some other mechanism?
> > > OK, I=E2=80=99ll add VHOST_USER_SUSPEND.
> > >=20
> > > So far I hadn=E2=80=99t considered making a note of resetting as a fa=
llback right in
> > > the specification.=C2=A0 I don=E2=80=99t think I would want it in the=
 specification, but
> > > on the other hand, it is probably important for back-end authors to k=
now
> > > that if they do not implement SUSPEND, their device is going to be re=
set by
> > > qemu.
> > >=20
> > > Can we make that a =E2=80=9Dmay=E2=80=9D, i.e.:
> > >=20
> > > ```
> > > Once the source has finished migration, the device will be suspended =
via
> > > VHOST_USER_SUSPEND and its rings will be stopped by the source.
> > I'm not sure what "its rings will be stopped by the source" means
> > exactly. Is it summarizing the effect of VHOST_USER_SUSPEND or is there
> > an additional action after VHOST_USER_SUSPEND that stops rings? And I'm
> > not sure whether "by the source" means by the front-end or back-end on
> > the source machine?
>=20
> This is pre-existing text and I assumed it (with not doubt) to refer to
> GET_VRING_BASE, because that is how rings are stopped.
>=20
> I can improve the existing documentation and add the reference to
> GET_VRING_BASE, and say that it clearly must come from the front-end.

Yes, please.

>=20
> > > No further
> > > update must be done before the device and its rings are resumed.
> > "Update" to what? Guest RAM? Device state? Rings?
> >=20
> > I feel like this text is too vague for a spec. People may interpret it
> > differently. Can you make rephrase this to more concrete?
>=20
> Honestly, no.=C2=A0 This is pre-existing, and I have the same questions a=
s you
> do.
>=20
> I cannot =E2=80=9Crephrase=E2=80=9D this to make it more concrete.=C2=A0 =
I can try to actually
> specify that was was left unspecified, but that would be a change in
> specification that would require its own patch, separate from this series.

I want to make sure that VHOST_USER_SUSPEND is well-defined. If it's
pre-existing live migration text that doesn't involve
VHOST_USER_SUSPEND, then it would be unfair to ask you to rewrite it.

>=20
> Personally, I=E2=80=99ve generally taken this sentence to be fluff.=C2=A0=
 If the rings
> are stopped, clearly, they should not be accessed at all. Probably the
> back-end should also refrain from writing to guest memory, because that i=
s a
> logical conclusion from having the rings stopped.=C2=A0 But now it=E2=80=
=99s even
> clearer: The back-end ideally is suspended, which directly means not to
> modify guest memory, and not to perform =E2=80=9Cbackground operations=E2=
=80=9D.=C2=A0 Updating
> device state of course is possible through vhost-user commands, because
> those must always be executed.
>=20
> So basically it=E2=80=99s just =E2=80=9CDevice and rings are stopped (RES=
UME and
> GET_VRING_BASE, resp.), so you know, adhere to that.=E2=80=9D
>=20
> Or maybe I=E2=80=99m completely wrong and =E2=80=9COnce the source has fi=
nished migration,
> rings will be stopped by the source. No further update must be done before
> rings are restarted.=E2=80=9D is to be taken together and the second sent=
ence just
> refers to the rings, i.e. the front-end stops the rings, and the back-end
> must not update them.=C2=A0 Or it means that the front-end must not send =
any
> commands to the back-end until restarting the rings, but that feels
> practically impossible.
>=20
> Again, because this sentence currently doesn=E2=80=99t specify anything, =
really,
> changing it to carry any meaning would be to add to the specification, not
> just clarify it.
>=20
> > > If and only
> > > if the back-end does not support VHOST_USER_SUSPEND, the front-end ma=
y reset
> > > it instead (via VHOST_USER_SET_STATUS, VHOST_USER_RESET_DEVICE, or
> > > VHOST_USER_RESET_OWNER).
> > > ```
> > >=20
> > > I=E2=80=99m unsure about the =E2=80=9CIf and only if=E2=80=9D =E2=80=
=93 older qemu versions will break this,
> > > but I feel like we must promise back-end writers that if they impleme=
nt
> > > SUSPEND, their back-end is not going to be reset; if it is, and somet=
hing
> > > breaks because of it, it=E2=80=99s the front-end that must be updated=
 to match the
> > > specification.
> > I this the trick is to say "if and only if VHOST_USER_F_SUSPEND has not
> > been negotiated". That way really only new front-ends that support
> > VHOST_USER_SUSPEND are required to use suspend instead of reset and
> > older versions of QEMU will not violate this statement.
>=20
> Ah, right, thanks!
>=20
> > > > - "before the device and its rings are resumed" via VHOST_USER_RESU=
ME?
> > > >     And is this referring to the source device?
> > > Yes, via VHOST_USER_RESUME, and restarting the rings by starting them=
 (i.e.
> > > a kick).
> > >=20
> > > Whether this is referring to the source device=E2=80=A6=C2=A0 Well, t=
he text as it was
> > > before begs the exact same question, so honestly, I don=E2=80=99t kno=
w for sure.
> > > =E2=80=9CRestarting=E2=80=9D only makes sense if the rings were stopp=
ed before, so I assume
> > > it=E2=80=99s referring to the source, e.g. for the case of a failed m=
igration.
> > > RESUME at least definitely will only happen after a prior SUSPEND, so=
 this
> > > one will definitely only apply on the source side.
> > >=20
> > > > Please rephrase the paragraph to identify the vhost-user messages
> > > > involved.
> > > >=20
> > > > >    In postcopy migration the back-end is started before all the m=
emory has
> > > > >    been received from the source host, and care must be taken to =
avoid
> > > > > @@ -885,6 +890,7 @@ Protocol features
> > > > >      #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
> > > > >      #define VHOST_USER_PROTOCOL_F_STATUS               16
> > > > >      #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
> > > > > +  #define VHOST_USER_PROTOCOL_F_SUSPEND              18
> > > > >    Front-end message types
> > > > >    -----------------------
> > > > > @@ -1440,6 +1446,31 @@ Front-end message types
> > > > >      query the back-end for its device status as defined in the V=
irtio
> > > > >      specification.
> > > > > +``VHOST_USER_SUSPEND``
> > > > > +  :id: 41
> > > > > +  :equivalent ioctl: VHOST_VDPA_SUSPEND
> > > > > +  :request payload: N/A
> > > > > +  :reply payload: N/A
> > > > > +
> > > > > +  When the ``VHOST_USER_PROTOCOL_F_SUSPEND`` protocol feature ha=
s been
> > > > > +  successfully negotiated, this message is submitted by the fron=
t-end to
> > > > > +  have the back-end cease all operations except for handling vho=
st-user
> > > > > +  requests.  The back-end must stop processing all virt queues, =
and it
> > > > > +  must not perform any background operations.  It may not resume=
 until a
> > > > "background operations" are not defined. What does it mean:
> > > > - Anything that writes to memory slots
> > > > - Anything that changes the visible state of the device
> > > > - Anything that changes the non-visible internal state of the device
> > > > - etc
> > > > ?
> > > My best answer (honestly) is: You tell me.=C2=A0 This series is intro=
ducing
> > > SUSPEND/RESUME because qemu wants to reset devices to make them stop
> > > =E2=80=9Cbackground operations=E2=80=9D, and this would break virtiof=
sd if any form of reset
> > > were actually implemented.=C2=A0 The implementation of SUSPEND/RESUME=
 in
> > > virtiofsd on the other hand is supposed to basically be a no-op (besi=
des
> > > delaying ring processing until a RESUME, but even if we processed them
> > > before, i.e. really make SUSPEND/RESUME no-ops, it would most likely =
work
> > > out fine), so I have no idea what kind of background operations we ar=
e even
> > > talking about, or whether any such actually exist in practice.
> > >=20
> > > I don=E2=80=99t know what anyone had in mind when introducing the RES=
ET.=C2=A0 It comes
> > > from vDPA (c3716f260bf moved it from vdpa into the common code), and =
exists
> > > since the code was originally added (108a64818e6), so there=E2=80=99s=
 no comment
> > > explaining why it exists.=C2=A0 I can=E2=80=99t explain what the back=
-end is supposed to
> > > stop doing, because so far it isn=E2=80=99t explained anywhere in qem=
u, its git log,
> > > or in any documentation (there basically is no vdpa documentation).
> > >=20
> > > I can only say what I just completely na=C3=AFvely assumed it to mean=
 so far:
> > > That the back-end basically should stop doing anything besides handli=
ng and
> > > replying to vhost-user messages.=C2=A0 If such a message requires cha=
nging any
> > > state, visible or not, then this state change is permissible.
> > Okay, I suggest the following instead of "background operations":
> >=20
> > - Changes to the device state produced by SET_DEVICE_STATE_FD.
>=20
> This is definitely something that I would absolutely allow after SUSPEND.=
=C2=A0
> If the front-end does not wish the back-end to do this, it can just not s=
end
> this command while the back-end is suspended.
>
>=20
> > - Writing to memory regions.
> > - Signalling that buffers have been used.
>=20
> This feels both too tight and not concrete enough.=C2=A0 The only buffers=
 I can
> think of are buffers supplied through virt queues, which I intended to
> already be included in =E2=80=9Cstop processing all virt queues=E2=80=9D.=
=C2=A0 (I took this to
> mean the used-buffer ring, too, but I can of course be more explicit about
> this, e.g. =E2=80=9Cstop processing all virt queues, including returning =
buffers to
> the driver=E2=80=9D.) =E2=80=9CSignalling=E2=80=9D sounds like triggering=
 the callfd, but that also
> seems clear; if you can=E2=80=99t process virt queues, including returnin=
g buffers,
> you can never trigger the callfd (or send VHOST_USER_BACKEND_VRING_CALL),
> because there can never be a new buffer returned to the driver.

Yes, I was trying to use the language of the vhost-user spec related to
the callfd. If the back-end has a timer for interrupt mitigation then it
technically isn't doing any virtqueue processing after SUSPEND but might
still signal the callfd when the timer expires.

There is overlap with virtqueue processing, depending on how you define
it. Maybe mentioning this separately is overkill.

>=20
> So too tight because it feels like a subset of virt queue processing, but
> not concrete enough because =E2=80=9Cbuffers=E2=80=9D makes me feel like =
I=E2=80=99m overlooking
> something besides virt queues.
>=20
> > - Signalling that the configuration space has changed.
>=20
> Maybe this could be more general, i.e. the back-end must not send any
> vhost-user messages to the front-end?

Yes, I was thinking solely of VHOST_USER_BACKEND_CONFIG_CHANGE_MSG but
it could include all back-end message types.

[I am reordering your reply, because this might be important before we
continue below...]
> Other than migration, qemu doesn=E2=80=99t see the device state at all.=
=C2=A0 I don=E2=80=99t see
> why internal state should not change between stop/cont. If a device
> experience some signal that (for some reason) it can=E2=80=99t pause to r=
eceive only
> after the subsequent RESUME, it might need to make note of that signal to
> act on it after RESUME.=C2=A0 I would consider that a change in internal =
state,
> and I don=E2=80=99t immediately see a problem with it.=C2=A0 (It may be p=
roblematic when
> migrating, because receiving such signals on the source side after
> transferring the state would mean they=E2=80=99re lost, but again, this i=
s something
> the device clearly has to solve, e.g. by redirecting the signals to the
> destination starting with the SET_TRANSFER_STATE_FD call.)

I only consider device state to be the data that is transferred over the
device state fd. The other state in the back-end, like the pending
signal example you mentioned, is not part of what I call the device
state.

> > The goal is to ensure the device state and memory regions are stable and
> > that back-end doesn't trigger activity in the front-end.
>=20
> If the goal is to ensure that the device state is stable, I feel like we
> must then specify precisely this, and not just to say it must not be muta=
ble
> through SET_DEVICE_STATE_FD: In general, the state is more likely to be
> changed by other factors after all.
>=20
> On the other hand, I also don=E2=80=99t see why that=E2=80=99s a goal.=C2=
=A0 For migration, it
> might seem desirable, but I don=E2=80=99t actually think so: The back-end=
 is
> required to send a consistent device state anyway, so it is up to the
> back-end to ensure the state is consistent, we don=E2=80=99t need to make=
 it a
> requirement for SUSPEND.=C2=A0 It is implicitly clear from the migration =
model
> that if the device state were to change after the back-end has sent it to
> the front-end, those change will be lost on the destination side, so it is
> clear that the back-end must anticipate this and work around it.

I don't follow your last sentence. I agree that device state changes
after the device state fd has been read would be lost on the
destination. But that does not mean that it is valid to modify the
device state while reading the device state fd (there is no iterative
migration support yet).

Are you assuming that SET_DEVICE_STATE_FD takes a snapshot of the device
state and reading the fd reads the (consistent) snapshot?

I worry that it may not be possible for all implementations to take a
snapshot of the device state and then continue modifying the actual
device state. This could be due to resource limitations or due to
underlying API limitations. It would be easier if the spec forbid
modifying the device state while the device was suspended.

Stefan

--bqWjiJzgy8dJQDiX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTC3acACgkQnKSrs4Gr
c8hzfQf/Qm7LtD2nt4huNQp5sObetiiUYnZqfCiwe2wFWecS3WFdx/X0h976INBZ
ZdeJ3SlCGu8sL4ChV6e6L8zw5HM+or5JLhRfUrS7Yq0voNP2beZkjvac8VoUm+Kh
15tUfcsUoINRBoeIKDg7HqzuJn918tGmUTd1oDFnhhooz47hGX5SsPAScx5MWYJm
do4Yk9W/hunkMEwPZa8f/2SPQc52EaWexUmjNKSCBhZUwuor7LlsAIIjYforbow1
NEFPiB2vX4HiZz7V+NiJlQjNhw9zk20pzJMg+cWgx49KbP/h6VWsXYzns8JbtZo4
CBPdD+4Vn2GBcx5wkDdPZyQl7Xw4dQ==
=XApX
-----END PGP SIGNATURE-----

--bqWjiJzgy8dJQDiX--


