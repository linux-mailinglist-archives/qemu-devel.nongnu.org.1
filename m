Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4968582D717
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 11:19:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPK44-0003KY-T1; Mon, 15 Jan 2024 05:19:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPK41-0003K4-3X
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:19:29 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPK3y-0007dj-W7
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:19:28 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-50e766937ddso9566459e87.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 02:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705313964; x=1705918764; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0zzkHkmxcYPMtMYAkRidXJDVQc0pwPW0Gw3GwSETRqg=;
 b=r8dG7gvoX5sQNPSGkCxoTzR/x2Vdpl14N/rEJo/K3qbh6dJBZnvmAvmWf22HimTu7H
 9RJ6hOhLkIjt5+fnFD0DKT17rbaOvkRnZaGLcyV2Odkp63yOsFNP8mLvXGjOK90eySUx
 WcBk+IsbZFSejiVwUCRvSEg+QJlhmdWKrvPWCSHWRzj406LQFd6cq/KXDAE6rSnV8P4r
 2vRfh8oc4BolgcksNnYeNflqX48p3V/2Ppk5lojBMkR5CD3r2znn6gCYtTR/6rhSspiH
 8GoxhHoXHp4evKnfxJGEkUk0jxKkV0Hs/Lc0oyWRIhzzguTOZfGBh+3FanqAqy1xpkeQ
 WxFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705313964; x=1705918764;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0zzkHkmxcYPMtMYAkRidXJDVQc0pwPW0Gw3GwSETRqg=;
 b=rf9V93Wb3jFHGkvEJjMkRDvvganLaRA2CGhcmbHu4ob2CNckKsBEg5QluD9yqyYvtS
 5lmmJzVH9bIprb76EU1AaW8I64KzyYL+f0V0wLZMNZ0pM0ec2cy7bm6aXtA1pCU8qYe8
 rDdame1mjWtHtBhgi4EAZVHKtOxcE50WBuNb9GdOI8jt1gu7jmk3DxZI/f1WFL77GrNq
 MLPQ0KpNhuyMeV3pI+qIpqT8IRHY/a5pwtoxbRvqGGNjZiOXms7s0M1lIEZexM46oH5r
 jmVh17tJlKXu/q13exiD8jHKm9s3UZvoeL914KubyUCuivKxIpUKPNqlsk37p8PCJH54
 hyrg==
X-Gm-Message-State: AOJu0Yytp95sEa3L6jWMuhp1NSLBajNrUunvFE6Y7lSBMpDfVC/9bxbB
 wZRwhaihzvU/2orR8D1xUo20GdqpUN9EDx9CNu1hw3mPCxgd9g==
X-Google-Smtp-Source: AGHT+IGv6dxuem/FcveAyyDySUT/jmaq2cocamWgC8ENuJ9WCfwWOqE+Ps0IpgrLrl4n4bsRUTEcehV42S9TxJyujSs=
X-Received: by 2002:a19:5f18:0:b0:50e:db6c:dd0a with SMTP id
 t24-20020a195f18000000b0050edb6cdd0amr2027928lfb.86.1705313964030; Mon, 15
 Jan 2024 02:19:24 -0800 (PST)
MIME-Version: 1.0
References: <20240104162942.211458-1-berrange@redhat.com>
 <CAJSP0QXUGgZdFaDKWUSjVNwHJXe+xz3Fq6WneP_=XS8htE9JYQ@mail.gmail.com>
 <CACGkMEtf0TeTSXg1PLrJQ31ehptuzgzyTmLxER2KDXp4GZa1kg@mail.gmail.com>
In-Reply-To: <CACGkMEtf0TeTSXg1PLrJQ31ehptuzgzyTmLxER2KDXp4GZa1kg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2024 10:19:12 +0000
Message-ID: <CAFEAcA_SWTzOygqGB=ozfGZ=WnZ6fG0Tnmz79Mc=PTUFOa+U+w@mail.gmail.com>
Subject: Re: [PATCH 0/6] net: fix non-deterministic failures of the
 'netdev-socket' qtest
To: Jason Wang <jasowang@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 15 Jan 2024 at 02:37, Jason Wang <jasowang@redhat.com> wrote:
>
> On Fri, Jan 5, 2024 at 12:45=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.c=
om> wrote:
> >
> > On Thu, 4 Jan 2024 at 11:30, Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
> > >
> > > We've previously bumped up the timeouts in the netdev-socket qtest
> > > to supposedly fix non-deterministic failures, however, the failures
> > > are still hitting CI.
> > >
> > > A simple 'listen()' and 'connect()' pairing across 2 QEMU processes
> > > should be very quick to execute, even under high system load, so it
> > > was never likely that the test was failing due to timeouts being
> > > reached.
> > >
> > > The actual root cause was a race condition in the test design. It
> > > was spawning a QEMU with a 'server' netdev, and then spawning one
> > > with the 'client' netdev. There was insufficient synchronization,
> > > however, so it was possible for the 2nd QEMU process to attempt
> > > to 'connect()' before the 'listen()' call was made by the 1st QEMU.
> > >
> > > In the test scenarios that did not use the 'reconnect' flag, this
> > > would result in the client QEMU never getting into the expected
> > > state. The test code would thus loop on 'info network' until
> > > hitting the maximum wait time.
> > >
> > > This series reverts the increased timeouts, and fixes synchronization
> > > in the test scenarios. It also improves reporting of errors in the
> > > socket netdev backend so that 'info network' reports what actually
> > > went wrong rather than a useless generic 'connection error' string.
> > > This will help us diagnose any future CI problems, should they occurr=
.
> > >
> > > Daniel P. Berrang=C3=A9 (6):
> > >   Revert "netdev: set timeout depending on loadavg"
> > >   Revert "osdep: add getloadavg"
> > >   Revert "tests/qtest/netdev-socket: Raise connection timeout to 120
> > >     seconds"
> > >   net: add explicit info about connecting/listening state
> > >   net: handle QIOTask completion to report useful error message
> > >   qtest: ensure netdev-socket tests have non-overlapping names
> > >
> > >  include/qemu/osdep.h        | 10 ---------
> > >  meson.build                 |  1 -
> > >  net/stream.c                | 18 +++++++++++-----
> > >  tests/qtest/netdev-socket.c | 42 +++++++----------------------------=
--
> > >  4 files changed, 21 insertions(+), 50 deletions(-)
> >
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> >
>
> Queued.

These are already upstream, via thuth's testing queue.

thanks
-- PMM

