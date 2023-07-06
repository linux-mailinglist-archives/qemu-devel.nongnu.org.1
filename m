Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E546E749BAA
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 14:28:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHO4N-0004qb-NR; Thu, 06 Jul 2023 08:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qHO4L-0004qL-MR
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 08:26:45 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qHO4J-0003W2-FT
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 08:26:45 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2b703caf344so8884201fa.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 05:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688646401; x=1691238401;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fD/GDCXNP6rLbXP6hdcOZNpcIzMG1YG0w847P4S79TE=;
 b=IwSY7MfwNeAcRYg130kTW9z3JJ6vvNI4ENzOQ0oI+K/1o2WvVd0PPBKWcPQj8i3Y2Z
 GMt9zuRkpR8NCuzwEUOTjSNgJqfEekxYNN5fUrdL5nQ5wiinjEF5rDwehS4tBJH9WM7t
 YGCuWSk/yuHX3reNtchlg9raNpjIQK7WkVHEpE0tMdZiK5AQOKd9WJsjVnTrRSGIyGte
 2VZNTztRbDjI3w++6rUQiHTPch8f/swTfwk5MP1GU6mUs1tSEmi69MFsjcCyyOUtHwop
 4mbdXuACoq8WLeGfIDixURkKZLSESTsJJmT4u7DB2A0FjZ3MrKaJ+H84TKfy1blMxtNZ
 zz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688646401; x=1691238401;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fD/GDCXNP6rLbXP6hdcOZNpcIzMG1YG0w847P4S79TE=;
 b=PDg7wQAHm0wvXCsvyGwt0vCwsbESYJ98sXkyjkCXC5n+cJsKquuurWFXS3b0w0uDJi
 QlCyp2QClA/WDhxL5YU7p5dNpfT8mBbeDqCYSbx2Rw2qchgjjcDZ/b3kfueEfN3mFGN7
 ibOxRYUkJptGFhV4MkeNZSVS98NoPx9GpyJ+vQwYOyO54GOv8fYKtbvMTTgHyBt61r8n
 1URqI8OpCG8UgBETXh6Ln3+2ZqdsSqUkE+BjGAyDgNsINKhOF/oZP7PU+Dco79mc5XB8
 uE5vwkWGRmK6sWfZAXGa82jCdGy5S4XPlkXIdSwnM4BBEAclLj0AbemMFwQqTEHGg1UJ
 UXFg==
X-Gm-Message-State: ABy/qLaa/znPetS6XWQ3yjKewKP7PiQogiBYLZ7M3c2jHGW2ZLTnpDVD
 wgJkckYCNN+U0uN9w+L5A+N/uTzOJmkrfgbG3UWsmA==
X-Google-Smtp-Source: APBJJlGrUur2nPaMXe0DqBrbAgKPHc6SHwxN7Utw3n1kZ3RLf5T2vJxyS0qeoauZjzvE9TfF8EjnifB71hKr3FSg/y4=
X-Received: by 2002:a05:651c:1025:b0:2b6:a22f:9fb9 with SMTP id
 w5-20020a05651c102500b002b6a22f9fb9mr1217560ljm.27.1688646401322; Thu, 06 Jul
 2023 05:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230704163634.3188465-1-peter.maydell@linaro.org>
 <20230704163634.3188465-8-peter.maydell@linaro.org>
 <2e39933a-b9d9-5792-8c4e-dd558d4aad5d@linaro.org>
 <dd6a96b4-1b72-67e2-58ce-8011203128ae@linaro.org>
In-Reply-To: <dd6a96b4-1b72-67e2-58ce-8011203128ae@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Jul 2023 13:26:29 +0100
Message-ID: <CAFEAcA8o8nG7_DWnjYHOL7R2x1DjJdQ-=Moe_jkSibXscZ2mQg@mail.gmail.com>
Subject: Re: [PULL 07/11] tests/tcg/aarch64: Add testcases for IC IVAU and
 dual-mapped code
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?John_H=C3=B6gberg?= <john.hogberg@ericsson.com>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22e.google.com
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

On Wed, 5 Jul 2023 at 10:25, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Cc'ing John.
>
> On 5/7/23 06:53, Richard Henderson wrote:
> > On 7/4/23 18:36, Peter Maydell wrote:
> >> +int main(int argc, char **argv)
> >> +{
> >> +    const char *shm_name =3D "qemu-test-tcg-aarch64-icivau";
> >> +    int fd;
> >> +
> >> +    fd =3D shm_open(shm_name, O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);
> >
> > Build failures:
> >
> > https://gitlab.com/qemu-project/qemu/-/jobs/4592433393#L3958
> > https://gitlab.com/qemu-project/qemu/-/jobs/4592433395#L4149
> > https://gitlab.com/qemu-project/qemu/-/jobs/4592433400#L3694
> >
> >
> > /usr/lib/gcc-cross/aarch64-linux-gnu/10/../../../../aarch64-linux-gnu/b=
in/ld: /usr/lib/gcc-cross/aarch64-linux-gnu/10/../../../../aarch64-linux-gn=
u/lib/../lib/librt.a(shm_open.o): in function `shm_open':
> > (.text+0x3c): undefined reference to `__shm_directory'
> > /usr/lib/gcc-cross/aarch64-linux-gnu/10/../../../../aarch64-linux-gnu/b=
in/ld: (.text+0xcc): undefined reference to `pthread_setcancelstate'
> > /usr/lib/gcc-cross/aarch64-linux-gnu/10/../../../../aarch64-linux-gnu/b=
in/ld: (.text+0xfc): undefined reference to `pthread_setcancelstate'
> > /usr/lib/gcc-cross/aarch64-linux-gnu/10/../../../../aarch64-linux-gnu/b=
in/ld: /usr/lib/gcc-cross/aarch64-linux-gnu/10/../../../../aarch64-linux-gn=
u/lib/../lib/librt.a(shm_unlink.o): in function `shm_unlink':
> > (.text+0x30): undefined reference to `__shm_directory'
> > collect2: error: ld returned 1 exit status
> > make[1]: *** [Makefile:119: icivau] Error 1
> > make[1]: *** Waiting for unfinished jobs....
> > make: *** [/builds/qemu-project/qemu/tests/Makefile.include:50:
> > build-tcg-tests-aarch64-linux-user] Error 2
> >
> > It looks like this test needs something else.
>
> Maybe:
>
> icivau: LDFLAGS+=3D-lrt -pthread

That is enough to get it to build, but then in the CI the test
consistently fails:

https://gitlab.com/pm215/qemu/-/jobs/4606447875

TEST icivau on aarch64
make[1]: *** [Makefile:178: run-icivau] Error 1

I'm going to drop this patch from the pullreq until we
can figure out what's going on...

thanks
-- PMM

