Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E347FFC7E
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 21:30:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8nf7-0005O0-Hk; Thu, 30 Nov 2023 15:29:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r8nf5-0005Mp-RJ
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 15:29:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r8nf4-00068e-BK
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 15:29:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701376165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pspgY/UtbTR6ASTEqbHV7C5jZMpcDbn0C1ttaW0vK+0=;
 b=TZ5QcwbdkUiWOndpZKjA4m0ET9sQ1SL5h9IM3IpCXT2fj1bgBxxaC3OxZmovJRmqCBI4Z5
 2D93jWwoyJ+WyRHgI5rD0M+26SalMsPCK92tcwQz7q8Mqbdgvc468AIrwrQmi01Ih5CgP1
 WbnUx4pBbyn4r9QvaDtxLbjJasDTTKo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-DFipSJ9NNb6fbEEPaw_Vzw-1; Thu,
 30 Nov 2023 15:29:21 -0500
X-MC-Unique: DFipSJ9NNb6fbEEPaw_Vzw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B2941C06EC1;
 Thu, 30 Nov 2023 20:29:18 +0000 (UTC)
Received: from localhost (unknown [10.39.192.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1713E36E2;
 Thu, 30 Nov 2023 20:27:34 +0000 (UTC)
Date: Thu, 30 Nov 2023 15:27:32 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Jean-Christophe Dubois <jcd@tribudubois.net>,
 Fabiano Rosas <farosas@suse.de>, qemu-s390x@nongnu.org,
 Song Gao <gaosong@loongson.cn>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Hyman Huang <yong.huang@smartx.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, Paul Durrant <paul@xen.org>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Juan Quintela <quintela@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Huacai Chen <chenhuacai@kernel.org>, Fam Zheng <fam@euphon.net>,
 Eric Blake <eblake@redhat.com>, Jiri Slaby <jslaby@suse.cz>,
 Alexander Graf <agraf@csgraf.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Weiwei Li <liwei1518@gmail.com>, Eric Farman <farman@linux.ibm.com>,
 Stafford Horne <shorne@gmail.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Cameron Esfahani <dirty@apple.com>, xen-devel@lists.xenproject.org,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, qemu-riscv@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 John Snow <jsnow@redhat.com>, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Michael Roth <michael.roth@amd.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bin Meng <bin.meng@windriver.com>,
 Stefano Stabellini <sstabellini@kernel.org>, kvm@vger.kernel.org,
 qemu-block@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Peter Xu <peterx@redhat.com>, Anthony Perard <anthony.perard@citrix.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Leonardo Bras <leobras@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 2/6] qemu/main-loop: rename QEMU_IOTHREAD_LOCK_GUARD to
 QEMU_BQL_LOCK_GUARD
Message-ID: <20231130202732.GA1184658@fedora>
References: <20231129212625.1051502-1-stefanha@redhat.com>
 <20231129212625.1051502-3-stefanha@redhat.com>
 <c3ac8d9c2b9d611e84672436ce1a96aedcaacf5e.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IGy9nSmIZnwUahKG"
Content-Disposition: inline
In-Reply-To: <c3ac8d9c2b9d611e84672436ce1a96aedcaacf5e.camel@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


--IGy9nSmIZnwUahKG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 10:14:47AM +0100, Ilya Leoshkevich wrote:
> On Wed, 2023-11-29 at 16:26 -0500, Stefan Hajnoczi wrote:
> > The name "iothread" is overloaded. Use the term Big QEMU Lock (BQL)
> > instead, it is already widely used and unambiguous.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > =A0include/qemu/main-loop.h=A0 | 20 ++++++++++----------
> > =A0hw/i386/kvm/xen_evtchn.c=A0 | 14 +++++++-------
> > =A0hw/i386/kvm/xen_gnttab.c=A0 |=A0 2 +-
> > =A0hw/mips/mips_int.c=A0=A0=A0=A0=A0=A0=A0 |=A0 2 +-
> > =A0hw/ppc/ppc.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 2 +-
> > =A0target/i386/kvm/xen-emu.c |=A0 2 +-
> > =A0target/ppc/excp_helper.c=A0 |=A0 2 +-
> > =A0target/ppc/helper_regs.c=A0 |=A0 2 +-
> > =A0target/riscv/cpu_helper.c |=A0 4 ++--
> > =A09 files changed, 25 insertions(+), 25 deletions(-)
> >=20
> > diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
> > index d6f75e57bd..0b6a3e4824 100644
> > --- a/include/qemu/main-loop.h
> > +++ b/include/qemu/main-loop.h
> > @@ -344,13 +344,13 @@ void qemu_bql_lock_impl(const char *file, int
> > line);
> > =A0void qemu_bql_unlock(void);
> > =A0
> > =A0/**
> > - * QEMU_IOTHREAD_LOCK_GUARD
> > + * QEMU_BQL_LOCK_GUARD
> > =A0 *
> > - * Wrap a block of code in a conditional
> > qemu_mutex_{lock,unlock}_iothread.
> > + * Wrap a block of code in a conditional qemu_bql_{lock,unlock}.
> > =A0 */
> > -typedef struct IOThreadLockAuto IOThreadLockAuto;
> > +typedef struct BQLLockAuto BQLLockAuto;
> > =A0
> > -static inline IOThreadLockAuto *qemu_iothread_auto_lock(const char
> > *file,
> > +static inline BQLLockAuto *qemu_bql_auto_lock(const char *file,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 int line)
>=20
> The padding is not correct anymore.

Good point, I didn't check the formatting after search-and-replace. I
will fix this across the patch series in v2.

Stefan

--IGy9nSmIZnwUahKG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVo8DQACgkQnKSrs4Gr
c8ge1wf+IIHG7oAMqIyOTOA/oFS2QG8uPyiFJQq8Zhme5LBuPIvsf8300Z76gAFP
LqKNIp9tEHi376ORvR9zKqXs6EyrAjdTT9jBThkjo9Dsw8WtdpMy1OP3sRZ6RZ5Z
BKv5+J0R2bvw5JBpc/wk7Fnypv5lgxFtWE/MiKDSG6jfjr6+6VDuHt3/CiBBs0cU
XCtQeZrqhRpjJVA0k05LM+8lVbx8H27bqQxQ9kLFFGpiDm0mMNtiQ+VyXLsxprcW
0OZ+iv46HtHiJtiBYEMxGxI7q3OJjnvS7fKklk3dLJAJxGHVUEedtOg9gzcMCec1
64wQWmIUbq61hdMdbFULncGwAIGa0w==
=I8on
-----END PGP SIGNATURE-----

--IGy9nSmIZnwUahKG--


