Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B05707CB342
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 21:19:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsT7H-00044A-Kn; Mon, 16 Oct 2023 15:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qsT7F-00043w-68; Mon, 16 Oct 2023 15:19:01 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qsT7D-00059C-6G; Mon, 16 Oct 2023 15:19:00 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-57de6e502fcso2902590eaf.3; 
 Mon, 16 Oct 2023 12:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697483937; x=1698088737; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Abai2VdYfpt//HzolIIW+ijw1I5Xo4cXzopFhjpqd8M=;
 b=IpW2VjN6YhSTps/kVr/vGvtY9laa3NwhHzbmZIdtWhw1itiVkSp7rcZqKG0H/UoHev
 l1zRnCXAW8ia46WVp2yyADrY3I1nfAF4/1LRSH+0i7iVSnX4LKtHeaW+tP2JbW0ejnkA
 l/yogf3ds8pW6fWlBNHEjw59C8ewWwiAEqo9uxcsTau05TTSkb2xgDewdZ9ar7evLx/H
 4M8NEPP8XeLkaZJguIQxS97bmCZrWUvDpAyJF48lNSeEnR75Qsoku80Vhs4s2Obm7Mtq
 9Feh1B22QuhmsJEDKe3LfMzIIloyMO7oC6IJEXdYLibIJXGew4LyEC8u00MeUhA5WVnh
 CRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697483937; x=1698088737;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Abai2VdYfpt//HzolIIW+ijw1I5Xo4cXzopFhjpqd8M=;
 b=HKTEoEmmeGDLw1vFJWsDBB/OIKf6mJ/npq1AZh362VD5MDkE7FXkeC+P5AzrNBDIig
 EAXhSP288MXJNTaxAnDJHWIuhpBQ+j1k5o4ZwW6eWaO0XKU+Un1djuCrCJxPF21Q5SNq
 +YisAqBqxiDz/oPKtEQgOUj+O9Z8QbnGoGj6AUEkRYaR+2pMUAHB65q3MLq18WZCRh1I
 zyu73AiXdySpEFRvJB5raFQMsNFaMjPEZikunuPz9RLkl6HAOrzVnXSZfcN28/vkO/gi
 LZhedZgq1CwhCbzUdRSqY7KVenPpTp1I6Q+s5MRHkG1zxnz2a4O4+lZ3CNeov3LgsAQH
 Fn7w==
X-Gm-Message-State: AOJu0YxUbpJ7j4IjRkpMkQw66EWKtalglohZJVe82B7u7EcNqbEyXbZu
 jEUJw0bVO/pOvWGbY1I23hiEMF3yAAF5RgBIn8Y=
X-Google-Smtp-Source: AGHT+IG31NIzGh+rrz38F3aNy0oWdv/ZFIfx0m4+ci519b0kYSPp1NKHcLDFuW0HnJ/vRwyj6jOt63TqggW/Kiy25xY=
X-Received: by 2002:a4a:6c02:0:b0:57b:6d88:4cb3 with SMTP id
 q2-20020a4a6c02000000b0057b6d884cb3mr33356852ooc.5.1697483937660; Mon, 16 Oct
 2023 12:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <20231016100706.2551-1-quintela@redhat.com>
 <CAJSP0QXkTvJnioak5X1Ya3CC6LmiriFqYhyUV+AJ4=JS4SK97w@mail.gmail.com>
 <87wmvmze0g.fsf@suse.de>
In-Reply-To: <87wmvmze0g.fsf@suse.de>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 16 Oct 2023 15:18:45 -0400
Message-ID: <CAJSP0QVaUrcpNT8qPM_4s6=OO3N0XA-nK68scoQYrbqavYZZoQ@mail.gmail.com>
Subject: Re: [PULL 00/38] Migration 20231016 patches
To: Fabiano Rosas <farosas@suse.de>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fam Zheng <fam@euphon.net>, 
 Cleber Rosa <crosa@redhat.com>, Eric Blake <eblake@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, 
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Leonardo Bras <leobras@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc36.google.com
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

On Mon, 16 Oct 2023 at 13:13, Fabiano Rosas <farosas@suse.de> wrote:
>
> Stefan Hajnoczi <stefanha@gmail.com> writes:
>
> > On Mon, 16 Oct 2023 at 06:11, Juan Quintela <quintela@redhat.com> wrote=
:
> >>
> >> The following changes since commit 63011373ad22c794a013da69663c03f1297=
a5c56:
> >>
> >>   Merge tag 'pull-riscv-to-apply-20231012-1' of https://github.com/ali=
stair23/qemu into staging (2023-10-12 10:24:44 -0400)
> >>
> >> are available in the Git repository at:
> >>
> >>   https://gitlab.com/juan.quintela/qemu.git tags/migration-20231016-pu=
ll-request
> >>
> >> for you to fetch changes up to f39b0f42753635b0f2d8b00a26d11bb197bf51e=
2:
> >>
> >>   migration/multifd: Clarify Error usage in multifd_channel_connect (2=
023-10-16 11:01:33 +0200)
> >>
> >> ----------------------------------------------------------------
> >> Migration Pull request (20231016)
> >>
> >> In this pull request:
> >> - rdma cleanups
> >> - removal of QEMUFileHook
> >> - test for analyze-migration.py
> >> - test for multifd file
> >> - multifd cleanups
> >> - available switchover bandwidth
> >> - lots of cleanups.
> >>
> >> CI: https://gitlab.com/juan.quintela/qemu/-/pipelines/1037878829
> >>
> >> Please, apply.
> >
> > This CI failure looks migration-related:
> >
> > MALLOC_PERTURB_=3D96
> > PYTHON=3D/home/gitlab-runner/builds/-LCfcJ2T/0/qemu-project/qemu/build/=
pyvenv/bin/python3
> > QTEST_QEMU_BINARY=3D./qemu-system-i386
> > G_TEST_DBUS_DAEMON=3D/home/gitlab-runner/builds/-LCfcJ2T/0/qemu-project=
/qemu/tests/dbus-vmstate-daemon.sh
> > QTEST_QEMU_IMG=3D./qemu-img
> > QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-daemon/qemu-storage-daemon
> > /home/gitlab-runner/builds/-LCfcJ2T/0/qemu-project/qemu/build/tests/qte=
st/migration-test
> > --tap -k
> > =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80 =E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95
> > stderr:
> > **
> > ERROR:../tests/qtest/migration-test.c:1969:file_offset_finish_hook:
> > assertion failed (cpu_to_be32(*p) =3D=3D QEMU_VM_FILE_MAGIC): (3 =3D=3D
> > 1363498573)
>
> That's the test for the file: transport which got merged in the last
> PR. I'll look into it.

I have dropped the 20231016 pull request for now and the tests passed
without it. Maybe there is an interaction with the test you recently
added and this pull request?

Stefan

