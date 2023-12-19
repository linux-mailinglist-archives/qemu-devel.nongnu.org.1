Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3328191B2
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 21:49:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFh0D-0006C4-3F; Tue, 19 Dec 2023 15:47:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFh0C-0006Bv-1Q
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 15:47:44 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFh08-0000zp-T2
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 15:47:43 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-55361b7f38eso3442641a12.0
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 12:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703018858; x=1703623658; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wJCYvBT3HH8I8yaFEH2rGcknZmAfs5te3ASrXLL7BA0=;
 b=BYQD0XFeevMxGlX7cJSCqVE49tkTvVXbkOXPQhRtjSF/pSOi5Q7YVSlh3cog+YzCFS
 fKyBHn/ptDe6FHEBFEtMwUaHZms1gZy/Z+255MeQe7zoJ79XBE9Vnwjm9hewsUgrukpF
 idqUXTSKZ6xqmwdAdAQZ38Dunqe+WbAEPXRYqfUjjuwxa+Fxp844lf6nCVfYko/cf3mF
 NcW9QrQq7zYwUv71hpbke5z2vl1c4t8bI7Ay2cKxBHSL6y+nFPo3JJc31KfutBJ4AyDN
 AdFQT4f5BXlnc/xXous4DNo/o9X656F20h1icAjlWuvZi59O9LG3TmryzeOy+pqG03Pj
 jeWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703018858; x=1703623658;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wJCYvBT3HH8I8yaFEH2rGcknZmAfs5te3ASrXLL7BA0=;
 b=weJxBYQ6MgYiWtaLgWVLEdjHhZWWUr3ITMoMQhUXkBbaGUpz/Bl6z/B8xcM+kCnaOs
 FJmZJyqE+IZxaH6htr0UtYgJa38NW1SZ8rkqUbExmijh94wluWktmIUnaWQoQTIz2c89
 MSfRyzgD29NPYPFk7eX4L/qjyO9LWVfZ8yXRtGXiMma4wwzExt8PuKZnE7J9Eq+n1Op0
 n/jq7Q2zXf+ZEN8zFJ1RLR4/mviFPbeDH0xGMl/d5ZVllO7++WJn+vHzcYQyb9lOfHLx
 6PnVJjjac85l2HnRAO0vRAq9SOZ0sUeJ1obXjpGgrIHPaR1QW7uVeG4RbfQ2/IzGQYGj
 VmhQ==
X-Gm-Message-State: AOJu0YyzknGEf1OmkSkJNkqtaD4XKezcjPrsIo3dWKdO+x2PIUX4+vFc
 wUkRX8he48ipJ2jDRMr3YVzM8h0OgFvaimM6BdzU2g==
X-Google-Smtp-Source: AGHT+IFSndKoVCMXlANVGfjHvOnW4SnnOPVZuEFc8iADu7bcZ/2j7LYCkyncjTGjiRKJGGJPRFzDgg4cISvPtrbkZhU=
X-Received: by 2002:a50:cb8b:0:b0:54a:f8d9:8026 with SMTP id
 k11-20020a50cb8b000000b0054af8d98026mr7034234edi.12.1703018857640; Tue, 19
 Dec 2023 12:47:37 -0800 (PST)
MIME-Version: 1.0
References: <20231216182740.3305724-1-sam@rfc1149.net>
 <878r5tqnyu.fsf@rfc1149.net>
 <CAFEAcA8sTLZSQdqZmNGSv4yp3TZvq86kwbhU8gFmK2=j8vVZhQ@mail.gmail.com>
 <87wmtaxaub.fsf@rfc1149.net>
In-Reply-To: <87wmtaxaub.fsf@rfc1149.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Dec 2023 20:46:59 +0000
Message-ID: <CAFEAcA_Y-0mUrjapFPqigpfLhzKDf+G8_H9LVNBDS7Ne5UfUAQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add "num-prio-bits" property for Cortex-M devices
To: Samuel Tardieu <sam@rfc1149.net>
Cc: qemu-devel@nongnu.org, Anton Kochkov <anton.kochkov@proton.me>,
 qemu-arm@nongnu.org, 
 Alexandre Iooss <erdnaxe@crans.org>, Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Tue, 19 Dec 2023 at 19:15, Samuel Tardieu <sam@rfc1149.net> wrote:
>
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> >> Any idea to why patchew fails to apply thoses patches? The mbox
> >> at
> >> <https://patchew.org/QEMU/20231216182740.3305724-1-sam@rfc1149.net/>
> >> applies cleanly on master AFAICS.
> >
> > This is because you put a Based-on: tag in the cover letter.
> > Based-on: means "please apply this other patch first before this
> > series, because there is a dependency" (we use it for things
> > like "this patchset has to sit on top of some other cleanup
> > patchset I sent last week and which hasn't got into git yet").
> > So patchew applied Anton's original patch from 2022, and then
> > tried
> > to apply your three patches on top of that, which caused a
> > conflict.
>
> Thanks for the explanation. I thought "Based-on:" was just a
> polite way of attributing credit to past discussions. I'll keep
> that in mind. Do you want me to resubmit it as a v2 without the
> "Based-on:" tag so that patchew gets it right?

No, you don't need to do that. I can review it, and if it's
OK I can apply it to my target-arm tree, based on what we
have now.

thanks
-- PMM

