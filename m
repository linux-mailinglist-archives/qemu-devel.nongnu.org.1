Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E52C7EE1B2
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 14:41:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3cbL-0003ql-6x; Thu, 16 Nov 2023 08:40:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1r3cbI-0003qF-PM
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 08:40:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1r3cbG-0002mA-Oa
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 08:40:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700142006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+5ZaIc14sCkpR7U9ihuxHGH3RQ3ZP0FmHYDYBFzcsdg=;
 b=InUd33Te2VWa9nqe2KB3dHafe4VTF/BHiY4lfE5KANLTxsji15TJlWtWndTU7xORihfQ9Y
 Dzk0bRJEzTT6DK2JOpBRy9Nx+FkuP2Hj1nwW7EIUQwTZOm1PFs87RgsmMRZR5+F885EzUa
 kW88GlZBaenMJMzN2l0u9f2VN3z/tvA=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-ThBqGPxNPjueiYdENv0fnA-1; Thu, 16 Nov 2023 08:40:04 -0500
X-MC-Unique: ThBqGPxNPjueiYdENv0fnA-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5be154fe98bso2199161a12.0
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 05:40:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700142003; x=1700746803;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+5ZaIc14sCkpR7U9ihuxHGH3RQ3ZP0FmHYDYBFzcsdg=;
 b=AvWu7BnoCnIoW0hUb9rKuH8oBnLqn9e9uHlJAYgj+J6vZS4PS9zatjb6EufkaI9kv+
 ShWjG7C/XzfGHZwOFBkjH7oAVdc3WYMISvmVWG8yNRE0gCDFWW8jdLZQi/AWgFD7f341
 pa0kBErUud3KeXtGXmR73z5KSHowzNr3aItKu+7URJ2Jb9O5yg7EJpFR9lazfokMCYGm
 FTYdQbEU+lPv8in3wX1t2KQCnJ+oyudNDU0iEdLIl7yGvYfi7+NDj8qXDp1LH0CmeYrd
 EAR/r5Gc5qx5fgdD7XbrbXxSBztP5XfQ4nXfUcoekgYdH5E7LTO2lfGNlKpmWSCLgLZK
 CHcQ==
X-Gm-Message-State: AOJu0Yx8M5kDtw2lSO1/+l4AJ4li1nS0M8orpqVMfYolwBnvR85wdWkt
 6PpwDsLdCt1nJpSClShkkErSv40u5c3czVfVPs3334gz12SGsYCqzeIChAtrl0aCD7obg2wQGl4
 qGN5hBv2hiwlcOrI=
X-Received: by 2002:a17:902:e5cd:b0:1cc:4402:9e7c with SMTP id
 u13-20020a170902e5cd00b001cc44029e7cmr2466471plf.15.1700142003250; 
 Thu, 16 Nov 2023 05:40:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeBs0C9ldsT77Ho8mj6+g8cEuihjlTf+YByKpOtwXOVj1FKAPwSzusM+7cP0deARCIUR0UBw==
X-Received: by 2002:a17:902:e5cd:b0:1cc:4402:9e7c with SMTP id
 u13-20020a170902e5cd00b001cc44029e7cmr2466432plf.15.1700142002896; 
 Thu, 16 Nov 2023 05:40:02 -0800 (PST)
Received: from smtpclient.apple ([203.212.246.21])
 by smtp.gmail.com with ESMTPSA id
 w23-20020a170902a71700b001bc676df6a9sm9152221plq.132.2023.11.16.05.39.58
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 16 Nov 2023 05:40:02 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH 1/3] tests/avocado: reverse_debugging drain console to
 prevent hang
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <2F8B4C12-4E26-45C5-81AC-2DC7B70C92D8@redhat.com>
Date: Thu, 16 Nov 2023 19:09:47 +0530
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 =?utf-8?Q?=22Daniel_P_=2E_Berrang=C3=A9=22?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-ppc@nongnu.org, =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3E935BD3-BA4D-4812-9005-385B068AF789@redhat.com>
References: <20231116115354.228678-1-npiggin@gmail.com>
 <44B87DD4-B2FF-4061-97D6-631367D625B5@redhat.com>
 <2F8B4C12-4E26-45C5-81AC-2DC7B70C92D8@redhat.com>
To: Nicholas Piggin <npiggin@gmail.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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



> On 16-Nov-2023, at 7:01=E2=80=AFPM, Ani Sinha <anisinha@redhat.com> =
wrote:
>=20
>=20
>=20
>> On 16-Nov-2023, at 6:56=E2=80=AFPM, Ani Sinha <anisinha@redhat.com> =
wrote:
>>=20
>>=20
>>=20
>>> On 16-Nov-2023, at 5:23=E2=80=AFPM, Nicholas Piggin =
<npiggin@gmail.com> wrote:
>>>=20
>>> Like replay_linux.py, reverse_debugging.py starts the vm with =
console
>>> set but does not interact with it (e.g., with =
wait_for_console_pattern).
>>> In this situation, the console should have a drainer attached so the
>>> socket does not fill. replay_linux.py has a drainer, but it is =
missing
>>> from reverse_debugging.py.
>>>=20
>>> Per analysis in Link: this can cause the console socket/pipe to fill =
and
>>> QEMU get stuck in qemu_chr_write_buffer, leading to strange test =
case
>>> failures (ppc64 fails because it prints a lot to console in early =
bios).
>>> Attaching a drainer prevents this.
>>>=20
>>> Note, this commit does not fix bugs introduced by the commits =
referenced
>>> in the first two Fixes: tags, but together those commits conspire to
>>> irritate the problem and cause test case failure, which this commit
>>> fixes.
>>>=20
>>> Link: =
https://lore.kernel.org/qemu-devel/ZVT-bY9YOr69QTPX@redhat.com/
>>> Fixes: 1d4796cd0083 ("python/machine: use socketpair() for console =
connections")
>>> Fixes: 761a13b23946 ("tests/avocado: ppc64 reverse debugging tests =
for pseries and powernv")
>>> Fixes: be52eca30978 ("tests/acceptance: add reverse debugging test")
>>> Tested-by: Thomas Huth <thuth@redhat.com>
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>=20
>> Reviewed-by: Ani Sinha <anisinha@redhat.com =
<mailto:anisinha@redhat.com>>
>=20
> This bs started happening recently once I upgraded my OS. Sorry about =
that.
>=20
> Reviewed-by: Ani Sinha <anisinha@redhat.com =
<mailto:anisinha@redhat.com>>

Trying again=09

Reviewed-by: Ani Sinha <anisinha@redhat.com>


>=20
>=20
>>=20
>>> ---
>>> tests/avocado/reverse_debugging.py | 5 +++++
>>> 1 file changed, 5 insertions(+)
>>>=20
>>> diff --git a/tests/avocado/reverse_debugging.py =
b/tests/avocado/reverse_debugging.py
>>> index fc47874eda..128d85bc0e 100644
>>> --- a/tests/avocado/reverse_debugging.py
>>> +++ b/tests/avocado/reverse_debugging.py
>>> @@ -12,6 +12,7 @@
>>>=20
>>> from avocado import skipIf
>>> from avocado_qemu import BUILD_DIR
>>> +from avocado.utils import datadrainer
>>> from avocado.utils import gdb
>>> from avocado.utils import process
>>> from avocado.utils.network.ports import find_free_port
>>> @@ -52,6 +53,10 @@ def run_vm(self, record, shift, args, =
replay_path, image_path, port):
>>>       if args:
>>>           vm.add_args(*args)
>>>       vm.launch()
>>> +        console_drainer =3D =
datadrainer.LineLogger(vm.console_socket.fileno(),
>>> +                                    =
logger=3Dself.log.getChild('console'),
>>> +                                    stop_check=3D(lambda : not =
vm.is_running()))
>>> +        console_drainer.start()
>>>       return vm
>>>=20
>>>   @staticmethod
>>> --=20
>>> 2.42.0



