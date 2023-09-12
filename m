Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D72D79D365
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 16:17:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg4Ca-0003RC-SX; Tue, 12 Sep 2023 10:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qg4CJ-0003Hk-7U
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 10:17:02 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qg4CG-0001F4-EW
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 10:16:58 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3aa1254fb45so3822083b6e.2
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 07:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694528215; x=1695133015; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n4nO0CNFo/AJ8ekQgl0srrAJCty0ENBSuksw9RCAkPM=;
 b=ZyulT8BDsmzyTuBC3rENWyG+liE6elPlwB8v5SSHZ7rtlwQt69ego1zri9tz8Qi8lF
 r047pjJv8D0HdTqOfRDOntnKLcOJJqj8vNFjSldEAALBu5K1jHtx7EucpzUbt9CqZseJ
 yaHPflV4vOw4hm6nFkrtax5xSF44wyiOivkoeBlmwb5ytLmX0DUWQbH8fbtLxGKr7yfb
 HW4ITJUfNENfydS6mUIsY5vDBRSgaOdb2ZS7FAQmdLvhBsQad5L/Be1NJ5LLvPvhNdlv
 tN2kxwWcfznIbDA+qvGRECBeBmy3Yn236zR520sX4Of1Nue5WarpgbAWWZxs/0dxQi+g
 5RhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694528215; x=1695133015;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n4nO0CNFo/AJ8ekQgl0srrAJCty0ENBSuksw9RCAkPM=;
 b=uyVYQlDtm4DKnKLpZLFo9vOC7UVdtNPOXXbmGc+cUziEV+NqWJSyIbZdBU/r2q682+
 cwGV7YKjN5wQgRP82zPo1Vz9FnGzfvLiG34w0kP1pGEHgCRAVgGh8C3aM9Ie4flXYzwP
 AeGcQ7kNt7zHmtT7qUOj83OY7KEYrKFoB4MXQGn8JPwkOzE6+T53Z2W/ONgAnHK6lAc2
 ZmPGKSXzHBX6Dd6tEzvSDFkR2KABfriySmkeCzRheXUhn/2iQXHRIAPjKqACkrmrPZd8
 2pRp31+6GOdkLtalJBY88SIRVwEw0nR3bVIqgroSaiEIa6CGtOGFALVk2OkcDKbD5im/
 8FRw==
X-Gm-Message-State: AOJu0Yz5mr3vHup921jYSne/H6lUFKZjpeU0xFVWDOkavEP/vClg+Z9q
 xmRCXqART27lwBaGonQaBZ90dhUIICzEBkpbZ2mYaem/Pgg=
X-Google-Smtp-Source: AGHT+IHnLBzoAX3NDfaWLUeuds9h4vSck/xSWwzyV3N32uI9GUIixP43lDUGIKS2LhqqH1FeSHYt5z4dkROrLZNWv3w=
X-Received: by 2002:a54:478a:0:b0:3a7:4914:23ce with SMTP id
 o10-20020a54478a000000b003a7491423cemr12273936oic.18.1694528215043; Tue, 12
 Sep 2023 07:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230912133310.60583-1-stefanha@redhat.com>
 <ZQBqqu9NNygDhBAM@redhat.com>
 <479c6698-2f32-6771-b758-28d85f100963@redhat.com>
In-Reply-To: <479c6698-2f32-6771-b758-28d85f100963@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 12 Sep 2023 10:16:43 -0400
Message-ID: <CAJSP0QWfgMiRpgSKqZ=VG=xF=SPuiUeH34d8Pir5kTDqM-DRwA@mail.gmail.com>
Subject: Re: [PATCH] tests/qtest/netdev-socket: Raise connection timeout to
 120 seconds
To: Laurent Vivier <lvivier@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=stefanha@gmail.com; helo=mail-oi1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Here is a log from the CI, but I don't think it has much information:
https://gitlab.com/qemu-project/qemu/-/jobs/5020899550

Is it possible to detect the crash? Timeouts are hard to diagnose, so
it would be better for the test to detect a terminated child process
and print an error.

Stefan

On Tue, 12 Sept 2023 at 10:08, Laurent Vivier <lvivier@redhat.com> wrote:
>
> On 9/12/23 15:42, Daniel P. Berrang=C3=A9 wrote:
> > On Tue, Sep 12, 2023 at 09:33:10AM -0400, Stefan Hajnoczi wrote:
> >> The test still fails intermittently with a 60 second timeout in the
> >> GitLab CI environment. Raise the timeout to 120 seconds.
> >>
> >>    576/839 ERROR:../tests/qtest/netdev-socket.c:293:test_stream_unix: =
assertion failed (resp =3D=3D expect): ("st0: index=3D0,type=3Dstream,conne=
ction error\r\n" =3D=3D "st0: index=3D0,type=3Dstream,unix:/tmp/netdev-sock=
et.UW5IA2/stream_unix\r\n") ERROR
> >>    576/839 qemu:qtest+qtest-sh4 / qtest-sh4/netdev-socket             =
               ERROR          62.85s   killed by signal 6 SIGABRT
> >>    >>> MALLOC_PERTURB_=3D249 QTEST_QEMU_BINARY=3D./qemu-system-sh4 QTE=
ST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-daemon/qemu-storage-daemon G_TEST=
_DBUS_DAEMON=3D/home/gitlab-runner/builds/-LCfcJ2T/0/qemu-project/qemu/test=
s/dbus-vmstate-daemon.sh QTEST_QEMU_IMG=3D./qemu-img /home/gitlab-runner/bu=
ilds/-LCfcJ2T/0/qemu-project/qemu/build/tests/qtest/netdev-socket --tap -k
> >>    =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80  =E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95
> >>    stderr:
> >>    **
> >>    ERROR:../tests/qtest/netdev-socket.c:293:test_stream_unix: assertio=
n failed (resp =3D=3D expect): ("st0: index=3D0,type=3Dstream,connection er=
ror\r\n" =3D=3D "st0: index=3D0,type=3Dstream,unix:/tmp/netdev-socket.UW5IA=
2/stream_unix\r\n")
> >>    (test program exited with status code -6)
> >>
> >> Buglink: https://gitlab.com/qemu-project/qemu/-/issues/1881
> >> Fixes: 417296c8d858 ("tests/qtest/netdev-socket: Raise connection time=
out to 60 seconds")
> >> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> >
> > That bumped the timeout from 5 seconds to 60 seconds to
> > cope with intermittent failures, which was a x12
> > increases. I'm concerned that it would still be failing
> > in largely the same way after that, and possibly we are
> > instead hitting a race condition causing setup to fail,
> > which masquerades as a timeout.
> >
> >> ---
> >>   tests/qtest/netdev-socket.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/tests/qtest/netdev-socket.c b/tests/qtest/netdev-socket.c
> >> index 8eed54801f..b2501d72a1 100644
> >> --- a/tests/qtest/netdev-socket.c
> >> +++ b/tests/qtest/netdev-socket.c
> >> @@ -16,7 +16,7 @@
> >>   #include "qapi/qobject-input-visitor.h"
> >>   #include "qapi/qapi-visit-sockets.h"
> >>
> >> -#define CONNECTION_TIMEOUT    60
> >> +#define CONNECTION_TIMEOUT    120
> >>
> >>   #define EXPECT_STATE(q, e, t)                             \
> >>   do {                                                      \
> >
> > I'll add
> >
> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> >
> > but with the caveat that i'm only 50/50 on whether this is actually
> > the right fix. Doesn't hurt to try it, but if 120 seconds still shows
> > failures I'd say we're hitting a functional race not a timeout.
>
> It can also happen if the first QEMU (server) crashes. Do we have some tr=
aces from this side?
>
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
>
> Thanks,
> Laurent
>
>

