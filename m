Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8538736B12
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 13:33:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBZaW-00009A-Mt; Tue, 20 Jun 2023 07:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBZaU-00008b-Dj
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 07:31:54 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBZaS-0001zO-Pc
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 07:31:54 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-977e0fbd742so627846466b.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 04:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687260711; x=1689852711;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rD9VLmftQDJtVbHY8IbTXMoPCQg8DINAVNGXnf4m7qY=;
 b=kZwkG8a4SdwexNzWkdy1qbaQzxT5v8KrV72FDzywZ/GgQMu+aKaIFrqTumUfwELIyp
 ijEIxzV2t2/7IzZy0g2Z5jpd/+ezLFbK14iRyyd2feULuNbiG2KCNbCn8JNorQPS3GDd
 sYh0cb0Et9u6v+LZ16hnYABbyMT991VZeGd5Pzfct9KfBij6CVhTzWiBUnEQH9/WY9pK
 nrxvq9aJm0esYNXpF688/rxP5guR2NfTsoxOmYtSX0xvNlPUTDoVwfFcPRBv1w7z6bj+
 ZVoxz6hcUvbF0oMPkOxD/APhH8h9XGFgbdKOckcHktTXZxN9PFG8XcAYuIa/iV0zocQs
 4StA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687260711; x=1689852711;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rD9VLmftQDJtVbHY8IbTXMoPCQg8DINAVNGXnf4m7qY=;
 b=aYJSnyHWwDoF8coJbkDc6SAgJSNqloS5gKxmpMD97iYzDAzRsfnxmrYDGZdMoqvbyF
 GKZMvYQpW73TWOESmkBf19XQDFIrxB12cAtM+S60nMAuj0zv12KEWsGjBW6A8OxcpUpz
 XjI+hcBd/mQWxrofMH6w/MWGQ8D1NB+C9tr63wd3GEEcyyZSJeQN+35Fz/e8Agb1uvjC
 JvN1jqPS123OWcP2FaIZRsSmWCappkZZrzMU16GuTdD15NfUlne4TTei4T1kCNLLPzrI
 q4OOs7fNC9Pss5Ce4iYrH9l2td63LHZyPlkxMbHgIUoUMTlqq8jL4FsubD/+QAIbQRwn
 QOiA==
X-Gm-Message-State: AC+VfDzvvKXT9rBW2W5oA9KXFgh4YPfSbfJFippR1T00YLLQGtcf4GpQ
 xHnpzCgJbnfQus0bldbno0WSrQ==
X-Google-Smtp-Source: ACHHUZ41/F6TDOeAPzbzLVPRjxkao9gOkOlBI0P9eTUiDgxjj8uQAGH3Z5+u0gFdJP5wQj4Ln38OZQ==
X-Received: by 2002:a17:907:940e:b0:988:76ac:6ff6 with SMTP id
 dk14-20020a170907940e00b0098876ac6ff6mr4710480ejc.25.1687260711155; 
 Tue, 20 Jun 2023 04:31:51 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 bw17-20020a170906c1d100b009893b06e9e3sm722705ejb.225.2023.06.20.04.31.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 04:31:50 -0700 (PDT)
Message-ID: <4e6420d8-a39f-a093-b115-f1a107031ec2@linaro.org>
Date: Tue, 20 Jun 2023 13:31:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 8/9] ppc/pnv: Rephrase error when run with KVM
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Claudio Fontana <cfontana@suse.de>
References: <20230620055911.187065-1-clg@kaod.org>
 <20230620055911.187065-9-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230620055911.187065-9-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

On 20/6/23 07:59, Cédric Le Goater wrote:
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   hw/ppc/pnv.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 590fc64b32e9..fc083173f346 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -799,7 +799,8 @@ static void pnv_init(MachineState *machine)
>       DeviceState *dev;
>   
>       if (kvm_enabled()) {
> -        error_report("The powernv machine does not work with KVM acceleration");
> +        error_report("machine %s does not support the KVM accelerator",
> +                     mc->name);
>           exit(EXIT_FAILURE);
>       }
>   

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Now thinking loudly, we could have an array of allowed accelerators
in MachineClass, similarly to allowed_dynamic_sysbus_devices[], then
handle this generically.

