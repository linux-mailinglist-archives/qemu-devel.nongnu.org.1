Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE297A69CB
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 19:43:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiejm-00087K-JT; Tue, 19 Sep 2023 13:42:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qiejj-00085b-Nc
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 13:42:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qiejf-0005cR-9e
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 13:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695145325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=fkS6W4h0fJ1BMQy864xb5tjzek0Wj46PU2lpXxBaqms=;
 b=MnGXm8Ko2EWVeiK/IYIal7ifVnaYiOxCGzrQK+CmTKylcPtq/NCe1uvliMeSH5sFvfVYqS
 Enm1eS+fzYBlPWizVT6chnzw8E1ALPGF1a9k5XradeJrGoutToQMsvx0x46i7wVX7p6gbx
 SAKh/5DLKZ25QT/+F5XpJtHthqKdYgE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-487-zwLmQ-YAMFOLO-ZSZtkH6Q-1; Tue, 19 Sep 2023 13:42:03 -0400
X-MC-Unique: zwLmQ-YAMFOLO-ZSZtkH6Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B03F85A5BA;
 Tue, 19 Sep 2023 17:42:02 +0000 (UTC)
Received: from localhost (unknown [10.39.192.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1FFBD10EE859;
 Tue, 19 Sep 2023 17:42:01 +0000 (UTC)
Date: Tue, 19 Sep 2023 13:42:00 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: npcm7xx_timer-test.c is unreliable
Message-ID: <20230919174200.GA1542425@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="L0/RzYScWsUvj8df"
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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


--L0/RzYScWsUvj8df
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,
Sometimes npcm7xx_timer-test fails intermittently: https://gitlab.com/qemu-=
project/qemu/-/jobs/5121787250

38/96 qemu:qtest+qtest-arm / qtest-arm/npcm7xx_timer-test           ERROR  =
         0.95s   exit status 1
>>> QTEST_QEMU_BINARY=3D./qemu-system-arm QTEST_QEMU_STORAGE_DAEMON_BINARY=
=3D./storage-daemon/qemu-storage-daemon G_TEST_DBUS_DAEMON=3D/builds/qemu-p=
roject/qemu/tests/dbus-vmstate-daemon.sh QTEST_QEMU_IMG=3D./qemu-img MALLOC=
_PERTURB_=3D103 /builds/qemu-project/qemu/build/tests/qtest/npcm7xx_timer-t=
est --tap -k
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80  =E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95
stderr:
**
ERROR:../tests/qtest/npcm7xx_timer-test.c:475:test_periodic_interrupt: asse=
rtion failed (tim_read(td, TISR) =3D=3D tim_timer_bit(td)): (0x00000000 =3D=
=3D 0x00000004)
**
ERROR:../tests/qtest/npcm7xx_timer-test.c:476:test_periodic_interrupt: 'qte=
st_get_irq(global_qtest, tim_timer_irq(td))' should be TRUE
(test program exited with status code 1)
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95

When I reran the CI job, it passed.

Please investigate why this test is unreliable and fix it. Thanks!

There is a GitLab Issue to track this here:
https://gitlab.com/qemu-project/qemu/-/issues/1897

Stefan

--L0/RzYScWsUvj8df
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUJ3WgACgkQnKSrs4Gr
c8j6nAf+PXJRPeicg7B3OQX3416vrNXQjzW9QGy6PZk/uZefScgpyXDdnwq9bydV
axECq6N/FzpZCa+Ulv+mXQtvYeAGE2zIQWCz6a2FZ1+ih+NUT4h1ltueqswQgDsn
e97Ap8sCHaUEsHqEk9HebPldyzl+nCtQ+H9zC0vcqdzt6CCvP5MmsacAWpctAgW3
cJnl4S75sZQ4pIImPlMUwOMTZMOdOfKbdJg0dooDdwQvKzI5/f4eIObW5/oXF+Kz
WixqXuaFJjOeCNsm4Z9eR8yTINQ3JCfVq5w5kjbMGNSJV3S930da6x997wa3ZQAy
gEI+s0mWU4JXzpQ0rQQ7gM6mZ+HLsw==
=lr6J
-----END PGP SIGNATURE-----

--L0/RzYScWsUvj8df--


