Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EC97FDD9D
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 17:50:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8Nka-0000P2-SQ; Wed, 29 Nov 2023 11:49:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r8NkW-0000Nw-Lk
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 11:49:20 -0500
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r8NkV-0006cQ-5t
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 11:49:20 -0500
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-58d54fd8c5aso2275130eaf.2
 for <qemu-devel@nongnu.org>; Wed, 29 Nov 2023 08:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701276557; x=1701881357; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vRf8tbT+Ph99HG9WyHarJPNebgXtZ037qc+bMvnnmMw=;
 b=jDHanwmCZ5CS9QOtPnf4sJfnU+M8t6eGRbocKoPkCmwKNXpsT6793qevjvhRew40HD
 LMpjk6Oi/QtfkvRV77Edjgy6hivfI5UtavVoIaAAbFreDfcD6npr4VWZ4a0N/kYrOHkd
 uOsaajsUhkWr0tEGzUnKgqoC2/ylfdYamXOph5fO2jmG2SZNc4y0pH959nUxXNVbcEKm
 szJhFpzKTf7F99dCFOUHCNGbobo2tiVie6/89KePrF9EKnlBUKB4ht7n+g7Q3QlLWwTh
 WBc7HbrDUloHhdK2QBDPxrlDwdx1HdhnbnP+rKqrgj/sPDgbTOx9Vh2IEtAiYRnV6h5e
 J7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701276557; x=1701881357;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vRf8tbT+Ph99HG9WyHarJPNebgXtZ037qc+bMvnnmMw=;
 b=j7zLXS2u+CDPGxtTs/bN5OcGST3W94cHqGUKcOJbV4IbVuXcB3omqE3JCTEQuM2iUi
 5c3fi8ByTXtHJG57OohY0Q0yz9/5diMbBCGV8wS/jL7rJSAt3VLIfcXnDtFJRzpIdsXQ
 A++NOHRr+Eq6VAMceTfaC3sXjzQvMlSluPtStuMBnZOP6tJnNYYtdvAfviHmdUILAjkq
 GUCqsKdS+G1eMrtW2I3BfdFNIxFa8eG52GofqVLvtFoiUEU2q0Xd1kitjczphdOWFkYp
 9i7DudIVoF4mT63LVO+WejWLtk7HM3RVAng6vGSHNncjkZr6OC0GPdFaTPul6USj2k7Q
 Ln/g==
X-Gm-Message-State: AOJu0YxG9gk4CyPdVGMt6UdYbv0vQxkcJM4SE9QYOHfOcByC85VtIoyj
 OgDXq51Wds3gzVlUypp5xX0yZcnaZtF7zzjAq/M=
X-Google-Smtp-Source: AGHT+IFzC4uD74Lc73OyAy883a0lUP2w2zUs78FUy4sg25ZorHZKLhb2a7TvD2dlnxljluK6Fdg9YD0YXiQ+hc6HTK0=
X-Received: by 2002:a05:6820:551:b0:58d:5afa:b79d with SMTP id
 n17-20020a056820055100b0058d5afab79dmr16770426ooj.1.1701276557080; Wed, 29
 Nov 2023 08:49:17 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA_rziBuSwgJ9cg9m1PS5pNG58eyim+_P9hMu5nF7G70XA@mail.gmail.com>
 <87edgjf2v4.fsf@draig.linaro.org>
 <ef77ed27-8b95-480e-97da-8e0c53bf3aa1@redhat.com>
 <ZWYsMsgxjDZ_T2zA@redhat.com>
 <68337349-a8c7-4520-a381-a359bf8f8438@linaro.org>
 <CAJSP0QVzwJ8GFAaprwt6892zhxC9-uuKAk9d2cftXebFkMoVog@mail.gmail.com>
 <CAJSP0QVSe6MZOS=20d9NMkJOAwsXaFF3aOOxZFkzhT-XZogG-w@mail.gmail.com>
 <ZWdq067AtaN_66EK@redhat.com>
In-Reply-To: <ZWdq067AtaN_66EK@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 29 Nov 2023 11:49:04 -0500
Message-ID: <CAJSP0QV6MZzeG201my3BjqxgiidifZeJF09xyMoK5ce-+TiKTQ@mail.gmail.com>
Subject: Re: QEMU Summit Minutes 2023
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc29.google.com
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

On Wed, 29 Nov 2023 at 11:46, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Wed, Nov 29, 2023 at 10:53:00AM -0500, Stefan Hajnoczi wrote:
> > To give a picture of the state of the CI, I'd say it fails 80% of the
> > time. Usually 2 or 3 of the tests fail randomly from a group of <10
> > tests that commonly fail randomly.
> >
> > In order for the CI to be usable to submaintainers I think it should
> > _pass_ at least 90% of the time.
> >
> > There is still some way to go but I think this goal is achievable in
> > the next 2 or 3 months because the set of problematic tests is not
> > that large.
>
> FWIW, also bear in mind that when a pipeline fails, it is advisible to
> *NOT* re-run the pipeline, as that increases your odds of hitting another
> non-deterministic bug. Instead re-run only the individual job(s) that
> failed.

Yes, that's the approach I take. It's way to risky to re-run the
pipeline because it will probably fail again somewhere else :-).

Stefan

