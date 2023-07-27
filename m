Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A86765D7F
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 22:39:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP77j-0000LD-Ec; Thu, 27 Jul 2023 15:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qP77e-0000KT-5R
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 15:58:06 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qP77c-0001IO-Eb
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 15:58:05 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-4fdfefdf5abso2386623e87.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 12:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690487882; x=1691092682;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=34agnrziPL9mxHsgVtlV+MC8UVIIF2Rquj32rqL7wfo=;
 b=LtmbCVJVx0+QPyIcdAAmeBk7hOj+xeGPuQSc/3G0drEIqnmz7k8Vipo5INi504YqJZ
 i9cDUFsLMOaaIXJ3Gxaa68EoE5H6WbvifawpaHUeXirF8/YXgGxFjWfxA5iet14rdzKG
 Im0Jy567jnxVGl39c4shqtMGgne9uLx9wKODmj2bUht8/FRUjRi+jfxRsb5LzCd5JW66
 7dF4Syd+wLEvIFsJ+HahYAUAXPLzdQ/CLOMzcQegyETF+T/YOUjRhwIUbPOBepKuKziD
 ftiyRlJOlb/yReyOmy6OrQG92g2zQ60x5aGrg60joL9V1TNJY5Hy+HT08weJ5WWW8w+H
 OIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690487882; x=1691092682;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=34agnrziPL9mxHsgVtlV+MC8UVIIF2Rquj32rqL7wfo=;
 b=TZVjQPDUvQtxWNGahz4952VUGxYw7SLRqbj2grqWMVWH4rLKXVoqZ8ddHDx9XO0lB7
 S+yV+SeTH9BpulAbK1oRiSVb2Fq7s3uQGgBbtBINF0xhbCptuJiVt64qb2sHD+/izS8U
 blP6ckxiJT7trYfbq4Y9mpvbzjfDVnhulfHoxpd++KSZSbF8aDDRS34pfWN3ZndmL4+u
 2g1LOEXX+TrYt4/RWDVx2THV05yvvf1/oI/JwSF5p/zQcaJrqE+mcf09T8oiyAHl8ChM
 Lg0UoVaxOwO4TIh5sECDI70F2w1wXi1eiAR2+h+3IJ1xsTPPh4KX9E+DjuAHeqxVrKsw
 1csA==
X-Gm-Message-State: ABy/qLbvGK4icPkBwkcaJc0Qqn0yWe+xHmUs4jDRVhOLnhs+Y22ynORS
 BKukFumTKyRR1es6q6+yUXatnHdgv7twTITVadWK3Q==
X-Google-Smtp-Source: APBJJlH/uM+p4ndamJ2n6RSi0n2LENgHeASSp8TsN+tYgM9YKJQY5d6XFFZNaLbtY47xZL39gwIVY6UWcY5+8ismePo=
X-Received: by 2002:a05:6512:2018:b0:4fd:d4b4:faba with SMTP id
 a24-20020a056512201800b004fdd4b4fabamr123573lfb.51.1690487882054; Thu, 27 Jul
 2023 12:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA--tJPhQO49W3BDO1MABQFHrr50MU=q54TFYpbkOxVWHw@mail.gmail.com>
 <CA+bd_6Krq9aCCQe01OjXxb+T-=3XrSnvVHrKs3F-3cwdZEGH8Q@mail.gmail.com>
 <CAFEAcA9txYV4GZQi-uRPWuXd1oOiVHB7ZUQ5-+=zA4T+Of-g1g@mail.gmail.com>
 <CA+bd_6LsQw3ao1KQk8Jk-VvAb9SZ1ioxSdBsghtNqJK-cnMRXA@mail.gmail.com>
In-Reply-To: <CA+bd_6LsQw3ao1KQk8Jk-VvAb9SZ1ioxSdBsghtNqJK-cnMRXA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Jul 2023 20:57:51 +0100
Message-ID: <CAFEAcA9_W3LFmZqarA7ZSYhL9WP46Ew+4=P0EVG=60nfpQ1XVA@mail.gmail.com>
Subject: Re: avocado test failing INTERRUPTED for "Missing asset"
To: Cleber Rosa <crosa@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12f.google.com
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

On Thu, 27 Jul 2023 at 20:08, Cleber Rosa <crosa@redhat.com> wrote:
>
> On Thu, Jul 27, 2023 at 11:50=E2=80=AFAM Peter Maydell <peter.maydell@lin=
aro.org> wrote:
> >
> > Ah, so the problem is that we are trying to download the asset
> > file, and the remote server is stalling so it doesn't actually
> > download the file in 90s, and Avocado doesn't distinguish
> > "hit the timeout while trying to download assets" from
> > "hit the timeout running the actual test" ?
> >
>
> Yes, exactly.  Once the test starts, that's the only timeout being
> enforced.  The fetch_asset() (and all the download code path) is
> simply part of the test and thus under the test timeout.  Also, right
> now, avocado.Test.fetch_asset() doesn't provide a timeout parameter
> (but the underlying avocado.utils.asset.Asset.fetch() does).
>
> > This sounds to me like the ideal would be that there is a separate
> > timeout for file downloads (which could then be a lot shorter than
> > the overall test timeout), and "timeout during asset download"
> > would be detected separately from "timeout while actually running
> > test".  But maybe the separation-of-phases in newer Avocado achieves
> > that already ?
> >
>
> The mechanism in newer Avocado will simply never attempt to run tests
> that don't have the stated requirements fulfilled.  With regards to
> timeouts, each of the different kinds of requirement implementations
> (file downloads and cache, A.K.A. "assets", packages installation,
> ansible module execution,  etc) are supposed to provide their own
> features, including timeouts.
>
> Anyways, I'll look into, and report back on:
>
> 1. expanding avocado.Test.fetch_asset() with a timeout parameter

If newer-avocado does all this stuff differently it might not
be worth the extra effort on something we're going to move away from.

> 2. making sure the newer implementation for the requirement types used
> by QEMU respect a timeout (they don't need to be smaller than the
> test, because they run completely outside of the test).

The main thing I think is that timeouts on asset fetch should
result in a SKIP or CANCEL status, not INTERRUPTED, because
the CI treats INTERRUPTED as a failure, whereas SKIP and CANCEL
are OK.

> For now, are you OK with re-running those jobs if the servers stall
> the transfers? Or would you rather see a patch that changes the
> find_only parameter to True, so that if the pre-test attempt to
> download the asset fails, the transfer is never attempted during the
> test?

I think for the moment we're OK retrying (or more usually, saying
"this job is failing today, ignore it") -- usually this kind
of thing is "somebody's server is having troubles" and it goes
away after a day or so.

thanks
-- PMM

