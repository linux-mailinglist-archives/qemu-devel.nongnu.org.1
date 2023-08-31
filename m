Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B5F78F630
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 01:46:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbrLP-0008T5-0C; Thu, 31 Aug 2023 19:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbrLM-0008Rr-JM
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 19:44:56 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbrLK-0006pt-A1
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 19:44:56 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-56c2e840e70so1084419a12.3
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 16:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693525492; x=1694130292; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=klvaGUlBjSlNH3x/kRMXh5i6DPnOTWzv9y1DZkMLF5A=;
 b=WfZ1m2BdatpykPBdIiGQY3Lenm+kB65nSzKwSvCf8YnZz6bNv6pPf1nOREW3Cd0bE2
 /hWs2nv+1SfX6PB70eoTLctykWKVWGiIXyfucGS5nJbnc0RNvzAZVP6nOoEkr1vsASL4
 I6Uowd3X1TkZxtQeZTo3vO9FcW10HxBR6iRpMFwp87AcSF1mhlCYV7gEW0G3GSRuB7yW
 EbYrc1FqQ+fzGPYTJvTKUnLZ/Np0WPFSNtl3r3EMi/2eOeF92cAmrP6cv7APuv8HgNS5
 0wv8QC8v/Km+k7pY2iH5zseFv95cHYO8EKy5/w5LGNFuJ0FYrBt1YxpdH8wr9kHjuzQ5
 6Nmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693525492; x=1694130292;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=klvaGUlBjSlNH3x/kRMXh5i6DPnOTWzv9y1DZkMLF5A=;
 b=Yv1ecN9rZp9CwuosFiBndrpA4Bs/6259TAGovIAPFEZtKzEqW2Mc8HdUY0k481PKtm
 wKeOcuszhDaK/ZV6oWg9Tn+LeZNnh02IvdsPOVrg+DsU0A367+r5T19o9B6gE6wXz9pg
 gkAWab2D7d+oeuWqto/dhEnsSsBEkKgECdU+oQyCzIYCoLTB3z2NR2t6ATb69/uAx1lc
 h8vmoP1Q0lR33dBxVpBVZ4w6cydRsS9wGwsmOqDFjoEqFoWPP0AiYs0ziC9N+DDkLwbG
 b9EQr96n7RM3M9RAnc+iu8syRMU5vmbM1mY+xJ8odZ05wSQJyCGbTQdAEh+5zUxcfP2s
 pRwQ==
X-Gm-Message-State: AOJu0YyO1ymjhNBokR0SfODYzAf0FIQG8A2RdYvgXe2vNZh7hSLnkqFX
 UNGbJuyTr/W3/SEtl0hpbnZMyQ==
X-Google-Smtp-Source: AGHT+IG8yLHDwmBVzPdyDD1KN1uoDMvQuQwI1kXPnZ9CiXOGtE9W3u8Xo/Pm/m94lxGT2Z8tTo07cg==
X-Received: by 2002:a05:6a20:2cf:b0:14d:382c:f354 with SMTP id
 15-20020a056a2002cf00b0014d382cf354mr1098468pzb.36.1693525492568; 
 Thu, 31 Aug 2023 16:44:52 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 k13-20020a63ab4d000000b005642a68a508sm1804470pgp.35.2023.08.31.16.44.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Aug 2023 16:44:52 -0700 (PDT)
Message-ID: <622751d4-8a89-b34e-171f-9e9f7ac99972@linaro.org>
Date: Thu, 31 Aug 2023 16:44:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] hw/misc: Introduce AMD/Xilix Versal TRNG device
Content-Language: en-US
To: Tong Ho <tong.ho@amd.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, alistair@alistair23.me, edgar.iglesias@gmail.com,
 peter.maydell@linaro.org
References: <20230831171849.3297497-1-tong.ho@amd.com>
 <20230831171849.3297497-2-tong.ho@amd.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230831171849.3297497-2-tong.ho@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.478,
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

On 8/31/23 10:18, Tong Ho wrote:
> This adds a non-cryptographic grade implementation of the
> model for the True Random Number Generator (TRNG) component
> in AMD/Xilinx Versal device family.
> 
> This model is only intended for non-real world testing of
> guest software, where cryptographically strong TRNG is not
> needed.
> 
> This model supports versions 1 & 2 of the Versal TRNG, with
> default to be version 2; the 'hw-version' uint32 property
> can be set to 0x0100 to override the default.
> 
> Other implemented properties:
> - 'forced-prng', uint64
>    When set to non-zero, "true random reseed" is replaced by
>    deterministic reseed based on the given value and other
>    deterministic parameters, even when guest software has
>    configured the TRNG as "true random reseed".  This option
>    allows guest software to reproduce data-dependent defects.
> 
> - 'fips-fault-events', uint32, bit-mask
>    bit 3: Triggers the SP800-90B entropy health test fault irq
>    bit 1: Triggers the FIPS 140-2 continuous test fault irq
> 
> Signed-off-by: Tong Ho<tong.ho@amd.com>
> ---
>   hw/misc/Kconfig                    |   3 +
>   hw/misc/meson.build                |   3 +
>   hw/misc/xlnx-versal-trng.c         | 725 +++++++++++++++++++++++++++++
>   include/hw/misc/xlnx-versal-trng.h |  58 +++
>   4 files changed, 789 insertions(+)
>   create mode 100644 hw/misc/xlnx-versal-trng.c
>   create mode 100644 include/hw/misc/xlnx-versal-trng.h

I don't think you should be inventing another PRNG, or related properties.

We already have qemu/guest-random.h, and the -seed command-line parameter to force the use 
of a deterministic PRNG with a given seed value.


r~

