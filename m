Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D048744815
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 10:39:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFW7u-0003I2-Aa; Sat, 01 Jul 2023 04:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qFW7q-0003Hq-H7; Sat, 01 Jul 2023 04:38:38 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qFW7k-0001rT-2f; Sat, 01 Jul 2023 04:38:34 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-66c729f5618so2280660b3a.1; 
 Sat, 01 Jul 2023 01:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688200707; x=1690792707;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nMZGrLrWB0GCB1W9JleqQok60Bd9lVqU9ke1F/wQpbg=;
 b=R1dru4zDcRPfvN0tpEwDLWehqQPCCvJ1mrIkwQwzxuXKPgafrkq5PY7xX1l4PZuGr7
 n/Mg5hUQ0EiZu0LKsFD0gtsKyYYAjNVCkejbIGPZB38MxCv8Dnxeit7cZpy+tQX7Whhn
 LzGCwLTHKvoQ0IagBJd03g/bkrZAzV17lNuS9mLFm7i3saawXkdalDV7VjC6wFh1SRFV
 gSn3E0ubtEiszCvStH/90RdRSNCH1lyuzSOc+3NQWa++QHkYLHmMXgwSs6A9SUsFNCjb
 F3Ip6tiENdlKKTljytbo8p8ndBjFUf4bsarJ3C7KKQh7/S3egLRrWYHKkF9xcVAYyY9F
 akKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688200707; x=1690792707;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nMZGrLrWB0GCB1W9JleqQok60Bd9lVqU9ke1F/wQpbg=;
 b=DaR3LUJXD6JfUp2/tB4QwSg5MGO15ZkJYcU7gT0U0IcSd8TZc1m5/V1+N911Krypkj
 XtTaP9mOqk9RCt/Fawv9V7yBuDH/3os44zgMoie4sOqGEMPnmIkMzid8YR1sAbk+mGMB
 44gVMDJkMfGXnqD/ZxNoDXf2vMjpfUy3N1gFsTwsz4h1pYiX9GIBrOcBw4FxJI97Jxid
 GM82ayQRlDDeX1U/k6KaRXHzAQJDGaUulZtW5bqpcKb4Eu5DN9XKX0uxi4V5RueMPEuq
 N42hoiWskghsNIyWJUXAj9yA2Eg5qjBG5KhzcrIScZe8PLx9ZgIVy+GsCRYk+RgSCmlX
 8VxA==
X-Gm-Message-State: ABy/qLYfCoNDn57NFcP2N8ANosLdnPCjx6gqcgnInGs2SOXHmcl3anyl
 ZVO59faf/L7/bvndDI+z+/c=
X-Google-Smtp-Source: APBJJlGCUU0OSE7r9eJt/vB1Bqo5Lmy5sQgOtGOEJhSfCryDUvMCCcDpVcprpyzdkaf0L8QrnJzcJQ==
X-Received: by 2002:a05:6a00:1ace:b0:682:4e4c:48bc with SMTP id
 f14-20020a056a001ace00b006824e4c48bcmr6460397pfv.21.1688200706846; 
 Sat, 01 Jul 2023 01:38:26 -0700 (PDT)
Received: from localhost (220-244-154-206.tpgi.com.au. [220.244.154.206])
 by smtp.gmail.com with ESMTPSA id
 x48-20020a056a000bf000b0062cf75a9e6bsm37509pfu.131.2023.07.01.01.38.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Jul 2023 01:38:26 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 01 Jul 2023 18:38:21 +1000
Message-Id: <CTQP7BKWD8W3.MP8NCILJUWDQ@wheely>
Cc: <qemu-ppc@nongnu.org>, "Harsh Prateek Bora" <harshpb@linux.ibm.com>
Subject: Re: [PATCH 0/2] target/ppc: Easy parts of the POWER chiptod series
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Daniel Henrique Barboza" <danielhb413@gmail.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230625120317.13877-1-npiggin@gmail.com>
 <3f70738c-f30a-99a6-6e06-e53b8f93f830@kaod.org>
 <9989efc7-5ad9-0c31-e0af-b8a735dce353@gmail.com>
In-Reply-To: <9989efc7-5ad9-0c31-e0af-b8a735dce353@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
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

On Sat Jul 1, 2023 at 5:38 AM AEST, Daniel Henrique Barboza wrote:
>
>
> On 6/29/23 01:58, C=C3=A9dric Le Goater wrote:
> > On 6/25/23 14:03, Nicholas Piggin wrote:
> >> Cedric kindly reviewed these already so I think they should be
> >> good to go now. This is just a rebase and slight rewording the
> >> changelog. Still haven't completed the main chiptod device yet.
> >>
> >> Thanks,
> >> Nick
> >>
> >> Nicholas Piggin (2):
> >> =C2=A0=C2=A0 target/ppc: Tidy POWER book4 SPR registration
> >> =C2=A0=C2=A0 target/ppc: Add TFMR SPR implementation with read and wri=
te helpers
> >>
> >> =C2=A0 target/ppc/cpu_init.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 82 ++++++++++++++++++++++++------------
> >> =C2=A0 target/ppc/helper.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 2 +
> >> =C2=A0 target/ppc/spr_common.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2=
 +
> >> =C2=A0 target/ppc/timebase_helper.c | 13 ++++++
> >> =C2=A0 target/ppc/translate.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10=
 +++++
> >> =C2=A0 5 files changed, 82 insertions(+), 27 deletions(-)
> >>
> >=20
> >=20
> > Daniel,
> >=20
> > When you start building the next PPC PR, I think you can also take
> > this patch :
> >=20
> >  =C2=A0 [4/4] target/ppc: Implement core timebase state machine and TFM=
R
> >  =C2=A0 https://patchwork.ozlabs.org/project/qemu-ppc/patch/20230603233=
612.125879-5-npiggin@gmail.com/
> >=20
> > It belongs to the same series.
>
> That doesn't apply cleanly with these 2 patches and it didn't look trivia=
l to
> me. As if there were some code missing.

Yeah, it actually uses some signals from the nest chiptod patch.

> If Nick re-send it rebased on top of ppc-next I can queue it. Since it's =
a
> rebase you can keep the r-b. Thanks,

I'll see how it goes, it may have to wait for next merge. SMT for
powernv is a little more important since it's more user-facing and it
would be nice to introduce SMT for both pseries and powernv together.

Chiptod for doesn't really do much except step through skiboot init
code, and getting more useful things wired up like TB fault / HMI
injection won't be ready before freeze.

Thanks,
Nick

