Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 407AD7ED8D9
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 02:17:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Qyr-0004aH-Kq; Wed, 15 Nov 2023 20:15:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r3Qyp-0004Zu-P5; Wed, 15 Nov 2023 20:15:39 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r3Qyn-0002wo-MA; Wed, 15 Nov 2023 20:15:39 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3b6c31e604cso178617b6e.2; 
 Wed, 15 Nov 2023 17:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700097335; x=1700702135; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n8lnafgpV8D7wSCfOOxM9Oz7iijX+G35oRBXKSe5XFo=;
 b=AoX/gteTlUJ0EM5xE9puqKA2kIuk+sZxtCzbRHtj5TstfGLbZH6ZzjDIdStAlzGMsV
 dYoG9YrpQOWt7INo5pUe6wUBMAWs4jnF42kgjry0YvWFfF4KWrGxWtEIwGd+IzIJa9zt
 xYPCJJ5Z+fSGcuNylzTXMP8w5W4X7cpjJi4kM3Wp6iGbtKEgtOIi9Iw6IU/cTN0ZeKZ9
 Jpui5ohFg0cVbrn/bI8GDeWSLzArAG7XGIz/CW7XKsFWfbwM1sWdC6cOQe2BnlHd9rqE
 /zyO0zBMYCyivCwRcVK+6xzGSmwk7zWwrHp7q3Ht0gc9fxCdu0hg+FQWoWtWmu95Ds9+
 uUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700097335; x=1700702135;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=n8lnafgpV8D7wSCfOOxM9Oz7iijX+G35oRBXKSe5XFo=;
 b=VOtWOd2VD5mdBjP5JJHRuO9BtaALzhZFZLdepsJrgehCy/LcaahgI6aE9+GeE1zxyv
 5+LaVzKhw0AOUpwNOHmp2SA1Ut3an+sGJNbvJlmAEZwbNHVZZU2rGNmN4kLTEJShp5wT
 b/Es02GnBuAWiF00yLQ3up6BHJqeJb4DSTPfbIcph6vjzrM1og/8Jt8/fOMnr0hkvOXH
 eTp8S9x4C1R3PvtABVX1JXVHwOaGJLHXeT6Y/BqsSFjTSG+h19owFJLVCwcCJe+o9xi0
 ax0MJ9O3n3Ux9ygbcRFiEuhlk5fL+W+Wtr7PLfbXS5N6IyjaNyO3Je8+pZV9ZSf5TolT
 CFJA==
X-Gm-Message-State: AOJu0Yz5JjTiBi2bqxFHA66bJkJcQcxGbmrxRzF+Yn3vgbLy3n3GUjxt
 R0G1rzc5uk7XbKyeGFvwEfk=
X-Google-Smtp-Source: AGHT+IGRJeTksVSfdELlRy4nCm/zLjL8FDJxX6jiZAJWyQu1rYBI4viF4vm27uBYb4kjlyTbkfOEig==
X-Received: by 2002:a05:6808:11ca:b0:3b5:7044:37f with SMTP id
 p10-20020a05680811ca00b003b57044037fmr20073648oiv.17.1700097335370; 
 Wed, 15 Nov 2023 17:15:35 -0800 (PST)
Received: from localhost (121-44-82-40.tpgi.com.au. [121.44.82.40])
 by smtp.gmail.com with ESMTPSA id
 e70-20020a636949000000b005b6f075da0dsm1791207pgc.25.2023.11.15.17.15.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 17:15:34 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Nov 2023 11:15:25 +1000
Message-Id: <CWZU7DEIX9E4.26PTZ0GK1ZAUP@wheely>
Subject: Re: [PATCH] tests/avocado/reverse_debugging: Disable the ppc64
 tests by default
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, "Thomas
 Huth" <thuth@redhat.com>, "John Snow" <jsnow@redhat.com>, "Ani Sinha"
 <anisinha@redhat.com>, "Wainer dos Santos Moschetta" <wainersm@redhat.com>,
 "Beraldo Leal" <bleal@redhat.com>, "Cleber Rosa" <crosa@redhat.com>, "Pavel
 Dovgalyuk" <pavel.dovgaluk@ispras.ru>, "Paolo Bonzini"
 <pbonzini@redhat.com>, <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: aerc 0.15.2
References: <20231114163115.298041-1-thuth@redhat.com>
 <12b4420e-1440-4516-8276-e0e907003c16@linaro.org>
 <9f6247e4-7e81-44f8-a63b-8ee11f722710@redhat.com>
 <CWYYRW53VEPJ.3UL1X7GB1P4H2@wheely>
 <6877d6d6-bfbf-4475-8c61-dd537265b278@redhat.com>
 <ZVTETYrfL8f48qe3@redhat.com> <ZVT-bY9YOr69QTPX@redhat.com>
In-Reply-To: <ZVT-bY9YOr69QTPX@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x235.google.com
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

On Thu Nov 16, 2023 at 3:22 AM AEST, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Nov 15, 2023 at 01:14:53PM +0000, Daniel P. Berrang=C3=A9 wrote:
> > On Wed, Nov 15, 2023 at 07:23:01AM +0100, Thomas Huth wrote:
> > > On 15/11/2023 02.15, Nicholas Piggin wrote:
> > > > On Wed Nov 15, 2023 at 4:29 AM AEST, Thomas Huth wrote:
> > > > > On 14/11/2023 17.37, Philippe Mathieu-Daud=C3=A9 wrote:
> > > > > > On 14/11/23 17:31, Thomas Huth wrote:
> > > > > > > The tests seem currently to be broken. Disable them by defaul=
t
> > > > > > > until someone fixes them.
> > > > > > >=20
> > > > > > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > > > > > ---
> > > > > > >  =C2=A0 tests/avocado/reverse_debugging.py | 7 ++++---
> > > > > > >  =C2=A0 1 file changed, 4 insertions(+), 3 deletions(-)
> > > > > >=20
> > > > > > Similarly, I suspect https://gitlab.com/qemu-project/qemu/-/iss=
ues/1961
> > > > > > which has a fix ready:
> > > > > > https://lore.kernel.org/qemu-devel/20231110170831.185001-1-rich=
ard.henderson@linaro.org/
> > > > > >=20
> > > > > > Maybe wait the fix gets in first?
> > > > >=20
> > > > > No, I applied Richard's patch, but the problem persists. Does thi=
s test
> > > > > still work for you?
> > > >=20
> > > > I bisected it to 1d4796cd008373 ("python/machine: use socketpair() =
for
> > > > console connections"),
> > >=20
> > > Maybe John (who wrote that commit) can help?
> >=20
> > I find it hard to believe this commit is a direct root cause of the
> > problem since all it does is change the QEMU startup sequence so that
> > instead of QEMU listening for a monitor connection, it is given a
> > pre-opened monitor connection.
> >=20
> > At the very most that should affect the startup timing a little.
> >=20
> > I notice all the reverse debugging tests have a skip on gitlab
> > with a comment:
> >=20
> >     # unidentified gitlab timeout problem
> >=20
> > this makes be suspicious that John's patch has merely made this
> > (henceforth undiagnosed) timeout more likely to ocurr.
>
> After an absolutely horrendous hours long debugging session I think
> I figured out the problem. The QEMU process is blocking in
>
>     qemu_chr_write_buffer
>
> spinning in the loop on EAGAIN.

Great work.

Why does this make the gdb socket give an empty response? Something
just times out?

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
> =20
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
> =20
>          # NOTE: Make sure any opened resources are *definitely* freed in

So perhaps ppc64 fails just because it prints more to the console in early
boot than other targets?

> The Machine class doesn't know if anything will ever use the console,
> so as is the change is unsafe.
>
> The original goal of John's change was to guarantee we capture early
> boot messages as some test need that. =20
>
> I think we need to be able to have a flag to say whether the caller needs
> an "early console" facility, and only use the pre-opened FD passing for
> that case. Tests we need early console will have to ask for that guarante=
e
> explicitly.

The below patch makes this test work. Maybe as a quick fix it is
better than disabling the test.

I guess we still have a problem if a test invokes vm.launch()
directly without subsequently waiting for a console pattern or
doing something with the console as you say. Your suggesstion is
add something like vm.launch(console=3DTrue) ?=20

Thanks,
Nick
---

diff --git a/tests/avocado/reverse_debugging.py b/tests/avocado/reverse_deb=
ugging.py
index fc47874eda..128d85bc0e 100644
--- a/tests/avocado/reverse_debugging.py
+++ b/tests/avocado/reverse_debugging.py
@@ -12,6 +12,7 @@
=20
 from avocado import skipIf
 from avocado_qemu import BUILD_DIR
+from avocado.utils import datadrainer
 from avocado.utils import gdb
 from avocado.utils import process
 from avocado.utils.network.ports import find_free_port
@@ -52,6 +53,10 @@ def run_vm(self, record, shift, args, replay_path, image=
_path, port):
         if args:
             vm.add_args(*args)
         vm.launch()
+        console_drainer =3D datadrainer.LineLogger(vm.console_socket.filen=
o(),
+                                    logger=3Dself.log.getChild('console'),
+                                    stop_check=3D(lambda : not vm.is_runni=
ng()))
+        console_drainer.start()
         return vm
=20
     @staticmethod

