Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4708B70F831
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 16:02:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1p3U-00028z-Vm; Wed, 24 May 2023 10:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1p3N-000281-KC
 for qemu-devel@nongnu.org; Wed, 24 May 2023 10:01:25 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1p3L-0007qb-TH
 for qemu-devel@nongnu.org; Wed, 24 May 2023 10:01:25 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3f6042d60b5so11395015e9.2
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 07:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684936882; x=1687528882;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H5d+9oVbqK/+2tI8zHq0xTLIkSguQcSDGD32/dixfLc=;
 b=bInmMnLVU8zNFb7vHXLErPZ4rj2sic4T9cF7XvIMt9nBaRY4zVZMBc84oriMWd34E8
 KdbQBmphouxD6yhTCsErd7RcumiACdEzt01/ttRWHnSPy1wzLHq5maoH3UyIJVLoK9qK
 ibchB3GT9bolkPDbRB10jTYKJW/PtntIqL4eWXdv9KhipLHFMUUOATBW/7LyaHk/su6p
 xVx/WoWjkE9h0zmdvgm7iHECmIU6X8E517wCTNpw58HGwImkmlXETtTEtmZSBFqmG8E2
 fpuU35n3zTAQkumPizj8Hv8q0RL6rewil8QcNDPodGoMM9A0R1mj/nPvu0MD+FxOoeD5
 Sa8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684936882; x=1687528882;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H5d+9oVbqK/+2tI8zHq0xTLIkSguQcSDGD32/dixfLc=;
 b=f/3p87xdXbOqPLXtlFA9l20pidDkYl/z+f8yakDBYiLLG9WJd8HO6wX0PiACjMUMDX
 odepAinEpynCbhhHfrGf9D3QYooV+lcdZQpLRBaNMWnq/JzrZM6SuKK9oxiyS9kyxDWg
 Ty2ajHENiShcdMH5/gxZS4mompHfUo8zYw6uDLmoTrXNaDHrmj8QkHx0UKxuO/Lc1m9/
 6bFPtpykIZTqjCHKqX4vYvsko94c2zEPoFQbW8/BJ7936CS40kUQINmJrKFVgooPMihf
 QQcdurxlKRoVeePeMC7hqLR9T2KqJyQENHZR/3hkA64wpXfxn4DsHz/QHUhPLEYKw1tC
 5+3Q==
X-Gm-Message-State: AC+VfDwi7PFzLhzsNa67JhfvqOyFI5EkcF3lTPPTlp2QmYZ5PHxNnWfk
 sSbN0TJ12KcXMUIrHUj9nUcA+Q==
X-Google-Smtp-Source: ACHHUZ5DUJ4wA+427phw8In1oUFHEftCKL/trOE8YMs3L0ryMTnzSRVyUGgDMqXzKHTfAVUF8gRNSg==
X-Received: by 2002:a5d:5348:0:b0:306:2ef0:d223 with SMTP id
 t8-20020a5d5348000000b003062ef0d223mr12242411wrv.62.1684936882023; 
 Wed, 24 May 2023 07:01:22 -0700 (PDT)
Received: from [192.168.69.115] (fac34-h02-176-184-31-193.dsl.sta.abo.bbox.fr.
 [176.184.31.193]) by smtp.gmail.com with ESMTPSA id
 e9-20020adffc49000000b003078a3f3a24sm14705924wrs.114.2023.05.24.07.01.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 07:01:21 -0700 (PDT)
Message-ID: <1d3d36da-3b7a-ebbe-6339-0c707b329e45@linaro.org>
Date: Wed, 24 May 2023 16:01:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH] tests/qtest: Run arm-specific tests only if the required
 machine is available
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>
References: <20230524080600.1618137-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230524080600.1618137-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.107,
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

On 24/5/23 10:06, Thomas Huth wrote:
> pflash-cfi02-test.c always uses the "musicpal" machine for testing,
> test-arm-mptimer.c always uses the "vexpress-a9" machine, and
> microbit-test.c requires the "microbit" machine, so we should only
> run these tests if the machines have been enabled in the configuration.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/qtest/meson.build | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 4c5585ac0f..087f2dc9d7 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -198,14 +198,15 @@ qtests_arm = \
>     (config_all_devices.has_key('CONFIG_CMSDK_APB_DUALTIMER') ? ['cmsdk-apb-dualtimer-test'] : []) + \
>     (config_all_devices.has_key('CONFIG_CMSDK_APB_TIMER') ? ['cmsdk-apb-timer-test'] : []) + \
>     (config_all_devices.has_key('CONFIG_CMSDK_APB_WATCHDOG') ? ['cmsdk-apb-watchdog-test'] : []) + \
> -  (config_all_devices.has_key('CONFIG_PFLASH_CFI02') ? ['pflash-cfi02-test'] : []) +         \
> +  (config_all_devices.has_key('CONFIG_PFLASH_CFI02') and
> +   config_all_devices.has_key('CONFIG_MUSICPAL') ? ['pflash-cfi02-test'] : []) + \
>     (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed : []) + \
>     (config_all_devices.has_key('CONFIG_NPCM7XX') ? qtests_npcm7xx : []) + \
>     (config_all_devices.has_key('CONFIG_GENERIC_LOADER') ? ['hexloader-test'] : []) + \
>     (config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
> +  (config_all_devices.has_key('CONFIG_VEXPRESS') ? ['test-arm-mptimer'] : []) + \

Also ARM_MPTIMER?

> +  (config_all_devices.has_key('CONFIG_MICROBIT') ? ['microbit-test'] : []) + \
>     ['arm-cpu-features',
> -   'microbit-test',
> -   'test-arm-mptimer',
>      'boot-serial-test']
>   
>   # TODO: once aarch64 TCG is fixed on ARM 32 bit host, make bios-tables-test unconditional


