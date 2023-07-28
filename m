Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE390766939
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 11:48:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPJq4-0004bM-6f; Fri, 28 Jul 2023 05:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qPJq1-0004ao-Ny
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 05:32:45 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qPJpz-0000Ia-HS
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 05:32:45 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-4f4b2bc1565so3267614e87.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 02:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690536760; x=1691141560;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wH7bJbZhu2Q6KNd2TTdhSXlH5UfTyGWlGSg7gGLBkjs=;
 b=YUhyme/PE9TMZtxvyiaeWOmsn5jJtGC0Rc0u1MZvZDB2ro8/jvuWckCxWpWU0aRncr
 E3v5iwE+Bhoy3SSjzBquuPdD6KCnBdbu/i3bc8JaYmlKPeaSrFx/EAMaEKJtyLKO6scs
 v7SVXMk4VE2A6E5xfWq810QeLWVA6ONOelwQGT9dFvHT+OOuzaJbAPhnyOuRO3hfA544
 y68AMWQDKlp5F8hcLXXaP8TCE2gdLfMpLFDzpubl6INNWbRcXFfNi7m6PPOmGth/+8Lo
 nTtMNDHfCnFcI31Z7L71A0xUclTwe3tWHWQzD8FaYfoVaGRl9aTQgh8bM6mOvr4U8OmY
 aVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690536760; x=1691141560;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wH7bJbZhu2Q6KNd2TTdhSXlH5UfTyGWlGSg7gGLBkjs=;
 b=j6cjaed4u5zqCsasRO1P2fQIkhbgc/Hrgk/AYifv+UvxRac6ZEgYIBuDymYZ3t8o6t
 liTiNcRAc8T/jR61OyMTj+TJuY42X3mQNO/uPKfr/5xl0Xkf8VKstkCNj/E4huOZ6vSo
 qJEPRcP+9v7k4XkGH/lB0BQFf1CBSVh3bfx0+Cnx2yUP+xTCNBj/X01tyTiTcNI+ZL7Z
 uQLpPjhd6XynW+vkAxBzXYPml1z1KOiJ/eJB5PhnIdM97bAOm4o/lkx5kzcVNN1l8Kgu
 SWlu2n/+/DsV4VvsudcLmfbapflx5sPCZ4nOxJoL/fsm54SAdPLnqX+08CaIeG6BGA0/
 hpLw==
X-Gm-Message-State: ABy/qLZXHhUxEO/6M3weDOrg4ZVT8eo+yc7a5l4ggtHTd/YOVlcHDPN0
 J/jxAPUmFklLiEJDYrZV9XhykAAZmfd+eR725zfDBg==
X-Google-Smtp-Source: APBJJlHxBORmwyGxA6e5zNAdj4fgcefZxU/z4V9br/S2OBIGHnuTuaJ5y5X3+iv6niStr03WS8+SKiUDeHSyTwQH9zM=
X-Received: by 2002:ac2:5bcd:0:b0:4fd:ddbc:1577 with SMTP id
 u13-20020ac25bcd000000b004fdddbc1577mr1410052lfn.2.1690536760388; Fri, 28 Jul
 2023 02:32:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230714232659.76434-1-chris@laplante.io>
 <CAFEAcA_gGia=ckyv4=XHNX4=VHJJ=rmVGXQbdnOAGv5h1rzLzw@mail.gmail.com>
 <uJ83qRpjm3C76JRjI4OOm2NAz3uF-RDUa2WL8sp3ftAzoH16KDfxZhwxsqxqxrHTfXHKkZZXy0JY6UUpq7nD0jfYEUtYM_K340O6E6BFwJY=@laplante.io>
 <CAFEAcA_HWapg170-7yu2cZ-ePTe4PaX-tWyL7FJzENgig=dq5g@mail.gmail.com>
 <yokIQT37oK_0HPVzoPJBD5moVrsM_9vvTfjLSATREN7NSvy794przKE2H0mtVB7Puff1nucD8N0Boa4tdRv8CcqFZHaM2FY6Wxty2-tkTjY=@laplante.io>
In-Reply-To: <yokIQT37oK_0HPVzoPJBD5moVrsM_9vvTfjLSATREN7NSvy794przKE2H0mtVB7Puff1nucD8N0Boa4tdRv8CcqFZHaM2FY6Wxty2-tkTjY=@laplante.io>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Jul 2023 10:32:29 +0100
Message-ID: <CAFEAcA8posSu-U-7hpY6EKXk7P7Ji90KsPNzoRFNs2J8Z431sQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add nRF51 DETECT signal with test
To: Chris Laplante <chris@laplante.io>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12c.google.com
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

On Thu, 27 Jul 2023 at 23:51, Chris Laplante <chris@laplante.io> wrote:
>
> Hi Peter,
>
> > > 2. I also have some implementations for pieces of CLOCK, namely the H=
FCLKSTART/HFCLKSTOP events and HFCLKSTARTED event. Should I include that in=
 this patch series, or would you prefer it in a separate series? It is unre=
lated to DETECT and POWER.
> >
> >
> > If you think they're ready to go in, and it doesn't
> > make the series more than about 12-15 patches long,
> > you can put them on the end of the series. If the
> > patchset is starting to get a bit big then it might
> > be easier to get the POWER/DETECT parts reviewed
> > first.
>
> Unrelated question regarding the CLOCK module. Should I model the startup=
 times for the various crystal oscillators? Or should I just assume they st=
art instantly for simplicity? External xtal startup time is 750-800 us. Int=
ernal RC startup time is 4-5 us. I've already modeled the delay for the ext=
ernal xtal, but just wondering if its worth the extra code.

We typically just have that sort of thing start instantly,
unless there's some specific guest workload that falls
over if you don't model the startup delay. Usually
modelling the delay is unnecessary complexity.

thanks
-- PMM

