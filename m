Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2F57EDA85
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 04:57:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3TUK-0008PR-4o; Wed, 15 Nov 2023 22:56:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1r3TUI-0008PJ-8o
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 22:56:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1r3TUG-000265-Ec
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 22:56:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700106975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pKHvthyH27o+g8ws067froe+SEB8akfO9E62fULjDvI=;
 b=e/joh0YuKxRC529ONftCMvhvo1rM2425cbxTJ8IV53RYZH2aWmQBrVqiMq3vbmyTMB1hpS
 nXx+c5HA4oHh5H5MFaFytLHQFvlccCFpN6kOJk8mTL/XBVUJkBKjOzzTkE8PlRXSRMkRd2
 diSsK0yvqlC0D+Ji9QwjsBVw4q6429w=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-h0mHo4OhP76TXem9MxRNsg-1; Wed, 15 Nov 2023 22:56:13 -0500
X-MC-Unique: h0mHo4OhP76TXem9MxRNsg-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-283350d52a3so372663a91.3
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 19:56:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700106973; x=1700711773;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pKHvthyH27o+g8ws067froe+SEB8akfO9E62fULjDvI=;
 b=xUhq03pJwQ4qmj/KdRaJeMjZWX3GG3o9th4UjH7NiMZ2E6nlCAAwhMrlSbUatQb7jl
 mdX9xVXfSXy5WE7TKD/oDEMGytghKRQXzM+/FHimyAroeRNfI8w665Hxs65ewFpNEPu6
 xvPZPkC85P6ody10iVg2gw4icKQXUwOKf+VCfH4fAbwJCSQ4oB+igI6gePUeXs8DtAtx
 c9QdJ+3hzzY4UGhKoInquSRaVm6B2htwZAmD0KkbCTWzhu0ikgXKjYmnABmtp0rEx7l+
 qblw3WHmzNrEIRcFNeoth8MHtcRP++P6fNPknxkWIfZokeJ5IzHJ9wEVJQ2Iy1CO9zk+
 3QMw==
X-Gm-Message-State: AOJu0YwXTE0LG31Jug9La2QIDpzs+Vf1E+Kr4EII06AKB6bnWd5hxIzm
 7a+M1a+O55J82ZK+ZbuQ38bNT4PFhdqhN8/xIKMOFR1gp3bLpqI0wDF5h9VR1ikY6dUuvibQ5ba
 qKW/ojPBr7Y0YCNA=
X-Received: by 2002:a17:90b:3886:b0:27f:fa7a:a7b with SMTP id
 mu6-20020a17090b388600b0027ffa7a0a7bmr17886674pjb.33.1700106972579; 
 Wed, 15 Nov 2023 19:56:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsdjAiABF0oAwW4MfW3DK7X0NGyCzrali4YlmAyNSLHtPS4kuq12lE2MzIQ+9hVcWeim9I9A==
X-Received: by 2002:a17:90b:3886:b0:27f:fa7a:a7b with SMTP id
 mu6-20020a17090b388600b0027ffa7a0a7bmr17886651pjb.33.1700106972237; 
 Wed, 15 Nov 2023 19:56:12 -0800 (PST)
Received: from smtpclient.apple ([203.212.246.21])
 by smtp.gmail.com with ESMTPSA id
 gk20-20020a17090b119400b00280202c092fsm589053pjb.33.2023.11.15.19.56.08
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Nov 2023 19:56:11 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH] tests/avocado/reverse_debugging: Disable the ppc64 tests
 by default
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <CWZU7DEIX9E4.26PTZ0GK1ZAUP@wheely>
Date: Thu, 16 Nov 2023 09:25:52 +0530
Cc: =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9853904F-F5F7-4744-98B0-0B61A60DAD7B@redhat.com>
References: <20231114163115.298041-1-thuth@redhat.com>
 <12b4420e-1440-4516-8276-e0e907003c16@linaro.org>
 <9f6247e4-7e81-44f8-a63b-8ee11f722710@redhat.com>
 <CWYYRW53VEPJ.3UL1X7GB1P4H2@wheely>
 <6877d6d6-bfbf-4475-8c61-dd537265b278@redhat.com>
 <ZVTETYrfL8f48qe3@redhat.com> <ZVT-bY9YOr69QTPX@redhat.com>
 <CWZU7DEIX9E4.26PTZ0GK1ZAUP@wheely>
To: Nicholas Piggin <npiggin@gmail.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
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



> On 16-Nov-2023, at 6:45=E2=80=AFAM, Nicholas Piggin =
<npiggin@gmail.com> wrote:
>=20
> On Thu Nov 16, 2023 at 3:22 AM AEST, Daniel P. Berrang=C3=A9 wrote:
>> On Wed, Nov 15, 2023 at 01:14:53PM +0000, Daniel P. Berrang=C3=A9 =
wrote:
>>> On Wed, Nov 15, 2023 at 07:23:01AM +0100, Thomas Huth wrote:
>>>> On 15/11/2023 02.15, Nicholas Piggin wrote:
>>>>> On Wed Nov 15, 2023 at 4:29 AM AEST, Thomas Huth wrote:
>>>>>> On 14/11/2023 17.37, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>>>> On 14/11/23 17:31, Thomas Huth wrote:
>>>>>>>> The tests seem currently to be broken. Disable them by default
>>>>>>>> until someone fixes them.
>>>>>>>>=20
>>>>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>>>>> ---
>>>>>>>>   tests/avocado/reverse_debugging.py | 7 ++++---
>>>>>>>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>>>>>>=20
>>>>>>> Similarly, I suspect =
https://gitlab.com/qemu-project/qemu/-/issues/1961
>>>>>>> which has a fix ready:
>>>>>>> =
https://lore.kernel.org/qemu-devel/20231110170831.185001-1-richard.henders=
on@linaro.org/
>>>>>>>=20
>>>>>>> Maybe wait the fix gets in first?
>>>>>>=20
>>>>>> No, I applied Richard's patch, but the problem persists. Does =
this test
>>>>>> still work for you?
>>>>>=20
>>>>> I bisected it to 1d4796cd008373 ("python/machine: use socketpair() =
for
>>>>> console connections"),
>>>>=20
>>>> Maybe John (who wrote that commit) can help?
>>>=20
>>> I find it hard to believe this commit is a direct root cause of the
>>> problem since all it does is change the QEMU startup sequence so =
that
>>> instead of QEMU listening for a monitor connection, it is given a
>>> pre-opened monitor connection.
>>>=20
>>> At the very most that should affect the startup timing a little.
>>>=20
>>> I notice all the reverse debugging tests have a skip on gitlab
>>> with a comment:
>>>=20
>>>    # unidentified gitlab timeout problem
>>>=20
>>> this makes be suspicious that John's patch has merely made this
>>> (henceforth undiagnosed) timeout more likely to ocurr.
>>=20
>> After an absolutely horrendous hours long debugging session I think
>> I figured out the problem. The QEMU process is blocking in
>>=20
>>    qemu_chr_write_buffer
>>=20
>> spinning in the loop on EAGAIN.
>=20
> Great work.
>=20
> Why does this make the gdb socket give an empty response? Something
> just times out?
>=20
>>=20
>> The Python  Machine() class has passed one of a pre-created =
socketpair
>> FDs for the serial port chardev. The guest is trying to write to this
>> and blocking.  Nothing in the Machine() class is reading from the
>> other end of the serial port console.
>>=20
>>=20
>> Before John's change, the serial port uses a chardev in server mode
>> and crucially  'wait=3Doff', and the Machine() class never opened the
>> console socket unless the test case wanted to read from it.
>>=20
>> IOW, QEMU had a background job setting there waiting for a connection
>> that would never come.
>>=20
>> As a result when QEMU started executing the guest, all the serial =
port
>> writes get sent into to the void.
>>=20
>>=20
>> So John's patch has had a semantic change in behaviour, because the
>> console socket is permanently open, and thus socket buffers are =
liable
>> to fill up.
>>=20
>> As a demo I increased the socket buffers to 1MB and everything then
>> succeeded.
>>=20
>> @@ -357,6 +360,10 @@ def _pre_launch(self) -> None:
>>=20
>>         if self._console_set:
>>             self._cons_sock_pair =3D socket.socketpair()
>> +            self._cons_sock_pair[0].setsockopt(socket.SOL_SOCKET, =
socket.SO_SNDBUF, 1024*1024);
>> +            self._cons_sock_pair[0].setsockopt(socket.SOL_SOCKET, =
socket.SO_RCVBUF, 1024*1024);
>> +            self._cons_sock_pair[1].setsockopt(socket.SOL_SOCKET, =
socket.SO_SNDBUF, 1024*1024);
>> +            self._cons_sock_pair[1].setsockopt(socket.SOL_SOCKET, =
socket.SO_RCVBUF, 1024*1024);
>>             os.set_inheritable(self._cons_sock_pair[0].fileno(), =
True)
>>=20
>>         # NOTE: Make sure any opened resources are *definitely* freed =
in
>=20
> So perhaps ppc64 fails just because it prints more to the console in =
early
> boot than other targets?
>=20
>> The Machine class doesn't know if anything will ever use the console,
>> so as is the change is unsafe.
>>=20
>> The original goal of John's change was to guarantee we capture early
>> boot messages as some test need that. =20
>>=20
>> I think we need to be able to have a flag to say whether the caller =
needs
>> an "early console" facility, and only use the pre-opened FD passing =
for
>> that case. Tests we need early console will have to ask for that =
guarantee
>> explicitly.
>=20
> The below patch makes this test work. Maybe as a quick fix it is
> better than disabling the test.
>=20
> I guess we still have a problem if a test invokes vm.launch()
> directly without subsequently waiting for a console pattern or
> doing something with the console as you say. Your suggesstion is
> add something like vm.launch(console=3DTrue) ?=20

I think what he is saying is to add a new property for QEMUMachine() =
with which the test can explicitly tell the machine init code that it is =
going to drain the console logs. By default it can be false. When tests =
use console_drainer, they can set the property to true and inspect the =
early console logs after draining it.=20

>=20
> Thanks,
> Nick
> ---
>=20
> diff --git a/tests/avocado/reverse_debugging.py =
b/tests/avocado/reverse_debugging.py
> index fc47874eda..128d85bc0e 100644
> --- a/tests/avocado/reverse_debugging.py
> +++ b/tests/avocado/reverse_debugging.py
> @@ -12,6 +12,7 @@
>=20
> from avocado import skipIf
> from avocado_qemu import BUILD_DIR
> +from avocado.utils import datadrainer
> from avocado.utils import gdb
> from avocado.utils import process
> from avocado.utils.network.ports import find_free_port
> @@ -52,6 +53,10 @@ def run_vm(self, record, shift, args, replay_path, =
image_path, port):
>         if args:
>             vm.add_args(*args)
>         vm.launch()
> +        console_drainer =3D =
datadrainer.LineLogger(vm.console_socket.fileno(),
> +                                    =
logger=3Dself.log.getChild('console'),
> +                                    stop_check=3D(lambda : not =
vm.is_running()))
> +        console_drainer.start()
>         return vm
>=20
>     @staticmethod



