Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8B2827BB6
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 00:54:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMzQb-0008I2-Bl; Mon, 08 Jan 2024 18:53:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rMzQW-0008H3-Cl
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 18:53:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rMzQU-0006Kg-PC
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 18:53:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704757981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N33w+Lj8Kaf73NR/DDcxzQgq2RkNhr5kAx/De1wM0sQ=;
 b=H+8LVnAAl79F+x9VTqlN6CCedY+EOLUpjy1wdA4Ym+jl90n7m0BZxujJKRTHndFZiBuDaV
 R8lp6bYO8sPdvfo9aG78wysLH6kIzzbb9VX0MtsPLh52IkBK8cL+Z3Rs1ioaLlVPVpiNeE
 CCI4CEuLYxEX5eyQ1TXGiSasp3/MQZY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-o0TJcez4P8mT7D9K64cOwA-1; Mon, 08 Jan 2024 18:52:59 -0500
X-MC-Unique: o0TJcez4P8mT7D9K64cOwA-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-28cbd4aaf29so1057816a91.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 15:52:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704757978; x=1705362778;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N33w+Lj8Kaf73NR/DDcxzQgq2RkNhr5kAx/De1wM0sQ=;
 b=hvMQ3tnhL5cvcEd6S+KRBbEDRf+VA0A9NPEdD3Q+EdmPfFyFjXTyNWZjwf45FTfU1L
 DmHyWkfXf9OyPApI4TzAMV4SQaNyHI7jmERhXHB1hmE/eqg966uJUo4p6O+n1WKfOS/0
 dieMEVMnQWzMo5A2yfosLgnYU14TDJbBTuPI6xv38c61CWN0+ofxB69HN7kOa4xUvwhC
 p47T3Q1Y0FFX0URqhZ3MfxDCkWYm68wnmqFhqD4yST4QYdSWZjGw8dej7fbSF17A8e2u
 035kjJjhcYnY6/gyXZLIyEpEZQ+WyBk9B/+2OQPSP2DTKcKNTZ+ToD57hQgrbH+2nKdN
 szvg==
X-Gm-Message-State: AOJu0YzjkjmF6U+tFhCiTLNDpI7SummHxMJRjxBAXbSBjk4At5vkxAAb
 CypBsYQmvpB/deZ8g23Pm4ZYGAQorsDYLmCWgiP9Sezpvo7hn3Dw97HfnP6tfXky5rwhLufRiKr
 k/QwRJBR/zHH76g0Ab2+mVZi7jlm3pU1d9rUKRN4=
X-Received: by 2002:a17:90b:3682:b0:28d:504d:d6dc with SMTP id
 mj2-20020a17090b368200b0028d504dd6dcmr1299594pjb.65.1704757978184; 
 Mon, 08 Jan 2024 15:52:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVTfkLmUcd4PKzUcFcdwBHRLcGegXe34MK+u5j84nIIwvQteOpqn2jmOqyUKWpXuHzuy2vr4pz6szRn33VIIw=
X-Received: by 2002:a17:90b:3682:b0:28d:504d:d6dc with SMTP id
 mj2-20020a17090b368200b0028d504dd6dcmr1299573pjb.65.1704757977886; Mon, 08
 Jan 2024 15:52:57 -0800 (PST)
MIME-Version: 1.0
References: <20231114163115.298041-1-thuth@redhat.com>
 <12b4420e-1440-4516-8276-e0e907003c16@linaro.org>
 <9f6247e4-7e81-44f8-a63b-8ee11f722710@redhat.com>
 <CWYYRW53VEPJ.3UL1X7GB1P4H2@wheely>
 <6877d6d6-bfbf-4475-8c61-dd537265b278@redhat.com>
 <ZVTETYrfL8f48qe3@redhat.com> <ZVT-bY9YOr69QTPX@redhat.com>
 <CAFn=p-aDO_fZOsiBMdHhn6GP3ZadCrUAN4=C6o4d95UVMo3vOA@mail.gmail.com>
 <CAFEAcA-kvS0TJN=wEeHYrG0Fqqm9Mj5Bx_0TFHwnTts6jXvFfw@mail.gmail.com>
In-Reply-To: <CAFEAcA-kvS0TJN=wEeHYrG0Fqqm9Mj5Bx_0TFHwnTts6jXvFfw@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Date: Mon, 8 Jan 2024 18:52:46 -0500
Message-ID: <CAFn=p-YgXanRxPBQL5juwKs0deO4seD8t-WiPCnYuRv0e_sK3g@mail.gmail.com>
Subject: Re: [PATCH] tests/avocado/reverse_debugging: Disable the ppc64 tests
 by default
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Nov 23, 2023 at 5:53=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Mon, 20 Nov 2023 at 19:19, John Snow <jsnow@redhat.com> wrote:
> >
> > On Wed, Nov 15, 2023 at 12:23=E2=80=AFPM Daniel P. Berrang=C3=A9 <berra=
nge@redhat.com> wrote:
> > > The Python  Machine() class has passed one of a pre-created socketpai=
r
> > > FDs for the serial port chardev. The guest is trying to write to this
> > > and blocking.  Nothing in the Machine() class is reading from the
> > > other end of the serial port console.
>
> > > The Machine class doesn't know if anything will ever use the console,
> > > so as is the change is unsafe.
> > >
> > > The original goal of John's change was to guarantee we capture early
> > > boot messages as some test need that.
> > >
> > > I think we need to be able to have a flag to say whether the caller n=
eeds
> > > an "early console" facility, and only use the pre-opened FD passing f=
or
> > > that case. Tests we need early console will have to ask for that guar=
antee
> > > explicitly.
> >
> > Tch. I see. Thank you for diagnosing this.
> >
> > From the machine.py perspective, you have to *opt in* to having a
> > console, so I hadn't considered that a caller would enable the console
> > and then ... not read from it. Surely that's a bug in the caller?
>
> From an Avocado test perspective, I would expect that the test case
> should have to explicitly opt *out* of "the console messages appear
> in the avocado test log, even if the test case doesn't care about them
> for the purposes of identifying when to end the test or whatever".
> The console logs are important for after-the-fact human diagnosis
> of why a test might have failed, so we should always collect them.
>
> thanks
> -- PMM
>

Understood. In that case, fixing the test would involve engaging's the
avocado suite's draining utility to ensure that the log is being
consumed and logged.

I think there's a potential here to simplify all of the
draining-and-logging code we have split across the avocado test suite,
console_socket.py and machine.py, but I can't promise that the rewrite
I've been working on will be ready quickly, so if this is still busted
(I'm still catching back up with my mail post-holidays) then we want a
quicker fix if we haven't committed one yet.

--js


