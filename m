Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 807E7710C6B
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 14:52:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2ARz-0000XT-Oh; Thu, 25 May 2023 08:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q2ARy-0000Wz-8j
 for qemu-devel@nongnu.org; Thu, 25 May 2023 08:52:14 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q2ARs-0003PA-IY
 for qemu-devel@nongnu.org; Thu, 25 May 2023 08:52:12 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3095557dd99so2024374f8f.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 05:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685019126; x=1687611126;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4yXPvalOKey4PMADW/H+sxi3bhn+1lbvczP/FuWf7MY=;
 b=BATdIGpkSlf8XKZy8YXkneKAJQlGuI8gqvWz0WrcipLbdxVy0qhzi44VgGVbJDH3Uo
 BKBvOVzAOm7OrNmusM8HGN0kAW/R5gAfW+AJ4eXjOmHUbDlaZyI+oP3BGEfX8p2uMV15
 5NcwdRpN1pWndMOCptvDUm2aF2ERZ2a64V2228KrzOHH8NjoC7+qd1M3v/P28QiCmKts
 PGRtO0/cm5wAKxguIaKLgSvIDwT1vfy96H7k1heD7vEjW177A5OZeDRaDvo8Wig8l0Kp
 EKZy559FitiRTW27RxDZxEcFT/QN3O6agTrhoaKFrAGnxBEldobKQkoP+MNKlPnHwDTG
 91hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685019126; x=1687611126;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4yXPvalOKey4PMADW/H+sxi3bhn+1lbvczP/FuWf7MY=;
 b=asSMyZ4FD3oLL2Kc3McwQP+Nw+6pNQCWA7yUhCIQ9sWuFVex0wxiclQrC2ky++8hzW
 zd0/SSmA0R9GxxF83cFWpRMscvohqBBQ8z+N5Q8GDFjE2U2Z6T3bry9enTSpMjV9N1jn
 uwZIrJ0eE4W0QwGn2aVHVAVlcYd7ODUxMkUnLSV0zgrdjXsNe+FlB06Sl3SE4kKvsaQj
 GrvZRHtYKdSMYiKg6IHs+eL+jhJAHV5OqtRNBoqSNDTfmNuKYVveD7SYrgwI6Ulw54fH
 NqHYwn60XxpqUWIYW3qIUIC4OXvlc0NoPEhrp1/PeES6fitVzJur+HszQOx2E8vOC+Ii
 5rTg==
X-Gm-Message-State: AC+VfDx3N06Z7wAWPAzAMqmFhUhlvJJg/EUILg9Jr85POqf75WlHh016
 0OVwSSGf3Y0hNZGkr66tnhOIAA==
X-Google-Smtp-Source: ACHHUZ4wMUAErCerMApE6aky+I/EuajnMYx1SUbPbVBrnUM9VPWhv5ZGNACW066hxJ7VdAOtL5RP1w==
X-Received: by 2002:a05:6000:10cb:b0:309:3e77:6cac with SMTP id
 b11-20020a05600010cb00b003093e776cacmr2237268wrx.0.1685019126396; 
 Thu, 25 May 2023 05:52:06 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 g18-20020a5d5552000000b002e5f6f8fc4fsm1663179wrw.100.2023.05.25.05.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 05:52:06 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 611471FFBB;
 Thu, 25 May 2023 13:52:05 +0100 (BST)
References: <20230522153144.30610-1-philmd@linaro.org>
 <20230522153144.30610-10-philmd@linaro.org>
 <CAFEAcA_7dkWB9qPkzYmW6_F1eaAet0PPk0PHywGS2EpAkFAsUQ@mail.gmail.com>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Paolo
 Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, Evgeny Iakovlev
 <eiakovlev@linux.microsoft.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 09/12] hw/char/pl011: Check if transmitter is enabled
Date: Thu, 25 May 2023 13:51:08 +0100
In-reply-to: <CAFEAcA_7dkWB9qPkzYmW6_F1eaAet0PPk0PHywGS2EpAkFAsUQ@mail.gmail.com>
Message-ID: <87zg5stvyi.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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


Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 22 May 2023 at 16:32, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.=
org> wrote:
>>
>> Do not transmit characters when UART or transmitter are disabled.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> Last time somebody tried to add checks on the tx/rx enable bits
> for the PL011 it broke 'make check' because the hand-rolled
> UART code in boot-serial-test and migration-test doesn't
> set up the UART control register strictly correctly:
>
> https://lore.kernel.org/qemu-devel/CAFEAcA8ZDmjP7G0eVpxcB1jiSGarZAbqPV0xr=
5WquR213mBUBg@mail.gmail.com/
>
> Given that imposing these checks doesn't help anything
> much and might break naive bare-metal tested-only-on-QEMU
> code, is it worthwhile ?

Surely we aim to be a correct model so the fix should be in our naive
and incorrect code?

>
>>  static void pl011_write_tx(PL011State *s, const uint8_t *buf, int lengt=
h)
>>  {
>> -    /* ??? Check if transmitter is enabled.  */
>> +    if (!(s->cr & (CR_UARTEN | CR_TXE))) {
>
> This will allow TX if either UARTEN or TXE is set, which
> probably isn't what you meant.
>
>> +        return;
>> +    }
>>
>>      /* XXX this blocks entire thread. Rewrite to use
>>       * qemu_chr_fe_write and background I/O callbacks */
>
> thanks
> -- PMM


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

