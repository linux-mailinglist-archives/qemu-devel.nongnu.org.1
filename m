Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F5F7A2764
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 21:49:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhEnf-0000dA-Ip; Fri, 15 Sep 2023 15:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qhEnd-0000bz-Gf
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 15:48:21 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qhEnb-0008QR-U1
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 15:48:21 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5008d16cc36so4246816e87.2
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 12:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694807297; x=1695412097; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oxxvMdlKt/HRFm5Hf+lIe0aLbT3VZ7UC4ihb/IBSqXw=;
 b=k3yQj+V9he/uRj3ZjPDqwUwE7rL1fmN4mA3GPBWHGCtGOKAx1TWqDc9N0ZrQ2I7DEF
 6G08Tdm39gxVdNDfaAOExiBdHYE1XeLi/cun74YYYyzaPwUT2lfDFykhhImrzr6ZG1d0
 vOreYsHLho3+gdr//Dq2MEBF4huEB7RIhK1mHJLeR1+PevoqVcb0pdzg5+N3BOLrdlZo
 4PyOtfym9NZZMR+aZC+Wb3K1FJNIfSrL0XdE0Vzr4t+MwnKC+HYJIIm+IpdNhuGkXAGT
 INuWgAg05y8xkjCDSrHLiTYs0wfU9vwO/51uUUC7Z7IpIXevS/5PnqL3Mbl/6RwG2Is8
 G8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694807297; x=1695412097;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oxxvMdlKt/HRFm5Hf+lIe0aLbT3VZ7UC4ihb/IBSqXw=;
 b=feu15Vi+FhjS7eYFf9vt1p8ZuqBzVEtLzIuC89A1FNnIh51Jlwp6BHQI5itspdIYmH
 tNM03GxKZyNbcVoHC2ymvvQH+sbmz/FCuoD8pNqvUjCDTAMAPANLd/PXhHu5wj0FOxsg
 0Z5JXz3EDYg/X0aCQEK+qQdp5jWODPEfsBZBlEFQ9shxKx5KIgvXeYBPCLbNv+yzXDdd
 sOmLqiVbmLGrUDkviYj2hxcnMARZ8zUwIptHZgtnkgYpyxYiPAcxUlh2wnQZji791KOR
 GucjyiY21vLWjl9gp26DcGyjqOGVtnmiaYT7dD+PmXycO80QWijCSZ8fvNuKWxnDNxzx
 L1pQ==
X-Gm-Message-State: AOJu0YwYPwLKUTK8gvTE8qP6KC8WXVMlzxdMou20aUyHq6EP4BzyIRtD
 ooBCCQ1Uej2n98bqShLOPBc5msrpGu7HGMCwlsQ=
X-Google-Smtp-Source: AGHT+IEeqBOTpSaUZ0HHwBWzCkrNyr493kdPBxVETf+eT+nCt/rTFhAP6/TQdHGJhUKExZXObPYtbg==
X-Received: by 2002:a05:6512:3b9d:b0:500:807a:f1a4 with SMTP id
 g29-20020a0565123b9d00b00500807af1a4mr3112150lfv.18.1694807297453; 
 Fri, 15 Sep 2023 12:48:17 -0700 (PDT)
Received: from [192.168.69.115]
 (6lp61-h01-176-171-209-234.dsl.sta.abo.bbox.fr. [176.171.209.234])
 by smtp.gmail.com with ESMTPSA id
 c6-20020a17090620c600b009888aa1da11sm2834435ejc.188.2023.09.15.12.48.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 12:48:16 -0700 (PDT)
Message-ID: <882e6f4c-0df4-6a90-9464-f41c764c882d@linaro.org>
Date: Fri, 15 Sep 2023 21:48:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 2/5] accel: Introduce accel_cpu_unrealize() stub
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Marcelo Tosatti <mtosatti@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Eduardo Habkost <eduardo@habkost.net>,
 kvm@vger.kernel.org, Yanan Wang <wangyanan55@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20230915190009.68404-1-philmd@linaro.org>
 <20230915190009.68404-3-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230915190009.68404-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12b.google.com
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

On 15/9/23 21:00, Philippe Mathieu-Daudé wrote:
> Prepare the stub for parity with accel_cpu_realize().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/qemu/accel.h | 6 ++++++
>   accel/accel-common.c | 4 ++++
>   cpu.c                | 3 ++-
>   3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/include/qemu/accel.h b/include/qemu/accel.h
> index cb64a07b84..23254c6c9c 100644
> --- a/include/qemu/accel.h
> +++ b/include/qemu/accel.h
> @@ -96,6 +96,12 @@ void accel_cpu_instance_init(CPUState *cpu);
>    */
>   bool accel_cpu_realize(CPUState *cpu, Error **errp);
>   
> +/**
> + * accel_cpu_unrealizefn:

"accel_cpu_unrealize"

> + * @cpu: The CPU that needs to call accel-specific cpu unrealization.
> + */
> +void accel_cpu_unrealize(CPUState *cpu);


