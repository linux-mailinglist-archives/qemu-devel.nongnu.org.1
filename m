Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E82D803B2D
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 18:12:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rACSl-0004WR-By; Mon, 04 Dec 2023 12:10:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rACST-0004W8-QT
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 12:10:14 -0500
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rACSS-0005RG-1u
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 12:10:13 -0500
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-423f4a6144fso34638151cf.0
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 09:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701709811; x=1702314611; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fxXP7x7wm8x4qCS6WXEWMuklHrU0s1s4qnu1iGL5Eu0=;
 b=nreMSoGoNeESO3w2fCKjdRFiZy/0o5+ozY8pi2RdaLxpZmtP2YiFEWXQVM/yRBcM63
 wn3Ekll3egy9aCyEz0+Gz+nIewwJxQv6oOgMsOe1bpr8PNHCsVSuJyAZ8VJRhS+eVazM
 GNn9rDUax1RErYmeAuqvsbtlaAlnkENAovPNRj8zXmYbFdwUGnv1mxyksq4Xufve5c5F
 cyacw7gY0oOa0sbB69wI8Bcklx/qNnevSZ1zXWRAOuhvujVQi3pR0iqbKSEYPofyJydt
 5GCzZf2nNWVU1xob9YmrEB1A/GgY8H4f5XH/oXF/v5VtqitrhTm60btcpEpBK2A7VdrE
 prIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701709811; x=1702314611;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fxXP7x7wm8x4qCS6WXEWMuklHrU0s1s4qnu1iGL5Eu0=;
 b=HpLBQiWr1w6elKcDoBipaIV8AekDydj231aV2ixsQFfdpDDLpUcpj/QdKb7drXTfSF
 ceNQjiQbYtMUuri7npc9JLzqFHQdv4cmXAGMTWjOaPDQrzGy4kL2vyFLIgPTjZwmKuTI
 eBrE58Sjt62xwaRZ1G7c0jjeknoXzylF573++KPNvJ214cQQhOlcJaofAal+wWphLqyh
 B1DVPQAfj3bOu5dnHbZXk5ZPE9feturp9GR9OjKVb4Y6I2Ztw+50dF6MWg5e32CKwYQ5
 fd136d8O3JtTvjJ59F3GGmefiz4aSojmbYCxKuMzValiOcqim2gKnH/zhkSEhohuWt5u
 0GqQ==
X-Gm-Message-State: AOJu0YyqSzmgUu5xc+5t85auLZs+m3sNMq/b/998c2hXIczVcYV5bz1H
 kj8dthPgbct4ry1W68ok20cpPSs3dlIpVgnfU28=
X-Google-Smtp-Source: AGHT+IHbPvWzeA0pQwS9eHN9/6Ncu3LpzNJNLENN8RCwKKEtninekZWD83Mg3zbDofVkH6eOKpStZoQauF5/4Hh62vI=
X-Received: by 2002:ac8:5715:0:b0:425:4043:18bf with SMTP id
 21-20020ac85715000000b00425404318bfmr6763390qtw.114.1701709810932; Mon, 04
 Dec 2023 09:10:10 -0800 (PST)
MIME-Version: 1.0
References: <20231204163257.1011556-1-andrey.drobyshev@virtuozzo.com>
 <CAJ+F1CKni6vzAfPDefU8c-kRuhPDbzOohpC0bZ40WGOxLGGtmQ@mail.gmail.com>
 <d91b89b9-41bb-4968-ae46-438bae0b3952@virtuozzo.com>
In-Reply-To: <d91b89b9-41bb-4968-ae46-438bae0b3952@virtuozzo.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 4 Dec 2023 21:09:59 +0400
Message-ID: <CAJ+F1CLLp3z85KScYw07a21HKx2qjhtS7bzZ45x8e7xo--iLcQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "test/qga: use G_TEST_DIR to locate os-release
 test file"
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, kkostiuk@redhat.com, michael.roth@amd.com, 
 den@virtuozzo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82a.google.com
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

Hi

On Mon, Dec 4, 2023 at 9:01=E2=80=AFPM Andrey Drobyshev
<andrey.drobyshev@virtuozzo.com> wrote:
>
> On 12/4/23 18:51, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Mon, Dec 4, 2023 at 8:33=E2=80=AFPM Andrey Drobyshev
> > <andrey.drobyshev@virtuozzo.com> wrote:
> >>
> >> Since the commit a85d09269b QGA_OS_RELEASE variable points to the path
> >> relative to the build dir.  Then on qemu-ga startup this path can't be
> >> found as qemu-ga cwd is somewhere else, which leads to the test failur=
e:
> >>
> >>   # ./tests/unit/test-qga -p /qga/guest-get-osinfo
> >>   # random seed: R02S3a90c22d77ff1070fbd844f4959cf4a4
> >>   # Start of qga tests
> >>   **
> >>   ERROR:../tests/unit/test-qga.c:906:test_qga_guest_get_osinfo: 'str' =
should not be NULL
> >>   Bail out! ERROR:../tests/unit/test-qga.c:906:test_qga_guest_get_osin=
fo: 'str' should not be NULL
> >>
> >> Let's obtain the absolute path again.
> >
> > Can you detail how the build and the test is done?
> >
>
> Simple as:
>
> > ./configure --cc=3Dgcc --target-list=3Dx86_64-softmmu --enable-guest-ag=
ent && make -j16
> > cd build; tests/unit/test-qga -p /qga/guest-get-osinfo
>
>
> > If I recall correctly, this change was done in order to move qga to a
> > subproject(), but isn't strictly required at this point. Although I
> > believe it is more correct to lookup test data relative to
> > G_TEST_DIST.
> >
>
> Then we'd have to change cwd of qemu-ga at startup to ensure relative
> paths work.  Right now (with the initial change) it appears broken.

By reverting the patch, it is _still_ broken if you run the test
manually from a different directory (say from tests/unit for example)

With G_TEST_DIST, and proper testing environment, it works from any directo=
ry.

Tests are not meant to be run manually, you should run them through
the test runner: meson test -v test-qga

>
> >>
> >> This reverts commit a85d09269bb1a7071d3ce0f2957e3ca9dba7c047.
> >>
> >> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> >> ---
> >>  tests/unit/test-qga.c | 6 ++++--
> >>  1 file changed, 4 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/tests/unit/test-qga.c b/tests/unit/test-qga.c
> >> index 671e83cb86..47cf5e30ec 100644
> >> --- a/tests/unit/test-qga.c
> >> +++ b/tests/unit/test-qga.c
> >> @@ -1034,10 +1034,12 @@ static void test_qga_guest_get_osinfo(gconstpo=
inter data)
> >>      g_autoptr(QDict) ret =3D NULL;
> >>      char *env[2];
> >>      QDict *val;
> >> +    g_autofree gchar *cwd =3D NULL;
> >>
> >> +    cwd =3D g_get_current_dir();
> >>      env[0] =3D g_strdup_printf(
> >> -        "QGA_OS_RELEASE=3D%s%c..%cdata%ctest-qga-os-release",
> >> -        g_test_get_dir(G_TEST_DIST), G_DIR_SEPARATOR, G_DIR_SEPARATOR=
, G_DIR_SEPARATOR);
> >> +        "QGA_OS_RELEASE=3D%s%ctests%cdata%ctest-qga-os-release",
> >> +        cwd, G_DIR_SEPARATOR, G_DIR_SEPARATOR, G_DIR_SEPARATOR);
> >>      env[1] =3D NULL;
> >>      fixture_setup(&fixture, NULL, env);
> >>
> >> --
> >> 2.39.3
> >>
> >>
> >
> >
>


--=20
Marc-Andr=C3=A9 Lureau

