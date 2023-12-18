Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B43CD81744B
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 15:54:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFF0G-0006q4-GT; Mon, 18 Dec 2023 09:53:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFF0F-0006pi-Cj
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 09:53:55 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFF0D-0005PW-NE
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 09:53:55 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-54c77e0835bso3837314a12.2
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 06:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702911232; x=1703516032; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N0GisI5Cj/+d1y5wO4vQHvEhnw40IXcjJYnIm9AP1y8=;
 b=ugoJ1A4i+mOkey/KtfYUzRQl6pN7zZq7qIjuyjfp4cKkLRyp9kjDJjVV/Mfkizeufb
 uRmMQWQx0ZGedStMBmyJPZ4E14Q0XjWfHZCmkD2CVrLhZi3ocpi/TfHrb+2qdRRU1X9+
 VrziMDLym4SNStv459PxK4cjrNFqFuB4KR5iMDLaPyMXams3jGjD8EgsKKnaiczoXwr0
 VA6+R6RLvUc97Ei+PYOuaEpmk621lf5nEOi/sJoInkUUNEzGqLe1T7qfNUxO1zUwwS5q
 UmhnpQdoWYZpOzCnq52GUpYAK6O/1i6eZ4CpdHZhzxy8HWh2cLRHnm06QCVS2MLG6UUV
 Ngyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702911232; x=1703516032;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N0GisI5Cj/+d1y5wO4vQHvEhnw40IXcjJYnIm9AP1y8=;
 b=VUAR8fFM4G1WqvbG5ectd1wUWSXSr8UQc52RsvODpAeYEBeIBr9fK6iD+xr2xQ9k9n
 OnYudRF2U0j9CLm71uVnJ/D6xK6DNSSe8XucM2j/K2WZYfMGiIDmY6uVvuif9EG8hj/y
 +tc51xrI7+OD/E6MfthVYuJ5eCCZBAhRn+R0kn67cnd4wiblLlAnHk8s/gZvDL5X4FSH
 jPqAqmfbYhn/vM+vYroQXY5WxL1QrZD8+QHR24MqOeWzVVFYwVYno9wmZawVHjBfuN5D
 m4wH2eDTPoaprswh3CdEx88oSMYef2hRxNao/ZLCW56uoVTSfncadAXzXordMiQxRlpa
 7uXw==
X-Gm-Message-State: AOJu0YwLWQxQPQOaQ93MMLyK0qDNAkaCvNU+JFTeYp/H3MSEBZHRKVxX
 /jEqQ7C6PARo8OvbNYIaePu+DWsTYvJNzQ5aGPNZfEhE987AAspc
X-Google-Smtp-Source: AGHT+IHxuUPOuRV/pHNYFIueLTZmiYRhUH2Jgq6Oqn9Y3Um+P/cghrQeUcxfBAXk/GXcG1o5pc5SPszg4ZSVEVs3wWI=
X-Received: by 2002:a50:85c6:0:b0:54c:7b90:f40a with SMTP id
 q6-20020a5085c6000000b0054c7b90f40amr10520015edh.4.1702911232016; Mon, 18 Dec
 2023 06:53:52 -0800 (PST)
MIME-Version: 1.0
References: <170256739558.25729.14053113716470464567-0@git.sr.ht>
In-Reply-To: <170256739558.25729.14053113716470464567-0@git.sr.ht>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Dec 2023 14:53:39 +0000
Message-ID: <CAFEAcA_kYruv-b8_FzSTAE+yKh6PTYjHHbFEfiqOVwDR462kpg@mail.gmail.com>
Subject: Re: [PATCH qemu v3 0/2] Add minimal support for the B-L475E-IOT01A
 board
To: "~inesvarhol" <inesvarhol@proton.me>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, alistair@alistair23.me, 
 philmd@linaro.org, ines.varhol@telecom-paris.fr, 
 arnaud.minier@telecom-paris.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Thu, 14 Dec 2023 at 15:23, ~inesvarhol <inesvarhol@git.sr.ht> wrote:
>
> This patch adds a new STM32L4x5 SoC, it is necessary to add support for
> the B-L475E-IOT01A board.
> The implementation is derived from the STM32F405 SoC and NetduinoPlus2
> board.
> The implementation contains no peripherals, only memory regions are
> implemented.
>
> Sorry about the inconsistency in licenses in v2, I changed them.
> Should I clarify anything further? Thank you.
>
> Changes from v1 to v3:
> Changing the MIT license to GPL.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
>
> In=C3=A8s Varhol (2):
>   hw/arm: Add minimal support for the STM32L4x5 SoC
>   hw/arm: Add minimal support for the B-L475E-IOT01A board
>
>  MAINTAINERS                             |  15 ++
>  configs/devices/arm-softmmu/default.mak |   1 +
>  hw/arm/Kconfig                          |  11 +
>  hw/arm/b-l475e-iot01a.c                 |  70 +++++++
>  hw/arm/meson.build                      |   2 +
>  hw/arm/stm32l4x5_soc.c                  | 268 ++++++++++++++++++++++++
>  include/hw/arm/stm32l4x5_soc.h          |  59 ++++++

Can we have some documentation for the new board model, please?
That should be a new file under docs/system/arm/, that you
then list in docs/system/target-arm.rst (note the comment there
about what order the ToC should be in). The docs don't have to
be super comprehensive, but should at least:
 * describe what the board is
 * briefly list the supported devices
 * list any missing features or other limitations
 * describe any machine-specific options (you don't have any yet)
 * if there is an easy open source guest that will run on the board,
   some instructions for how to do that (this part isn't mandatory)

docs/system/arm/orangepi.rst is a good example of the format/structure.

(If you pass configure '--enable-docs' that will ensure that it
builds documentation and doesn't skip it because you're missing
a dependency.)

Then subsequent followon patchsets that update the model to
add new devices etc will likely also patch the docs to add
items to the "supported" list.

thanks
-- PMM

