Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 623517CE659
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 20:25:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtBDw-0003pT-GK; Wed, 18 Oct 2023 14:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtBDu-0003oG-VX
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 14:24:50 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtBDt-0002iD-9X
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 14:24:50 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9b96c3b4be4so1123707366b.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 11:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697653486; x=1698258286; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4ufZo3aBED985y+HEvMQWfccNubXrdsVggrXkAwGK/g=;
 b=widsE0/RLXEX0p3ny7OGa0ty0HUvWizGHUaLpTfxYEozcWA8FKsu1qEhj2JJpxG7lt
 In4iV00mmSobh47462BdTZaqP5tJTamtZU907WAHs2BCUW6YEzyX/jnKelLnn5hVOgDm
 nkEq/x7+IXw4iWVeDL6xNpzNDD8FkpSCTdAZ3s/OG0wr3L6ssutOA3IX+z/GaJXt4trL
 JTN6BO08eDGdJHbNylbemEX9K2aNARe2CAOvJzwYDSdzjxmMVrKxaE6yq3Z2yvltbbXo
 3rvsVMSSfcYRm2cydDwjFFeazr0PB3B0fPEZ+UK8d0V+HwH+I8+5FUyYVHSyDfZ0GnHq
 X2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697653486; x=1698258286;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4ufZo3aBED985y+HEvMQWfccNubXrdsVggrXkAwGK/g=;
 b=XtA7hqzNsRFymSetDZucVvJm6ZRaQFli9s0LXW/lsjueeg7BDUpZZQbx89kW8t3dzY
 VNdX2ft1oh329HYnaDyZG473Pfr5p/9V1jNDOBtZxWtIbjVwe/yMy81AD7IB90TpyIIE
 FaEQ4CzXVP2MB7Q1BIS+MBPvqo7Uois6pcaYjZhrum0IGc7qNtlI3eowf12g4pd2Sw3k
 Dsj76mFs9gwp1c55IJ5YBowmTc5ZoipWsyP6lPR83rXmkL+fzWnQ95xuULAi0ioz2Abw
 RS0eijszpECv1JuOpRWvuXKdFkVeRmT66oJzmkf2E7kbTMNPhDq8n8f1UMT15APx5kP6
 3H0g==
X-Gm-Message-State: AOJu0Yxhms5M+ZdMgcA14+pPsyKIZ7JP2L+L2WzKgWDpYrIf57zr5yUi
 eFaAwXBHSa3hEGjKlgmS9IDCHA==
X-Google-Smtp-Source: AGHT+IFlqI6BLbQL8Cz041noG1aFuKhj0j2S4fczU9rpiBySOM+le8tajj1TsdkwRKCA6BW5XUzV0Q==
X-Received: by 2002:a17:907:2da7:b0:9ba:dcbf:6f53 with SMTP id
 gt39-20020a1709072da700b009badcbf6f53mr43454ejc.35.1697653485914; 
 Wed, 18 Oct 2023 11:24:45 -0700 (PDT)
Received: from [192.168.69.115]
 (gyl59-h01-176-171-218-149.dsl.sta.abo.bbox.fr. [176.171.218.149])
 by smtp.gmail.com with ESMTPSA id
 jz14-20020a17090775ee00b009b27d4153c0sm2153997ejc.178.2023.10.18.11.24.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 11:24:45 -0700 (PDT)
Message-ID: <5230f54a-2e2e-c086-a675-2f45348a8468@linaro.org>
Date: Wed, 18 Oct 2023 20:24:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 12/12] hw/sysbus: Ensure device is realized before mapping
 it
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Sergio Lopez <slp@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Song Gao <gaosong@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20231018141151.87466-1-philmd@linaro.org>
 <20231018141151.87466-13-philmd@linaro.org>
 <44597d18-292d-4a4a-91b0-febf2519d9b8@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <44597d18-292d-4a4a-91b0-febf2519d9b8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 18/10/23 18:13, Thomas Huth wrote:
> On 18/10/2023 16.11, Philippe Mathieu-Daudé wrote:
>> sysbus_mmio_map() should not be called on unrealized device.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/core/sysbus.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
>> index ce54e2c416..a46828a808 100644
>> --- a/hw/core/sysbus.c
>> +++ b/hw/core/sysbus.c
>> @@ -20,6 +20,7 @@
>>   #include "qemu/osdep.h"
>>   #include "qapi/error.h"
>>   #include "qemu/module.h"
>> +#include "qemu/error-report.h"
> 
> I assume this hunk should go into the previous patch?

Oops indeed...


> With the hunk moved (or the order of the patches reversed):
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Thanks!


