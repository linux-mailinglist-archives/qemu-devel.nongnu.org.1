Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E19077D577C
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 18:09:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvJxP-0004XL-L8; Tue, 24 Oct 2023 12:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <titusr@google.com>) id 1qvJxL-0004X0-GF
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:08:35 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <titusr@google.com>) id 1qvJxH-0005eR-3x
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:08:32 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40907b82ab9so10826675e9.1
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 09:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1698163709; x=1698768509; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2js/JElsVO5jqQBxYFXdXpYOV6Y8lfDs5qXzeoDvbwI=;
 b=j91ktS+A8gCn+ryNCxpAH9KoUPqSguKymwayxr340rdFqkdcn/81fRbcquCqDlswDR
 5UGQgQ6ijVWLvbz5Kvts4LKFwU3NiWW7f/9r/IsKKYA5wux7/ibNduCp8jijaXdFMBlA
 RBgegsL+HtU2SrHrvCgvvsOnqp3HW1B1C46ZI+fj+gV6X3Efg1ywrC4vAWOkTMKrtE4W
 80y7GqZZEF1yIpw2EcHXYMlI4kymDZeCoPezC6Omz6KwvLdIZbTc6ThYqb26PhH12O67
 AI5GZvpYu2wnYqNONQ8VTNnU+JaZorqZ5W+00i1UYyMkOS0XxGplwYS/4u3Aezqi5+HD
 sJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698163709; x=1698768509;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2js/JElsVO5jqQBxYFXdXpYOV6Y8lfDs5qXzeoDvbwI=;
 b=UfzfkC+PDDkuo4AxnMXaTGKgoD/QDKTLlfx0Yeb85ryfax/KAtKWxQZda9EMIYco+5
 iemqOKdoEY+wnLVhH9FRGDf3e8uGq9L3ZBKlKaiTH42So1ST92qsjWhpC/fh3uTBQWpw
 kcWHO5UzSd/+fvXET/bra90P7fALr36NWslEy9dwEHa4S+WSTa6wxzC7pdk88gkKD6AC
 Gz2b99M3mhC8F6tCvzVRcvaVyf6C9XtOxRbq0vrkq1xcjMR73wX2zxbARZOgBmYUn2gB
 1FjYQM6zjYfDOUJExF4846M4jbfAGxyN1fYd7KVBjt98LCadRtjuflhf+nQKNUP1LqYa
 89rA==
X-Gm-Message-State: AOJu0Yx6k9xS7QXYH2dR/bPbqqOMVXMY2PuiMQyBtZfbN7Ps352mQLq0
 OQNDwffa1/uvhEpZsyEYPG0/w0Cx7JpJ8nsK2I6wxA==
X-Google-Smtp-Source: AGHT+IHr3/fMnYeVgYpbgVZ03va1SGLHbEZjqitQ8LxLIvVfS5u+EuHKVLZ+bYuwqpWxvutXMRnPZ3FVygh9/3mlw1Q=
X-Received: by 2002:a5d:46c9:0:b0:32d:de87:1085 with SMTP id
 g9-20020a5d46c9000000b0032dde871085mr14561900wrs.10.1698163709291; Tue, 24
 Oct 2023 09:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231023180837.91785-1-titusr@google.com>
 <874jih40a3.fsf@linaro.org>
 <CAMvPwGpXZxyoX1WNypgNCW+Uj+bcVPn99vF71Myx7jn_c2Fjdg@mail.gmail.com>
 <87zg082twp.fsf@linaro.org> <c87866ad-568b-1917-7617-c63b137a196a@linaro.org>
In-Reply-To: <c87866ad-568b-1917-7617-c63b137a196a@linaro.org>
From: Titus Rwantare <titusr@google.com>
Date: Tue, 24 Oct 2023 09:07:52 -0700
Message-ID: <CAMvPwGpyE0BVKJVEo+bZsQz99W_O61fW4TzEwm7A6bCd0bsJ0g@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] PMBus fixes and new functions
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org,
 minyard@acm.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=titusr@google.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Tue, 24 Oct 2023 at 04:50, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 24/10/23 12:06, Alex Benn=C3=A9e wrote:
>
> > A pull request is really just a GPG signed tag that you push to a repo.
> > You can use the existing git tooling to create the cover letter for it.
> >
> > I've included my exact steps at the end of the email but really it come=
s
> > down to:
> >
> >    git tag --sign your-pr-tag
> >    git push your-pr-tag
> >    git format-patch <series details>
> >    git request-pull origin/master your_repo_details your-pr-tag
> >
> > and finally
> >
> >    git send-email
> >
> > My personal exact steps are integrated with my editor but are:
>
>
> > 8 Preparing a QEMU Pull Request
> > =E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90
>
> > 9 And send the pull request
> > =E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90
>
> For these steps I just do:
>
> $ git publish -b origin/master \
>      --pull-request --sign-pull --keyid=3D0xMYKEY
>
> which uses .gitpublish from commit 08bb160e02,
> calling get_maintainer.pl for each patch.
>
> Using GSuite, I also have in ~/.gitconfig:
>
> [sendemail]
>      smtpServer =3D smtp.gmail.com
>      smtpBatchSize =3D 1
>      smtpReloginDelay =3D 3

Thanks all, I'll do some dry runs to walk through these approaches.

-Titus

