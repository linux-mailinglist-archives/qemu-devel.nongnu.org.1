Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C45218038E6
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 16:35:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAAy9-0002oN-FI; Mon, 04 Dec 2023 10:34:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rAAy6-0002oB-Qr
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 10:34:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rAAy5-00080p-3J
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 10:34:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701704084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GYliOjviVhfU5cTROqcQGw0+CVoLJHCWzI4cm9odr1Q=;
 b=VVwPsupHKQt7QU4KFShpu9yeLgU61co/WWD8RYT3HJYxzQmb+Mn+Z7X35m9XhGJBlJqKnt
 rZH3HKfxG2MwAUdm8RZ+jJ28rG5wgx+TJIwIEMTC5RblvafRA3qiCZFb11LmIHZyaT8ioc
 OelyJ4Xaldr6V1lyypTywk5r5gAM4HQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-IhzX-SwCNdqDrmUT3z6REQ-1; Mon,
 04 Dec 2023 10:34:41 -0500
X-MC-Unique: IhzX-SwCNdqDrmUT3z6REQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E9C929AA3AF;
 Mon,  4 Dec 2023 15:34:40 +0000 (UTC)
Received: from localhost (unknown [10.39.192.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C980B10F44;
 Mon,  4 Dec 2023 15:34:39 +0000 (UTC)
Date: Mon, 4 Dec 2023 10:34:38 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Shu-Chun Weng <scw@google.com>, Helge Deller <deller@gmx.de>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Jonah Petri <jonah@petri.us>,
 Edoardo Spadolini <edoardo.spadolini@gmail.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 2/2] linux-user: Fix openat() emulation to not modify atime
Message-ID: <20231204153438.GG1492005@fedora>
References: <20231201032140.2470599-1-scw@google.com>
 <20231201032140.2470599-3-scw@google.com>
 <63d6f19a-ec9b-4397-bf90-95e89a618838@linaro.org>
 <CAF3nBxjGBtGnKr3m9soohGDPB9z+C7SkJt00FQOucYQNQUqCxw@mail.gmail.com>
 <4f149724-37f6-4e7f-95ef-61e3d4f0c3f8@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Bf1WksV+gpTtNjvH"
Content-Disposition: inline
In-Reply-To: <4f149724-37f6-4e7f-95ef-61e3d4f0c3f8@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--Bf1WksV+gpTtNjvH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2023 at 02:39:24PM +0100, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Laurent, Helge, Richard,
>=20
> On 1/12/23 19:51, Shu-Chun Weng wrote:
> > On Fri, Dec 1, 2023 at 4:42=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <phi=
lmd@linaro.org
> > <mailto:philmd@linaro.org>> wrote:
> >=20
> >     Hi Shu-Chun,
> >=20
> >     On 1/12/23 04:21, Shu-Chun Weng wrote:
> >      > Commit b8002058 strengthened openat()'s /proc detection by calli=
ng
> >      > realpath(3) on the given path, which allows various paths and
> >     symlinks
> >      > that points to the /proc file system to be intercepted correctly.
> >      >
> >      > Using realpath(3), though, has a side effect that it reads the
> >     symlinks
> >      > along the way, and thus changes their atime. The results in the
> >      > following code snippet already get ~now instead of the real atim=
e:
> >      >
> >      >=C2=A0 =C2=A0 int fd =3D open("/path/to/a/symlink", O_PATH | O_NO=
FOLLOW);
> >      >=C2=A0 =C2=A0 struct stat st;
> >      >=C2=A0 =C2=A0 fstat(fd, st);
> >      >=C2=A0 =C2=A0 return st.st_atime;
> >      >
> >      > This change opens a path that doesn't appear to be part of /proc
> >      > directly and checks the destination of /proc/self/fd/n to
> >     determine if
> >      > it actually refers to a file in /proc.
> >      >
> >      > Neither this nor the existing code works with symlinks or
> >     indirect paths
> >      > (e.g.=C2=A0 /tmp/../proc/self/exe) that points to /proc/self/exe
> >     because it
> >      > is itself a symlink, and both realpath(3) and /proc/self/fd/n wi=
ll
> >      > resolve into the location of QEMU.
> >=20
> >     Does this fix any of the following issues?
> >     https://gitlab.com/qemu-project/qemu/-/issues/829
> >     <https://gitlab.com/qemu-project/qemu/-/issues/829>
> >=20
> >=20
> > Not this one -- this is purely in the logic of util/path.c, which we do
> > see and carry an internal patch. It's quite a behavior change so we
> > never upstreamed it.
> >=20
> >     https://gitlab.com/qemu-project/qemu/-/issues/927
> >     <https://gitlab.com/qemu-project/qemu/-/issues/927>
> >=20
> >=20
> > No, either. This patch only touches the path handling, not how files are
> > opened.
> >=20
> >     https://gitlab.com/qemu-project/qemu/-/issues/2004
> >     <https://gitlab.com/qemu-project/qemu/-/issues/2004>
> >=20
> >=20
> > Yes! Though I don't have a toolchain for HPPA or any of the
> > architectures intercepting /proc/cpuinfo handy, I hacked the condition
> > and confirmed that on 7.1 and 8.2, test.c as attached in the bug prints
> > out the host cpuinfo while with this patch, it prints out the content
> > generated by `open_cpuinfo()`.
> >=20
> >=20
> >=20
> >      > Signed-off-by: Shu-Chun Weng <scw@google.com <mailto:scw@google.=
com>>
> >=20
> >=20
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2004
> > <https://gitlab.com/qemu-project/qemu/-/issues/2004>
>=20
> Do we need to merge this for 8.2?

Please assign release blocker issues to the 8.2 milestone so that are
tracked:
https://gitlab.com/qemu-project/qemu/-/milestones/10

Thanks,
Stefan

>=20
> >=20
> >      > ---
> >      >=C2=A0 =C2=A0linux-user/syscall.c | 42
> >     +++++++++++++++++++++++++++++++++---------
> >      >=C2=A0 =C2=A01 file changed, 33 insertions(+), 9 deletions(-)
> >=20
> >=20
> > On Fri, Dec 1, 2023 at 9:09=E2=80=AFAM Helge Deller <deller@gmx.de
> > <mailto:deller@gmx.de>> wrote:
> >=20
> >     On 12/1/23 04:21, Shu-Chun Weng wrote:
> >      > Commit b8002058 strengthened openat()'s /proc detection by calli=
ng
> >      > realpath(3) on the given path, which allows various paths and
> >     symlinks
> >      > that points to the /proc file system to be intercepted correctly.
> >      >
> >      > Using realpath(3), though, has a side effect that it reads the
> >     symlinks
> >      > along the way, and thus changes their atime.
> >=20
> >     Ah, ok. I didn't thought of that side effect when I came up with the
> >     patch.
> >     Does the updated atimes trigger some real case issue ?
> >=20
> >=20
> > We have an internal library shimming the underlying filesystem that uses
> > the `open(O_PATH|O_NOFOLLOW)`+`fstat()` pattern for all file stats.
> > Checking symlink atime is in one of the unittests, though I don't know
> > if production ever uses it.
> >=20
> >=20
> >     Helge
> >=20
>=20

--Bf1WksV+gpTtNjvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVt8Y4ACgkQnKSrs4Gr
c8iJlAf8D8AqorW2YVdXLzZGwqDfom9hynbcYMM9PMGuCYh6JplyuZ3pgKKO8mkc
Nrl/XGvkP1bfBWkApOHHJFiPy2VloGuhgvimy8EtK/IINw/RrbCCpNqaKCQBGQl+
0tGPWClSceSD6F2VJgprZOl0p9+C+Gq4/pZezdxt/Wt8QnhlfxY0V0bjKBbamtFd
BRy0N6YlDIOxVK/1vJnxUorBItlY+uV/A5OTm/JYO70lXiszVo64C9fyxvB6NBGN
j5+qC0dlWIKF64B7/wqIhj9JyF0s4vC/ehCKRj2quJyOB8hGUI+pEa0HYgYsSRSF
Oj2h+w8q2JEwblsdg8lenYz/XbbKXg==
=TOSj
-----END PGP SIGNATURE-----

--Bf1WksV+gpTtNjvH--


