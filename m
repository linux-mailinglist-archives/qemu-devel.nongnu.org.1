Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 309108A20E8
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Apr 2024 23:30:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rv1z0-0000OP-GP; Thu, 11 Apr 2024 17:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rv1yx-0000NP-7x
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 17:29:19 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rv1ys-00032x-M0
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 17:29:17 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6ecf3943040so317568b3a.0
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 14:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712870953; x=1713475753; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RJsOI0kIFMfF7NmBE+13vGuAmxuOp2z6y46qcjNHHPk=;
 b=ZbGXft0XBJJKD/16Q/s7gT42W6dexpergWdI9QURiEz5pP2OclhCyYWGvYOxn7RWBL
 tA+eKm7oVeSKybFmpqT8lBEGQ+QaBHr+1IXR9hCBZZci7W5V6zFVIGqgovBROVO1MNUN
 PfoXxVjQ9Hv0upjLiejyjrH7Hiix8MFj1qv20xPagVcbiULegM/XHyiAfgSnmkiegLlg
 FrmFPK3L5cLCkoodTTVoWZxQAl+qW0QblUCzmDP66IwQJdSzoiudKUgIDDTk+BulD+6T
 O+ffUrYU9BbhqXsSkFxZQ4firf/aCORy0PKRp5oBJkHRZIfHMuam7ETwLHFWPzw32QQn
 p1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712870953; x=1713475753;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RJsOI0kIFMfF7NmBE+13vGuAmxuOp2z6y46qcjNHHPk=;
 b=Gf4NqQad5YL+a/uuYUxMI+mDM9r7mTN1EW50XlqJFAfrkxYfVtg5jL9hCp3UpNbKGl
 p7e8BXh83msGyMizIJl8ET6FtymqXAtE4i/9yDrvpJu8UFne8koxwqNYeDoiFYwJoMFv
 mYcfvGN6XllSwFy7Art0BTtixjL/Gc++8In3luUb7ASryatr5iXuWt/ryAeuEx4vCxLZ
 7e2XnOWuzM5LNo9pj3cLrmEN+aBHxqfhg+SCqBmEUFXr4SlfhTLrr8FCw9GyjPgb6Z55
 YKXuqLeijal8zwPbTEbL/kt3OvP6EEOxtWA0uLpj+rUPxEJ9B5pJJRJ/QUJmWNjAHevy
 YnNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBwsv/6JpvFTWC+MhrCmrWxHBrJ1V8wL20Y3lPUlBkMOSuBp0FyyMEEILbBveiZRP0UHBvvRBsEqLoBGxkqNRozwew3a8=
X-Gm-Message-State: AOJu0YwmyI1KO7wGgMNG7X557IpqFhs/GqGiwQstyMqajkIEDn6fjygP
 ssnF4NnD8wtykXTBfNORRurf5Y3LQhQyRkuu1Ofx5FwqhaLOnTiZ6by4QzearlY=
X-Google-Smtp-Source: AGHT+IFTsDXFybrBDBfHZcOg7OLhaoZ4jGLRpALM4RHTKVOX4S9xKbOZZ3xLC2DX7/1CD7sPo5NKZQ==
X-Received: by 2002:a05:6a00:2314:b0:6ec:cec1:8fe3 with SMTP id
 h20-20020a056a00231400b006eccec18fe3mr1135997pfh.11.1712870952893; 
 Thu, 11 Apr 2024 14:29:12 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 cb22-20020a056a02071600b005f034b4d123sm1312682pgb.24.2024.04.11.14.29.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 14:29:12 -0700 (PDT)
Message-ID: <9dbb14fc-fec9-486c-b480-86a6c5f3f84e@linaro.org>
Date: Thu, 11 Apr 2024 14:29:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] hw/riscv/virt: Replace sprintf() by snprintf()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20240411104340.6617-1-philmd@linaro.org>
 <20240411104340.6617-8-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240411104340.6617-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/11/24 03:43, Philippe Mathieu-Daudé wrote:
> sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
> resulting in painful developper experience. Use snprintf() instead.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/riscv/virt.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index d171e74f7b..b3fede1207 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1619,7 +1619,7 @@ static char *virt_get_aia_guests(Object *obj, Error **errp)
>       RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
>       char val[32];
>   
> -    sprintf(val, "%d", s->aia_guests);
> +    snprintf(val, sizeof(val), "%d", s->aia_guests);
>       return g_strdup(val);
>   }

g_strdup_printf.

> @@ -1785,7 +1785,8 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>       object_class_property_add_str(oc, "aia-guests",
>                                     virt_get_aia_guests,
>                                     virt_set_aia_guests);
> -    sprintf(str, "Set number of guest MMIO pages for AIA IMSIC. Valid value "
> +    snprintf(str, sizeof(str),
> +                 "Set number of guest MMIO pages for AIA IMSIC. Valid value "
>                    "should be between 0 and %d.", VIRT_IRQCHIP_MAX_GUESTS);
>       object_class_property_set_description(oc, "aia-guests", str);
>       object_class_property_add(oc, "acpi", "OnOffAuto",

Ok.


r~

