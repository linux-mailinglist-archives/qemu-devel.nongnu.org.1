Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E730B7D96F1
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 13:51:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwLLc-0000uB-BA; Fri, 27 Oct 2023 07:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwLLX-0000tm-6o
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 07:49:47 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwLLU-0007OM-RY
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 07:49:46 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-53b32dca0bfso4080583a12.0
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 04:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698407383; x=1699012183; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2oFBLQq+dlgjwGLJDoOXdpoEdOhmXl5xUtjF+mOEJPI=;
 b=lZbAoFi2YMhVsCBKp+tg4wul0G8M3ksstiA/m2lg5W6DTPT7YruAkeG0CYbSXmTMAd
 p+DQAMtxZ0ZuVEZ3baljEUHHtL2ztClavnlpvBQpW5zdI8eYzqvVSElsb9Uz99UW1OHs
 iwYx1GVdrWNHoADhnfuXtadw3gFATPYbonN/WOVI+foubp97aSJx5/2eESIUFjAlHIKf
 Z9gOsLr91N4odcnUTq4Oe1M/ZWph3baCso1k0toLM6AV+EWaZStZnT+E4Vpii4YjEEqj
 peN592X/PjfGt2vUUic1uQDn1p0IjcC93JIHGjHFeLO2JdH34o0D0J3naNlPJaWe1Bdx
 gGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698407383; x=1699012183;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2oFBLQq+dlgjwGLJDoOXdpoEdOhmXl5xUtjF+mOEJPI=;
 b=BCLt9BFCSMxQB6kY7k/MT0rM0OUs+LfZyHCXjpLO3a/eotOHJu5NCo4Fs9aa7eU1G/
 9EiO7i1nqOg11f/b+x31mRvawjiAyFQSjfcuozGTpEReRyHLE/XFan5SaZ0AjniLwnH9
 nmgNZHyzDCBjXrqW7HtsRsul+1Uh9bPctgMRfhHQhZZYH2PjTjWABZ7mfSZnpQinVwqP
 qDS4JXczWW3WrCEzja4hc3UvBObPj87O1eR30QCqZdleDoywV4iN9kszsLBbZBOHNgQn
 rrhSbG7twSJ8cONMuvvkQkIaimhbhPZYeytk9SgzhGd3b6s5lGbCQUusPI55DGjjhvjo
 TVaw==
X-Gm-Message-State: AOJu0YzoDwDkV+7sBn3C7QdlpX3ii4XorooZ3cV1yQAmXyHhVyoKk6TY
 JTpFodE8YinrZHIsdHQpnAHcSk9+63v9LMaHsnwwhVfGQ7apsJQ3
X-Google-Smtp-Source: AGHT+IGt0AaiPrutl0DLzPXIJZK5yo4jOOiLkBdSzWr8rUV8jRyWH2xFB3G/Rw8v4WabgcmrGGyJ3LKkQLWvpjaYnzI=
X-Received: by 2002:aa7:d615:0:b0:53e:2aab:14f3 with SMTP id
 c21-20020aa7d615000000b0053e2aab14f3mr2743280edr.17.1698407382946; Fri, 27
 Oct 2023 04:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <20231020130331.50048-1-philmd@linaro.org>
In-Reply-To: <20231020130331.50048-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Oct 2023 12:49:31 +0100
Message-ID: <CAFEAcA8-uB1978pJJXKfS+bbysTxjXK3_X=26__4cEP8DAe19g@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] hw/arm/pxa2xx: SysBus/QDev fixes
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Fri, 20 Oct 2023 at 14:03, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Missing review: 6-9
>
> Hi,
>
> Extracted from a bigger series which enforce QDev state machine
> (qdev instance must be realized before external API is used on
> it).
>
> While here, pxa2xx i2c/intc devices received some qdev fondness.

Applied to target-arm.next, thanks.

-- PMM

