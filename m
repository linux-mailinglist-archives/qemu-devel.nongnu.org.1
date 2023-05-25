Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D357710C2A
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 14:32:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2A7y-0006al-HA; Thu, 25 May 2023 08:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q2A7a-0006Ww-Hi
 for qemu-devel@nongnu.org; Thu, 25 May 2023 08:31:10 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q2A7T-0005Mf-Ae
 for qemu-devel@nongnu.org; Thu, 25 May 2023 08:31:07 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-510d1972d5aso3777020a12.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 05:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685017861; x=1687609861;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A+Z/U+7mYwoqkhWgmcVkpFHOCV1fMx9hUmEC3Zzb0No=;
 b=QwajTjXMBHY+2NRUfFXyAZVkoExdh9jNoD9Bqa5rrGY/lyzHSkwerhTBqVl+3YGYuO
 M/unCtnFDmJcGKsJoyrAgRDIC58kymfvR8B8U3VFi7cqnX/OpVOaXSVaebjSlq1UZml/
 lVOFrfmWE1db43PNqz02TNXsLTd7L5IEPYVg/CzHafrBP6FokZrGCU25qfcZ8i0Hvz+v
 VqQj9P3VcoOj/YJg5WPFPmUUZBkeIAzBLBr1bvZthC+zCC6YMbmurQTEb1tP9dLj7zPY
 LNjqVhCtyHwljqDyg+phhkE1rt2kKe9zhPdxCpxDC8mXE0yPACVcKPmeRa7lV9FIe21G
 p3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685017861; x=1687609861;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A+Z/U+7mYwoqkhWgmcVkpFHOCV1fMx9hUmEC3Zzb0No=;
 b=YLlxUGbImCEKyRDftmvLkEC0mMB4UJtQs5NRk3w1MmyDCBk/WuACy7M9uPsCu+ZHP8
 ndzjTF5qK6lDK7PeWxcfvXuAZEgNkAI0rUN4eg3OAK4gSWv1DskPe0AKXE2aFuHLV63L
 7s1M8WuZ+IeI6KzqkVM5YuzwahV8ldp8cbQa37MnroN269fFSyz24izee+9LpRXdCjYc
 XEuEUc+PjuOvnb09mD6UVbatA1PkhVNQQ5N2u3zh51em/SObpMUZy2V70cJbzdOqFfPR
 wS4X3K6hTIu62et4vIPJzA7SerbSvltewVDKeOVUiEjcblUpxpRwjQXqXBdXf1tB1hoq
 eTPA==
X-Gm-Message-State: AC+VfDyzyLMsk4qJdpqXbY61vbl50uMnPuFxbK04nvjV9uiZ3e6OR3ut
 OEq4FTMgNZ9++KSXyaMHcxXS4aCjf0bK5ywb3gjTGg==
X-Google-Smtp-Source: ACHHUZ7fpCx4la7kBBOHjg1o/toEFTmClFjwmSxDLBaMNsiIXBZtzM7ZMn/1FJE0einCHHjUPEry+DK7DQS5TLRn11M=
X-Received: by 2002:a50:fa8f:0:b0:50d:abde:c7a3 with SMTP id
 w15-20020a50fa8f000000b0050dabdec7a3mr4151643edr.42.1685017861142; Thu, 25
 May 2023 05:31:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230522153144.30610-1-philmd@linaro.org>
 <20230522153144.30610-10-philmd@linaro.org>
In-Reply-To: <20230522153144.30610-10-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 May 2023 13:30:50 +0100
Message-ID: <CAFEAcA_7dkWB9qPkzYmW6_F1eaAet0PPk0PHywGS2EpAkFAsUQ@mail.gmail.com>
Subject: Re: [PATCH 09/12] hw/char/pl011: Check if transmitter is enabled
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Mon, 22 May 2023 at 16:32, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Do not transmit characters when UART or transmitter are disabled.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Last time somebody tried to add checks on the tx/rx enable bits
for the PL011 it broke 'make check' because the hand-rolled
UART code in boot-serial-test and migration-test doesn't
set up the UART control register strictly correctly:

https://lore.kernel.org/qemu-devel/CAFEAcA8ZDmjP7G0eVpxcB1jiSGarZAbqPV0xr5W=
quR213mBUBg@mail.gmail.com/

Given that imposing these checks doesn't help anything
much and might break naive bare-metal tested-only-on-QEMU
code, is it worthwhile ?

>  static void pl011_write_tx(PL011State *s, const uint8_t *buf, int length=
)
>  {
> -    /* ??? Check if transmitter is enabled.  */
> +    if (!(s->cr & (CR_UARTEN | CR_TXE))) {

This will allow TX if either UARTEN or TXE is set, which
probably isn't what you meant.

> +        return;
> +    }
>
>      /* XXX this blocks entire thread. Rewrite to use
>       * qemu_chr_fe_write and background I/O callbacks */

thanks
-- PMM

