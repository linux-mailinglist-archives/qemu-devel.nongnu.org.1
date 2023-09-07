Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F276797258
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 14:33:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeECH-0004sd-Ii; Thu, 07 Sep 2023 08:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeEBo-0004mO-FK
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 08:32:52 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeEBm-0000vu-2E
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 08:32:52 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-99357737980so107217766b.2
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 05:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694089968; x=1694694768; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o4J+x+9gFiEhafa+n0Udq8IEqpY37LD5jCgLsVyzpRo=;
 b=yi7sxtgvgS706NvMrVl8EoAkqwkBRu6JvwH+fDW3ft6FXlRTv33CBR25YZV4gcYb41
 MSQvCJBDCE3yMAiqq4EprPu20ToIuYar4pc0jUb4UFrCAhcfZiQs93FU1sPGGvue4SfE
 KfTOIgn5eqkp7/zcRjZ/sRhBb1srbtfLZM3PxeDCl/8FgpOGTtimW8tsWPo6w/FhDIIu
 T5ZVp/F01WhiKkMcUp6O7Joz5RCY2gJHlTe48x6YYZ295+UxS12sshjluQJzCNO2IrMs
 A1q5eTTledqRuJN1YhE7mK6Onwey5LYU5q3PVdTT/k4IVJ5laLIHNrvKaKyjTNWIUV85
 2HXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694089968; x=1694694768;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o4J+x+9gFiEhafa+n0Udq8IEqpY37LD5jCgLsVyzpRo=;
 b=OHapiLOlvKPzS0oGLABebImTCxRJWqDHC3RhfMuxdipth0bxzLJXHZS8mf8LSrbcBm
 dgH5oJ8ftcj9IUEYQBVTX4jbIm2DO3uRMjmPRek7pvSreLyB4zCTxtCzr0575lbSCyGd
 55lJgpoprImcfyymvTDacma2T6p/udn8LsFBxvD6cKT3gpBfrw3Pb3ODw0CFHhkzKA0c
 /GV7rj9SWZBh2KJBpK5/0LksKUaMczf73Y5USQX70RIcO3P7/Cf2t0SBg6ThoqNOh9V4
 wImVKw0whZcQHPd76wMHIPT53KKbksp0f8KOx0QNYd0pyBZw11mEpC3Y28MY1QfPaTYi
 dSUQ==
X-Gm-Message-State: AOJu0Ywa77LLo+kaHdRcuErscEEHWUcL71E2wA87JJumI11k/G5d5yKY
 nt+PT4PJnLZw15qfbU6ATufUxA==
X-Google-Smtp-Source: AGHT+IGztItOl3eFrW8RECsrQJg6GZmok9OSRRvWKbxsH07ySq2cPLsKwz+NQRsQF12df/U4CwXjnw==
X-Received: by 2002:a17:906:3192:b0:9a1:bb8f:17d0 with SMTP id
 18-20020a170906319200b009a1bb8f17d0mr4571364ejy.30.1694089968509; 
 Thu, 07 Sep 2023 05:32:48 -0700 (PDT)
Received: from [192.168.69.115] (176-131-222-226.abo.bbox.fr.
 [176.131.222.226]) by smtp.gmail.com with ESMTPSA id
 a25-20020a1709064a5900b009a2202bfce5sm10293516ejv.118.2023.09.07.05.32.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Sep 2023 05:32:48 -0700 (PDT)
Message-ID: <9ced1089-3199-f19a-e89e-4fbdf647b234@linaro.org>
Date: Thu, 7 Sep 2023 14:32:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] trivial: Simplify the spots that use TARGET_BIG_ENDIAN as
 a numeric value
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
References: <20230907113500.185276-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230907113500.185276-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 7/9/23 13:35, Thomas Huth wrote:
> TARGET_BIG_ENDIAN is *always* defined, either as 0 for little endian
> targets or as 1 for big endian targets. So we can use this as a value
> directly in places that need such a 0 or 1 for some reason, instead
> of taking a detour through an additional local variable or something
> similar.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   target/arm/cpu.h     | 12 ++----------
>   cpu.c                |  6 +-----
>   hw/microblaze/boot.c |  9 ++-------
>   hw/mips/jazz.c       | 10 ++--------
>   hw/mips/malta.c      | 21 ++++-----------------
>   hw/mips/mipssim.c    |  9 +--------
>   hw/nios2/boot.c      |  9 ++-------
>   hw/xtensa/sim.c      |  7 +------
>   hw/xtensa/xtfpga.c   | 10 +++-------
>   9 files changed, 18 insertions(+), 75 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


