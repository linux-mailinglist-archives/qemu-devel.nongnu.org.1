Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B9275FECD
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 20:09:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNzzI-00078x-Aw; Mon, 24 Jul 2023 14:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qNzzH-00078n-3D
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 14:08:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qNzzF-00026m-EW
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 14:08:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690222128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vy0s3t2bKntxrw72io7NoadgGa/K+CMor+nXPDkE+vQ=;
 b=Td5Wdy33hee7PB7iop5DHD20ShBGnfBUkhR+gkqTy1oQKR3BGi2smnLJGiaCHupU6eCQJm
 btmo2vsZS/0D0BoORUNn5Z+7+T4llO6qjSrfgKrpOzOEcU7JgC9zO96NwMOMf2uEb+9pZ0
 0RIlq7/1ZP24dFXSW94YTRbrlCu9808=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-695-SatHzKsSM66rfF1WWHDfMw-1; Mon, 24 Jul 2023 14:08:43 -0400
X-MC-Unique: SatHzKsSM66rfF1WWHDfMw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6A1913815F6B;
 Mon, 24 Jul 2023 18:08:42 +0000 (UTC)
Received: from localhost (unknown [10.39.192.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B4DCE140E952;
 Mon, 24 Jul 2023 18:08:41 +0000 (UTC)
Date: Mon, 24 Jul 2023 14:08:39 -0400
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
Message-ID: <20230724180839.GC222590@fedora>
References: <20230704123600.1808604-1-alex.bennee@linaro.org>
 <20230706124347-mutt-send-email-mst@kernel.org>
 <20230720195837.GJ210977@fedora>
 <20230720171321-mutt-send-email-mst@kernel.org>
 <CAJSP0QVDBA0Fb+LVjJVWq7Dp7FosXAJsRJUCcAtdNr-VyzYipg@mail.gmail.com>
 <20230720182128-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="o5VRGi/hTISP7+bi"
Content-Disposition: inline
In-Reply-To: <20230720182128-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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


--o5VRGi/hTISP7+bi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2023 at 06:22:08PM -0400, Michael S. Tsirkin wrote:
> On Thu, Jul 20, 2023 at 05:31:03PM -0400, Stefan Hajnoczi wrote:
> > On Thu, 20 Jul 2023 at 17:15, Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Thu, Jul 20, 2023 at 03:58:37PM -0400, Stefan Hajnoczi wrote:
> > > > On Thu, Jul 06, 2023 at 12:48:20PM -0400, Michael S. Tsirkin wrote:
> > > > > On Tue, Jul 04, 2023 at 01:36:00PM +0100, Alex Benn=E9e wrote:
> > > > > > Currently QEMU has to know some details about the back-end to b=
e able
> > > > > > to setup the guest. While various parts of the setup can be del=
egated
> > > > > > to the backend (for example config handling) this is a very pie=
cemeal
> > > > > > approach.
> > > > >
> > > > > > This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_S=
TANDALONE)
> > > > > > which the back-end can advertise which allows a probe message t=
o be
> > > > > > sent to get all the details QEMU needs to know in one message.
> > > > >
> > > > > The reason we do piecemeal is that these existing pieces can be r=
eused
> > > > > as others evolve or fall by wayside.
> > > > >
> > > > > For example, I can think of instances where you want to connect
> > > > > specifically to e.g. networking backend, and specify it
> > > > > on command line. Reasons could be many, e.g. for debugging,
> > > > > or to prevent connecting to wrong device on wrong channel
> > > > > (kind of like type safety).
> > > > >
> > > > > What is the reason to have 1 message? startup latency?
> > > > > How about we allow pipelining several messages then?
> > > > > Will be easier.
> > > >
> > > > This flag effectively says that the back-end is a full VIRTIO device
> > > > with a Device Status Register, Configuration Space, Virtqueues, the
> > > > device type, etc. This is different from previous vhost-user devices
> > > > which sometimes just offloaded certain virtqueues without providing=
 the
> > > > full VIRTIO device (parts were emulated in the VMM).
> > > >
> > > > So for example, a vhost-user-net device does not support the contro=
lq.
> > > > Alex's "standalone" device is a mode where the vhost-user protocol =
is
> > > > used but the back-end must implement a full virtio-net device.
> > > > Standalone devices are like vDPA device in this respect.
> > > >
> > > > I think it is important to have a protocol feature bit that adverti=
ses
> > > > that this is a standalone device, since the semantics are different=
 for
> > > > traditional vhost-user-net devices.
> > >
> > > Not sure what that would gain as compared to a feature bit per
> > > message as we did previously.
> >=20
> > Having a single feature bit makes it easier to distinguish between a
> > traditional vhost-user device and a standalone device.
> >=20
> > For example, the presence of VHOST_USER_F_GET_DEVICE_ID doesn't tell
> > you whether this device is a standalone device that is appropriate for
> > a new generic QEMU --device vhost-user-device feature that Alex is
> > working on. It could be a traditional vhost-user device that is not
> > standalone but implements the VHOST_USER_GET_DEVICE_ID message.
> >=20
> > How will we detect standalone devices? It will be messy if there is no
> > single feature bit that advertises that this back-end is a standalone
> > device.
> >=20
> > Stefan
>=20
> Looks like standalone implies some 5-6 messages to be supported.
> So just test the 6 bits are all ones.

It's not clear to me that the individual bits together mean this is
really a standalone device, but let's go with individual commands and
see if a front-end can distinguish standalone devices or not. If not,
then we can still add "standalone" feature bit before merging the code.

Stefan

--o5VRGi/hTISP7+bi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmS+vicACgkQnKSrs4Gr
c8gwHAf/Zt97EcRQvJNEWrSazGTKbMTLdGKZ7TelOycHhzAnDHdlCyrx1BGi544l
rp4kQ7TcJN9zqH1wmQ2SBCkGUnkDCl6y2P3Ce989k2FY6YM0+kJIifJxAvUCOFXK
DCYXTTB6ARA0IAV3lB+nPXLbZ8YCdFyMHGEQ3HtvRA7h8z3EvzzMcL3RZDm9QPOg
QPL2mPB77lpWvtpBivQudZtVBiM5/3AqavlvS2A5WgFQMO+IDW1BfkCNRAY+UMX0
68vth18G0A7LJQ731qmSxRKhcOUbyQIcJTesMwQmx0GYOzGY1wDCb06j7OghZQmV
ACcFtLAFRdp7jg4yKdt+2mzS2HTzcA==
=HvKo
-----END PGP SIGNATURE-----

--o5VRGi/hTISP7+bi--


