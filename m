Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA15837456
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 21:46:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rS1BM-0006gl-5D; Mon, 22 Jan 2024 15:46:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rS1BI-0006Zn-0O
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 15:46:08 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rS1BF-0005Um-4e
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 15:46:06 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-55c2e6f0542so1704303a12.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 12:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705956363; x=1706561163; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X88/NUHn09TSNhlqrrbj/PgNx95vNRBZOnAF7uVWttk=;
 b=gPqG3qqlk+kJ6HOwA2ZZMbH7QFJ9UYdETJmXat7f4Qwdz3cvI9PXQvmyuAy14LoB7t
 9/oDO0Z4HNc7Y64K8UvJQ8L4cAYIyn1fjVcEDXmW7qBMez57WrIs7e+KInUp1IJTzC4n
 ZVcuAWeXiVVsyG5ZXKTrVklj1Zh5TNcxQNmrRcOhwsvE/iX/7LtaWdAkn78NdRSnQiWn
 i6upAo0I8Y6S2uSofGOWi3ptwVBr0cZ4XCKJwg6pmP9Z0KbaY/oiC54V1A1mHOIK2+Rl
 Y3s1ovaRvBenVYbSmgijtUQhHMDCLc1qaNCULullYTO/WU4tKpU/pOmtWtl9dAKYybWx
 qycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705956363; x=1706561163;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X88/NUHn09TSNhlqrrbj/PgNx95vNRBZOnAF7uVWttk=;
 b=cOMTPZdtTngCm00JH+2tQIlIggvrTOEulOmd/AwepJc9v1eUBPJeVAbGnpDyrj/r8z
 X2fhzzFmf5oodkiyM8sj6xkBwh8jAz6EO50WJM5Im5IB+DR5IcTjL73r7srtt24ymoyd
 ltXCD7vehLXKchcWSXvnd2nUpjr6WL4J/yWqs4Mt1CPrKy3D0t1dn7vj0xbBBPnjw2sl
 lVoWKynAogabmiDtItaLhi0qC9RZdMBe5DgTn9HN07pKcspn9dwHmUj6bdznlw/e1Jud
 rSqW5uJZbnLdSnoIAoMDh2+XG4rnw/BVHtFMDOO7KzOb5YSXqPEbqK2eirmdrnqPROMl
 q1tA==
X-Gm-Message-State: AOJu0YxiGghIsla+II4lq/yBOpxOj8r6FzhAmh4TBL6YuQP1P1tnxLAH
 o/RghhcnPbSqIpktarxwPwmWQgcOcnx4GKX7HP98j8Tn7ANmrB9hH7TP1oxqlPEhjswZ1cZu04C
 rD/HPYe6BHIWZ2Xn+zXlaz7/Mbb+wjOH+h9x9DA==
X-Google-Smtp-Source: AGHT+IFRQhWt+sfeF0rR3RVQX3l3gAYl/GBSQcpg6OMZiEolXywjcQEdhPTkTbqbufzBLtRaE9n2VEV5CHmnjeN6Ilg=
X-Received: by 2002:a05:6402:b6e:b0:55a:5ecc:79ed with SMTP id
 cb14-20020a0564020b6e00b0055a5ecc79edmr249601edb.79.1705956363484; Mon, 22
 Jan 2024 12:46:03 -0800 (PST)
MIME-Version: 1.0
References: <20240119204608.779541-1-jcmvbkbc@gmail.com>
 <20240119204608.779541-2-jcmvbkbc@gmail.com>
 <CAFEAcA-dSxaseY+w_z-U1pa8XkJ9XTyBWekXvH0q0XkrZJ+jNA@mail.gmail.com>
 <CAMo8BfKWg14m9HG+3D9YiGdJ5JZsphU9AF4d6jha-DPbhr8TOw@mail.gmail.com>
In-Reply-To: <CAMo8BfKWg14m9HG+3D9YiGdJ5JZsphU9AF4d6jha-DPbhr8TOw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2024 20:45:32 +0000
Message-ID: <CAFEAcA890Q7mwt4CZWRnrhOUm2_8y54PTuk31_B248p+O4PhzA@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/xtensa: wrap MMU and MPU state into structures
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Mon, 22 Jan 2024 at 18:45, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> On Mon, Jan 22, 2024 at 10:29=E2=80=AFAM Peter Maydell <peter.maydell@lin=
aro.org> wrote:
> >
> > On Fri, 19 Jan 2024 at 20:47, Max Filippov <jcmvbkbc@gmail.com> wrote:
> > > +    union {
> > > +        XtensaMMU mmu;
> > > +        XtensaMPU mpu;
> > > +    };
> >
> > Is it really worth having this be a union ? I suspect it will
> > make adding migration/savevm support later more awkward.
>
> I have a draft implementation of savevm for xtensa and I did this part
> using subsections with the .needed callback checking whether the
> MMU or MPU option is enabled in the config. I wonder where the
> awkwardness is expected.

Oh, well if it works that's fine I guess. I was kind of thinking
that if you didn't have the union you could avoid having
subsections entirely.

On Arm we don't try to save space in the CPU struct by
using unions, even though some fields are A-profile
specific and some are R or M-profile specific.

-- PMM

