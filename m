Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8064C7EE188
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 14:29:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3cPx-0004Sk-5H; Thu, 16 Nov 2023 08:28:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1r3cPq-0004SF-ON
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 08:28:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1r3cPo-00011p-IB
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 08:28:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700141295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RMuaw7hfPiqBcCEflQdFQi37DmLG+g40OPEVaD8XuTo=;
 b=hdfkBKvGrpAec7AoILkL9bHt0QP9XEDDsC2Ivs9bP221EMnDx9HvPxKz6/Gt1LQcmK8P4T
 jCh86OFeThBjZsq7oXpaXa2IDeLz5LQ8I/hA3bxjekM58JexyaxUkRNe+oZrWZoh+Nb1t7
 LAvVAKdfm+vUQvRPhoSwG5m3r+F3fpk=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-99uJAqrmN0mkgHPIUgjB2g-1; Thu, 16 Nov 2023 08:28:14 -0500
X-MC-Unique: 99uJAqrmN0mkgHPIUgjB2g-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5b8d4a559ddso968625a12.1
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 05:28:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700141293; x=1700746093;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RMuaw7hfPiqBcCEflQdFQi37DmLG+g40OPEVaD8XuTo=;
 b=EKPIHqp/wy97LUp0UPX6yflNl4050J2WJnfEqrO4V54hNGdHpwP/c0rmClkykoG2ef
 vB93YjXdFh0uGaKDqBLytRT2Vqjk5dM6rgT2VAnXdxT/CxS9VKSIVcVxJVYHIGuuV8qe
 76PDWjG4ZDkjAH7bTkc4vEhRSPC/I+GrH0EOp9rRR8jEqnRpGpOKZ26FPfP/pRsEeoOT
 Kxut1HzcqFr06Rt5WZI2uulTbYiQAmBvz8hX95fCKRibw4jyNkKpkXX2PaReCBNxx1ib
 cQ3UJdxKD5Y796yTG/ICnDzVaLa9axRPuqqYxLEdf7PXede1rpI9lq91xq3CCVYTfS55
 mR+w==
X-Gm-Message-State: AOJu0YzbfM2MBJNS2QFhfPpH8E+5FFvbUuVn3aS1m3urbKTAhleEGxB0
 0ezuJJW1l7GaxuA0rgPsySavrVMP6BPOOmbCZaCuH7VrkBCL5qB7k91ma22KNuuw93+U1mf4g9Q
 kbfZdzkHwVGqEJts=
X-Received: by 2002:a05:6a20:daa3:b0:187:858b:8c06 with SMTP id
 iy35-20020a056a20daa300b00187858b8c06mr4999604pzb.16.1700141293347; 
 Thu, 16 Nov 2023 05:28:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyDdkknn1Py0eCtccZtyhBNH/mOrhAsqU7dFHMqMrY+fM42n3en6dKhjCrJJ39b+DI7rXnqQ==
X-Received: by 2002:a05:6a20:daa3:b0:187:858b:8c06 with SMTP id
 iy35-20020a056a20daa300b00187858b8c06mr4999582pzb.16.1700141293008; 
 Thu, 16 Nov 2023 05:28:13 -0800 (PST)
Received: from smtpclient.apple ([203.212.246.21])
 by smtp.gmail.com with ESMTPSA id
 j17-20020a170902c3d100b001bf846dd2d0sm9262639plj.13.2023.11.16.05.28.08
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 16 Nov 2023 05:28:12 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
Message-Id: <44B87DD4-B2FF-4061-97D6-631367D625B5@redhat.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_209E2658-427A-40C7-9055-4C082BB134BA"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH 1/3] tests/avocado: reverse_debugging drain console to
 prevent hang
Date: Thu, 16 Nov 2023 18:56:44 +0530
In-Reply-To: <20231116115354.228678-1-npiggin@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 =?utf-8?Q?=22Daniel_P_=2E_Berrang=C3=A9=22?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-ppc@nongnu.org, =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicholas Piggin <npiggin@gmail.com>
References: <20231116115354.228678-1-npiggin@gmail.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


--Apple-Mail=_209E2658-427A-40C7-9055-4C082BB134BA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 16-Nov-2023, at 5:23=E2=80=AFPM, Nicholas Piggin =
<npiggin@gmail.com> wrote:
>=20
> Like replay_linux.py, reverse_debugging.py starts the vm with console
> set but does not interact with it (e.g., with =
wait_for_console_pattern).
> In this situation, the console should have a drainer attached so the
> socket does not fill. replay_linux.py has a drainer, but it is missing
> from reverse_debugging.py.
>=20
> Per analysis in Link: this can cause the console socket/pipe to fill =
and
> QEMU get stuck in qemu_chr_write_buffer, leading to strange test case
> failures (ppc64 fails because it prints a lot to console in early =
bios).
> Attaching a drainer prevents this.
>=20
> Note, this commit does not fix bugs introduced by the commits =
referenced
> in the first two Fixes: tags, but together those commits conspire to
> irritate the problem and cause test case failure, which this commit
> fixes.
>=20
> Link: https://lore.kernel.org/qemu-devel/ZVT-bY9YOr69QTPX@redhat.com/
> Fixes: 1d4796cd0083 ("python/machine: use socketpair() for console =
connections")
> Fixes: 761a13b23946 ("tests/avocado: ppc64 reverse debugging tests for =
pseries and powernv")
> Fixes: be52eca30978 ("tests/acceptance: add reverse debugging test")
> Tested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com <mailto:anisinha@redhat.com> =
<mailto:anisinha@redhat.com>>

> ---
> tests/avocado/reverse_debugging.py | 5 +++++
> 1 file changed, 5 insertions(+)
>=20
> diff --git a/tests/avocado/reverse_debugging.py =
b/tests/avocado/reverse_debugging.py
> index fc47874eda..128d85bc0e 100644
> --- a/tests/avocado/reverse_debugging.py
> +++ b/tests/avocado/reverse_debugging.py
> @@ -12,6 +12,7 @@
>=20
> from avocado import skipIf
> from avocado_qemu import BUILD_DIR
> +from avocado.utils import datadrainer
> from avocado.utils import gdb
> from avocado.utils import process
> from avocado.utils.network.ports import find_free_port
> @@ -52,6 +53,10 @@ def run_vm(self, record, shift, args, replay_path, =
image_path, port):
>        if args:
>            vm.add_args(*args)
>        vm.launch()
> +        console_drainer =3D =
datadrainer.LineLogger(vm.console_socket.fileno(),
> +                                    =
logger=3Dself.log.getChild('console'),
> +                                    stop_check=3D(lambda : not =
vm.is_running()))
> +        console_drainer.start()
>        return vm
>=20
>    @staticmethod
> --=20
> 2.42.0

--Apple-Mail=_209E2658-427A-40C7-9055-4C082BB134BA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta charset=3D"UTF-8"><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br style=3D"caret-color: rgb(0, 0, 0); =
color: rgb(0, 0, 0); font-family: RedHatMono-Regular; font-size: 13px; =
font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); =
font-family: RedHatMono-Regular; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><blockquote =
type=3D"cite" style=3D"font-family: RedHatMono-Regular; font-size: 13px; =
font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;">On 16-Nov-2023, at 5:23=E2=80=AFPM, Nicholas Piggin =
&lt;npiggin@gmail.com&gt; wrote:<br><br>Like replay_linux.py, =
reverse_debugging.py starts the vm with console<br>set but does not =
interact with it (e.g., with wait_for_console_pattern).<br>In this =
situation, the console should have a drainer attached so the<br>socket =
does not fill. replay_linux.py has a drainer, but it is missing<br>from =
reverse_debugging.py.<br><br>Per analysis in Link: this can cause the =
console socket/pipe to fill and<br>QEMU get stuck in =
qemu_chr_write_buffer, leading to strange test case<br>failures (ppc64 =
fails because it prints a lot to console in early bios).<br>Attaching a =
drainer prevents this.<br><br>Note, this commit does not fix bugs =
introduced by the commits referenced<br>in the first two Fixes: tags, =
but together those commits conspire to<br>irritate the problem and cause =
test case failure, which this commit<br>fixes.<br><br>Link: =
https://lore.kernel.org/qemu-devel/ZVT-bY9YOr69QTPX@redhat.com/<br>Fixes: =
1d4796cd0083 ("python/machine: use socketpair() for console =
connections")<br>Fixes: 761a13b23946 ("tests/avocado: ppc64 reverse =
debugging tests for pseries and powernv")<br>Fixes: be52eca30978 =
("tests/acceptance: add reverse debugging test")<br>Tested-by: Thomas =
Huth &lt;thuth@redhat.com&gt;<br>Signed-off-by: Nicholas Piggin =
&lt;npiggin@gmail.com&gt;<br></blockquote><br style=3D"caret-color: =
rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: RedHatMono-Regular; =
font-size: 13px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); color: =
rgb(0, 0, 0); font-family: RedHatMono-Regular; font-size: 13px; =
font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; display: inline !important; float: none;">Reviewed-by: Ani Sinha =
&lt;</span><a href=3D"mailto:anisinha@redhat.com" style=3D"font-family: =
RedHatMono-Regular; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;">anisinha@redhat.com</a><span =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: =
RedHatMono-Regular; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; display: inline =
!important; float: none;"><span =
class=3D"Apple-converted-space">&nbsp;</span>&lt;</span><a =
href=3D"mailto:anisinha@redhat.com" style=3D"font-family: =
RedHatMono-Regular; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;">mailto:anisinha@redhat.com</a><span =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: =
RedHatMono-Regular; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; display: inline =
!important; float: none;">&gt;&gt;</span><br style=3D"caret-color: =
rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: RedHatMono-Regular; =
font-size: 13px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><br style=3D"caret-color: rgb(0, 0, 0); color: =
rgb(0, 0, 0); font-family: RedHatMono-Regular; font-size: 13px; =
font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><blockquote type=3D"cite" style=3D"font-family: =
RedHatMono-Regular; font-size: 13px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: =
none;">---<br>tests/avocado/reverse_debugging.py | 5 +++++<br>1 file =
changed, 5 insertions(+)<br><br>diff --git =
a/tests/avocado/reverse_debugging.py =
b/tests/avocado/reverse_debugging.py<br>index fc47874eda..128d85bc0e =
100644<br>--- a/tests/avocado/reverse_debugging.py<br>+++ =
b/tests/avocado/reverse_debugging.py<br>@@ -12,6 +12,7 @@<br><br>from =
avocado import skipIf<br>from avocado_qemu import BUILD_DIR<br>+from =
avocado.utils import datadrainer<br>from avocado.utils import =
gdb<br>from avocado.utils import process<br>from =
avocado.utils.network.ports import find_free_port<br>@@ -52,6 +53,10 @@ =
def run_vm(self, record, shift, args, replay_path, image_path, =
port):<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if =
args:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;vm.add_args(*args)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vm.launch=
()<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;console_drainer =3D =
datadrainer.LineLogger(vm.console_socket.fileno(),<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;logger=3Dsel=
f.log.getChild('console'),<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;stop_check=3D=
(lambda : not vm.is_running()))<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;console_drainer.start()<br>&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
vm<br><br>&nbsp;&nbsp;&nbsp;@staticmethod<br>--<span =
class=3D"Apple-converted-space">&nbsp;</span><br>2.42.0</blockquote></body=
></html>=

--Apple-Mail=_209E2658-427A-40C7-9055-4C082BB134BA--


