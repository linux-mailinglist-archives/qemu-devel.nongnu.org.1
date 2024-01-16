Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFB082E628
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 02:06:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPXtW-0005VZ-Ep; Mon, 15 Jan 2024 20:05:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rPXtV-0005VQ-4X
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 20:05:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rPXtT-0005Aq-3R
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 20:05:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705367129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wJV57VdVZZu1YthTbGokqDky91e22R27v7I0YPlx4sg=;
 b=cQ1dSSuZPjAuS6fChBNzzeQcaOwJcU6hNwV800f/h6tQNqjbSP8KsfhWdmwrCDslyUAGLn
 Mlrs/KqHK9+tEeH0byHxHdimTiyzl6p0PcfCclaJaP1SUvmEj5kDfA50kMhTsmrY7m2JVb
 T9w/R0ZQXVMTAtRMEwV5FZAxqqIej6c=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-Ojk10u3kOt6d-j2GufUGjg-1; Mon, 15 Jan 2024 20:05:27 -0500
X-MC-Unique: Ojk10u3kOt6d-j2GufUGjg-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5cdfa8dea37so7704376a12.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 17:05:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705367126; x=1705971926;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wJV57VdVZZu1YthTbGokqDky91e22R27v7I0YPlx4sg=;
 b=mj3b3TuGLN0Qt77QWZD2v+pjVAgu+A/Ll0BeURtQLZ8UtxUeIH77piCaGibjy9lwml
 rHmIV9GuLFQZdumxUuKNHZhKCQgexUrUVwypkf+NwtoSXRN22EKpMBRuOOAtE2vzcUl1
 0rNlPkrNlAvBwZdakh06rnQuE8A8aNTBAIy2jXrKwog5kYzEdbPydvNncikEYk7ZTze+
 el9WztQHLNQZsum02s4ykFoR4wpVOoLOYJ+fpWWxnGjxdW+kNZYrG/WGJvhMmwjAZdEZ
 9LzhaFvPbh4q3hXHSXSL8NA5/CSSbmvZHxlCan2Ae6oF3eQiybtF0HLOmPI+kKkFsNeR
 tRqw==
X-Gm-Message-State: AOJu0YzSoUmQjpQdIxq6qCSRakDIcq9kHe9uzjUI6OaVgUKoSGkSHTTk
 /SUR+8aEFJm7pCVXo3ZGg4Nx+FbsbFuuxmS5sma76Oo73qvgsnEQ9W3bJIuQ6yH9IErvNR9vGVh
 Kj/aV4IQ5cqBx4bot7n+VnHyA0d1BBvkZL6XM5V4=
X-Received: by 2002:a17:90a:f188:b0:28c:c5fd:32eb with SMTP id
 bv8-20020a17090af18800b0028cc5fd32ebmr10171042pjb.45.1705367126249; 
 Mon, 15 Jan 2024 17:05:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH24KlvEDfaTOBJwOA2JmZohdsIEkEISLfB5LgEQno4aJQSraeqeLvrjjEmkVR8RbpuKuObct22RBg10/y8gO8=
X-Received: by 2002:a17:90a:f188:b0:28c:c5fd:32eb with SMTP id
 bv8-20020a17090af18800b0028cc5fd32ebmr10171012pjb.45.1705367125924; Mon, 15
 Jan 2024 17:05:25 -0800 (PST)
MIME-Version: 1.0
References: <20240104162942.211458-1-berrange@redhat.com>
 <CAJSP0QXUGgZdFaDKWUSjVNwHJXe+xz3Fq6WneP_=XS8htE9JYQ@mail.gmail.com>
 <CACGkMEtf0TeTSXg1PLrJQ31ehptuzgzyTmLxER2KDXp4GZa1kg@mail.gmail.com>
 <CAFEAcA_SWTzOygqGB=ozfGZ=WnZ6fG0Tnmz79Mc=PTUFOa+U+w@mail.gmail.com>
In-Reply-To: <CAFEAcA_SWTzOygqGB=ozfGZ=WnZ6fG0Tnmz79Mc=PTUFOa+U+w@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 16 Jan 2024 09:05:14 +0800
Message-ID: <CACGkMEsJsL5FLpJgQxhLfn=B3QLBGHWO3L1Vu8w-wn3V14DuVQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] net: fix non-deterministic failures of the
 'netdev-socket' qtest
To: Peter Maydell <peter.maydell@linaro.org>
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
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
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

On Mon, Jan 15, 2024 at 6:19=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Mon, 15 Jan 2024 at 02:37, Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Fri, Jan 5, 2024 at 12:45=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail=
.com> wrote:
> > >
> > > On Thu, 4 Jan 2024 at 11:30, Daniel P. Berrang=C3=A9 <berrange@redhat=
.com> wrote:
> > > >
> > > > We've previously bumped up the timeouts in the netdev-socket qtest
> > > > to supposedly fix non-deterministic failures, however, the failures
> > > > are still hitting CI.
> > > >
> > > > A simple 'listen()' and 'connect()' pairing across 2 QEMU processes
> > > > should be very quick to execute, even under high system load, so it
> > > > was never likely that the test was failing due to timeouts being
> > > > reached.
> > > >
> > > > The actual root cause was a race condition in the test design. It
> > > > was spawning a QEMU with a 'server' netdev, and then spawning one
> > > > with the 'client' netdev. There was insufficient synchronization,
> > > > however, so it was possible for the 2nd QEMU process to attempt
> > > > to 'connect()' before the 'listen()' call was made by the 1st QEMU.
> > > >
> > > > In the test scenarios that did not use the 'reconnect' flag, this
> > > > would result in the client QEMU never getting into the expected
> > > > state. The test code would thus loop on 'info network' until
> > > > hitting the maximum wait time.
> > > >
> > > > This series reverts the increased timeouts, and fixes synchronizati=
on
> > > > in the test scenarios. It also improves reporting of errors in the
> > > > socket netdev backend so that 'info network' reports what actually
> > > > went wrong rather than a useless generic 'connection error' string.
> > > > This will help us diagnose any future CI problems, should they occu=
rr.
> > > >
> > > > Daniel P. Berrang=C3=A9 (6):
> > > >   Revert "netdev: set timeout depending on loadavg"
> > > >   Revert "osdep: add getloadavg"
> > > >   Revert "tests/qtest/netdev-socket: Raise connection timeout to 12=
0
> > > >     seconds"
> > > >   net: add explicit info about connecting/listening state
> > > >   net: handle QIOTask completion to report useful error message
> > > >   qtest: ensure netdev-socket tests have non-overlapping names
> > > >
> > > >  include/qemu/osdep.h        | 10 ---------
> > > >  meson.build                 |  1 -
> > > >  net/stream.c                | 18 +++++++++++-----
> > > >  tests/qtest/netdev-socket.c | 42 +++++++--------------------------=
----
> > > >  4 files changed, 21 insertions(+), 50 deletions(-)
> > >
> > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > >
> >
> > Queued.
>
> These are already upstream, via thuth's testing queue.
>
> thanks
> -- PMM
>

Great, so I dropped this.

Thanks


