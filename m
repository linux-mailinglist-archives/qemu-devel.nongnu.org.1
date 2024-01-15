Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6429082D323
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 03:38:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPCqN-0007FX-5e; Sun, 14 Jan 2024 21:36:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rPCqI-0007FH-Rk
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 21:36:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rPCqG-0005zo-EH
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 21:36:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705286207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g4iJ8LTfQcUX8VfFLj4pynypzaHxIg6hs4fofelZ0OM=;
 b=L8Va7WTIViJD3Nj8mBVGPnah0cFv0IA0TnC1iJvOn49Wu1ZOvJ6FnLyCwm6qPqE7+B5ie8
 Baxwy6FiXDAYxu34mox9/vmakkC2eRhANlEc503R6eWvMWTf/+CAHpVL26jTtsHS+1wMOY
 RKHnTvngT1+DYtbTOgXXr1OfzhpxOXM=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-Gfr7daY5Nk2bO8InEEs7FA-1; Sun, 14 Jan 2024 21:36:40 -0500
X-MC-Unique: Gfr7daY5Nk2bO8InEEs7FA-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6d99506e2e7so10313000b3a.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 18:36:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705286200; x=1705891000;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g4iJ8LTfQcUX8VfFLj4pynypzaHxIg6hs4fofelZ0OM=;
 b=K/1e+LY8jT9kXdSPhbDOWIuogzj+R9rhoS/aLP8wuSDvnqWq8kw2ZowaeZjvYfycyq
 0wpi0KmBxOGfjOjUEsyLFe29n+7SV8KZgJF4sjjA0ZKulxxinLP1FFz31mz9ccqAbR8C
 xSuE06T7a66zy2FuFBDo+GIfNq76hj9D7axLuJFZm0pWKTXeHGFuZa5TC3TAa3UgGrJU
 BRJ9FovWpr6GOW9Vid8BqwdhSoTs1zsxFUNwjV54esGWfNvwNcyh1Hr9UcK/39Gn+XTw
 moz+jLCcaTNIvkgo3zJ3RoelPZMAVgkR+zQnxg271Oi6uCjp91dcQuhNaAetjlHGIfEb
 xhwQ==
X-Gm-Message-State: AOJu0YyqbqNKKmtFXu9FR6h9gYEnMYYp2j+aj3THLq0AiPcWsAt4h33Q
 mnhT/3PvXvzzsZ6YtP3TgQ+7UnbsYVZPEK+Yv+wOHYrhLTziKwAoeJp83wtJu+PmkKbl0pZbYzP
 7QIrb/6U+NC2LW2pqIETRudObB3C9u2Mc3LqhvCk=
X-Received: by 2002:a05:6a20:e687:b0:19a:ef31:e8a9 with SMTP id
 mz7-20020a056a20e68700b0019aef31e8a9mr1282405pzb.74.1705286199849; 
 Sun, 14 Jan 2024 18:36:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHM9cLxC0J9skxr45Om+VoGdVQFBfNRODEzpyHPU3BQ6mCxi7rBvcEGyK54phGWcUOoqoHsElVB/8EYxns8woA=
X-Received: by 2002:a05:6a20:e687:b0:19a:ef31:e8a9 with SMTP id
 mz7-20020a056a20e68700b0019aef31e8a9mr1282400pzb.74.1705286199592; Sun, 14
 Jan 2024 18:36:39 -0800 (PST)
MIME-Version: 1.0
References: <20240104162942.211458-1-berrange@redhat.com>
 <CAJSP0QXUGgZdFaDKWUSjVNwHJXe+xz3Fq6WneP_=XS8htE9JYQ@mail.gmail.com>
In-Reply-To: <CAJSP0QXUGgZdFaDKWUSjVNwHJXe+xz3Fq6WneP_=XS8htE9JYQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Jan 2024 10:36:28 +0800
Message-ID: <CACGkMEtf0TeTSXg1PLrJQ31ehptuzgzyTmLxER2KDXp4GZa1kg@mail.gmail.com>
Subject: Re: [PATCH 0/6] net: fix non-deterministic failures of the
 'netdev-socket' qtest
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
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
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
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

On Fri, Jan 5, 2024 at 12:45=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.com=
> wrote:
>
> On Thu, 4 Jan 2024 at 11:30, Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
> >
> > We've previously bumped up the timeouts in the netdev-socket qtest
> > to supposedly fix non-deterministic failures, however, the failures
> > are still hitting CI.
> >
> > A simple 'listen()' and 'connect()' pairing across 2 QEMU processes
> > should be very quick to execute, even under high system load, so it
> > was never likely that the test was failing due to timeouts being
> > reached.
> >
> > The actual root cause was a race condition in the test design. It
> > was spawning a QEMU with a 'server' netdev, and then spawning one
> > with the 'client' netdev. There was insufficient synchronization,
> > however, so it was possible for the 2nd QEMU process to attempt
> > to 'connect()' before the 'listen()' call was made by the 1st QEMU.
> >
> > In the test scenarios that did not use the 'reconnect' flag, this
> > would result in the client QEMU never getting into the expected
> > state. The test code would thus loop on 'info network' until
> > hitting the maximum wait time.
> >
> > This series reverts the increased timeouts, and fixes synchronization
> > in the test scenarios. It also improves reporting of errors in the
> > socket netdev backend so that 'info network' reports what actually
> > went wrong rather than a useless generic 'connection error' string.
> > This will help us diagnose any future CI problems, should they occurr.
> >
> > Daniel P. Berrang=C3=A9 (6):
> >   Revert "netdev: set timeout depending on loadavg"
> >   Revert "osdep: add getloadavg"
> >   Revert "tests/qtest/netdev-socket: Raise connection timeout to 120
> >     seconds"
> >   net: add explicit info about connecting/listening state
> >   net: handle QIOTask completion to report useful error message
> >   qtest: ensure netdev-socket tests have non-overlapping names
> >
> >  include/qemu/osdep.h        | 10 ---------
> >  meson.build                 |  1 -
> >  net/stream.c                | 18 +++++++++++-----
> >  tests/qtest/netdev-socket.c | 42 +++++++------------------------------
> >  4 files changed, 21 insertions(+), 50 deletions(-)
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>

Queued.

Thanks


