Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6C175B146
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 16:31:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMUfb-0005MQ-5j; Thu, 20 Jul 2023 10:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qMUfY-0005Kh-HS
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 10:30:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qMUfT-00080a-45
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 10:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689863410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W1DUMjcH4iPhgcd3XPHureoB6Dwjl8fuvA5ymm1z3EM=;
 b=D2f8uHOiu8vrvQjxSFHCJEMdN+m6Ezy/7Ya9czMOjxJxSTtuW5QpZUa7VYqDZr/6zdttPg
 iZIGgF6it3rilYEjOv6rpHBUko8f9KlRNCdofpG93TeG1hMmtq481TlHpHAo0Gl9dZQUdX
 aZ4qv6SUYppJyEVCYfFP7mnNy2AvGn8=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-3e93lM6AMX-fLc_v04HH0g-1; Thu, 20 Jul 2023 10:30:08 -0400
X-MC-Unique: 3e93lM6AMX-fLc_v04HH0g-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-53ba38cf091so1181933a12.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 07:30:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689863407; x=1690468207;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W1DUMjcH4iPhgcd3XPHureoB6Dwjl8fuvA5ymm1z3EM=;
 b=CnWIDtNI29rklP5T2Plc+MotTJnQqHgywkfLVIcvScWYAjC0Cawd+e2gzonyvKptUe
 GSFF1SJzzxeZWQP9MsEzP09FAsqnaZdSBD++GChSHHQDXzAue3rbmJTYR77DCavmeKh9
 h0a9rSw8eVGmGugU8Bi9w/72br7gFu88FFL9POdU26lLnPpd3BDfn3o12kI8IF4bAqVk
 GqKqW7N7at5IBiAp9jIuBC5H9fzR3Mf2cto6x8p2XXzfMYOXL+fgxor+s1Cm2rioiBUd
 PKsW+c6ZAiJ2HjBSU2qCmwjM5WGFluYGQAKHzBQlB+qegio02i4JPPMSy3bIl21TgrR3
 m4vg==
X-Gm-Message-State: ABy/qLZ0hoSdtVm/FkQithNSGT4EqdEOy5UkxNY9mYmwPfMDS1oLCSxp
 /t5WmIbikyfPdzZTPanAdjpdMwiyqbcE98Ww890R9u/+83YyYYsFIXoX9467YsmC/seG35iD67j
 mdGLLjBr5OszCZLjNvD6+J8FiTgrUL9A=
X-Received: by 2002:a17:90a:5987:b0:263:7d8:4a with SMTP id
 l7-20020a17090a598700b0026307d8004amr7749268pji.18.1689863407656; 
 Thu, 20 Jul 2023 07:30:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF+M63ksj36BWbbg/629RO26xGQon2bbl7j/5LQo3wNVzyR24u82SksHpP6RvWbCMnnYWsnji/pLHsIlmED440=
X-Received: by 2002:a17:90a:5987:b0:263:7d8:4a with SMTP id
 l7-20020a17090a598700b0026307d8004amr7749218pji.18.1689863407134; Thu, 20 Jul
 2023 07:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230720130448.921356-1-jsnow@redhat.com>
 <20230720130448.921356-5-jsnow@redhat.com>
 <ZLk/BmwoxLhJ26Sj@redhat.com>
In-Reply-To: <ZLk/BmwoxLhJ26Sj@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Thu, 20 Jul 2023 10:29:56 -0400
Message-ID: <CAFn=p-YEq9JA2goRVBRmHBsaVctQR22F3xtrCGk8DnSGrR+sZA@mail.gmail.com>
Subject: Re: [PATCH 4/4] python/machine: remove unused console socket
 configuration arguments
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Beraldo Leal <bleal@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
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

On Thu, Jul 20, 2023 at 10:05=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> On Thu, Jul 20, 2023 at 09:04:48AM -0400, John Snow wrote:
> > By using a socketpair for the console, we don't need the sock_dir
> > argument for the base class anymore, remove it.
> >
> > The qtest subclass still uses the argument for the qtest socket for now=
.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  python/qemu/machine/machine.py             | 18 ------------------
> >  python/qemu/machine/qtest.py               |  6 +++---
> >  tests/qemu-iotests/tests/copy-before-write |  3 +--
> >  3 files changed, 4 insertions(+), 23 deletions(-)
>
> A couple of callers to be updated to remove 'sock_dir=3D':
>
> $ git grep 'sock_dir=3D' tests
> tests/avocado/acpi-bits.py:                         sock_dir=3Dsock_dir, =
qmp_timer=3Dqmp_timer)
> tests/avocado/avocado_qemu/__init__.py:                         sock_dir=
=3Dself._sd.name, log_dir=3Dself.logdir)
> tests/qemu-iotests/iotests.py:                         sock_dir=3Dsock_di=
r, qmp_timer=3Dtimer)
> tests/qemu-iotests/tests/copy-before-write:                              =
sock_dir=3Diotests.sock_dir)
>
> presume the avocado_qemu/__init__.py one is what caused the
> failure Peter reported.
>

Yep, missed a spot, sorry :( I tested avocado after patch 3 but not here.

While I'm at it, though, I am testing the same treatment for the qtest
extension and just removing sock_dir from *everything*, since we don't
need that workaround anymore if we aren't creating named sockets.

...And if I get rid of *that*, I can get rid of some other temp
directory management stuff too.

> >
> > diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machi=
ne.py
> > index ef9b2dc02e..350aa8bb26 100644
> > --- a/python/qemu/machine/machine.py
> > +++ b/python/qemu/machine/machine.py
> > @@ -127,7 +127,6 @@ def __init__(self,
> >                   name: Optional[str] =3D None,
> >                   base_temp_dir: str =3D "/var/tmp",
> >                   monitor_address: Optional[SocketAddrT] =3D None,
> > -                 sock_dir: Optional[str] =3D None,
> >                   drain_console: bool =3D False,
> >                   console_log: Optional[str] =3D None,
> >                   log_dir: Optional[str] =3D None,
> > @@ -141,7 +140,6 @@ def __init__(self,
> >          @param name: prefix for socket and log file names (default: qe=
mu-PID)
> >          @param base_temp_dir: default location where temp files are cr=
eated
> >          @param monitor_address: address for QMP monitor
> > -        @param sock_dir: where to create socket (defaults to base_temp=
_dir)
> >          @param drain_console: (optional) True to drain console socket =
to buffer
> >          @param console_log: (optional) path to console log file
> >          @param log_dir: where to create and keep log files
> > @@ -163,7 +161,6 @@ def __init__(self,
> >              Tuple[socket.socket, socket.socket]] =3D None
> >          self._temp_dir: Optional[str] =3D None
> >          self._base_temp_dir =3D base_temp_dir
> > -        self._sock_dir =3D sock_dir
> >          self._log_dir =3D log_dir
> >
> >          self._monitor_address =3D monitor_address
> > @@ -189,9 +186,6 @@ def __init__(self,
> >          self._console_index =3D 0
> >          self._console_set =3D False
> >          self._console_device_type: Optional[str] =3D None
> > -        self._console_address =3D os.path.join(
> > -            self.sock_dir, f"{self._name}.con"
> > -        )
> >          self._console_socket: Optional[socket.socket] =3D None
> >          self._remove_files: List[str] =3D []
> >          self._user_killed =3D False
> > @@ -334,9 +328,6 @@ def args(self) -> List[str]:
> >          return self._args
> >
> >      def _pre_launch(self) -> None:
> > -        if self._console_set:
> > -            self._remove_files.append(self._console_address)
> > -
> >          if self._qmp_set:
> >              if self._monitor_address is None:
> >                  self._sock_pair =3D socket.socketpair()
> > @@ -900,15 +891,6 @@ def temp_dir(self) -> str:
> >                                                dir=3Dself._base_temp_di=
r)
> >          return self._temp_dir
> >
> > -    @property
> > -    def sock_dir(self) -> str:
> > -        """
> > -        Returns the directory used for sockfiles by this machine.
> > -        """
> > -        if self._sock_dir:
> > -            return self._sock_dir
> > -        return self.temp_dir
> > -
> >      @property
> >      def log_dir(self) -> str:
> >          """
> > diff --git a/python/qemu/machine/qtest.py b/python/qemu/machine/qtest.p=
y
> > index 1c46138bd0..22f8045ef6 100644
> > --- a/python/qemu/machine/qtest.py
> > +++ b/python/qemu/machine/qtest.py
> > @@ -115,8 +115,8 @@ def __init__(self,
> >                   wrapper: Sequence[str] =3D (),
> >                   name: Optional[str] =3D None,
> >                   base_temp_dir: str =3D "/var/tmp",
> > -                 sock_dir: Optional[str] =3D None,
> > -                 qmp_timer: Optional[float] =3D None):
> > +                 qmp_timer: Optional[float] =3D None,
> > +                 sock_dir: Optional[str] =3D None):
> >          # pylint: disable=3Dtoo-many-arguments
> >
> >          if name is None:
> > @@ -125,7 +125,7 @@ def __init__(self,
> >              sock_dir =3D base_temp_dir
> >          super().__init__(binary, args, wrapper=3Dwrapper, name=3Dname,
> >                           base_temp_dir=3Dbase_temp_dir,
> > -                         sock_dir=3Dsock_dir, qmp_timer=3Dqmp_timer)
> > +                         qmp_timer=3Dqmp_timer)
> >          self._qtest: Optional[QEMUQtestProtocol] =3D None
> >          self._qtest_path =3D os.path.join(sock_dir, name + "-qtest.soc=
k")
> >
> > diff --git a/tests/qemu-iotests/tests/copy-before-write b/tests/qemu-io=
tests/tests/copy-before-write
> > index 2ffe092b31..d3987db942 100755
> > --- a/tests/qemu-iotests/tests/copy-before-write
> > +++ b/tests/qemu-iotests/tests/copy-before-write
> > @@ -44,8 +44,7 @@ class TestCbwError(iotests.QMPTestCase):
> >
> >          opts =3D ['-nodefaults', '-display', 'none', '-machine', 'none=
']
> >          self.vm =3D QEMUMachine(iotests.qemu_prog, opts,
> > -                              base_temp_dir=3Diotests.test_dir,
> > -                              sock_dir=3Diotests.sock_dir)
> > +                              base_temp_dir=3Diotests.test_dir)
> >          self.vm.launch()
> >
> >      def do_cbw_error(self, on_cbw_error):
> > --
> > 2.41.0
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>


