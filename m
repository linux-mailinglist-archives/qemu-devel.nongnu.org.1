Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B2879E5A0
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 13:02:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgNcm-0007e6-UM; Wed, 13 Sep 2023 07:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgNci-0007dQ-M1
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 07:01:33 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgNcg-0001rt-DW
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 07:01:32 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-52a3ff5f0abso8620218a12.1
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 04:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694602888; x=1695207688; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o6bQ9qIFAQjmGDcYvu8QwCAp5qPKggwYx6E19UhI450=;
 b=PI2Guz+8t+ZpHYBdmwYY5Y7qiJZCxdaYwSO/e9POP1yoZNg8h3r6vka82LkOdjK5Nn
 3Q+YFGYMnwu7PEJCJaTe51nAJxQe11AmBK7I3rLv17umbzuTMcIFqB7ep2l/LzCe3uwz
 qMimHQBOLEyVtn7qW/xF9v6incRtt85E6V7MzIEKmeQDt7Hf4pWmkvxdspkByzBqZ8VH
 3XbXe9M7ILL9vkMBBfL7EZ4e11txysq8Nn6sAmvwABRrJFnMejIGgNrJh+ff2r4mdQF0
 GPP3lJPDL8FON0+jcPXNa+01gwAOEyrjCdu7uBDRwWjIkr/sLamSN1yN90RhjJyyUkoB
 /h0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694602888; x=1695207688;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o6bQ9qIFAQjmGDcYvu8QwCAp5qPKggwYx6E19UhI450=;
 b=gyZgE2fOCP4iKiJUZrWEkvT1hB2VcpjDy45IQaj58nGiiXoIoGVNK/N/obod2g6IVf
 uR+1gKL5hmfgYU6mvgGkMkVcVe6+0nmfthSVy1l8jITai30Kp6Qh5fMrUYiQ+rGaLq1L
 pT4bjP3JMEeZGP8k6O5TpDuUB5zzCjX+ZG4xvlWdH/RMr56h4gq6HeHyzNwPRyqiYsXX
 Opun3W8WHmyAFQMKkhaCA28Jz8VL6pbcF/rxzKQOpGkK63TJB9rLsHZbUk8WGnsj7Btg
 ITNzyI+zQoX8sS8gpwqG/RZ8ei1sQPHOJPUNuzdbsbW6kPJd6vnFl4lY3fFU1z7emKzI
 5E4Q==
X-Gm-Message-State: AOJu0YwYI/kOn8Z4/ttbSo+ANM0EJGHCyGQc8bI4AOkZZ9T9T3GwJZXr
 xuWYI60fan9Dm1+zmYSjNoYgOg==
X-Google-Smtp-Source: AGHT+IE4omAlPVmfnLAIvG/joqNM9bdlE3Hh2WkpgY5OF3atbeSWVsDHR9QNDMtmPgTV28DSwVU8Qg==
X-Received: by 2002:a17:906:53c5:b0:9a2:2842:f1c6 with SMTP id
 p5-20020a17090653c500b009a22842f1c6mr1510581ejo.28.1694602888668; 
 Wed, 13 Sep 2023 04:01:28 -0700 (PDT)
Received: from [192.168.69.115] (176-131-211-241.abo.bbox.fr.
 [176.131.211.241]) by smtp.gmail.com with ESMTPSA id
 t14-20020a1709064f0e00b0099e05fb8f95sm8270935eju.137.2023.09.13.04.01.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 04:01:28 -0700 (PDT)
Message-ID: <ccdf7e04-b85b-8086-dda8-c1394930fa96@linaro.org>
Date: Wed, 13 Sep 2023 13:01:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v5 3/6] target/i386: Call accel-agnostic
 x86_cpu_get_supported_cpuid()
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20230913093009.83520-1-philmd@linaro.org>
 <20230913093009.83520-4-philmd@linaro.org>
 <b905884e-04ad-f195-3228-b0bedc59b66c@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <b905884e-04ad-f195-3228-b0bedc59b66c@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
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

On 13/9/23 12:59, Michael Tokarev wrote:
> 13.09.2023 12:30, Philippe Mathieu-Daudé:
>> x86_cpu_get_supported_cpuid() is generic and handles the different
>> accelerators. Use it instead of kvm_arch_get_supported_cpuid().
>>
>> That fixes a link failure introduced by commit 3adce820cf
>> ("target/i386: Remove unused KVM stubs") when QEMU is configured
>> as:
> ..
>> Cc: qemu-stable@nongnu.org
>> Fixes: 3adce820cf ("target/i386: Remove unused KVM stubs")
> 
> This hopefully should not go to -stable as the issue has been
> introduced in v8.1.0-291-g3adce820cf which is past latest release.
> That's okay though, - just a small side-note.

Oh indeed. Paolo, do you mind removing the tag?

Thanks both!

