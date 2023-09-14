Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9A37A03E0
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 14:31:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qglTz-0004OV-Q1; Thu, 14 Sep 2023 08:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qglTq-0004Km-Ff
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 08:29:58 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qglTo-000725-5J
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 08:29:57 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-52a250aa012so997091a12.3
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 05:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694694594; x=1695299394; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zdC48JVHTK+xh36WM3cJD4OenGPDzE+qRMdD98V+rJY=;
 b=qxU9BquAG49F2G1xznRujhJ+AjcFKtRKz3crA7kc+TYiNHdXXMa4Q5f/ZAovT1UF8f
 uL08ksz1VfySlzdekRwTfhgmW0o2O+omHTdRMkbWUs8DrpkO+D3hV3XKzkESUVM310OC
 O75b9/5B08hlH/YiPRfEgtDZ+mjP+IifdWHHJBUCALrDVYtgq6zLYv9SGhBZLPhKqwWQ
 MyySwyXDAMkjOy1pCV+U64WBiNND2SJI+TiCkmRHg3JG04p9YSDbiWTDceeX9Vz1Vxvz
 DdjLlkfKcQASKm5Vt5c+Wzw0pb9w0ssn31zN/0PTbnaEkJiMIUm0vsgXhJln323MC/Cb
 0CFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694694594; x=1695299394;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zdC48JVHTK+xh36WM3cJD4OenGPDzE+qRMdD98V+rJY=;
 b=ut6yRrwkeS5farpY9sQsAO8sJCCLMVLYakuO8py3ka8g/ux4fsGk9qbfCF1ZzD/+PO
 0cpyxBd9eOjgFkilKFuo29aGxD5k/nw60qEYZxEPglT09nu6phwctRuTQskE+ztuD7dS
 JbSSu+zJAJSViiGm5FhWb5P1uRDg9QShFPy/l4ovWt5oUWHe/KRhTbPfimn33GPMyJHB
 sMz1n0H/xVGEVxvYkFfKm/Dmlie6Kd2UCXzcTtnva5b2Ux1JYy/BTYHOpqM4NT/C57ey
 s2WNrG669a/Q47EFZiVCuFZaYWrwwGgjc2HfvIzrlkKaEjdImR0YGZDOcEkhz13lVM62
 DyrQ==
X-Gm-Message-State: AOJu0YxDWSsdTxFTPa2KT13e7k5a/cY3CIpx0N1wluLb50AEKqzx68LS
 EhZNN+5HZvJO0biNtzM8AlyIjA==
X-Google-Smtp-Source: AGHT+IGpQB+Ddd5Ef+5+2rWFzGD01qnKnpl66YxevQbXVUtPDAbwcOR8cy3u992RDGilY4V+ZWsCuA==
X-Received: by 2002:a17:906:ef8b:b0:9ad:a395:64ae with SMTP id
 ze11-20020a170906ef8b00b009ada39564aemr3964286ejb.37.1694694594405; 
 Thu, 14 Sep 2023 05:29:54 -0700 (PDT)
Received: from [192.168.69.115] (176-131-223-129.abo.bbox.fr.
 [176.131.223.129]) by smtp.gmail.com with ESMTPSA id
 h27-20020a170906111b00b009a1fef32ce6sm962028eja.177.2023.09.14.05.29.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 05:29:53 -0700 (PDT)
Message-ID: <96770865-924c-5fe9-48bd-44fa52070ef1@linaro.org>
Date: Thu, 14 Sep 2023 14:29:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] gdbstub: Fix SEGFAULT in find_cpu_clusters()
Content-Language: en-US
To: Nikita Shubin <nikita.shubin@maquefel.me>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Nikita Shubin <n.shubin@yadro.com>, qemu-devel@nongnu.org
References: <20230914122558.2379-1-nikita.shubin@maquefel.me>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230914122558.2379-1-nikita.shubin@maquefel.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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

Hi Nikita,

On 14/9/23 14:25, Nikita Shubin wrote:
> From: Nikita Shubin <n.shubin@yadro.com>
> 
> target_xml is a dynamic GString, use NULL to initialize it.
> 
> Fixes: 56e534bd11 ("gdbstub: refactor get_feature_xml")
> 
> Signed-off-by: Nikita Shubin <n.shubin@yadro.com>
> ---
> Observed with:
> build-qemu/qemu-system-riscv64 -M sifive_u -bios none -nographic -s
> Segmentation fault
> ---
>   gdbstub/softmmu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/gdbstub/softmmu.c b/gdbstub/softmmu.c
> index 9f0b8b5497..42645d2220 100644
> --- a/gdbstub/softmmu.c
> +++ b/gdbstub/softmmu.c
> @@ -292,7 +292,7 @@ static int find_cpu_clusters(Object *child, void *opaque)
>           assert(cluster->cluster_id != UINT32_MAX);
>           process->pid = cluster->cluster_id + 1;
>           process->attached = false;
> -        process->target_xml[0] = '\0';
> +        process->target_xml = NULL;

Yes, good catch. Akihiko also posted the same fix 2 days ago:
https://lore.kernel.org/qemu-devel/20230912065811.27796-2-akihiko.odaki@daynix.com/

>   
>           return 0;
>       }



