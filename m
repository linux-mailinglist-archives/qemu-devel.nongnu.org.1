Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 409927C6423
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:37:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqnRH-0007kz-8p; Thu, 12 Oct 2023 00:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqnRE-0007kH-I0
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:36:44 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqnRA-0008Fn-2X
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:36:42 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-99c3d3c3db9so81988666b.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697085398; x=1697690198; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rsqWk+2/+fzNt1nwuH5nLLJ02vPdHgexuKsMnzAkv3w=;
 b=HEXqGli7PkdLWRguv/Ybzgyntlytd4AjslYx/OGoVGTd9P/1pFZHG5xTJ0gJsYzNdH
 oeKlAedSb0ex2idiBuwUyhu1YjgpDqtPDL/NgobFvdPzpzdk62soPQZJ8IfpiKQmpEfY
 pT/uW9MDAEGMh3UoKdhr4ID7kwneFDyfd4qKfsyv32lmMuAbRCGz/1Xb5488Yo/Teo8D
 r5jwMFhPFIH2JPgmm8nJ1AK+JY+8oD1aoGHuejh2moMvVizI+rgjoZPV5hHdstBPWQUz
 nUEPbxNUb/kUYcRJbgzFO4zUT0FiFNO8iDQhjx3YAIhBSi7ejIHasqlaqPNkI1hiaYWc
 2e2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697085398; x=1697690198;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rsqWk+2/+fzNt1nwuH5nLLJ02vPdHgexuKsMnzAkv3w=;
 b=Lr/JD4aUDA+SIbshu42sOFwDv2tQB57D4DBIDZrqn+LlAoPGfhwAigSoZI+uvrC9AW
 rGVTwKJq73wNl5zBMWNq7i/DQ+rdeTX7eYNvDtRuvXrilvvkWxh+/eLVBj3qu+POMHv5
 XChHhA9arerVSxtAR2izBs8vtOcbG31n7dVLWZ8pnwNuBxdUNKIb+ElVlBqSif0Rydgb
 auvdfewoGqS67YJ58qQFyc/cQy4x4NSz4OPzYBqzbRFInRYHbnCLUlMlKB/Ag5N6wUTt
 v4m6MVjCqSdBoyG8Ug/EjrV9ZbRpT9mcH0358NRIkzhZRTqcWwZ/iJqjw7xfxqxjYowH
 GDWw==
X-Gm-Message-State: AOJu0YxFuOPxFwhaC2S4bXzABaDrrvT+gjjuwwhxSSjzGNpEQdZLxDiG
 k9NFnFhDLCe8LsNlUWkvgqzu8g==
X-Google-Smtp-Source: AGHT+IGn5Y1WzWdsdU7MfdCfa5PmA9zEevz9KS71cMQv84u2N+RvvzYye12V78QdPYi70J2QkbPG0g==
X-Received: by 2002:a17:906:844c:b0:9a5:cab0:b050 with SMTP id
 e12-20020a170906844c00b009a5cab0b050mr19136706ejy.13.1697085397985; 
 Wed, 11 Oct 2023 21:36:37 -0700 (PDT)
Received: from [192.168.69.115] (dcs23-h01-176-173-173-31.dsl.sta.abo.bbox.fr.
 [176.173.173.31]) by smtp.gmail.com with ESMTPSA id
 y17-20020a1709064b1100b0099cc3c7ace2sm10727685eju.140.2023.10.11.21.36.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 21:36:37 -0700 (PDT)
Message-ID: <f1998265-a32b-e900-6b0c-3b9508789be7@linaro.org>
Date: Thu, 12 Oct 2023 06:36:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC/PATCH v0 09/12] gunyah: Customize device-tree
Content-Language: en-US
To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>, peter.maydell@linaro.org, 
 alex.bennee@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: quic_tsoni@quicinc.com, quic_pheragu@quicinc.com,
 quic_eberman@quicinc.com, quic_yvasi@quicinc.com, quic_cvanscha@quicinc.com,
 quic_mnalajal@quicinc.com
References: <20231011165234.1323725-1-quic_svaddagi@quicinc.com>
 <20231011165234.1323725-10-quic_svaddagi@quicinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231011165234.1323725-10-quic_svaddagi@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/10/23 18:52, Srivatsa Vaddagiri wrote:
> Customize device-tree with Gunyah specific properties. Some of these
> properties include specification of doorbells that need to be created
> and associated with various interrupts.
> 
> Signed-off-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
> ---
>   hw/arm/virt.c           | 11 ++++++
>   include/sysemu/gunyah.h |  7 ++++
>   target/arm/gunyah.c     | 79 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 97 insertions(+)


> diff --git a/include/sysemu/gunyah.h b/include/sysemu/gunyah.h
> index 101e190619..f077837437 100644
> --- a/include/sysemu/gunyah.h
> +++ b/include/sysemu/gunyah.h
> @@ -35,6 +35,8 @@ DECLARE_INSTANCE_CHECKER(GUNYAHState, GUNYAH_STATE,
>                            TYPE_GUNYAH_ACCEL)
>   
>   int gunyah_arm_set_dtb(__u64 dtb_start, __u64 dtb_size);
> +void gunyah_arm_fdt_customize(void *fdt, uint64_t mem_base,
> +                uint32_t gic_phandle);
>   
>   #else   /* CONFIG_GUNYAH_IS_POSSIBLE */
>   
> @@ -45,6 +47,11 @@ static inline int gunyah_arm_set_dtb(__u64 dtb_start, __u64 dtb_size)
>       return -1;
>   }
>   
> +static inline void gunyah_arm_fdt_customize(void *fdt, uint64_t mem_base,
> +                uint32_t gic_phandle)
> +{

Similar comment than previous patch: stub can be avoided.

> +}
> +
>   #endif  /* CONFIG_GUNYAH_IS_POSSIBLE */
>   
>   #endif  /* QEMU_GUNYAH_H */


