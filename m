Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D0F7B3BD1
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 23:10:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmKkH-0004QI-7k; Fri, 29 Sep 2023 17:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmKkF-0004OB-BB
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 17:09:55 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmKkC-0001gj-Sb
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 17:09:55 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c61acd1285so79600065ad.2
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 14:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696021791; x=1696626591; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PPVWU28wCukLqZnpl3xxllG1iKKSfXKVz0UHB99p4tY=;
 b=HaUYYV4COCwNQjbwtBwaY3Y2zfznI9aHeNzPaZPIbXi6ucFIe36jcdKJtE+9aQr2Kx
 IdSHWGweBAx+VI/qyqIjfmnkGP5E3+j1OvgkJmzLELh8/APR1+bS6CzZBDEByi1zJfCl
 NKQWND2VGRLE0thFIKYIDIilajzeupTXSHMIpi4HvmAqZKSYSYHhc49FlEkC1p5mBmZV
 dgmO/RXw+mIp8OUWTsMcEngk15KIExjygoFTtmbnTuznS0s0Lzzeu6tf/dl59N6ddEta
 9o17NhAKYHLCuHfh5DMeOnh5Llgj6c8x4OCg6FsnXRuYJZvivK/YMTxbEicqy9c2qcr1
 v3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696021791; x=1696626591;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PPVWU28wCukLqZnpl3xxllG1iKKSfXKVz0UHB99p4tY=;
 b=cjaEe2kVmHUuFuqJV4EljrRe06g+rCjZFswnyChZVmmvL2JopkBY0w0tyxx9xH3y37
 ZTPimgjvu28lR9oc90NEXO7IBXCNQH0/ffolJfiUBSG2+ex7U9z6C6Uo5ul1B+0Q3Rq+
 xd/EdZa8XdaZmVoNenVDDSWAsjHL7sEQ0xaxXKSY5vumajpjKB3OSdAdf6/HWfKaiVM0
 hzJAogZBSkZ+SlCzuw8x98ES+Jnuu7XyjH8kd9U1uVQcnKbWz3VNfNVtE7UNxCnt3b5J
 23/SREMk62sJkvQpAhNUh9ZnbZ/DgnvZh08N9NpPhv9cLC7wIKX7wHms1MLySHte3w0x
 XXVw==
X-Gm-Message-State: AOJu0YwYZaP9IgYcpnRrJpsj4YIpf+Nd1JI7XOTuz8NXfCC1Zpr2HKb4
 kSrZtz+GAT4mAWlb2YDULh+Q8g==
X-Google-Smtp-Source: AGHT+IHp78VTM1P/b3he1jDMdXR8KhD937TRiZfqhB7QkyBhLH8YHD1Ob1VDgsc44/mfDwckhq+euQ==
X-Received: by 2002:a17:902:ab47:b0:1c4:a650:21df with SMTP id
 ij7-20020a170902ab4700b001c4a65021dfmr4234958plb.50.1696021791435; 
 Fri, 29 Sep 2023 14:09:51 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 jj19-20020a170903049300b001b9d7c8f44dsm8166606plb.182.2023.09.29.14.09.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Sep 2023 14:09:50 -0700 (PDT)
Message-ID: <594b2550-9a73-684f-6e54-29401dc6cd7a@linaro.org>
Date: Fri, 29 Sep 2023 14:09:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 07/22] exec/cpu: Introduce the CPU address space
 destruction function
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230918160257.30127-1-philmd@linaro.org>
 <20230918160257.30127-8-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230918160257.30127-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
> --- a/softmmu/physmem.c
> +++ b/softmmu/physmem.c
> @@ -761,6 +761,7 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
>   
>       if (!cpu->cpu_ases) {
>           cpu->cpu_ases = g_new0(CPUAddressSpace, cpu->num_ases);
> +        cpu->cpu_ases_ref_count = cpu->num_ases;
>       }
>   
...
>   
> +void cpu_address_space_destroy(CPUState *cpu, int asidx)
> +{
> +    CPUAddressSpace *cpuas;
> +
> +    assert(asidx < cpu->num_ases);
> +    assert(asidx == 0 || !kvm_enabled());
> +    assert(cpu->cpu_ases);
> +
> +    cpuas = &cpu->cpu_ases[asidx];
> +    if (tcg_enabled()) {
> +        memory_listener_unregister(&cpuas->tcg_as_listener);
> +    }
> +
> +    address_space_destroy(cpuas->as);
> +
> +    cpu->cpu_ases_ref_count--;
> +    if (cpu->cpu_ases_ref_count == 0) {
> +        g_free(cpu->cpu_ases);
> +        cpu->cpu_ases = NULL;
> +    }
> +
> +}

I think it would be better to destroy all address spaces at once, so that you don't need 
to invent a reference count that isn't used for anything else.


r~

