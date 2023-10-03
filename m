Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B437B746C
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:02:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnoOa-0008Ol-V2; Tue, 03 Oct 2023 19:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnoOU-0008O3-Dr
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:01:35 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnoOR-0004bg-Bk
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:01:33 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3af86819ba9so910340b6e.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696374090; x=1696978890; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZLcV46YMSHEpMV+PKueirvOZSKYDclSuCnidjEsGXic=;
 b=A9aAl7Qb0RVWP9cTlthDJOjCAgKxO9OUA/VuuJmr3inKiL28fsD1tSnm0EqtTiSDtp
 qm8zfndmudJGRQdE/Rd1Uwk3LpwKGlsx15HE2zZJVI42QdOYl56cUf66t2q24Kj+p+jR
 VN3jKUdaXAHNBaO5KvZXzVYjGFErrEy2HiGTWbCycnaSyB/47QAc5LvJkUlDn9H1rYFv
 j5Q8q32X9B0b6ioYvtsgiQsaIB/Se4XT/zScS1HLNQmNVIBut+zCXINBMlpmytraGOGa
 T+DjKm9QK0bBhvyL2zHv3NTyA4hH3um43xdRemjP2Vpl5HfaNWVhiwAB45VX75mcoO4k
 zwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696374090; x=1696978890;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZLcV46YMSHEpMV+PKueirvOZSKYDclSuCnidjEsGXic=;
 b=N8gKVw2uxxjIIiwqRghF1BKpHIZ+zO6fEuBblsIoZmSk+pfU1LT3QRo0UINRif4HVe
 /vt+EOZWr24pE4oY/KHJvU+d9YeD7WlpurTPj+2m9ehhERDTiPajM+7pKzWaNBgEEMyB
 yUtBhFdXavPz+cAUUg3b/q8GVwzLrIyePxzhlArQHbVNe2oneUDKXJZggo+OYARzTOq4
 drdGEpBX/gAK1oW2/vhMms17xDGq1OPIwd+Mxtqw30scfV9ed0Zn1uzbakDd31x7DbjN
 N8bhQgK/Kcx5JPx42Z0fzxZoBapMf04e+PxggG+jFnAkMYusbtNWP0qIUHprifmqIQs4
 gUeQ==
X-Gm-Message-State: AOJu0YxulpT1yVXMsp+hIsWJIiwzov8E20SAEiP/erQlL0GZI1CUAr0g
 r2KwJVSMwGl7Yzatch4RpiokVQ==
X-Google-Smtp-Source: AGHT+IFUqItOQsUqhxHmi6Ob2XebfLAU2NVnWCPzhJlVa7hZy/aPpPuS10psK88+Y0q1NDIZzqgyBQ==
X-Received: by 2002:a05:6808:2092:b0:3a7:1278:1899 with SMTP id
 s18-20020a056808209200b003a712781899mr1095808oiw.15.1696374090004; 
 Tue, 03 Oct 2023 16:01:30 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 s11-20020a63b40b000000b005776446f7cbsm1684679pgf.66.2023.10.03.16.01.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 16:01:29 -0700 (PDT)
Message-ID: <4e1ade7c-8414-eade-6ea6-5e3fa58583fb@linaro.org>
Date: Tue, 3 Oct 2023 16:01:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 18/19] linux-user/s390x: Add vdso
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, laurent@vivier.eu
References: <20230930021529.987950-1-richard.henderson@linaro.org>
 <20230930021529.987950-19-richard.henderson@linaro.org>
 <92c8b00d-157e-6a03-7629-c331cf41ffc5@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <92c8b00d-157e-6a03-7629-c331cf41ffc5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x236.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
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

On 10/3/23 06:07, Philippe Mathieu-Daudé wrote:
>> +++ b/linux-user/s390x/vdso.ld
>> @@ -0,0 +1,69 @@
>> +/*
>> + * Linker script for linux x86-64 replacement vdso.
>> + *
>> + * Copyright 2023 Linaro, Ltd.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +VERSION {
>> +        LINUX_2.6.29 {
>> +        global:
>> +                __kernel_gettimeofday;
>> +                __kernel_clock_gettime;
>> +                __kernel_clock_getres;
>> +                __kernel_getcpu;
>> +                __kernel_restart_syscall;
> 
> Where is __kernel_restart_syscall defined?

It isn't, and I guess isn't needed for qemu (we have QEMU_ERESTARTSYS).
I'm not sure why it's an exported symbol for the s390x vdso for the kernel, even if they 
do require some user-space code.

Anyway, I'll remove the symbol here.


r~

