Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4E57DF0EF
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 12:10:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyVZD-0004G0-Us; Thu, 02 Nov 2023 07:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qyVZ6-0004DX-J9
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:08:44 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qyVZ3-0006aa-VZ
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:08:43 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-53de8fc1ad8so1304824a12.0
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 04:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698923320; x=1699528120; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m4EtCgAMQpp77MxdoZeboNJyzqIGM9jaBb2Uf5UHZ0c=;
 b=WWCwiAoS6PV4iCWAXRjjajBxRngDRElXcEGPwkuoR9MbQK9O87eNPUZDb6fciXeyTe
 h5z8U5DnMYQJkD65LhA6+FR+x6Hf9zGICBqcxOXnUf9MXze7HLnYomXap6WhmDZgiUEB
 8T1ghQpo+dWBW99nC1JCwXKMGHG7mRnbvRSuKfBuLQAczvZrgKMoRrKL/0inXn69iUuO
 hgdijEw1CK1bK0+P8XGZ+SkCjUBJ+1gmYDkAlVmL7/S5cngNf5j9CaP2npHiXK3TKxpy
 nXOT+SBu/nk9z50JJro/gArMKShAwcT8ksZ9sGEnZ4DvjfKZdhBxm5MOcMdmRdig8jY5
 V30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698923320; x=1699528120;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m4EtCgAMQpp77MxdoZeboNJyzqIGM9jaBb2Uf5UHZ0c=;
 b=rAnYuhs/mrzlMiGgB3ATYfL0j2/S95G053Ty4Y/Mf5NsVJlwVbAlGsPVKUQ1KrW8sq
 pjgpTaDN+yBRLBVAa+E8s0pcem0v6WjinuXFyM8EOm86n3RVVIUs8Zx/JcS5oTlbuO29
 Si7Q48Lm0bQ7RIyxXRNqKphC+OgEZFEe2z9zYlfF3KVcUkbw/gD8pyHqsk//4+uMgtOY
 gkdVxxNeCwxEExKPXbT83SvSD8INd2M1fMdxrz2Vxkw6bvRfqCZ+ugTQFuxVl8ghJ3qO
 Nyq0XwuQmh9D0wJ2s0GEqEm7+vX4i+wz+opgAV7o1Q3ryGvxWnXsI1k9wchq/AJlITXw
 bYIw==
X-Gm-Message-State: AOJu0YwCcKMqvtTkiVckil+j+br877rols8OletPIyYM66QwUWM01odT
 ByCNIF+/qq/JpxYr6n1nH5ELaIM05RpxAcisxs6g2w==
X-Google-Smtp-Source: AGHT+IHQr+NtNfY5zkJOyXdILWAEFJeYozDfat5x7UCNtpjtsvMXetZ0tKHM5gp2ByIc04jOyj6azrSrN/+VsCGiuyM=
X-Received: by 2002:a17:906:fd89:b0:9ce:24d0:8a01 with SMTP id
 xa9-20020a170906fd8900b009ce24d08a01mr4501877ejb.60.1698923320319; Thu, 02
 Nov 2023 04:08:40 -0700 (PDT)
MIME-Version: 1.0
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
 <CAJSP0QU1SUqdTbzNT9_fgCyZ1pGDUk47_T2B-JzjnBXFicEWBA@mail.gmail.com>
 <CAFEAcA_na1NB3nFRmc9MRRr92VunxPJUG3SHmE2HkXAGx6RPUw@mail.gmail.com>
 <CAJSP0QW=7f3k35DjBwsnbnj79HmqwSH3hWRE1Fur8x4pyOGs7w@mail.gmail.com>
In-Reply-To: <CAJSP0QW=7f3k35DjBwsnbnj79HmqwSH3hWRE1Fur8x4pyOGs7w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Nov 2023 11:08:29 +0000
Message-ID: <CAFEAcA8cPSb0MLLREuW0AuHQFhvkovaufQBVoxVZk3rbrK_kxw@mail.gmail.com>
Subject: Re: [PULL 00/41] target-arm queue
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Mon, 30 Oct 2023 at 22:09, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Mon, 30 Oct 2023 at 19:09, Peter Maydell <peter.maydell@linaro.org> wrote:
> > 'git.linaro.org' has several geolocated servers and pushes to
> > it should get mirrored across to all of them. Maybe the
> > syncing between them went wrong? You could try using one
> > specific one:
> >  https://git-us.linaro.org/people/pmaydell/qemu-arm.git
> > tags/pull-target-arm-20231027
> >
> > git-ie.linaro.org also seems to have the tag.
>
> Yes, that solves the problem. DNS was resolving to git-ap.linaro.org
> for me and it doesn't have the tag.

This was a problem with that specific mirror server;
it has been resolved, and future pulls with 'git.linaro.org'
should work as usual.

thanks
-- PMM

