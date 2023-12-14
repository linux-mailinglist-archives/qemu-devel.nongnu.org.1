Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65696812CEE
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 11:31:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDiyt-0005Vj-Fw; Thu, 14 Dec 2023 05:30:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rDiyq-0005VA-2k
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 05:30:12 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rDiyo-00088Y-5E
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 05:30:11 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40c1e3ea2f2so77418335e9.2
 for <qemu-devel@nongnu.org>; Thu, 14 Dec 2023 02:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702549808; x=1703154608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uOVO+bfnnJKpEsOHryNuWrr2usdamUm/q/5hMMN7t4I=;
 b=NHxvu6EsC6qnJrBftUulNFXD4Q3sxxoLc7qK0+B6sSNkbMWOGyaV938P98JCO6dyGw
 I2g3UGWLH7cK2hg3RES52N1PPR8sQaZVSOOQEd3wBAYW/0jVGxk7DQbK8xJI+qzj9Ez/
 eY7oJZigBbRVKy2Dcl4xRj3em083O4HYqKHVbgwc0pEm26IYmALroVCBgHI1fcVO2IXr
 l5Izi8VD5tZaJwXNn+/pSZyR7bmDomswewf1E+MK61hCv6qLq16w0xjCEEI/OmpIresl
 VC7Fgz3Nz/omeSz7qhvx7zxRjXtF7Ix0XZu5YCiaMvDMqzzWRnxGSla6w7osaUGBogLO
 M4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702549808; x=1703154608;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uOVO+bfnnJKpEsOHryNuWrr2usdamUm/q/5hMMN7t4I=;
 b=qXfox8O1oNwnFJ9dctgjYQVx1Ys+XJpJcOGUVkCzUFAMy/ZEqPJAbO6UM/TlkiRY3g
 V37AxxFUtQj79yguHqvaZdJ6ZYNdILwjb0vF7BbfUsCwvELMkuXNl+imjRQaiap3x+Lh
 KkCZRsEqrL+xu+KfPVqtop2znq/T0GLqK+734YSEt41K9p0rqtF//2nYjSxazGTkOJZN
 7bgXIUZDzJj/j8OgEbFeHGALKd5d7zFTpAerXSHPhDGUZPmz2HPr89lc/FlD3+6r80SH
 T/vP7TEpq4FOZTVbFvCz5enVINrvVqbADTgyawUImPzE4lsWSjZ9+tsAgrScByyvTh5c
 6RWA==
X-Gm-Message-State: AOJu0YypsThBeKbMCij3qyEpJiGI+GfMjunKZi3LcBSm7ECAXBk4tvkS
 +QZ2YHeptG9n+FLP+xIfHKJq0w==
X-Google-Smtp-Source: AGHT+IGfGsKpkGfYhg49s8Yquwu96sYE4oPzI7EF/ZouNO4OCHspwjlC8bcFEg/vs/gJgAL1beDnrQ==
X-Received: by 2002:a7b:cb95:0:b0:40c:9fa:592f with SMTP id
 m21-20020a7bcb95000000b0040c09fa592fmr5374387wmi.104.1702549808302; 
 Thu, 14 Dec 2023 02:30:08 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 m27-20020a05600c3b1b00b0040b38292253sm26513051wms.30.2023.12.14.02.30.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 02:30:07 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 838705F7D3;
 Thu, 14 Dec 2023 10:30:07 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Cleber Rosa <crosa@redhat.com>
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 qemu-devel@nongnu.org,  Jiaxun Yang <jiaxun.yang@flygoat.com>,  Radoslaw
 Biernacki <rad@semihalf.com>,  Paul Durrant <paul@xen.org>,  Akihiko Odaki
 <akihiko.odaki@daynix.com>,  Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  kvm@vger.kernel.org,  qemu-arm@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Beraldo Leal
 <bleal@redhat.com>,  Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,  David Woodhouse
 <dwmw2@infradead.org>
Subject: Re: [PATCH 04/10] tests/avocado: machine aarch64: standardize
 location and RO/RW access
In-Reply-To: <87le9xvmto.fsf@p1.localdomain> (Cleber Rosa's message of "Wed,
 13 Dec 2023 16:01:39 -0500")
References: <20231208190911.102879-1-crosa@redhat.com>
 <20231208190911.102879-5-crosa@redhat.com>
 <2972842d-e4bf-49eb-9d72-01b8049f18bf@linaro.org>
 <87le9xvmto.fsf@p1.localdomain>
User-Agent: mu4e 1.11.26; emacs 29.1
Date: Thu, 14 Dec 2023 10:30:07 +0000
Message-ID: <87r0jp84b4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

> Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org> writes:
>
>> W dniu 8.12.2023 o=C2=A020:09, Cleber Rosa pisze:
>>> The tests under machine_aarch64_virt.py do not need read-write access
>>> to the ISOs.  The ones under machine_aarch64_sbsaref.py, on the other
>>> hand, will need read-write access, so let's give each test an unique
>>> file.
>>>=20
>>> And while at it, let's use a single code style and hash for the ISO
>>> url.
>>>=20
>>> Signed-off-by: Cleber Rosa<crosa@redhat.com>
>>
>> It is ISO file, so sbsa-ref tests should be fine with readonly as well.
>>
>> Nothing gets installed so nothing is written. We only test does boot wor=
ks.
>
> That was my original expectation too.  But, with nothing but the
> following change:
>
> diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/mac=
hine_aarch64_sbsaref.py
> index 528c7d2934..436da4b156 100644
> --- a/tests/avocado/machine_aarch64_sbsaref.py
> +++ b/tests/avocado/machine_aarch64_sbsaref.py
> @@ -129,7 +129,7 @@ def boot_alpine_linux(self, cpu):
>              "-cpu",
>              cpu,
>              "-drive",
> -            f"file=3D{iso_path},format=3Draw",
> +            f"file=3D{iso_path},readonly=3Don,format=3Draw",

               f"file=3D{iso_path},readonly=3Don,media=3Dcdrom,format=3Draw=
",

works (although possible the readonly is redundant in this case).

>              "-device",
>              "virtio-rng-pci,rng=3Drng0",
>              "-object",
>
> We get:
>
> 15:55:10 DEBUG| VM launch command: './qemu-system-aarch64 -display none -=
vga none -chardev socket,id=3Dmon,fd=3D15 -mon chardev=3Dmon,mode=3Dcontrol=
 -machine sbsa-ref -
> chardev socket,id=3Dconsole,fd=3D20 -serial chardev:console -cpu cortex-a=
57 -drive if=3Dpflash,file=3D/home/cleber/avocado/job-results/job-2023-12-1=
3T15.55-28ef2b5/test
> -results/tmp_dirx8p5xzt4/1-tests_avocado_machine_aarch64_sbsaref.py_Aarch=
64SbsarefMachine.test_sbsaref_alpine_linux_cortex_a57/SBSA_FLASH0.fd,format=
=3Draw -drive=20
> if=3Dpflash,file=3D/home/cleber/avocado/job-results/job-2023-12-13T15.55-=
28ef2b5/test-results/tmp_dirx8p5xzt4/1-tests_avocado_machine_aarch64_sbsare=
f.py_Aarch64Sbsa
> refMachine.test_sbsaref_alpine_linux_cortex_a57/SBSA_FLASH1.fd,format=3Dr=
aw -smp 1 -machine sbsa-ref -cpu cortex-a57 -drive file=3D/home/cleber/avoc=
ado/data/cache/b
> y_location/0154b7cd3a4f5e135299060c8cabbeec10b70b6d/alpine-standard-3.17.=
2-aarch64.iso,readonly=3Don,format=3Draw -device virtio-rng-pci,rng=3Drng0 =
-object rng-random
> ,id=3Drng0,filename=3D/dev/urandom'
>
> Followed by:
>
> 15:55:10 DEBUG| Failed to establish session:
>   | Traceback (most recent call last):
>   |   File "/home/cleber/src/qemu/python/qemu/qmp/protocol.py", line 425,=
 in _session_guard
>   |     await coro
>   |   File "/home/cleber/src/qemu/python/qemu/qmp/qmp_client.py", line 25=
3, in _establish_session
>   |     await self._negotiate()
>   |   File "/home/cleber/src/qemu/python/qemu/qmp/qmp_client.py", line 30=
5, in _negotiate
>   |     reply =3D await self._recv()
>   |             ^^^^^^^^^^^^^^^^^^
>   |   File "/home/cleber/src/qemu/python/qemu/qmp/protocol.py", line 1009=
, in _recv
>   |     message =3D await self._do_recv()
>   |               ^^^^^^^^^^^^^^^^^^^^^
>   |   File "/home/cleber/src/qemu/python/qemu/qmp/qmp_client.py", line 40=
2, in _do_recv
>   |     msg_bytes =3D await self._readline()
>   |                 ^^^^^^^^^^^^^^^^^^^^^^
>   |   File "/home/cleber/src/qemu/python/qemu/qmp/protocol.py", line 977,=
 in _readline
>   |     raise EOFError
>   | EOFError
>
> With qemu-system-arch producing on stdout:
>
>    qemu-system-aarch64: Block node is read-only
>
> Any ideas on the reason or cause?
>
> Thanks,
> - Cleber.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

