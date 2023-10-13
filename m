Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 863367C7C63
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 05:57:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qr9IR-0006tC-SR; Thu, 12 Oct 2023 23:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qr9IP-0006sQ-Ld
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 23:57:05 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qr9IO-0004DV-54
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 23:57:05 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5a7c011e113so22625597b3.1
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 20:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697169423; x=1697774223; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kLJsTgpCV8IGz+6OnaZBjvfwx3X3KRa4KAC6RvnLWqE=;
 b=xwKgh85GgGMT4s4YyQjLR4zTRFrlJrYcTDLGF3sp77KuUcT6PJddKarS/vbhBRf7X7
 KCB1O/N+iW2m4syHHtkmqYbQzssHP2rfSTggmoVAQxMGGw+Tdh4+LHNGnUUlZgvzECsd
 mZH3pYAE7gDeN2imY8NPaPXASkMCrKTtc/mHk/Bi/n3YYOvchvcs220YPpnUoi5uFl7W
 MUqln2wS0bpQzn+8UOEP1djiYmk+fKKTWy+nu5vamZ+cMIGvsuONGMT+l6Sb269j8eCc
 KvhVGWSh1aaL7ivDZzRZ1hVmKY/WQfU99kRnZSOwiLUA0uE1o0kcHt1/nUJgKIVYxy7b
 30yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697169423; x=1697774223;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kLJsTgpCV8IGz+6OnaZBjvfwx3X3KRa4KAC6RvnLWqE=;
 b=dXqT6socwH5ihF6uPHlRf6ituvVqZQmKagynwhnKns/46E7/iwDaXeUdWSYT4uZ4ar
 0e8rkkzxV/TkDuSALpmDyxCVn3bcruVqUSXJ3Y8XXCw1O0PRCNeCvu7+1bwtNemH5D4Q
 oRGjgzO0H9RpsDX0ie9OaTEpjZe6hJTqG5zblNzgQ++FXC+MpHZ8DeRI7xmYy9quGYjo
 QtGZ2GoFmX7eR2egEk+yw0oods/WvnxgncbcPX6A8bZlrI1uQUM8EFjJ8w/4oGun/hMF
 Ea2t/dP033sqmrtFccy3sJn9MCWjQEJkzFpnLXjXvsYnkqgLiEEn1oAZtI5HIMspcn3R
 rt+Q==
X-Gm-Message-State: AOJu0YwG7GpBxyJmGgDdqXqqo5IUQ7XADrs0lGeoLVP1MJcx16BTpxTb
 VnuMaDeNnoW/vB+sE1UfMysA6g==
X-Google-Smtp-Source: AGHT+IFU1WD/n3X2gV09ZB/FviU5zQuz/XYQNFhVEk4xWZooXzdiAdEuHuPixaqdUlG3ei2dWSFwvQ==
X-Received: by 2002:a05:690c:f92:b0:5a7:e6fb:39b with SMTP id
 df18-20020a05690c0f9200b005a7e6fb039bmr7572100ywb.1.1697169422812; 
 Thu, 12 Oct 2023 20:57:02 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 w26-20020aa79a1a000000b0069b772c4325sm333393pfj.87.2023.10.12.20.57.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 20:57:02 -0700 (PDT)
Message-ID: <b5d33195-7520-41ed-b5da-bdbf90075cfc@linaro.org>
Date: Thu, 12 Oct 2023 20:57:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/18] target/riscv: Remove CPU_RESOLVING_TYPE from
 'cpu-qom.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-arm@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20231010092901.99189-1-philmd@linaro.org>
 <20231010092901.99189-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231010092901.99189-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x112e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/10/23 02:28, Philippe Mathieu-Daudé wrote:
> CPU_RESOLVING_TYPE is a per-target definition, and is
> irrelevant for other targets. Move it to "cpu.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/riscv/cpu-qom.h | 1 -
>   target/riscv/cpu.h     | 2 ++
>   2 files changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

