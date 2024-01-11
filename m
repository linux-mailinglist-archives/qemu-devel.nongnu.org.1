Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC39382AF15
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 14:01:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNugA-0003TY-L3; Thu, 11 Jan 2024 08:01:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rNufy-0003GD-9R
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 08:00:53 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rNufv-0002ud-NK
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 08:00:50 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d50d0c98c3so36895705ad.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 05:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1704978043; x=1705582843; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rFg1dNzVPnTCsOdeKSTg9W97fq3ju3xEU4cGnUvmmQY=;
 b=pX1jYTeIIa99KP9XtBtGyCp+iqD0j12ZESCQ5cVtvv3yvVFe5Oa6QJJxRuiGSWXq46
 Ppj75JNvARsp5d9PcrpLb5C9+E5dgW322B1uw7Q1mEAA4SDzaBLR/NtHFdxlc/Xn46V7
 q92Ecii0qO02eJdis6VpWlffGdf4EmGw94pAjKIZhEwtMIcwzj5tbz0xuQOtf5AhVGZC
 XWURLDaNlyR0s7c1mCT/dmBNLjWLhAQpz5jiUejtQA/AGy67i8imDc/wk2+ltXQVSyvq
 DKSFCD0Eb+iu/+3cERERSxEHtNyS4SDErWzQtZmYaZxq5cYlIc1LdbmptlxDYS+yXNjD
 aX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704978043; x=1705582843;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rFg1dNzVPnTCsOdeKSTg9W97fq3ju3xEU4cGnUvmmQY=;
 b=aJdxxrTPoHaUCHsYwlm/eKwjdPVZpsEBB6/LsYCur2/NVIIPrkqV64WDb5uxwxeQD6
 DG3g4y9PNS5XOwislU8Gli/oyHHlLsy8iM7M6Xf/N6kgZlLrueygt6JBgROZkYzS2w3e
 NDEQcP5W2v7iqF+z9CC1KpiFptnKMglqeo50pc4egzWGOd+Bod0WT0Gf6PqAwZLrmtd7
 ZjDqTQcOvqNFcJeMPNisagQt5PpuuUQKB62Jg0DSUiT6HQ45io2SOqz4ev85ccpRAUvm
 ctA/bxNgRIzsLN7iI6Ydf6LbYHrozfrZzNinb2+JOvqE7cL0xxEqgPdy9Pi8C1B2df1P
 EPgw==
X-Gm-Message-State: AOJu0YwK09PfCmtaNK4lO9TulQzcMvkV18bbY+hhmj61mP5oMebpmz+0
 XwWOGrGYEPEZPctVWjkNGUboltEaeNny8jbQD4z3BuDv9BOlRA==
X-Google-Smtp-Source: AGHT+IHKq5uz9HJ7tGNRly4fQPUPZks7QHK7eRejUxuKSvk+CAZt0w+2McbJtV6c1U6lMxiSVend0g==
X-Received: by 2002:a17:902:c40d:b0:1d0:acd4:e711 with SMTP id
 k13-20020a170902c40d00b001d0acd4e711mr1098588plk.15.1704978043272; 
 Thu, 11 Jan 2024 05:00:43 -0800 (PST)
Received: from [192.168.68.110] ([152.234.123.64])
 by smtp.gmail.com with ESMTPSA id
 g11-20020a170902c98b00b001d4c97a2adcsm1115031plc.108.2024.01.11.05.00.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jan 2024 05:00:42 -0800 (PST)
Message-ID: <cfee5451-89a8-444a-b0a1-ac2035a66922@ventanamicro.com>
Date: Thu, 11 Jan 2024 10:00:38 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] hw/core/cpu: Rename cpu_class_init() to include
 'common'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Alistair Francis
 <alistair.francis@wdc.com>, qemu-s390x@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bin.meng@windriver.com>,
 qemu-trivial@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>, Laurent Vivier <laurent@vivier.eu>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Eric Farman
 <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>
References: <20240111120221.35072-1-philmd@linaro.org>
 <20240111120221.35072-3-philmd@linaro.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240111120221.35072-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x633.google.com
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



On 1/11/24 09:02, Philippe Mathieu-Daudé wrote:
> cpu_class_init() is common, so rename it as cpu_common_class_init()
> to ease navigating the code.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   hw/core/cpu-common.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
> index 3ccfe882e2..67db07741d 100644
> --- a/hw/core/cpu-common.c
> +++ b/hw/core/cpu-common.c
> @@ -273,7 +273,7 @@ static int64_t cpu_common_get_arch_id(CPUState *cpu)
>       return cpu->cpu_index;
>   }
>   
> -static void cpu_class_init(ObjectClass *klass, void *data)
> +static void cpu_common_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
>       ResettableClass *rc = RESETTABLE_CLASS(klass);
> @@ -304,7 +304,7 @@ static const TypeInfo cpu_type_info = {
>       .instance_finalize = cpu_common_finalize,
>       .abstract = true,
>       .class_size = sizeof(CPUClass),
> -    .class_init = cpu_class_init,
> +    .class_init = cpu_common_class_init,
>   };
>   
>   static void cpu_register_types(void)

