Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE30735C8E
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 18:59:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBIDC-00057F-6F; Mon, 19 Jun 2023 12:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBIDA-00056z-6S
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 12:58:40 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBID8-00061U-BE
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 12:58:39 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-31110aea814so3789767f8f.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 09:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687193916; x=1689785916;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mG4aIRRtlKSAFaWPXJe2/TUtPNLg90ReSBB867DRGDQ=;
 b=G73xPOI60TSEFLmGnV/lDqv6OyVuhVQ6qFhnNzZMkqaGp/zDWFiuXBA3Y60suZ7nFr
 uvJIac2727tcR9kp+5LUsRWwMRR1I832VKzZ+hiKLv0LttSLHuQ+XSWAoyxoWYrGBQMN
 GptWo3bGeKg/+2s0frvmFfm791IyWYt0UIQjtrtHCkRyQWYdSsK+obTbGZvtA4IASm+H
 18DFJ1RKqb1TMQTVloB5JLLwGK2rsfPQculnBCMyRcGn3uOBVQpMu83j4z17voTZcs89
 4NGlMDzj/vHBeKvTRVKtSQyiaThSJv+RFqKUcZ2O+whC7nhvkzpOoLIlWpeZeaqP9A08
 ioFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687193916; x=1689785916;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mG4aIRRtlKSAFaWPXJe2/TUtPNLg90ReSBB867DRGDQ=;
 b=CcBbwC04sXn4qR2UFvyU/g5KzWEsnZD1WVnZPhEobUdGN1i4E96om2EeSx4ZkwORvp
 k/w17KJqme+p3/MSN0G6pOsta2el7J+0JWxSTZ3pGmt1A3ZLhOHZb4duPfBicUcMa7A2
 3ulIDTtk6FX+paNfWYoSSlL/uOncmqlnaVyjXcLiDZXOdthxbbDrx3ehHP/j8Zw/0tX8
 Q+DP+6FOERVExKyofqs0P/WqiUf/OkljsHnALQaCoEudcwgAv958o8VWx9Aoi+/UJPaV
 wAR1BwjNkd6ZIoWlp24iLZvoF5IsBvtL0TzkSsr9rnLmJILaFAAM6jhPc1csejaQ8uZV
 zgow==
X-Gm-Message-State: AC+VfDwC8T0pUNXOay3L2VVqh/b57ybXOBq8zZgK1dwLtZu7F7P6Ip/k
 k/Zq3Wh3BQsVBqa4oG0dte+Pzg==
X-Google-Smtp-Source: ACHHUZ5qDp4iJJWMLl2FQqFKsJHGlRxwTs3gBtzg8CFLBHU1xrYwhxwNB6AA7NuWRUGexv99ce6SAA==
X-Received: by 2002:adf:e488:0:b0:30f:c580:2d0 with SMTP id
 i8-20020adfe488000000b0030fc58002d0mr8545714wrm.35.1687193916531; 
 Mon, 19 Jun 2023 09:58:36 -0700 (PDT)
Received: from [192.168.69.129] (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 y10-20020adfe6ca000000b0030fd23381ffsm34184wrm.11.2023.06.19.09.58.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 09:58:36 -0700 (PDT)
Message-ID: <11f7951f-4ee5-35ad-26fe-3949883cd8e7@linaro.org>
Date: Mon, 19 Jun 2023 18:58:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/33] target-arm queue
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20230619142914.963184-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230619142914.963184-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/19/23 16:28, Peter Maydell wrote:
> Hi; here's a target-arm pullreq. Mostly this is some decodetree
> conversion patches from me, plus a scattering of other bug fixes.
> 
> thanks
> -- PMM
> 
> The following changes since commit e3660cc1e3cb136af50c0eaaeac27943c2438d1d:
> 
>    Merge tag 'pull-loongarch-20230616' of https://gitlab.com/gaosong/qemu into staging (2023-06-16 12:30:16 +0200)
> 
> are available in the Git repository at:
> 
>    https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20230619
> 
> for you to fetch changes up to 074259c0f2ac40042dce766d870318cc22f388eb:
> 
>    hw/misc/bcm2835_property: Handle CORE_CLK_ID firmware property (2023-06-19 15:27:21 +0100)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   * Fix return value from LDSMIN/LDSMAX 8/16 bit atomics
>   * Return correct result for LDG when ATA=0
>   * Conversion of system insns, loads and stores to decodetree
>   * hw/intc/allwinner-a10-pic: Handle IRQ levels other than 0 or 1
>   * hw/sd/allwinner-sdhost: Don't send non-boolean IRQ line levels
>   * hw/timer/nrf51_timer: Don't lose time when timer is queried in tight loop
>   * hw/arm/Kconfig: sbsa-ref uses Bochs display
>   * imx_serial: set wake bit when we receive a data byte
>   * docs: sbsa: document board to firmware interface
>   * hw/misc/bcm2835_property: avoid hard-coded constants

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


