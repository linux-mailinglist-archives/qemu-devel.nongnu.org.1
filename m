Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 026C1799C06
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Sep 2023 01:28:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf7LP-0008Ms-PY; Sat, 09 Sep 2023 19:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf7LO-0008Mk-Mx
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 19:26:26 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf7LM-0007Xv-3j
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 19:26:26 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-68a56401b9aso2728956b3a.1
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 16:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694301982; x=1694906782; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gr4H/8Lc1i2LZXDSRdDMW8r6yELJ31ZzWG+W2fgGk+0=;
 b=SzTC/YvjQvRYvWsClQ6vzB7pxoVGKZ8dAD3l5LFIC7MUaHaiUHjV66uO8svc3q+wZ+
 QqP5X/lyzlk5Wyh4iikOfTuWefh6/ff/3Gsl2UbnY9kxa4CFAWHrCJkmLrhsLswYfHMs
 O2/n7AI7tcDKqUftGIgQGOzV4MVY5hbs0HAFA4s7UBV/P+C17ymmF/Ha8G480bz9TjlT
 dJGJDI8blomPNR4HHaRfGFDu3GM7S419H83cj49ZwUarvWr3CPDgAsSF8toi0fGkSA70
 clXOYx65YuYvo1KDSUHBxBKREFMcyHuWpmxrOUsQ3Nc0I7+LMpLUeqZ42eknjD2A3yuw
 935w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694301982; x=1694906782;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gr4H/8Lc1i2LZXDSRdDMW8r6yELJ31ZzWG+W2fgGk+0=;
 b=Y2WOqCz1ONuQn8wvbq6cOWEkSbpeaahIA08CIdUqEQ/AGW+sxztemuxJ5SG6KAYwok
 wH2xu83ofHGiTcchRA9Na+hzCBdhaCMkY6FTvx1o0mZjLDDrOgoN5oZOKFhg56jSi4Bm
 JrgKrDhTyeKZGqw4fHpy1AM3o6IuEEgwOarMKJ98NqeOzPjn/VtbwCM9jXq7MZ9il9ar
 4PcaZ1JQuyey2S+sBjwCYKf3MOrMVhIgaZQkKDFu7RhSy2CEH7BVaudpLnOOisFw5cTM
 lwksilk1IYWavcZ6h8uXbAWBpm2ufESDVyICTn7Qx8IAEjsr7raMSikmXVeF6ckpicrh
 g4tA==
X-Gm-Message-State: AOJu0Ywz0a1Ov3NyrGdINQbyKxi+KLRTsiTzJ+aLUTgI3w1kjbpZRbr1
 a+ZMXLq2OYrlJVA+PoP+sk6qUA==
X-Google-Smtp-Source: AGHT+IH+ek8oCX3jgFY4GmWBUpkd++sSsh1hjdm9tu33ia0ql1Xmor0Hu7wAFw/E+dUXaybelonR5A==
X-Received: by 2002:a17:903:18a:b0:1bf:728:7458 with SMTP id
 z10-20020a170903018a00b001bf07287458mr6888061plg.58.1694301981437; 
 Sat, 09 Sep 2023 16:26:21 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 jj18-20020a170903049200b001b9d95945afsm3747888plb.155.2023.09.09.16.26.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Sep 2023 16:26:20 -0700 (PDT)
Message-ID: <f31f8276-a66a-919e-4f96-9c5fbabe6bc0@linaro.org>
Date: Sat, 9 Sep 2023 16:26:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 4/4] hw/cpu: Call object_class_dynamic_cast() once in
 cpu_class_by_name()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230908112235.75914-1-philmd@linaro.org>
 <20230908112235.75914-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230908112235.75914-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/8/23 04:22, Philippe Mathieu-Daudé wrote:
> +++ b/hw/core/cpu-common.c
> @@ -157,7 +157,8 @@ ObjectClass *cpu_class_by_name(const char *typename, const char *cpu_model)
>       cc = CPU_CLASS(oc);
>       assert(cc->cpu_resolving_type && cc->class_by_name);
>       oc = cc->class_by_name(cpu_model);
> -    if (oc == NULL || object_class_is_abstract(oc)) {
> +    if (oc == NULL || object_class_is_abstract(oc)
> +                   || !object_class_dynamic_cast(oc, cc->cpu_resolving_type)) {
>           return NULL;
>       }

cc->cpu_resolving_type, as constructed in patch 3, is always @typename.
In the only (!) caller in toplevel/cpu.c, this is CPU_RESOLVING_TYPE.

Indentation:

     if (oc == NULL
         || object_class_is_abstract(oc)
         || !object_class_dynamic_cast(oc, typename)


r~

