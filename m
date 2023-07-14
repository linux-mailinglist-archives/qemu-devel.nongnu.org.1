Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4F775428B
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 20:28:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKNWI-0008LJ-Hx; Fri, 14 Jul 2023 14:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mborgerson@gmail.com>)
 id 1qKNWC-0008Kw-7D
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 14:27:52 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mborgerson@gmail.com>)
 id 1qKNW9-0000em-Ve
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 14:27:51 -0400
Received: by mail-lf1-f51.google.com with SMTP id
 2adb3069b0e04-4fafe87c6fbso3791805e87.3
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 11:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689359267; x=1691951267;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YgF9XKTRh9et8C5ItX0fcZZPcAHn6Qryv81Zukn8CtU=;
 b=b69u433BxJjmoiNK8ANp+blOsNgyfADUWE81hsaElec8tUkcU1KK2SniAE1d6Mmi9z
 LZEuLHevkqct5dJohbHBGiTtLr3ZHohGmb/Bn+JEdjiXZCL7RjW9jzI8yUSBwF4Tg2Ak
 y1C5ul+96JqkKPtK6JSpM1vjDyUsusu6ccy35VYrGZNnJ3SvdlOZ/pqWuV/dHaM6BDnh
 ROc80JH9hkXacKEhktrCbYqqzVwbtQtwuAjyxeeTLLdsodcUMVKuP7afE3g34FoqW/IT
 KQn07yV10DrZSde08lMMIIdFNeZ8u0X2fmkbhhXRrc68btBxAy2/Rk/oGdnwKvP6WOHV
 F54g==
X-Gm-Message-State: ABy/qLY0eR5LUhkyJcSi2BX5iMaJd68Hrj5mZTU4aZ3iTjLguI26CtjX
 f75vPun9uCYm3MoV6+3AQ5+NWg/k1vH4rG9R
X-Google-Smtp-Source: APBJJlHcdaR6kUHDPNzQKRzVDKgwUyAY02AQEhwXzRDRMtM4+I5uVCa2LC41ZQGXqfwNNbavL02scw==
X-Received: by 2002:a05:6512:368e:b0:4fd:b223:92c with SMTP id
 d14-20020a056512368e00b004fdb223092cmr46784lfs.60.1689359267192; 
 Fri, 14 Jul 2023 11:27:47 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com.
 [209.85.208.172]) by smtp.gmail.com with ESMTPSA id
 er24-20020a05651248d800b004fb8f4df9bdsm1583253lfb.226.2023.07.14.11.27.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jul 2023 11:27:46 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id
 38308e7fff4ca-2b70bfc8db5so34363591fa.2
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 11:27:46 -0700 (PDT)
X-Received: by 2002:a2e:a410:0:b0:2b6:e7ce:4e7d with SMTP id
 p16-20020a2ea410000000b002b6e7ce4e7dmr4496772ljn.43.1689359266698; Fri, 14
 Jul 2023 11:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <CADc=-s4Ef9eBV7Z6FKYRT=-5c733ZHQRjvnumV5OwjJh8uFmmA@mail.gmail.com>
 <598f26c9-af6f-f289-e4a8-5a8f5f3a3db6@linaro.org>
In-Reply-To: <598f26c9-af6f-f289-e4a8-5a8f5f3a3db6@linaro.org>
From: Matt Borgerson <contact@mborgerson.com>
Date: Fri, 14 Jul 2023 11:27:35 -0700
X-Gmail-Original-Message-ID: <CADc=-s6abXzR1jDCFJ7JaF+J9=osO0uLDivxfYGbvQ05d-V-Qg@mail.gmail.com>
Message-ID: <CADc=-s6abXzR1jDCFJ7JaF+J9=osO0uLDivxfYGbvQ05d-V-Qg@mail.gmail.com>
Subject: Re: [PATCH] plugins: Set final instruction count in plugin_gen_tb_end
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Matt Borgerson <contact@mborgerson.com>, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.167.51; envelope-from=mborgerson@gmail.com;
 helo=mail-lf1-f51.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hi Philippe,

> num_insns is a 'size_t'.

You are right. I copied the `int` type from `DisasContextBase`, but it
should really be `size_t`. I'll send an updated patch.

Thanks,
Matt

On Fri, Jul 14, 2023 at 11:09=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Hi Matt,
>
> On 14/7/23 06:18, Matt Borgerson wrote:
> > Translation logic may partially decode an instruction, then abort and
> > remove the instruction from the TB. This can happen for example when an
> > instruction spans two pages. In this case, plugins may get an incorrect
> > result when calling qemu_plugin_tb_n_insns to query for the number of
> > instructions in the TB. This patch updates plugin_gen_tb_end to set the
> > final instruction count.
> >
> > Signed-off-by: Matt Borgerson <contact@mborgerson.com>
> > ---
> >   accel/tcg/plugin-gen.c    | 5 ++++-
> >   accel/tcg/translator.c    | 2 +-
> >   include/exec/plugin-gen.h | 4 ++--
> >   3 files changed, 7 insertions(+), 4 deletions(-)
>
>
> > diff --git a/include/exec/plugin-gen.h b/include/exec/plugin-gen.h
> > index 52828781bc..4feaa47b08 100644
> > --- a/include/exec/plugin-gen.h
> > +++ b/include/exec/plugin-gen.h
> > @@ -20,7 +20,7 @@ struct DisasContextBase;
> >
> >   bool plugin_gen_tb_start(CPUState *cpu, const struct DisasContextBase=
 *db,
> >                            bool supress);
> > -void plugin_gen_tb_end(CPUState *cpu);
> > +void plugin_gen_tb_end(CPUState *cpu, int num_insns);
>
> num_insns is a 'size_t'.

