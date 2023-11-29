Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 915087FDBEC
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 16:47:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8Mmw-0005pZ-Pp; Wed, 29 Nov 2023 10:47:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r8Mmt-0005pP-D0
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 10:47:43 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r8Mmr-0001AB-SW
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 10:47:43 -0500
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3b565e35fedso3944200b6e.2
 for <qemu-devel@nongnu.org>; Wed, 29 Nov 2023 07:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701272860; x=1701877660; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fKE2POUF4iEOTbLiXcPexg7wWa4PlrF+puwDT/rxgM0=;
 b=Lc+RVmhrJYyN08Qw0FzS0vb3FI1pDnc+4tEgqAagp2cEcqS7+B6z9jLHs61Xty8tdp
 19gQOPFaFEt1mkKjQUV7doqbUQHKd+DXw4eYEnP72Mwgo1YmXGQo2GJ3ihMUGYv1NepY
 Ac6XPrrOOCpGEvIZ4rF85gQh7UEi1TIcg+937l4of8eTHd9Apf5ML8NKvoZBizZ5oEWl
 kMOIlf4Qi91/1Qk9nHhvf1hCt0rNrB3B2NPnGkE8IlHLeRU0D8aoIQn/zc7pYNvzZNUi
 Ea8Re51CsU+LUaI1oTLkKSPmVl6oustC1Iamk/KDPyIj2bgbGCRGapn//Nr/jsLH0DiM
 P3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701272860; x=1701877660;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fKE2POUF4iEOTbLiXcPexg7wWa4PlrF+puwDT/rxgM0=;
 b=RCednHof2RORZH5GR2JI9yV4JgZUCF/CLA/c+4GsKvt1utsARZsVwcE+H4DYipw82V
 JcF0mPxQXQAN5KZVfQvfiAy0pO6p/3P8zaenOrayZK13YAW00XoOr/IlhiZdNhjywMwm
 tc6DMFFQJUwNZfKuyfznhPCW3Bt+U/BpRS5A8x1XphAsvWfkNhKesdI0Q3pIqO38MU5h
 FtFX/lkMSjfIx73g7J27gRP8NKuHAshujafvoXV6ixMQeTYo3T/biZ1k/TMCk8V5BEzf
 i/GHvV+EQthMilptCwm/5bqU3mSMkMggwgoi6WTFnkkYiA/puxchnGDul0/jlLxqRPO4
 XRDw==
X-Gm-Message-State: AOJu0YxdGx1mQHISjvw/n6SQJE+zhJk/eaSEIcyuTBbKRJYCzmFcfXvN
 JVeX5AUV0lPj+sp9ZqJUeTomIUQefTLcRSudPM/9mU9I
X-Google-Smtp-Source: AGHT+IFzojLvuNzZ6kPfueFYKXdKre2hFDIB5jv1/FU9AlGNHbEmwGVH4Z1aYXwBxWLiTTXN6coWjx+2Hh99cb+TyMc=
X-Received: by 2002:a54:4386:0:b0:3b8:8247:71d with SMTP id
 u6-20020a544386000000b003b88247071dmr7751102oiv.18.1701272860564; Wed, 29 Nov
 2023 07:47:40 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA_rziBuSwgJ9cg9m1PS5pNG58eyim+_P9hMu5nF7G70XA@mail.gmail.com>
 <87edgjf2v4.fsf@draig.linaro.org>
 <ef77ed27-8b95-480e-97da-8e0c53bf3aa1@redhat.com>
 <ZWYsMsgxjDZ_T2zA@redhat.com>
 <68337349-a8c7-4520-a381-a359bf8f8438@linaro.org>
In-Reply-To: <68337349-a8c7-4520-a381-a359bf8f8438@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 29 Nov 2023 10:47:28 -0500
Message-ID: <CAJSP0QVzwJ8GFAaprwt6892zhxC9-uuKAk9d2cftXebFkMoVog@mail.gmail.com>
Subject: Re: QEMU Summit Minutes 2023
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=stefanha@gmail.com; helo=mail-oi1-x22e.google.com
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

On Wed, 29 Nov 2023 at 09:22, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 28/11/23 19:06, Daniel P. Berrang=C3=A9 wrote:
> > On Tue, Nov 28, 2023 at 06:54:42PM +0100, C=C3=A9dric Le Goater wrote:
>
> > Anyway, when a maintainer wants to merge a tree, I would expect to
> > have a MR opened against 'master' in qemu-project/qemu.  The CI
> > ought to then run and if it is all green, then someone would approve
> > it to merge to master.
> >
> >> It seems to me that we should also have a group of people approving
> >> the MR.
> >
> > Yes, while we could have one designated gate keeper approving all
> > MRs, that would defeat some of the benefit of MRs. So likely would
> > be good to have a pool, and also setup the config so that the owner
> > of an MR is not allow to approve their own MR, to guarantee there
> > is always a 2nd pair of eyes as sanity check.
>
> Are all our tests already on GitLab? Last time I remember Peter still
> had manual tests.

Hi Philippe,
QEMU no longer depends on those manual tests even if they still exist.
I did not run any manual tests during the 8.2 release cycle.

I want to highlight that the CI is not yet reliable. It fails due to
intermittent issues more often than it passes. Most of the issues are
related to unreliable test cases. Some of the issues are related to
temporary infrastructure outages where the tests fail when
initializing the environment (e.g. failure to download dependencies).

I am willing to review the CI failure history for the past two weeks
and submit patches to disable unreliable tests. The test owners can
investigate and fix those tests if they want to re-enable them.

Stefan

