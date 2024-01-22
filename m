Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C08F0836463
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 14:23:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRuFs-0008Th-Mx; Mon, 22 Jan 2024 08:22:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rRuFp-0008Sr-VE
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 08:22:22 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rRuFl-0005Z6-8o
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 08:22:21 -0500
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B58CD3F154
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 13:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1705929730;
 bh=6cVA8fWMFl6x88fq4D3SL0fjNy3wS32WKYPg1inKUrM=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=dmlCqfQX1w8GJwhTYVrKRhMWQ2ohIJRtcVXbc7Yhh9eQ0FaYtzr+v1+/HaLKubs5i
 i7QCgXst3SFCTM76Lw38QLXBTP7MCil6t4MgBWFTlQ2rz72d5QxyYB0dWXU7YiSY8M
 pQbphMTPseZUja1gRrRQ8yzIICK6xyViHsiEqvutC9mq64tjC3skcNUeCsY+PT66JT
 p5sjBfUaVAcdzmzodUWRgva1KV64v5HwUhjCoXlMAsyTx5wR7Qoxnfa+17qtvw1DQx
 NmD0vQMm/q9A4X9/nWS30UKoJwG1hkgJ1GuIgLA+6d9nsDKVgbRLk0wrFOKZC3AyJk
 TgZaLHTtmAgKg==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40e6f3c5730so29754125e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 05:22:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705929730; x=1706534530;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6cVA8fWMFl6x88fq4D3SL0fjNy3wS32WKYPg1inKUrM=;
 b=qQ4ZtXdw9Fv+JIHEqrrABO9pl4LM07cZtaWAaHgprsFmMD0IQ4UdVbt2fqLsqi07Oh
 d48SEGpDSJjzFq2TSayLmDIMG+H+m9Nco2YiI5laq9FfpMNyi0sAQd8esx8JRv2OfTSk
 qnkS2ezTi5D3+4D83hvkpBLl64Op+g5EfLgeWC4cO+bPvXODh868I3/jNnzqF42deUfg
 cspJ3N65vm6Di0PeQx2IZUtZmaMob5i4p8t43ChGjK5NYGo093RxdR2TKdHra6o9jHpK
 74347Zs3iDzij6RFbpacNn/wji39ZUpskdNil6/f1fwM7JC1Fy3EbTcScdXzeWBL0WWM
 Kdng==
X-Gm-Message-State: AOJu0YwNkhqEpCRrw9RPaP7nydTsI6Za+x6wCHUxmCBO7PAKdT007HnN
 2j9+QU/qCWRHQ3TQ6k99vbgdBATwRznG3Pcl78kjG4J9+OTytB1gFhyEXijzdT9IW/C2ry9di3M
 HE/qS2N3r3ZizQW2ecAYv8JbVnu576OGFKvHgki7XbrmRb92+tIADLboa0HMHxDeyUW0u
X-Received: by 2002:a05:600c:154b:b0:40e:4794:f225 with SMTP id
 f11-20020a05600c154b00b0040e4794f225mr1575895wmg.9.1705929730408; 
 Mon, 22 Jan 2024 05:22:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHryeTnvpXnUw8ktQ1SGX/ECCaaI0aKUJa/gCbMxzdbYNb5cLlD5/6VlCZMcOg4cN2TQTV4eQ==
X-Received: by 2002:a05:600c:154b:b0:40e:4794:f225 with SMTP id
 f11-20020a05600c154b00b0040e4794f225mr1575881wmg.9.1705929730002; 
 Mon, 22 Jan 2024 05:22:10 -0800 (PST)
Received: from [192.168.123.67] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 az40-20020a05600c602800b0040ead8c6c0fsm3743588wmb.21.2024.01.22.05.22.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jan 2024 05:22:09 -0800 (PST)
Message-ID: <2dfd12d7-d3dc-47af-ba1c-2d2e25cb9c5f@canonical.com>
Date: Mon, 22 Jan 2024 14:22:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] target/riscv: SMBIOS support for RISC-V virt
 machine
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20231229120724.41383-1-heinrich.schuchardt@canonical.com>
 <20231229120724.41383-4-heinrich.schuchardt@canonical.com>
 <20240122-4f4cbce3692cd684e0409f9e@orel>
 <22105210-d8d1-4808-b9ed-41eee71c53ca@canonical.com>
 <20240122-195c4a8d0ece609441068e16@orel>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20240122-195c4a8d0ece609441068e16@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 22.01.24 13:59, Andrew Jones wrote:
> On Mon, Jan 22, 2024 at 01:28:18PM +0100, Heinrich Schuchardt wrote:
>> On 22.01.24 10:57, Andrew Jones wrote:
>>> On Fri, Dec 29, 2023 at 01:07:23PM +0100, Heinrich Schuchardt wrote:
> ...
>>>> +#if defined(TARGET_RISCV32)
>>>> +    smbios_set_default_processor_family(0x200);
>>>> +#elif defined(TARGET_RISCV64)
>>>> +    smbios_set_default_processor_family(0x201);
>>>> +#endif
>>>
>>> I think we should use misa_mxl_max to determine the family, rather than
>>> TARGET_*, because, iirc, we're slowly working our ways towards allowing
>>> rv32 cpus to be instantiated with qemu-system-riscv64.
>>
>> Hello Andrew,
>>
>> thank you for reviewing. I guess you mean something like:
>>
>>      if (riscv_is_32bit(&s->soc[0])) {
>>          smbios_set_default_processor_family(0x200);
>> #if defined(TARGET_RISCV64)
>>      } else {
>>          smbios_set_default_processor_family(0x201);
>> #endif
>>      }
> 
> Yes, but I'm not sure we need the #ifdef around the 64-bit part.

I just followed the style in riscv_cpu_validate_misa_mxl().

Best regards

Heinrich

> 
>>
>> riscv_is_32bit returns harts->harts[0].env.misa_mxl_max == MXL_RV32.
>>
>> Some real hardware has a 32bit hart and multiple 64bit harts. Will QEMU
>> support mixing harts with different bitness on the virt machine in future?
>> In that case we would have to revisit the code using misa_mxl_max in
>> multiple places.
>>
> 
> Never say never, but I don't think there has been much effort to support
> these types of configurations with a single QEMU binary. My googling is
> failing me right now, but I seem to recall that there may have been
> efforts to implement Arm big.LITTLE with multiprocess QEMU [1]. IOW, I
> think we're safe to use misa_mxl_max, since we'll have one for each QEMU
> instance and we'll use a different QEMU instance for each hart bitness.
> 
> [1] docs/system/multi-process.rst
> 
> Thanks,
> drew


