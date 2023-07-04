Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7207472BC
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 15:28:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGg4h-0008Ad-93; Tue, 04 Jul 2023 09:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGg4d-0007wS-B0
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 09:28:07 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGg4X-00013F-Da
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 09:28:06 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4fb761efa7aso8707761e87.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 06:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688477277; x=1691069277;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vKprHJlHCt7jsjvkN2pdznmCZN1BHCy/Kd9+VFc58BQ=;
 b=jMA3UubFEeXhlGZ0H7+SeSUGwB6wf7pUnap1bkXGO5SqRqWUXxcf/n2gMqtidQq1Jk
 w7lPB8N/QNM4MxxMdHMxhevLkFimWKsXYJQDUdbgSs96SslfoU3m0ysTD4on2DkhN3FW
 atQGRHoNu5e86g5HeuQzjmdjegOobOJYClp6nXRK77B/VBQ1LZUFV1dK3bYn7GVLxVEx
 koMkIpgg+3oziBJ/6ft+1Huudtyylp3bJ954WK+fL+lx6zh3OhBjPkrm2xIAeg8RYlgP
 wxGP9wr7hKsHL7n37+T4CH5+bBK0s/6gIThZ8/Dsm/hbrIjD2Mu9Z2tsHRKi0Qfgy2He
 X+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688477277; x=1691069277;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vKprHJlHCt7jsjvkN2pdznmCZN1BHCy/Kd9+VFc58BQ=;
 b=jwGmReJMAuRDKVlwsNdM2T8m4WRLQH+n7wYi8vHJpDtAeiz7ZAiz/UMJqhzI+fuXIx
 Fjcz34TI6UgEURJDdbq2bdqUlm1jt3O1msA2L6anHpBvfwgm8rjJ9aw7yFZaSwvTf2Qd
 wqXiU6/TKuzHCuyS/QqjJKGPjMsqdHMPjpz1gypn0LRyrUUPVTIx0OZli0XwR68v7PEN
 EdjvjyDgfRhr8eoNweJnseumNBMkaZC4sHWCwZPXg6gNvFj41tzb0dCmrpgubQNFMuPy
 CJFzDCVt8Z4GWD+2k/78kZ5z9gVhUocH8Uh1fbEWggSesafdwCK0Oea04iQ4wpPmm5OH
 mzXw==
X-Gm-Message-State: ABy/qLZUEzYHLoL4ge6KwVKo0PghL6LvROgVY2t354g90Ux8LDpCZvBv
 T8HsZoNnj2s1zIFaqDnQ6EU9aIYrQYax3lyB4ZGz1I6mQPRMrjyY
X-Google-Smtp-Source: APBJJlEKVmk9J8V3+APoNUjNY7h0KkpoyUk9wsRhAXM71clZsLANedvPQ6jnhWKIdkVIVYAtZjqqldGxd5qZ/KTTHOk=
X-Received: by 2002:a05:6512:3e27:b0:4fb:8616:7a03 with SMTP id
 i39-20020a0565123e2700b004fb86167a03mr12247056lfv.4.1688477276941; Tue, 04
 Jul 2023 06:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230623154135.1930261-1-peter.maydell@linaro.org>
 <CAMo8Bf+poaCgeO+bveMcrZgdTM=HowpjQFVU=aXX92C0b7BoJQ@mail.gmail.com>
In-Reply-To: <CAMo8Bf+poaCgeO+bveMcrZgdTM=HowpjQFVU=aXX92C0b7BoJQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Jul 2023 14:27:45 +0100
Message-ID: <CAFEAcA8wX-Ok_Ma+U3+eXMoXTC4cpHXxsf+hRfwhDzb1TkCROg@mail.gmail.com>
Subject: Re: [PATCH] target/xtensa: Assert that interrupt level is within
 bounds
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x135.google.com
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

On Sat, 24 Jun 2023 at 01:20, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> On Fri, Jun 23, 2023 at 8:41=E2=80=AFAM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
> >
> > In handle_interrupt() we use level as an index into the interrupt_vecto=
r[]
> > array. This is safe because we have checked it against env->config->nle=
vel,
> > but Coverity can't see that (and it is only true because each CPU confi=
g
> > sets its XCHAL_NUM_INTLEVELS to something less than MAX_NLEVELS), so it
> > complains about a possible array overrun (CID 1507131)
> >
> > Add an assert() which will make Coverity happy and catch the unlikely
> > case of a mis-set XCHAL_NUM_INTLEVELS in future.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > NB: only tested with 'make check-avocado'. You could argue that we
> > should mark the coverity issue as false-positive instead if you like.
> > ---
> >  target/xtensa/exc_helper.c | 3 +++
> >  1 file changed, 3 insertions(+)
>
> Acked-by: Max Filippov <jcmvbkbc@gmail.com>

Thanks. I'll take it via target-arm since I'm doing a pullreq
anyway, unless you'd prefer otherwise.

-- PMM

