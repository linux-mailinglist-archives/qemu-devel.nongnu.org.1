Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D3D7FB575
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 10:18:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7uDK-00078t-KU; Tue, 28 Nov 2023 04:17:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7uDD-000788-AR
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 04:16:59 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7uDA-0007Fh-JU
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 04:16:58 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a02d12a2444so753500966b.3
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 01:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701163014; x=1701767814; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1XV/TBPvwyYXxSNdtRwLlW8SZbceQ4dDfhHc5Ad6/ew=;
 b=ruD1W/6Ua+nFWTQIyyDVvAtTQGj6Yr2T0SiYKvGVMB8GW03+MX0xqOWSKYlbYu+bCj
 ruc/bF5ZOmKjOHnBcTrnzN6rocTbuhI0jQbaWN1Undjjk8zV4nVazcEYZ7tR+O9/TDXD
 05GnAYEV3S/6P2QiXSL6ZMQeuPKYeKqDuJ8Vc3D3NHlrzK6eWmN3ADjrC50um1GwYKrm
 kD9Xq6Q4R4ye6OgLieHmj3O0vRI2b0kMgxNUxJfw7y3vzCnM2avupHr7lApP3HIKLrJf
 iQkxN5m1W3dOTsYV5qapnUyGIPZNSdAo0M+gCiOjsjCBNVCkz3W/QpqQRnVHpZZHfXdm
 bQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701163014; x=1701767814;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1XV/TBPvwyYXxSNdtRwLlW8SZbceQ4dDfhHc5Ad6/ew=;
 b=if/+MKO/r3uHODexAyLgR7JajquVDd1Z8QjYXRJ0+uI1MXnbApDuo7NQRNql0APYOl
 4LWP78v5teOVzy8IVD0VSxEeqbYW821wXA3Mv2RdAXGJFvDBUrIejmzSImhfZhn/hnbf
 FOHPZpSBkt/D80I4nPiq0fklm7zLj3ZFrdOznddsZp7nH35z8XRi1UN3KGrFYHKtGyDh
 cgO3mK6uJ6/sUO8nHZCADmkvE2XHVsCAVjw+cWtNv56MqnIXi9O2Ghr5nyWBR7k5Hbma
 gKrxMMEdto5408dEZ6hSjj8gaNS/NAHZ0QCRVSlR6DA7XEC9aqMQsELVvdjiy3731Czb
 S7qw==
X-Gm-Message-State: AOJu0Yzbj8gkMs07VO8yZMrUE+N0gjrliM9v2vrF2fsPxAcGTEgLU3yn
 yvFYbWblZC71PExuxSI7MSHcOA==
X-Google-Smtp-Source: AGHT+IGovF0vaAVGmZMcA4JjRJhP3kcL4WzM25Ar+7sdhEG4PcKWRhs3Xat7nFKuBh1FrjCJ6lNjwA==
X-Received: by 2002:a17:906:29cd:b0:a04:d7e3:61f4 with SMTP id
 y13-20020a17090629cd00b00a04d7e361f4mr10037932eje.68.1701163014023; 
 Tue, 28 Nov 2023 01:16:54 -0800 (PST)
Received: from [192.168.69.100] (crb44-h02-176-184-13-61.dsl.sta.abo.bbox.fr.
 [176.184.13.61]) by smtp.gmail.com with ESMTPSA id
 fy12-20020a170906b7cc00b00a11b2677acbsm1093165ejb.163.2023.11.28.01.16.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 01:16:53 -0800 (PST)
Message-ID: <c6dbd03f-a060-46b1-bf25-c9a6387f6347@linaro.org>
Date: Tue, 28 Nov 2023 10:16:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-8.2] ppc/amigaone: Allow running AmigaOS without
 firmware image
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20231125163425.3B3BC756078@zero.eik.bme.hu>
 <CX9EPBH7MMHK.14A30GV035VAZ@wheely>
 <0eb18a77-af0e-a84b-764c-b435ea912a3d@eik.bme.hu>
 <CX9LVFYU6MBA.MLF4OMOCHE6K@wheely>
 <3f188a09-9927-4fc3-a4eb-0cde34934539@kaod.org>
 <CXA2ENP9VBT1.2THPXM7WFD3I3@wheely>
 <595c26d6-ef8f-443e-8192-3e73ee6b7d75@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <595c26d6-ef8f-443e-8192-3e73ee6b7d75@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

On 28/11/23 08:07, Cédric Le Goater wrote:
> On 11/28/23 02:47, Nicholas Piggin wrote:
>> On Tue Nov 28, 2023 at 2:37 AM AEST, Cédric Le Goater wrote:
>>>
>>>> I'm not sure, I don't think it's necessary if your minimal patch works.
>>>>
>>>> I'll do a PR for 8.2 for SLOF and Skiboot updates, so happy to include
>>>> this as well.


>> I think this amigaone patch could still be merged since it's only
>> touching a new machine and it's fixing an issue of missing firmware.
> 
> ARM does something similar with roms. See hw/arm/boot.c file.
> 
> It will need a "Fixes" tag.

Fixes: d9656f860a ("hw/ppc: Add emulation of AmigaOne XE board")


