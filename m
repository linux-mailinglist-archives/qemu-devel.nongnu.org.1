Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4950812081
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 22:16:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDWYr-0004hU-I7; Wed, 13 Dec 2023 16:14:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1rDWYp-0004h6-49
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 16:14:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1rDWYm-0004cC-23
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 16:14:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702502067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dv+BwqU9G5p6t/Y+G3miUUTURJX1TKXf0664e8KgZsU=;
 b=K7EJ2icwAnsvYKyMEKk4ND/YpbXAdcyGJ/fBb2vMcGU4zPzdyG862Yb7jxK2a81imD3Pag
 e4xLBOohUch/U6GjKjPA0JGDl45K3LUbTQUOlboPd4QDU1nnWfge4Tc95DPqaB1KevCSHM
 JL/EXy/8IJaq89fqr9796WZFx2mIfK8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-czLEbr1nMc2OSSgy0b-KvA-1; Wed, 13 Dec 2023 16:14:22 -0500
X-MC-Unique: czLEbr1nMc2OSSgy0b-KvA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6BE12185A781;
 Wed, 13 Dec 2023 21:14:21 +0000 (UTC)
Received: from p1.localdomain.some.host.somewhere.org
 (ovpn-114-21.gru2.redhat.com [10.97.114.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A08D22166B31;
 Wed, 13 Dec 2023 21:14:13 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>, Radoslaw
 Biernacki <rad@semihalf.com>, Paul Durrant <paul@xen.org>, Akihiko Odaki
 <akihiko.odaki@daynix.com>, Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, kvm@vger.kernel.org, qemu-arm@nongnu.org, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Beraldo Leal
 <bleal@redhat.com>, Wainer
 dos Santos Moschetta <wainersm@redhat.com>, Sriram Yagnaraman
 <sriram.yagnaraman@est.tech>, Marcin Juszkiewicz
 <marcin.juszkiewicz@linaro.org>, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 04/10] tests/avocado: machine aarch64: standardize
 location and RO/RW access
In-Reply-To: <87wmtkeils.fsf@draig.linaro.org>
References: <20231208190911.102879-1-crosa@redhat.com>
 <20231208190911.102879-5-crosa@redhat.com>
 <87wmtkeils.fsf@draig.linaro.org>
Date: Wed, 13 Dec 2023 16:14:03 -0500
Message-ID: <87h6klvm90.fsf@p1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Cleber Rosa <crosa@redhat.com> writes:
>
>> The tests under machine_aarch64_virt.py do not need read-write access
>> to the ISOs.  The ones under machine_aarch64_sbsaref.py, on the other
>> hand, will need read-write access, so let's give each test an unique
>> file.
>
> I think we are making two separate changes here so probably best split
> the patch.
>

Sure, but, do you mean separating the "readonly=3Don" and the "writable
file" changes?  Or separating those two from the ISO url code style
change?

>> And while at it, let's use a single code style and hash for the ISO
>> url.
>>
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> ---
>>  tests/avocado/machine_aarch64_sbsaref.py |  9 +++++++--
>>  tests/avocado/machine_aarch64_virt.py    | 14 +++++++-------
>>  2 files changed, 14 insertions(+), 9 deletions(-)
>>
>> diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/ma=
chine_aarch64_sbsaref.py
>> index 528c7d2934..6ae84d77ac 100644
>> --- a/tests/avocado/machine_aarch64_sbsaref.py
>> +++ b/tests/avocado/machine_aarch64_sbsaref.py
>> @@ -7,6 +7,7 @@
>>  # SPDX-License-Identifier: GPL-2.0-or-later
>>=20=20
>>  import os
>> +import shutil
>>=20=20
>>  from avocado import skipUnless
>>  from avocado.utils import archive
>> @@ -123,13 +124,15 @@ def boot_alpine_linux(self, cpu):
>>=20=20
>>          iso_hash =3D "5a36304ecf039292082d92b48152a9ec21009d3a62f459de6=
23e19c4bd9dc027"
>>          iso_path =3D self.fetch_asset(iso_url, algorithm=3D"sha256", as=
set_hash=3Diso_hash)
>> +        iso_path_rw =3D os.path.join(self.workdir, os.path.basename(iso=
_path))
>> +        shutil.copy(iso_path, iso_path_rw)
>>=20=20
>>          self.vm.set_console()
>>          self.vm.add_args(
>>              "-cpu",
>>              cpu,
>>              "-drive",
>> -            f"file=3D{iso_path},format=3Draw",
>> +            f"file=3D{iso_path_rw},format=3Draw",
>
> Instead of copying why not add ",snapshot=3Don" to preserve the original
> image. We don't want to persist data between tests.
>
>>              "-device",
>>              "virtio-rng-pci,rng=3Drng0",
>>              "-object",
>> @@ -170,13 +173,15 @@ def boot_openbsd73(self, cpu):
>>=20=20
>>          img_hash =3D "7fc2c75401d6f01fbfa25f4953f72ad7d7c18650056d30755=
c44b9c129b707e5"
>>          img_path =3D self.fetch_asset(img_url, algorithm=3D"sha256", as=
set_hash=3Dimg_hash)
>> +        img_path_rw =3D os.path.join(self.workdir, os.path.basename(img=
_path))
>> +        shutil.copy(img_path, img_path_rw)
>>=20=20
>>          self.vm.set_console()
>>          self.vm.add_args(
>>              "-cpu",
>>              cpu,
>>              "-drive",
>> -            f"file=3D{img_path},format=3Draw",
>> +            f"file=3D{img_path_rw},format=3Draw",
>
> ditto.
>
>
>>              "-device",
>>              "virtio-rng-pci,rng=3Drng0",
>>              "-object",
>> diff --git a/tests/avocado/machine_aarch64_virt.py b/tests/avocado/machi=
ne_aarch64_virt.py
>> index a90dc6ff4b..093d68f837 100644
>> --- a/tests/avocado/machine_aarch64_virt.py
>> +++ b/tests/avocado/machine_aarch64_virt.py
>> @@ -37,13 +37,13 @@ def test_alpine_virt_tcg_gic_max(self):
>>          :avocado: tags=3Dmachine:virt
>>          :avocado: tags=3Daccel:tcg
>>          """
>> -        iso_url =3D ('https://dl-cdn.alpinelinux.org/'
>> -                   'alpine/v3.17/releases/aarch64/'
>> -                   'alpine-standard-3.17.2-aarch64.iso')
>> +        iso_url =3D (
>> +            "https://dl-cdn.alpinelinux.org/"
>> +            "alpine/v3.17/releases/aarch64/alpine-standard-3.17.2-aarch=
64.iso"
>> +        )
>>=20=20
>> -        # Alpine use sha256 so I recalculated this myself
>> -        iso_sha1 =3D '76284fcd7b41fe899b0c2375ceb8470803eea839'
>> -        iso_path =3D self.fetch_asset(iso_url, asset_hash=3Diso_sha1)
>> +        iso_hash =3D "5a36304ecf039292082d92b48152a9ec21009d3a62f459de6=
23e19c4bd9dc027"
>> +        iso_path =3D self.fetch_asset(iso_url, algorithm=3D"sha256", as=
set_hash=3Diso_hash)
>>=20=20
>>          self.vm.set_console()
>>          kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
>> @@ -60,7 +60,7 @@ def test_alpine_virt_tcg_gic_max(self):
>>          self.vm.add_args("-smp", "2", "-m", "1024")
>>          self.vm.add_args('-bios', os.path.join(BUILD_DIR, 'pc-bios',
>>                                                 'edk2-aarch64-code.fd'))
>> -        self.vm.add_args("-drive", f"file=3D{iso_path},format=3Draw")
>> +        self.vm.add_args("-drive",
>>          f"file=3D{iso_path},readonly=3Don,format=3Draw")
>
> Perhaps we can set ",media=3Dcdrom" here.
>

Yes, but more importantly, adding both "readonly=3Don" and "media=3Dcdrom"
to the tests under machine_aarch64_sbsaref.py do the trick.  Now, the
behavior explained in my previous response still warrants investigation
IMO.

Thanks
- Cleber.


