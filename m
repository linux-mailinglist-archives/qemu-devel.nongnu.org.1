Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A575A710BF4
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 14:22:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q29y8-0003pr-L9; Thu, 25 May 2023 08:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q29xw-0003pQ-E8
 for qemu-devel@nongnu.org; Thu, 25 May 2023 08:21:12 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q29xt-0003HI-Te
 for qemu-devel@nongnu.org; Thu, 25 May 2023 08:21:11 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-96fffe11714so100166366b.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 05:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685017268; x=1687609268;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xt73mBk/BF3DP3yChIeQbwO/64UdUHjyoYKQoOnbBmU=;
 b=iPOhRAYrHJ42CkOi2u2lvNoOXrzjUGWmA/iQKjVqco0cBiGwJ6FEzHOQ8UZXumOk33
 4n3l0XS0WrqD7B3SHkNxl2UYWHVWQnFI+R+yYpHVpkAzL/malAx5+EO5r7qJWQNRN01j
 Hu5XQAG7N4SWOtVtLMlN2KB7BgwriAjut2EpkZWOmI1VpssSTqpdbcMsdoLaPZenFtnC
 BqGbVuGGDn8Fe783kSWulw3GZ6DbxmeO5xgtabwJ2bASTzUHK8Zg4tEPL2RWwiEwPfD7
 MNngMC8iJMBNwPTiBuNGIIn5bIX/CPPvMteJZh+hFxbwhUbBrbvOQuQ36YguP/xviwH7
 d6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685017268; x=1687609268;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xt73mBk/BF3DP3yChIeQbwO/64UdUHjyoYKQoOnbBmU=;
 b=jerRm6XrNmlGlA5pywDWR1CvfXQpZZCVlILrP/IxHp1pw0u3z3y4aFFoTF86EbWVcH
 RiMjsPErDibEEd+M6Ndzj+nWUmr4ibenqz1Vk69AWnlgu4meTGeDIlr82LGt1DajVI4v
 npD9yPv9S81QEenZdL4htE4qaK4SDPcICLfk5slQxZFuNTqXexjrQl8sPYzilcx5d2Oy
 F1Y0t2Jc9JW0qbBv8fD8Sm5L7AZjXFidlVyUE9M38W1GM3jfBqt7MtJBM7VU+Mm84k/q
 8B3b3QJ0VjORfXqDtlf0aHy9TaXLzfd5mlzoLcYqkDiaF7EVmJtHid3/Ks+iL0f8WUnk
 S/qA==
X-Gm-Message-State: AC+VfDzT3WsYgf1qYR/sDWW6xP4erjbO/x0ifhwlNQDAWe23taUDuFGK
 1kqmILiYGl9PqtzpF5ltmMWNLl632oHDn3wUxlQotw==
X-Google-Smtp-Source: ACHHUZ4Gfyl99n1iWrKvxDzOfSxkHaiIvsXX3Byp5HGT+QCm0fqkNT5kXWfRi7MDXOvYmygihs+Paq9jxmClpB9LsjY=
X-Received: by 2002:a17:907:360e:b0:96a:ee54:9f19 with SMTP id
 bk14-20020a170907360e00b0096aee549f19mr1419675ejc.48.1685017268318; Thu, 25
 May 2023 05:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230524080600.1618137-1-thuth@redhat.com>
In-Reply-To: <20230524080600.1618137-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 May 2023 13:20:57 +0100
Message-ID: <CAFEAcA_eNTydi4cnX0E8Pg6aO_b-1zL=tMNibcn-vO97JdJYXQ@mail.gmail.com>
Subject: Re: [PATCH] tests/qtest: Run arm-specific tests only if the required
 machine is available
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x633.google.com
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

On Wed, 24 May 2023 at 09:06, Thomas Huth <thuth@redhat.com> wrote:
>
> pflash-cfi02-test.c always uses the "musicpal" machine for testing,
> test-arm-mptimer.c always uses the "vexpress-a9" machine, and
> microbit-test.c requires the "microbit" machine, so we should only
> run these tests if the machines have been enabled in the configuration.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/qtest/meson.build | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 4c5585ac0f..087f2dc9d7 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -198,14 +198,15 @@ qtests_arm = \
>    (config_all_devices.has_key('CONFIG_CMSDK_APB_DUALTIMER') ? ['cmsdk-apb-dualtimer-test'] : []) + \
>    (config_all_devices.has_key('CONFIG_CMSDK_APB_TIMER') ? ['cmsdk-apb-timer-test'] : []) + \
>    (config_all_devices.has_key('CONFIG_CMSDK_APB_WATCHDOG') ? ['cmsdk-apb-watchdog-test'] : []) + \
> -  (config_all_devices.has_key('CONFIG_PFLASH_CFI02') ? ['pflash-cfi02-test'] : []) +         \
> +  (config_all_devices.has_key('CONFIG_PFLASH_CFI02') and
> +   config_all_devices.has_key('CONFIG_MUSICPAL') ? ['pflash-cfi02-test'] : []) + \
>    (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed : []) + \
>    (config_all_devices.has_key('CONFIG_NPCM7XX') ? qtests_npcm7xx : []) + \
>    (config_all_devices.has_key('CONFIG_GENERIC_LOADER') ? ['hexloader-test'] : []) + \
>    (config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
> +  (config_all_devices.has_key('CONFIG_VEXPRESS') ? ['test-arm-mptimer'] : []) + \
> +  (config_all_devices.has_key('CONFIG_MICROBIT') ? ['microbit-test'] : []) + \
>    ['arm-cpu-features',
> -   'microbit-test',
> -   'test-arm-mptimer',
>     'boot-serial-test']

Applied to target-arm.next, thanks.

>  # TODO: once aarch64 TCG is fixed on ARM 32 bit host, make bios-tables-test unconditional

Aside: I wonder what we meant by this... Added in
commit ab6b6a7777449905a in 2019 with no further detail.

-- PMM

