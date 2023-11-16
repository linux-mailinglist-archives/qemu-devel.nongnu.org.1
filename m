Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BE87EDDE9
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 10:46:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3YwO-000767-Il; Thu, 16 Nov 2023 04:45:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r3YwG-00072D-Rh; Thu, 16 Nov 2023 04:45:33 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r3YwF-0001E6-6d; Thu, 16 Nov 2023 04:45:32 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1cc4f777ab9so5628685ad.0; 
 Thu, 16 Nov 2023 01:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700127929; x=1700732729; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iTiBQW4F9yrgbUsaSPnroBpPJ8tnCP5a+PAMYAIcAog=;
 b=nlISh8yZEZ5SXaApuDHYcjQ34x2VmDYVa7e0ZuhqBaShdn4cHuqvIPIb9UAWDdHbug
 UXCp775wgu9hXUg+hQtPj5qXJsR7pFZvs/MUXgZv4+kHCwCYtTH0BPWCygeebvJg/fz6
 0Rt4Ih+cHudUuIzZFLK6bUQVLqMdtNtKgp11cA6nYNgppxINetWPEGbjzQxDgfZFi8vr
 Mq22vFIBJMXOvxS7tc2qYeyNUkectRNIRFtH29oTZKfq8X1CHfffTMcnnhmqb/j4/I3H
 f/wszNcUr4GFdXKnPWtMPLHhPs4hPm1YPvMawXu0JjAwxfjp51MFETcHWtVJScALqI5z
 6GhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700127929; x=1700732729;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iTiBQW4F9yrgbUsaSPnroBpPJ8tnCP5a+PAMYAIcAog=;
 b=eBGHEO8KKs6b7Uy226NSObZDYcFSNcdaYVks6Y/T/zIw5o4S92h5vM5xXhmGbEur2C
 tepg94EYjgJZchUEm6ZqDpb2GvYZBhsvmA2lNdkmF33MiLQyzWT6VAhpg6Dur/0CTYQ6
 8xxzqfjOBeNscjbKMosw9CUfB/F8gdoGtbErjLlwp7WDA7o3fCrDrt5Nsshn8guyTXaC
 fV3Vi1upCTxB612jxv1hWmuQgfpoVHme6xg5JevtoaWAqJ6ge/ttynsXAsgXPBFfPYgR
 v1K3OeIrYbOgKU655yVoWzDmYH1KpfuU9J2K842tPYlr7i+bP4mxqYaqIxOv4qLa6F2l
 m7OA==
X-Gm-Message-State: AOJu0YxAUbQGyDHdTIizx85LMEV7zZQk51pO7QKsv1dgR51aX42lQ2N3
 5KyO1Mr2QqhdYnYY2OyCJgU=
X-Google-Smtp-Source: AGHT+IHQFKvtSPvqnNogSFXa0gqQtMxvtlSLZjk37PToEgf8TMRbipPN0aNum477X7WGl6ygm/B62A==
X-Received: by 2002:a17:902:9a8a:b0:1cc:3fce:8aa8 with SMTP id
 w10-20020a1709029a8a00b001cc3fce8aa8mr8151861plp.6.1700127929209; 
 Thu, 16 Nov 2023 01:45:29 -0800 (PST)
Received: from localhost ([210.84.53.86]) by smtp.gmail.com with ESMTPSA id
 p18-20020a170902e75200b001b8b45b177esm8803390plf.274.2023.11.16.01.45.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 01:45:28 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Nov 2023 19:45:20 +1000
Message-Id: <CX051SMKMNFP.1GWS0WCUV5KDJ@wheely>
Subject: Re: [PATCH] tests/avocado/reverse_debugging: Disable the ppc64
 tests by default
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Thomas Huth" <thuth@redhat.com>,
 =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, "John Snow"
 <jsnow@redhat.com>, "Ani Sinha" <anisinha@redhat.com>, "Wainer dos Santos
 Moschetta" <wainersm@redhat.com>, "Beraldo Leal" <bleal@redhat.com>,
 "Cleber Rosa" <crosa@redhat.com>, "Pavel Dovgalyuk"
 <pavel.dovgaluk@ispras.ru>, "Paolo Bonzini" <pbonzini@redhat.com>,
 <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: aerc 0.15.2
References: <20231114163115.298041-1-thuth@redhat.com>
 <12b4420e-1440-4516-8276-e0e907003c16@linaro.org>
 <9f6247e4-7e81-44f8-a63b-8ee11f722710@redhat.com>
 <CWYYRW53VEPJ.3UL1X7GB1P4H2@wheely>
 <6877d6d6-bfbf-4475-8c61-dd537265b278@redhat.com>
 <ZVTETYrfL8f48qe3@redhat.com> <ZVT-bY9YOr69QTPX@redhat.com>
 <CWZU7DEIX9E4.26PTZ0GK1ZAUP@wheely>
 <b1587362-a84c-44d5-9d07-6e2307c15152@redhat.com>
In-Reply-To: <b1587362-a84c-44d5-9d07-6e2307c15152@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x630.google.com
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

On Thu Nov 16, 2023 at 5:09 PM AEST, Thomas Huth wrote:
> On 16/11/2023 02.15, Nicholas Piggin wrote:
> > On Thu Nov 16, 2023 at 3:22 AM AEST, Daniel P. Berrang=C3=A9 wrote:
> >> On Wed, Nov 15, 2023 at 01:14:53PM +0000, Daniel P. Berrang=C3=A9 wrot=
e:
> ...
> >> The Machine class doesn't know if anything will ever use the console,
> >> so as is the change is unsafe.
> >>
> >> The original goal of John's change was to guarantee we capture early
> >> boot messages as some test need that.
> >>
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
> > add something like vm.launch(console=3DTrue) ?
> >=20
> > Thanks,
> > Nick
> > ---
> >=20
> > diff --git a/tests/avocado/reverse_debugging.py b/tests/avocado/reverse=
_debugging.py
> > index fc47874eda..128d85bc0e 100644
> > --- a/tests/avocado/reverse_debugging.py
> > +++ b/tests/avocado/reverse_debugging.py
> > @@ -12,6 +12,7 @@
> >  =20
> >   from avocado import skipIf
> >   from avocado_qemu import BUILD_DIR
> > +from avocado.utils import datadrainer
> >   from avocado.utils import gdb
> >   from avocado.utils import process
> >   from avocado.utils.network.ports import find_free_port
> > @@ -52,6 +53,10 @@ def run_vm(self, record, shift, args, replay_path, i=
mage_path, port):
> >           if args:
> >               vm.add_args(*args)
> >           vm.launch()
> > +        console_drainer =3D datadrainer.LineLogger(vm.console_socket.f=
ileno(),
> > +                                    logger=3Dself.log.getChild('consol=
e'),
> > +                                    stop_check=3D(lambda : not vm.is_r=
unning()))
> > +        console_drainer.start()
> >           return vm
> >  =20
> >       @staticmethod
>
> Tested-by: Thomas Huth <thuth@redhat.com>

Thank you.

> Could you please send this as a proper patch, with a S-o-b line, and a sh=
ort=20
> comment in front of the newly added code explaining it?

Yep, just testing it now. Should have it sent out in an hour or two.

Thanks,
Nick

