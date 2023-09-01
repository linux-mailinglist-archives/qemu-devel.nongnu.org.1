Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B8278FEF0
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 16:22:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc52C-0007uV-No; Fri, 01 Sep 2023 10:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qc52B-0007u7-5S
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 10:22:03 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qc526-0002pP-Gv
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 10:22:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693578114; x=1694182914; i=deller@gmx.de;
 bh=d8X4nS/EnNKFvXSJw8EqfUSX1HG9Q+f2fo2rKZUDuwM=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=nwipr4aaK1PpEIg20GNKCaqGiIeEv7qHX8HGaVTJ422FDBhcSvz2dwm9PSnSHs2NiCTxOkY
 C2jSOxj391yQCLBJ6wIJ5XbGs9it0gJBXHAxGcjJLDY/cWKWzC2U7ULJOVqhV84GUchJx3OhZ
 hBNKeOyXcGbJSp86I/eS1M1T8bsJCHsjof6tWb7fzBYyG3D/PBsnF5uauo7Y/yec2lc4OctBz
 kcgPTeJ4t86eAWvU2JpfpH6c/7zF+bBr1Qy+XQPddRhIjyN9D2fLg+CQitXkAlQLXuGiPNVkU
 AV6Z25/NfMvCNgQL0g7Gr2ZhRXH1ndRD63pueb9gm5cKQPwAkHBA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.152.187]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M42nS-1qc5222Aeu-0003yP; Fri, 01
 Sep 2023 16:21:54 +0200
Message-ID: <b6f1fba2-c9b6-eaf5-9693-06bd8d747bf9@gmx.de>
Date: Fri, 1 Sep 2023 16:21:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 00/20] linux-user: Implement VDSOs
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu
References: <20230829220228.928506-1-richard.henderson@linaro.org>
 <31a0da15-2d40-6779-091a-fc19207399bc@gmx.de>
 <efc935f7-67c2-8877-98aa-1aebfcafa534@linaro.org> <87h6ofprre.fsf@linaro.org>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <87h6ofprre.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tE96Kz6LYnvk8lT7Ynii96N4SwGPpZSEH4BiXSO+Kz7HC1WCdRm
 uX/PabSZ0DzLxjcPf74MBCv6y5W4GdgE0dJ06+eI/e7LpuMa6CFkUvZ7473upu0Rcesjwft
 2tnwWu/cslJWaDF5fdyuMlpbO1+wO4qvuAUgU46D2A40bCiPk3x0VpXEOMnnzJbBGn4tehu
 t6MxOv5ts3hVMOFAHXn2Q==
UI-OutboundReport: notjunk:1;M01:P0:T0QSxcekXts=;ZYhqRJjUmkx/cSwH6/Mf98CMXie
 OkJserxuGJMoJ6hRL/x7EMmD22X27b45WrIVc8wcErNq0kNsvwZBnJsTWRXn0+YZ/4a2ZbVhr
 IqrYDxTlZUk1BPhdhnwm8Bg6GUKF8sbvBMoN1VpG1M+OvryEp/jqee3+xKHaeuXVkBMLnNtrA
 i91yALKCJhsBezHOz9uz+geXPFPRe4wo2D2vj+WdSCWqHLJVYmMg3WAVncCmNAVuJmGyqf0b1
 F5eQI9LOlOdVJGAgNQbCNRwk5cyiQrrX26nQdfX5K1hYteZxRXGVXDFOkVOjoQZxpeVI9ZP9w
 c2vq3eQmsWuco64MGhp4t1/0F9ZausKJdX1TC5s8ND9SlVfSCo4lFzeq4mjMatpj5PTWx4Knt
 Lhg9+/y/5ijXilCKkrwPED0gLBH6q1AP8HUERHQV+7EabM+Uihn9lErgX3PUzZDGWt1Rwwdeq
 Fo/uOdKQfrCdIa301zXO3ayonvBTIhw+Ur8dJIUFIBdK128PdGYvuKIzVb3F/tNTppohBPNAw
 cNoul7IMPYesiA6Ke4NH7gEEzXuU2v1tl8njl4hTqj2fygLMhdObX961tcKv/K66viqwK9YR4
 RVnbhSgvPamQ2lWJrVnR4lA7Ek5KNOWWGixUYEUpYdrXhXnrCjgNzxpmbXQRIQrIfEvOFGkox
 5+Lvs/udkhxr5Xy2z/l0p6qMhdftyT8dh36pyBurLUYMF3uBvt4jKygd4CKz4NkIuYvpmoMmh
 /M88LCR//ka9xRRo5lr3Hq8jmKSZ3q6+fvLbExojMz46thWOPbR7EMBR4ur6+w541HzMNsGV0
 5typz+uFqrPNBMrR5WpnxWLb1lGFT1TVdYvWnsHkOkrYk5NSRGzrSV7Uh1qBQfH8zFt43jwzI
 DzuRT5EIubVfcr9Ctyc/BSj8uPWO+53V3JbMIgISy+vrItmIFEwt52raPSR7rTMz37YvoXQZV
 1N0s5BWF/lBZbNfiGf+Dwf0IbSU=
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-3.478, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
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

On 8/31/23 09:57, Alex Benn=C3=A9e wrote:
>
> Richard Henderson <richard.henderson@linaro.org> writes:
>
>> On 8/30/23 07:52, Helge Deller wrote:
>>> On 8/30/23 00:02, Richard Henderson wrote:
>>>> Changes for v5:
>>>>  =C2=A0=C2=A0 * Integrated cross-compile, via new build-vdso.sh and m=
eson rules.
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 However, keep the binaries in the tree for =
hosts which do not
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 have all of the cross-compile machinery.
>>>>  =C2=A0=C2=A0 * Update our loongarch64 docker image to avoid a binuti=
ls bug.
>>>>
>>>> Just in case the list eats a binary:
>>>>  =C2=A0=C2=A0 https://gitlab.com/rth7680/qemu/-/tree/lu-vdso
>>> I pulled that on top of git head, and ran into the build problem
>>> below.
>>> Do I miss something?
>>
>> No idea, since it worked for me.  Looks like some sort of docker.py pro=
blem.  Alex?
>>
>> In the short term, use --disable-containers so that you only use the
>> cross-compilers that you have locally installed.
>>
>>
>> r~
>>
>>> Helge
>>> [62/1742] Generating linux-user/aarch64/vdso-be.so with a custom
>>> command
>>> FAILED: linux-user/aarch64/vdso-be.so
>>> /home/cvs/qemu/qemu/linux-user/build-vdso.sh -B /srv/_build -C
>>> /home/cvs/qemu/qemu/linux-user/aarch64 -T aarch64-linux-user -o
>>> linux-user/aarch64/vdso-be.so -- -nostdlib -shared
>>> -Wl,-h,linux-vdso.so.1 -Wl,--build-id=3Dsha1 -Wl,--hash-style=3Dboth
>>> -Wl,-T,../../home/cvs/qemu/qemu/linux-user/aarch64/vdso.ld
>>> ../../home/cvs/qemu/qemu/linux-user/aarch64/vdso.S -mbig-endian
>>> Error: short-name resolution enforced but cannot prompt without a TTY
>>> Traceback (most recent call last):
>>>   =C2=A0 File "/home/cvs/qemu/qemu/tests/docker/docker.py", line 683, =
in <module>
>>>   =C2=A0=C2=A0=C2=A0 sys.exit(main())
>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ^^^^^^
>>>   =C2=A0 File "/home/cvs/qemu/qemu/tests/docker/docker.py", line 679, =
in main
>>>   =C2=A0=C2=A0=C2=A0 return args.cmdobj.run(args, argv)
>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^^^^^^^=
^^^^^^^^^^^^^^^^^^^^
>>>   =C2=A0 File "/home/cvs/qemu/qemu/tests/docker/docker.py", line 657, =
in run
>>>   =C2=A0=C2=A0=C2=A0 return Docker().run(cmd, False, quiet=3Dargs.quie=
t,
>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>   =C2=A0 File "/home/cvs/qemu/qemu/tests/docker/docker.py", line 370, =
in run
>>>   =C2=A0=C2=A0=C2=A0 ret =3D self._do_check(["run", "--rm", "--label",
>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>   =C2=A0 File "/home/cvs/qemu/qemu/tests/docker/docker.py", line 247, =
in _do_check
>>>   =C2=A0=C2=A0=C2=A0 return subprocess.check_call(self._command + cmd,=
 **kwargs)
>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>   =C2=A0 File "/usr/lib64/python3.11/subprocess.py", line 413, in chec=
k_call
>>>   =C2=A0=C2=A0=C2=A0 raise CalledProcessError(retcode, cmd)
>>> subprocess.CalledProcessError: Command '['podman', 'run', '--rm',
>>> '--label',
>
> It looks like it detected podman on this setup. Can you invoke the
> container from the command line?

Yes, if I run it on the command line:

[deller@p100 _build]$ 'podman' 'run' '--rm' '--label' 'com.qemu.instance.u=
uid=3D21e1c0332a2c44b6ae94a71392c57ccf' '--userns=3Dkeep-id' '-u' '1000' '=
-w' '/srv/_build' '-v' '/srv/_build:/srv/_build:rw' '-v' '/home/cvs/qemu/q=
emu:/home/cvs/qemu/qemu:ro,z' 'qemu/debian-armhf-cross' 'arm-linux-gnueabi=
hf-gcc' '-o' 'linux-user/arm/vdso-le.so' '-nostdlib' '-shared' '-Wl,-use-b=
lx' '-Wl,-h,linux-vdso.so.1' '-Wl,--build-id=3Dsha1' '-Wl,--hash-style=3Db=
oth' '-Wl,-T,../../home/cvs/qemu/qemu/linux-user/arm/vdso.ld' '../../home/=
cvs/qemu/qemu/linux-user/arm/vdso.S' '-mlittle-endian'

I get this interactive(!!!) output where I can use the cursor keys to swit=
h up/down:

? Please select an image:
   =E2=96=B8 registry.fedoraproject.org/qemu/debian-armhf-cross:latest
     registry.access.redhat.com/qemu/debian-armhf-cross:latest
     docker.io/qemu/debian-armhf-cross:latest
     quay.io/qemu/debian-armhf-cross:latest

I assume the problem is, that we don't want interactive input at this stag=
e?
Probably this is why I get the error message: "Error: short-name resolutio=
n enforced but cannot prompt without a TTY" ?

Helge

