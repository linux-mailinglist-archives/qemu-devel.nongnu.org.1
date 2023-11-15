Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3451A7ED35A
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 21:49:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Mop-00024S-Lp; Wed, 15 Nov 2023 15:49:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3Mon-00022M-8b
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 15:49:01 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3Mol-0003h7-0c
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 15:49:00 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40a48775c58so363285e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 12:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700081337; x=1700686137; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7uoFzP027E314xblzySCEGxa40cu6sZwXa3vlWS3OdA=;
 b=sx5YUSCq01Tn6meAw5fD77+g3UD+CI8Funo3M7phCBytHvAO1ns8BcEzu7rNlg6nWV
 WFOR7pXFQqn1bwKCv7Zj4El3CTX31J7kMbc67GBr21Xd/1+Me3YANrtLDfIPkNczxDs5
 y484arHsw5v+A8mi9j1FkUi+iY5Na5kKw1RsZdukUgPjQpwhNX7Z3OAh4bI1J5h/UhjV
 6sTdt9WzN8/osleN0xlXtXgdwNeCQAB5wxTsuFAVjjmwOX1l5T0H/bhP7QhBZ2Wmo2V+
 AlG/2/41qboGrprRNtxGCF7UiuYZN/6CqS7f981gOXQaQEV9zX/KiCxL/pwRnLMKNtmY
 XErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700081337; x=1700686137;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7uoFzP027E314xblzySCEGxa40cu6sZwXa3vlWS3OdA=;
 b=tkbtzFrz+aK9N+zioeJirRnF1N+xDOFz7GCQPGTJqkTWXm7Tu46iXPdskJg6clPAl4
 zcFq/9RNeNlxUn8BP0B+iSC3COsJ5n35ehux1/ZxBbjBepGY8K0W+VZ4syS2FG6uHBAy
 CrqR7MNiG2trflk+eubYPgh4fcCMYz3v1tGgYuNXlShU35NT5zMv9PWkaqiycW352+5w
 GT4k4jDRV+t0IlU0qmdWInTj6usSxwcj0hscgOei+xrOcHh+vI11zpJpY6s4En4DH1gF
 sRWdWYjWNvEXL+b9OgmTTbwdOMjLUwmohbZn1YKflVBqrlWPFRHaVCRJW0GKpV3FakFb
 TmBg==
X-Gm-Message-State: AOJu0YwpTZ8WYX0ipMFIYGSwecWrX3yxfqxJkQpG/hVnZELg+R/VWXzm
 /Ox04bOxqHObkOdH7MAoH6vtuw==
X-Google-Smtp-Source: AGHT+IGcsXqXkSODosLaCvA/0B3CFHYUVQDQINbipTtHgS5USugLfpDM/UX9o+KopqAsc/FduroUFg==
X-Received: by 2002:a05:600c:3acc:b0:3fe:1232:93fa with SMTP id
 d12-20020a05600c3acc00b003fe123293famr357541wms.22.1700081337382; 
 Wed, 15 Nov 2023 12:48:57 -0800 (PST)
Received: from [192.168.69.100] ([176.176.130.62])
 by smtp.gmail.com with ESMTPSA id
 s9-20020a05600c45c900b0040651505684sm853944wmo.29.2023.11.15.12.48.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 12:48:57 -0800 (PST)
Message-ID: <53d3883b-39a4-4ca6-87df-f7d726c806c7@linaro.org>
Date: Wed, 15 Nov 2023 21:48:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] ich9: Remove unused hotplug field from ICH9LPCPMRegs
 struct
Content-Language: en-US
To: Thierry Escande <thierry.escande@vates.tech>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>
References: <20231115171837.18866-1-thierry.escande@vates.tech>
 <20231115171837.18866-2-thierry.escande@vates.tech>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231115171837.18866-2-thierry.escande@vates.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 15/11/23 18:18, Thierry Escande wrote:
> This patch removes the unused field use_acpi_hotplug_bridge from the
> ICH9LPCPMRegs structure as it is now part of AcpiPciHpState.
> 
> Hotplug fields have been removed from piix4 state structure by commit
> 6536e427ce49 (pcihp: move fields enabling hotplug into AcpiPciHpState)
> so do the same for ich9.
> 
> Signed-off-by: Thierry Escande <thierry.escande@vates.tech>
> ---
>   include/hw/acpi/ich9.h | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


