Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DC278E778
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 09:59:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbcZp-00055L-Mu; Thu, 31 Aug 2023 03:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbcZn-000554-DI
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 03:58:51 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbcZk-0002R4-OT
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 03:58:51 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-401ceda85cdso4908585e9.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 00:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693468727; x=1694073527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DyDFCnhNE/har/KY6iiXMetsIsADgeTMgi3ePE979zc=;
 b=TZLet+H3X7i3R+h+wvN7Ncbhq5/wxTw8C4CrGJbdVg+763TSdTXg6XX8Dd8mmV0fOF
 v3gypmAEQwiEm3uDMJ4qx5OvSy0RkQq5aM5tuOpznGSZeIWzH0613EnE17EeyuXt1Cu8
 /kjDjXv5L5t10VmweAkZYviy34UMqFaIPwQQo2G85MAWbCS0xrvEq3cgQVW9gUryOgHD
 jjTNFCh21i4NLkr3e7U1bh8pS/JYGcP4eLztoHf0GgsXxMwDG/kinPMpYDfiC3zOIeK6
 OmaN5QC8HBCpklj1TG5tMiAJQjAxImmsuDej8wucG0kuXfUEU1M6VTl0v/X9tQRXSPCv
 /1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693468727; x=1694073527;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DyDFCnhNE/har/KY6iiXMetsIsADgeTMgi3ePE979zc=;
 b=Jeip1ggQODkcq0FTjbdMVH2U8XqPw5IPRhi9OwkDnACm9GLlriDnTGAK+uJzH0+YZx
 6Y3qHMtA93colU78ne6rgDZ+PzL/Ze4+ZSYnj8wcZtpeNQPWxPH56kVXDBkphK9Bt6wr
 Zk6x9DUZAnYDY9wqsvvJritU709vXmv4wF/rqO8ng7HalrXlVPF7FCmx8k1qfdxlgV3m
 6k7enNF7pDde6n3H/gW4az1T4w6XGIimkyHksgAmRf48w6oQsqfzzjUhyI6eP5VG6eKN
 70BUNgB6lx8ZtD+sQ8lZd06ILzL/iZwH/SbDijEkYppPz3aQqrKjB0GWBNMKoUMCuuJ0
 Pc7Q==
X-Gm-Message-State: AOJu0YwWboEEuQKasIN0NGy3rQdBb2rX68DcaQNauw+Be53O0R0/Ic5D
 98poUqMbtQx/jmONnSNWCCU2wA==
X-Google-Smtp-Source: AGHT+IHq8tiDwqaCMIVls2HT4HfdzYptBR/FFhrgkdRNi5mc6rRKRwOsgXOBJMiJ2VqReNUwFTV/fQ==
X-Received: by 2002:a7b:c455:0:b0:400:ce4f:f184 with SMTP id
 l21-20020a7bc455000000b00400ce4ff184mr3447790wmi.41.1693468726857; 
 Thu, 31 Aug 2023 00:58:46 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 x18-20020adfec12000000b0031989784d96sm1303615wrn.76.2023.08.31.00.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 00:58:46 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0AF071FFBB;
 Thu, 31 Aug 2023 08:58:46 +0100 (BST)
References: <20230829220228.928506-1-richard.henderson@linaro.org>
 <31a0da15-2d40-6779-091a-fc19207399bc@gmx.de>
 <efc935f7-67c2-8877-98aa-1aebfcafa534@linaro.org>
User-agent: mu4e 1.11.16; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org, laurent@vivier.eu
Subject: Re: [PATCH v5 00/20] linux-user: Implement VDSOs
Date: Thu, 31 Aug 2023 08:57:51 +0100
In-reply-to: <efc935f7-67c2-8877-98aa-1aebfcafa534@linaro.org>
Message-ID: <87h6ofprre.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


Richard Henderson <richard.henderson@linaro.org> writes:

> On 8/30/23 07:52, Helge Deller wrote:
>> On 8/30/23 00:02, Richard Henderson wrote:
>>> Changes for v5:
>>> =C2=A0=C2=A0 * Integrated cross-compile, via new build-vdso.sh and meso=
n rules.
>>> =C2=A0=C2=A0=C2=A0=C2=A0 However, keep the binaries in the tree for hos=
ts which do not
>>> =C2=A0=C2=A0=C2=A0=C2=A0 have all of the cross-compile machinery.
>>> =C2=A0=C2=A0 * Update our loongarch64 docker image to avoid a binutils =
bug.
>>>
>>> Just in case the list eats a binary:
>>> =C2=A0=C2=A0 https://gitlab.com/rth7680/qemu/-/tree/lu-vdso
>> I pulled that on top of git head, and ran into the build problem
>> below.
>> Do I miss something?
>
> No idea, since it worked for me.  Looks like some sort of docker.py probl=
em.  Alex?
>
> In the short term, use --disable-containers so that you only use the
> cross-compilers that you have locally installed.
>
>
> r~
>
>> Helge
>> [62/1742] Generating linux-user/aarch64/vdso-be.so with a custom
>> command
>> FAILED: linux-user/aarch64/vdso-be.so
>> /home/cvs/qemu/qemu/linux-user/build-vdso.sh -B /srv/_build -C
>> /home/cvs/qemu/qemu/linux-user/aarch64 -T aarch64-linux-user -o
>> linux-user/aarch64/vdso-be.so -- -nostdlib -shared
>> -Wl,-h,linux-vdso.so.1 -Wl,--build-id=3Dsha1 -Wl,--hash-style=3Dboth
>> -Wl,-T,../../home/cvs/qemu/qemu/linux-user/aarch64/vdso.ld
>> ../../home/cvs/qemu/qemu/linux-user/aarch64/vdso.S -mbig-endian
>> Error: short-name resolution enforced but cannot prompt without a TTY
>> Traceback (most recent call last):
>>  =C2=A0 File "/home/cvs/qemu/qemu/tests/docker/docker.py", line 683, in =
<module>
>>  =C2=A0=C2=A0=C2=A0 sys.exit(main())
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ^^^^^^
>>  =C2=A0 File "/home/cvs/qemu/qemu/tests/docker/docker.py", line 679, in =
main
>>  =C2=A0=C2=A0=C2=A0 return args.cmdobj.run(args, argv)
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^^^^^^^^^^=
^^^^^^^^^^^^^^^^^
>>  =C2=A0 File "/home/cvs/qemu/qemu/tests/docker/docker.py", line 657, in =
run
>>  =C2=A0=C2=A0=C2=A0 return Docker().run(cmd, False, quiet=3Dargs.quiet,
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>  =C2=A0 File "/home/cvs/qemu/qemu/tests/docker/docker.py", line 370, in =
run
>>  =C2=A0=C2=A0=C2=A0 ret =3D self._do_check(["run", "--rm", "--label",
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^^^^
>>  =C2=A0 File "/home/cvs/qemu/qemu/tests/docker/docker.py", line 247, in =
_do_check
>>  =C2=A0=C2=A0=C2=A0 return subprocess.check_call(self._command + cmd, **=
kwargs)
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>  =C2=A0 File "/usr/lib64/python3.11/subprocess.py", line 413, in check_c=
all
>>  =C2=A0=C2=A0=C2=A0 raise CalledProcessError(retcode, cmd)
>> subprocess.CalledProcessError: Command '['podman', 'run', '--rm',
>> '--label',

It looks like it detected podman on this setup. Can you invoke the
container from the command line?

>> 'com.qemu.instance.uuid=3De746f7e345ed420088a9cc30e884a7e8',
>> '--userns=3Dkeep-id', '-u', '1000', '-w', '/srv/_build', '-v',
>> '/srv/_build:/srv/_build:rw', '-v',
>> '/home/cvs/qemu/qemu:/home/cvs/qemu/qemu:ro,z',
>> 'qemu/debian-arm64-cross', 'aarch64-linux-gnu-gcc-10', '-o',
>> 'linux-user/aarch64/vdso-be.so', '-nostdlib', '-shared',
>> '-Wl,-h,linux-vdso.so.1', '-Wl,--build-id=3Dsha1',
>> '-Wl,--hash-style=3Dboth',
>> '-Wl,-T,../../home/cvs/qemu/qemu/linux-user/aarch64/vdso.ld',
>> '../../home/cvs/qemu/qemu/linux-user/aarch64/vdso.S',
>> '-mbig-endian']' returned non-zero exit status 125.
>> filter=3D--filter=3Dlabel=3Dcom.qemu.instance.uuid=3De746f7e345ed420088a=
9cc30e884a7e8
>>=20


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

