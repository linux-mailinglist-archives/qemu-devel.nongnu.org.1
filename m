Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB45575AED0
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 14:54:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMT9w-0003n8-KY; Thu, 20 Jul 2023 08:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qMT9u-0003mm-W4
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 08:53:31 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qMT9t-0002j0-78
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 08:53:30 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fbea14700bso5837315e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 05:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689857607; x=1690462407;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9bybHgMXv13RWEb0qTGEFUV7z6cklckcq2Ahk9N/jGM=;
 b=bjfOidPbRP9NWOX5ykNT2gD8DyvVPxDd6xOrp+SCINyHvJMRU3dUby76qyzVLbj5ba
 AjDn10ynnD7gzPr0rmuFHq+46YDg4vx4h/dDi1biCHZ93De5gwXIkP4WZaVjKNY07K5F
 5Byz4tXPagdEF98X6C0kebg9rrzBb6Dy9lsf9JxpTWtiTBbs85xKKCmdGZ1Rpurusl0O
 V/oOM5ewPs/hXgWXkjq7DMyVreWIe3nS0KqDPlCm8KnpVjHWio5O7YNxUcvRk37j/dgp
 u12SipBquK2lpoIdxxWjCDj2yy3U4+VsgYDbD2r3RgdbwYKOfiyCzH/iTkspH03KhN06
 TQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689857607; x=1690462407;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9bybHgMXv13RWEb0qTGEFUV7z6cklckcq2Ahk9N/jGM=;
 b=Yl8gLniBiWty1yWQQ64QT5bFcYn8hnmdVZ7bHgkJ9o4IAB6UFGH9zhq8F7BkGRXb9R
 GoYGHduPYWmHzr167y71cJNQXYAbLzM32NGgikaKRZLE1sr5ZUKz6QDmNCq16TyqqHfe
 z78CqdzWf4YAQA6pQ7Pqs9SeBucoX2QudtoMNEXKSBfNvbldDcNYUWpVVDEqSNhK7RAz
 B+A5L0OvHK7DHLbwjWs+hy6BqB4f/QDWtcuYEmiyMNg/x/bCi27lmVZPmIwmB5PkPpKk
 NyKHUAPMuCo6M2jahe/e+ecZ+N6yav+RSTV3pZ32jOyz0Pd1p/oG3aJEvKlRTY/rf1kz
 YEnw==
X-Gm-Message-State: ABy/qLZmHxS/izhB828DIS2ZBdYqQ1WQtOebXCJQFASqaOjbgSngCoLm
 Re3zv661cbutQQlbm9gMxc1bww==
X-Google-Smtp-Source: APBJJlHa+X86YwtwblzY3T94YA6d5QHL9Ml9+qxM5S5loYlPhyfvapvocfjFZjHnM9707PLK8zhQBA==
X-Received: by 2002:a05:600c:ad9:b0:3fc:1bd:95a6 with SMTP id
 c25-20020a05600c0ad900b003fc01bd95a6mr1676956wmr.31.1689857607287; 
 Thu, 20 Jul 2023 05:53:27 -0700 (PDT)
Received: from myrica ([2.219.138.198]) by smtp.gmail.com with ESMTPSA id
 m14-20020a7bcb8e000000b003fbc9371193sm1147093wmi.13.2023.07.20.05.53.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 05:53:27 -0700 (PDT)
Date: Thu, 20 Jul 2023 13:53:30 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: Re: [PATCH 0/5] target/arm: Fixes for RME
Message-ID: <20230720125330.GB59402@myrica>
References: <20230719153018.1456180-2-jean-philippe@linaro.org>
 <CAFEAcA9sfezZEHVXFT1bTA=1oiEy_ayc0xePJHPKVf87P3E-Mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9sfezZEHVXFT1bTA=1oiEy_ayc0xePJHPKVf87P3E-Mg@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, Jul 20, 2023 at 01:05:58PM +0100, Peter Maydell wrote:
> On Wed, 19 Jul 2023 at 16:56, Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
> >
> > With these patches I'm able to boot a Realm guest under
> > "-cpu max,x-rme=on". They are based on Peter's series which fixes
> > handling of NSTable:
> > https://lore.kernel.org/qemu-devel/20230714154648.327466-1-peter.maydell@linaro.org/
> 
> Thanks for testing this -- this is a lot closer to
> working out of the box than I thought we might be :-)
> I'm tempted to try to put these fixes (and my ptw patchset)
> into 8.1, but OTOH I suspect work on Realm guests will probably
> still want to use a bleeding-edge QEMU for other bugs we're
> going to discover over the next few months, so IDK. We'll
> see how code review goes on those, I guess.
> 
> > Running a Realm guest requires components at EL3 and R-EL2. Some rough
> > support for TF-A and RMM is available here:
> > https://jpbrucker.net/git/tf-a/log/?h=qemu-rme
> > https://jpbrucker.net/git/rmm/log/?h=qemu-rme
> > I'll clean this up before sending it out.
> >
> > I also need to manually disable FEAT_SME in QEMU in order to boot this,
> 
> Do you mean you needed to do something more invasive than
> '-cpu max,x-rme=on,sme=off' ?

Ah no, I hadn't noticed there was a sme=off switch, that's much better

Thanks,
Jean

> 
> > otherwise the Linux host fails to boot because hyp-stub accesses to SME
> > regs are trapped to EL3, which doesn't support RME+SME at the moment.
> > The right fix is probably in TF-A but I haven't investigated yet.
> 
> thanks
> -- PMM

