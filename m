Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 025FC784245
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 15:41:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYRcP-0005ge-KN; Tue, 22 Aug 2023 09:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYRcM-0005gJ-Q5
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 09:40:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYRcK-0006bu-0x
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 09:40:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692711618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xllcJciTJwkjZIlhV6UjbTwuh0nErD/MF676N4GEx7U=;
 b=b14qLt2DiW7tuJa4mi8AkzfSNaz7g68R5rO0+5B5X37FzbGsWWzqahGtUv2Ao+y0Ttxy7y
 CXQcv/W8O4zq+zxmgcLaV9efs2O3zyjAPlcS7fAw0pZNSnvJovIjg8yHweAkHQR28+A++g
 PCNGCsesIKXOh/kXYUnl/8rMAYG0KKw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-137-Pp5xutw2OVq7pwRhPtQgcw-1; Tue, 22 Aug 2023 09:40:14 -0400
X-MC-Unique: Pp5xutw2OVq7pwRhPtQgcw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 293DF856F67;
 Tue, 22 Aug 2023 13:40:14 +0000 (UTC)
Received: from localhost (unknown [10.39.195.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A25CB40D2843;
 Tue, 22 Aug 2023 13:40:13 +0000 (UTC)
Date: Tue, 22 Aug 2023 09:40:11 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel Verkamp <dverkamp@chromium.org>
Cc: virtio-comment@lists.oasis-open.org,
 virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org,
 Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Subject: Re: [virtio-comment] virtio queue numbering and optional queues
Message-ID: <20230822134011.GB727224@fedora>
References: <CABVzXAke4LRt4=S4FsFTFf_WPrAhe1dukoLZto6t6R13kgjw0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NsB0Om6PIIbwq28o"
Content-Disposition: inline
In-Reply-To: <CABVzXAke4LRt4=S4FsFTFf_WPrAhe1dukoLZto6t6R13kgjw0Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--NsB0Om6PIIbwq28o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 21, 2023 at 03:18:50PM -0700, Daniel Verkamp wrote:
> Hello virtio folks,

Hi Daniel,
I have CCed those involved in the free page hint and page reporting
features.

Stefan

>=20
> I noticed a mismatch between the way the specification defines
> device-specific virtqueue indexes and the way device and driver
> implementers have interpreted the specification. As a practical example,
> consider the traditional memory balloon device [1]. The first two queues
> (indexes 0 and 1) are available as part of the baseline device, but the
> rest of the queues are tied to feature bits.
>=20
> Section 5.5.2, "Virtqueues", gives a list that appears to be a mapping fr=
om
> queue index to queue name/function, defining queue index 3 as free_page_vq
> and index 4 as reporting_vq, and declaring that "free_page_vq only exists
> if VIRTIO_BALLOON_F_FREE_PAGE_HINT is set" and "reporting_vq only exists =
if
> VIRTIO_BALLOON_F_PAGE_REPORTING is set." This wording is a bit vague, but=
 I
> assume "is set" means "is negotiated" (not just "advertised by the
> device"). Also presumably "exists" means something like "may only be used
> by the driver if the feature bit is negotiated" and "should be ignored by
> the device if the feature bit is not negotiated", although it would be ni=
ce
> to have a proper definition in the spec somewhere.
>=20
> Section 5.5.3, "Feature bits", gives definitions of the feature bits, with
> similar descriptions of the relationship between the feature bits and
> virtqueue availability, although the wording is slightly different
> ("present" rather than "exists"). No dependency between feature bits is
> defined, so it seems like it should be valid for a device or driver to
> support or accept one of the higher-numbered features while not supporting
> a lower-numbered one.
>=20
>=20
> Notably, there is no mention of queue index assignments changing based on
> negotiated features in either of these sections. Hence a reader can only
> assume that the queue index assignments are fixed (i.e. stats_vq will
> always be vq index 4 if F_STATS_VQ is negotiated, regardless of any other
> feature bits).
>=20
> Now consider a scenario where VIRTIO_BALLOON_F_STATS_VQ and
> VIRTIO_BALLOON_F_PAGE_REPORTING are negotiated but
> VIRTIO_BALLOON_F_FREE_PAGE_HINT is not (perhaps the device supports all of
> the defined features but the driver only wants to use reporting_vq, not
> free_page_vq). In this case, what queue index should be used by the driver
> when enabling reporting_vq? My reading of the specification is that the
> reporting_vq is always queue index 4, independent of whether
> VIRTIO_BALLOON_F_STATS_VQ or VIRTIO_BALLOON_F_FREE_PAGE_HINT are
> negotiated, but this contradicts existing device and driver
> implementations, which will use queue index 3 (the next one after stats_vq
> =3D 2) as reporting_vq in this case.
>=20
> The qemu virtio-ballon device [2] assigns the next-highest unused queue
> index when calling virtio_add_queue(), and in the scenario presented abov=
e,
> free_page_vq will not be added since F_STATS_VQ is not negotiated, so
> reporting_vq will be assigned queue index 3, rather than 4. (Additionally,
> qemu always adds the stats_vq regardless of negotiated features, but that=
's
> irrelevant in this case since we are assuming the STATS_VQ feature is
> negotiated.)
>=20
> The Linux virtio driver code originally seemed to use the correct (by my
> reading) indexes, but it was changed to match the layout used by qemu in a
> 2019 commit ("virtio_pci: use queue idx instead of array idx to set up the
> vq") [3] - in other words, it will now also expect queue index 3 to be
> reporting_vq in the scenario laid out above.
>=20
> I'm not sure how to resolve the mismatch between the specification and
> actual implementation behavior. The simplest change would probably be to
> rewrite the specification to drop the explicit queue indexes in section
> 5.5.2 and add some wording about how queues are numbered based on
> negotiated feature bits (this would need to be applied to other device
> types that have specified queue indexes as well). However, this would also
> technically be an incompatible change of the specification. On the other
> hand, changing the device and driver implementations to match the
> specification would be even more challenging, since it would be an
> incompatible change in actual practice, not just a change of the spec to
> match consensus implementation behavior.
>=20
>=20
> Perhaps drivers could add a quirk to detect old versions of the qemu devi=
ce
> and use the old behavior, while enabling the correct behavior only for
> other device vendors and newer qemu device revisions, and the qemu device
> could add an opt-in feature to enable the correct behavior that users wou=
ld
> need to enable only when they know they have a sufficiently new driver wi=
th
> the fix.
>=20
>=20
> Or maybe there could be a new feature bit that would opt into following t=
he
> spec-defined queue indexes (VIRTIO_F_VERSION_2?) and some new wording to
> require devices to use the old behavior when that bit is not negotiated,
> but that also feels less than ideal to me.
>=20
> Any thoughts on how to proceed with this situation? Is my reading of the
> specification just wrong?
>=20
> Thanks,
>=20
> -- Daniel
>=20
> [1]:
> https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.ht=
ml#x1-3160002
>=20
> [2]:
> https://github.com/qemu/qemu/blob/f33c74576425fac2cbb0725229895fe096df426=
1/hw/virtio/virtio-balloon.c#L879-L897
>=20
> [3]:
> https://github.com/torvalds/linux/commit/ddbeac07a39a81d82331a312d0578fab=
94fccbf1

--NsB0Om6PIIbwq28o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTkursACgkQnKSrs4Gr
c8hY+Af/WebgXTM8+0jDCtOkr9ErLVrpWkHrmPJvRYq+/CZQGt/OxKZk65L4hNZm
N6POPg0QW57+SN3z4EDAedrUI4g5muy/PxLxKU6e+1G4oIIZOaMK6dvZ6Ef/bMfE
gaOcqAXWxsQgWbDmsRotEidmJ1Gak0R4WHwWUm549eGSFvgP1Cn7P77PeGwGSnIL
7k0yLX80514vq7iycJmUeUIb7H0lCkMoL49r0vzZO1tMvmwxp4FvuA60GwXsYn6E
QM80FTm/XB6qoPSnatQZsuwima8EZZewFaVsYjX33Zo++7CA0LzsHCJaOUjxCBOK
MBEJPFeyGd3uN+tdlppzDz48erQ4mw==
=o3yW
-----END PGP SIGNATURE-----

--NsB0Om6PIIbwq28o--


