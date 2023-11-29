Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4858E7FE067
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 20:43:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8QRc-0003Ht-8h; Wed, 29 Nov 2023 14:42:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r8QRX-0003HI-3y
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 14:41:56 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r8QRV-0001nO-G9
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 14:41:54 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-54bd7e5182cso260845a12.0
 for <qemu-devel@nongnu.org>; Wed, 29 Nov 2023 11:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701286911; x=1701891711; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=572tFnImS4KTm2pG7ZiqsXMrCZAo9D13blSFZtmGxKQ=;
 b=Ap6S8K+n7dyXMqKVGSz2WgOpmedPKcDXIbzQabosb/OljNusjctErtK9JEwDWryZGg
 40KzVdnt25eJFlfzZ4U/CpcJ50T4zxZUBCz7EMmjjmTgj2YYMex2OgiMzS9jtrax1mN/
 m6oZqPOt/+OfpEfc3nK1+Vs+bBrEBYvfIE6GyNk/x4yhqhJIYB6rKGMhIwilPy+2O1Uj
 XXJq2dgB6EctPLedODv7W7CQUcCPrZZIWUbSnPRqDyysh2OFVX+2L9noRBd11Iz5Hvaa
 WVG0T+ffamLdQ6EbWgy9bKom1CC3prxR3Hjb6MAUDT67nmToybchaDEiBrce4EPi7prN
 NX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701286911; x=1701891711;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=572tFnImS4KTm2pG7ZiqsXMrCZAo9D13blSFZtmGxKQ=;
 b=c85M8P1F2MUgGM+8k8ROwcACjFZPVvK3qvsI1nsZ4qY25xA7x/bOkghjKJ3vkeyUsM
 VrP1kr48zgCMdrMeD6gTmN36h9QnkwZ+QpKCUB7G9hW9UbpddU67iDmDFxQjV5YUQBSt
 Fp9yMl2QSfIIgAJLs2FUV6chmJm66+fafw8xgz0EYYIOOmuyvoua91agSwjcQ/dX7Ih7
 XksF8IMgoaahD4TXvkkNRT94R7Y2uhoM+7nBMPD4/dcwRc5c+gq1t6ymv0Zuv7qnZMMX
 5rYW9FKxcWpRhV9OVXrtVatOQnGU0wUUVfKnhRx+481SnLKq06z4NHIO0pwcnQTHojWi
 AIlg==
X-Gm-Message-State: AOJu0YzmLOap1bUT0lh86Jo8/RYLMswcEo9VgX5+1TbKH1y/9WYdvspa
 +TTMTQuHeG4k+wX1XKSsNO7WinA37ir9pHAxiFLXmA==
X-Google-Smtp-Source: AGHT+IFbQHaM8DxzQSRkOO7RlThBpDKT3c+EcLZpiQtr0rpcP3XzZvJxM7QEU75yK85XX1zSBM37kLMI2COUV7oeYRw=
X-Received: by 2002:a05:6402:5143:b0:54b:2894:d1d8 with SMTP id
 n3-20020a056402514300b0054b2894d1d8mr9742546edd.27.1701286910983; Wed, 29 Nov
 2023 11:41:50 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA_rziBuSwgJ9cg9m1PS5pNG58eyim+_P9hMu5nF7G70XA@mail.gmail.com>
 <87edgjf2v4.fsf@draig.linaro.org>
 <ef77ed27-8b95-480e-97da-8e0c53bf3aa1@redhat.com>
 <ZWYsMsgxjDZ_T2zA@redhat.com>
 <CANCZdfq6dPArtLjwAbV9MxQnR6pOn6MR+gB7eTogUyw8WuyjCw@mail.gmail.com>
 <ZWdrhGhmY--yUluR@redhat.com>
In-Reply-To: <ZWdrhGhmY--yUluR@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 29 Nov 2023 19:41:09 +0000
Message-ID: <CAFEAcA830vK7nAMi2oxeLek_PsJw_F81gUE7PY6029OevG-kFA@mail.gmail.com>
Subject: Re: QEMU Summit Minutes 2023
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Warner Losh <imp@bsdimp.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Wed, 29 Nov 2023 at 16:49, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Wed, Nov 29, 2023 at 08:50:06AM -0700, Warner Losh wrote:
> > I'd honestly optimize for 'frequent merges of smaller things' rather th=
an
> > 'infrequent merges of larger things'. The latter has caused most of the
> > issues for me. It's harder to contribute because the overhead of doing =
so
> > is so large you want to batch everything. Let's not optimize for that
> > workaround for the high-friction submission process we have now. If the=
re's
> > always smaller bits of work going in all the time, you'll find few comm=
it
> > races... though the CI pipeline is rather large, so having a ci-staging
> > branch to land the MRs to that have completed CI, but not CI on the tip=
,
> > might not be bad... but the resolution of conflicts can be tricky, thou=
gh
> > infrequent, so if a ci-staging branch bounces, all MRs would need to be
> > manually requeued after humans look at why and think through who needs =
to
> > talk to whom, or if it's just a 'other things landed before you could g=
et
> > yours in and it's not the ci-staging being full of other people's commi=
ts
> > that is at fault.
>
> I agree. Right now we tend to have fairly large pull requests, because
> people are concious of each pull request consuming non-trivial resources
> from the release maintainer. If this new MR based approach reduces the
> load on the release maintainer, then sending frequent small pull requests
> is almost certainly going to be better.

FWIW, in the current system also I would recommend submitting
smaller pullrequests rather than large ones. For me when I'm doing
release handling, pushing pullreqs through the process is not
that difficult. The problems come when there are test failures
that need to be tracked down, and those are more likely to be
problematic if they're in the middle of a huge pullreq than
if they're in a smaller one.

Plus waiting means things don't get into the tree as soon, which
just extends the timelines on things.

thanks
-- PMM

