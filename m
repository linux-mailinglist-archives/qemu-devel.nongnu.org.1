Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2DC7A0788
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 16:40:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgnVB-0008Nf-Gq; Thu, 14 Sep 2023 10:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgnV8-0008NF-Mx
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 10:39:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgnV0-0000KY-Vq
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 10:39:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694702357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cQCiT93qxcDF6QFB3Lc11Kn3Rg0j5FjV7iyKL8A+fVc=;
 b=UDg/TRdkujIapKSQAn3e860SAEV26bfx5ovo+1FwnkBE3gjT1L4FKc30nB0dt7I54/+2JJ
 BwyryrpK+nhhfklpUhn4jzHC7YzLVcwSEciaCqGJxRZQ6rcxzYlLBdZvFHMbqYIr0jK5bW
 5wQjArsFNXdfoi47DU2cJY2fe38tE2k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-36-9BSByDa-OO28I0WhQQ7nrQ-1; Thu, 14 Sep 2023 10:39:16 -0400
X-MC-Unique: 9BSByDa-OO28I0WhQQ7nrQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6EE87101D25D;
 Thu, 14 Sep 2023 14:39:14 +0000 (UTC)
Received: from localhost (unknown [10.39.194.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B734B40C6EA8;
 Thu, 14 Sep 2023 14:39:13 +0000 (UTC)
Date: Thu, 14 Sep 2023 10:39:12 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mattias Nissler <mnissler@rivosinc.com>
Cc: qemu-devel@nongnu.org, john.levon@nutanix.com,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 0/5] Support message-based DMA in vfio-user server
Message-ID: <20230914143912.GA1066211@fedora>
References: <20230907130410.498935-1-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="K95de4OWTPElmcR4"
Content-Disposition: inline
In-Reply-To: <20230907130410.498935-1-mnissler@rivosinc.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--K95de4OWTPElmcR4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 07, 2023 at 06:04:05AM -0700, Mattias Nissler wrote:
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
> Note that there is some more work required on top of this series to get
> message-based DMA to really work well:
>=20
> * libvfio-user has a long-standing issue where socket communication gets =
messed
>   up when messages are sent from both ends at the same time. See
>   https://github.com/nutanix/libvfio-user/issues/279 for more details. I'=
ve
>   been engaging there and a fix is in review.
>=20
> * qemu currently breaks down DMA accesses into chunks of size 8 bytes at
>   maximum, each of which will be handled in a separate vfio-user DMA requ=
est
>   message. This is quite terrible for large DMA accesses, such as when nv=
me
>   reads and writes page-sized blocks for example. Thus, I would like to i=
mprove
>   qemu to be able to perform larger accesses, at least for indirect memory
>   regions. I have something working locally, but since this will likely r=
esult
>   in more involved surgery and discussion, I am leaving this to be addres=
sed in
>   a separate patch.

Have you tried setting mr->ops->valid.max_access_size to something like
64 KB?

Paolo: Any suggestions for increasing DMA transaction sizes?

Stefan

>=20
> Changes from v1:
>=20
> * Address Stefan's review comments. In particular, enforce an allocation =
limit
>   and don't drop the map client callbacks given that map requests can fai=
l when
>   hitting size limits.
>=20
> * libvfio-user version bump now included in the series.
>=20
> * Tested as well on big-endian s390x. This uncovered another byte order i=
ssue
>   in vfio-user server code that I've included a fix for.
>=20
> Changes from v2:
>=20
> * Add a preparatory patch to make bounce buffering an AddressSpace-specif=
ic
>   concept.
>=20
> * The total buffer size limit parameter is now per AdressSpace and can be
>   configured for PCIDevice via a property.
>=20
> * Store a magic value in first bytes of bounce buffer struct as a best ef=
fort
>   measure to detect invalid pointers in address_space_unmap.
>=20
> Mattias Nissler (5):
>   softmmu: Per-AddressSpace bounce buffering
>   softmmu: Support concurrent bounce buffers
>   Update subprojects/libvfio-user
>   vfio-user: Message-based DMA support
>   vfio-user: Fix config space access byte order
>=20
>  hw/pci/pci.c                  |   8 ++
>  hw/remote/trace-events        |   2 +
>  hw/remote/vfio-user-obj.c     |  88 +++++++++++++++++--
>  include/exec/cpu-common.h     |   2 -
>  include/exec/memory.h         |  39 ++++++++-
>  include/hw/pci/pci_device.h   |   3 +
>  softmmu/dma-helpers.c         |   4 +-
>  softmmu/memory.c              |   4 +
>  softmmu/physmem.c             | 155 ++++++++++++++++++----------------
>  subprojects/libvfio-user.wrap |   2 +-
>  10 files changed, 220 insertions(+), 87 deletions(-)
>=20
> --=20
> 2.34.1
>=20

--K95de4OWTPElmcR4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUDGxAACgkQnKSrs4Gr
c8j+Owf9EwUZlanvgfUnPHV6AFc/RQRtwk27eeI8Tacprr4oUmgrw+6ye5bv8Jui
D+diUcuS6K48GDE+vXeHPxfK1PDQV0JMjzyT6yVxFof9BNXFP368TwvUa3TIz3RX
rMzzIFAxaDWkh9MlcP/6MEmiq0zMrE/pcW3DWYJa6W1Oj4+7eiHrjgYsbyLCmYLN
effNbo6oV1n6tVhuLQ1GcwtSVvUn4K57FZgNOjs5xFtBEtgxKHSkaA6ENmAmB184
9c0C/Fr6mX6+BEi/x7mohkRClIJtNwV+qU99IxybMoOhb44ohCjMewCit6EvUmEj
4kNirJ1bs+vNxBHXuAf4ZBPWCjwdkw==
=O2H0
-----END PGP SIGNATURE-----

--K95de4OWTPElmcR4--


