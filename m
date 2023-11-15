Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E231B7EBA98
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 01:35:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r33rJ-0001rP-Vl; Tue, 14 Nov 2023 19:34:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r33rH-0001r8-2c
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 19:34:19 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r33rB-00069N-VA
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 19:34:18 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1cc68c1fac2so56162635ad.0
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 16:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700008451; x=1700613251; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XJlQt7mvl/N4ytLvXZCof7qr//064R+E6Xodrk05Fho=;
 b=X422+l3P3w8m2TNEizDNdkqS4i2HsWbL4/D58qKOEZ6Cx4AZnXym4vZPL7DGvDejiE
 0Kxj4KQRNPGVoVZxohfooLUkj+aUsiGFNX2RS+T5d8hufGLbJ4q5hwACTekfdWPpkK5V
 tMcr2+x0H0sDd3Rgv525Oa83AHv0tIvrGRbQvyAJ1iu0zT8NnD2LvSw6m1BYDwNlxRst
 EXID+nMpgUIE9IIc9hfOmDfl+WahompmhaYtChavMq1Un42Gzoh4II8UFWLVz7NAzqVz
 x0AXtsVevc+2thXAoIUGGhn9kUfnrvhQw+/BgHpFe8D42gmoFdo9VfSD86D7hJqGrnQV
 HZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700008451; x=1700613251;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XJlQt7mvl/N4ytLvXZCof7qr//064R+E6Xodrk05Fho=;
 b=bQSpJIt3ovmfjPYDUauSap5lOm2Zu9BD/iTrx80ZIvbbGxOe5THwFVJTePMeWM0V7J
 zXifPjk3bg5xCtxIsR8zAlsySphMi60hVTry6Q6Y7Oq/3nJ7vpZHK2IZDj+ZwXFR/X72
 vqkRpkUDMxNVhAvqYkVTxR4YMN/fZHk8VY5Nlhp50gD9q9aajJ6EpiyhrrrgiIdC1aVA
 pUP82GcjBG+/89etlLpstjvthUM8spuSex23za5T6y3Wwp1KnJSibzkqUo4Tt3KzXp+F
 iZyQV7P2A8dKGK22HLu7+Y/+DtY6lM8yRge8hvH2l5+3K0FrFycS2jBbHTUq1R9ylRj+
 psTA==
X-Gm-Message-State: AOJu0YxR1L0yv+LzM23sh39bNQyyThILrgcVfiQYsLwdXeNgnquszerR
 QlyS2ejOf7gSb63PGS6SaRXu5vtR41R1a2jVGy4=
X-Google-Smtp-Source: AGHT+IEBY5kA3uMuzehqIxe+wZCNkJu3obtZEr/WnjGANecbwSy7QCToOigywcf9V1TWKoCRvti0Mg==
X-Received: by 2002:a17:903:2284:b0:1cc:43ca:b5b3 with SMTP id
 b4-20020a170903228400b001cc43cab5b3mr4862947plh.28.1700008450865; 
 Tue, 14 Nov 2023 16:34:10 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 i4-20020a17090332c400b001bbfa86ca3bsm6275251plr.78.2023.11.14.16.34.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 16:34:10 -0800 (PST)
Message-ID: <bdc86ee9-a7ec-4cf9-84d2-0c23b77905a8@linaro.org>
Date: Tue, 14 Nov 2023 16:34:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/31] target: Remove 'oc == NULL' check
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20231114235628.534334-1-gshan@redhat.com>
 <20231114235628.534334-5-gshan@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231114235628.534334-5-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 11/14/23 15:56, Gavin Shan wrote:
> No need to have 'oc == NULL' since object_class_dynamic_cast()
> covers it. Besides, we don't expect an abstrat CPU class returned
> from CPUClass::cpu_class_by_name() in the middle on alpha and rx.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   target/alpha/cpu.c | 3 ++-
>   target/rx/cpu.c    | 4 +++-
>   2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
> index 83345c5c7d..c19257d765 100644
> --- a/target/alpha/cpu.c
> +++ b/target/alpha/cpu.c
> @@ -126,7 +126,8 @@ static ObjectClass *alpha_cpu_class_by_name(const char *cpu_model)
>       int i;
>   
>       oc = object_class_by_name(cpu_model);
> -    if (oc != NULL && object_class_dynamic_cast(oc, TYPE_ALPHA_CPU) != NULL) {
> +    if (object_class_dynamic_cast(oc, TYPE_ALPHA_CPU) &&
> +        !object_class_is_abstract(oc)) {
>           return oc;
>       }

This appears to be a rebase error, re-introducing code removed in patch 3.
I think the entire patch should be dropped.


r~

>   
> diff --git a/target/rx/cpu.c b/target/rx/cpu.c
> index 9cc9d9d15e..dd5561c8eb 100644
> --- a/target/rx/cpu.c
> +++ b/target/rx/cpu.c
> @@ -111,9 +111,11 @@ static ObjectClass *rx_cpu_class_by_name(const char *cpu_model)
>       char *typename;
>   
>       oc = object_class_by_name(cpu_model);
> -    if (oc != NULL && object_class_dynamic_cast(oc, TYPE_RX_CPU) != NULL) {
> +    if (object_class_dynamic_cast(oc, TYPE_RX_CPU) &&
> +        !object_class_is_abstract(oc)) {
>           return oc;
>       }
> +
>       typename = g_strdup_printf(RX_CPU_TYPE_NAME("%s"), cpu_model);
>       oc = object_class_by_name(typename);
>       g_free(typename);


