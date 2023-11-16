Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 280AB7EDBD0
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 08:15:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Waa-0007kf-Gb; Thu, 16 Nov 2023 02:15:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r3WaV-0007jV-Gu; Thu, 16 Nov 2023 02:14:55 -0500
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r3WaT-0002GW-EX; Thu, 16 Nov 2023 02:14:55 -0500
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-1eb7a8e9dd0so226732fac.3; 
 Wed, 15 Nov 2023 23:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700118891; x=1700723691; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AjXyJ4ATkw1YiIMNkwLAx39Z4RgeIC8eluChYbPXjQ0=;
 b=Kg6A+omu6JbYZd12W75xSjmF4o4nyGUWTQSq1MiaS1wkGtnhLedHlzbDXQoAo+ye4b
 1I/tDvRxQDm+Q0oQ3iLhr1KMS3s8zdQO1ZlBMBn1wLTQ/A+i4FkN6QfS+/S2qVhnlwvq
 /Yn2qN7vdfE85dX+TbQBWChF5eOKI94ELwZhAS1BHlwR5ma/h1rYuYXhWydGT2CIV9mB
 98HU7Cg6kR9ysulPQGdFR/IAJN9bC4myxlVLce6G/dwZmeS1PO/xx2coRP61ySXfH9xE
 NXZ5TTvTK2oBoWYIgLuW8znVZVnnHrutfJd9+D/5P1VUe2SEj6hXT1AEJN/0JE2jw7Rw
 ZPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700118891; x=1700723691;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AjXyJ4ATkw1YiIMNkwLAx39Z4RgeIC8eluChYbPXjQ0=;
 b=Ywnq+xzLeUxkel5hjaoyOL9aLT77i70MJ45Z3eCJAC+tRul3nX/WhObF3WHzulMhHS
 FH/SIPhGFJ6gwYBxhKTdeIsrh73Rc+BzbJLB1udBe9WjF7eR9nbk6HNxwoLVIvTcobcm
 WcxQDDM4QW1v8DmclyVesHLfHkzDPiVEDXO7V4cyib743lSttfvwO64iKolMqw49OROG
 iwZwHExgNQgAD8GvlLpYdJYMC3gsVnD6DwIp9vgADz79E9EW905f1QvTFJCs4cfUmAHF
 If07gfXOKZ6iI7sWIACp2/QXPACmsGAH+o5H+mhvIcr7CUuvEo9Vvnl/mFUCBgOuStFp
 VWsQ==
X-Gm-Message-State: AOJu0Yx/Kn7mSfMOjenjJ3lyT292Asm0cNjp4ke7KC8VoqXSsfFjstP5
 y/XqnubQd/bRP3zOdkIzNV0=
X-Google-Smtp-Source: AGHT+IGoODpiVoTaLhljo2dRzfhbvOxTzUSpeQRbfuhI90G/chddh0MVvrVYjN1ZDsQpe8Z9siJK8A==
X-Received: by 2002:a05:6871:5289:b0:1d6:cbcd:80f8 with SMTP id
 hu9-20020a056871528900b001d6cbcd80f8mr20768361oac.54.1700118891630; 
 Wed, 15 Nov 2023 23:14:51 -0800 (PST)
Received: from localhost (121-44-82-40.tpgi.com.au. [121.44.82.40])
 by smtp.gmail.com with ESMTPSA id
 fj35-20020a056a003a2300b006c34a39eeb9sm3845239pfb.218.2023.11.15.23.14.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 23:14:51 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Nov 2023 17:14:43 +1000
Message-Id: <CX01UGZ8PCU9.1TMVG7FPP29YF@wheely>
Cc: =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, "Thomas
 Huth" <thuth@redhat.com>, "John Snow" <jsnow@redhat.com>, "Wainer dos
 Santos Moschetta" <wainersm@redhat.com>, "Beraldo Leal" <bleal@redhat.com>,
 "Cleber Rosa" <crosa@redhat.com>, "Pavel Dovgalyuk"
 <pavel.dovgaluk@ispras.ru>, "Paolo Bonzini" <pbonzini@redhat.com>,
 <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] tests/avocado/reverse_debugging: Disable the ppc64
 tests by default
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Ani Sinha" <anisinha@redhat.com>
X-Mailer: aerc 0.15.2
References: <20231114163115.298041-1-thuth@redhat.com>
 <12b4420e-1440-4516-8276-e0e907003c16@linaro.org>
 <9f6247e4-7e81-44f8-a63b-8ee11f722710@redhat.com>
 <CWYYRW53VEPJ.3UL1X7GB1P4H2@wheely>
 <6877d6d6-bfbf-4475-8c61-dd537265b278@redhat.com>
 <ZVTETYrfL8f48qe3@redhat.com> <ZVT-bY9YOr69QTPX@redhat.com>
 <CWZU7DEIX9E4.26PTZ0GK1ZAUP@wheely>
 <9853904F-F5F7-4744-98B0-0B61A60DAD7B@redhat.com>
In-Reply-To: <9853904F-F5F7-4744-98B0-0B61A60DAD7B@redhat.com>
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=npiggin@gmail.com; helo=mail-oa1-x33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu Nov 16, 2023 at 1:55 PM AEST, Ani Sinha wrote:
>
>
> > On 16-Nov-2023, at 6:45=E2=80=AFAM, Nicholas Piggin <npiggin@gmail.com>=
 wrote:
> >=20
> > On Thu Nov 16, 2023 at 3:22 AM AEST, Daniel P. Berrang=C3=A9 wrote:
> >> On Wed, Nov 15, 2023 at 01:14:53PM +0000, Daniel P. Berrang=C3=A9 wrot=
e:
> >>> On Wed, Nov 15, 2023 at 07:23:01AM +0100, Thomas Huth wrote:
> >>>> On 15/11/2023 02.15, Nicholas Piggin wrote:
> >>>>> On Wed Nov 15, 2023 at 4:29 AM AEST, Thomas Huth wrote:
> >>>>>> On 14/11/2023 17.37, Philippe Mathieu-Daud=C3=A9 wrote:
> >>>>>>> On 14/11/23 17:31, Thomas Huth wrote:
> >>>>>>>> The tests seem currently to be broken. Disable them by default
> >>>>>>>> until someone fixes them.
> >>>>>>>>=20
> >>>>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >>>>>>>> ---
> >>>>>>>>   tests/avocado/reverse_debugging.py | 7 ++++---
> >>>>>>>>   1 file changed, 4 insertions(+), 3 deletions(-)
> >>>>>>>=20
> >>>>>>> Similarly, I suspect https://gitlab.com/qemu-project/qemu/-/issue=
s/1961
> >>>>>>> which has a fix ready:
> >>>>>>> https://lore.kernel.org/qemu-devel/20231110170831.185001-1-richar=
d.henderson@linaro.org/
> >>>>>>>=20
> >>>>>>> Maybe wait the fix gets in first?
> >>>>>>=20
> >>>>>> No, I applied Richard's patch, but the problem persists. Does this=
 test
> >>>>>> still work for you?
> >>>>>=20
> >>>>> I bisected it to 1d4796cd008373 ("python/machine: use socketpair() =
for
> >>>>> console connections"),
> >>>>=20
> >>>> Maybe John (who wrote that commit) can help?
> >>>=20
> >>> I find it hard to believe this commit is a direct root cause of the
> >>> problem since all it does is change the QEMU startup sequence so that
> >>> instead of QEMU listening for a monitor connection, it is given a
> >>> pre-opened monitor connection.
> >>>=20
> >>> At the very most that should affect the startup timing a little.
> >>>=20
> >>> I notice all the reverse debugging tests have a skip on gitlab
> >>> with a comment:
> >>>=20
> >>>    # unidentified gitlab timeout problem
> >>>=20
> >>> this makes be suspicious that John's patch has merely made this
> >>> (henceforth undiagnosed) timeout more likely to ocurr.
> >>=20
> >> After an absolutely horrendous hours long debugging session I think
> >> I figured out the problem. The QEMU process is blocking in
> >>=20
> >>    qemu_chr_write_buffer
> >>=20
> >> spinning in the loop on EAGAIN.
> >=20
> > Great work.
> >=20
> > Why does this make the gdb socket give an empty response? Something
> > just times out?
> >=20
> >>=20
> >> The Python  Machine() class has passed one of a pre-created socketpair
> >> FDs for the serial port chardev. The guest is trying to write to this
> >> and blocking.  Nothing in the Machine() class is reading from the
> >> other end of the serial port console.
> >>=20
> >>=20
> >> Before John's change, the serial port uses a chardev in server mode
> >> and crucially  'wait=3Doff', and the Machine() class never opened the
> >> console socket unless the test case wanted to read from it.
> >>=20
> >> IOW, QEMU had a background job setting there waiting for a connection
> >> that would never come.
> >>=20
> >> As a result when QEMU started executing the guest, all the serial port
> >> writes get sent into to the void.
> >>=20
> >>=20
> >> So John's patch has had a semantic change in behaviour, because the
> >> console socket is permanently open, and thus socket buffers are liable
> >> to fill up.
> >>=20
> >> As a demo I increased the socket buffers to 1MB and everything then
> >> succeeded.
> >>=20
> >> @@ -357,6 +360,10 @@ def _pre_launch(self) -> None:
> >>=20
> >>         if self._console_set:
> >>             self._cons_sock_pair =3D socket.socketpair()
> >> +            self._cons_sock_pair[0].setsockopt(socket.SOL_SOCKET, soc=
ket.SO_SNDBUF, 1024*1024);
> >> +            self._cons_sock_pair[0].setsockopt(socket.SOL_SOCKET, soc=
ket.SO_RCVBUF, 1024*1024);
> >> +            self._cons_sock_pair[1].setsockopt(socket.SOL_SOCKET, soc=
ket.SO_SNDBUF, 1024*1024);
> >> +            self._cons_sock_pair[1].setsockopt(socket.SOL_SOCKET, soc=
ket.SO_RCVBUF, 1024*1024);
> >>             os.set_inheritable(self._cons_sock_pair[0].fileno(), True)
> >>=20
> >>         # NOTE: Make sure any opened resources are *definitely* freed =
in
> >=20
> > So perhaps ppc64 fails just because it prints more to the console in ea=
rly
> > boot than other targets?
> >=20
> >> The Machine class doesn't know if anything will ever use the console,
> >> so as is the change is unsafe.
> >>=20
> >> The original goal of John's change was to guarantee we capture early
> >> boot messages as some test need that. =20
> >>=20
> >> I think we need to be able to have a flag to say whether the caller ne=
eds
> >> an "early console" facility, and only use the pre-opened FD passing fo=
r
> >> that case. Tests we need early console will have to ask for that guara=
ntee
> >> explicitly.
> >=20
> > The below patch makes this test work. Maybe as a quick fix it is
> > better than disabling the test.
> >=20
> > I guess we still have a problem if a test invokes vm.launch()
> > directly without subsequently waiting for a console pattern or
> > doing something with the console as you say. Your suggesstion is
> > add something like vm.launch(console=3DTrue) ?=20
>
> I think what he is saying is to add a new property for QEMUMachine() with=
 which the test can explicitly tell the machine init code that it is going =
to drain the console logs. By default it can be false. When tests use conso=
le_drainer, they can set the property to true and inspect the early console=
 logs after draining it.=20

Hmm... well we do have QEMUMachine.set_console already. Is this enough?
If the test case is not going to drain or interact with the console
then it could set it to false. Or am I missing something?

Thanks,
Nick

