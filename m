Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4A57D39EE
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 16:44:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quw9O-0005Gu-NU; Mon, 23 Oct 2023 10:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1quw9H-0005AV-0Y
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 10:43:21 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1quw9F-0007C9-98
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 10:43:18 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-407c3adef8eso29068125e9.2
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 07:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698072195; x=1698676995; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P1IKVsTqkj99RDY2qiY/s/KuwiYyjC5GJ/LHuLZqrkQ=;
 b=btRGPQ/pMfu4NtE165Dyjx9dFO0hL0w5xM6HOnLllezGQI30SUojLvJ0Z63pbu7pkQ
 fgKENVix5cAzpejon2WaqHvF01jrWvhh2QcBEvLK6hefsAmlJte/Gu9SGhFzYkqiFD2w
 oikTktQg8AsFkU28BvcARdCohY0irgooIXtXXHdo1qdKihN5Ppyn824BFJayJGpxc4AN
 xb16T5uaWY3q021OVgZZtE6XJkttsux/+R43Nrw3N/4Hxdm4fmgxmWX9OdlTicp1jXTi
 SwRe6sN9lvsZ9LUh6LPjdpJ6Iuuf5iVIV/AAxDE9QtWXJO0y3KqRebj0yjjiGzJt1O4F
 2tPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698072195; x=1698676995;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P1IKVsTqkj99RDY2qiY/s/KuwiYyjC5GJ/LHuLZqrkQ=;
 b=rbMcWMiU/XPe4azbHt0iE6xMFLAc+dBFhCK5WOkjNlCHh7Qe6tqaABBRfhkzHmFVJR
 qtmeLHcLn7XOKU2A+0rlb2MI15g6lzCAMOkWm4O639+zJqrvDf0frIRrnVzS1IR8pko/
 2egD7dIMWuAsjvG3yfXVQaGVGRXEOoYONh/bwV3ef/xwxwJuj3O2IPFHyAafGlcObM+J
 g/RMUW0tiDsnygQRjbGxY5UDwL1RUXypglilFdRDhFO98YPibJXi6VLPGBGf3WOJHwt5
 Q4Y/FM6tgzijPiXLE1WqBtWj+94AJ5CZ2kAu7xvxwxufWd3AX1EVl8pYrpHTUgOZHgVQ
 r04g==
X-Gm-Message-State: AOJu0Yw7RBLvROO4CnMcmvPYaGPDYaMOdZ8RcqBKJkEuJUTR/jxYATn5
 6OxaIvTqoDVwVEqd5JpO7++tCg==
X-Google-Smtp-Source: AGHT+IFEpFZeoolQkRox2vswn7hTGsvDTYt91fu6ANeanQ954bvMDi6GUaI6+LLqqRd+RQi4Fb4y3A==
X-Received: by 2002:a05:600c:3b9a:b0:405:3455:567e with SMTP id
 n26-20020a05600c3b9a00b004053455567emr7199086wms.5.1698072194869; 
 Mon, 23 Oct 2023 07:43:14 -0700 (PDT)
Received: from [192.168.69.115]
 (thr44-h01-176-170-216-159.dsl.sta.abo.bbox.fr. [176.170.216.159])
 by smtp.gmail.com with ESMTPSA id
 p21-20020a05600c431500b004076f522058sm14254044wme.0.2023.10.23.07.43.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Oct 2023 07:43:14 -0700 (PDT)
Message-ID: <35ae2397-9be2-4f0d-1914-1156a10cd71f@linaro.org>
Date: Mon, 23 Oct 2023 16:43:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] target/loongarch: Support 4K page size
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, maobibo <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org
References: <20231023024059.3858349-1-gaosong@loongson.cn>
 <b0e7be32-ab05-a39c-f722-44b2eaac8318@loongson.cn>
 <CAFEAcA8UEC1XSsjuSbwDmiUs03VVK=wTY0PHSte-4f1=hk3EgA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA8UEC1XSsjuSbwDmiUs03VVK=wTY0PHSte-4f1=hk3EgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 23/10/23 12:22, Peter Maydell wrote:
> On Mon, 23 Oct 2023 at 05:06, maobibo <maobibo@loongson.cn> wrote:
>>
>>
>>
>> 在 2023/10/23 上午10:40, Song Gao 写道:
>>> The LoongArch kernel supports 4K page size.
>>> Change TARGET_PAGE_BITS to 12.
>>>
>>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>>> ---
>>>    target/loongarch/cpu-param.h  | 2 +-
>>>    target/loongarch/tlb_helper.c | 9 ++++-----
>>>    2 files changed, 5 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/target/loongarch/cpu-param.h b/target/loongarch/cpu-param.h
>>> index 1265dc7cb5..cfe195db4e 100644
>>> --- a/target/loongarch/cpu-param.h
>>> +++ b/target/loongarch/cpu-param.h
>>> @@ -12,6 +12,6 @@
>>>    #define TARGET_PHYS_ADDR_SPACE_BITS 48
>>>    #define TARGET_VIRT_ADDR_SPACE_BITS 48
>>>
>>> -#define TARGET_PAGE_BITS 14
>>> +#define TARGET_PAGE_BITS 12
>> Hi Gaosong,
>>
>> The popular OS about LoongArch still uses 16K page size, qemu should
>> follow the rule of OS rather than defining 4K page size alone.
> 
> The TARGET_PAGE_BITS value in QEMU is a property of the hardware,
> not the guest OS. It should specify the smallest page size the
> guest can configure the CPU to use. If the guest asks for a
> larger page size than the minimum then that works fine. See
> for example PPC64 -- on this architecture both 4K and 64K
> pages are possible, so we define TARGET_PAGE_BITS to 12,
> even though a lot of Linux guests use 64K pages.
> 
> It is slightly less efficient when the guest uses a page size
> larger than the TARGET_PAGE_BITS value indicates, so if you
> have an architecture where some CPUs support small pages
> but most do not, you can do what Arm does, and use the
> TARGET_PAGE_BITS_VARY support. This makes the TARGET_PAGE_BITS
> macro be a runtime-configurable value, where a machine model can
> set the mc->minimum_page_bits value to indicate that that
> machine doesn't need the small-pages handling.

With heterogeneous architectures emulation, eventually all
targets will use TARGET_PAGE_BITS_VARY.


