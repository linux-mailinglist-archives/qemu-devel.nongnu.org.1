Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 144C57FDF48
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 19:25:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8PEj-00065k-CZ; Wed, 29 Nov 2023 13:24:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r8PEh-00065Y-MX
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 13:24:35 -0500
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r8PEg-00036x-9N
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 13:24:35 -0500
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-58d3c5126e9so65913eaf.1
 for <qemu-devel@nongnu.org>; Wed, 29 Nov 2023 10:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701282272; x=1701887072; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hpsdDpYcFTUYGeheLMQuUlT2IqKJIFHea+RJOj250SE=;
 b=JO1bJuvB8FeUhsxs5x89hu1Yr8xC1fG0H3VQKoYoiQOGGOCoens5cGY5hUcA2ncyQv
 xlu4Zd1bb3cE0FRLaF3CZd7ba7zQUyY5CBQOeRHxS4yWfXbOrQTfZtg7b5dhdMl4Q5Zj
 vJ7FVuwKsMLOVeVmnaMwHEoZzB6OyH9FvqWKRBbvTcsiWYluXIAGZQfHnEWx5Tdg4ggo
 HSbgqNjatX+bYpUXDJLBBw/yJR14YJoZtjZ4zHuG25NKD0kA+n7r+ohFtf29wRrPJLgq
 g2wtPnGRz8BDqFdzYsbs81bbI1zGSvNROVaX7uS1kIr04ZfukLFgJLz7MOwUM3wZK4c4
 e4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701282272; x=1701887072;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hpsdDpYcFTUYGeheLMQuUlT2IqKJIFHea+RJOj250SE=;
 b=gWxYl7iUr0UoNkzBPOr2brVAirva2XpPWI8+B1PmpwS9VNLHCFR51IilsTjvy4NiR2
 c2z74jhOQahtPK+cO7ASxDyBc4RQSjrnRAtkgBbkQgduGifCIPSNgLemTFAZMMAni5Bf
 RLjdZ20cO9bH8vDibJOc5ALOQmuFu77jB+goVs+pxmR7zD6vrxQFtmx9smjuNQaJRAyD
 a9/lbdStgnglmKWXJ2XaMT8cWmkrBxQvAhjrxf/gqBS5zrmThTy2+PFMg9sx8mtYSLfd
 6P8Ta0gkzksH0SKKdwVSmtbsQHcGqhOmpxkr3qOD8ii+DEKEFrT7YPP/UanrHak2oT0S
 WHbw==
X-Gm-Message-State: AOJu0YxzhfsaE2cfcL8ItkRMB0R8VnU/8SgrmFBp6D5C33ZesKgBvoy0
 E9cFaOYew7shkMo8+oRd1hGU7MphKxvGfEWgF1w=
X-Google-Smtp-Source: AGHT+IG9ojLtCnQukzQEbtMByytmd1QyB5vRR8O5OtW/S79OGshz75sio5La7JEXQ+0OF3zrTRdQC5opcQtvIJEuUNQ=
X-Received: by 2002:a05:6820:228b:b0:56c:d297:164c with SMTP id
 ck11-20020a056820228b00b0056cd297164cmr21108644oob.4.1701282272577; Wed, 29
 Nov 2023 10:24:32 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA_rziBuSwgJ9cg9m1PS5pNG58eyim+_P9hMu5nF7G70XA@mail.gmail.com>
 <87edgjf2v4.fsf@draig.linaro.org>
 <ef77ed27-8b95-480e-97da-8e0c53bf3aa1@redhat.com>
 <ZWYsMsgxjDZ_T2zA@redhat.com>
 <68337349-a8c7-4520-a381-a359bf8f8438@linaro.org>
 <CAJSP0QVzwJ8GFAaprwt6892zhxC9-uuKAk9d2cftXebFkMoVog@mail.gmail.com>
 <CAJSP0QVSe6MZOS=20d9NMkJOAwsXaFF3aOOxZFkzhT-XZogG-w@mail.gmail.com>
 <877cm08pkc.fsf@draig.linaro.org>
In-Reply-To: <877cm08pkc.fsf@draig.linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 29 Nov 2023 13:24:20 -0500
Message-ID: <CAJSP0QXcukka4VzrY6cghYm0gD1TSVP3xRwie0CTp_LF=FdRuw@mail.gmail.com>
Subject: Re: QEMU Summit Minutes 2023
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc31.google.com
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

On Wed, 29 Nov 2023 at 11:57, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Stefan Hajnoczi <stefanha@gmail.com> writes:
>
> > To give a picture of the state of the CI, I'd say it fails 80% of the
> > time. Usually 2 or 3 of the tests fail randomly from a group of <10
> > tests that commonly fail randomly.
>
> Do you have a list anywhere?

No, I will need to review the test results from the past two weeks.

Tests I remember causing trouble:
- avocado tests: plain unreliable, most of the time the CI job fails
but the test output doesn't show hard failures, just a bunch of
warnings
- netdev-socket: UNIX domain socket tests are non-deterministic
- qemu-iotests/161: randomly complains that another QEMU may be
running (file locking cleanup is probably racy)
- cfi and s390 jobs are particularly prone to random failures/timeouts

There are more that I don't remember.

Stefan

