Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE0B83923A
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 16:12:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSIRQ-00056n-Kl; Tue, 23 Jan 2024 10:11:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manolodemedici@gmail.com>)
 id 1rSIRK-00056E-W4
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 10:11:51 -0500
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manolodemedici@gmail.com>)
 id 1rSIRJ-0002H3-CY
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 10:11:50 -0500
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7ba9f1cfe94so120613539f.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 07:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706022707; x=1706627507; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8wUzrOlceyvCurOGxZHU2BGBtWQu6vvOH9OzvCbQDAc=;
 b=Nh5HSlgjHUJQjtbMAtq71FGFpNXNrtd/jWZI54g8ld4RxIerNUgFkcQgbNi/Bj8/FZ
 tqYvQGnhvvd38MMSlF1G7f8Egh/PgH+/++3NGf/UcqcARffZ2kGRGCwdvvqGLcRHQfuc
 rLDx54hHs8rEtIyCyvlbiqkFqqluBAqeN03HX4iEyqTWASHZvOJQ8XX7RhJWeWgaoCm7
 b8p6yjYdh+S3wHlIr1EqSJvxdN5b1DSfprFpiZRSMu9Rx5/y2zgw+Xn+AMcjrPUrznrP
 ZP6hRXnQhx3EHRf3zDrehrsQ/OJ4aNldQjsf7bgjSS/pH8CDFaAZtMNyjj57RTQT5Izz
 O2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706022707; x=1706627507;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8wUzrOlceyvCurOGxZHU2BGBtWQu6vvOH9OzvCbQDAc=;
 b=KVDG/8T42Yn3RH1pqkEvFqs4SqIJOEzm0YAiJSUamHWF8cl8DEEmIRR5KNx0sxvVMr
 bZ7iOxXA1hZOKiTNCsIKJiUYidZe4CD2Zv9mvB21vAV2MVeztx8geuR2prwq08rhIx8Y
 2QWP2AIu4dceyic36cwFKUHjLTeeVGumMsbGeVr7QQ8Q7TbVaY+TeWxsxGyjK4NH/XGb
 ZyZQeH+ylMTpxa30o7OAUR8r9/5UEdpmvbRMk9g98OLuHeC+fRRPnI77dauuNTlzwT+S
 6ZqBUF14PTeF9HMC4qcbvNNRJur+7pZ5PKtnN+kUDtos7IrgXQSzMKiTqtFeRkaFJRm5
 I5HQ==
X-Gm-Message-State: AOJu0YxFuqa9KqiRC1IIPmUXcdkIQJOFQYeYiwT8BlBoUz/sTtXBd10J
 DW6aN8tmAUvWCrCr8jeOSiHeEW4SnxQLKlBk20h3/svDMLQz2AZ2r+aWLWluLeeuupulgRE4KAd
 8IBjHCA/BScIJWFJwE1sJzTYNHbg=
X-Google-Smtp-Source: AGHT+IG+4/wqUL2Gw0N+1GVD8OpwpTBQRliXV5Hf1CddDuWHxhQyqD984+n+8vH4uJOjSalSI3xZ6hexURLw/7E0VVc=
X-Received: by 2002:a05:6e02:1c02:b0:362:7b2c:12b3 with SMTP id
 l2-20020a056e021c0200b003627b2c12b3mr2560324ilh.22.1706022707622; Tue, 23 Jan
 2024 07:11:47 -0800 (PST)
MIME-Version: 1.0
References: <CAHP40m=UQ=F1-Vy4-wR18RjqzF9o+8UOjgpUsrTU8QXn=7eAeA@mail.gmail.com>
 <CAFEAcA-6Eb-XDBYkcK4rbDcavNU7pY4dWHeQvVa4MFODBKiWsA@mail.gmail.com>
In-Reply-To: <CAFEAcA-6Eb-XDBYkcK4rbDcavNU7pY4dWHeQvVa4MFODBKiWsA@mail.gmail.com>
From: Manolo de Medici <manolodemedici@gmail.com>
Date: Tue, 23 Jan 2024 16:11:41 +0100
Message-ID: <CAHP40mm_HmNUAPMcTz9-NskLA3ckFWK0Zb+iV+CvKq2s6s81NQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Port qemu to GNU/Hurd
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, bug-hurd@gnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2a;
 envelope-from=manolodemedici@gmail.com; helo=mail-io1-xd2a.google.com
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

Thank you, I see that there is an issue and I'll take care of fixing
it in the future

On Mon, Jan 22, 2024 at 5:53=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Thu, 18 Jan 2024 at 16:02, Manolo de Medici <manolodemedici@gmail.com>=
 wrote:
> >
> > Recently, a testsuite for gnumach, the GNU/Hurd microkernel, was develo=
ped
> > that uses qemu. Currently qemu cannot be compiled for the GNU/Hurd, as =
such,
> > this testsuite is available only for GNU/Linux users.
> >
> > This patcheset allows qemu compilation in GNU/Hurd. With this patchset =
applied,
> > qemu can be compiled without any special configure options.
> >
> > Please review, thanks,
> >
> > Manolo de Medici (4):
> >   Include new arbitrary limits if not already defined
> >   Avoid conflicting types for 'copy_file_range'
> >   Add the GNU/Hurd as a target host
> >   Exclude TPM ioctls definitions for the GNU/Hurd
>
> Hi -- something odd seems to have happened with these patchset
> emails. The cover letter got to the list:
> https://lore.kernel.org/qemu-devel/CAHP40m=3DUQ=3DF1-Vy4-wR18RjqzF9o+8UOj=
gpUsrTU8QXn=3D7eAeA@mail.gmail.com/
>
> but it doesn't have any of the patches as followup emails
> in the thread. Instead they got sent as entirely separate
> emails, eg here's patch 1:
> https://lore.kernel.org/qemu-devel/CAHP40mmk4cPk6ZHETfq5BtQxK63A6PiuCKrvv=
4yyOPBxVTW+OQ@mail.gmail.com/
>
> This means the automated patch tooling thinks none of the patches
> arrived, eg patchew says "0 patches received":
> https://lore.kernel.org/qemu-devel/CAHP40mmk4cPk6ZHETfq5BtQxK63A6PiuCKrvv=
4yyOPBxVTW+OQ@mail.gmail.com/
>
> git format-patch can help in getting this right (it is its
> "--thread=3Dshallow" style).
>
> For this version, I'll send some review comments to the
> individual patch emails, but it would be nice to get this
> right on v3.
>
> thanks
> -- PMM

