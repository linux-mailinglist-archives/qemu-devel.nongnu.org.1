Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B5A8009EE
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 12:28:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r91g3-0002yo-UR; Fri, 01 Dec 2023 06:27:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r91g1-0002yG-J1; Fri, 01 Dec 2023 06:27:21 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r91fz-0001nb-Ic; Fri, 01 Dec 2023 06:27:21 -0500
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3b844e3e817so235757b6e.0; 
 Fri, 01 Dec 2023 03:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701430037; x=1702034837; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=N7G4F+/3DYTV2xUhvsGBYPnyztxOU0n9MgMzRa6wU2s=;
 b=LBjJDYg/cKTqAolYdY+T5um7Fg1SPNRufJiO+oDwD//0TOvlv9tIY7q+vldYGZ+SxP
 8LzG2qlD6frnFL1ALANFou/em7ImEkd646+Qyqqwi+E9BQsigxwlaVRmuLG6SR7E3e99
 tYlAOfsF/QPhLbLQlCzN2zvrGTkyQwU0e/DVl7d1+mkJ8PkegT3W0UwvtuKXoic6zrKK
 jILta5jKRt6RyaG4o3/hGmKZ9SSPEiTE0dnnMGyE98ABNgelVh4juWMDoDoNGZCvWJD4
 BitYq229r5Ih9MxWlFapWZ5USG8QgcjM0tsOW8ipCxvLwkiQo5HjIy5GK+sz1CIXlXTq
 Zg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701430037; x=1702034837;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N7G4F+/3DYTV2xUhvsGBYPnyztxOU0n9MgMzRa6wU2s=;
 b=pwZvQc9EJ/kepAoPIGW5wDAAh5R2cL5VgUTrR7HIICyYweofkrAnTgKgZoEMENZvlb
 sTDN4tXmy/JdFx/MCCd72ETFEpqHTMeSR6AXP+trDEh7ELHKcXQpnzAh4/mdHvmZus9s
 DVbb7aa+pnu8es4ZMoZN+QN8Wftivqh02hTS9BFlOg0sSAS3Rx7hDfw4Eolr+DDxl2VC
 0i6SmRFGRH+3UaA6soYpEfznz8YeBBw+pdEtcPwxTn+ed2pd7TX1OV/AtFib9aUbaRLh
 5LLm2PykcKcGguwOH8QgkMudMjii5dzmnP7MLD1pjgdJK9AEsaEYMec3p38PpU08QM0p
 XpuQ==
X-Gm-Message-State: AOJu0YwQdbOOSRYzfLDepTipz+XcxZqINyOOf2nAYH+MqRP7A8o3xkq6
 BqFLeo/+GzM9Eudx8Kxo4GruvBueh2cXhdhf5dk=
X-Google-Smtp-Source: AGHT+IFp3fTMYRgCAcNM5+dZH0jaMsO2IqgcFPnSMega3ELhBtT5pHeWWfce4HWh35rjZ2F1kv1Ft0XbVS6DIfyZREY=
X-Received: by 2002:a05:6870:240a:b0:1fa:c88e:19fc with SMTP id
 n10-20020a056870240a00b001fac88e19fcmr4566807oap.20.1701430035498; Fri, 01
 Dec 2023 03:27:15 -0800 (PST)
MIME-Version: 1.0
References: <20231201093633.2551497-1-alex.bennee@linaro.org>
 <20231201093633.2551497-4-alex.bennee@linaro.org>
In-Reply-To: <20231201093633.2551497-4-alex.bennee@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 1 Dec 2023 06:27:04 -0500
Message-ID: <CAJSP0QXSm9nLqixMmgOCn72MQPUBUCHVOLu456FTSDnKSJFq5A@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] tests/avocado: drop
 BootLinuxConsole.test_mips_malta_cpio test
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Farman <farman@linux.ibm.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, 
 Beraldo Leal <bleal@redhat.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, 
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Thomas Huth <thuth@redhat.com>, 
 qemu-arm <qemu-arm@nongnu.org>, Radoslaw Biernacki <rad@semihalf.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Eric Auger <eric.auger@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, 
 Cleber Rosa <crosa@redhat.com>, Joel Stanley <joel@jms.id.au>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e04b62060b710c86"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=stefanha@gmail.com; helo=mail-oi1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000e04b62060b710c86
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023, 04:38 Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:

> The assets are no longer archived by Debian so we can't run this on
> CI. While some people may still have the test in their cache we do
> have more recent images from tuxrun so this isn't a great loss.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  tests/avocado/boot_linux_console.py | 22 ----------------------
>  1 file changed, 22 deletions(-)
>

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>


> diff --git a/tests/avocado/boot_linux_console.py
> b/tests/avocado/boot_linux_console.py
> index 231b4f68e5..5d978f6dd0 100644
> --- a/tests/avocado/boot_linux_console.py
> +++ b/tests/avocado/boot_linux_console.py
> @@ -116,28 +116,6 @@ def test_x86_64_pc(self):
>          console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
>          self.wait_for_console_pattern(console_pattern)
>
> -    def test_mips_malta(self):
> -        """
> -        :avocado: tags=3Darch:mips
> -        :avocado: tags=3Dmachine:malta
> -        :avocado: tags=3Dendian:big
> -        """
> -        deb_url =3D ('http://snapshot.debian.org/archive/debian/'
> -                   '20130217T032700Z/pool/main/l/linux-2.6/'
> -                   'linux-image-2.6.32-5-4kc-malta_2.6.32-48_mips.deb')
> -        deb_hash =3D 'a8cfc28ad8f45f54811fc6cf74fc43ffcfe0ba04'
> -        deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
> -        kernel_path =3D self.extract_from_deb(deb_path,
> -
> '/boot/vmlinux-2.6.32-5-4kc-malta')
> -
> -        self.vm.set_console()
> -        kernel_command_line =3D self.KERNEL_COMMON_COMMAND_LINE +
> 'console=3DttyS0'
> -        self.vm.add_args('-kernel', kernel_path,
> -                         '-append', kernel_command_line)
> -        self.vm.launch()
> -        console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
> -        self.wait_for_console_pattern(console_pattern)
> -
>      def test_mips64el_malta(self):
>          """
>          This test requires the ar tool to extract "data.tar.gz" from
> --
> 2.39.2
>
>
>

--000000000000e04b62060b710c86
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Fri, Dec 1, 2023, 04:38 Alex Benn=C3=A9e &lt;<a hre=
f=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex">The assets are no longer archived by=
 Debian so we can&#39;t run this on<br>
CI. While some people may still have the test in their cache we do<br>
have more recent images from tuxrun so this isn&#39;t a great loss.<br>
<br>
Signed-off-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.or=
g" target=3D"_blank" rel=3D"noreferrer">alex.bennee@linaro.org</a>&gt;<br>
Cc: Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com" target=3D"_b=
lank" rel=3D"noreferrer">stefanha@redhat.com</a>&gt;<br>
Cc: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org" ta=
rget=3D"_blank" rel=3D"noreferrer">philmd@linaro.org</a>&gt;<br>
---<br>
=C2=A0tests/avocado/boot_linux_console.py | 22 ----------------------<br>
=C2=A01 file changed, 22 deletions(-)<br></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Acked-by: Stefan Hajnoczi &lt;<a href=
=3D"mailto:stefanha@redhat.com">stefanha@redhat.com</a>&gt;</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
<br>
diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux=
_console.py<br>
index 231b4f68e5..5d978f6dd0 100644<br>
--- a/tests/avocado/boot_linux_console.py<br>
+++ b/tests/avocado/boot_linux_console.py<br>
@@ -116,28 +116,6 @@ def test_x86_64_pc(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0console_pattern =3D &#39;Kernel command l=
ine: %s&#39; % kernel_command_line<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.wait_for_console_pattern(console_pat=
tern)<br>
<br>
-=C2=A0 =C2=A0 def test_mips_malta(self):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Darch:mips<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dmachine:malta<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dendian:big<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_url =3D (&#39;<a href=3D"http://snapshot.d=
ebian.org/archive/debian/" rel=3D"noreferrer noreferrer" target=3D"_blank">=
http://snapshot.debian.org/archive/debian/</a>&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;=
20130217T032700Z/pool/main/l/linux-2.6/&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;=
linux-image-2.6.32-5-4kc-malta_2.6.32-48_mips.deb&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_hash =3D &#39;a8cfc28ad8f45f54811fc6cf74fc=
43ffcfe0ba04&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_path =3D self.fetch_asset(deb_url, asset_h=
ash=3Ddeb_hash)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_path =3D self.extract_from_deb(deb_path=
,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &#39;/boot/vmlinux-2.6.32-5-4kc-malta&#39;)<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.set_console()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_command_line =3D self.KERNEL_COMMON_COM=
MAND_LINE + &#39;console=3DttyS0&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.add_args(&#39;-kernel&#39;, kernel_pat=
h,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;-append&#39;, kernel_command_line)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.launch()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 console_pattern =3D &#39;Kernel command line: =
%s&#39; % kernel_command_line<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.wait_for_console_pattern(console_pattern)=
<br>
-<br>
=C2=A0 =C2=A0 =C2=A0def test_mips64el_malta(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This test requires the ar tool to extract=
 &quot;data.tar.gz&quot; from<br>
-- <br>
2.39.2<br>
<br>
<br>
</blockquote></div></div></div>

--000000000000e04b62060b710c86--

