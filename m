Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E1C7359F8
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 16:45:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBG88-0001gg-NM; Mon, 19 Jun 2023 10:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qBG87-0001fB-3y
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:45:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qBG85-0007X1-Ez
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687185916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PGchxwlSNZ3DTlOU8gVHA0bUX+njFGdzFVwSEEPTunM=;
 b=Yj/FqyXnhfvdwLijuKTG1McQA2VdLsCW686ZMUnmQ2QKgr9w1LJQQO/jK6dvJVKeRufGAn
 ePjvs4R9H5i8BpRDXf7goML25RYRhXxpUOP45pKPoHeixGECydt5kPQ/nHlNsJj8JMFg6G
 SrMlQxwLVc+9k7ca2Tkd1zaQqHflFjc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-JUSiI6utP2K7LxyQUD2D4A-1; Mon, 19 Jun 2023 10:45:13 -0400
X-MC-Unique: JUSiI6utP2K7LxyQUD2D4A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B888101A52C;
 Mon, 19 Jun 2023 14:45:12 +0000 (UTC)
Received: from localhost (unknown [10.39.192.41])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5CA6140C95A9;
 Mon, 19 Jun 2023 14:45:10 +0000 (UTC)
Date: Mon, 19 Jun 2023 16:45:10 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "fam@euphon.net" <fam@euphon.net>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "kwolf@redhat.com" <kwolf@redhat.com>,
 "hreitz@redhat.com" <hreitz@redhat.com>,
 Klaus Birkelund Jensen <k.jensen@samsung.com>,
 "eblake@redhat.com" <eblake@redhat.com>
Subject: Re: [PATCH v2 3/3] hw/ufs: Support for UFS logical unit
Message-ID: <20230619144510.GG2497337@fedora>
References: <20230619082325.GB2497337@fedora>
 <20230616065827epcms2p2ad3eefa7762feafe673ff9c0a54ba007@epcms2p2>
 <CGME20230616065827epcms2p2ad3eefa7762feafe673ff9c0a54ba007@epcms2p7>
 <20230619111627epcms2p70ab099f30804d2819b72f105c6f28e19@epcms2p7>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JaWWuMzZyq370s8L"
Content-Disposition: inline
In-Reply-To: <20230619111627epcms2p70ab099f30804d2819b72f105c6f28e19@epcms2p7>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


--JaWWuMzZyq370s8L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 19, 2023 at 08:16:27PM +0900, Jeuk Kim wrote:
> On Fri, Jun 19, 2023, Stefan Hajnoczi wrote:
> >On Fri, Jun 16, 2023 at 03:58:27PM +0900, Jeuk Kim wrote:
> >> This commit adds support for ufs logical unit.
> >> The LU handles processing for the SCSI command,
> >> unit descriptor query request.
> >>=20
> >> This commit enables the UFS device to process
> >> IO requests.
> >
> >Is UFS a SCSI Host Bus Adapter capable of exposing any SCSI device? The
> >code is written as if UFS was a special-purpose SCSI bus that cannot
> >handle regular SCSI devices already emulated by QEMU (like scsi-hd). As
> >a result, it duplicates a lot of SCSI device code instead of just
> >focussing on unwrapping/wrapping the SCSI commands and responses from
> >the UFS interface.
> >
> >Would it be possible to have:
> >
> >  --device ufs,id=3D<bus-name>
> >  --device scsi-hd,bus=3D<bus-name>
> >
> >?
> >
> >I think that would involve less code and be more flexible.
> >
>=20
> Unfortunately, UFS is not a generic SCSI Host Bus Adapter.
> UFS uses the SCSI specification to communicate with the driver,
> but its behaviour is very different from that of a typical SCSI device.
> (So it's intentional that UFS looks like a special-purpose SCSI bus.)
>=20
> For example, UFS has the well-known lu.
> Unlike typical SCSI devices, where each lu is independent,
> UFS can control other lu's through the well-known lu.
>=20
> Therefore, UFS can only work properly with ufs-lu, and not with
> other scsi devices such as scsi-hd. :'(
>=20
> That's why I made the UFS bus and added the ufs_bus_check_address()
> to prevent normal scsi devices and UFS from connecting to each other.
>=20
> Also, in the future, I will add more ufs-specific features
> like hibernation and zoned, which are different from normal SCSI devices.
>=20
> So personally, I think we should define ufs-lu separately as we do now.
> Is that okay?

Yes, I think that makes sense. Thanks for explaining.

Paolo Bonzini is the QEMU SCSI emulation maintainer. He might have more
thoughts about this. I have CCed him, but I think you can continue with
the current approach unless Paolo decides to get involved in this patch
series.

Stefan

--JaWWuMzZyq370s8L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmSQafYACgkQnKSrs4Gr
c8jDoQgAnnlQrdzxI59/HdM55aRZLODQ8VWsgJFMnjF2q9aMxYKm+BS5iKbeRdmv
xhNrx/ZkfAjyvRmp47+TYk7K5UAQhAXjSwLxXjLutuJIkWbyGC+hDMX9b3HET6yB
ohyp05GXMN2Qqf1AKC8CGotnZ0dLUs0IMQyHghTHN1GxmaGoxXX9uyfmjDi/u5d1
v/25py5hc/lkywVVdrnhxTuqqJmrfFMjAx5/Jcu+ugoUHOT/+2kNuBCgob55c48D
TIhqyUF3AfHaJIC1h7ro97XhoyhkSZaG78xfNWimrVreQdP6CEMK00dR7BXrGtbw
ueFuK8OSF/KOfbEoYmSonrvDuPjFmA==
=Og+M
-----END PGP SIGNATURE-----

--JaWWuMzZyq370s8L--


