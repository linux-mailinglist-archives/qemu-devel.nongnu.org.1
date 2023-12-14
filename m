Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 821C0812D12
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 11:35:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDj3J-00077i-Hv; Thu, 14 Dec 2023 05:34:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rDj3H-00076u-BC
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 05:34:47 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rDj3D-0000Of-Pu
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 05:34:46 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3333a3a599fso243175f8f.0
 for <qemu-devel@nongnu.org>; Thu, 14 Dec 2023 02:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702550082; x=1703154882; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VTIMG9FJoGMyoT9rRoj2x7tqQ0Gr6d1LxVablCR6iy8=;
 b=LJqp0fv+ph0yKxxq8iwm1omECTS5EyqD72z/oyycgzPN8ZLJm9/Z51yOFtSQsbtDb1
 +K/UW5FB2ITPcfg3J0eyxdvtKJv0OwrDhSpK9cuHc3Rl+wmA6jaxn0iHQpUU/I5FdSza
 ZnrBSkQJgWL0MPHXg0jCOGkL3S1yV4mNL4LxbQx8Ib/oC/IznQzcex7mdgoeHM39M3YW
 caAshML0ib6RCuN5fCqGVutx2g0F7jjOt6RGSBpoqttY4LBT7dNa2EyZnswHG40qpnb3
 MCxppWtCZUek66D+WtaD2+U6HZDkyEs6GxLu353eZgsUzEr9FFPBiahxCU44tvBsEKdn
 NPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702550082; x=1703154882;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VTIMG9FJoGMyoT9rRoj2x7tqQ0Gr6d1LxVablCR6iy8=;
 b=t0yXj1cWWbP3/ZbToFX1oImKhNXGeBpz0c+6CbbJ1YW3zs6BTzhnfffuwlmiEtJj9s
 n3vZhZVrx+5DxtPor4K6HfSpJNEtUjLy7AyZ4UrUDI+RTrDfUmO2Zp6hNCrJclfyUCgw
 eDUmiddkJ2ARBCXDTacXMwXylM0jyg5uw+8xXGj34SoYhh/ereoGBzQW3zYLJh54OQWe
 TSwPc8Ne6WmcjuPEj0H97q/f5pHDLZo1fr7lh+qV6f/SFREzllktV5v5+DHjTbkUn2H+
 SkBgEpGd1kFD0/HEKDyKBKf70XICi2gLn0WU37gI++svM7d7V4dLRbFg7yY0iJxMyX0Z
 j5gw==
X-Gm-Message-State: AOJu0Yz+5BNf5qgympV1CWjigDqlBondwaTw2OGHxZvyLNUyPz8yvWoX
 OjhIti9XX6Y8uO92q6YHloHOWw==
X-Google-Smtp-Source: AGHT+IEnzdfsAufZfsYDDmCA8IJHdokLbFAltymI6snKzyOYYZjuz900q/taMvC1Zuz+SQEW3V/P3g==
X-Received: by 2002:a1c:7906:0:b0:40b:5e4a:235b with SMTP id
 l6-20020a1c7906000000b0040b5e4a235bmr4708868wme.93.1702550082208; 
 Thu, 14 Dec 2023 02:34:42 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bi11-20020a05600c3d8b00b0040c2963e5f3sm23970057wmb.38.2023.12.14.02.34.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 02:34:41 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 758725F7D3;
 Thu, 14 Dec 2023 10:34:41 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org,  Jiaxun Yang <jiaxun.yang@flygoat.com>,  Radoslaw
 Biernacki <rad@semihalf.com>,  Paul Durrant <paul@xen.org>,  Akihiko Odaki
 <akihiko.odaki@daynix.com>,  Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  kvm@vger.kernel.org,  qemu-arm@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Beraldo Leal
 <bleal@redhat.com>,  Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,  Marcin Juszkiewicz
 <marcin.juszkiewicz@linaro.org>,  David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 04/10] tests/avocado: machine aarch64: standardize
 location and RO/RW access
In-Reply-To: <87h6klvm90.fsf@p1.localdomain> (Cleber Rosa's message of "Wed,
 13 Dec 2023 16:14:03 -0500")
References: <20231208190911.102879-1-crosa@redhat.com>
 <20231208190911.102879-5-crosa@redhat.com>
 <87wmtkeils.fsf@draig.linaro.org> <87h6klvm90.fsf@p1.localdomain>
User-Agent: mu4e 1.11.26; emacs 29.1
Date: Thu, 14 Dec 2023 10:34:41 +0000
Message-ID: <87le9x843i.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Cleber Rosa <crosa@redhat.com> writes:

> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
>> Cleber Rosa <crosa@redhat.com> writes:
>>
>>> The tests under machine_aarch64_virt.py do not need read-write access
>>> to the ISOs.  The ones under machine_aarch64_sbsaref.py, on the other
>>> hand, will need read-write access, so let's give each test an unique
>>> file.
>>
>> I think we are making two separate changes here so probably best split
>> the patch.
>>
>
> Sure, but, do you mean separating the "readonly=3Don" and the "writable
> file" changes?  Or separating those two from the ISO url code style
> change?

I was thinking about splitting the sbsaref and virt patches, but
actually they are fairly related as they all use the alpine image so
maybe no need.

>
>>> And while at it, let's use a single code style and hash for the ISO
>>> url.
>>>
>>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>>> ---
>>>  tests/avocado/machine_aarch64_sbsaref.py |  9 +++++++--
>>>  tests/avocado/machine_aarch64_virt.py    | 14 +++++++-------
>>>  2 files changed, 14 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/m=
achine_aarch64_sbsaref.py
>>> index 528c7d2934..6ae84d77ac 100644
>>> --- a/tests/avocado/machine_aarch64_sbsaref.py
>>> +++ b/tests/avocado/machine_aarch64_sbsaref.py
>>> @@ -7,6 +7,7 @@
>>>  # SPDX-License-Identifier: GPL-2.0-or-later
>>>=20=20
>>>  import os
>>> +import shutil
>>>=20=20
>>>  from avocado import skipUnless
>>>  from avocado.utils import archive
>>> @@ -123,13 +124,15 @@ def boot_alpine_linux(self, cpu):
>>>=20=20
>>>          iso_hash =3D "5a36304ecf039292082d92b48152a9ec21009d3a62f459de=
623e19c4bd9dc027"
>>>          iso_path =3D self.fetch_asset(iso_url, algorithm=3D"sha256", a=
sset_hash=3Diso_hash)
>>> +        iso_path_rw =3D os.path.join(self.workdir, os.path.basename(is=
o_path))
>>> +        shutil.copy(iso_path, iso_path_rw)
>>>=20=20
>>>          self.vm.set_console()
>>>          self.vm.add_args(
>>>              "-cpu",
>>>              cpu,
>>>              "-drive",
>>> -            f"file=3D{iso_path},format=3Draw",
>>> +            f"file=3D{iso_path_rw},format=3Draw",
>>
>> Instead of copying why not add ",snapshot=3Don" to preserve the original
>> image. We don't want to persist data between tests.

Ahh yes these are isos so snapshot isn't needed.

>>
>>>              "-device",
>>>              "virtio-rng-pci,rng=3Drng0",
>>>              "-object",
>>> @@ -170,13 +173,15 @@ def boot_openbsd73(self, cpu):
>>>=20=20
>>>          img_hash =3D "7fc2c75401d6f01fbfa25f4953f72ad7d7c18650056d3075=
5c44b9c129b707e5"
>>>          img_path =3D self.fetch_asset(img_url, algorithm=3D"sha256", a=
sset_hash=3Dimg_hash)
>>> +        img_path_rw =3D os.path.join(self.workdir, os.path.basename(im=
g_path))
>>> +        shutil.copy(img_path, img_path_rw)
>>>=20=20
>>>          self.vm.set_console()
>>>          self.vm.add_args(
>>>              "-cpu",
>>>              cpu,
>>>              "-drive",
>>> -            f"file=3D{img_path},format=3Draw",
>>> +            f"file=3D{img_path_rw},format=3Draw",
>>
>> ditto.
>>
>>
>>>              "-device",
>>>              "virtio-rng-pci,rng=3Drng0",
>>>              "-object",
>>> diff --git a/tests/avocado/machine_aarch64_virt.py b/tests/avocado/mach=
ine_aarch64_virt.py
>>> index a90dc6ff4b..093d68f837 100644
>>> --- a/tests/avocado/machine_aarch64_virt.py
>>> +++ b/tests/avocado/machine_aarch64_virt.py
>>> @@ -37,13 +37,13 @@ def test_alpine_virt_tcg_gic_max(self):
>>>          :avocado: tags=3Dmachine:virt
>>>          :avocado: tags=3Daccel:tcg
>>>          """
>>> -        iso_url =3D ('https://dl-cdn.alpinelinux.org/'
>>> -                   'alpine/v3.17/releases/aarch64/'
>>> -                   'alpine-standard-3.17.2-aarch64.iso')
>>> +        iso_url =3D (
>>> +            "https://dl-cdn.alpinelinux.org/"
>>> +            "alpine/v3.17/releases/aarch64/alpine-standard-3.17.2-aarc=
h64.iso"
>>> +        )
>>>=20=20
>>> -        # Alpine use sha256 so I recalculated this myself
>>> -        iso_sha1 =3D '76284fcd7b41fe899b0c2375ceb8470803eea839'
>>> -        iso_path =3D self.fetch_asset(iso_url, asset_hash=3Diso_sha1)
>>> +        iso_hash =3D "5a36304ecf039292082d92b48152a9ec21009d3a62f459de=
623e19c4bd9dc027"
>>> +        iso_path =3D self.fetch_asset(iso_url, algorithm=3D"sha256", a=
sset_hash=3Diso_hash)
>>>=20=20
>>>          self.vm.set_console()
>>>          kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
>>> @@ -60,7 +60,7 @@ def test_alpine_virt_tcg_gic_max(self):
>>>          self.vm.add_args("-smp", "2", "-m", "1024")
>>>          self.vm.add_args('-bios', os.path.join(BUILD_DIR, 'pc-bios',
>>>                                                 'edk2-aarch64-code.fd'))
>>> -        self.vm.add_args("-drive", f"file=3D{iso_path},format=3Draw")
>>> +        self.vm.add_args("-drive",
>>>          f"file=3D{iso_path},readonly=3Don,format=3Draw")
>>
>> Perhaps we can set ",media=3Dcdrom" here.
>>
>
> Yes, but more importantly, adding both "readonly=3Don" and "media=3Dcdrom"
> to the tests under machine_aarch64_sbsaref.py do the trick.  Now, the
> behavior explained in my previous response still warrants investigation
> IMO.
>
> Thanks
> - Cleber.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

