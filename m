Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD687632AB
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 11:44:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOb3c-00089e-7G; Wed, 26 Jul 2023 05:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qOb3Z-000898-N2
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 05:43:45 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qOb3X-00086F-FC
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 05:43:44 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5221f193817so5880491a12.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 02:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690364622; x=1690969422;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tk0q8YO4QkKl6VPTSK2cIEtpxfFLlQzhhmlRw5h19P4=;
 b=TMUmaSYzvRdVVaKRQ4r84588jIMYu/qdkii/PBMpSxQ3vDoG8fhIISVXY2pbfKnoyl
 KLirxdRApOxFLbAugk2ZbXnKk6EKBGT1jDfTWP1LI70/0NSQxFKNL4kR/ZNWSjMLGU1a
 jITSAybI/metmkjZ14ztnprOTrdv8HlsH2eVLQwEzy3TYdV0Fp9o9c549llkrNhttGpw
 35NF4WUU12PIgYWq+qzvbbzlYQJAkHiYCQUuZ7/d6W1lO3yP0w/0+xMmNRaqtMilF6vy
 yFNU1ApAIsHY4CdHvsjeP6kr7NKnq8AGvLr8l+pvSJ4jjJP33RL+/OfrfTb50ugwdSrg
 /NZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690364622; x=1690969422;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tk0q8YO4QkKl6VPTSK2cIEtpxfFLlQzhhmlRw5h19P4=;
 b=JwDegw/U9BOjqcFZg8nURfZwcFl2emECwNNVikDWI+08AvBmn85fePhMAQYSUnL36M
 xWd0fP3JOYRxJv0/M91pjHMnAvq9Em/PVh0gXQ2urbbki3KgIzc7bGuYAn7MIwDyK30p
 AsZK2Q6tVCh/FwMZO+pIWMvoDx+s5zfMl1Vf4hOHuHg9PR20ZlOTjL79kmEuLIkv7WbV
 9asc9a5JlLDJ1h+ODrNiPljib9V2ZWl9X+A5Mkes1y5llrB3uJomEcqu49QFIgtgCsA2
 22b4KY+noM/BAOFhlBZzqdpci3UUqjqRDs+krCdKuv2haK6ZNB4HSpuFIDU6QKHWurMj
 cKZg==
X-Gm-Message-State: ABy/qLb78FyUhWPwvl+uGI/iJkuQLrUu+whCZyRcmb4SYmA3SdcimFkh
 ILyOKvfJl8YFQQiArWt5Zs/bxrQOOqY0oGqG24LnkIIAZJKw1ES/
X-Google-Smtp-Source: APBJJlGsR9VUCQnwf3WId9l/I6J+H7RVpmSUaEMfrfzOajWLUMgQiBximT3OgHyB45iksQfXEbDty/oNPSh1j6Qk64I=
X-Received: by 2002:aa7:c315:0:b0:522:1f3a:ad19 with SMTP id
 l21-20020aa7c315000000b005221f3aad19mr1056947edq.12.1690364621724; Wed, 26
 Jul 2023 02:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230725080630.1083-1-dinglimin@cmss.chinamobile.com>
 <20230725090039.1271-1-dinglimin@cmss.chinamobile.com>
 <106cf02f-f746-e216-22be-8f7594028695@tls.msk.ru>
 <CAFEAcA-ErMrk60uZMu8M-0G15aTvhOZsYsvJD1F-YbLGOFDBYA@mail.gmail.com>
 <E1qOWH5-0002Du-U6@lists.gnu.org>
In-Reply-To: <E1qOWH5-0002Du-U6@lists.gnu.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 26 Jul 2023 10:43:30 +0100
Message-ID: <CAFEAcA8UdN4-DU4dAiY3VGLA77mLK-ohfFJs5+5fDt3v1mAAcg@mail.gmail.com>
Subject: Re: [PATCH] semihosting/uaccess.c: Replaced a malloc call with
 g_malloc.
To: dinglimin@cmss.chinamobile.com
Cc: Michael Tokarev <mjt@tls.msk.ru>, 
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

(Something went wrong with the quoting in your email. I've
fixed it up.)

On Wed, 26 Jul 2023 at 05:38, <dinglimin@cmss.chinamobile.com> wrote:
> Peter Maydell wrote:
> > The third part here, is that g_malloc() does not ever
> > fail -- it will abort() on out of memory. However
> > the code here is still handling g_malloc() returning NULL.
> > The equivalent for "we expect this might fail" (which we want
> > here, because the guest is passing us the length of memory
> > to try to allocate) is g_try_malloc().

> g_malloc() is preferred more than g_try_* functions, which return NULL on error,
> when the size of the requested allocation  is small.
> This is because allocating few bytes should not be a problem in a healthy system.

This is true. But in this particular case we cannot be sure
that the size of the allocation is small, because the size
is controlled by the guest. So we want g_try_malloc().

thanks
-- PMM

