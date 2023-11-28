Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4817FC0FD
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 19:06:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r82T0-00024y-Dt; Tue, 28 Nov 2023 13:05:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r82St-00024M-2m
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 13:05:43 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r82Sr-0000Gp-0a
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 13:05:42 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-54af0eca12dso6295346a12.3
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 10:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701194737; x=1701799537; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NIWhnJQJG9W6L+GQ8OQQYANhmKyMSUgwlyiLy7BMC10=;
 b=S1v8vV124BHgk7JpllbHFm6UsK0RxBiaxGFK0xL0gFaBjQv+dkJ9FEzX+a05GlValI
 oNGWUEfhBkEoTNcJQnPvIbu/wy+9gowfLUPdrQJrtYAZXHom35UvzrIzynS16ssNaxVt
 LXLcsjb110Q4WgxtQRFsbrymPeY1st44LxJi4T4Q3HoDmWiAWulNwV2layp0b1VW5rHe
 sSigxrcVClELN+7lxpMrMtJ8nqF/P9BcCCYSb4Kiuxm4/iRk+rsiQadnBzWjPCmd/YNi
 JNSie54ratDSF+zzdiG9MziciNSZ3kM3O2tFRFjVvIT9PBgQm9rk5BwTwiIs5q2IVFmE
 RDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701194737; x=1701799537;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NIWhnJQJG9W6L+GQ8OQQYANhmKyMSUgwlyiLy7BMC10=;
 b=ecLJOEm4GfRy4hrJYoRLgInrJzG38d9Cg4G9Sj7MnzNPqsu8SKqo7Mz5aYZ3+LffrF
 kkLwDVjaJyL0GNszu5YOxD2t2VAzE76qnrNj3alhnD6sBdMwrQ7NukbgSTGF25Ct3V/Z
 9B8D7o01TVljPy3cbzt0dq1NpbE+LQywfkRDZDASZEHgbYystVG8Z91l2lB+yuX0JaBJ
 der+DUu6PPYM89UzWVfD6M28nTtcItpTz0jbeKwE3fSwkfgM848uML/1kpBn7AbVsZy3
 +4Rk7cIYq7Nv/jSljOs4S5I5GCxIl6PgNz2yy5kFyzyIRbPSSiNlVrfWL0uhldsCyo/g
 X96g==
X-Gm-Message-State: AOJu0Yxk1wHiQV5beK43B6rWOb+gZZBeNkZnAChpe7B1xH28wwcDBYlC
 phCNV7Men+jWc6AJ3f/AGiyJoSS6JHEfvVuyDORqJA==
X-Google-Smtp-Source: AGHT+IE+zOdndgNulH8JyfzXWnM4QLeBbIOxwYr633LIdfnxfVsvpDrsQQ/EOsCXvYBQC6BmAu1yejVfLifHIVm1P88=
X-Received: by 2002:a50:c102:0:b0:54b:2af0:dee2 with SMTP id
 l2-20020a50c102000000b0054b2af0dee2mr7943845edf.4.1701194736692; Tue, 28 Nov
 2023 10:05:36 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA_rziBuSwgJ9cg9m1PS5pNG58eyim+_P9hMu5nF7G70XA@mail.gmail.com>
 <87edgjf2v4.fsf@draig.linaro.org>
 <ef77ed27-8b95-480e-97da-8e0c53bf3aa1@redhat.com>
In-Reply-To: <ef77ed27-8b95-480e-97da-8e0c53bf3aa1@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Nov 2023 18:05:25 +0000
Message-ID: <CAFEAcA9M5mXQJRQWGTWoh52H+KmCYd2sWrKzM8RrA=Dh=VeTQg@mail.gmail.com>
Subject: Re: QEMU Summit Minutes 2023
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Tue, 28 Nov 2023 at 17:54, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> On 11/21/23 18:11, Alex Benn=C3=A9e wrote:
> > Peter Maydell <peter.maydell@linaro.org> writes:
> >> Topic 2: Are we happy with the email workflow?
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> This was a topic to see if there was any consensus among maintainers
> >> about the long-term acceptability of sticking with email for patch
> >> submission and review -- in five years' time, if we're still doing it
> >> the same way, how would we feel about it?
> >>
> >> One area where we did get consensus was that now that we're doing CI
> >> on gitlab we can change pull requests from maintainers from via-email
> >> to gitlab merge requests. This would hopefully mean that instead of
> >> the release-manager having to tell gitlab to do a merge and then
> >> reporting back the results of any CI failures, the maintainer
> >> could directly see the CI results and deal with fixing up failures
> >> and resubmitting without involving the release manager. (This
> >> may have the disbenefit that there isn't a single person any
> >> more who looks at all the CI results and gets a sense of whether
> >> particular test cases have pre-existing intermittent failures.)
> >
> > If we are keen to start processing merge requests for the 9.0 release w=
e
> > really should consider how it is going to work before we open up the
> > taps post 8.2-final going out.
> >
> > Does anyone want to have a go at writing an updated process for
> > docs/devel/submitting-a-pull-request.rst (or I guess merge-request) so
> > we can discuss it and be ready early in the cycle? Ideally someone who
> > already has experience with the workflow with other gitlab hosted
> > projects.
>
>
> Reading the Topic 2 paragraph above, I understand that a maintainer
> of a subsystem would be able to merge its '-next' branch in the main
> repository when CI is all green. Correct ?

I think my intention when writing that was to say that the submaintainer
kicks things off and deals with resubmitting and rerunning if there
are failures, but actually doing "merge this successfully tested
pullreq" is still the release-manager's job.

> It seems to me that we should also have a group of people approving
> the MR.

I do think something like this is probably where we want to get to
eventually, where there's a group of people with the rights to
approve a merge, and maybe the rules about how many approvals
or whose approval is needed can differ between "normal development"
and "in freeze" periods. But the idea of the above text I think
was that the first step is to change from how the release manager
receives "please merge this" requests from the current "here's an
email, you need to test it" to "here's a thing in the gitlab UI
that has already passed the tests and is ready to go".

thanks
-- PMM

