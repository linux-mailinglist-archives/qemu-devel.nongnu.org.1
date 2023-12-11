Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA80B80CFCC
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 16:42:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCiPK-00054C-F1; Mon, 11 Dec 2023 10:41:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rCiPI-00053z-B1
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 10:41:20 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rCiPE-0007vu-O3
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 10:41:19 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-54cd8f5bb5cso6230224a12.1
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 07:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702309275; x=1702914075; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jR2GEF0BnAY6HyvVJuXTO6tJSvNHXRwQ8RHT+QBI1Do=;
 b=mbqPT5T0AMbD1V8CWCiis//WEDNedUQ1QSfwK3YFaaDOwZgKp7gG7L7IxPsnxNLYdA
 CoUX3yYcVjYa6xCAf2jDZjSCMPCRPs9XvmDAZlwaVBVjvV+U9DQQM83ajE3V/FApGiT3
 VFyo9d5NmKft4TcYagvlZsYaKZT4edKWs3lSwFFUlJlizGr11IFOl6eoKN3b6BZThLmf
 Qgdzmd+svw3I9kqh7Xoer85IHGDR7CY3R0FMpXCdiF+sPM0/ku/3tlp4tBR1/j61h41a
 ClcbJAZbI8uu/dU6a3reFuBYf76nDkWgulfyGZYaFJPMjyd8ez+pE8A1rJtvCiuVMH04
 zgYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702309275; x=1702914075;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jR2GEF0BnAY6HyvVJuXTO6tJSvNHXRwQ8RHT+QBI1Do=;
 b=c3+FHobE1bdqMkkudTzN4mkLwrKqHK2Jz6/pKie7JjKxdy63dzRyW5JzFzkOwouiJ5
 18TbRXBDwDrF3vJm75iZzNYx3wDSWqWffzvRHkU0GRjKhlIsLW0EwEhNLW+IgXby2Q17
 r87bnrJJIpsowjGuLcscyGJq/TTn+nZnV79/gNmKuIPtMlNFI2UsRwcH2NMFtI2qJZ0q
 +2g+gTMbg5hwThVSuUXl+Z1iJV0rFlEeNCKC4oUYRdYy+MwDW4ARilK1EzNG+xDAsYCE
 aDqFki/iIH1YnmIRnjAmncjZLdv64A1Ux27NMAqCnCoNn6bSc4z6VvQb7stnEdZIGpDM
 cFNA==
X-Gm-Message-State: AOJu0YygDdBmuDmi3g9fDpxhZWHsMx23ioze+q511GKx55ABtrlgQwTs
 soeTn3lz7TU+KzgWQF7uFwHW1Pih4NQi5anEQJSSog==
X-Google-Smtp-Source: AGHT+IF+WG6A6K5DF8cKqjkezBy24cs7zlnAEAbP5lcjwkv7neJn8vdUJgv/xNyngH6EA6X7ZBjhmh9o2ma6zMdWmtw=
X-Received: by 2002:a50:bb49:0:b0:54b:d16:4c4b with SMTP id
 y67-20020a50bb49000000b0054b0d164c4bmr2678625ede.19.1702309274900; Mon, 11
 Dec 2023 07:41:14 -0800 (PST)
MIME-Version: 1.0
References: <20231027175532.3601297-1-nabihestefan@google.com>
 <20231027175532.3601297-7-nabihestefan@google.com>
In-Reply-To: <20231027175532.3601297-7-nabihestefan@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Dec 2023 15:41:03 +0000
Message-ID: <CAFEAcA8ABPROeGEp+eEiBVzDj-NMbX7Extwv=ZAziZygwCYDrw@mail.gmail.com>
Subject: Re: [PATCH v5 06/11] tests/qtest: Creating qtest for GMAC Module
To: Nabih Estefan <nabihestefan@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasonwang@redhat.com, avi.fishman@nuvoton.com, 
 kwliu@nuvoton.com, tomer.maimon@nuvoton.com, Hila.Miranda-Kuzi@nuvoton.com
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

On Fri, 27 Oct 2023 at 18:55, Nabih Estefan <nabihestefan@google.com> wrote:
>
> From: Nabih Estefan Diaz <nabihestefan@google.com>
>
>  - Created qtest to check initialization of registers in GMAC Module.
>  - Implemented test into Build File.
>
> Change-Id: Ib0e07f6dacc1266b62b4926873ccd912250cf89d
> Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> ---
>  tests/qtest/meson.build      |   7 +-
>  tests/qtest/npcm_gmac-test.c | 209 +++++++++++++++++++++++++++++++++++
>  2 files changed, 211 insertions(+), 5 deletions(-)
>  create mode 100644 tests/qtest/npcm_gmac-test.c
>
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index daec219a32..205c60aadc 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -205,9 +205,6 @@ qtests_arm = \
>    (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed : []) + \
>    (config_all_devices.has_key('CONFIG_NPCM7XX') ? qtests_npcm7xx : []) + \
>    (config_all_devices.has_key('CONFIG_GENERIC_LOADER') ? ['hexloader-test'] : []) + \
> -  (config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
> -  (config_all_devices.has_key('CONFIG_VEXPRESS') ? ['test-arm-mptimer'] : []) + \
> -  (config_all_devices.has_key('CONFIG_MICROBIT') ? ['microbit-test'] : []) + \
>    ['arm-cpu-features',
>     'boot-serial-test']
>
> @@ -219,8 +216,8 @@ qtests_aarch64 = \
>    (config_all_devices.has_key('CONFIG_XLNX_ZYNQMP_ARM') ? ['xlnx-can-test', 'fuzz-xlnx-dp-test'] : []) + \
>    (config_all_devices.has_key('CONFIG_XLNX_VERSAL') ? ['xlnx-canfd-test'] : []) + \
>    (config_all_devices.has_key('CONFIG_RASPI') ? ['bcm2835-dma-test'] : []) +  \
> -  (config_all.has_key('CONFIG_TCG') and                                            \
> -   config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
> +  (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed : []) + \
> +  (config_all_devices.has_key('CONFIG_NPCM7XX') ? qtests_npcm7xx : []) + \
>    ['arm-cpu-features',
>     'numa-test',
>     'boot-serial-test',

Why does this patch remove a bunch of existing tests for non-npcm
board types ?

thanks
-- PMM

