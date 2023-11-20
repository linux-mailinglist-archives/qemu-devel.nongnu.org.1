Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF3D7F1D3F
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 20:19:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r59nR-0004b6-I3; Mon, 20 Nov 2023 14:19:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r59nO-0004aZ-It
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 14:18:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r59nM-0001vS-Jw
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 14:18:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700507935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xUaTNbMWV/2zpwUJAGxk2dei5iWxNVWv7jOFPfd2C7s=;
 b=Bma5jzu5rZ0qPVF7AolV18q3+Dk/Oms7rR0XYkjFMapxUuK0xGKEOzC65XkCxIbtiZJk+T
 M/t/fw9STSmr6LdUeQZJMz+ykwvvLvfvcWHzoKJOcje67L4wHPwPjInU61qdZ2uHbAniRC
 Paf+mkFxZY3EOKByLDKH5t8S1iXIDp0=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-h9wJJJIzOQ6spEaFMmlTEA-1; Mon, 20 Nov 2023 14:18:53 -0500
X-MC-Unique: h9wJJJIzOQ6spEaFMmlTEA-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5bdd8eee498so5517217a12.0
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 11:18:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700507932; x=1701112732;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xUaTNbMWV/2zpwUJAGxk2dei5iWxNVWv7jOFPfd2C7s=;
 b=Gu93c3qqkonoEMvHFkUo/O4OPWCI3NPW2hcAI8Q678EFCHkGmROQIFFWBNTpIqLTZK
 fAqoh2ihObscpF5eBL04LGFuV3TVl7ezExAm6gYC5AvGglT26K28z8kAZahfv+2z4F/R
 a4XSasJFmEk7Jk/2Ija/yV2za14LjdnXHBN7+nhbismo4qjuToonmj0QtLPRwZ6OIKcc
 R1H4CFQ1X+ziEA6d+ckhCXAvoqC5XKTTh2c7KJ1hc0VToTslTlRycxC6QyroSbesLtk0
 K6ijhM0WXZ/cIw7vXFiGCJIpcvLBBifWJAxx4ymgiJIgfflP17txb6dyQIPWfsUdZHtM
 Zxug==
X-Gm-Message-State: AOJu0YzUtGTg/0KCNkMu6b2/XJe5fUFqi51G4l2UfUnwIZM8yVF7tO6e
 xoSEGHQWe1rhrweP/ICU2cboZWXxuMcjD37bo/tcr3pGm2FeqOOhYiPM6hZhiv7L3n2ozPsYbXQ
 f1BsohtMTce+5zJaRoI2JkUPccZBw48E=
X-Received: by 2002:a05:6a20:7351:b0:180:f9c4:a796 with SMTP id
 v17-20020a056a20735100b00180f9c4a796mr6958242pzc.54.1700507932201; 
 Mon, 20 Nov 2023 11:18:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhm6Dq3NqnuSzxzlg1DmrTd1LNKmMtyCkc87o+ALMEJVespBUcZHnmV3HR9aJRKOsTjdpO73fxh2US/4SglTc=
X-Received: by 2002:a05:6a20:7351:b0:180:f9c4:a796 with SMTP id
 v17-20020a056a20735100b00180f9c4a796mr6958221pzc.54.1700507931894; Mon, 20
 Nov 2023 11:18:51 -0800 (PST)
MIME-Version: 1.0
References: <20231114163115.298041-1-thuth@redhat.com>
 <12b4420e-1440-4516-8276-e0e907003c16@linaro.org>
 <9f6247e4-7e81-44f8-a63b-8ee11f722710@redhat.com>
 <CWYYRW53VEPJ.3UL1X7GB1P4H2@wheely>
 <6877d6d6-bfbf-4475-8c61-dd537265b278@redhat.com>
 <ZVTETYrfL8f48qe3@redhat.com> <ZVT-bY9YOr69QTPX@redhat.com>
In-Reply-To: <ZVT-bY9YOr69QTPX@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Mon, 20 Nov 2023 14:18:40 -0500
Message-ID: <CAFn=p-aDO_fZOsiBMdHhn6GP3ZadCrUAN4=C6o4d95UVMo3vOA@mail.gmail.com>
Subject: Re: [PATCH] tests/avocado/reverse_debugging: Disable the ppc64 tests
 by default
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
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

On Wed, Nov 15, 2023 at 12:23=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> On Wed, Nov 15, 2023 at 01:14:53PM +0000, Daniel P. Berrang=C3=A9 wrote:
> > On Wed, Nov 15, 2023 at 07:23:01AM +0100, Thomas Huth wrote:
> > > On 15/11/2023 02.15, Nicholas Piggin wrote:
> > > > On Wed Nov 15, 2023 at 4:29 AM AEST, Thomas Huth wrote:
> > > > > On 14/11/2023 17.37, Philippe Mathieu-Daud=C3=A9 wrote:
> > > > > > On 14/11/23 17:31, Thomas Huth wrote:
> > > > > > > The tests seem currently to be broken. Disable them by defaul=
t
> > > > > > > until someone fixes them.
> > > > > > >
> > > > > > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > > > > > ---
> > > > > > >    tests/avocado/reverse_debugging.py | 7 ++++---
> > > > > > >    1 file changed, 4 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > Similarly, I suspect https://gitlab.com/qemu-project/qemu/-/iss=
ues/1961
> > > > > > which has a fix ready:
> > > > > > https://lore.kernel.org/qemu-devel/20231110170831.185001-1-rich=
ard.henderson@linaro.org/
> > > > > >
> > > > > > Maybe wait the fix gets in first?
> > > > >
> > > > > No, I applied Richard's patch, but the problem persists. Does thi=
s test
> > > > > still work for you?
> > > >
> > > > I bisected it to 1d4796cd008373 ("python/machine: use socketpair() =
for
> > > > console connections"),
> > >
> > > Maybe John (who wrote that commit) can help?
> >
> > I find it hard to believe this commit is a direct root cause of the
> > problem since all it does is change the QEMU startup sequence so that
> > instead of QEMU listening for a monitor connection, it is given a
> > pre-opened monitor connection.
> >
> > At the very most that should affect the startup timing a little.
> >
> > I notice all the reverse debugging tests have a skip on gitlab
> > with a comment:
> >
> >     # unidentified gitlab timeout problem
> >
> > this makes be suspicious that John's patch has merely made this
> > (henceforth undiagnosed) timeout more likely to ocurr.
>
> After an absolutely horrendous hours long debugging session I think
> I figured out the problem. The QEMU process is blocking in
>
>     qemu_chr_write_buffer
>
> spinning in the loop on EAGAIN.
>
> The Python  Machine() class has passed one of a pre-created socketpair
> FDs for the serial port chardev. The guest is trying to write to this
> and blocking.  Nothing in the Machine() class is reading from the
> other end of the serial port console.
>
>
> Before John's change, the serial port uses a chardev in server mode
> and crucially  'wait=3Doff', and the Machine() class never opened the
> console socket unless the test case wanted to read from it.
>
> IOW, QEMU had a background job setting there waiting for a connection
> that would never come.
>
> As a result when QEMU started executing the guest, all the serial port
> writes get sent into to the void.
>
>
> So John's patch has had a semantic change in behaviour, because the
> console socket is permanently open, and thus socket buffers are liable
> to fill up.
>
> As a demo I increased the socket buffers to 1MB and everything then
> succeeded.
>
> @@ -357,6 +360,10 @@ def _pre_launch(self) -> None:
>
>          if self._console_set:
>              self._cons_sock_pair =3D socket.socketpair()
> +            self._cons_sock_pair[0].setsockopt(socket.SOL_SOCKET, socket=
.SO_SNDBUF, 1024*1024);
> +            self._cons_sock_pair[0].setsockopt(socket.SOL_SOCKET, socket=
.SO_RCVBUF, 1024*1024);
> +            self._cons_sock_pair[1].setsockopt(socket.SOL_SOCKET, socket=
.SO_SNDBUF, 1024*1024);
> +            self._cons_sock_pair[1].setsockopt(socket.SOL_SOCKET, socket=
.SO_RCVBUF, 1024*1024);
>              os.set_inheritable(self._cons_sock_pair[0].fileno(), True)
>
>          # NOTE: Make sure any opened resources are *definitely* freed in
>
>
> The Machine class doesn't know if anything will ever use the console,
> so as is the change is unsafe.
>
> The original goal of John's change was to guarantee we capture early
> boot messages as some test need that.
>
> I think we need to be able to have a flag to say whether the caller needs
> an "early console" facility, and only use the pre-opened FD passing for
> that case. Tests we need early console will have to ask for that guarante=
e
> explicitly.

Tch. I see. Thank you for diagnosing this.

From the machine.py perspective, you have to *opt in* to having a
console, so I hadn't considered that a caller would enable the console
and then ... not read from it. Surely that's a bug in the caller?

If you don't intend to read from the console, you shouldn't call set_consol=
e().

(The async rewrite I have been toying with on and off has a built-in
drainer that writes to a log file that would probably remedy this, but
the client tests should still be fixed, I think. Otherwise, do you
have any suggestions for how I might make this failure state more
obvious/friendly? I wonder if on close of the machine.py object I
could detect that the pipe is full and emit a warning about that.)

--js

>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>


