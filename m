Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8941B7F9D38
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 11:13:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7YcG-0003Cu-Gp; Mon, 27 Nov 2023 05:13:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1r7YcD-0003CS-Ee
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 05:13:21 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1r7YcA-0007Ha-Do
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 05:13:20 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-54b0c7987easo2997681a12.3
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 02:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701079997; x=1701684797; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=tyNL8YcIXDoqDeFQ+9aD9eH/uirY1NxD9VXtnLU/H9o=;
 b=AOt6A+zwjZjbDmnt4L291WKK5tODx2/mobEHMLYzQ/fM0WJtNis4Qinr8bOfZ8AjkU
 Lorn3I+N5qGyIFLQz1iwWm4bz8WfxP6EkCDQ/8xRduIkRg2IsCaeqi9zebZHYuUGsUMe
 oxsg5k131WuBWA1VFVEhFxq8zO/EBg9RFIWm/rjv6Rnugxj5dTNK5YOqZRueJBSTKfEm
 P8x5tYRhGB2z/VzmyBa8CZEN+jD5FSYpT6d+Sm22UvowYThh5rzpbeRE1WxmEK9qVViV
 1kdhP74wQbeVyQRrJyH2InvBneeE9KWhz99RoVBn0WEKcppvBghmCaGOHy/9S/cw6J92
 j06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701079997; x=1701684797;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tyNL8YcIXDoqDeFQ+9aD9eH/uirY1NxD9VXtnLU/H9o=;
 b=XbfR6AYwvPRrd97Okd+9g6RWcL0anaXq0xtdo9qY0L066nmg0TUgLosoyfyqLJdt4/
 0nsrMp0KMslWU+UckJeRSDl/FvPEshLtlGfcmkoKP3267Fj7YAKbyDoOaDGoo3pZF6Jm
 S7K1UgBXvYQMD4G7LaiwXZSukpH+Bzp4NOIr7cimH6WwZBKyX0Qlqm9/4M+pIkV9MxVx
 rKMmv1zyd3zHn8wjORkT2+Z5QfsArlsC+Z+gNHFnlQhywD4cVdnkQKBzBMNB37RyVtoU
 hK4dvnvlwH1yaO1endAFZ4ndnNhOYQXeURyXhn/3Ppb028v5sbYQ9lt+fbm/MzPn2vNO
 PUdw==
X-Gm-Message-State: AOJu0YynRSvYL49FwmNWb/ixrCfF+iioL2BfxA9NW7gKAqYKVN5xdEKd
 IehaBTPpNsL+H+Ci9Jmjz5Bonw==
X-Google-Smtp-Source: AGHT+IGm0zMrXrz74CTQZBx65Nzl8ExA9oJtkCrujRIbuyVRlRHrzytu6yB24sY9T12hhibN1+iiZw==
X-Received: by 2002:a05:6402:3514:b0:54b:687f:446c with SMTP id
 b20-20020a056402351400b0054b687f446cmr2105657edd.31.1701079996838; 
 Mon, 27 Nov 2023 02:13:16 -0800 (PST)
Received: from [192.168.200.206] (83.11.23.160.ipv4.supernova.orange.pl.
 [83.11.23.160]) by smtp.gmail.com with ESMTPSA id
 e7-20020a056402104700b00542db304680sm5056297edu.63.2023.11.27.02.13.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Nov 2023 02:13:16 -0800 (PST)
Message-ID: <c7d6f212-b051-4533-8b89-6241d28658fc@linaro.org>
Date: Mon, 27 Nov 2023 11:13:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/8] hw/arm/virt: Check CPU type in
 machine_run_board_init()
Content-Language: pl-PL, en-GB, en-HK
To: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, richard.henderson@linaro.org,
 quic_llindhol@quicinc.com, b.galvani@gmail.com,
 strahinja.p.jankovic@gmail.com, kfting@nuvoton.com, wuhaotsh@google.com,
 nieklinnenbank@gmail.com, rad@semihalf.com, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 vijai@behindbytes.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, shan.gavin@gmail.com
References: <20231126231210.112820-1-gshan@redhat.com>
 <20231126231210.112820-6-gshan@redhat.com>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <20231126231210.112820-6-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

W dniu 27.11.2023 o 00:12, Gavin Shan pisze:
> @@ -2939,6 +2900,28 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>   {
>       MachineClass *mc = MACHINE_CLASS(oc);
>       HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
> +    static const char * const valid_cpu_types[] = {
> +#ifdef CONFIG_TCG
> +        ARM_CPU_TYPE_NAME("cortex-a7"),
> +        ARM_CPU_TYPE_NAME("cortex-a15"),
> +        ARM_CPU_TYPE_NAME("cortex-a35"),
> +        ARM_CPU_TYPE_NAME("cortex-a55"),
> +        ARM_CPU_TYPE_NAME("cortex-a72"),
> +        ARM_CPU_TYPE_NAME("cortex-a76"),
> +        ARM_CPU_TYPE_NAME("cortex-a710"),
> +        ARM_CPU_TYPE_NAME("a64fx"),
> +        ARM_CPU_TYPE_NAME("neoverse-n1"),
> +        ARM_CPU_TYPE_NAME("neoverse-v1"),
> +        ARM_CPU_TYPE_NAME("neoverse-n2"),
> +#endif
> +        ARM_CPU_TYPE_NAME("cortex-a53"),
> +        ARM_CPU_TYPE_NAME("cortex-a57"),
> +#if defined(CONFIG_KVM) || defined(CONFIG_HVF)
> +        ARM_CPU_TYPE_NAME("host"),
> +#endif
> +        ARM_CPU_TYPE_NAME("max"),
> +        NULL
> +    };

I understand that you just move list from one place to the other but 
also wonder why a53/a57 were/are outside of 'ifdef CONFIG_TCG' check.



