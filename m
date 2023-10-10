Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC4E7C4306
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 23:57:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqKi5-0000J7-Nb; Tue, 10 Oct 2023 17:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qqKi3-0000IE-US
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 17:56:11 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qqKhz-0005u4-Up
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 17:56:11 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-53d9b94731aso1835321a12.1
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 14:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696974964; x=1697579764;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XOhxlHVN0GFxDxpII+OlTWSOWrMH6Dkjj0A3W7m53nQ=;
 b=EOLOHiA06ET/Py41wvOs5zLA2tfCFQPuR/u2JxFCDQL9axAQRRoceMf1R2onYUPwjn
 g8Ov5vZxlPmymZBZoRqWkLjzRRMPAquXtA7nKQKwsX8umX/KXeLWUEuz+k9bfc6C4Yoq
 6PNlazTIWcU0JtiuXsN01ysBcmBjyjS2pZtEizBLwsOg9STMKkAhl+ZAnRHtReZIEEYZ
 QefUTC9wZe3ZTEX/LpF6Yp9yuX5v3RlKU7dxt5VQveFXcYu58Cds7eMoJHVaq/u+Hl6Y
 f+kAqd8cvfiNii53MO9LJB7OYqsKx0qG9LWZ0bANdFzStwBPxjyUaNsrm8pEfG0Ox0t7
 c7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696974964; x=1697579764;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XOhxlHVN0GFxDxpII+OlTWSOWrMH6Dkjj0A3W7m53nQ=;
 b=b+LYynrbAti95fA4wnTw2yCQnARVRx2f1zve5LqR9EYxKkf8Qr+5Ot0XgfeHSQvWby
 tz3vYiAzGc+NxLsu2NkoZibmrq2ykHrCDiwUxDXo05XfgW5H/wYXY3ukYVMuGA59Aywl
 SmvnrRAbZKNb/nisBmp7N4uh3Fd8MWnA2oRGhZVK2I9Wv2rRfSOecdYf2MwLZ76F2uhS
 cceCgj7I0WYysyJceNEFuh+fWUUzp7qTXIfOWGQtLzRzNlcuC48YQ3wrNmpPX1qiMzN1
 EKVy/+cUcoJ9HmVLWaondNsd+Y2TKcNFz4SNnsLz4ESoQ5l1EOnhW4Wd+i+nuGoDN4UV
 iv1A==
X-Gm-Message-State: AOJu0YyVqYBED//txEnQP1I+6SbkTHHyZYxk42FGknEQ+MIXDcQ2F/Qx
 RqJy8fWPD+uzO3P1/Xplfa2aS5Yofy2XFZ6TQ31jAw==
X-Google-Smtp-Source: AGHT+IF+7lFdnLOjnbwndlJ4aw4w0F7nVDHTZ20MVeKbb99npChXX7GUMSKbsZbnC4jjHjglOzPIkLClarr1w1hMx3M=
X-Received: by 2002:a17:906:23e9:b0:9b2:c583:cd71 with SMTP id
 j9-20020a17090623e900b009b2c583cd71mr18596870ejg.50.1696974964498; Tue, 10
 Oct 2023 14:56:04 -0700 (PDT)
MIME-Version: 1.0
References: <20231010075238.95646-1-npiggin@gmail.com>
 <20231010075238.95646-7-npiggin@gmail.com>
In-Reply-To: <20231010075238.95646-7-npiggin@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 10 Oct 2023 15:55:52 -0600
Message-ID: <CANCZdfqNJ97EgAax=P7pzny8zcULfiLEVJighecm5=DgLtRv8g@mail.gmail.com>
Subject: Re: [RFC PATCH 06/11] tests/avocado: Add FreeBSD distro boot tests
 for ppc
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-ppc@nongnu.org, Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000f3b872060763c527"
Received-SPF: none client-ip=2a00:1450:4864:20::52a;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

--000000000000f3b872060763c527
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 10, 2023 at 1:53=E2=80=AFAM Nicholas Piggin <npiggin@gmail.com>=
 wrote:

> FreeBSD project provides qcow2 images that work well for testing QEMU.
> Add pseries tests for HPT and Radix, KVM and TCG.
>
> Other architectures could be added so this does not get a ppc_ prefix
> but is instead named similarly to boot_linux.
>
> Cc: Warner Losh <imp@bsdimp.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>
> CC'ing Warner to check if it's okay for us to use these images and
> any comments or suggestions. avocado tests have many Linux boots so we'd
> do much better to expand test coverage by adding some other systems.
>

I like this.... I'm a little worried at the exact hash encoded in it, but
since there's a checksum
to match, it's OK I guess. It will give this code a shelf-life of months,
IIRC our retention policy.

Other than that, I think this is good. Not familiar enough with Avocado to
understand
skipping for gitlab CI, but given the extreme crunch on minutes, I think
that's OK.

Other than one nit below which is fine if it is intentionally left behind
(or removed):

Reviewed-by: Warner Losh <imp@bsdimp.com>

Please don't hesitate to reach out to me if this is failing. I'll act as a
backstop to get
it to the right people.

Warner


> ---
>  tests/avocado/boot_freebsd.py | 109 ++++++++++++++++++++++++++++++++++
>  1 file changed, 109 insertions(+)
>  create mode 100644 tests/avocado/boot_freebsd.py
>
> diff --git a/tests/avocado/boot_freebsd.py b/tests/avocado/boot_freebsd.p=
y
> new file mode 100644
> index 0000000000..9a499a28ad
> --- /dev/null
> +++ b/tests/avocado/boot_freebsd.py
> @@ -0,0 +1,109 @@
> +# Functional tests that boot FreeBSD in various configurations
> +#
> +# Copyright (c) 2023 IBM Corporation
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later. See the COPYING file in the top-level directory.
> +
> +import os
> +
> +from avocado import skipUnless
> +from avocado import skipIf
> +from avocado_qemu import QemuSystemTest
> +from avocado_qemu import wait_for_console_pattern
> +from avocado_qemu import exec_command
> +from avocado.utils import archive
> +from avocado.utils import process
> +from avocado.utils.path import find_command
> +
> +class BootFreeBSDPPC64(QemuSystemTest):
> +    """
> +    :avocado: tags=3Darch:ppc64
> +    """
> +
> +    timeout =3D 360
> +
> +    def run_pseries_test(self, force_HPT=3DFalse):
> +        # We need zstd for all the tuxrun tests
> +        # See https://github.com/avocado-framework/avocado/issues/5609
> +        zstd =3D find_command('zstd', False)
> +        if zstd is False:
> +            self.cancel('Could not find "zstd", which is required to '
> +                        'decompress rootfs')
> +        self.zstd =3D zstd
> +
> +        drive_url =3D ('
> https://artifact.ci.freebsd.org/snapshot/15.0-CURRENT/a2440348eed75bb7682=
579af0905b652747fd016/powerpc/powerpc64le/disk.qcow2.zst
> ')
> +        drive_hash =3D '8ab11a05ccab3d44215fd4667a70454ed10a203f'
> +        drive_path_zstd =3D self.fetch_asset(drive_url,
> asset_hash=3Ddrive_hash)
> +        drive_path =3D os.path.join(self.workdir, 'disk.qcow2')
> +        # archive.zstd_uncompress(drive_path_zstd, drive_path)
>

Why is this commented out? It looks like a leftover maybe?


> +
> +        cmd =3D f"{self.zstd} -d {drive_path_zstd} -o {drive_path}"
> +        process.run(cmd)
> +
> +        drive =3D f"file=3D{drive_path},format=3Dqcow2,if=3Dvirtio"
> +
> +        self.vm.set_console()
> +        if force_HPT:
> +            self.vm.add_args('-m', '4g')
> +        else:
> +            self.vm.add_args('-m', '1g')
> +        self.vm.add_args('-smp', '4')
> +        self.vm.add_args('-drive', drive)
> +        self.vm.add_args('-net', 'nic,model=3Dvirtio')
> +        self.vm.launch()
> +
> +        wait_for_console_pattern(self, 'Hit [Enter] to boot immediately,
> or any other key for command prompt.')
> +        if force_HPT:
> +            exec_command(self, 'x')
> +            wait_for_console_pattern(self, 'OK')
> +            exec_command(self, 'set radix_mmu=3D0')
> +            exec_command(self, 'boot')
> +            wait_for_console_pattern(self, 'cas: selected hash MMU',
> 'panic:')
> +        else:
> +            exec_command(self, '')
> +            wait_for_console_pattern(self, 'cas: selected radix MMU')
> +
> +        wait_for_console_pattern(self, 'FreeBSD 15.0-CURRENT #0 a244034:
> Mon Sep 25 02:05:22 UTC 2023', 'panic:')
> +        wait_for_console_pattern(self, 'FreeBSD/SMP: Multiprocessor
> System Detected: 4 CPUs')
> +        wait_for_console_pattern(self, 'FreeBSD/powerpc (Amnesiac)
> (ttyu0)', 'panic:')
> +
> +    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
> +    def test_pseries_tcg(self):
> +        """
> +        :avocado: tags=3Darch:ppc64
> +        :avocado: tags=3Dmachine:pseries
> +        :avocado: tags=3Daccel:tcg
> +        """
> +        self.require_accelerator("tcg")
> +        self.run_pseries_test()
> +
> +    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
> +    def test_pseries_hpt_tcg(self):
> +        """
> +        :avocado: tags=3Darch:ppc64
> +        :avocado: tags=3Dmachine:pseries
> +        :avocado: tags=3Daccel:tcg
> +        """
> +        self.require_accelerator("tcg")
> +        self.run_pseries_test(force_HPT=3DTrue)
> +
> +    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
> +    def test_pseries_kvm(self):
> +        """
> +        :avocado: tags=3Darch:ppc64
> +        :avocado: tags=3Dmachine:pseries
> +        :avocado: tags=3Daccel:kvm
> +        """
> +        self.require_accelerator("kvm")
> +        self.run_pseries_test()
> +
> +    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
> +    def test_pseries_hpt_kvm(self):
> +        """
> +        :avocado: tags=3Darch:ppc64
> +        :avocado: tags=3Dmachine:pseries
> +        :avocado: tags=3Daccel:kvm
> +        """
> +        self.require_accelerator("kvm")
> +        self.run_pseries_test(force_HPT=3DTrue)
> --
> 2.42.0
>
>

--000000000000f3b872060763c527
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 10, 2023 at 1:53=E2=80=AF=
AM Nicholas Piggin &lt;<a href=3D"mailto:npiggin@gmail.com">npiggin@gmail.c=
om</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">FreeBSD project provides qcow2 images that work well for testing QEMU.<br=
>
Add pseries tests for HPT and Radix, KVM and TCG.<br>
<br>
Other architectures could be added so this does not get a ppc_ prefix<br>
but is instead named similarly to boot_linux.<br>
<br>
Cc: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" target=3D"_blank">imp=
@bsdimp.com</a>&gt;<br>
Signed-off-by: Nicholas Piggin &lt;<a href=3D"mailto:npiggin@gmail.com" tar=
get=3D"_blank">npiggin@gmail.com</a>&gt;<br>
<br>
CC&#39;ing Warner to check if it&#39;s okay for us to use these images and<=
br>
any comments or suggestions. avocado tests have many Linux boots so we&#39;=
d<br>
do much better to expand test coverage by adding some other systems.<br></b=
lockquote><div><br></div><div>I like this.... I&#39;m a little worried at t=
he exact hash encoded in it, but since there&#39;s a checksum</div><div>to =
match, it&#39;s OK I guess. It will give this code a shelf-life of months, =
IIRC our retention policy.</div><div><br></div><div>Other than that, I thin=
k this is good. Not familiar enough=C2=A0with Avocado to understand</div><d=
iv>skipping for gitlab CI, but given the extreme crunch on minutes, I think=
 that&#39;s OK.</div><div><br></div><div>Other than one nit below which is =
fine if it is intentionally left behind (or removed):</div><div><br></div><=
div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdi=
mp.com</a>&gt;</div><div><br></div><div>Please don&#39;t hesitate to reach =
out to me if this is failing. I&#39;ll act as a backstop to get</div><div>i=
t to the right people.</div><div><br></div><div>Warner</div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0tests/avocado/boot_freebsd.py | 109 +++++++++++++++++++++++++++++++++=
+<br>
=C2=A01 file changed, 109 insertions(+)<br>
=C2=A0create mode 100644 tests/avocado/boot_freebsd.py<br>
<br>
diff --git a/tests/avocado/boot_freebsd.py b/tests/avocado/boot_freebsd.py<=
br>
new file mode 100644<br>
index 0000000000..9a499a28ad<br>
--- /dev/null<br>
+++ b/tests/avocado/boot_freebsd.py<br>
@@ -0,0 +1,109 @@<br>
+# Functional tests that boot FreeBSD in various configurations<br>
+#<br>
+# Copyright (c) 2023 IBM Corporation<br>
+#<br>
+# This work is licensed under the terms of the GNU GPL, version 2 or<br>
+# later. See the COPYING file in the top-level directory.<br>
+<br>
+import os<br>
+<br>
+from avocado import skipUnless<br>
+from avocado import skipIf<br>
+from avocado_qemu import QemuSystemTest<br>
+from avocado_qemu import wait_for_console_pattern<br>
+from avocado_qemu import exec_command<br>
+from avocado.utils import archive<br>
+from avocado.utils import process<br>
+from avocado.utils.path import find_command<br>
+<br>
+class BootFreeBSDPPC64(QemuSystemTest):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 :avocado: tags=3Darch:ppc64<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 timeout =3D 360<br>
+<br>
+=C2=A0 =C2=A0 def run_pseries_test(self, force_HPT=3DFalse):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # We need zstd for all the tuxrun tests<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # See <a href=3D"https://github.com/avocado-fr=
amework/avocado/issues/5609" rel=3D"noreferrer" target=3D"_blank">https://g=
ithub.com/avocado-framework/avocado/issues/5609</a><br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 zstd =3D find_command(&#39;zstd&#39;, False)<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if zstd is False:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.cancel(&#39;Could not find =
&quot;zstd&quot;, which is required to &#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;decompress rootfs&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.zstd =3D zstd<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 drive_url =3D (&#39;<a href=3D"https://artifac=
t.ci.freebsd.org/snapshot/15.0-CURRENT/a2440348eed75bb7682579af0905b652747f=
d016/powerpc/powerpc64le/disk.qcow2.zst" rel=3D"noreferrer" target=3D"_blan=
k">https://artifact.ci.freebsd.org/snapshot/15.0-CURRENT/a2440348eed75bb768=
2579af0905b652747fd016/powerpc/powerpc64le/disk.qcow2.zst</a>&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 drive_hash =3D &#39;8ab11a05ccab3d44215fd4667a=
70454ed10a203f&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 drive_path_zstd =3D self.fetch_asset(drive_url=
, asset_hash=3Ddrive_hash)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 drive_path =3D os.path.join(self.workdir, &#39=
;disk.qcow2&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # archive.zstd_uncompress(drive_path_zstd, dri=
ve_path)<br></blockquote><div><br></div><div>Why is this commented out? It =
looks like a leftover maybe?</div><div>=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd =3D f&quot;{self.zstd} -d {drive_path_zstd=
} -o {drive_path}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 process.run(cmd)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 drive =3D f&quot;file=3D{drive_path},format=3D=
qcow2,if=3Dvirtio&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.set_console()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if force_HPT:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.add_args(&#39;-m&#39;, &=
#39;4g&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.add_args(&#39;-m&#39;, &=
#39;1g&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.add_args(&#39;-smp&#39;, &#39;4&#39;)<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.add_args(&#39;-drive&#39;, drive)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.add_args(&#39;-net&#39;, &#39;nic,mode=
l=3Dvirtio&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.launch()<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 wait_for_console_pattern(self, &#39;Hit [Enter=
] to boot immediately, or any other key for command prompt.&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if force_HPT:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command(self, &#39;x&#39;)<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wait_for_console_pattern(self, &=
#39;OK&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command(self, &#39;set radi=
x_mmu=3D0&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command(self, &#39;boot&#39=
;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wait_for_console_pattern(self, &=
#39;cas: selected hash MMU&#39;, &#39;panic:&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command(self, &#39;&#39;)<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wait_for_console_pattern(self, &=
#39;cas: selected radix MMU&#39;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 wait_for_console_pattern(self, &#39;FreeBSD 15=
.0-CURRENT #0 a244034: Mon Sep 25 02:05:22 UTC 2023&#39;, &#39;panic:&#39;)=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 wait_for_console_pattern(self, &#39;FreeBSD/SM=
P: Multiprocessor System Detected: 4 CPUs&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 wait_for_console_pattern(self, &#39;FreeBSD/po=
werpc (Amnesiac) (ttyu0)&#39;, &#39;panic:&#39;)<br>
+<br>
+=C2=A0 =C2=A0 @skipIf(os.getenv(&#39;GITLAB_CI&#39;), &#39;Running on GitL=
ab&#39;)<br>
+=C2=A0 =C2=A0 def test_pseries_tcg(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Darch:ppc64<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dmachine:pseries<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Daccel:tcg<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.require_accelerator(&quot;tcg&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.run_pseries_test()<br>
+<br>
+=C2=A0 =C2=A0 @skipIf(os.getenv(&#39;GITLAB_CI&#39;), &#39;Running on GitL=
ab&#39;)<br>
+=C2=A0 =C2=A0 def test_pseries_hpt_tcg(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Darch:ppc64<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dmachine:pseries<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Daccel:tcg<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.require_accelerator(&quot;tcg&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.run_pseries_test(force_HPT=3DTrue)<br>
+<br>
+=C2=A0 =C2=A0 @skipIf(os.getenv(&#39;GITLAB_CI&#39;), &#39;Running on GitL=
ab&#39;)<br>
+=C2=A0 =C2=A0 def test_pseries_kvm(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Darch:ppc64<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dmachine:pseries<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Daccel:kvm<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.require_accelerator(&quot;kvm&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.run_pseries_test()<br>
+<br>
+=C2=A0 =C2=A0 @skipIf(os.getenv(&#39;GITLAB_CI&#39;), &#39;Running on GitL=
ab&#39;)<br>
+=C2=A0 =C2=A0 def test_pseries_hpt_kvm(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Darch:ppc64<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dmachine:pseries<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Daccel:kvm<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.require_accelerator(&quot;kvm&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.run_pseries_test(force_HPT=3DTrue)<br>
-- <br>
2.42.0<br>
<br>
</blockquote></div></div>

--000000000000f3b872060763c527--

