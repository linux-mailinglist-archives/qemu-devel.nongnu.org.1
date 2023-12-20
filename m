Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D273081A73D
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 20:24:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG2AK-0003tO-Tt; Wed, 20 Dec 2023 14:23:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rG2AH-0003tD-Aw
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 14:23:33 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rG2A3-0000rv-UH
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 14:23:33 -0500
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AF8CB3F73B
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1703100196;
 bh=js4pgbMeLleNUdg6ReN6OPIZX8bPhOiScNdH+ifeyhI=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=eqicBLGhpiP8rHwTX9ZL3i9WJYcxa7TSrT2m6wtP7MoK9Yx1eAScr5NA5KIRX5zRm
 xXRj/XAvBrQ4CudA2XSuyR2TQ7zvG0fLNkAecSXqtrC3VwHhn1lD14QFEeUs05s+X1
 NEoUml2B7Ny3aRumGosNAhdiww6f97SqhMs/Ne+4vCYp1TKcU+iGRO4Jd4Akwf1xV8
 5H2BgKLyP1c3guLTMEKVcJIzXdiCtXytDQQAcOWjndfiJUJH1JR2WsUHy34iI7Pc0D
 15KZjUtNibUpgpTInaT/c6j/uAlTPphVjbwep/bddMRhHlTtegabq3Op/pLd9yY0wn
 DAr0piAnIuYhQ==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40c495a9c7cso172415e9.3
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 11:23:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703100196; x=1703704996;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=js4pgbMeLleNUdg6ReN6OPIZX8bPhOiScNdH+ifeyhI=;
 b=JlvRxIqsslUDwPrzxXSgmCl6EGecA+g/EB1H9HOdAYWYmADnFTCaQJturPPhcXvlqA
 toRnbFgyEnmWSzuIQsLPOu5msurFfUK0b7KhCIA3h9WFkeu6QeWNeCQzxTbNolIU3SwF
 cHPeCNuFM36av54K1NVTDaO1oN5h1YqFhPqBgZG2duRLgUpX7oVd0zDwM4Uu4/00FKkt
 jho45oOny5nn3NdnONdarMXR3CtTaeq6wpYaZWaNd2o30MfDC99KKs3RDjK+EnUM7N2f
 rtSmKG+918xr9z5ZkRRvKd0qyfTabeKaxDxcONkBnI/gH4dX5ciNAA/aCstkNpA81joW
 2htg==
X-Gm-Message-State: AOJu0Yx47arJopRKIre3MegxH3JFwwL7H9xUtBcrIvNVZTxuEodCiwXl
 Vag6WCIwJfXcPjfc8qekWHUSl67AjPQF5yWEOGjiBpALfBHJ5PFzIC3xWBP3x5ws3yaOCzI0zsg
 ZnG0p/9r1/G4MjVctefqm8ZCubSXqHYJj
X-Received: by 2002:a05:600c:3488:b0:40d:2a2a:c0f3 with SMTP id
 a8-20020a05600c348800b0040d2a2ac0f3mr99201wmq.34.1703100196386; 
 Wed, 20 Dec 2023 11:23:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLCkfHdLgDqAxOpoAAeqZR0yS/9woQAXLoS95ZRMvZCJ9js0eM2dxKiaZ85cTiFhoTeJb4LA==
X-Received: by 2002:a05:600c:3488:b0:40d:2a2a:c0f3 with SMTP id
 a8-20020a05600c348800b0040d2a2ac0f3mr99190wmq.34.1703100196033; 
 Wed, 20 Dec 2023 11:23:16 -0800 (PST)
Received: from [192.168.123.67] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 dx18-20020a05600c63d200b0040c61ee0816sm1190216wmb.0.2023.12.20.11.23.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Dec 2023 11:23:15 -0800 (PST)
Message-ID: <f0299e4a-ca4e-41fe-9475-b06db1bc80c5@canonical.com>
Date: Wed, 20 Dec 2023 20:23:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] docs/system/riscv: document acpi parameter of virt
 machine
Content-Language: en-US
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
References: <20231219143829.8961-1-heinrich.schuchardt@canonical.com>
 <ZYKQdb0xYGVezoqS@sunil-laptop>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <ZYKQdb0xYGVezoqS@sunil-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 20.12.23 07:57, Sunil V L wrote:
> On Tue, Dec 19, 2023 at 03:38:29PM +0100, Heinrich Schuchardt wrote:
>> Since QEMU v8.0.0 the RISC-V virt machine has a switch to disable ACPI
>> table generation. Add it to the documentation.
>>
>> Fixes: 168b8c29cedb ("hw/riscv/virt: Add a switch to disable ACPI")
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   docs/system/riscv/virt.rst | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
>> index f5fa7b8b29..4e134ff2ac 100644
>> --- a/docs/system/riscv/virt.rst
>> +++ b/docs/system/riscv/virt.rst
>> @@ -95,6 +95,11 @@ The following machine-specific options are supported:
>>     SiFive CLINT. When not specified, this option is assumed to be "off".
>>     This option is restricted to the TCG accelerator.
>>   
>> +- acpi=[on|off|auto]
>> +
>> +  When this option is "on", ACPI tables are generated and exposed as firmware
>> +  tables etc/acpi/rsdp and etc/acpi/tables.
>> +
> Hi Heinrich,
> 
> Should we add, When not specified or set to auto, this option is assumed
> to be "on"?

Sure.

Best regards

Heinrich

