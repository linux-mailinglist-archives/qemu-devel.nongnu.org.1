Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D82799C12
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Sep 2023 01:32:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf7RV-000562-0N; Sat, 09 Sep 2023 19:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf7RT-00052E-Me
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 19:32:43 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf7RR-0000EN-HL
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 19:32:43 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-1d4db7959f6so2431130fac.0
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 16:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694302360; x=1694907160; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hklIEyvEMdt+6pjJnj9lvNqIg+adlSoBHDezk3jIHmw=;
 b=eAgw170AaaZxd+jhKoZVMrMMFJs3kxgAHuL91GJiUh/447coLT5Cn+D6E5mlOS0jbS
 3e1N2/ujQvAyyI4Qswp4iHNW2oT9iIHkTVm4nZ5NjoDUyL3wBsfe+glB9XC0BQy5lrcs
 xriVtYBWko6clUph4v8Idc9epRq9KIyUN+BDHZ5p89W/M7GcIbFsu57BFxm9LGuVrtov
 2BdgWFyRm37fFkQmGrlOlOB1+I/c+zQNxAhVKwJ104lrcJCrOYX9ZQXIcR4uDzpbL36g
 Q39thsJUEDUEG0OpDdDeYznaxQWG9SOJ7IUANDgKHEiTiCO5KmqkDem5QWz20GYnvKzt
 IP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694302360; x=1694907160;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hklIEyvEMdt+6pjJnj9lvNqIg+adlSoBHDezk3jIHmw=;
 b=dW44llZRlCMslz8J01TMwwvEGGZ5AeB1Lh8wVP9U8mFhWboVozmxKahcyC/gDplvBy
 /xaZWnt2WSOTrQY/txYQ1+3LdEnS4e9QAyfpFmL+MXDyWlIFFJ2zIHlnUPwBchcsP6Ge
 N4nOrvYX+vn/4wzop65m/6XWpwOVBp2bAepwAKh+ZatJ76aPBNUhgLUkTow7IkvsATD1
 lgsDoPiRW6NH/EPdzDLhbnMFVgYSSbim8ErYGxZOIJjogAqh35MjS6Ut/V4lfHcHyLNb
 +nzamFdUGGl3E/UXo1q+GrTJCzMLJf5GZfHKw8ivUPm3Nb+9697ne13coE8n2YovINOj
 aV6w==
X-Gm-Message-State: AOJu0Yx99lqXbv13HkwoooENKviKoujc325+Ef7KpjvXOhoXg1Zn0Xc3
 x+taCOYm0vfLUnmYKYUE+tmrAw==
X-Google-Smtp-Source: AGHT+IEhY4vwQ1atyyj0XqtBPn+kj5StFrNDxnfRNmIcOgAF9OvXbsYdqUVk6Y4yShd2rU6YvRkuCA==
X-Received: by 2002:a05:6870:82a4:b0:1bb:5480:4bc with SMTP id
 q36-20020a05687082a400b001bb548004bcmr6753473oae.37.1694302360231; 
 Sat, 09 Sep 2023 16:32:40 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 iz2-20020a170902ef8200b001bd99fd1114sm3728700plb.288.2023.09.09.16.32.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Sep 2023 16:32:39 -0700 (PDT)
Message-ID: <caa52ece-dacc-782e-015f-f27238482fbf@linaro.org>
Date: Sat, 9 Sep 2023 16:32:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 05/13] target/i386/cpu-sysemu: Inline kvm_apic_in_kernel()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 kvm@vger.kernel.org
References: <20230904124325.79040-1-philmd@linaro.org>
 <20230904124325.79040-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230904124325.79040-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
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

On 9/4/23 05:43, Philippe Mathieu-Daudé wrote:
> In order to have cpu-sysemu.c become accelerator-agnostic,
> inline kvm_apic_in_kernel() -- which is a simple wrapper
> to kvm_irqchip_in_kernel() -- and use the generic "sysemu/kvm.h"
> header.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/i386/kvm/kvm_i386.h | 2 --
>   target/i386/cpu-sysemu.c   | 4 ++--
>   2 files changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

