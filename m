Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAA07BD4FD
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 10:17:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qplRp-00080y-8V; Mon, 09 Oct 2023 04:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qplRe-0007za-Ti
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 04:16:55 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qplRd-0005ww-ER
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 04:16:54 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-32329d935d4so3814206f8f.2
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 01:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696839412; x=1697444212; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hXkXTLIzOfJw26nrprQuRnF5RiIlswMt+R7mOJ3z0k8=;
 b=U/L8dwHTlYeMfhsrX1uf+I+aXuxyMoy8eLxxkKKITP4zYFcvG/wbAok6NL4UoW/TTL
 NwXDSAuPtgWxSbXsDgig9kqC0M9udlbP/7i+KUeAQbUDKX4X5JGZKpvaDExWZZT0jk0O
 Voo/xtVoOqHRbu/3wj9gsUyD0nGKKJNeCGzhQDpnIpjx5k8H0rWimUQ2cVbDC7mDNU/A
 +uZmpQQ8TJKJNuz2d/dVEH0M4a7fHYFPDaD4zTWmZhtv71nfGtD3VH4tC7V+NITdYmi/
 lVyHS7S/UghyuQlABGIXT6y7kqs/uwZg4wtgBvRfAHF/Xdud8K75BwIEOp4ZVBzPoZp2
 7Tpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696839412; x=1697444212;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hXkXTLIzOfJw26nrprQuRnF5RiIlswMt+R7mOJ3z0k8=;
 b=K1Ar0BQLA9kyK+8jOncZ49MZfMwmHeXVdlHdwiis0vNEDOSg74Dkqycc8SIFZeZowG
 qxk7kp/M7Gpx22ERHscMorXXt5FW/vT9Gg9MfgE58P5gb4codEcLCBjBi67yACI1BQgc
 WvvzeXggPY0/OYxM+Yp7YRSS4JtiBuME5QM3zn5dDM78qA4O9T7rC8Y1iJSOjaNLrJI8
 tI23jWT+Yt3Jq5J8v8zH/niyV2uMjIglwOOi5GuZ1lLQB9UFcuIkWkCiONPaiwl237q0
 C0AkoNnjTZdkEE+BcGfwOIb+qhl4nBUK0+RAYftsBRwwcWGKClz643TIJ7gb85HtRthI
 j+JA==
X-Gm-Message-State: AOJu0YyUcJ3GkY4Z7YgAmUDfkHKaXK3pSgmH3IKpKj5dOAWomL9z5VcF
 pJeP+zJ6bew6u4VNc6mylt70sA==
X-Google-Smtp-Source: AGHT+IGmhrJynjTgKs8LBesr3W06+k8/ED+mOzR5Npc0iDZK8PdXzX3nvcapZz7/ZhgNrw9QRSG++Q==
X-Received: by 2002:adf:c805:0:b0:329:6bfa:dc8c with SMTP id
 d5-20020adfc805000000b003296bfadc8cmr5996395wrh.46.1696839411592; 
 Mon, 09 Oct 2023 01:16:51 -0700 (PDT)
Received: from [192.168.69.115]
 (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr. [176.170.217.185])
 by smtp.gmail.com with ESMTPSA id
 y14-20020a5d4ace000000b00327cd5e5ac1sm8885193wrs.1.2023.10.09.01.16.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 01:16:51 -0700 (PDT)
Message-ID: <1d01aaa9-6026-0369-59ae-836a49c767a5@linaro.org>
Date: Mon, 9 Oct 2023 10:16:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] memory: follow Error API guidelines
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
References: <20231009075310.153617-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231009075310.153617-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.818,
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

On 9/10/23 09:53, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Return true/false on success/failure.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/hw/core/cpu.h             |  4 +++-
>   include/hw/core/sysemu-cpu-ops.h  |  2 +-
>   include/sysemu/memory_mapping.h   |  2 +-
>   target/i386/cpu.h                 |  2 +-
>   hw/core/cpu-sysemu.c              |  6 +++---
>   softmmu/memory_mapping.c          | 13 ++++++-------
>   target/i386/arch_memory_mapping.c |  6 ++++--
>   7 files changed, 19 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


