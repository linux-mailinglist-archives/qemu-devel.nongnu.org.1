Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CFE712DDF
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 21:49:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2dPm-0003sB-S2; Fri, 26 May 2023 15:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q2dPk-0003ri-Pu
 for qemu-devel@nongnu.org; Fri, 26 May 2023 15:47:52 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q2dPj-0007Sh-B8
 for qemu-devel@nongnu.org; Fri, 26 May 2023 15:47:52 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-510b6a249a8so2040280a12.0
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 12:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685130469; x=1687722469;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7ayqAp/WfCJAImDzhE+cH4YIjqOnRTlTdy/kK1qHrsU=;
 b=NwQkzUHR0H4SGO1uuApNit5ESUCC7qQIH9zijiu81X990lFK+My6AR8c0B199jVmT/
 oZvFX6MOZ9GoTBhHzj/7Feji+yP5NzLCT15ayxrzBt6FEOsPXOMC4w5XlysZpjGAI28S
 o32G5ggbAxDB1ZvaqxA540qw01XU5AV06D8mhFesqxH0NjY938HIsRHClGNHfWsyJonA
 +IiPYLKLbqbmapvJ0oPEih4byJgdBl5c9OQXaudsP/Y1WUHP+qJ4u1qhcUOgReAlxOn1
 A93uukvIWy/bRnoJVb7DlfxtsLqcZDWdOzwvgnT3fvHw9oXncSuuFGBhIXmrI3CO6Uij
 sL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685130469; x=1687722469;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7ayqAp/WfCJAImDzhE+cH4YIjqOnRTlTdy/kK1qHrsU=;
 b=USI75PLmEHKncP/O82ON6V55y6fpFZJ6jYuJfQ2bIKlFC4KvBzO0a6Gtv7Nv8y0vqy
 YK0GPl/T/npLRfjyrfa4wFcwaPiSig2/cL27+qgg8AcGDAlOTt/i4hXRyFGxoMdjfAXC
 2Sh/PI4y1IxEW3dAao99XL9YuDeKsm442IDw5Afi+JU3s3MI1mTuwaEwtKofiMhaZAqB
 eaBtmCGfiwdgbNTARRguxgg9KXcthSlQAgu16I+gb0R/rSypJzMqStZOdoP1+rubfF62
 dCPbGZ9Af2zHFy88GGNhBhBFUIdDXtPvbl8UVELuWZf2qFGJUcDWmnBvOi35DfoExCtm
 BRug==
X-Gm-Message-State: AC+VfDzmCHpbhrB8B9i137HqMbHiEr55TgPN+Wr4h63dnIcQ4kTsHd4e
 Op7IrJQjkSggACq2NB0L8+/GKu0BxDwVU8tkPPR5EA==
X-Google-Smtp-Source: ACHHUZ5gN6YjS24XMplyb+Xppxqfq1mnNrVvMDSvHFE7BgltAQQjWtSx4F1X8S5kagLbts9IZFKzcPDNEJ/Ons40WqQ=
X-Received: by 2002:a05:6402:688:b0:50b:c689:8610 with SMTP id
 f8-20020a056402068800b0050bc6898610mr2378562edy.18.1685130469366; Fri, 26 May
 2023 12:47:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230404011956.90375-1-dinahbaum123@gmail.com>
 <20230526162821.455a5c4c@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230526162821.455a5c4c@imammedo.users.ipa.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 May 2023 20:47:21 +0100
Message-ID: <CAFEAcA8Ap6L_AOoTqU33+A-t7zBZn9OnzEyvT8RZdq26QCV4Wg@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 0/3] Enable -cpu <cpu>,help
To: Igor Mammedov <imammedo@redhat.com>
Cc: Dinah Baum <dinahbaum123@gmail.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Fri, 26 May 2023 at 15:28, Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Mon,  3 Apr 2023 21:19:53 -0400
> Dinah Baum <dinahbaum123@gmail.com> wrote:
>
> > Part 1 is a refactor/code motion patch for
> > qapi/machine target required for setup of
> >
> > Part 2 which enables query-cpu-model-expansion
> > on all architectures
> >
> > Part 3 implements the '<cpu>,help' feature
> >
> > Limitations:
> > Currently only 'FULL' expansion queries are implemented since
> > that's the only type enabled on the architectures that
> > allow feature probing
> >
> > Unlike the 'device,help' command, default values aren't
> > printed
>
> what's wrong with 'device,help' if it's used for cpu devices?

Nothing, but almost no creation/configuration of CPUs
is done with -device. -cpu is by far the more usual way,
so '-cpu foo,help' should work...

-- PMM

