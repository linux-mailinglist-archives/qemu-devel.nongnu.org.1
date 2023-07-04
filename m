Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 951BA7473A9
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 16:08:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGggk-0002gM-SS; Tue, 04 Jul 2023 10:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1qGggi-0002gD-RG
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:07:28 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1qGggh-0002E9-BV
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:07:28 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2633fe9b6c0so3531836a91.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 07:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688479645; x=1691071645;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NUsbRFNFaDMDPICaRIHxN2LRbE8mfrEFRsgVztn2k1g=;
 b=PjL3PLC9UDYX9GhpqL05GOt2vy+ku3N3bz2kH1SGXCE/UI8bAbs3LEYhUgXDyGDd2p
 JBcRmkKNAQfMjo6yK0u8ZKcIxhlZY9Bd2hd3ux1zwADOOvE7uSDnF2jx0pyiGF/SLL7Q
 E/5uGSu+cRVQwk7VAZfEPFclPOESwLNXN4p+q8C4bIRYNKXAvmpEv0u2ERT6/B22kJKe
 HZiIk5t5Vpvonl+Ebh2O4Lbxl/yXEeYjVObzEqefeP+OvBAqGGlYS5D+IpvsOJV1MvmQ
 JwwAgfH80MwHIx9k+zsToChC6oetSFO6e4FPHHLYL0BQN8Fyifka/lqW7m93OQtUVKIl
 lK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688479645; x=1691071645;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NUsbRFNFaDMDPICaRIHxN2LRbE8mfrEFRsgVztn2k1g=;
 b=R0nUChdSzOEmTCNjXQ+1ZCBJ57pagj1EeP4pu1ZVKol7qpodt7hkhDg3ee0Y6yvTPp
 n98IqrTLmZmj4bxLtw23yJERdV1eX0uAsEy4KMZY1mvDBFzz3ZcD7ozSIR2AbzVIRvA2
 jUjwaJRtz7wSoLpvrYb8M//JJfUkzZewK495oGGhHmp847kc+mCYmJESIVu7hczTDIiz
 8GscksWlIh0UOBECmU+qGfYPeVdpiDSTOk4Mnwu7vtNMeiAE6jF4NdH36HwhOl2HlE+U
 w+7f4dpzLK384kxxYV9VF4PozviYtLDdEfseCN4TPFfyUlMq3+rvlMQFSv6qp1e5Vn0v
 SNfA==
X-Gm-Message-State: ABy/qLbNcnF36j9nbisLFHcZpcIn7g2BmBXYk6tb7zzkupjiI0ffHmDO
 86wsBiz4ScDnmv/rukO9nIA17IbkCPDzyH1b76Q=
X-Google-Smtp-Source: APBJJlEx8t4twUhnYM1iwszZSxbYt05Vxg8kMQxBIlCuGlpbety0Lyhya+PxjP4wPWEF2NXSmfIy30Z/3WqJSr4I0oI=
X-Received: by 2002:a17:90a:f6c8:b0:263:3567:f99 with SMTP id
 er8-20020a17090af6c800b0026335670f99mr20016275pjb.15.1688479645364; Tue, 04
 Jul 2023 07:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230623154135.1930261-1-peter.maydell@linaro.org>
 <CAMo8Bf+poaCgeO+bveMcrZgdTM=HowpjQFVU=aXX92C0b7BoJQ@mail.gmail.com>
 <CAFEAcA8wX-Ok_Ma+U3+eXMoXTC4cpHXxsf+hRfwhDzb1TkCROg@mail.gmail.com>
In-Reply-To: <CAFEAcA8wX-Ok_Ma+U3+eXMoXTC4cpHXxsf+hRfwhDzb1TkCROg@mail.gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 4 Jul 2023 07:07:14 -0700
Message-ID: <CAMo8Bf+YhLDHbZTUANUBG+GDTan1xET0OJ95ZPUAUW+xKuQ4pQ@mail.gmail.com>
Subject: Re: [PATCH] target/xtensa: Assert that interrupt level is within
 bounds
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001,
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

On Tue, Jul 4, 2023 at 6:27=E2=80=AFAM Peter Maydell <peter.maydell@linaro.=
org> wrote:
>
> On Sat, 24 Jun 2023 at 01:20, Max Filippov <jcmvbkbc@gmail.com> wrote:
> >
> > On Fri, Jun 23, 2023 at 8:41=E2=80=AFAM Peter Maydell <peter.maydell@li=
naro.org> wrote:
> > >
> > > In handle_interrupt() we use level as an index into the interrupt_vec=
tor[]
> > > array. This is safe because we have checked it against env->config->n=
level,
> > > but Coverity can't see that (and it is only true because each CPU con=
fig
> > > sets its XCHAL_NUM_INTLEVELS to something less than MAX_NLEVELS), so =
it
> > > complains about a possible array overrun (CID 1507131)
> > >
> > > Add an assert() which will make Coverity happy and catch the unlikely
> > > case of a mis-set XCHAL_NUM_INTLEVELS in future.
> > >
> > > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > > ---
> > > NB: only tested with 'make check-avocado'. You could argue that we
> > > should mark the coverity issue as false-positive instead if you like.
> > > ---
> > >  target/xtensa/exc_helper.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> >
> > Acked-by: Max Filippov <jcmvbkbc@gmail.com>
>
> Thanks. I'll take it via target-arm since I'm doing a pullreq
> anyway, unless you'd prefer otherwise.

It's good, please go ahead.

--=20
Thanks.
-- Max

