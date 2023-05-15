Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC0D703E3A
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 22:10:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyeWF-0008Qp-IH; Mon, 15 May 2023 16:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1pyeWC-0008Q8-JF; Mon, 15 May 2023 16:10:04 -0400
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1pyeW9-0008Mu-RM; Mon, 15 May 2023 16:10:04 -0400
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-b9246a5f3feso20384057276.1; 
 Mon, 15 May 2023 13:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684181400; x=1686773400;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YjO8HuNGrmegC80ej0RLgMzbWkEossW3n/MQYA7fKvA=;
 b=Ej9vb4tLpEbM/8Tey+ql871BtvTwjD3UD4clKunklxRLxrEBkLjT0QJLngm/4+A5pO
 Rv7o0ih0bggCSuTsyYDjNY2f5Dfhn1hAc17MKAiSDvk0tPqj08kA444VLgX5aJKU/nf5
 cRy0ZPptrIt7dn8imtDKAzRQl9pRfPaXW/YEwBN/1iOGyltv773f9cS192p008FTXRX7
 sV+4XAE9E7C1YkDpXSlw3hLRRlEl+ta6r+T3rlqUv0uHqGAf6SfXRiolgY+6PlSNizyP
 PZUNjR5FYtyHSyjjyEvgv8ssZnY2G0I3a6vq9D3bRdlDeQ9ixUXJoiDXPjydIEHK5GHx
 U6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684181400; x=1686773400;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YjO8HuNGrmegC80ej0RLgMzbWkEossW3n/MQYA7fKvA=;
 b=UasfTcHg/xASNMRDHs9qqvrs56+p86G9A6jJgo9765vUyaPVhjeRE4+vXPQuMpe0eg
 vrb9PxE3S2Vi8PpoFE2+8l7hoiNz0Nc4TEGAjS9ot5TyXRUJ7q9FGpo0Kjg5kk1K5oZo
 nWmFqzsKRKhW+op8HsYgIZxhN/V9soJ1xY28/dgE8LUYTpzhv6rB6td85t96zLgmeGMA
 76dnkQf04uVOO/1M6kCCgS1DLEFiHSfDcPyfnoSyoM87ElmUMfwArp0XSsvrIzkQOSxS
 KOGkBfDY1odBcxub1VMMkxaGr+uI832lPUPiH0oPzsCbXYJ7OzS1CwfxexB6/hiZ9XoO
 r/Og==
X-Gm-Message-State: AC+VfDxXT3LbXt2MG1zYizEKYEAGJLUp88JT6LoezBaDMmnlmjB4ILeY
 Q70vaNx3GhOGuVUCXJFx3vQCpCv4pakX9wNmyWQ=
X-Google-Smtp-Source: ACHHUZ6L7EibrieikxiIDtenM3xTIzJ9vBbYxkC3sp65BrRFaeKLchSH6LZKElQuMmd7R6P7z2TfAq6YlB/zTas8V9E=
X-Received: by 2002:a81:5b54:0:b0:559:f52b:7c5f with SMTP id
 p81-20020a815b54000000b00559f52b7c5fmr33363881ywb.17.1684181398901; Mon, 15
 May 2023 13:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230510103004.30015-1-qianfanguijin@163.com>
 <20230510103004.30015-11-qianfanguijin@163.com>
In-Reply-To: <20230510103004.30015-11-qianfanguijin@163.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Mon, 15 May 2023 22:09:48 +0200
Message-ID: <CAPan3WqJF981jRpqSnqdHzYQZ+hidtUhLArke1aYjCvhLm1F5A@mail.gmail.com>
Subject: Re: [PATCH v4 10/11] tests: avocado: boot_linux_console: Add test
 case for bpim2u
To: qianfanguijin@163.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Beniamino Galvani <b.galvani@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000004d8d505fbc10a76"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=nieklinnenbank@gmail.com; helo=mail-yb1-xb2f.google.com
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

--00000000000004d8d505fbc10a76
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 10, 2023 at 12:30=E2=80=AFPM <qianfanguijin@163.com> wrote:

> From: qianfan Zhao <qianfanguijin@163.com>
>
> Add test case for booting from initrd and sd card.
>

To make the commit message more complete and reflect the full contents,
maybe also mention the gmac and openwrt test?

Tests look fine to me, and are running OK on my machine:

$ AVOCADO_ALLOW_LARGE_STORAGE=3Dyes ./build/tests/venv/bin/avocado
--show=3Dapp,console run -t machine:bpim2u tests/avocado/boot_linux_console=
.py
...
RESULTS    : PASS 4 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 |
CANCEL 0
JOB TIME   : 26.46 s

So for me feel free to add:

Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>

Regards,
Niek


>
> Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
> ---
>  tests/avocado/boot_linux_console.py | 176 ++++++++++++++++++++++++++++
>  1 file changed, 176 insertions(+)
>
> diff --git a/tests/avocado/boot_linux_console.py
> b/tests/avocado/boot_linux_console.py
> index c0675809e6..6ed660611f 100644
> --- a/tests/avocado/boot_linux_console.py
> +++ b/tests/avocado/boot_linux_console.py
> @@ -769,6 +769,182 @@ def test_arm_quanta_gsj_initrd(self):
>          self.wait_for_console_pattern(
>                  'Give root password for system maintenance')
>
> +    def test_arm_bpim2u(self):
> +        """
> +        :avocado: tags=3Darch:arm
> +        :avocado: tags=3Dmachine:bpim2u
> +        :avocado: tags=3Daccel:tcg
> +        """
> +        deb_url =3D ('
> https://apt.armbian.com/pool/main/l/linux-5.10.16-sunxi/'
> +                   'linux-image-current-sunxi_21.02.2_armhf.deb')
> +        deb_hash =3D '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
> +        deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
> +        kernel_path =3D self.extract_from_deb(deb_path,
> +                                            '/boot/vmlinuz-5.10.16-sunxi=
')
> +        dtb_path =3D ('/usr/lib/linux-image-current-sunxi/'
> +                    'sun8i-r40-bananapi-m2-ultra.dtb')
> +        dtb_path =3D self.extract_from_deb(deb_path, dtb_path)
> +
> +        self.vm.set_console()
> +        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
> +                               'console=3DttyS0,115200n8 '
> +                               'earlycon=3Duart,mmio32,0x1c28000')
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-dtb', dtb_path,
> +                         '-append', kernel_command_line)
> +        self.vm.launch()
> +        console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
> +        self.wait_for_console_pattern(console_pattern)
> +
> +    def test_arm_bpim2u_initrd(self):
> +        """
> +        :avocado: tags=3Darch:arm
> +        :avocado: tags=3Daccel:tcg
> +        :avocado: tags=3Dmachine:bpim2u
> +        """
> +        deb_url =3D ('
> https://apt.armbian.com/pool/main/l/linux-5.10.16-sunxi/'
> +                   'linux-image-current-sunxi_21.02.2_armhf.deb')
> +        deb_hash =3D '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
> +        deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
> +        kernel_path =3D self.extract_from_deb(deb_path,
> +                                            '/boot/vmlinuz-5.10.16-sunxi=
')
> +        dtb_path =3D ('/usr/lib/linux-image-current-sunxi/'
> +                    'sun8i-r40-bananapi-m2-ultra.dtb')
> +        dtb_path =3D self.extract_from_deb(deb_path, dtb_path)
> +        initrd_url =3D ('https://github.com/groeck/linux-build-test/raw/=
'
> +                      '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
> +                      'arm/rootfs-armv7a.cpio.gz')
> +        initrd_hash =3D '604b2e45cdf35045846b8bbfbf2129b1891bdc9c'
> +        initrd_path_gz =3D self.fetch_asset(initrd_url,
> asset_hash=3Dinitrd_hash)
> +        initrd_path =3D os.path.join(self.workdir, 'rootfs.cpio')
> +        archive.gzip_uncompress(initrd_path_gz, initrd_path)
> +
> +        self.vm.set_console()
> +        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
> +                               'console=3DttyS0,115200 '
> +                               'panic=3D-1 noreboot')
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-dtb', dtb_path,
> +                         '-initrd', initrd_path,
> +                         '-append', kernel_command_line,
> +                         '-no-reboot')
> +        self.vm.launch()
> +        self.wait_for_console_pattern('Boot successful.')
> +
> +        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
> +                                                'Allwinner sun8i Family'=
)
> +        exec_command_and_wait_for_pattern(self, 'cat /proc/iomem',
> +                                                'system-control@1c00000'=
)
> +        exec_command_and_wait_for_pattern(self, 'reboot',
> +                                                'reboot: Restarting
> system')
> +        # Wait for VM to shut down gracefully
> +        self.vm.wait()
> +
> +    def test_arm_bpim2u_gmac(self):
> +        """
> +        :avocado: tags=3Darch:arm
> +        :avocado: tags=3Daccel:tcg
> +        :avocado: tags=3Dmachine:bpim2u
> +        :avocado: tags=3Ddevice:sd
> +        """
> +        self.require_netdev('user')
> +
> +        deb_url =3D ('
> https://apt.armbian.com/pool/main/l/linux-5.10.16-sunxi/'
> +                   'linux-image-current-sunxi_21.02.2_armhf.deb')
> +        deb_hash =3D '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
> +        deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
> +        kernel_path =3D self.extract_from_deb(deb_path,
> +                                            '/boot/vmlinuz-5.10.16-sunxi=
')
> +        dtb_path =3D ('/usr/lib/linux-image-current-sunxi/'
> +                    'sun8i-r40-bananapi-m2-ultra.dtb')
> +        dtb_path =3D self.extract_from_deb(deb_path, dtb_path)
> +        rootfs_url =3D ('
> http://storage.kernelci.org/images/rootfs/buildroot/'
> +
> 'buildroot-baseline/20221116.0/armel/rootfs.ext2.xz')
> +        rootfs_hash =3D 'fae32f337c7b87547b10f42599acf109da8b6d9a'
> +        rootfs_path_xz =3D self.fetch_asset(rootfs_url,
> asset_hash=3Drootfs_hash)
> +        rootfs_path =3D os.path.join(self.workdir, 'rootfs.cpio')
> +        archive.lzma_uncompress(rootfs_path_xz, rootfs_path)
> +        image_pow2ceil_expand(rootfs_path)
> +
> +        self.vm.set_console()
> +        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
> +                               'console=3DttyS0,115200 '
> +                               'root=3D/dev/mmcblk0 rootwait rw '
> +                               'panic=3D-1 noreboot')
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-dtb', dtb_path,
> +                         '-drive', 'file=3D' + rootfs_path +
> ',if=3Dsd,format=3Draw',
> +                         '-net', 'nic,model=3Dgmac,netdev=3Dhost_gmac',
> +                         '-netdev', 'user,id=3Dhost_gmac',
> +                         '-append', kernel_command_line,
> +                         '-no-reboot')
> +        self.vm.launch()
> +        shell_ready =3D "/bin/sh: can't access tty; job control turned o=
ff"
> +        self.wait_for_console_pattern(shell_ready)
> +
> +        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
> +                                                'Allwinner sun8i Family'=
)
> +        exec_command_and_wait_for_pattern(self, 'cat /proc/partitions',
> +                                                'mmcblk0')
> +        exec_command_and_wait_for_pattern(self, 'ifconfig eth0 up',
> +                                                 'eth0: Link is Up')
> +        exec_command_and_wait_for_pattern(self, 'udhcpc eth0',
> +            'udhcpc: lease of 10.0.2.15 obtained')
> +        exec_command_and_wait_for_pattern(self, 'ping -c 3 10.0.2.2',
> +            '3 packets transmitted, 3 packets received, 0% packet loss')
> +        exec_command_and_wait_for_pattern(self, 'reboot',
> +                                                'reboot: Restarting
> system')
> +        # Wait for VM to shut down gracefully
> +        self.vm.wait()
> +
> +    @skipUnless(os.getenv('AVOCADO_ALLOW_LARGE_STORAGE'), 'storage
> limited')
> +    def test_arm_bpim2u_openwrt_22_03_3(self):
> +        """
> +        :avocado: tags=3Darch:arm
> +        :avocado: tags=3Dmachine:bpim2u
> +        :avocado: tags=3Ddevice:sd
> +        """
> +
> +        # This test download a 8.9 MiB compressed image and expand it
> +        # to 127 MiB.
> +        image_url =3D ('
> https://downloads.openwrt.org/releases/22.03.3/targets/'
> +                     'sunxi/cortexa7/openwrt-22.03.3-sunxi-cortexa7-'
> +                     'sinovoip_bananapi-m2-ultra-ext4-sdcard.img.gz')
> +        image_hash =3D ('5b41b4e11423e562c6011640f9a7cd3b'
> +                      'dd0a3d42b83430f7caa70a432e6cd82c')
> +        image_path_gz =3D self.fetch_asset(image_url, asset_hash=3Dimage=
_hash,
> +                                         algorithm=3D'sha256')
> +        image_path =3D archive.extract(image_path_gz, self.workdir)
> +        image_pow2ceil_expand(image_path)
> +
> +        self.vm.set_console()
> +        self.vm.add_args('-drive', 'file=3D' + image_path +
> ',if=3Dsd,format=3Draw',
> +                         '-nic', 'user',
> +                         '-no-reboot')
> +        self.vm.launch()
> +
> +        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
> +                               'usbcore.nousb '
> +                               'noreboot')
> +
> +        self.wait_for_console_pattern('U-Boot SPL')
> +
> +        interrupt_interactive_console_until_pattern(
> +                self, 'Hit any key to stop autoboot:', '=3D>')
> +        exec_command_and_wait_for_pattern(self, "setenv extraargs '" +
> +                                                kernel_command_line +
> "'", '=3D>')
> +        exec_command_and_wait_for_pattern(self, 'boot', 'Starting kernel
> ...');
> +
> +        self.wait_for_console_pattern(
> +            'Please press Enter to activate this console.')
> +
> +        exec_command_and_wait_for_pattern(self, ' ', 'root@')
> +
> +        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
> +                                                'Allwinner sun8i Family'=
)
> +        exec_command_and_wait_for_pattern(self, 'cat /proc/iomem',
> +                                                'system-control@1c00000'=
)
> +
>      def test_arm_orangepi(self):
>          """
>          :avocado: tags=3Darch:arm
> --
> 2.25.1
>
>

--=20
Niek Linnenbank

--00000000000004d8d505fbc10a76
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 10, 2023 at 12:30=E2=80=
=AFPM &lt;<a href=3D"mailto:qianfanguijin@163.com">qianfanguijin@163.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Fro=
m: qianfan Zhao &lt;<a href=3D"mailto:qianfanguijin@163.com" target=3D"_bla=
nk">qianfanguijin@163.com</a>&gt;<br>
<br>
Add test case for booting from initrd and sd card.<br></blockquote><div><br=
></div><div>To make the commit message more complete and reflect the full c=
ontents, maybe also mention the gmac and openwrt test?<br></div><div><br></=
div><div>Tests look fine to me, and are running OK on my machine:</div><div=
><br></div><div>$ AVOCADO_ALLOW_LARGE_STORAGE=3Dyes ./build/tests/venv/bin/=
avocado --show=3Dapp,console run -t machine:bpim2u tests/avocado/boot_linux=
_console.py</div><div>...</div><div>RESULTS =C2=A0 =C2=A0: PASS 4 | ERROR 0=
 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0<br>JOB TIME =C2=A0 : 2=
6.46 s</div><div><br></div><div>So for me feel free to add:</div><div><br><=
/div><div>Reviewed-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank=
@gmail.com">nieklinnenbank@gmail.com</a>&gt;</div><div>Tested-by: Niek Linn=
enbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com">nieklinnenbank@gmail=
.com</a>&gt;</div><div><br></div><div>Regards,</div><div>Niek<br></div><div=
>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Signed-off-by: qianfan Zhao &lt;<a href=3D"mailto:qianfanguijin@163.com" ta=
rget=3D"_blank">qianfanguijin@163.com</a>&gt;<br>
---<br>
=C2=A0tests/avocado/boot_linux_console.py | 176 +++++++++++++++++++++++++++=
+<br>
=C2=A01 file changed, 176 insertions(+)<br>
<br>
diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux=
_console.py<br>
index c0675809e6..6ed660611f 100644<br>
--- a/tests/avocado/boot_linux_console.py<br>
+++ b/tests/avocado/boot_linux_console.py<br>
@@ -769,6 +769,182 @@ def test_arm_quanta_gsj_initrd(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.wait_for_console_pattern(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;Give roo=
t password for system maintenance&#39;)<br>
<br>
+=C2=A0 =C2=A0 def test_arm_bpim2u(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Darch:arm<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dmachine:bpim2u<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Daccel:tcg<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_url =3D (&#39;<a href=3D"https://apt.armbi=
an.com/pool/main/l/linux-5.10.16-sunxi/" rel=3D"noreferrer" target=3D"_blan=
k">https://apt.armbian.com/pool/main/l/linux-5.10.16-sunxi/</a>&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;=
linux-image-current-sunxi_21.02.2_armhf.deb&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_hash =3D &#39;9fa84beda245cabf0b4fa84cf6ea=
a7738ead1da0&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_path =3D self.fetch_asset(deb_url, asset_h=
ash=3Ddeb_hash)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_path =3D self.extract_from_deb(deb_path=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &#39;/boot/vmlinuz-5.10.16-sunxi&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D (&#39;/usr/lib/linux-image-curren=
t-sunxi/&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39=
;sun8i-r40-bananapi-m2-ultra.dtb&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D self.extract_from_deb(deb_path, d=
tb_path)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.set_console()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_command_line =3D (self.KERNEL_COMMON_CO=
MMAND_LINE +<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;console=3DttyS0,115200n8 &#39;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;earlycon=3Duart,mmio32,0x1c28000=
&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.add_args(&#39;-kernel&#39;, kernel_pat=
h,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;-dtb&#39;, dtb_path,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;-append&#39;, kernel_command_line)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.launch()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 console_pattern =3D &#39;Kernel command line: =
%s&#39; % kernel_command_line<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.wait_for_console_pattern(console_pattern)=
<br>
+<br>
+=C2=A0 =C2=A0 def test_arm_bpim2u_initrd(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Darch:arm<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Daccel:tcg<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dmachine:bpim2u<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_url =3D (&#39;<a href=3D"https://apt.armbi=
an.com/pool/main/l/linux-5.10.16-sunxi/" rel=3D"noreferrer" target=3D"_blan=
k">https://apt.armbian.com/pool/main/l/linux-5.10.16-sunxi/</a>&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;=
linux-image-current-sunxi_21.02.2_armhf.deb&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_hash =3D &#39;9fa84beda245cabf0b4fa84cf6ea=
a7738ead1da0&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_path =3D self.fetch_asset(deb_url, asset_h=
ash=3Ddeb_hash)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_path =3D self.extract_from_deb(deb_path=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &#39;/boot/vmlinuz-5.10.16-sunxi&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D (&#39;/usr/lib/linux-image-curren=
t-sunxi/&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39=
;sun8i-r40-bananapi-m2-ultra.dtb&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D self.extract_from_deb(deb_path, d=
tb_path)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 initrd_url =3D (&#39;<a href=3D"https://github=
.com/groeck/linux-build-test/raw/" rel=3D"noreferrer" target=3D"_blank">htt=
ps://github.com/groeck/linux-build-test/raw/</a>&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &#39;2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &#39;arm/rootfs-armv7a.cpio.gz&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 initrd_hash =3D &#39;604b2e45cdf35045846b8bbfb=
f2129b1891bdc9c&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 initrd_path_gz =3D self.fetch_asset(initrd_url=
, asset_hash=3Dinitrd_hash)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 initrd_path =3D os.path.join(self.workdir, &#3=
9;rootfs.cpio&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 archive.gzip_uncompress(initrd_path_gz, initrd=
_path)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.set_console()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_command_line =3D (self.KERNEL_COMMON_CO=
MMAND_LINE +<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;console=3DttyS0,115200 &#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;panic=3D-1 noreboot&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.add_args(&#39;-kernel&#39;, kernel_pat=
h,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;-dtb&#39;, dtb_path,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;-initrd&#39;, initrd_path,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;-append&#39;, kernel_command_line,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;-no-reboot&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.launch()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.wait_for_console_pattern(&#39;Boot succes=
sful.&#39;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_pattern(self, &#39;c=
at /proc/cpuinfo&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &#39;Allwinner sun8i Family&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_pattern(self, &#39;c=
at /proc/iomem&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &#39;system-control@1c00000&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_pattern(self, &#39;r=
eboot&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &#39;reboot: Restarting system&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Wait for VM to shut down gracefully<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.wait()<br>
+<br>
+=C2=A0 =C2=A0 def test_arm_bpim2u_gmac(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Darch:arm<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Daccel:tcg<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dmachine:bpim2u<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Ddevice:sd<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.require_netdev(&#39;user&#39;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_url =3D (&#39;<a href=3D"https://apt.armbi=
an.com/pool/main/l/linux-5.10.16-sunxi/" rel=3D"noreferrer" target=3D"_blan=
k">https://apt.armbian.com/pool/main/l/linux-5.10.16-sunxi/</a>&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;=
linux-image-current-sunxi_21.02.2_armhf.deb&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_hash =3D &#39;9fa84beda245cabf0b4fa84cf6ea=
a7738ead1da0&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_path =3D self.fetch_asset(deb_url, asset_h=
ash=3Ddeb_hash)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_path =3D self.extract_from_deb(deb_path=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &#39;/boot/vmlinuz-5.10.16-sunxi&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D (&#39;/usr/lib/linux-image-curren=
t-sunxi/&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39=
;sun8i-r40-bananapi-m2-ultra.dtb&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D self.extract_from_deb(deb_path, d=
tb_path)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rootfs_url =3D (&#39;<a href=3D"http://storage=
.kernelci.org/images/rootfs/buildroot/" rel=3D"noreferrer" target=3D"_blank=
">http://storage.kernelci.org/images/rootfs/buildroot/</a>&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &#39;buildroot-baseline/20221116.0/armel/rootfs.ext2.xz&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rootfs_hash =3D &#39;fae32f337c7b87547b10f4259=
9acf109da8b6d9a&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rootfs_path_xz =3D self.fetch_asset(rootfs_url=
, asset_hash=3Drootfs_hash)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rootfs_path =3D os.path.join(self.workdir, &#3=
9;rootfs.cpio&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 archive.lzma_uncompress(rootfs_path_xz, rootfs=
_path)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 image_pow2ceil_expand(rootfs_path)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.set_console()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_command_line =3D (self.KERNEL_COMMON_CO=
MMAND_LINE +<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;console=3DttyS0,115200 &#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;root=3D/dev/mmcblk0 rootwait rw =
&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;panic=3D-1 noreboot&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.add_args(&#39;-kernel&#39;, kernel_pat=
h,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;-dtb&#39;, dtb_path,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;-drive&#39;, &#39;file=3D&#39; + rootfs_path + &#39;,=
if=3Dsd,format=3Draw&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;-net&#39;, &#39;nic,model=3Dgmac,netdev=3Dhost_gmac&#=
39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;-netdev&#39;, &#39;user,id=3Dhost_gmac&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;-append&#39;, kernel_command_line,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;-no-reboot&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.launch()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 shell_ready =3D &quot;/bin/sh: can&#39;t acces=
s tty; job control turned off&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.wait_for_console_pattern(shell_ready)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_pattern(self, &#39;c=
at /proc/cpuinfo&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &#39;Allwinner sun8i Family&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_pattern(self, &#39;c=
at /proc/partitions&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &#39;mmcblk0&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_pattern(self, &#39;i=
fconfig eth0 up&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;eth0: Link is Up&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_pattern(self, &#39;u=
dhcpc eth0&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;udhcpc: lease of 10.0.2.15 =
obtained&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_pattern(self, &#39;p=
ing -c 3 10.0.2.2&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;3 packets transmitted, 3 pa=
ckets received, 0% packet loss&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_pattern(self, &#39;r=
eboot&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &#39;reboot: Restarting system&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Wait for VM to shut down gracefully<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.wait()<br>
+<br>
+=C2=A0 =C2=A0 @skipUnless(os.getenv(&#39;AVOCADO_ALLOW_LARGE_STORAGE&#39;)=
, &#39;storage limited&#39;)<br>
+=C2=A0 =C2=A0 def test_arm_bpim2u_openwrt_22_03_3(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Darch:arm<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dmachine:bpim2u<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Ddevice:sd<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # This test download a 8.9 MiB compressed imag=
e and expand it<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # to 127 MiB.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 image_url =3D (&#39;<a href=3D"https://downloa=
ds.openwrt.org/releases/22.03.3/targets/" rel=3D"noreferrer" target=3D"_bla=
nk">https://downloads.openwrt.org/releases/22.03.3/targets/</a>&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&#39;sunxi/cortexa7/openwrt-22.03.3-sunxi-cortexa7-&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&#39;sinovoip_bananapi-m2-ultra-ext4-sdcard.img.gz&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 image_hash =3D (&#39;5b41b4e11423e562c6011640f=
9a7cd3b&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &#39;dd0a3d42b83430f7caa70a432e6cd82c&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 image_path_gz =3D self.fetch_asset(image_url, =
asset_hash=3Dimage_hash,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0al=
gorithm=3D&#39;sha256&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 image_path =3D archive.extract(image_path_gz, =
self.workdir)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 image_pow2ceil_expand(image_path)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.set_console()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.add_args(&#39;-drive&#39;, &#39;file=
=3D&#39; + image_path + &#39;,if=3Dsd,format=3Draw&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;-nic&#39;, &#39;user&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;-no-reboot&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.launch()<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_command_line =3D (self.KERNEL_COMMON_CO=
MMAND_LINE +<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;usbcore.nousb &#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;noreboot&#39;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.wait_for_console_pattern(&#39;U-Boot SPL&=
#39;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupt_interactive_console_until_pattern(<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self, &#39;Hit any=
 key to stop autoboot:&#39;, &#39;=3D&gt;&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_pattern(self, &quot;=
setenv extraargs &#39;&quot; +<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 kernel_command_line + &quot;&#39;&quot;, &#39;=3D&gt;&=
#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_pattern(self, &#39;b=
oot&#39;, &#39;Starting kernel ...&#39;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.wait_for_console_pattern(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;Please press Enter to activ=
ate this console.&#39;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_pattern(self, &#39; =
&#39;, &#39;root@&#39;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_pattern(self, &#39;c=
at /proc/cpuinfo&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &#39;Allwinner sun8i Family&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_pattern(self, &#39;c=
at /proc/iomem&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &#39;system-control@1c00000&#39;)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0def test_arm_orangepi(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0:avocado: tags=3Darch:arm<br>
-- <br>
2.25.1<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"l=
tr"><div>Niek Linnenbank<br><br></div></div></div></div>

--00000000000004d8d505fbc10a76--

