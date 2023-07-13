Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA8A75298D
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 19:09:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJzn0-0006XM-W6; Thu, 13 Jul 2023 13:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qJzmz-0006W5-0H
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 13:07:37 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qJzmw-0004o0-F4
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 13:07:35 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-51bece5d935so1161237a12.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 10:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689268052; x=1691860052;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jowodQCJOW88EDuekr5JJ7LRyhgRzD+BC2SalQa+H48=;
 b=djay1L8WT/yzTm4ko6LNYR61oInxSlgaJRBxjNFtdMan2GgIjBwKGCSCVPrOL1WXpb
 OmWzmCB/32es7kEvgNLOnE9tCpOteRP4n/w1S0CzUw4Cfh63+mA1MNmQtr3mr6mB1bN6
 C0AXQ0Ukiqd6j7YnvGXzJNX5mhHez+hc6LLfC6xUmSgZMdG03nfQ34UlacJFhSZNEloI
 aDYlna+kACqwAbZlc+radhipOEwVHMHt/NYOMGilU8N6f5NxipL+++z5T4uLItwn3J9Y
 s8xlTDzJ1tC2Vqn6Gr9N3KFy6Ke2VceicDaSdZhcMjB6+OjV5G0e131LjQql3nHPIjyv
 iQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689268052; x=1691860052;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jowodQCJOW88EDuekr5JJ7LRyhgRzD+BC2SalQa+H48=;
 b=hhKikGLBYs+ARl8HQdhmR/LQNPQH8b6TNLM+UwVqx+lSriPlhaJuEIbEpYLkY7pRGq
 92Z1L9F2Wa+8Krh/4MqDsLngwsWNyeyWSX8/DCs05q0xCDc2hKowdTRSBFMnQSBCAns4
 a5stQgkpcX1YB3TzWzTi82FKJ+V5U08q5xAdIBqXPbicgCo5YeT4f38lMBXdRLPBjZBq
 YLgkaxo8pyX0iyudorW/qo+0omkFlEtQn261UKUBTnoMJViTG6w7QN4qIWBOA/DEdrie
 rY/XcEBornBWOZtGd6iM8/TOQ8tNoM+U9lT6Cm2K9rP8x6RNQkHKvjrqGjJomaFvhDk6
 j8mg==
X-Gm-Message-State: ABy/qLbqn6pUin1wpep0GTljI1UWsdtpCntlxo2mrhtIbjSmk976nNqj
 htlJV5flSUY1nLLt1lp/eFLZ6dzJNhnHXvg34qV9eQ==
X-Google-Smtp-Source: APBJJlG8gmFqTmj7cro7ttmotb0GBAcPNvlzJF2xKmK3g8St+nhXPnaCK4dYuDEqu1vjfMKclIy8dl3FIuuHHn5AEV4=
X-Received: by 2002:a05:6402:60a:b0:51d:7fa6:62ca with SMTP id
 n10-20020a056402060a00b0051d7fa662camr2143527edv.14.1689268052662; Thu, 13
 Jul 2023 10:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230713035232.48406-1-j@getutm.app>
 <20230713035232.48406-5-j@getutm.app>
 <4a49285e-0d91-93a0-2f8e-e76c71ed89f8@linux.ibm.com>
 <CAFEAcA-r_VOc18-jm99asYQQk4TJMBW_7oJMzFQofEHqVdF50A@mail.gmail.com>
 <ab339186-1af7-171c-eb11-fe124f12b4a2@linux.ibm.com>
 <CAFEAcA9nad4H3MgitMyVsZjNZdY-n9d65Yz4Gtbz2wPYA4fbsg@mail.gmail.com>
 <e2340c41-1d77-3406-001c-4dcce544af74@linux.ibm.com>
 <CAFEAcA-WtwcckNO=kDP8HbY53qV3mTtYysH2Lw8FSJsrWO2tdQ@mail.gmail.com>
 <afb324e8-d65a-12b3-e591-65133087689b@linux.ibm.com>
In-Reply-To: <afb324e8-d65a-12b3-e591-65133087689b@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Jul 2023 18:07:21 +0100
Message-ID: <CAFEAcA9Z5wHRuMmeogoyrN=C4OtoKObxNu58nQaOXdYwzq_gpw@mail.gmail.com>
Subject: Re: [PATCH 04/11] tpm_crb: use a single read-as-mem/write-as-mmio
 mapping
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 13 Jul 2023 at 17:54, Stefan Berger <stefanb@linux.ibm.com> wrote:
>
>
>
> On 7/13/23 11:55, Peter Maydell wrote:
> > On Thu, 13 Jul 2023 at 16:46, Stefan Berger <stefanb@linux.ibm.com> wrote:
> >> On 7/13/23 11:34, Peter Maydell wrote:
> >>> On Thu, 13 Jul 2023 at 16:28, Stefan Berger <stefanb@linux.ibm.com> wrote:
> >>>> On 7/13/23 10:50, Peter Maydell wrote:
> >>>>> I'm not a super-fan of hacking around the fact that LDP
> >>>>> to hardware registers isn't supported in specific device
> >>>>> models, though...
> >>>>
> >>>> What does this mean for this effort here?
> >>>
> >>> Usually we say "fix the guest to not try to access hardware
> >>> registers with silly load/store instruction types". The other
> >>> option would be "put in a large amount of effort to support
> >>> emulating those instructions in QEMU userspace when KVM/HVF/etc
> >>> trap and punt them to us". For the last decade or so we have
> >>> taken the first of these approaches :-)
> >>
> >> Is Microsoft likely to react to use telling them "fix the guest"?
> >
> > They have on occasion in the past, yes.
> >
> > The other outstanding question here is if this TPM device
> > should be a sysbus one at all (i.e. not i2c), which might
> > render this part moot.
>
> Does the aarch64 virt VM support an i2c bus? Would it support the aspeed i2c bus? Does Windows then accept this i2c bus? Maybe the faster answer comes via this device that Joelle presumably has working on AARCH64 Windows.

The aim is not "get Windows booting as fast as possible", though.
It's to end up with a QEMU virt board that (a) is maintainable
(b) is reasonably congruent with what real hardware does
(c) works in a way that will also work with what other
guest OSes are expecting.

I don't want to accept changes to the virt board that are
hard to live with in future, because changing virt in
non-backward compatible ways is painful.

thanks
-- PMM

