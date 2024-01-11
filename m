Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E346882A7E0
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 07:49:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNosL-0007MH-Qn; Thu, 11 Jan 2024 01:49:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNosH-0007Le-0N
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 01:49:10 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNosE-0002al-Vf
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 01:49:08 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-33674f60184so4780930f8f.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 22:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704955743; x=1705560543; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uj4IshRUpye2musL4IAPVwgkOgzzw9ZtcQXIi3JvXy0=;
 b=M9nh24XEPeLqOz8k2ZnlcYNvcqEmoJ+A/9xma6Hrn/qKuxa4J/A9/KEupLKpjDHF89
 KYUjrPCkF6NmT3tAuWBbZuh9sZ4mHL0/0zVDs1mh+BlJQpk8nKrpkyXwBvsz3h/7ZgK4
 sDyLlnPiAXjeMp/gUtd7eGsqS05NMPDf253Aqm/Y3Jbch7JCWK9SBcWGCijP/+YxfC1o
 T6EBdZWVw/eeSXbfNObw++VcbQWXZZ//cUJuUhxJJZnfIpQgMhiPCz4meQdfhS1X8GX7
 bIYDxNUh7cZjjlbdb8nvFPNAc8SN5NyQ6LXOezTHx6NByPzzbYxNxk3q8Q3JuOPWWGg4
 GQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704955743; x=1705560543;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uj4IshRUpye2musL4IAPVwgkOgzzw9ZtcQXIi3JvXy0=;
 b=nTc0PjjX6+1i9KxFpGb5HBCrnOFz2FMVXsfw8i52eUvCGtnBD6SEVj4qej6RGpmTKQ
 aAPwtOIDykMHVBLAU2GCRIr5U/dhjnYNtVYl1rOlsRZB66XgpEPLOxI2iTDOf3alDBBp
 8EaR6fb6yDiEnfuozOrNr66p5nZB6aMkVItczdRg8Nx8VIoHwoCcWjOlNLiFWvAtBUc0
 OQQVDUJzDe66hRV+9/9c7CX67xGfeMv4G2y4z6ovdcO1KPsY4p3E/7DkmmiT8Sl0wZD0
 Dsrju/RoNBhzxwLlSYbiokUccf5XPy9JFyAcw4rZmpBhae13N3AYyxC3bBJZatq4wcJw
 8ueQ==
X-Gm-Message-State: AOJu0YxCbDqfofBqtVMqzFXtJK0/GeCiLRKOa7Ivgu+5iw9iQkWLcFPH
 Wa4WvlLTOAdfpmJas0HUiFXZYHBi0IcyP0t9RZhWkVCdn6k=
X-Google-Smtp-Source: AGHT+IGXTRKubmI4kSA+XoMn9tQu3G+62w1bw7J1yOQLQPm6d8ccK6EjlvdVk9cQqxcSSLNpoWZb9A==
X-Received: by 2002:a5d:540c:0:b0:336:6ad2:b64e with SMTP id
 g12-20020a5d540c000000b003366ad2b64emr319712wrv.48.1704955743355; 
 Wed, 10 Jan 2024 22:49:03 -0800 (PST)
Received: from [192.168.69.100] (vau06-h02-176-184-43-236.dsl.sta.abo.bbox.fr.
 [176.184.43.236]) by smtp.gmail.com with ESMTPSA id
 c15-20020adfef4f000000b00336d24b4847sm356760wrp.114.2024.01.10.22.49.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jan 2024 22:49:03 -0800 (PST)
Message-ID: <05d42a43-081d-40b2-a772-2d3b89641601@linaro.org>
Date: Thu, 11 Jan 2024 07:49:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/core: Handle cpu_model_from_type() returning NULL value
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 Gavin Shan <gshan@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20240111064723.6920-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240111064723.6920-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 11/1/24 07:47, Philippe Mathieu-Daudé wrote:
> Per cpu_model_from_type() docstring (added in commit 445946f4dd):
> 
>    * Returns: CPU model name or NULL if the CPU class doesn't exist
> 
> We must check the return value in order to avoid surprises, i.e.:
> 
>   $ qemu-system-arm -machine virt -cpu cortex-a9

Doh I missed one space before the '$' character when pasting.

>    qemu-system-arm: Invalid CPU model: cortex-a9
>    The valid models are: cortex-a7, cortex-a15, (null), (null), (null), (null), (null), (null), (null), (null), (null), (null), (null), max
> 
> Add assertions when the call can not fail (because the CPU type
> must be registered).
> 
> Fixes: 5422d2a8fa ("machine: Print CPU model name instead of CPU type")
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   cpu-target.c          | 1 +
>   hw/core/machine.c     | 5 +++++
>   target/ppc/cpu_init.c | 1 +
>   3 files changed, 7 insertions(+)


