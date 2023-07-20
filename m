Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA79F75B3BE
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 18:04:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMW89-0006Cp-20; Thu, 20 Jul 2023 12:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qMW86-00067s-0m
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 12:03:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qMW83-0006DR-RR
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 12:03:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689868995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F/RkjBNseSFxsP4eKVtLRJqD6U5PLeeq+J2j0YSh/to=;
 b=i2snkMRHmPLtNF1xyrVZDDTWm23pZlKaPIMozMl6EYvcsAHSnoo5QX8Rs3kVmJTLk+wUky
 YbWQYDHGyuAde2CjmLG8CiUA3LsEW2u633NNbcAOL0Z9GL5EQRO5oCRUV9CHE2snwzmGtY
 PaM9hZfETnK5mJnmedNfHced1KUdhuA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-544-oMobr-yLPwWjZZVx1P91hg-1; Thu, 20 Jul 2023 12:03:07 -0400
X-MC-Unique: oMobr-yLPwWjZZVx1P91hg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9262984B171
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 16:03:02 +0000 (UTC)
Received: from localhost (unknown [10.39.194.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C168F2166B25;
 Thu, 20 Jul 2023 16:03:01 +0000 (UTC)
Date: Thu, 20 Jul 2023 12:03:00 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [PATCH 6/6] vhost-user: Have reset_status fall back to reset
Message-ID: <20230720160300.GG184015@fedora>
References: <20230711155230.64277-1-hreitz@redhat.com>
 <20230711155230.64277-7-hreitz@redhat.com>
 <20230718151044.GG44841@fedora>
 <7ba1e055-e513-1735-5e60-eceb06fe877a@redhat.com>
 <0c8e2902-89a0-a9b6-744d-6ab737a0dbb0@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0wTypkegingWqqaq"
Content-Disposition: inline
In-Reply-To: <0c8e2902-89a0-a9b6-744d-6ab737a0dbb0@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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


--0wTypkegingWqqaq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2023 at 04:27:58PM +0200, Hanna Czenczek wrote:
> On 19.07.23 16:11, Hanna Czenczek wrote:
> > On 18.07.23 17:10, Stefan Hajnoczi wrote:
> > > On Tue, Jul 11, 2023 at 05:52:28PM +0200, Hanna Czenczek wrote:
> > > > The only user of vhost_user_reset_status() is vhost_dev_stop(), whi=
ch
> > > > only uses it as a fall-back to stop the back-end if it does not sup=
port
> > > > SUSPEND.=C2=A0 However, vhost-user's implementation is a no-op unle=
ss the
> > > > back-end supports SET_STATUS.
> > > >=20
> > > > vhost-vdpa's implementation instead just calls
> > > > vhost_vdpa_reset_device(), implying that it's OK to fully reset the
> > > > device if SET_STATUS is not supported.
> > > >=20
> > > > To be fair, vhost_vdpa_reset_device() does nothing but to set
> > > > the status
> > > > to zero.=C2=A0 However, that may well be because vhost-vdpa has no =
method
> > > > besides this to reset a device.=C2=A0 In contrast, vhost-user has
> > > > RESET_DEVICE and a RESET_OWNER, which can be used instead.
> > > >=20
> > > > While it is not entirely clear from documentation or git logs, from
> > > > discussions and the order of vhost-user protocol features, it
> > > > appears to
> > > > me as if RESET_OWNER originally had no real meaning for vhost-user,=
 and
> > > > was thus used to signal a device reset to the back-end.=C2=A0 Then,
> > > > RESET_DEVICE was introduced, to have a well-defined dedicated reset
> > > > command.=C2=A0 Finally, vhost-user received full STATUS support, in=
cluding
> > > > SET_STATUS, so setting the device status to 0 is now the preferred =
way
> > > > of resetting a device.=C2=A0 Still, RESET_DEVICE and RESET_OWNER sh=
ould
> > > > remain valid as fall-backs.
> > > >=20
> > > > Therefore, have vhost_user_reset_status() fall back to
> > > > vhost_user_reset_device() if the back-end has no STATUS support.
> > > >=20
> > > > Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> > > > ---
> > > > =C2=A0 hw/virtio/vhost-user.c | 2 ++
> > > > =C2=A0 1 file changed, 2 insertions(+)
> > > >=20
> > > > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > > > index 4507de5a92..53a881ec2a 100644
> > > > --- a/hw/virtio/vhost-user.c
> > > > +++ b/hw/virtio/vhost-user.c
> > > > @@ -2833,6 +2833,8 @@ static void vhost_user_reset_status(struct
> > > > vhost_dev *dev)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (virtio_has_feature(dev->protocol=
_features,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 VHOST_USER_PROTOCOL_F_STATUS)) {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vhost_user_s=
et_status(dev, 0);
> > > > +=C2=A0=C2=A0=C2=A0 } else {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vhost_user_reset_device=
(dev);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > =C2=A0 }
> > > Did you check whether DPDK treats setting the status to 0 as equivale=
nt
> > > to RESET_DEVICE?
> >=20
> > If it doesn=E2=80=99t, what=E2=80=99s even the point of using reset_sta=
tus?
>=20
> Sorry, I=E2=80=99m being unclear, and I think this may be important becau=
se it ties
> into the question from patch 1, what qemu is even trying to do by running
> SET_STATUS(0) vhost_dev_stop(), so here=E2=80=99s what gave me the impres=
sion that
> SET_STATUS(0) and RESET_DEVICE should be equivalent:
>=20
> vhost-vdpa.c runs SET_STATUS(0) in a function called
> vhost_vdpa_reset_device().=C2=A0 This is one thing that gave me the impre=
ssion
> that this is about an actual full reset.
>=20
> Another is the whole discussion that we=E2=80=99ve had.=C2=A0 vhost_dev_s=
top() does not
> call a `vhost_reset_device()` function, it calls `vhost_reset_status()`.=
=C2=A0
> Still, we were always talking about resetting the device.

There is some hacky stuff with struct vhost_dev's vq_index_end and
multi-queue devices. I think it's because multi-queue vhost-net device
consist of many vhost_devs and NetClientStates, so certain vhost
operations are skipped unless this is the "first" or "last" vhost_dev
=66rom a large aggregate vhost-net device. That might be responsible for
part of the weirdness.

>=20
> It doesn=E2=80=99t make sense to me that vDPA would provide no function t=
o fully
> reset a device, while vhost-user does.=C2=A0 Being able to reset a device=
 sounds
> vital to me.=C2=A0 This also gave me the impression that SET_STATUS(0) on=
 vDPA at
> least is functionally equivalent to a full device reset.
>=20
>=20
> Maybe SET_STATUS(0) does mean a full device reset on vDPA, but not on
> vhost-user.=C2=A0 That would be a real shame, so I assumed this would not=
 be the
> case; that SET_STATUS(0) does the same thing on both protocols.

Yes, exactly. It has the real VIRTIO spec meaning in vDPA. In vhost-user
it's currently only used by DPDK as a hint for when device
initialization is complete:
https://github.com/DPDK/dpdk/commit/41d201804c4c44738168e2d247d3b1780845faa1

> The virtio specification says =E2=80=9CWriting 0 into this field resets t=
he device.=E2=80=9D
> about the device_status field.
>=20
> This also makes sense, because the device_status field is basically used =
to
> tell the device that a driver has taken control.=C2=A0 If reset, this ind=
icates
> the driver has given up control, and to me this is a point where a device
> should fully reset itself.
>=20
> So all in all, I can=E2=80=99t see the rationale why any implementation t=
hat
> supports SET_STATUS would decide to treat SET_STATUS(0) not as equivalent=
 or
> a superset of RESET_DEVICE.=C2=A0 I may be wrong, and this might explain =
a whole
> deal about what kind of background operations we hope to stop with
> SET_STATUS(0).

I would like vhost-user devices to implement SET_STATUS according to the
VIRTIO specification in the future and they can do that. But I think
front-ends should continue sending RESET_DEVICE in order to support old
devices.

Stefan

--0wTypkegingWqqaq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmS5WrQACgkQnKSrs4Gr
c8hAUQf/Zv+lL9IFYepRn47L0lBsb9u3BrzxyWahBttjYOuNFhfKfp3OhK5DCPOE
mlz6jXUlqX6PzLskgW/ty7vTnMaufqAH49jW/glp1LFIdUBzuFQhsXjV923Oyr7B
F1i1BCVmHHxvhdhu5AX1Yh4SGbB3eHqHbEwxiMKoOWRQ8a4WAEyLEy42emBwsgrY
Sw3ThLvQ+klFwIRfLghcunodJKvJHjk9mi/WikxJxZclGkF3pZICAr1/gyXXkcGK
hhVB1Xv0UJ1/vB/zsM2lGbZ7NajraC8pD1l8MLWZPso7YRjub+SGUD2Nn0iQypXY
erBYn+BWQ3BL0rti3C+F6rjbTHiHcw==
=YEZC
-----END PGP SIGNATURE-----

--0wTypkegingWqqaq--


