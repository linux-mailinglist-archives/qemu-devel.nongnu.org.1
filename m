Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4AB78D064
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:23:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7n3-0000os-5I; Tue, 29 Aug 2023 19:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb5tV-0005iZ-VQ
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 17:05:01 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb5tS-00027n-F5
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 17:05:01 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-26d1e5f2c35so3108420a91.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 14:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693343097; x=1693947897; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gqNE4/JQUpb7CobD9wA6872guc9yXl/a0O63kdH0V80=;
 b=VKHdfBay8YIuosgtSeE8VPVl9icjFAUy6lm7ln+YoG7a7YoUBEmWxT9QwhFRDUgy9Y
 lHx0mtbkY1VJlIoyFeg6ug6Wu/hnHane3tgoU5bdyml6iyk86WHnFvIrmOZ6VG28Udx2
 iBJH7jeA81TJbkFE8YvbfB4BTYFRLM4xuEFjuMoy9tMiU8tlVD/teMzJrMxCPmwWM0z/
 WYTI6dz/7UOnqxNIvL//hwvQnKB0amsDGd5wU/yvGtZT4q+AclK4Avb/GSP8c/g3499U
 1rTqlWKYBTKNN7O2jQxE5Aa1eGsf/WnM+gUQiQ19qI9ZMJ87XNJW0gODbcIT1Q+Cppwy
 Ym7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693343097; x=1693947897;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gqNE4/JQUpb7CobD9wA6872guc9yXl/a0O63kdH0V80=;
 b=jKGQX8xznHJGjMajt/aa5YJKoDWfybzaheUeqFYlPjhgvc2mZRtJCYN143/i0Yh09+
 o6wWmUnaq2dT/NQ9KIINe4bwt7uHGT4hRqPxHzRWd1nTL/JxKj99L2LvooKK6HafvtQB
 qA6MQzfTLzsDCePFC5HKsi/JTliMc/Ma3tTb+OfsyMEhhl7rlrVT1e2M0CWF8x28cYjj
 V84BEMC6BI2K1UyMCxVVl3wk9QzbWkXKBdyk4n3mQ3stGX9gYrQkN9BtF5vLzkzORpeS
 uEpHCa1Vre4szaDmPLO09bg92M/HZyxWw3PYWlN2/CdzojXEjT8T/8fHwLAIN/GHQMqm
 WMdA==
X-Gm-Message-State: AOJu0Yycm2PA3UoKND4baa12mQy51Y4P+Z5WDrIvhKoW5++ugHGRJpj+
 wgsousWIZC//QxkBfddgBumTGg==
X-Google-Smtp-Source: AGHT+IHW2zwTo+sW5ECW9TqMC8l2RITybQ5zDxa4XSFXz+QreCG8p3kPyeoqzserYd1W7NQ/YbFt2A==
X-Received: by 2002:a17:90b:1b46:b0:25c:8b5e:814 with SMTP id
 nv6-20020a17090b1b4600b0025c8b5e0814mr349418pjb.44.1693343096891; 
 Tue, 29 Aug 2023 14:04:56 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 s2-20020a17090ad48200b0026d533216e5sm13277pju.46.2023.08.29.14.04.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 14:04:56 -0700 (PDT)
Message-ID: <d82f93cc-db75-0956-805d-02aa813e4445@linaro.org>
Date: Tue, 29 Aug 2023 14:04:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/3] linux-user/aarch64: Add ESR signal frame for PACFAIL
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20230822170209.1130173-1-richard.henderson@linaro.org>
 <20230822170209.1130173-4-richard.henderson@linaro.org>
 <CAFEAcA_5C8D+B1ad9RftcckknzS-WMC0o=t-zQKpzC7_9gfJ9g@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA_5C8D+B1ad9RftcckknzS-WMC0o=t-zQKpzC7_9gfJ9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/29/23 07:46, Peter Maydell wrote:
>> +    /* See arch/arm64/kernel/traps.c, do_el0_fpac, and our cpu_loop(). */
>> +    if (sig == TARGET_SIGILL && code == TARGET_ILL_ILLOPN) {
>> +        return true;
>> +    }
> 
> This works, but we'll need to do something else if the kernel adds
> some other fault later that is reported as ILLOPN but without
> an ESR record...

Yes.  I'm not happy about the separation in logic, but I can't think of a better way at 
present.


r~


