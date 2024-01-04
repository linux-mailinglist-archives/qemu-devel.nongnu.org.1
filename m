Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A7982468D
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 17:46:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLQr1-0000xa-2a; Thu, 04 Jan 2024 11:45:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rLQqr-0000ws-Nb
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:45:50 -0500
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rLQqp-0001gI-Rp
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:45:49 -0500
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-596263ec75eso249434eaf.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 08:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704386746; x=1704991546; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E1GuCTQ4mjN8LhvR+xiWp8dEAiJmIDE7wozLC/dBC2E=;
 b=DCPSJCvo7LapPZw6nIMzpE1Hye7c451l+LXlKP8J61PkdhdOHRAA9Qux1SIzRcJKSt
 UR0CAravH+MFgqoOG+4vc19gPCl5fiRJfXDxZCGEcg3cLmYIEl0fz3F0KmP2jogbHG4A
 BfMJeHz0WPVf+M5LrzDDir9y0qyfc7RCgX2NljdIuTW77rVHF7AS2MJ+fAx2r0JY3kRf
 QM7skah/svg/L/VZiNczMkL0YUAuiaoxhCoTtPHFJQ5NXTd4fWh6Ys/Y7tjIvuRc5h2W
 ghkQDEN9lARUeq4Jpa155uaXib1tvDiauM7KOzUQ434lWHVtwqp7XNLk2ioLZJLG362x
 5hOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704386746; x=1704991546;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E1GuCTQ4mjN8LhvR+xiWp8dEAiJmIDE7wozLC/dBC2E=;
 b=YgYhrBcofaE7z5pX8d0YBKGv8Fiv8trR4SKuTCgSDLUgBCU6czbcmdrgWTq01QcZ5L
 YArw1+TZbbs1NKsrWe6bMEfKXTOdaEBRLn3MhCP9seoD7jfQj/MDUQAf7oouhrSiGhM+
 +MHqoIwLuQnuf3iXRjOxKS2d0hOOAc/85p7E9+Kexkn8ULBXFTXTQ+zSrOnmXqYK1v+u
 sdnJDGl5P+J9gj2NjyWk86rCottptEuCFoYv6414eQL+CS3naujugSiYRO2gdrEETq/R
 2jzo503Sa8HS+K3eHBwNemxvRApjlIbZKE0VH+bEBQtUQ3njJ+XZrybz/sNNWLY4Q/xS
 QplA==
X-Gm-Message-State: AOJu0YwLg//y0z9G4t3wEXzEDH7GJ3eSqk+Reaa29WBtWsjmzMFsJWKc
 NedlMx2iAzTjSG60m9dqBxaqbXtRZJQrl1qmaAs=
X-Google-Smtp-Source: AGHT+IGb70MJ3HKTVY2mYDcuTJqTKUE/Pp2ub4AnbVFq1zMy6WLEVsorXYdQbyejFuE96J31ebhUFyaWQ/WZHjdL4k4=
X-Received: by 2002:a4a:643:0:b0:591:c8d7:aa80 with SMTP id
 64-20020a4a0643000000b00591c8d7aa80mr846205ooj.14.1704386746423; Thu, 04 Jan
 2024 08:45:46 -0800 (PST)
MIME-Version: 1.0
References: <20240104162942.211458-1-berrange@redhat.com>
In-Reply-To: <20240104162942.211458-1-berrange@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 4 Jan 2024 11:45:34 -0500
Message-ID: <CAJSP0QXUGgZdFaDKWUSjVNwHJXe+xz3Fq6WneP_=XS8htE9JYQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] net: fix non-deterministic failures of the
 'netdev-socket' qtest
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2c.google.com
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

On Thu, 4 Jan 2024 at 11:30, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> We've previously bumped up the timeouts in the netdev-socket qtest
> to supposedly fix non-deterministic failures, however, the failures
> are still hitting CI.
>
> A simple 'listen()' and 'connect()' pairing across 2 QEMU processes
> should be very quick to execute, even under high system load, so it
> was never likely that the test was failing due to timeouts being
> reached.
>
> The actual root cause was a race condition in the test design. It
> was spawning a QEMU with a 'server' netdev, and then spawning one
> with the 'client' netdev. There was insufficient synchronization,
> however, so it was possible for the 2nd QEMU process to attempt
> to 'connect()' before the 'listen()' call was made by the 1st QEMU.
>
> In the test scenarios that did not use the 'reconnect' flag, this
> would result in the client QEMU never getting into the expected
> state. The test code would thus loop on 'info network' until
> hitting the maximum wait time.
>
> This series reverts the increased timeouts, and fixes synchronization
> in the test scenarios. It also improves reporting of errors in the
> socket netdev backend so that 'info network' reports what actually
> went wrong rather than a useless generic 'connection error' string.
> This will help us diagnose any future CI problems, should they occurr.
>
> Daniel P. Berrang=C3=A9 (6):
>   Revert "netdev: set timeout depending on loadavg"
>   Revert "osdep: add getloadavg"
>   Revert "tests/qtest/netdev-socket: Raise connection timeout to 120
>     seconds"
>   net: add explicit info about connecting/listening state
>   net: handle QIOTask completion to report useful error message
>   qtest: ensure netdev-socket tests have non-overlapping names
>
>  include/qemu/osdep.h        | 10 ---------
>  meson.build                 |  1 -
>  net/stream.c                | 18 +++++++++++-----
>  tests/qtest/netdev-socket.c | 42 +++++++------------------------------
>  4 files changed, 21 insertions(+), 50 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

