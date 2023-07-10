Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E691674CE75
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 09:31:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIlLE-0005iD-3F; Mon, 10 Jul 2023 03:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIlJt-0004Ej-6u
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 03:28:30 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIlJq-0005LH-59
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 03:28:28 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2b6ef64342aso64246601fa.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 00:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688974099; x=1691566099;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dmsLO5VsOWxV/K7czIhaIYpx/HLDgPQANrakXLKl9Os=;
 b=eeM3IV2d4boMzQ4lZcS0NEKBqoErCJgdMRSb+CufZF+zqoICm52g/yY2ecV15HBIkD
 VhfLKFRh2MimKfvcyu4KsWYbquHo83ONSY3Hz6GCxCMjRQzNdsiP/DEjyZ0NRO6Rejas
 ao1EL9ux1zLSMoX84fR+sM76agvhy5KOLEOqkks10bQPH4Qo2INYDWn34j55m4OKX08d
 6N5XZPoX+NUl0wcmwER2rBJ1+4MWOrGMpfoMoX7I8V82aPUtu2Uu22rYhrpzMbJ639yw
 XEBS39y7F/KxzyEYMuWNAsuyWJGuSyRxahiS7znC7+o4kTtVCu6izINWf8typQ2Uq4lp
 xCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688974099; x=1691566099;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dmsLO5VsOWxV/K7czIhaIYpx/HLDgPQANrakXLKl9Os=;
 b=aLTlT1KDUkRMw49YuoRn4On5THuEIAPqTa0jDeccStr6d5QAZpYrKA5blDGlKRdsLK
 qr/osmA0AyJb2/JUuuu2QHEfFtaCUCiIy+SxYp0mujRbGf/l7GZvUje0XJM7mdT5ZEaU
 5YOmetc2tUhoSxbWryywCJyFVIpN6htq629HRKURDwlTP6616TdzNV8hOID0QMHsRvwD
 jGUZh6QbvqQrKjowqPH7qZQr7kbb32/LzAYaV9vsvQx34agBu5uwOE76gRen1k7BqZYJ
 AJydJ6ZkwvPWNJA8UgHQMaGohld2/M4tYZFfg3WCI3ROXpzLd5sJTw1SaKmbYe3dVoHx
 gJbg==
X-Gm-Message-State: ABy/qLZUYrRc90xNcBPUu67jMPhgO/0ny51kEVamUSNCgIoZzziqFZyq
 tCNZ7+h8ek5A925TKKFPr3hBN5xlcLi6qsgyg4t+fw==
X-Google-Smtp-Source: APBJJlFDhDdffDiwcDS5FBALVtchmPzuq8ufpyeBhgNFKIrWhA2zGX2cjXjfGHm5x/jZj6z8F5f5ng==
X-Received: by 2002:a2e:9dcb:0:b0:2b4:6195:bb26 with SMTP id
 x11-20020a2e9dcb000000b002b46195bb26mr9283407ljj.25.1688974099096; 
 Mon, 10 Jul 2023 00:28:19 -0700 (PDT)
Received: from [192.168.8.133] ([148.252.133.210])
 by smtp.gmail.com with ESMTPSA id
 f11-20020a7bc8cb000000b003fbb618f7adsm9441390wml.15.2023.07.10.00.28.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 00:28:18 -0700 (PDT)
Message-ID: <6f7e7eb1-0837-58d4-1b6b-4f408150579e@linaro.org>
Date: Mon, 10 Jul 2023 08:28:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/1] hw/arm/sbsa-ref: set 'slots' property of xhci
Content-Language: en-US
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>, rad@semihalf.com,
 peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: quic_llindhol@quicinc.com, marcin.juszkiewicz@linaro.org,
 chenbaozi@phytium.com.cn
References: <20230710063750.473510-1-wangyuquan1236@phytium.com.cn>
 <20230710063750.473510-2-wangyuquan1236@phytium.com.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230710063750.473510-2-wangyuquan1236@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 7/10/23 07:37, Yuquan Wang wrote:
> This extends the slots of xhci to 64, since the default xhci_sysbus
> just supports one slot.
> 
> Signed-off-by: Wang Yuquan <wangyuquan1236@phytium.com.cn>
> Signed-off-by: Chen Baozi <chenbaozi@phytium.com.cn>
> ---
>   hw/arm/sbsa-ref.c | 1 +
>   1 file changed, 1 insertion(+)


hw/usb/hcd-xhci-nec.c:    DEFINE_PROP_UINT32("slots", XHCINecState, slots, XHCI_MAXSLOTS),
hw/usb/hcd-xhci-sysbus.c:    DEFINE_PROP_UINT32("slots", XHCISysbusState, xhci.numslots, 
XHCI_MAXSLOTS),

The default is XCHI_MAXSLOTS, not 1.  So I can't see why you'd need this.

r~

> 
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index 64e1cbce17..bc89eb4806 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -611,6 +611,7 @@ static void create_xhci(const SBSAMachineState *sms)
>       hwaddr base = sbsa_ref_memmap[SBSA_XHCI].base;
>       int irq = sbsa_ref_irqmap[SBSA_XHCI];
>       DeviceState *dev = qdev_new(TYPE_XHCI_SYSBUS);
> +    qdev_prop_set_uint32(dev, "slots", XHCI_MAXSLOTS);
>   
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>       sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);


