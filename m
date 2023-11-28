Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E587FB68F
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 11:02:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7uuw-000572-3t; Tue, 28 Nov 2023 05:02:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7uus-00056u-5P
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 05:02:06 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7uuq-00067v-GS
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 05:02:05 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5482df11e73so6863168a12.0
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 02:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701165723; x=1701770523; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ER0uc6CIIoL95uGJbJd9VeBeocUitkVktcrA1Kz3IT4=;
 b=N6WhwFYXJpvmXnWN3Oyo3fMagBkUP/rKm8hLppq0EOLUmE2KJWnngSJfEi0bD5VcDw
 taF4HKh1VzO7kMLGine6h2KxbvVxcveLsKmRCkpv4PObbl+H5Wdye9PC1pXNHe6gRq2C
 48ZyRAsWROStdnXdihH0oL8Pa8wrw49PVw9Y2fmdsCIrkM4FYsHtEjO0L96Hxhqs4q8o
 qDNz/6vCf0PKjN1tEUiXA7pj0jZdbgWinLn7e3IaOLJKMXrLP9OSfIP544mSGBSkVn46
 jAGLbAQQDXLuI/asAAmnFVsfb31i8D6UTUXaM98UUjW0/q++yp8HNww/8u7RkJLzQpiO
 GM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701165723; x=1701770523;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ER0uc6CIIoL95uGJbJd9VeBeocUitkVktcrA1Kz3IT4=;
 b=Zkon+c9K8TuYbMN3Hk2oSa69QGy3RUkMVjGkG6mf06yYaNG2sRipv8Hw0U5NHbliaa
 8DLplotAvxJBitjX+LlVwYQ2PWM8DYRZ6SnLeXN4adnoNKbJWOfsSbj19ezhT1MyP326
 BavyXgoleZ2iwMFiKtXDyvPsGpw0oFDcSWyfbunGh+Y9Pzn5UGlraDAK/uXFsSGFTNXM
 lctP5ZLPzDhUYFWP/CoEmXvChbDicd65uwIiQ3CFi1uieqTzmw6UOS4QIkmTPTDtS7i0
 y4scTCcMsSwbzW4mGnPlFh9oNfrlsKm7xZCik6A0SFvZOwDEmF2gjRHc96V2LscVXaLC
 KFcg==
X-Gm-Message-State: AOJu0Yw4Ryrq3LZFS7CRGkXLqTyJeQrgs3sQYnW45a3bgNeQSKBBZ6Rw
 uh1rouo9670Santt/ovvHdjDwW2druGJrJRZ758=
X-Google-Smtp-Source: AGHT+IHi4AiKb8dkyzE0kS0l2NWxniOUGLLy8GjCPgsE2hfAhkj5VfrxxNLJz97uPG67XKqVMB5HIQ==
X-Received: by 2002:a17:906:1685:b0:9fe:a92b:9844 with SMTP id
 s5-20020a170906168500b009fea92b9844mr11068106ejd.37.1701165722892; 
 Tue, 28 Nov 2023 02:02:02 -0800 (PST)
Received: from [192.168.69.100] (crb44-h02-176-184-13-61.dsl.sta.abo.bbox.fr.
 [176.184.13.61]) by smtp.gmail.com with ESMTPSA id
 r22-20020a170906351600b00a0c01560bdfsm3835090eja.139.2023.11.28.02.02.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 02:02:02 -0800 (PST)
Message-ID: <605a850b-ebdd-4744-a772-5b20ec171ec7@linaro.org>
Date: Tue, 28 Nov 2023 11:02:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/cpu/cluster: Cleanup unused included header in
 cluster.c
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
References: <20231127145611.925817-1-zhao1.liu@linux.intel.com>
 <20231127145611.925817-3-zhao1.liu@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231127145611.925817-3-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 27/11/23 15:56, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> Remove unused header (qemu/module.h and qemu/cutils.h) in cluster.c,
> and reorder the remaining header files (except qemu/osdep.h) in
> alphabetical order.
> 
> Tested by "./configure" and then "make".
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   hw/cpu/cluster.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


