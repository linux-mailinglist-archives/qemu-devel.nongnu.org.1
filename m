Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B901379F1F4
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 21:24:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgVSM-0007FJ-3i; Wed, 13 Sep 2023 15:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgVS8-0007Eb-7s
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 15:23:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgVS5-0003zp-Vl
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 15:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694632985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=Df8kghh2MvgIffcCn2eNol8oqWS5FvmRyW6NHM1qTDI=;
 b=UhDCOpmKLDFJ5I5TKauaZzXxxJmHzakDv1pnE5FMtwjnRztU4XkbIp2Gh37gViSNG0xJ9q
 darzQ2R0/y81hcTNIJZ0yvNtPuqUrHJZTEuRhKb80GYlNEUV8EuYU/ftGzRD3BMCvljgbt
 IME5matfSUW5+GQ9VFR8sHqIGke0M4s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-322-_JpPvyVnNV6fEU4BJe2GSg-1; Wed, 13 Sep 2023 15:23:03 -0400
X-MC-Unique: _JpPvyVnNV6fEU4BJe2GSg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D638101A529
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 19:23:03 +0000 (UTC)
Received: from localhost (unknown [10.39.192.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB9AB200BC7F;
 Wed, 13 Sep 2023 19:23:02 +0000 (UTC)
Date: Wed, 13 Sep 2023 15:23:01 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: QEMU migration-test CI intermittent failure
Message-ID: <20230913192301.GA917052@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0ybhYX6rGTBfF2ZP"
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--0ybhYX6rGTBfF2ZP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,
The following intermittent failure occurred in the CI and I have filed
an Issue for it:
https://gitlab.com/qemu-project/qemu/-/issues/1886

Output:

  >>> QTEST_QEMU_IMG=3D./qemu-img MALLOC_PERTURB_=3D116 QTEST_QEMU_STORAGE_=
DAEMON_BINARY=3D./storage-daemon/qemu-storage-daemon G_TEST_DBUS_DAEMON=3D/=
builds/qemu-project/qemu/tests/dbus-vmstate-daemon.sh QTEST_QEMU_BINARY=3D.=
/qemu-system-x86_64 /builds/qemu-project/qemu/build/tests/qtest/migration-t=
est --tap -k
  =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80  =E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95
  stderr:
  qemu-system-x86_64: Unable to read from socket: Connection reset by peer
  Memory content inconsistency at 5b43000 first_byte =3D bd last_byte =3D b=
c current =3D 4f hit_edge =3D 1
  **
  ERROR:../tests/qtest/migration-test.c:300:check_guests_ram: assertion fai=
led: (bad =3D=3D 0)
  (test program exited with status code -6)

You can find the full output here:
https://gitlab.com/qemu-project/qemu/-/jobs/5080200417

Please take a look!

Thanks,
Stefan

--0ybhYX6rGTBfF2ZP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUCDBUACgkQnKSrs4Gr
c8jLzQf9GS9pD5CWa3K58Cu/3BALKzImP2ECqNZdvq0Inr2b0j+2tEyIfs/omxua
q+S1WY1LLKng6q4NHlY9F2iPSAxTJrJRzrU4RAFouJbBWmurjSoaX2DYBnMPUpMr
CxcPoab5FxlrfhgLv1E25Ti37dBVbmvqvCQcNSWbwN8itNOJkVLd7niqCrrkqgpm
GpcD/jPq4Sxnn3PxcFhneXf+dl+054h38gqjlVNjfkhbVuNDZANi30zzLNJFJnXJ
6bV5CefaOYzUT4yXMWMKmZdctk9llWvkIpw285Na+6ZwHoiPG3eMSE2qm508hazX
geoqAGtuIkiqUS+lEN3YLfCVBrL0MA==
=B5XD
-----END PGP SIGNATURE-----

--0ybhYX6rGTBfF2ZP--


