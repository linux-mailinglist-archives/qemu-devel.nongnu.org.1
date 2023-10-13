Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF2B7C8744
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 15:59:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrIh2-00059w-Ss; Fri, 13 Oct 2023 09:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrIgz-00057V-Ig
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 09:59:06 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrIgs-0001WO-Pm
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 09:59:05 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-53e07db272cso3143945a12.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 06:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697205535; x=1697810335; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mFZ8Hez1D/92l69JU6rcHrVRA5cuRUZMYxrubsP2WRo=;
 b=C6E4bL7ufIhA70NQXh48PqBPpvbD7Cp9pV+QpWi096Dr05yCVhxoUdH09W/ahemfN1
 r+HBcXuFX2C3wfH4zirejbjnubBMHngm44VTU80d9pRh+nWKh+8wTIHq8LYjK8RdqxEf
 S5l+H5otzL4YhZVPAURgG8UAN2rZphWQyKvyZDZoy/gJj2/doKspUrY4kn2C84APi9kl
 QcknnOuPdxH+6afwRXHPdIA4GbWz+1rqLJxqtHIozT70vHzHi3iArmN4TN1FILncJy05
 YxSHx7HFZ8Sbjox5k8kObgTBeLtqhu0yCEz3y26sat4tgs0rykjnPewtVSICLg3VPuqL
 iMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697205535; x=1697810335;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mFZ8Hez1D/92l69JU6rcHrVRA5cuRUZMYxrubsP2WRo=;
 b=rzmlQbdOuh2pJ4ypO+1kwGZR1LgG9wNctbX8u2yb0visBu+kIk0DEg5Vg0p8oGlKxx
 FMf+qpnW8jalF4lW9QKay7ElXEZHkjtZfuM6uXe1AqKN9KMbhcovy1U3HM89/iXltaY5
 JK5SfVWZ0OOptP/hFvlWn7j5AtRw+94Osc+MEq+2aT+YMt3El1OSDY5mZmtlc5pryU+8
 retCbgO6WXNNE6zZhaIXD5Yew8fNVQ1OtNTCcOS1FtHba/9HLPzQKnCZQI5J2BOX1PI4
 F2BCk0MK9fWVtQm0goGlSpXR39mZ7LhFBT1XdWwGrTEx9eM6L7t5i14CBerfHwlrmLXa
 LZRA==
X-Gm-Message-State: AOJu0YwwQ+nmgfn19A77CtG5yl2Npi5bR0swG7LujDawUHcZ35Hx/+5u
 eScWQGU8lYbtgsei23i/zgfeMHgDZLrMq/OuJoE=
X-Google-Smtp-Source: AGHT+IEcuzKPvPOB7Pp7e5wLYdRjtM+jB+eFujYn8zlMUXQOyBpARjvdHsHtRFE9Wwl108qeUHrbtw==
X-Received: by 2002:a05:6402:5207:b0:53e:332e:3e03 with SMTP id
 s7-20020a056402520700b0053e332e3e03mr2539277edd.4.1697205534859; 
 Fri, 13 Oct 2023 06:58:54 -0700 (PDT)
Received: from [192.168.69.115] ([176.172.118.168])
 by smtp.gmail.com with ESMTPSA id
 t11-20020a056402240b00b0053dae8a5e1csm4005820eda.8.2023.10.13.06.58.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 06:58:54 -0700 (PDT)
Message-ID: <d1814aa5-8570-da48-11db-497a863974af@linaro.org>
Date: Fri, 13 Oct 2023 15:58:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 10/18] target/riscv: Inline target specific
 TYPE_RISCV_CPU_BASE definition
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20231010092901.99189-1-philmd@linaro.org>
 <20231010092901.99189-11-philmd@linaro.org>
 <e6a5386e-e33d-464d-b84d-b58ca16429f0@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <e6a5386e-e33d-464d-b84d-b58ca16429f0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
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

On 13/10/23 06:13, Richard Henderson wrote:
> On 10/10/23 02:28, Philippe Mathieu-Daudé wrote:
>> TYPE_RISCV_CPU_BASE depends on the TARGET_RISCV32/TARGET_RISCV64
>> definitions which are target specific. Such target specific
>> definition taints "cpu-qom.h".
>>
>> Since "cpu-qom.h" must be target agnostic, remove its target
>> specific definition uses by inlining TYPE_RISCV_CPU_BASE in the
>> two machines using it.
>>
>> "target/riscv/cpu-qom.h" is now fully target agnostic.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/riscv/cpu-qom.h | 8 +-------
>>   hw/riscv/spike.c       | 8 +++++++-
>>   hw/riscv/virt.c        | 8 +++++++-
>>   3 files changed, 15 insertions(+), 9 deletions(-)


>> @@ -43,12 +43,6 @@
>>   #define TYPE_RISCV_CPU_VEYRON_V1        
>> RISCV_CPU_TYPE_NAME("veyron-v1")
>>   #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
>> -#if defined(TARGET_RISCV32)
>> -# define TYPE_RISCV_CPU_BASE            TYPE_RISCV_CPU_BASE32
>> -#elif defined(TARGET_RISCV64)
>> -# define TYPE_RISCV_CPU_BASE            TYPE_RISCV_CPU_BASE64
>> -#endif
> 
> Move to cpu.h (or elsewhere) instead of replicating in two hw/ files?

Yes, better.


