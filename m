Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB50B8221C8
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 20:10:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKk8g-0006rR-9d; Tue, 02 Jan 2024 14:09:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKk8e-0006qr-AY
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 14:09:20 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKk8c-0001ln-Ne
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 14:09:20 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50e72e3d435so7206172e87.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 11:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704222557; x=1704827357; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P22KJd4xSMdDsULBNfpp2XHeqw0XeEFBkNPx7c8XCxM=;
 b=gVIqQ7uIBrhf5q2Y+CPSF5RL4ptd9/BbLMat0tSSbFA+w+jjFdjfJkWtnuja9Iqr0M
 8tyLmwAlk+ZVjwYNAMM8s04aZ+/0VmggYLi3zX10NHX5ngFS6UVYtpHsKl7TKdm0+mft
 MpBfTEKWYt+RuLKBzj2etpYQD3OquscAUdVe0kJaVwQGva4gFVg4ElPxdTFgToSTSvXy
 0mJN4uiW7ZbvmjxEc2/bOEdjo9B8abrKvSCbllCDI96pWbHE1d4DEBlLJzzIhXOMdMkV
 ArKc86juj6PHyriQs8Av0Q4z0CToEr35sJbdMrRFW4RkFtLblnPphrb9cTahxTiu7++O
 o58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704222557; x=1704827357;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P22KJd4xSMdDsULBNfpp2XHeqw0XeEFBkNPx7c8XCxM=;
 b=ICrRp78uuBfk0BBYE/gaknj5sKK5xp3Kg7kbmcC4jQp4Jjbk5QC6FNUVSSIx7zpoGB
 COMhahn5eKzv2vykTdyFPJ4y0OedZhRoPyejiXQE0W6px3Ga6hrJz3hdSv9vEjUeZAUq
 wN67PLfjnGzP4/s/O1FLGP5M4nDkst8iJtS2Pe1S9tH2vVXqx7plEWLNd0lJO5OhWFcp
 PjkSYF7/y/5kFqHT4wBbcb68B9IHrTW/x25uZVi/9WzjTSdWQwbYO/qaYzCNUnqZWFkX
 VMLoBtKcBxQchJii3jU75GKwP9DVjtLy1ZXCz4ZZ37IwEtitTXN4YAh6Q1vyAEhShsPc
 i7HQ==
X-Gm-Message-State: AOJu0YyvimWbqujbapBw9BlqbVAwd+pTlsghMIYLv17x4rRpyBs+94q/
 oFmHzOHGYPndOrQlqqHIMk7Hm954sV9Geg==
X-Google-Smtp-Source: AGHT+IHUWhpk9s36ngvS0fhj6eyzPq5uCEkEnCzUu2612vJcSF/PyQH8F5hUjMzd6zZ2nrAmoS82ow==
X-Received: by 2002:a05:6512:505:b0:50e:3c22:9d8e with SMTP id
 o5-20020a056512050500b0050e3c229d8emr5195420lfb.59.1704222556641; 
 Tue, 02 Jan 2024 11:09:16 -0800 (PST)
Received: from [192.168.69.100] (sal63-h02-176-184-16-71.dsl.sta.abo.bbox.fr.
 [176.184.16.71]) by smtp.gmail.com with ESMTPSA id
 lj3-20020a170906f9c300b00a26a80ac5fasm11565207ejb.120.2024.01.02.11.09.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jan 2024 11:09:16 -0800 (PST)
Message-ID: <0ff293e2-4155-4ec3-a078-41e4b022127f@linaro.org>
Date: Tue, 2 Jan 2024 20:09:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for 8.2.1] hw/net: cadence_gem: Fix MDIO_OP_xxx values
Content-Language: en-US
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng@tinylab.org>
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 qemu-devel@nongnu.org, Luc Michel <luc.michel@amd.com>,
 qemu-trivial@nongnu.org
References: <20240102141803.117631-1-bmeng@tinylab.org>
 <985e87d6-0f8c-4127-b425-f1efc6034879@linaro.org>
 <f662a5cd-fa5b-4583-8864-6f1c1a1f6ec2@gmx.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f662a5cd-fa5b-4583-8864-6f1c1a1f6ec2@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
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

On 2/1/24 19:32, Heinrich Schuchardt wrote:
> On 1/2/24 16:08, Philippe Mathieu-Daudé wrote:
>> On 2/1/24 15:18, Bin Meng wrote:
>>> Testing upstream U-Boot with 'sifive_u' machine we see:
>>>
>>>    => dhcp
>>>    ethernet@10090000: PHY present at 0
>>>    Could not get PHY for ethernet@10090000: addr 0
>>>    phy_connect failed
>>>
>>> This has been working till QEMU 8.1 but broken since QEMU 8.2.
>>
>> s/till/until/?
> 
> These are synonyms. Till is more informal. No need to change.

Not obvious for non-native/fluent informal English speakers.

> 
>>
>>> Fixes: 1b09eeb122aa ("hw/net/cadence_gem: use FIELD to describe
>>> PHYMNTNC register fields")
>>> Reported-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>>> Signed-off-by: Bin Meng <bmeng@tinylab.org>
>>>
>>> ---
>>>
>>>   hw/net/cadence_gem.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)


