Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D00A57AD1E3
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 09:39:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkgBT-00016J-0D; Mon, 25 Sep 2023 03:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qkgBP-000169-9F
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 03:39:08 -0400
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qkgBN-0004us-1v
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 03:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
 t=1695627538; x=1696232338; i=lukasstraub2@web.de;
 bh=EdzbkdlNX/cQkGXw2RqeQFomSNdSb3DqI2gTpAjYZog=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=ZxEol4t3D6EtY5QFXW7iBmyRRd9drSKwS7Lh+qkP+iZ145XfTMJ5R/DtkSqGwULZVYhKqMVCffA
 S+w3UELnvCB3ndHwFzAujI/FhoClS+rGlAEKjiTiDVB8n4rYlL2zfykQVCs+aPOZM7RfzR9xW789f
 2T+iMoRhhVx0BpFHACQ8Xp9Bb8zFNW2H84xELifnTA5zfTxyln6T1WOY/AbRGkF+uYvmuqaM71vLs
 tmRiw6zwiD3DEEAf8HIpOaauNOLahJpnJjKT9BTLBznAdo4AimDjNG/ZiDqJQSh6d+78yqCR0LPjm
 nEmcNB4/DpYKqBV86Fq5nQt4BRlbJZaUePNw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from penguin ([82.207.254.110]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N3Gga-1rl05211zW-010OG1; Mon, 25
 Sep 2023 09:38:58 +0200
Date: Mon, 25 Sep 2023 09:38:47 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org, Juan Quintela
 <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v6 09/10] migration/yank: Keep track of registered yank
 instances
Message-ID: <20230925093607.7f3ab989@penguin>
In-Reply-To: <ZQMfa38ulqQiRZ3d@x1n>
References: <20230911171320.24372-1-farosas@suse.de>
 <20230911171320.24372-10-farosas@suse.de> <ZQIX+KUgL5V6H/gj@x1n>
 <87jzstkaen.fsf@suse.de> <ZQJKQLNNZe772MUA@x1n>
 <87h6nwkhwl.fsf@suse.de> <ZQMfa38ulqQiRZ3d@x1n>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.GWoHE7Ov7Cg6N5BwI5lQUw";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:fsUBy0N1D4nQb5jVZIP3LkYxd3n8n63gNbrYqrwBT1hIGvtjwAm
 X5Q5tBl+bvHGjwf1QA3DKuPSgQIHAlgrKBSdqYmlUkhVJODb5sJi5IzV8EpDIywWO4109tR
 CeDBCSh+CHxjvu5O3Zxj8bp0R4IfW+ytOKhaYhA6khVC0ZYesj3d3R+XT2QU6MPAK0xpmf7
 EEhrsZ9nMjpH4lgY06a+w==
UI-OutboundReport: notjunk:1;M01:P0:KnNHOda/wKw=;kuzgq7GtxvZeelvf4Zmf0Vdun9v
 1uz0CRUjuSXlr9tfTAMLJBBH5bLkm0Ayhmh2aqT1gSmPVxsyFDLP5iMxAPHYFsm7rM995rCgW
 rrTh6F/QMPyCQKbutm4VrI5/apn4x9sCwtMnFY0sKYH0mk5nHDtrHspy2ukbI1SyJE4hhT4yV
 DneCjeAr8vbVWXXcAG6cdAHkkKZ+vXOdvVu6r0h0W16JOZU4Y0zsApRbXiKvSoZbPjKdZnN4d
 Blxou50tBpqCvNjdtrtb7qJ5e3l4qex5pVHZ9/j+K+++boz1k+Twa2nIG6j+WvPzyQfK32tql
 XTfPsxmNhakGlbCqZizdzvjml+lkeL9OUHE6Ys3oIH2UL6cSzlj3KzEPRN/tJ5wYa4vbDSxDK
 J94fwcZakTAXh3NXj0wbe2CPlTz11dZLi+Q355NIblXo8siQkbdbvFJ9s8rqU/cBmv25KsQ2H
 gj9VXElwoJj7clKYLi7Er4Z+DSPr7yvE1cLw/fyVgM2jbv1pSChFskS1lVQUn79D8H2KzjNps
 bIXoIaOoyKV3p12HQIezmrtCOpfFNjAKEf17dxq/QgR+mouej3ixdJu8qW2dkMVhLLmfpIpKc
 OMffPwtdVVKfcy+vT1yZ/DCnyS1QdgYsPuMdY9xRqXnWqgKd2pasPbNyyhqaBHJhLWydcHe63
 5e3D5PhEmCgb4THS9tTI1mFMD3cKb3cV+Of1oMFoge56UZE83PH6e6IzmL2N4pMxkVsRoE50a
 fLvBnh0Vnwp5GooBynsPogVErkocnG7+yKj/k7dtiUwAia/HkxAYhhBeD04sLoQj8OxFn9m7O
 elycqgqvxgtQmGJRthm8l12yntG71Y/YdLklV2W16sBvZMp9fHTLmp3Gp+tMyTTLpR/lGCpmq
 cPB2LNvF1x1++bw/77WysFDztnV13W7pZyqsfUAgBff+xrwMggthvKLOqOdcWPhlWQagM4TDP
 InQDYbQqW/iHvQOMpf1mRgmuw8I=
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--Sig_/.GWoHE7Ov7Cg6N5BwI5lQUw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Sep 2023 10:57:47 -0400
Peter Xu <peterx@redhat.com> wrote:

> On Thu, Sep 14, 2023 at 10:23:38AM -0300, Fabiano Rosas wrote:
> > Peter Xu <peterx@redhat.com> writes:
> >  =20
> > > On Wed, Sep 13, 2023 at 06:53:20PM -0300, Fabiano Rosas wrote: =20
> > >> Peter Xu <peterx@redhat.com> writes:
> > >>  =20
> > >> > On Mon, Sep 11, 2023 at 02:13:19PM -0300, Fabiano Rosas wrote: =20
> > >> >> The core yank code is strict about balanced registering and
> > >> >> unregistering of yank functions.
> > >> >>=20
> > >> >> This creates a difficulty because the migration code registers one
> > >> >> yank function per QIOChannel, but each QIOChannel can be referenc=
ed by
> > >> >> more than one QEMUFile. The yank function should not be removed u=
ntil
> > >> >> all QEMUFiles have been closed.
> > >> >>=20
> > >> >> Keep a reference count of how many QEMUFiles are using a QIOChann=
el
> > >> >> that has a yank function. Only unregister the yank function when =
all
> > >> >> QEMUFiles have been closed.
> > >> >>=20
> > >> >> This improves the current code by removing the need for the progr=
ammer
> > >> >> to know which QEMUFile is the last one to be cleaned up and fixes=
 the
> > >> >> theoretical issue of removing the yank function while another QEM=
UFile
> > >> >> could still be using the ioc and require a yank.
> > >> >>=20
> > >> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> > >> >> ---
> > >> >>  migration/yank_functions.c | 81 ++++++++++++++++++++++++++++++++=
++----
> > >> >>  migration/yank_functions.h |  8 ++++
> > >> >>  2 files changed, 81 insertions(+), 8 deletions(-) =20
> > >> >
> > >> > I worry this over-complicate things. =20
> > >>=20
> > >> It does. We ran out of simple options.
> > >>  =20
> > >> > If you prefer the cleaness that we operate always on qemufile leve=
l, can we
> > >> > just register each yank function per-qemufile? =20
> > >>=20
> > >> "just" hehe
> > >>=20
> > >> we could, but:
> > >>=20
> > >> i) the yank is a per-channel operation, so this is even more unintui=
tive; =20
> > >
> > > I mean we can provide something like:
> > >
> > > void migration_yank_qemufile(void *opaque)
> > > {
> > >     QEMUFile *file =3D opaque;
> > >     QIOChannel *ioc =3D file->ioc;
> > >
> > >     qio_channel_shutdown(ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
> > > }
> > >
> > > void migration_qemufile_register_yank(QEMUFile *file)
> > > {
> > >     if (migration_ioc_yank_supported(file->ioc)) {
> > >         yank_register_function(MIGRATION_YANK_INSTANCE,
> > >                                migration_yank_qemufile,
> > >                                file);
> > >     }
> > > } =20
> >=20
> > Sure, this is what I was thinking as well. IMO it will be yet another
> > operation that happens on the channel, but it performed via the
> > file. Just like qio_channel_close() at qemu_fclose(). Not the end of the
> > world, of course, I just find it error-prone.
> >  =20
> > >>=20
> > >> ii) multifd doesn't have a QEMUFile, so it will have to continue usi=
ng
> > >>     the ioc; =20
> > >
> > > We can keep using migration_ioc_[un]register_yank() for them if there=
's no
> > > qemufile attached.  As long as the function will all be registered un=
der
> > > MIGRATION_YANK_INSTANCE we should be fine having different yank func.
> > > =20
> >=20
> > ok
> >  =20
> > >>=20
> > >> iii) we'll have to add a yank to every new QEMUFile created during t=
he
> > >>      incoming migration (colo, rdma, etc), otherwise the incoming si=
de
> > >>      will be left using iocs while the src uses the QEMUFile; =20
> > >
> > > For RDMA, IIUC it'll simply be a noop as migration_ioc_yank_supported=
()
> > > will be a noop for it for either reg/unreg.
> > >
> > > Currently it seems we will also unreg the ioc even for RDMA (even tho=
ugh we
> > > don't reg for it).  But since unreg will be a noop it seems all fine =
even
> > > if not paired.. maybe we should still try to pair it, e.g. register a=
lso in
> > > rdma_start_outgoing_migration() for the rdma ioc so at least they're =
paired.
> > >
> > > I don't see why COLO is special here, though.  Maybe I missed somethi=
ng. =20
> >=20
> > For colo I was thinking we'd have to register the yank just to be sure
> > that all paths unregistering it have something to unregister.
> >=20
> > Maybe I should move the register into qemu_file_new_impl() with a
> > matching unregister at qemu_fclose(). =20
>=20
> Sounds good.  Or...
>=20
> >  =20
> > >>=20
> > >> iv) this is a functional change of the yank feature for which we hav=
e no
> > >>     tests. =20
> > >
> > > Having yank tested should be preferrable.  Lukas is in the loop, let'=
s see
> > > whether he has something. We can still smoke test it before a selftest
> > > being there.
> > >

Hi All,
Sorry for the late reply.

Yes, testing missing. I'll work on it.

> > > Taking one step back.. I doubt whether anyone is using yank for migra=
tion?
> > > Knowing that migration already have migrate-cancel (for precopy) and
> > > migrate-pause (for postcopy). =20
> >=20
> > Right, both already call qio_channel_shutdown().
> >  =20
> > > I never used it myself, and I don't think
> > > it's supported for RHEL.  How's that in suse's case? =20
> >=20
> > Never heard mention of it and I don't see it in our virtualization
> > documentation.
> >  =20
> > >
> > > If no one is using it, maybe we can even avoid registering migration =
to
> > > yank?
> > > =20
> >=20
> > Seems reasonable to me. =20
>=20
> ... let's wait for a few days from Lukas to see whether he as any more
> input, or I'd vote for dropping yank for migration as a whole. It caused
> mostly more crashes that I knew than benefits, so far..
>=20
> I also checked libvirt is not using yank.
>=20

The main user for yank is COLO. It can't be replaced by 'migrate_pause'
or 'migrate_cancel', because:

1) It needs to work while the main lock is taken by the migration
   thread, so it needs to be an OOB qmp command. There are places
   where the migration thread can hang on a socket while the main lock
   is taken. 'migrate_pause' is OOB, but not usable in the COLO case (it
   doesn't support postcopy).

2) In COLO, it needs to work both on outgoing and on incoming side, since
   both sides have a completely healthy and ready to takeover guest state.

I agree that the migration yank code was not well thought out :(.
I had the idea back then to create child class of the IOCs, e.g.
YankableQIOChannelSocket and YankableQIOChannelTLS. It's not
perfect, but then the lifetime of the yank functions is directly
coupled with the iochannel. Then the IOCs can be used just as usual in
the rest of the migration code.

Another problem area was to be that there was no clear point in
migration code where all channels are closed to unregister the yank
instance itself. That seems to be solved now?

> >  =20
> > >>=20
> > >> If that's all ok to you I'll go ahead and git it a try.
> > >>  =20
> > >> > I think qmp yank will simply fail the 2nd call on the qemufile if =
the
> > >> > iochannel is shared with the other one, but that's totally fine, I=
MHO.
> > >> >
> > >> > What do you think?
> > >> >
> > >> > In all cases, we should probably at least merge patch 1-8 if that =
can
> > >> > resolve the CI issue.  I think all of them are properly reviewed. =
=20
> > >>=20
> > >> I agree. Someone needs to queue this though since Juan has been busy=
. =20
> > >
> > > Yes, I'll see what I can do. =20
> >=20
> > Thanks. I could even send a pull request myself if it would make things
> > easier. Let me know. =20
>=20
> That's definitely an option.  But I want to make sure it's the same thing;
> I replied in Stefan's report.  We can continue the discussion there for t=
hat.
>=20


--Sig_/.GWoHE7Ov7Cg6N5BwI5lQUw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmUROQcACgkQNasLKJxd
slj1iA/8Ca1WkuI0kPLQNJPp6UPlWsf7jFyyTjb9gKBH47a7bb17nTOlt45fXhEi
P0Wwyajy/qj/we7j1amjmNRT3gJZExe8QpwrEHNbSZ8hnbb2dZXtIrGnu99/2Fhz
+c1gdTG+vptMgTN6XYJFAL6v+NW1ujF+fejdJh661V6Fvpy581jvMbEPVHCpc1md
/rdySVxCHR5iiq5YWtfzJ36fYd5PCKUfZRZZXXWluzpA1Bv8b37bQ/j9ZqANElzR
zJQzU7og34M+8BCb5bcdjdFuF0qkXAFTswNfyn2OeSj2H6VvADjWoo4eXWc8jEo3
hIcxbI1ER9EWk1D9wW6szOXiA/cawm9WNQmxi1xy19DZYcxjm1xSG/SUAWWoVRGh
r5V+bY5IaFknFQCYToYCztHxWBMky0jsHUOI3iNfEPJawKnBC+pcjdWYd6dmj7wI
m6qAWU/wbMzZm6Q+y08O34Dcrxje2H52juAQPyDVUxqubFeOKSpdOhDEkgGEVQRr
EW3O5DfhAJwJvzTYU80F58JF+Jc9kzVxURUkDyZUEQK/tRtDZTgJInrTc2t947eM
8gsHgOTpOO+AA6Vhp9WZDEbnbcFsGtngV58OCeWnPKYr29oHG9yoM/4F3M/RzMIw
7fwwUGRhKHACRXrXtF/vxl/EsA5We3bTmbzRtV6blhdJ3I7Ptsg=
=2eRk
-----END PGP SIGNATURE-----

--Sig_/.GWoHE7Ov7Cg6N5BwI5lQUw--

