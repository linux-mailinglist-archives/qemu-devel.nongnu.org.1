Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF296763E3D
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 20:16:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOiSM-0002jK-VQ; Wed, 26 Jul 2023 13:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qOiSJ-0002jA-1a
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 13:37:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qOiSH-0005ks-Be
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 13:37:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690393064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pFhink9XhnUKYuFIwM0y8b80W1f1fXqWM1aZPZBy1Xo=;
 b=SjRR6OTwnJSMWsHZHpDIBE8f0FCmSP0tlYX1VkaYw8qUrMYcPLnNuGbXrs7fBOhsrYzXvG
 Gx2IYn2xbAr6gbaku4qFFYoqK3qQMLbIGgtyqoD2fJy4gZHkxRol7E2Vf+x6bk2SDG4+/s
 B/rk3KlTZ0sf/X9U5BPNoVTTeFVD048=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-338-iPc1mxNpOcaUNozPMe-ESw-1; Wed, 26 Jul 2023 13:37:40 -0400
X-MC-Unique: iPc1mxNpOcaUNozPMe-ESw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 067463C108D9;
 Wed, 26 Jul 2023 17:37:40 +0000 (UTC)
Received: from localhost (unknown [10.39.195.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 364BAC2C7D3;
 Wed, 26 Jul 2023 17:37:38 +0000 (UTC)
Date: Wed, 26 Jul 2023 13:37:37 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org,
 slp@redhat.com, marcandre.lureau@redhat.com,
 viresh.kumar@linaro.org, sgarzare@redhat.com,
 takahiro.akashi@linaro.org, erik.schilling@linaro.org,
 manos.pitsidianakis@linaro.org, mathieu.poirier@linaro.org
Subject: Re: [RFC PATCH] docs/interop: define STANDALONE protocol feature for
 vhost-user
Message-ID: <20230726173737.GA822884@fedora>
References: <20230704123600.1808604-1-alex.bennee@linaro.org>
 <20230706124347-mutt-send-email-mst@kernel.org>
 <20230720195837.GJ210977@fedora>
 <20230720171321-mutt-send-email-mst@kernel.org>
 <CAJSP0QVDBA0Fb+LVjJVWq7Dp7FosXAJsRJUCcAtdNr-VyzYipg@mail.gmail.com>
 <20230720182128-mutt-send-email-mst@kernel.org>
 <20230724180839.GC222590@fedora>
 <20230726120158-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="B6wJRZ+NXyQ1xUWH"
Content-Disposition: inline
In-Reply-To: <20230726120158-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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


--B6wJRZ+NXyQ1xUWH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2023 at 12:02:33PM -0400, Michael S. Tsirkin wrote:
> On Mon, Jul 24, 2023 at 02:08:39PM -0400, Stefan Hajnoczi wrote:
> > On Thu, Jul 20, 2023 at 06:22:08PM -0400, Michael S. Tsirkin wrote:
> > > On Thu, Jul 20, 2023 at 05:31:03PM -0400, Stefan Hajnoczi wrote:
> > > > On Thu, 20 Jul 2023 at 17:15, Michael S. Tsirkin <mst@redhat.com> w=
rote:
> > > > >
> > > > > On Thu, Jul 20, 2023 at 03:58:37PM -0400, Stefan Hajnoczi wrote:
> > > > > > On Thu, Jul 06, 2023 at 12:48:20PM -0400, Michael S. Tsirkin wr=
ote:
> > > > > > > On Tue, Jul 04, 2023 at 01:36:00PM +0100, Alex Benn=E9e wrote:
> > > > > > > > Currently QEMU has to know some details about the back-end =
to be able
> > > > > > > > to setup the guest. While various parts of the setup can be=
 delegated
> > > > > > > > to the backend (for example config handling) this is a very=
 piecemeal
> > > > > > > > approach.
> > > > > > >
> > > > > > > > This patch suggests a new feature flag (VHOST_USER_PROTOCOL=
_F_STANDALONE)
> > > > > > > > which the back-end can advertise which allows a probe messa=
ge to be
> > > > > > > > sent to get all the details QEMU needs to know in one messa=
ge.
> > > > > > >
> > > > > > > The reason we do piecemeal is that these existing pieces can =
be reused
> > > > > > > as others evolve or fall by wayside.
> > > > > > >
> > > > > > > For example, I can think of instances where you want to conne=
ct
> > > > > > > specifically to e.g. networking backend, and specify it
> > > > > > > on command line. Reasons could be many, e.g. for debugging,
> > > > > > > or to prevent connecting to wrong device on wrong channel
> > > > > > > (kind of like type safety).
> > > > > > >
> > > > > > > What is the reason to have 1 message? startup latency?
> > > > > > > How about we allow pipelining several messages then?
> > > > > > > Will be easier.
> > > > > >
> > > > > > This flag effectively says that the back-end is a full VIRTIO d=
evice
> > > > > > with a Device Status Register, Configuration Space, Virtqueues,=
 the
> > > > > > device type, etc. This is different from previous vhost-user de=
vices
> > > > > > which sometimes just offloaded certain virtqueues without provi=
ding the
> > > > > > full VIRTIO device (parts were emulated in the VMM).
> > > > > >
> > > > > > So for example, a vhost-user-net device does not support the co=
ntrolq.
> > > > > > Alex's "standalone" device is a mode where the vhost-user proto=
col is
> > > > > > used but the back-end must implement a full virtio-net device.
> > > > > > Standalone devices are like vDPA device in this respect.
> > > > > >
> > > > > > I think it is important to have a protocol feature bit that adv=
ertises
> > > > > > that this is a standalone device, since the semantics are diffe=
rent for
> > > > > > traditional vhost-user-net devices.
> > > > >
> > > > > Not sure what that would gain as compared to a feature bit per
> > > > > message as we did previously.
> > > >=20
> > > > Having a single feature bit makes it easier to distinguish between a
> > > > traditional vhost-user device and a standalone device.
> > > >=20
> > > > For example, the presence of VHOST_USER_F_GET_DEVICE_ID doesn't tell
> > > > you whether this device is a standalone device that is appropriate =
for
> > > > a new generic QEMU --device vhost-user-device feature that Alex is
> > > > working on. It could be a traditional vhost-user device that is not
> > > > standalone but implements the VHOST_USER_GET_DEVICE_ID message.
> > > >=20
> > > > How will we detect standalone devices? It will be messy if there is=
 no
> > > > single feature bit that advertises that this back-end is a standalo=
ne
> > > > device.
> > > >=20
> > > > Stefan
> > >=20
> > > Looks like standalone implies some 5-6 messages to be supported.
> > > So just test the 6 bits are all ones.
> >=20
> > It's not clear to me that the individual bits together mean this is
> > really a standalone device, but let's go with individual commands and
> > see if a front-end can distinguish standalone devices or not. If not,
> > then we can still add "standalone" feature bit before merging the code.
> >=20
> > Stefan
>=20
>=20
> I think it just shows that what a "standalone" device is just isn't
> that well defined ;).

No, I think it's the opposite way around. The existing vhost model is
not well defined. From time to time someone has to extend it to add
things like Configuration Space support or VHOST_USER_GET_DEVICE_ID.

Standalone devices are well defined: they are what the VIRTIO
specification describes.

My concern is that new messages added for standalone devices might also
be useful for existing non-standalone devices. Or do you want to declare
these new messages off-limits to non-standalone devices?

Stefan

--B6wJRZ+NXyQ1xUWH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTBWeEACgkQnKSrs4Gr
c8iokgf7B0DWkPqwgtPqkRLT429OcB9A0gFmWqw19fTcJb6p6V1ftWIJojzF6NPQ
THJgQMBPML/IsMheSdm8N0pu6+rT8KIkdOl7mP/C5hxzs5o43vndl7wBMpDyGOrg
62kz/RVC2RTmqYOSF/d1vr8JLQsQT5dB4DegWJEAXUur8kR5D07PWln0eyXITvx3
VPojujbiE85iMnbYn4Ss3dhNTugDX00Ncmn6liZBSrl7YonAHMtQJRIH/oxMHrmM
6w13HwaFQF/+uZWk5hvABY2N5GmFeH29t1la673S2y0AxuGOzz0GLxDuuaRDQQsa
4qp8IG4Xoxsn4FhoL/0er0p/AHl/Mw==
=LaX0
-----END PGP SIGNATURE-----

--B6wJRZ+NXyQ1xUWH--


