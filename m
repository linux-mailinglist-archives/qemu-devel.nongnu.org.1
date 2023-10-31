Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA727DD771
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 22:04:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxvtl-0006Qb-Ka; Tue, 31 Oct 2023 17:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qxvtj-0006QS-KR
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 17:03:39 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qxvti-0003Y2-7C
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 17:03:39 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5a82c2eb50cso55126367b3.2
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 14:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698786217; x=1699391017; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9ASjR43mp/KFEUUjI1ZH6Dvbq6eo1pa1UE6J4c4q/Bw=;
 b=pMmdXs0FzmmdwhhhxerJoihoWfejF6r248LZp1dMrY5snmLptkdChZDRK27I5WeGqy
 bx9vYFeG4eEqXzV4EyvftKtGlEg1CYcN+M0bJibTkha/iSpyCqboiGnythMaHL3JdxcZ
 y3n1DMTDCRIavG5qDIiKo+dxepkBRkdEPUKqSciWMzwJQg8rzxFvQB6zsKO04UJfTnJj
 faAT1TRdHzXwKHFWt9cDuCFrR3YsigZSDhy3xbzzduQobiVdvFvQQpmy5OlIXvaPi8A2
 3VHJb2RZyJ7gbTVI6EGGZx65fWEw+Lz1wLhf+rYQbFmVXKKmhvZ3AtNNvChPNHN1HWcf
 R1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698786217; x=1699391017;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9ASjR43mp/KFEUUjI1ZH6Dvbq6eo1pa1UE6J4c4q/Bw=;
 b=BzEdx1bkAB1qkKA2CnaiPdvQCQMHRbjW/u3MAsAlLq5AOvxoA48HlQtIC/i351q3oQ
 ABDStQwcew3jhgEbvkiEtrQGbQT3pPYAT8SKUY1vbDAMCOvRAIDksxTI9Q+Q2rQIOJ8k
 0dqKsqmWmfFpRiqMzB26jFp8OguEa5+mJqPCyYXuovRbDyVpHLCHZPkUK4YvvMwHXOMH
 3yMBd7L2hUkMJSD+vNlOUjL+8H8jiG67eUh3/i3nSZ+p4Wk0Ckk4+BsSVv43E1JDEqyC
 ncEPJb5aDHy7xUTWmqoEykSVV5d4/VA8wUj6o0e8aIGmjDp99LYdKP/ARMF8unyfYL3p
 k6RA==
X-Gm-Message-State: AOJu0Yxw3Qoe5d+mAJVu/lIS1ZEcZGh9guoOnl44f3b95P0NTVcO4KXS
 83Bt/ogHBikaixPkpDyer/Bw9Q==
X-Google-Smtp-Source: AGHT+IFoPrODV9fU9nTpUU0OCgb03z8FpifWP59PNDLCOTuQL/U3XHJy+c+Rngw+jqKF2cR85Wg5kg==
X-Received: by 2002:a81:c942:0:b0:5a8:2d2b:ca9c with SMTP id
 c2-20020a81c942000000b005a82d2bca9cmr11418942ywl.32.1698786217297; 
 Tue, 31 Oct 2023 14:03:37 -0700 (PDT)
Received: from [192.168.68.107] ([179.193.10.161])
 by smtp.gmail.com with ESMTPSA id
 s187-20020a0dd0c4000000b00583f8f41cb8sm1310837ywd.63.2023.10.31.14.03.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 14:03:36 -0700 (PDT)
Message-ID: <f1dd4a3d-92b6-42a1-a9b3-9675b7ba3f25@ventanamicro.com>
Date: Tue, 31 Oct 2023 18:03:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] hw/ppc/e500: Inline sysbus_create_simple(E500_SPIN)
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: Luc Michel <luc.michel@amd.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Bernhard Beschow <shentey@gmail.com>, qemu-ppc@nongnu.org,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20231030143957.82988-1-philmd@linaro.org>
 <20231030143957.82988-5-philmd@linaro.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20231030143957.82988-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x112a.google.com
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



On 10/30/23 11:39, Philippe Mathieu-Daudé wrote:
> In the next commit we'll set properties to the TYPE_E500_SPIN
> object. In order to ease next commit review, inline the
> sysbus_create_simple() call first.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   hw/ppc/e500.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index f8177c0280..e38f46df38 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -1082,7 +1082,9 @@ void ppce500_init(MachineState *machine)
>       }
>   
>       /* Register spinning region */
> -    sysbus_create_simple("e500-spin", pmc->spin_base, NULL);
> +    dev = qdev_new("e500-spin");
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, pmc->spin_base);
>   
>       if (pmc->has_mpc8xxx_gpio) {
>           qemu_irq poweroff_irq;

