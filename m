Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D25A680D467
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 18:48:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCkNy-0000np-S1; Mon, 11 Dec 2023 12:48:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rCkNv-0000nC-LM
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 12:48:03 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rCkNt-0008DY-Ap
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 12:48:03 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40c3fe6c08fso23740525e9.1
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 09:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702316880; x=1702921680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6GyIfzmIozQp2p6r6Dz0e+oD9SE+AcfjjewTE6Log7o=;
 b=S0uPos00dZ17imMDhS1l7RKURBVIpyLwrAX4E6w9I73yy8WlYhlPZ+FK3cCQ5B8xYi
 eEgufgNSWJ+ktE1clai0468aloYfqVeJeT5R/mR9dWcR3CPVmXobGZpaER34P4KPhsxo
 y07+lGvPweZD8fyMrlkhR7D5RC6F4Yl8DFV9DQSfQigPQstdMK5UXKEQPRDgvy5GOYK0
 /NH+ZlJeRYrGc/ct2eB6N8QHqUZep/4fX2QZWMR5Ejc4NI72qKl/Vj+024eUrfg6165e
 pr6ofXjACGxlot9mQpC56S5LjVokDtLryKDH3tDjxf3QIGpoJ1/vozNlttMv2bn35chi
 eRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702316880; x=1702921680;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6GyIfzmIozQp2p6r6Dz0e+oD9SE+AcfjjewTE6Log7o=;
 b=pl4aYm0MrrXZRpILfubj0k9Q0kmfOXKvkldIAsSb51oWfyrtRk9nLJKwWJbMuwrOH7
 YKDHOK+4ieJtfRfWvoiLB1pD6uv71Sym4h3MyfhjZhQjs4iw++bzPLRjY2PQyR9cj2jd
 7fBTk/s4jK1TPdtNAF7rSJawlSBbqTE75ZSTz3TRvXc0m0pgAaWsVfyx4VDr1N+FB02v
 UgTBV095njJfag6/nD+ZNt4fK9vvfCxvE76A54vkOfJU5LiRn/j5H93hh8GUdbh1WJeV
 mDMeiDR0dqxzoayYc8BSH7IstHIfTq5iJO0nuSRAdv/6v4WV4bq02o5G4nhdTltGiR1t
 iZQA==
X-Gm-Message-State: AOJu0YxvEoJL9RV4A6VfMmXVx9mOBZaa1GHrnBzDT8RbIZB+EY5XJc+1
 BeWxlAvduLM6VgATlGCIJjrSUg==
X-Google-Smtp-Source: AGHT+IG+1JJM7gVsvYVGmWwS9/xIxKeFKXGWkKen1e5v6kRMvEYri/9mxircEIok9/mWKo+AklmsMw==
X-Received: by 2002:a05:600c:3794:b0:40c:32b3:f297 with SMTP id
 o20-20020a05600c379400b0040c32b3f297mr1722285wmr.55.1702316879810; 
 Mon, 11 Dec 2023 09:47:59 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 h2-20020a05600c350200b0040c44b4a282sm5859487wmq.43.2023.12.11.09.47.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 09:47:59 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 17ED45FBC6;
 Mon, 11 Dec 2023 17:47:59 +0000 (GMT)
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
In-Reply-To: <20231208190911.102879-5-crosa@redhat.com> (Cleber Rosa's message
 of "Fri, 8 Dec 2023 14:09:05 -0500")
References: <20231208190911.102879-1-crosa@redhat.com>
 <20231208190911.102879-5-crosa@redhat.com>
User-Agent: mu4e 1.11.26; emacs 29.1
Date: Mon, 11 Dec 2023 17:47:59 +0000
Message-ID: <87wmtkeils.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

> The tests under machine_aarch64_virt.py do not need read-write access
> to the ISOs.  The ones under machine_aarch64_sbsaref.py, on the other
> hand, will need read-write access, so let's give each test an unique
> file.

I think we are making two separate changes here so probably best split
the patch.

> And while at it, let's use a single code style and hash for the ISO
> url.
>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  tests/avocado/machine_aarch64_sbsaref.py |  9 +++++++--
>  tests/avocado/machine_aarch64_virt.py    | 14 +++++++-------
>  2 files changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/mac=
hine_aarch64_sbsaref.py
> index 528c7d2934..6ae84d77ac 100644
> --- a/tests/avocado/machine_aarch64_sbsaref.py
> +++ b/tests/avocado/machine_aarch64_sbsaref.py
> @@ -7,6 +7,7 @@
>  # SPDX-License-Identifier: GPL-2.0-or-later
>=20=20
>  import os
> +import shutil
>=20=20
>  from avocado import skipUnless
>  from avocado.utils import archive
> @@ -123,13 +124,15 @@ def boot_alpine_linux(self, cpu):
>=20=20
>          iso_hash =3D "5a36304ecf039292082d92b48152a9ec21009d3a62f459de62=
3e19c4bd9dc027"
>          iso_path =3D self.fetch_asset(iso_url, algorithm=3D"sha256", ass=
et_hash=3Diso_hash)
> +        iso_path_rw =3D os.path.join(self.workdir, os.path.basename(iso_=
path))
> +        shutil.copy(iso_path, iso_path_rw)
>=20=20
>          self.vm.set_console()
>          self.vm.add_args(
>              "-cpu",
>              cpu,
>              "-drive",
> -            f"file=3D{iso_path},format=3Draw",
> +            f"file=3D{iso_path_rw},format=3Draw",

Instead of copying why not add ",snapshot=3Don" to preserve the original
image. We don't want to persist data between tests.

>              "-device",
>              "virtio-rng-pci,rng=3Drng0",
>              "-object",
> @@ -170,13 +173,15 @@ def boot_openbsd73(self, cpu):
>=20=20
>          img_hash =3D "7fc2c75401d6f01fbfa25f4953f72ad7d7c18650056d30755c=
44b9c129b707e5"
>          img_path =3D self.fetch_asset(img_url, algorithm=3D"sha256", ass=
et_hash=3Dimg_hash)
> +        img_path_rw =3D os.path.join(self.workdir, os.path.basename(img_=
path))
> +        shutil.copy(img_path, img_path_rw)
>=20=20
>          self.vm.set_console()
>          self.vm.add_args(
>              "-cpu",
>              cpu,
>              "-drive",
> -            f"file=3D{img_path},format=3Draw",
> +            f"file=3D{img_path_rw},format=3Draw",

ditto.


>              "-device",
>              "virtio-rng-pci,rng=3Drng0",
>              "-object",
> diff --git a/tests/avocado/machine_aarch64_virt.py b/tests/avocado/machin=
e_aarch64_virt.py
> index a90dc6ff4b..093d68f837 100644
> --- a/tests/avocado/machine_aarch64_virt.py
> +++ b/tests/avocado/machine_aarch64_virt.py
> @@ -37,13 +37,13 @@ def test_alpine_virt_tcg_gic_max(self):
>          :avocado: tags=3Dmachine:virt
>          :avocado: tags=3Daccel:tcg
>          """
> -        iso_url =3D ('https://dl-cdn.alpinelinux.org/'
> -                   'alpine/v3.17/releases/aarch64/'
> -                   'alpine-standard-3.17.2-aarch64.iso')
> +        iso_url =3D (
> +            "https://dl-cdn.alpinelinux.org/"
> +            "alpine/v3.17/releases/aarch64/alpine-standard-3.17.2-aarch6=
4.iso"
> +        )
>=20=20
> -        # Alpine use sha256 so I recalculated this myself
> -        iso_sha1 =3D '76284fcd7b41fe899b0c2375ceb8470803eea839'
> -        iso_path =3D self.fetch_asset(iso_url, asset_hash=3Diso_sha1)
> +        iso_hash =3D "5a36304ecf039292082d92b48152a9ec21009d3a62f459de62=
3e19c4bd9dc027"
> +        iso_path =3D self.fetch_asset(iso_url, algorithm=3D"sha256", ass=
et_hash=3Diso_hash)
>=20=20
>          self.vm.set_console()
>          kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
> @@ -60,7 +60,7 @@ def test_alpine_virt_tcg_gic_max(self):
>          self.vm.add_args("-smp", "2", "-m", "1024")
>          self.vm.add_args('-bios', os.path.join(BUILD_DIR, 'pc-bios',
>                                                 'edk2-aarch64-code.fd'))
> -        self.vm.add_args("-drive", f"file=3D{iso_path},format=3Draw")
> +        self.vm.add_args("-drive",
>          f"file=3D{iso_path},readonly=3Don,format=3Draw")

Perhaps we can set ",media=3Dcdrom" here.

>          self.vm.add_args('-device', 'virtio-rng-pci,rng=3Drng0')
>          self.vm.add_args('-object', 'rng-random,id=3Drng0,filename=3D/de=
v/urandom')

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

