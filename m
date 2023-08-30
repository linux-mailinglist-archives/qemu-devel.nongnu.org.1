Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 808E478D6A8
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 16:52:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbMYb-0000Sg-4R; Wed, 30 Aug 2023 10:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qbMYZ-0000SW-1p
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:52:31 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qbMYW-0000UC-8u
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693407144; x=1694011944; i=deller@gmx.de;
 bh=P/PQL8CV2apvOg8uQVUS1u6uyHZK7omKWCQDjeG30v0=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=D1rU94ZeFK/Af46oJ7/BNzwHS1m3Xa/zd/beYJRM7W+K8vFraSXvp8cLukvxG573ll/bSWL
 gyG1RcbnzttArhwXsiLDqiqR5d4PK7DwbvhyQXre6mXrUU7dI4gKPtpLNewf2JOClCYsXKP+Z
 wK42IRkISRjTDnexkKEGFZkxfFK62AL3pxqRBzvWD6Y1tXMrCD7fO6XXoXIksL1kNYWzJxPi5
 KjGgqOeFt+477RX1JV5E2mnvroKS8DrFvX5rDM5ywSOT3a/ivzQGueZ+ApJfRXWq+GONGpo+/
 iGeMdzrQT8hNTFgRo+REITxjDgIaeb64tbjEPo0JPOGTgBYhG1Hw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.153.41]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSc1B-1q8SlF0Bc9-00SwX2; Wed, 30
 Aug 2023 16:52:24 +0200
Message-ID: <31a0da15-2d40-6779-091a-fc19207399bc@gmx.de>
Date: Wed, 30 Aug 2023 16:52:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 00/20] linux-user: Implement VDSOs
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, laurent@vivier.eu
References: <20230829220228.928506-1-richard.henderson@linaro.org>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <20230829220228.928506-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rcU9Yz29CGi4UQt/+3kFUXtbC/vgVvfajobTNx/6M0mgMzO7FNy
 qY1Hp2tzdRnozDIUmryEjV1KR1bLityVYMYzhHKWQ2hiIaQlumY28RhjoyUjfJUbahat79+
 +VGt5O6dPCnR9kCPCJEPTMxDwmALXhEerHpxUgJ+XCbVfWPQ11nKuszV1d5J3b9SJbHX5Et
 XCDIMPodQyzXEvVdXnvXA==
UI-OutboundReport: notjunk:1;M01:P0:QrhihjAQYTM=;Vc3ijCIqFaPFCZusoKJiaoMJcLB
 Qcp5wq2EQyssXvsQ/FpjRtOq1AnH0jhvEfO+QjxBWj/ZobuGzhfJXHfs2vSg/GRhn+7UDI5vi
 YaO/4CJ+Iln25lY3SdogxWsx2vS6vZXmIB+8shwEfSeqrYA0JQ5tBl+cCX2jO8B83GN2AbXVR
 dPl8BrN5/epB9yBnZfSPda2Cp1Q5zW1GDAiSoEDXbAPgP/+ScgUdZ937vsAQ7kwLTRu7docb+
 ySRJflgXVioOlCQjfA4ciA4Byrdv35zUv7lcarW5DcQJ4GzVF1QwBIUfxHJUIAIJFE0rICrMf
 tKgCrByvrGtag6oD6ACgf1QJKYG1gVV9zJLDvVn1VopEpdgUhA8ss25OxuqgRLWrio71NX/Rj
 f4uUnCRtCryKeIKp7U4makBUeFB0XziGa61Aoy5/FwQM02HnKO8XJAiuNTLgssOeDFkniuUOz
 NJO8qP8f6736gFWV/PPFd+3RSN7a/WwnTJpBvU0BrAOTx/EAcbiVu1Dxnn0qu2PUveJ3Hgg2u
 YdREv4kSJN9ITMMv/nhFFASXrArI+0SY4I4zeclrvjrxbQ4mo6AebQuHWMhb6HI4L0LG9/UI6
 GAF9e5e7iPw8YJTwGcuOlN214aTwBsTQZRMD07q3or06i+whimXSio4xUDvp2Kv7mpunZ20b0
 vYzWfJf9dRM5v8Rb081fSgGmy0yO38B7ZiYvI1zhlVcZEhMBQe2UzfrnVAC9x4aeJ8aqttRMN
 lu/9YHUcTbMMzKvqwQPZ5lUTNU7MF8B3ESEvkVi6HvRZRpkrzV/hEerrfSyczLUwyfsvdfG1f
 4U1YbP9F27S8224QatQ7ENcOBW6Q6DnHkY5TRW7WmZATCqmYWtBDFnmwVd5hEp6FqNiVizUuB
 1VJT2nM9F+11F37/ldI15O65Oe03+xDgnWB45C7W4cTbxW3tebl4J7a+bPEwDnXO752Vm3uAL
 yexpmw==
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-1.242, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
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

On 8/30/23 00:02, Richard Henderson wrote:
> Changes for v5:
>    * Integrated cross-compile, via new build-vdso.sh and meson rules.
>      However, keep the binaries in the tree for hosts which do not
>      have all of the cross-compile machinery.
>    * Update our loongarch64 docker image to avoid a binutils bug.
>
> Just in case the list eats a binary:
>    https://gitlab.com/rth7680/qemu/-/tree/lu-vdso

I pulled that on top of git head, and ran into the build problem below.
Do I miss something?

Helge

[62/1742] Generating linux-user/aarch64/vdso-be.so with a custom command
FAILED: linux-user/aarch64/vdso-be.so
/home/cvs/qemu/qemu/linux-user/build-vdso.sh -B /srv/_build -C /home/cvs/q=
emu/qemu/linux-user/aarch64 -T aarch64-linux-user -o linux-user/aarch64/vd=
so-be.so -- -nostdlib -shared -Wl,-h,linux-vdso.so.1 -Wl,--build-id=3Dsha1=
 -Wl,--hash-style=3Dboth -Wl,-T,../../home/cvs/qemu/qemu/linux-user/aarch6=
4/vdso.ld ../../home/cvs/qemu/qemu/linux-user/aarch64/vdso.S -mbig-endian
Error: short-name resolution enforced but cannot prompt without a TTY
Traceback (most recent call last):
   File "/home/cvs/qemu/qemu/tests/docker/docker.py", line 683, in <module=
>
     sys.exit(main())
              ^^^^^^
   File "/home/cvs/qemu/qemu/tests/docker/docker.py", line 679, in main
     return args.cmdobj.run(args, argv)
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^
   File "/home/cvs/qemu/qemu/tests/docker/docker.py", line 657, in run
     return Docker().run(cmd, False, quiet=3Dargs.quiet,
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   File "/home/cvs/qemu/qemu/tests/docker/docker.py", line 370, in run
     ret =3D self._do_check(["run", "--rm", "--label",
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   File "/home/cvs/qemu/qemu/tests/docker/docker.py", line 247, in _do_che=
ck
     return subprocess.check_call(self._command + cmd, **kwargs)
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   File "/usr/lib64/python3.11/subprocess.py", line 413, in check_call
     raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['podman', 'run', '--rm', '--label=
', 'com.qemu.instance.uuid=3De746f7e345ed420088a9cc30e884a7e8', '--userns=
=3Dkeep-id', '-u', '1000', '-w', '/srv/_build', '-v', '/srv/_build:/srv/_b=
uild:rw', '-v', '/home/cvs/qemu/qemu:/home/cvs/qemu/qemu:ro,z', 'qemu/debi=
an-arm64-cross', 'aarch64-linux-gnu-gcc-10', '-o', 'linux-user/aarch64/vds=
o-be.so', '-nostdlib', '-shared', '-Wl,-h,linux-vdso.so.1', '-Wl,--build-i=
d=3Dsha1', '-Wl,--hash-style=3Dboth', '-Wl,-T,../../home/cvs/qemu/qemu/lin=
ux-user/aarch64/vdso.ld', '../../home/cvs/qemu/qemu/linux-user/aarch64/vds=
o.S', '-mbig-endian']' returned non-zero exit status 125.
filter=3D--filter=3Dlabel=3Dcom.qemu.instance.uuid=3De746f7e345ed420088a9c=
c30e884a7e8


