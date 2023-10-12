Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A78D47C6418
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:32:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqnLG-0004gZ-6K; Thu, 12 Oct 2023 00:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqnLE-0004g3-7u
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:30:32 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqnLC-0006WJ-C7
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:30:32 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-53dfc28a2afso954468a12.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697085027; x=1697689827; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VG8Xk44hp9JxvabFTtXK+e131SlWFy24PsH13mlhw64=;
 b=iSC2XVcF9Wh6L2AgI2d4XPx4Vo/TNlk3KemJToryB8+nGaEI4IAu14PwkBlzqrtNGf
 vr5/Y3AtDQ3RUKR/lUjWVqP1v4W/8VZ6XJyxh0zeDAMV64LdSuJ08hQzgnwgiRe+DSh1
 /exDrKKmtfhVMwB/e9PgtfMkM1jEtLE9XptEVyNVTURYZMYrgu6lrRDzLaFESATL8Bzn
 IFYTCp2GDzTv2HcOJhQLnM+5TRyFYVkXzhCmdWKkp6jJGKUx5Vvfl1PZ19aa9LlcfIor
 isziE2iTzklw76zWDSZBmC0SC1ZXgmd0CLxKCrfwB3wHTH0SzHOowb3ewktcS0ADa9JP
 ogAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697085027; x=1697689827;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VG8Xk44hp9JxvabFTtXK+e131SlWFy24PsH13mlhw64=;
 b=A+H/ek3HijjkAP0ePvHabnD4VYdZ8Hq2vSvnyD5tTZlZVbrhPDtE9RmxZEUZmkh3Dw
 kcYtgwl4sRUSDcqEOVCYrH71RlVmWvTmxLiZ8UT/3DrC1MtIes+DCdGYgzJYPvbSpKHc
 ycAPlaQYy055vCEMyV1bKh1iY3gYEnstD7mGQOFDFiHKtvYlA2b33WkHgANc/hyrqD05
 CLbNnvGiHc2iETBTTJY4drLEvq3xRC6mf8QtvB6vljYcgJFYTUWo7K1YXsdcwkrd01kx
 wn7wLuvgGTZAiqEG3g6W8ZHHlwVo4sLUyY6o2+7LojZkcnrNP7j9pm5oEV2uqpWvB6Bp
 yanA==
X-Gm-Message-State: AOJu0YzBAk8t9l+AKWSP08E5AuFy+H18kmitcllMigm7o2+tKq2kyXU/
 ZU20317DIZqkUgM8hb8rAbtCuQ==
X-Google-Smtp-Source: AGHT+IEfJXe20Op1Ag9DUrwgRxuSEFf9THgZww2zOYsHf8NXAM8agqumnRlIS9T4pnqRH6jVHngxwQ==
X-Received: by 2002:a05:6402:22b0:b0:53d:bb21:4d90 with SMTP id
 cx16-20020a05640222b000b0053dbb214d90mr3232027edb.40.1697085027160; 
 Wed, 11 Oct 2023 21:30:27 -0700 (PDT)
Received: from [192.168.69.115] (dcs23-h01-176-173-173-31.dsl.sta.abo.bbox.fr.
 [176.173.173.31]) by smtp.gmail.com with ESMTPSA id
 eo15-20020a056402530f00b0053d9cb67248sm2704584edb.18.2023.10.11.21.30.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 21:30:26 -0700 (PDT)
Message-ID: <b98e4566-56b4-d0e4-adb2-c163c7c26cfb@linaro.org>
Date: Thu, 12 Oct 2023 06:30:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC/PATCH v0 01/12] hw/arm/virt: Avoid NULL pointer de-reference
To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>, peter.maydell@linaro.org, 
 alex.bennee@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: quic_tsoni@quicinc.com, quic_pheragu@quicinc.com,
 quic_eberman@quicinc.com, quic_yvasi@quicinc.com, quic_cvanscha@quicinc.com,
 quic_mnalajal@quicinc.com
References: <20231011165234.1323725-1-quic_svaddagi@quicinc.com>
 <20231011165234.1323725-2-quic_svaddagi@quicinc.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231011165234.1323725-2-quic_svaddagi@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

Hi Srivatsa,

(+Markus/Peter for QOM fu)

On 11/10/23 18:52, Srivatsa Vaddagiri wrote:
> Avoid dereferencing a NULL pointer that its_class_name() could return.

While your patch is correct, there is some code smell
around its_class_name(). IMHO a foo_class_name() handler
should never return NULL.

I'm trying to rework apic_get_class() similarly, see:
https://lore.kernel.org/qemu-devel/20231003082728.83496-1-philmd@linaro.org/

> Signed-off-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
> ---
>   hw/arm/virt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index a13c658bbf..b55d5c7282 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -661,7 +661,7 @@ static void create_its(VirtMachineState *vms)
>       const char *itsclass = its_class_name();
>       DeviceState *dev;
>   
> -    if (!strcmp(itsclass, "arm-gicv3-its")) {
> +    if (itsclass && !strcmp(itsclass, "arm-gicv3-its")) {
>           if (!vms->tcg_its) {
>               itsclass = NULL;
>           }


