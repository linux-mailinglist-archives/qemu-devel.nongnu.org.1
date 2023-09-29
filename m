Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2CD7B3BDE
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 23:19:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmKsA-0007iZ-FL; Fri, 29 Sep 2023 17:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmKs8-0007gQ-Ig
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 17:18:04 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmKs6-0003w6-QV
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 17:18:04 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2776ca9adb7so6929437a91.1
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 14:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696022281; x=1696627081; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qFkv6UoUWzcxhcqswv9KdaiC8Yuy2hN+N1RBRDvAW2Y=;
 b=HBVsrhrX5dpW+IiPv6Tb93ExOfZiWguMjhzcXzDIRWo6Rd9Qup1p2d872HV2NceIVW
 q61Bz7OPYoGLBmvaI5jsPDBAa9Q2mQ1VU+TKzfzTTL/85fqmjQs0CRqGYvsNS+MIWhWi
 gaCpa2K/iHvbwFCj5+/nATvVoMZvB5e2TqFibDM7LgTaCGDHbMLlTUEgWnerLYT3jOGv
 NJn2VXaVwsLIUU+SgEyqfR5U1HFWdKHZcd4JdV2JI3MffIko9F26q4v6matU04Jpg+VC
 +HBy2U+dDSYMg6wz3k0aQlJ7b5uhC9U4R3wHhYJoHhl15p8uqACT1vv1k28Q4eWo5LVX
 2/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696022281; x=1696627081;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qFkv6UoUWzcxhcqswv9KdaiC8Yuy2hN+N1RBRDvAW2Y=;
 b=s/p6kVOHTfiGCdFzpqyNILtsdSY2sbXOKf/UWfnpp2VBFwTLZwS0K5qTKOEHFfDQEa
 sTrco2H59eMAnIqyFQUTjjHZRkEU5N6HTpMx7AaajtZZqz2odl1FoNjzXgdqBV/lwEJT
 oVSQSq37HQira05flZ1smLuWjiRTKP5y8Jux0f3d1nsCKyQbsjNTBwMO0L8LFMhdvuHN
 Ed8QPi4UJm4eS0rzqwiOIqqagr8nG3OEBRgUWEkqf5K6s8KNMkKXTjCKSyUWONyjLM9o
 ELtlvE8CvEXogCaoTOE72Fih3V4jYBIZFueOsDlBuRoZP0r3HZbagGo5OKpWkgEb4nPP
 YIJw==
X-Gm-Message-State: AOJu0YziTfQcFrlCWwpyuXXC4zkT2/jOwho6GNrt1OA9cvUo9mW/FQnp
 ryaW/l3whzjjdt4Qj8EADuJUqA==
X-Google-Smtp-Source: AGHT+IHekLRE4F7xzEeryQ1WelLj1baeujweAzidOMgZW8T3zv8rWzyFMAA0LmkVwRtJXdwRyiziIA==
X-Received: by 2002:a17:90b:38cb:b0:274:729a:bcd9 with SMTP id
 nn11-20020a17090b38cb00b00274729abcd9mr4978986pjb.43.1696022281215; 
 Fri, 29 Sep 2023 14:18:01 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 25-20020a17090a031900b00279060a0fccsm2081866pje.9.2023.09.29.14.18.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Sep 2023 14:18:00 -0700 (PDT)
Message-ID: <c7caafd8-1976-8ed2-f08e-99078eade4d9@linaro.org>
Date: Fri, 29 Sep 2023 14:17:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 09/22] target/arm: Create timers *after* accelerator vCPU
 is realized
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230918160257.30127-1-philmd@linaro.org>
 <20230918160257.30127-10-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230918160257.30127-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.295,
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

On 9/18/23 09:02, Philippe Mathieu-Daudé wrote:
> Architecture specific hardware doesn't have a particular dependency
> on the accelerator vCPU (created with cpu_exec_realizefn), and can
> be initialized*after*  the vCPU is realized. Doing so allows further
> generic API simplification (in few commits).
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/cpu.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)

Hmm.  I suppose so.  Considering we have no error return from timer_new().

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

