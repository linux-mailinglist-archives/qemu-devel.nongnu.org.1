Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5406776D94A
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 23:14:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRJAP-0001cY-S3; Wed, 02 Aug 2023 17:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qRJAN-0001bx-PT
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 17:13:59 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qRJAM-0001Kg-8h
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 17:13:59 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fe110de3b6so1871945e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 14:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691010836; x=1691615636;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AxJDJe9ilR9VVQikCffdfZe2WFJOOgB/KGplmGu7K5U=;
 b=oIu0x7PH4KSCDw0CuCtv0L/COVQUkAgahnb5pT6e+SbrsElA8XHJ/YudJ9PCQii8oy
 qgsso7JyeUGEnMZ8AbLvxv9ysSpuqZ5vg+cQ/iSPj8uxqnh1g6MnnKdWpmesWGEz3Dyg
 FlVk4W/HYcziS7GfOl3nVjBeDqxuy1oqppPXN0PAdslR1qolxKJuh+LQ88iYa7lMYgnF
 NhGShcwShU6cTgMb/+8zCiBEuoYm0I5KLL8GYXeUDIIZDJAlkYjPymwxVE50x8wrishh
 4AjrVpn4eNX+BiVO0KoA0WW8dF2F+6Nx5oj9jRnEdRqAzJh1+Zsc2VauTi+pZ+0wrCZj
 KDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691010836; x=1691615636;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AxJDJe9ilR9VVQikCffdfZe2WFJOOgB/KGplmGu7K5U=;
 b=J2m0/762TZu2ng/5mVkk1xQ04GI69xpxJCkEb7wIUyXyGoyyagrHHWOBoKNhm7UJOe
 u5I2Fi/h5MWClq9IiXXZnmKS6EoplP//EZ2KWO0WkIyIIRm1CtoHOD1gax5jgs+OtEk0
 gnni2331DXXTSTQ4vk3QkwKMoegkiT/yfs8lVZvw3llhIYw85CYLwN3yRTA6fgYl4att
 0Bwt95MGzoMtJqEUWQKT6OXcOF8RWQvxu7b0uzcwgIbbN79kafsJ+/qAM0URCSNq8hzl
 Us74Jahj/GHF6sdG5pknsrdTDIG9yG+RRTZZUJ1Noo5v+jq53e76XMfkd7fi1wySHymi
 4UAA==
X-Gm-Message-State: ABy/qLbQ5SB4H5NWr6gG1yRUSBgpuLYskMPv/8PjVqSky79VMXdB8EIa
 bSeFb0cy7LCIMziIL04TU64fVQ==
X-Google-Smtp-Source: APBJJlHxKgERAO7KcP//oNIoOp4goMGYcFR5kQgcnP2gEaGsv4TLeZE/8JgFSKHLY0Sm+xT8e1588w==
X-Received: by 2002:adf:e546:0:b0:317:6570:afec with SMTP id
 z6-20020adfe546000000b003176570afecmr5975542wrm.3.1691010836612; 
 Wed, 02 Aug 2023 14:13:56 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.158.229])
 by smtp.gmail.com with ESMTPSA id
 17-20020a05600c249100b003fe26bf65e7sm2575167wms.13.2023.08.02.14.13.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Aug 2023 14:13:56 -0700 (PDT)
Message-ID: <6cbfa624-6690-b2c6-4946-c1e44733a595@linaro.org>
Date: Wed, 2 Aug 2023 23:13:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 1/6] hw/i386/intel_iommu: Fix trivial endianness problems
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Xu <peterx@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20230802135723.178083-1-thuth@redhat.com>
 <20230802135723.178083-2-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230802135723.178083-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.102,
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

On 2/8/23 15:57, Thomas Huth wrote:
> After reading the guest memory with dma_memory_read(), we have
> to make sure that we byteswap the little endian data to the host's
> byte order.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/i386/intel_iommu.c | 5 +++++
>   1 file changed, 5 insertions(+)

Maybe worth adding a comment in "hw/i386/intel_iommu.h"
around VTDPASIDEntry::val mentioning little endianness.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>




