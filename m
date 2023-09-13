Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 264DE79F263
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 21:53:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgVuH-0000R5-9r; Wed, 13 Sep 2023 15:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qgVuF-0000Qs-V1
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 15:52:11 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qgVu9-0002ek-Uv
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 15:52:11 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6c0d6fef60cso112704a34.1
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 12:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694634725; x=1695239525; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rItP7555jaUdAH5ZQQjOn3jS/THeT9ArDz6i7bcroGg=;
 b=ETDgZXcM+F5AXlqcXaHwitibWysv5V56iBPoFfiYJpAaDiL5oQoJXCxk8QszsNSvip
 g9TV0TZq1mpSYfzgjlz0pF2mzBMl5HydJ15Pf1RseHG4lzkQ4z7IxAdGn+sq9Ao/6VJo
 Fhj241+drEVqEMLVMPIvDMoK2nQIa0/t9RqAkv2dg9dLyL7WIHETv+u/+K3ZOSPDSfT0
 nHwRWFRwrJVWPftq6mx7f6vsPAnuU2mNQWHkbp1R1/akRLomAhNRf53T2ItRuDzQQ1zz
 gJaamdRHNW0qgWidcjzkncgydQAiYaGpVYYg7pkkUJe3nIQKMRFbb9ULozIHFPZO0LgH
 w2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694634725; x=1695239525;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rItP7555jaUdAH5ZQQjOn3jS/THeT9ArDz6i7bcroGg=;
 b=HXT9AHzrcuXBSCuuYpmuhxOeT6wtplbCusToDdOvgAhlfF8iNwEGGajxMZTpcwBEN/
 i9QD2ad7Aai2xY8LpgUeJcgCHG5fSWnfdrdVEEfddJvVm8MIFyaA0mnqqcdrHsgHbXuw
 nWMLwFz4XzRmugyh3XtdWZohpV3s5YR4UMd1GsJoa8m7AEo/6vM+GM7lmXcL5Fuwl/wm
 ACVCTdp10NuqjTPKs4HjDm7IwU50XheZPlP1lx6U4eKPxnRCd60frwvGqxJfqkKxPueP
 u/5IsQhsqMkwkV8Wvlfgg9aDZbmBfl5IHBmkAoXVhTj0qa9XvF3qGvIGI5GO8jPLZyHP
 kY8w==
X-Gm-Message-State: AOJu0YxCTg7PRloUuRJ+Fb1PHKabfWCCbNFw/AbBSGQscQkh6AINb6Cu
 AYTKiNzRRxAs93zVfBrvc3CXjM34z9sH8Q2Bxwk=
X-Google-Smtp-Source: AGHT+IEBNfU3bz01f/fDzM8hUChihCYJYuIogiLYOsPBKF+Sg/nI8/tdAjoS4EG+UsyRFVWbxw9JLK/smbXPBvaUaqg=
X-Received: by 2002:a9d:6d94:0:b0:6b9:e3b0:1433 with SMTP id
 x20-20020a9d6d94000000b006b9e3b01433mr3828262otp.37.1694634724794; Wed, 13
 Sep 2023 12:52:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230913192301.GA917052@fedora> <87r0n1kggo.fsf@suse.de>
In-Reply-To: <87r0n1kggo.fsf@suse.de>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 13 Sep 2023 15:51:51 -0400
Message-ID: <CAJSP0QVsULczSQhk9DHd6iBQO7=+tie-uW_=1+TcWCzgK=WW_Q@mail.gmail.com>
Subject: Re: QEMU migration-test CI intermittent failure
To: Fabiano Rosas <farosas@suse.de>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=stefanha@gmail.com; helo=mail-ot1-x32f.google.com
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

On Wed, 13 Sept 2023 at 15:44, Fabiano Rosas <farosas@suse.de> wrote:
>
> Stefan Hajnoczi <stefanha@redhat.com> writes:
>
> > Hi,
> > The following intermittent failure occurred in the CI and I have filed
> > an Issue for it:
> > https://gitlab.com/qemu-project/qemu/-/issues/1886
> >
> > Output:
> >
> >   >>> QTEST_QEMU_IMG=3D./qemu-img MALLOC_PERTURB_=3D116 QTEST_QEMU_STOR=
AGE_DAEMON_BINARY=3D./storage-daemon/qemu-storage-daemon G_TEST_DBUS_DAEMON=
=3D/builds/qemu-project/qemu/tests/dbus-vmstate-daemon.sh QTEST_QEMU_BINARY=
=3D./qemu-system-x86_64 /builds/qemu-project/qemu/build/tests/qtest/migrati=
on-test --tap -k
> >   =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80  =E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95
> >   stderr:
> >   qemu-system-x86_64: Unable to read from socket: Connection reset by p=
eer
> >   Memory content inconsistency at 5b43000 first_byte =3D bd last_byte =
=3D bc current =3D 4f hit_edge =3D 1
> >   **
> >   ERROR:../tests/qtest/migration-test.c:300:check_guests_ram: assertion=
 failed: (bad =3D=3D 0)
> >   (test program exited with status code -6)
> >
> > You can find the full output here:
> > https://gitlab.com/qemu-project/qemu/-/jobs/5080200417
>
> This is the postcopy return path issue that I'm addressing here:
>
> https://lore.kernel.org/r/20230911171320.24372-1-farosas@suse.de
> Subject: [PATCH v6 00/10] Fix segfault on migration return path
> Message-ID: <20230911171320.24372-1-farosas@suse.de>

Awesome, thanks!

Stefan

