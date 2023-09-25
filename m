Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE0C7ADB83
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 17:33:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkna6-0003ZK-8I; Mon, 25 Sep 2023 11:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qknZw-0003Wa-IB
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:32:57 -0400
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qknZu-0000kv-Am
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:32:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
 t=1695655968; x=1696260768; i=lukasstraub2@web.de;
 bh=by6o41Tb+1JM5cSnnYU5yueDTeUjc1MqQxZxadpJ1/U=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=dRXXccdCXvoNO31vvSfcuKo6Zje4/W2Ms1nRxxCoT/TP3caKMm7uPc3qsHVIy222aQidEbD8wDz
 rUMd7G9sJC8YgdjcJj+C9jmW73XB+O+Ao/qKKfGHza4/oQfzH2Z2FTe4EI4T2vNJg9s4yKYg4RHEm
 7vta1IFgpZ9c7FYvrn8pi8F268J8sXN++AYlLKaP4vXIFoo1eh2GyVrzYWIiBBIevX60seELWyzLt
 vH9yMxuTcltVQ2zvn9jALZJpikFdfJ/7CgHI68eZRwyllPuI55dp088w+HDLsVntiP3cmWwzl60JW
 xPmc/TQlN8VVaFiU7XPecyF9wQUUzrhI8kag==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from penguin ([82.207.254.110]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1McIgY-1rN9fY2pzA-00ce1L; Mon, 25
 Sep 2023 17:32:48 +0200
Date: Mon, 25 Sep 2023 17:32:37 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Juan Quintela
 <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>, "Daniel P.
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Subject: Re: [PATCH v6 09/10] migration/yank: Keep track of registered yank
 instances
Message-ID: <20230925173237.6dccdd35@penguin>
In-Reply-To: <87y1gu4f6d.fsf@suse.de>
References: <20230911171320.24372-1-farosas@suse.de>
 <20230911171320.24372-10-farosas@suse.de> <ZQIX+KUgL5V6H/gj@x1n>
 <87jzstkaen.fsf@suse.de> <ZQJKQLNNZe772MUA@x1n>
 <87h6nwkhwl.fsf@suse.de> <ZQMfa38ulqQiRZ3d@x1n>
 <20230925093607.7f3ab989@penguin> <87y1gu4f6d.fsf@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/E51gebMc8DTfOPAurp6W/xr";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:fCpCzzl4KQkv2urhFIeRJx950tPmz3ccHAcY+XK+qTOCBh9PrPU
 vukTA46cou8l9RpBlGPPCEliy4M5PmQAQqG3CdNWwiw0FB7M6fCmTY4w9mdVYW2ubKIiP2e
 huTv+/Xj9X3KtoOfUpWOvvvcoz079WS11atDZh1ba25t9GNgWdv7VL07WIjGFByUcRalKSu
 Umb3BtSM2GDrszSTRDjRg==
UI-OutboundReport: notjunk:1;M01:P0:8YB++kolmo0=;LJyvyMIwWH7qtAZ/suN2GCcse+z
 Yny2maPGHBaC4r4/nmfZryBSxo1EXF/pXbxOfwMdTkOgnQyXOf3ssSrcMfeRddyUSO6d64X4a
 0RZ2zDdnZk6OCb/fNjyCHgqDzTmJS6iyNnhhsqsoubLGMEKSFn0L5waLUI3Ibbm4X2PSygJ+c
 mE0uTsoWF4c0T0mUaeBWR4NhuITdrlBAzLpU/WBLqJqMs6VMY/zQYZ5nDgTDiJcnYrsMCibSd
 asd6vf6HJQSVOALVAUg6zf56vTzHDMJbHiwlZz/PzuvvNXgg4v5rpCl6MfbrMm7l0Y+zbw6ww
 nb112nUlAs0I5O/JFn1asBxy0eG49Q/hQqPHxwJ1VeHrIf9C7Wll2R9aTktLfDw6jSz1h5B1d
 AGpLNAVQB0PBuyBP3YgbHR6JphIgTS4mSBCarNvteHL5+LgGG8uFEySdCnT4r9oBngLL0q+36
 rsRzxZerKWlU198D2FDDyBguGx17eBIRccD2aYi/z25tknNYnYNGjmcz5fnnoXzMYxQOt72Lv
 ATUsHc6d+mDrCo0iY5DzQjjk2nKpMw2/z2hb0HyOqxsoUif9Q8AkslBuET41vytnVesMDPAXY
 Vo2xZOFJiUGr/o6Oou2Cs6V1/qK2lSG3PR729SsZ43RMMqV8q/Ne/VtElH3br8+HVo5CsTzsG
 +WbLWhmOTvpD0jB6WBt5oMkkrKQLwPO8++2LJg6s7TVom5vJ500IaU+v1eGtQjgJ7fXMhurC+
 aU3R2uRkOv8YxlsL2/7SWwBTIbRoAjZuv1/KYHUJ8uUf8WUCsLhPQ17xky8o9EuEpuYwSXKCZ
 EmotahATIkcHvPfHgNZrod82tKMcgmrF8+gBatzalRbRC8krctvCfxO3aHLlDT/7XXQ9dKdoW
 3vX919WlnYF+J55fTZKTMuRNe/5wLtbPQ0hfBYoiVpOREUj2yQQ7yq9qweoDzW0MDDV6Nb1gw
 xDwLWhbHTuJXOl7l3QgNjvORd1E=
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--Sig_/E51gebMc8DTfOPAurp6W/xr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 25 Sep 2023 09:20:58 -0300
Fabiano Rosas <farosas@suse.de> wrote:

> CC: Daniel for the QIOChannel discussion
>=20
> Lukas Straub <lukasstraub2@web.de> writes:
> > On Thu, 14 Sep 2023 10:57:47 -0400
> > Peter Xu <peterx@redhat.com> wrote:
> > =20
> >> On Thu, Sep 14, 2023 at 10:23:38AM -0300, Fabiano Rosas wrote: =20
> >> > Peter Xu <peterx@redhat.com> writes:
> >> >    =20
> >> > > On Wed, Sep 13, 2023 at 06:53:20PM -0300, Fabiano Rosas wrote:   =
=20
> >> > >> Peter Xu <peterx@redhat.com> writes:
> >> > >>    =20
> >> > >> > On Mon, Sep 11, 2023 at 02:13:19PM -0300, Fabiano Rosas wrote: =
  =20
> >> > >> >> The core yank code is strict about balanced registering and
> >> > >> >> unregistering of yank functions.
> >> > >> >>=20
> >> > >> >> This creates a difficulty because the migration code registers=
 one
> >> > >> >> yank function per QIOChannel, but each QIOChannel can be refer=
enced by
> >> > >> >> more than one QEMUFile. The yank function should not be remove=
d until
> >> > >> >> all QEMUFiles have been closed.
> >> > >> >>=20
> >> > >> >> Keep a reference count of how many QEMUFiles are using a QIOCh=
annel
> >> > >> >> that has a yank function. Only unregister the yank function wh=
en all
> >> > >> >> QEMUFiles have been closed.
> >> > >> >>=20
> >> > >> >> This improves the current code by removing the need for the pr=
ogrammer
> >> > >> >> to know which QEMUFile is the last one to be cleaned up and fi=
xes the
> >> > >> >> theoretical issue of removing the yank function while another =
QEMUFile
> >> > >> >> could still be using the ioc and require a yank.
> >> > >> >>=20
> >> > >> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> > >> >> ---
> >> > >> >>  migration/yank_functions.c | 81 +++++++++++++++++++++++++++++=
+++++----
> >> > >> >>  migration/yank_functions.h |  8 ++++
> >> > >> >>  2 files changed, 81 insertions(+), 8 deletions(-)   =20
> >> > >> >
> >> > >> > I worry this over-complicate things.   =20
> >> > >>=20
> >> > >> It does. We ran out of simple options.
> >> > >>    =20
> >> > >> > If you prefer the cleaness that we operate always on qemufile l=
evel, can we
> >> > >> > just register each yank function per-qemufile?   =20
> >> > >>=20
> >> > >> "just" hehe
> >> > >>=20
> >> > >> we could, but:
> >> > >>=20
> >> > >> i) the yank is a per-channel operation, so this is even more unin=
tuitive;   =20
> >> > >
> >> > > I mean we can provide something like:
> >> > >
> >> > > void migration_yank_qemufile(void *opaque)
> >> > > {
> >> > >     QEMUFile *file =3D opaque;
> >> > >     QIOChannel *ioc =3D file->ioc;
> >> > >
> >> > >     qio_channel_shutdown(ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
> >> > > }
> >> > >
> >> > > void migration_qemufile_register_yank(QEMUFile *file)
> >> > > {
> >> > >     if (migration_ioc_yank_supported(file->ioc)) {
> >> > >         yank_register_function(MIGRATION_YANK_INSTANCE,
> >> > >                                migration_yank_qemufile,
> >> > >                                file);
> >> > >     }
> >> > > }   =20
> >> >=20
> >> > Sure, this is what I was thinking as well. IMO it will be yet another
> >> > operation that happens on the channel, but it performed via the
> >> > file. Just like qio_channel_close() at qemu_fclose(). Not the end of=
 the
> >> > world, of course, I just find it error-prone.
> >> >    =20
> >> > >>=20
> >> > >> ii) multifd doesn't have a QEMUFile, so it will have to continue =
using
> >> > >>     the ioc;   =20
> >> > >
> >> > > We can keep using migration_ioc_[un]register_yank() for them if th=
ere's no
> >> > > qemufile attached.  As long as the function will all be registered=
 under
> >> > > MIGRATION_YANK_INSTANCE we should be fine having different yank fu=
nc.
> >> > >   =20
> >> >=20
> >> > ok
> >> >    =20
> >> > >>=20
> >> > >> iii) we'll have to add a yank to every new QEMUFile created durin=
g the
> >> > >>      incoming migration (colo, rdma, etc), otherwise the incoming=
 side
> >> > >>      will be left using iocs while the src uses the QEMUFile;   =
=20
> >> > >
> >> > > For RDMA, IIUC it'll simply be a noop as migration_ioc_yank_suppor=
ted()
> >> > > will be a noop for it for either reg/unreg.
> >> > >
> >> > > Currently it seems we will also unreg the ioc even for RDMA (even =
though we
> >> > > don't reg for it).  But since unreg will be a noop it seems all fi=
ne even
> >> > > if not paired.. maybe we should still try to pair it, e.g. registe=
r also in
> >> > > rdma_start_outgoing_migration() for the rdma ioc so at least they'=
re paired.
> >> > >
> >> > > I don't see why COLO is special here, though.  Maybe I missed some=
thing.   =20
> >> >=20
> >> > For colo I was thinking we'd have to register the yank just to be su=
re
> >> > that all paths unregistering it have something to unregister.
> >> >=20
> >> > Maybe I should move the register into qemu_file_new_impl() with a
> >> > matching unregister at qemu_fclose().   =20
> >>=20
> >> Sounds good.  Or...
> >>  =20
> >> >    =20
> >> > >>=20
> >> > >> iv) this is a functional change of the yank feature for which we =
have no
> >> > >>     tests.   =20
> >> > >
> >> > > Having yank tested should be preferrable.  Lukas is in the loop, l=
et's see
> >> > > whether he has something. We can still smoke test it before a self=
test
> >> > > being there.
> >> > > =20
> >
> > Hi All,
> > Sorry for the late reply.
> >
> > Yes, testing missing. I'll work on it.
> > =20
> >> > > Taking one step back.. I doubt whether anyone is using yank for mi=
gration?
> >> > > Knowing that migration already have migrate-cancel (for precopy) a=
nd
> >> > > migrate-pause (for postcopy).   =20
> >> >=20
> >> > Right, both already call qio_channel_shutdown().
> >> >    =20
> >> > > I never used it myself, and I don't think
> >> > > it's supported for RHEL.  How's that in suse's case?   =20
> >> >=20
> >> > Never heard mention of it and I don't see it in our virtualization
> >> > documentation.
> >> >    =20
> >> > >
> >> > > If no one is using it, maybe we can even avoid registering migrati=
on to
> >> > > yank?
> >> > >   =20
> >> >=20
> >> > Seems reasonable to me.   =20
> >>=20
> >> ... let's wait for a few days from Lukas to see whether he as any more
> >> input, or I'd vote for dropping yank for migration as a whole. It caus=
ed
> >> mostly more crashes that I knew than benefits, so far..
> >>=20
> >> I also checked libvirt is not using yank.
> >>  =20
> >
> > The main user for yank is COLO. It can't be replaced by 'migrate_pause'
> > or 'migrate_cancel', because:
> >
> > 1) It needs to work while the main lock is taken by the migration
> >    thread, so it needs to be an OOB qmp command. There are places
> >    where the migration thread can hang on a socket while the main lock
> >    is taken. 'migrate_pause' is OOB, but not usable in the COLO case (it
> >    doesn't support postcopy).
> >
> > 2) In COLO, it needs to work both on outgoing and on incoming side, sin=
ce
> >    both sides have a completely healthy and ready to takeover guest sta=
te.
> >
> > I agree that the migration yank code was not well thought out :(. =20
>=20
> I'd say the QIOChannel being referenced via multiple QEMUFiles throws a
> curve ball to the yank design.
>=20
> > I had the idea back then to create child class of the IOCs, e.g.
> > YankableQIOChannelSocket and YankableQIOChannelTLS. It's not
> > perfect, but then the lifetime of the yank functions is directly
> > coupled with the iochannel. Then the IOCs can be used just as usual in
> > the rest of the migration code. =20
>=20
> The yank really wants to be tied to the channel. We should do that.
>=20
> I'm just thinking whether a feature bit + setter would be simpler to
> implement. It wouldn't require changing any of the object creation code,
> just add a qio_channel_enable_yank() at the start of migration and let
> the channel take care of the rest.

I think Daniel was against adding external dependencies to QIO
(dependency on yank in this case). But now that I'm thinking about it:
@Daniel How about qio_channel_add_destroy_cb() or similar?

>=20
> > Another problem area was to be that there was no clear point in
> > migration code where all channels are closed to unregister the yank
> > instance itself. That seems to be solved now? =20
>=20
> I'm inclined to add reference counting all over instead of trying to
> squint at the code and figure out where these cleanups should
> go. Specially since we have these pause/recovery scenarios.
>=20
>
> That said, I haven't looked closely at the instance unregister, but I
> don't think this series changes anything that would help in that regard.


--Sig_/E51gebMc8DTfOPAurp6W/xr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmURqBUACgkQNasLKJxd
sliANBAArfM7RB/egNa9YSDPmBeQz6D+jHeGTf0lpWyWKgy1bpq1Qiqo2HcE7HPr
U3yW/grppSEN7efbFg21Z0nxQnNR4bBP87mlSWAeK7FgTpOzqw1r/BjgXNm/mBPA
i/3nfo8ok8L3wKi4IcyX6K8gorovgoILGTZ1kq50/LdFeZ0oTpSJGLNxF07+/XzX
/4rJkR3LWFPBm7iLWfayhNwFTO1FRv1T+JMlHOYOJau5javKGaLN0qwd9Qp53Gnu
hA4VEzHB0/3uS+Xv61MqFvMxN4wVxT/cHgGpO+/OMuT6yrNur6X9G955axedc0Vd
54NodzEm+rHHZ8WBY/kKOA2Jt5hYR2n1vtn3JtAOrjJaNLjKwpHXXEXR/uCjN08Z
R+heCHHOPYgelmk7CKwtFAi1D+GHcIsGjt4tswvZguRl98noVSViv2qVfxb6AfeO
2HIT3y8P1320zsCGCKNpcjQh7qtPlS94qcgSb5ntQsXtTs8ArWdbdqUsKhCF6CaH
rF6StK/tCFBgKqHsw68a9Eg6iGntMKiMaiYjUMq/f9+q3/bSvcCuuOQWG10Z13vc
Fr0T2GKPpXwx/2RlqM/XGTk1IgrW4WubCcyIxJkPnQ0ykygMbbX/0SDwpzsi4Xrj
rMr7rcP+quvbBVeSUr2RAaMsr/2zYZz5vOu81Z73y6V2HlqS8os=
=wNLs
-----END PGP SIGNATURE-----

--Sig_/E51gebMc8DTfOPAurp6W/xr--

