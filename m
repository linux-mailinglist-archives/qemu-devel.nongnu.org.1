Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F137F5643
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 03:05:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5z58-0003g5-FM; Wed, 22 Nov 2023 21:04:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r5z55-0003fU-2O; Wed, 22 Nov 2023 21:04:39 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r5z53-0004vm-3H; Wed, 22 Nov 2023 21:04:38 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1cc0d0a0355so2877815ad.3; 
 Wed, 22 Nov 2023 18:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700705073; x=1701309873; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P1WrsGg6Vog7fKDadMy+uk9hjaNG0cUIk1NjBg41iKU=;
 b=g6fUnzx+aYcCOpRhRNmyr+3pnfOfqv6es2CWnG2X+GZkONpj31SG9wth0Gm54N4GBM
 6S7qvR5RgEMYhBLDQOs567tpJtVNbs1iKcoh9/QVH3wfC4vu/6ZqiWL1IDRLMh0ADXon
 bymecyKPtOmWnZk2/0Vf4N60I6QZRIH/60OdMKyo4vU4fOcUDYAM4N7jb4pGNvbmQX8K
 XnfbWKmqHd5cVzX5ZEg3oC/DqU+3jeqL6peqMTk1Dqi5JWxLB+O4z3PgcjNApHGa29gx
 3/oqHBq06/cnx4T9qInqWBUuKn6P2DZPT5xtQ3/Q3UPKbuvOaUb6eNlAzyPBFZ6/voyC
 h3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700705073; x=1701309873;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=P1WrsGg6Vog7fKDadMy+uk9hjaNG0cUIk1NjBg41iKU=;
 b=XgTCUnlMpzpn3RPS3YTP2gOJy2OO8w49/ErIhxPVYc0acFQE+DZvI6VWCIRwcVi6/n
 9jyE+NT6FNJoUeWVtggiH7oTjBtKPLsy7ks6UiiZS7elhAACc6cj83/K7wt1n/iXUa2/
 gXcLEZCjSubyhTPhqMw1D23KZC+i/eTHWPHrTghm1T3/Vo0qUPdO0TjGrRnJau5uBU5b
 entpDcIGTE3KPfRifEkK7mkyvydyQchhLFrW2RckoZmuoFvBhS80qxK9dUX7a6c08xxj
 AdpdsSNAwYMyytnnFVU2dvUD/cLzJq8nvfBQ7Hp+KdERCkO+EEGfCa8Nrj42ITwQ0eB3
 kWJg==
X-Gm-Message-State: AOJu0YytFpdNW/1Lt+IlFNn6IQnNAa91J8xvUoJjF9LFvTRbuBZBIsv7
 tsaNBJBFMjDIj3cyqmkw3/M=
X-Google-Smtp-Source: AGHT+IGJEHDsdTFJDUNllurnOil4K92tEV0d4YaSlbUH2mIBPUTkmphNNY/urq+xlWUNPNBTwFuTCA==
X-Received: by 2002:a17:903:1251:b0:1ce:654a:81e2 with SMTP id
 u17-20020a170903125100b001ce654a81e2mr4630093plh.16.1700705073261; 
 Wed, 22 Nov 2023 18:04:33 -0800 (PST)
Received: from localhost (60-240-124-93.tpgi.com.au. [60.240.124.93])
 by smtp.gmail.com with ESMTPSA id
 v2-20020a170902d68200b001cc530c495asm92713ply.113.2023.11.22.18.04.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Nov 2023 18:04:32 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Nov 2023 12:04:24 +1000
Message-Id: <CX5TMOWS9X9Y.366BHVH1CM2OQ@wheely>
To: "John Snow" <jsnow@redhat.com>, =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
 <berrange@redhat.com>
Cc: "Thomas Huth" <thuth@redhat.com>, "Ani Sinha" <anisinha@redhat.com>,
 "Wainer dos Santos Moschetta" <wainersm@redhat.com>, "Beraldo Leal"
 <bleal@redhat.com>, "Cleber Rosa" <crosa@redhat.com>, "Pavel Dovgalyuk"
 <pavel.dovgaluk@ispras.ru>, "Paolo Bonzini" <pbonzini@redhat.com>,
 <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] tests/avocado/reverse_debugging: Disable the ppc64
 tests by default
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.15.2
References: <20231114163115.298041-1-thuth@redhat.com>
 <12b4420e-1440-4516-8276-e0e907003c16@linaro.org>
 <9f6247e4-7e81-44f8-a63b-8ee11f722710@redhat.com>
 <CWYYRW53VEPJ.3UL1X7GB1P4H2@wheely>
 <6877d6d6-bfbf-4475-8c61-dd537265b278@redhat.com>
 <ZVTETYrfL8f48qe3@redhat.com> <ZVT-bY9YOr69QTPX@redhat.com>
 <CAFn=p-aDO_fZOsiBMdHhn6GP3ZadCrUAN4=C6o4d95UVMo3vOA@mail.gmail.com>
In-Reply-To: <CAFn=p-aDO_fZOsiBMdHhn6GP3ZadCrUAN4=C6o4d95UVMo3vOA@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
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

On Tue Nov 21, 2023 at 5:18 AM AEST, John Snow wrote:
> On Wed, Nov 15, 2023 at 12:23=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrang=
e@redhat.com> wrote:
> >
> > On Wed, Nov 15, 2023 at 01:14:53PM +0000, Daniel P. Berrang=C3=A9 wrote=
:
> > > On Wed, Nov 15, 2023 at 07:23:01AM +0100, Thomas Huth wrote:
> > > > On 15/11/2023 02.15, Nicholas Piggin wrote:
> > > > > On Wed Nov 15, 2023 at 4:29 AM AEST, Thomas Huth wrote:
> > > > > > On 14/11/2023 17.37, Philippe Mathieu-Daud=C3=A9 wrote:
> > > > > > > On 14/11/23 17:31, Thomas Huth wrote:
> > > > > > > > The tests seem currently to be broken. Disable them by defa=
ult
> > > > > > > > until someone fixes them.
> > > > > > > >
> > > > > > > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > > > > > > ---
> > > > > > > >    tests/avocado/reverse_debugging.py | 7 ++++---
> > > > > > > >    1 file changed, 4 insertions(+), 3 deletions(-)
> > > > > > >
> > > > > > > Similarly, I suspect https://gitlab.com/qemu-project/qemu/-/i=
ssues/1961
> > > > > > > which has a fix ready:
> > > > > > > https://lore.kernel.org/qemu-devel/20231110170831.185001-1-ri=
chard.henderson@linaro.org/
> > > > > > >
> > > > > > > Maybe wait the fix gets in first?
> > > > > >
> > > > > > No, I applied Richard's patch, but the problem persists. Does t=
his test
> > > > > > still work for you?
> > > > >
> > > > > I bisected it to 1d4796cd008373 ("python/machine: use socketpair(=
) for
> > > > > console connections"),
> > > >
> > > > Maybe John (who wrote that commit) can help?
> > >
> > > I find it hard to believe this commit is a direct root cause of the
> > > problem since all it does is change the QEMU startup sequence so that
> > > instead of QEMU listening for a monitor connection, it is given a
> > > pre-opened monitor connection.
> > >
> > > At the very most that should affect the startup timing a little.
> > >
> > > I notice all the reverse debugging tests have a skip on gitlab
> > > with a comment:
> > >
> > >     # unidentified gitlab timeout problem
> > >
> > > this makes be suspicious that John's patch has merely made this
> > > (henceforth undiagnosed) timeout more likely to ocurr.
> >
> > After an absolutely horrendous hours long debugging session I think
> > I figured out the problem. The QEMU process is blocking in
> >
> >     qemu_chr_write_buffer
> >
> > spinning in the loop on EAGAIN.
> >
> > The Python  Machine() class has passed one of a pre-created socketpair
> > FDs for the serial port chardev. The guest is trying to write to this
> > and blocking.  Nothing in the Machine() class is reading from the
> > other end of the serial port console.
> >
> >
> > Before John's change, the serial port uses a chardev in server mode
> > and crucially  'wait=3Doff', and the Machine() class never opened the
> > console socket unless the test case wanted to read from it.
> >
> > IOW, QEMU had a background job setting there waiting for a connection
> > that would never come.
> >
> > As a result when QEMU started executing the guest, all the serial port
> > writes get sent into to the void.
> >
> >
> > So John's patch has had a semantic change in behaviour, because the
> > console socket is permanently open, and thus socket buffers are liable
> > to fill up.
> >
> > As a demo I increased the socket buffers to 1MB and everything then
> > succeeded.
> >
> > @@ -357,6 +360,10 @@ def _pre_launch(self) -> None:
> >
> >          if self._console_set:
> >              self._cons_sock_pair =3D socket.socketpair()
> > +            self._cons_sock_pair[0].setsockopt(socket.SOL_SOCKET, sock=
et.SO_SNDBUF, 1024*1024);
> > +            self._cons_sock_pair[0].setsockopt(socket.SOL_SOCKET, sock=
et.SO_RCVBUF, 1024*1024);
> > +            self._cons_sock_pair[1].setsockopt(socket.SOL_SOCKET, sock=
et.SO_SNDBUF, 1024*1024);
> > +            self._cons_sock_pair[1].setsockopt(socket.SOL_SOCKET, sock=
et.SO_RCVBUF, 1024*1024);
> >              os.set_inheritable(self._cons_sock_pair[0].fileno(), True)
> >
> >          # NOTE: Make sure any opened resources are *definitely* freed =
in
> >
> >
> > The Machine class doesn't know if anything will ever use the console,
> > so as is the change is unsafe.
> >
> > The original goal of John's change was to guarantee we capture early
> > boot messages as some test need that.
> >
> > I think we need to be able to have a flag to say whether the caller nee=
ds
> > an "early console" facility, and only use the pre-opened FD passing for
> > that case. Tests we need early console will have to ask for that guaran=
tee
> > explicitly.
>
> Tch. I see. Thank you for diagnosing this.
>
> From the machine.py perspective, you have to *opt in* to having a
> console, so I hadn't considered that a caller would enable the console
> and then ... not read from it. Surely that's a bug in the caller?
>
> If you don't intend to read from the console, you shouldn't call set_cons=
ole().

Agree, hence the fix patch for the test case.

Although most tests wait for console, ones like this that control the
machine with gdb/qmp are rarer, so less examples to copy paste from.

>
> (The async rewrite I have been toying with on and off has a built-in
> drainer that writes to a log file that would probably remedy this, but
> the client tests should still be fixed, I think. Otherwise, do you

This sounds good because no matter the test, you rarely don't want to
log console output. Separating that from what the test does with
console would be nice.

> have any suggestions for how I might make this failure state more
> obvious/friendly? I wonder if on close of the machine.py object I
> could detect that the pipe is full and emit a warning about that.)

That's an idea. It wouldn't be foolproof (test could be waiting for
something else or failed for some other reason), but at least it could
give a suggestion (similar to my warning in the chardev code).

How would you do it? Maybe the simplest/portable way would be keep
a pipe write fd open in the harness and try write something to it
with O_NONBLOCK?

Thanks,
Nick

