Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 760EC74D5E6
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:41:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIqCR-0007yX-Ly; Mon, 10 Jul 2023 08:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qIqCK-0007vy-Tl
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:41:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qIqCJ-0007CP-G1
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:41:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688992858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QA9VrpLt5kpq5L3ikXfrFZrFGTdb++9t3ToNHTnsvsc=;
 b=MW4upWaZyHS5ztkwWHIxX1cz+hmtujMh3LU7GecUQiZihjbedw12OU2nvVk80kumLy4uST
 DsaoHR8VqA+Gyks+bel1KMkHtCRn5Zx9HRAqG9Cu9L0QLNMo6ye3aQLxPN22YXIuBzqTxk
 HMMtLdnH6xE2U02muHMKFGNZIDQCuKE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-oWK4ZfrgOHK94FLrOgFJgQ-1; Mon, 10 Jul 2023 08:40:52 -0400
X-MC-Unique: oWK4ZfrgOHK94FLrOgFJgQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5DB5B185A78B;
 Mon, 10 Jul 2023 12:40:52 +0000 (UTC)
Received: from redhat.com (unknown [10.39.195.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E8C1C478DE;
 Mon, 10 Jul 2023 12:40:51 +0000 (UTC)
Date: Mon, 10 Jul 2023 14:40:50 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-block@nongnu.org, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: [PULL 11/23] Revert "graph-lock: Disable locking for now"
Message-ID: <ZKv8UvKOHo6VX5g/@redhat.com>
References: <20230628141526.293104-1-kwolf@redhat.com>
 <20230628141526.293104-12-kwolf@redhat.com>
 <ZKv4G4A0l8EhMZoy@cormorant.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Eng89UzZ8jWCZbEn"
Content-Disposition: inline
In-Reply-To: <ZKv4G4A0l8EhMZoy@cormorant.local>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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


--Eng89UzZ8jWCZbEn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 10.07.2023 um 14:22 hat Klaus Jensen geschrieben:
> On Jun 28 16:15, Kevin Wolf wrote:
> > Now that bdrv_graph_wrlock() temporarily drops the AioContext lock that
> > its caller holds, it can poll without causing deadlocks. We can now
> > re-enable graph locking.
> >=20
> > This reverts commit ad128dff0bf4b6f971d05eb4335a627883a19c1d.
> >=20
>=20
> I'm seeing a pretty major performance regression on iothread-enabled
> virtio-blk (and on some on-going iothread hw/nvme work) with this
> applied. Something like ~300k iops prior to this vs ~200k after on my
> set up. On master, virtio-blk is currently faster without an iothread
> (~215k) than with (~200k).
>=20
> I bisected the change in iops to this revert.

Is CONFIG_DEBUG_GRAPH_LOCK enabled in your build? If so, this is
expected to cost some performance. If not, we need to take a look at
what else is causing the regression.

Kevin

--Eng89UzZ8jWCZbEn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAmSr/FIACgkQfwmycsiP
L9Z8BhAAl48CiZB/w+bdTQ0ofhya09vqjuNPfuJEWT7K4JJ/FjAv8hVyjFyp2QTG
Sr5KxZG2Y5CpFE0CgWqT5oGCt1rspPa4erMrKUcTCtRdj5qYIY0EFRutk/subbN7
JI9mXLAtkJWjb6xmyQ2S+5scTc6QPlql1foxi7Mkyn49NXAMdnQjULIwAluZ8sA2
0h+XGXNzTmZmwOs9z7FdnrdYK07uBinPHcteeotJl8ThJk9QhMYumKyV/USqZyts
MyPNIl/wsA7uVAdFmzck6YrHXITGnFYq5z88lPcwzoi491OSmYRBRQv2paqlpYEV
L5ILN8M+pABQWUyuhersQnLV0ZTP1plo3MTmAURvNX2ctdvU7y6syeB6ddes4rrO
gnjlNl/rQ/rnb5uMItptlHmL+1mR3PciAu+KH/ZOfzYT3LEWNkh1LKA3lfmPh4q0
BCnjY+pclqWV8Ek+REJSaQLbs7HqnlCROMMr5TNbXCA/pZBO4b6+RFkVfWPlYy42
gbrFDVDMTCcdFtCR514cMq4nDUpd7gzkFKwSyVUDk87GEsf+Aqw/NJuzMpgRX87q
b9vZiPtnSLVyCMpab3CspISW983ArYfuXy5JW9oMaGHpk5BqhLXfGFW5nYye3d4q
3rR2UQWGM71w7b9RxoDfx1cNbv1RpNrPCymNW3xixTCPcG6M4qo=
=N6QT
-----END PGP SIGNATURE-----

--Eng89UzZ8jWCZbEn--


