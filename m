Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A1975B707
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 20:43:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMYb0-00014X-97; Thu, 20 Jul 2023 14:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qMYay-00014P-WB
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 14:41:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qMYax-0001r0-Ax
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 14:41:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689878506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HQIw6nhGqBph9mjUixqyrBw7yfRwjID9ngPBke9zhrg=;
 b=HedSli/6LpkIdZA1rXgMYvbwvEvaJC0Jrm4TD1c6Fgm+y5y9nidl/v1Ar+wwpBGYBCHQxB
 53aOwf6wBJ/ONznNy20W6G1+ZxKaVrrMLLXOMkNgoTOQk8OKRzHg4yAXcsSqviGxio83nY
 g1tQXZHVhJrVSqglONDAro1GONHCO7Q=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-222-hXFlFt-UMJ-tBtLVipv-8g-1; Thu, 20 Jul 2023 14:41:41 -0400
X-MC-Unique: hXFlFt-UMJ-tBtLVipv-8g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 740551C0B9E3;
 Thu, 20 Jul 2023 18:41:41 +0000 (UTC)
Received: from localhost (unknown [10.39.194.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CEB351121314;
 Thu, 20 Jul 2023 18:41:40 +0000 (UTC)
Date: Thu, 20 Jul 2023 14:41:39 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mattias Nissler <mnissler@rivosinc.com>
Cc: qemu-devel@nongnu.org, Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, john.levon@nutanix.com
Subject: Re: [PATCH 0/3] Support message-based DMA in vfio-user server
Message-ID: <20230720184139.GE210977@fedora>
References: <20230704080628.852525-1-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WY0SPySYxcaPJ7ki"
Content-Disposition: inline
In-Reply-To: <20230704080628.852525-1-mnissler@rivosinc.com>
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


--WY0SPySYxcaPJ7ki
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 04, 2023 at 01:06:24AM -0700, Mattias Nissler wrote:
> This series adds basic support for message-based DMA in qemu's vfio-user
> server. This is useful for cases where the client does not provide file
> descriptors for accessing system memory via memory mappings. My motivatin=
g use
> case is to hook up device models as PCIe endpoints to a hardware design. =
This
> works by bridging the PCIe transaction layer to vfio-user, and the endpoi=
nt
> does not access memory directly, but sends memory requests TLPs to the ha=
rdware
> design in order to perform DMA.
>=20
> Note that in addition to the 3 commits included, we also need a
> subprojects/libvfio-user roll to bring in this bugfix:
> https://github.com/nutanix/libvfio-user/commit/bb308a2e8ee9486a4c8b53d8d7=
73f7c8faaeba08
> Stefan, can I ask you to kindly update the
> https://gitlab.com/qemu-project/libvfio-user mirror? I'll be happy to inc=
lude
> an update to subprojects/libvfio-user.wrap in this series.

Done:
https://gitlab.com/qemu-project/libvfio-user/-/commits/master

Repository mirroring is automated now, so new upstream commits will
appear in the QEMU mirror repository from now on.

>=20
> Finally, there is some more work required on top of this series to get
> message-based DMA to really work well:
>=20
> * libvfio-user has a long-standing issue where socket communication gets =
messed
>   up when messages are sent from both ends at the same time. See
>   https://github.com/nutanix/libvfio-user/issues/279 for more details. I'=
ve
>   been engaging there and plan to contribute a fix.
>=20
> * qemu currently breaks down DMA accesses into chunks of size 8 bytes at
>   maximum, each of which will be handled in a separate vfio-user DMA requ=
est
>   message. This is quite terrible for large DMA acceses, such as when nvme
>   reads and writes page-sized blocks for example. Thus, I would like to i=
mprove
>   qemu to be able to perform larger accesses, at least for indirect memory
>   regions. I have something working locally, but since this will likely r=
esult
>   in more involved surgery and discussion, I am leaving this to be addres=
sed in
>   a separate patch.
>=20
> Mattias Nissler (3):
>   softmmu: Support concurrent bounce buffers
>   softmmu: Remove DMA unmap notification callback
>   vfio-user: Message-based DMA support
>=20
>  hw/remote/vfio-user-obj.c |  62 ++++++++++++++++--
>  softmmu/dma-helpers.c     |  28 --------
>  softmmu/physmem.c         | 131 ++++++++------------------------------
>  3 files changed, 83 insertions(+), 138 deletions(-)

Sorry for the late review. I was on vacation and am catching up on
emails.

Paolo worked on the QEMU memory API and can give input on how to make
this efficient for large DMA accesses. There is a chance that memory
dispatch with larger sizes will be needed for ENQCMD CPU instruction
emulation too.

Stefan

--WY0SPySYxcaPJ7ki
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmS5f+MACgkQnKSrs4Gr
c8hjUQgAmVbiLOytu8Ai9h9vZyRMrBZyFJiMJvpi0iEawdEYdIMS6WTitVAbkuh5
4MqKDPAsjAFlM6ArlIbiLswQCgtC/lrRNU6WmggF0JH2nOkiB/7fw3CfjOxcm8jQ
w6GwuBZutsTCay/Hjy8EuPrfxV8kECWvVRGc23ZojbkSqkwRYXRUaWOP5vWBxQtW
dnZTdHBPDsr5lobHjAztSXmvemLx5281T/ifAk/nlA9NbfUI6V4gBtiP/TWQfAy5
zHORy4IAhCZTHu0jda4vDNri6DR/UJka/uuUTEPzfHwp3DMxGrI4LTcMpH9TTOwf
lXn4uDbknntAZT3tXWrgW2Vzpx8fvA==
=hhfx
-----END PGP SIGNATURE-----

--WY0SPySYxcaPJ7ki--


