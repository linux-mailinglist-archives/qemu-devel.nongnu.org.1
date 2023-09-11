Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 597EB79A66B
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 10:57:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfcj2-0003NS-DP; Mon, 11 Sep 2023 04:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfcj0-0003Mi-QH
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 04:56:54 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfciy-00045q-Ai
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 04:56:54 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31f7400cb74so3342603f8f.2
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 01:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694422610; x=1695027410; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J9YkBbqjzB4QSLj8SfZqX0NR/J7Xt+QjVWU6VrOkbI0=;
 b=YoICnUJWtQsDOUie7g5hsTn4tWLekWsNKSVTSJIIIMJupqw/YZUtNsvAp7NQMUO2WT
 XQQALR9TXEucC0EUXEi+P5WSKB1Gjn9TaIyleg9JaF3j1ZeaLutK2HBnDK7VkrOCfBZN
 JlizFfYVohdpYcEhXWwUpkC7q97j3lViKkAcxjhA+YwApirfhlDn8x02tvfaltPdgtBv
 WOqpnT0hU9hXFqRwL967v57rXtYM3EZgrqMFrNd/c6BH+c3mecn25zQNFlpUJh1nzhn/
 PS42MYs5qCFKGGjbtO9Lo4wPbkbyR1oppxzZl/inMjemOl/5KeEZCOUNrJSWKKDxx5Oz
 8LJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694422610; x=1695027410;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J9YkBbqjzB4QSLj8SfZqX0NR/J7Xt+QjVWU6VrOkbI0=;
 b=b51QgyFE8e5edISgRBhvAA/iM4tdDJMlOZFnYfkScnrlogedVWYq7oiX5P8IphUNRH
 JcOVkyI90I+KyAVi9H+ztakZ/DcFoUy4ADJzVuDYoMrpnDAVmLnk4K2o7UtfSRe6SNHE
 DvqGubsc/xbaF+Gi59AJqYuav+EG7w1btrEjuEw0QHNHVA7UQZo8gbhr1em4baobe3uF
 nRKXf+lqnCeOh6wI5/8arEaMkPDs/0hqYFnOIjsOgE3XqXKIeSg8e9zn9eyK12Cqw/d3
 Byt7+5CM9bJbId8Xm1izaS4xN5dEzaSsokpmzvhs8PDV9bHZvW42VSFzY7E+KsQVCi2F
 shZg==
X-Gm-Message-State: AOJu0Ywn0kAUTIA7x3ZJm+V7S/8bXWHIcMJbfnISCEAM857NGdlUnWLe
 mC9EQhMdE6k4C3axxH6dcJvbvNkV+EDUkkqZyq5Z2nVXyaxZ1J8f
X-Google-Smtp-Source: AGHT+IH5j9OIxkOxDtp87LJIWY/b1D37LBGUjzJnS2TC2ThWja9016M+0i7PA8RXP+2JvKyr5eJt3V1ZCSskofU5XIg=
X-Received: by 2002:a5d:5960:0:b0:31c:3136:60af with SMTP id
 e32-20020a5d5960000000b0031c313660afmr7114879wri.61.1694422610347; Mon, 11
 Sep 2023 01:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <8b3ee6b8-3f4f-3128-610d-8fa3595c16e5@tls.msk.ru>
In-Reply-To: <8b3ee6b8-3f4f-3128-610d-8fa3595c16e5@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Sep 2023 09:56:39 +0100
Message-ID: <CAFEAcA8XA_4JNwCpwpKnUyjkfzvp8exxskqtt4=fuWNzxOJw+A@mail.gmail.com>
Subject: Re: QEMU Stable series
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 qemu-stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, 10 Sept 2023 at 22:01, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> Hi!
>
> For quite some time I'm collecting stuff for stable, pocking various
> people with questions about stable, etc, so has become somewhat more
> visible and somewhat annoying too :)  Especially when I publish the
> next stable patch round-up, which has not only become larger when
> counting individual patches, but also multiplied by now 3 stable
> series.  So I guess you wondered what's going on, what's the buzz
> is all about, and when this ever stop... :)
>
> Seriously though, I stepped up to maintain -stable series just out of
> nowhere, just because I had issues with qemu in debian and thought to
> do something with that, but instead of collecting stuff privately
> inside debian, I decided to give it a more visible try, to see how
> it will work out, without understanding how it will be.

Thanks very much for taking on this work -- it's been an
area where for some time the project has lagged behind because
we didn't have anybody who could dedicate the time to doing
stable releases on a regular basis. So it's been great to
see the stable backport branches being more active.

> Meanwhile, next debian stable has been released, codenamed Bookworm,
> which has qemu version 7.2.  And it should be supported for the next
> 2 years until next debian release.
>
> We never had any long-maintained releases in QEMU before, usually the
> previous series maintenance stopped once next major release is out.
> Right now there's stable-7.2 and stable-8.0 still in existance even
> after 8.1 has been released.  I should draw the line somewhere, even
> while so far, the whole stuff has been quite easy (but time-consuming).
>
> For now I decided I'll stop publishing stable-8.0 releases.  This one
> had a number of linux-user issues, a big share of which Richard fixed
> at the very end of 8.1 development cycle.  There will be one more 8.0
> stable release at least (see below for the details), together with the
> first 8.1 stable.
>
> I think this is more appropriate to drop support for previous stable
> not with next major, but with first major stable release instead, -
> this way users have much more choices for smooth upgrade to the next
> major version.  So stable-8.0 will end with 8.1.1.  Unless there's
> a good reason to continue.

That seems reasonable. I think ultimately what we do in stable
releases depends on what people care enough about to want to
do the backport-and-release work for, though :-)

thanks
-- PMM

