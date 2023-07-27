Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C087646A2
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 08:20:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOtvr-0006p7-Va; Thu, 27 Jul 2023 01:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qOtve-0006oS-AV
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 01:52:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qOtvb-0004By-1m
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 01:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690437165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0sIGvyYLYcuzVrfKMIb255xdFprcmL/FRkQDuJiwbdQ=;
 b=TaSgwQhEufFFYcX2ZEQm1oxi26R/ycv9SudK3maFRQqJss40u0xCNDFQsy0IcBA3I+KL15
 Lg6WdaoJDTT4BQyehJOVcDBayOcKMZva3WR1tQcT/PmevuBoVQ2LBhwP4R5Ol63SV2dy8S
 ZTNeWZqIO8AfwH+gBf9+APoyOOMGekw=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-nXQ64zPPMCG903pKPdnAdw-1; Thu, 27 Jul 2023 01:52:43 -0400
X-MC-Unique: nXQ64zPPMCG903pKPdnAdw-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-686b7576e2bso400871b3a.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 22:52:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690437162; x=1691041962;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0sIGvyYLYcuzVrfKMIb255xdFprcmL/FRkQDuJiwbdQ=;
 b=euH0DqZI0DtqyDXQG/4WOFP4i0clKUQk+nCZsgSOlCZ/L3NFWuWq/1KlsNh/V+IerY
 CL9t4bTfCONY6+5KuP7mYEFABkAiONQygy561vSc+9ooOmQ9uZD2mkhOyyowNzz7nJPa
 LmVgLrdWtoh/Q3ac0MxgR6JWAmKZY1cdwfC1Rx2AAJcehcnTIUzsiV4EPW8K8HBi73iB
 L5Wv8vlRdb8HooyEbINbIavgGZvwBxccwSY6ou1s6KUezJ6JYucEPp47y8lLA0HFSWSw
 o7r5pJTtvmJe7MKsxAY1OctFHIHtDhqYv29IT3C/RXqyajSJHnn6R6dXXfuGhpAS3Omd
 mjWA==
X-Gm-Message-State: ABy/qLbNBwDsVYyiuCHIz8wzAll34mGRDaI30Wzl6rd2ZhjFay3YKW50
 Tn32NsrGvZHkkXe1OJRexjAXS8P0yO0FmQworpV0Qd6Tf4DElshuKXs0FsP4bt6zv2XwqbsGs3F
 mp80W4I7hTumk9WA=
X-Received: by 2002:a05:6a00:24d2:b0:686:254c:9d47 with SMTP id
 d18-20020a056a0024d200b00686254c9d47mr4438878pfv.30.1690437162378; 
 Wed, 26 Jul 2023 22:52:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEeAqF9VP7lkK31kcwxIsozAxgyU9R3rVC6A9Cfs9ptrZ22fUlBfUtHq5IU8auE3EMd/3raPw==
X-Received: by 2002:a05:6a00:24d2:b0:686:254c:9d47 with SMTP id
 d18-20020a056a0024d200b00686254c9d47mr4438856pfv.30.1690437162007; 
 Wed, 26 Jul 2023 22:52:42 -0700 (PDT)
Received: from smtpclient.apple ([115.96.104.156])
 by smtp.gmail.com with ESMTPSA id
 g23-20020aa78757000000b006758ae3952bsm582124pfo.122.2023.07.26.22.52.37
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Jul 2023 22:52:41 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v2 4/6] python/machine: use socketpair() for console
 connections
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <CAFn=p-bdA5cVMmsUkE0os0CVT6XMXzWk2M3UcKb0DFQmi130Mg@mail.gmail.com>
Date: Thu, 27 Jul 2023 11:22:35 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>,
 =?utf-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Hanna Reitz <hreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 Kevin Wolf <kwolf@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Daniel Berrange <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4EE2965D-F72B-4002-99BF-732F5F9734C6@redhat.com>
References: <20230725180337.2937292-1-jsnow@redhat.com>
 <20230725180337.2937292-5-jsnow@redhat.com>
 <B867C4E8-24FC-4C4E-9FE8-2353CC21320C@redhat.com>
 <CAFn=p-bdA5cVMmsUkE0os0CVT6XMXzWk2M3UcKb0DFQmi130Mg@mail.gmail.com>
To: John Snow <jsnow@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
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



> On 26-Jul-2023, at 10:51 PM, John Snow <jsnow@redhat.com> wrote:
>=20
>=20
>=20
> On Wed, Jul 26, 2023, 6:50 AM Ani Sinha <anisinha@redhat.com> wrote:
>=20
>=20
> > On 25-Jul-2023, at 11:33 PM, John Snow <jsnow@redhat.com> wrote:
> >=20
> > Create a socketpair for the console output. This should help =
eliminate
> > race conditions around console text early in the boot process that =
might
> > otherwise have been dropped on the floor before being able to =
connect to
> > QEMU under "server,nowait".
> >=20
> > Signed-off-by: John Snow <jsnow@redhat.com>
>=20
> Thanks for doing this. I recall we spoke about this late last year in =
the context of fixing my bios-bits avocado test and adding a console =
output there.
>=20
> Yep! I think you need a few more changes to do what you wanted. IIRC, =
you also want to be able to drain the console log while waiting for the =
vm to terminate of its own accord, which I don't support yet.
>=20
> (If you use console socket's self draining mode, it should be possible =
to forego the early termination of the console socket and allow this =
behavior. Maybe I can work that in now...)

yeah we want to collect all the console logs while the VM is running =
until it self terminates. Maybe you can add a flag for this behavior to =
not early terminate the socket. I think we need to add mathods to keep =
reading the socket and write to a file until the socket is closed. Maybe =
QemuMachine needs to be enhanced.=20

>=20
> Anything else I'm forgetting ...?
>=20
> Except the concern below,
>=20
> Reviewed-by: Ani Sinha <anisinha@redhat.com>
>=20
> Thanks =F0=9F=98=8A=20
>=20
>=20
>=20
> > ---
> > python/qemu/machine/machine.py | 30 +++++++++++++++++++++++++++---
> > 1 file changed, 27 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/python/qemu/machine/machine.py =
b/python/qemu/machine/machine.py
> > index 26f0fb8a81..09f214c95c 100644
> > --- a/python/qemu/machine/machine.py
> > +++ b/python/qemu/machine/machine.py
> > @@ -159,6 +159,8 @@ def __init__(self,
> >=20
> >         self._name =3D name or f"{id(self):x}"
> >         self._sock_pair: Optional[Tuple[socket.socket, =
socket.socket]] =3D None
> > +        self._cons_sock_pair: Optional[
> > +            Tuple[socket.socket, socket.socket]] =3D None
> >         self._temp_dir: Optional[str] =3D None
> >         self._base_temp_dir =3D base_temp_dir
> >         self._sock_dir =3D sock_dir
> > @@ -315,8 +317,9 @@ def _base_args(self) -> List[str]:
> >         for _ in range(self._console_index):
> >             args.extend(['-serial', 'null'])
> >         if self._console_set:
> > -            chardev =3D =
('socket,id=3Dconsole,path=3D%s,server=3Don,wait=3Doff' %
> > -                       self._console_address)
> > +            assert self._cons_sock_pair is not None
> > +            fd =3D self._cons_sock_pair[0].fileno()
> > +            chardev =3D f"socket,id=3Dconsole,fd=3D{fd}"
> >             args.extend(['-chardev', chardev])
> >             if self._console_device_type is None:
> >                 args.extend(['-serial', 'chardev:console'])
> > @@ -351,6 +354,10 @@ def _pre_launch(self) -> None:
> >                 nickname=3Dself._name
> >             )
> >=20
> > +        if self._console_set:
> > +            self._cons_sock_pair =3D socket.socketpair()
> > +            os.set_inheritable(self._cons_sock_pair[0].fileno(), =
True)
> > +
> >         # NOTE: Make sure any opened resources are *definitely* =
freed in
> >         # _post_shutdown()!
> >         # pylint: disable=3Dconsider-using-with
> > @@ -368,6 +375,9 @@ def _pre_launch(self) -> None:
> >     def _post_launch(self) -> None:
> >         if self._sock_pair:
> >             self._sock_pair[0].close()
> > +        if self._cons_sock_pair:
> > +            self._cons_sock_pair[0].close()
> > +
> >         if self._qmp_connection:
> >             if self._sock_pair:
> >                 self._qmp.connect()
> > @@ -518,6 +528,11 @@ def _early_cleanup(self) -> None:
> >             self._console_socket.close()
> >             self._console_socket =3D None
> >=20
> > +        if self._cons_sock_pair:
> > +            self._cons_sock_pair[0].close()
> > +            self._cons_sock_pair[1].close()
> > +            self._cons_sock_pair =3D None
> > +
> >     def _hard_shutdown(self) -> None:
> >         """
> >         Perform early cleanup, kill the VM, and wait for it to =
terminate.
> > @@ -878,10 +893,19 @@ def console_socket(self) -> socket.socket:
> >         Returns a socket connected to the console
> >         """
> >         if self._console_socket is None:
> > +            if not self._console_set:
> > +                raise QEMUMachineError(
> > +                    "Attempt to access console socket with no =
connection")
> > +            assert self._cons_sock_pair is not None
> > +            # os.dup() is used here for sock_fd because otherwise =
we'd
> > +            # have two rich python socket objects that would each =
try to
> > +            # close the same underlying fd when either one gets =
garbage
> > +            # collected.
> >             self._console_socket =3D console_socket.ConsoleSocket(
> > -                self._console_address,
> > +                sock_fd=3Dos.dup(self._cons_sock_pair[1].fileno()),
> >                 file=3Dself._console_log_path,
> >                 drain=3Dself._drain_console)
> > +            self._cons_sock_pair[1].close()
>=20
> I am not 100% sure but should we save the new sock_fd here? Like
> self._cons_sock_pair[1] =3D sock_fd ;
>=20
> Then next time console_socket() is invoked, the correct fd will be =
duped.
>=20
> It should be cached to self._console_socket, so it should return the =
same instance every time, no second call to os.dup().

yeah I missed your patch 3. All good now.

>=20
> self._console_socket takes ownership of the duplicated fd and we =
retain ownership of _cons_sock_pair[1] which we then close right after.
>=20
> All three sockets are closed and None'd if applicable during =
_early_cleanup().
>=20
>=20
> >         return self._console_socket
> >=20
> >     @property
> > --=20
> > 2.41.0
> >=20


