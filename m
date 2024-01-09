Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A84D828C88
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 19:24:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNGlM-000164-RY; Tue, 09 Jan 2024 13:23:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNGl1-00015A-RX
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 13:23:25 -0500
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNGky-0001xn-Mo
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 13:23:23 -0500
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-50e7b273352so3312259e87.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 10:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704824598; x=1705429398; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IwiYMRRiVitqny+M2/uSTF/IogCQlOZjF3fjjiHBnfg=;
 b=xulN80hk5KVwLjcK6SfFueagcGJLf2eXiPGczmwSHkpPVBfyzbSZcDhKdBA8QwsLRc
 o75261Iwa0DLpJS9aKSFfno6gQ3pJ4x3WFvJgOo4oVx37URe/uHY+1JXxyockh8VZYSV
 NQrgrjoyUGh/t3j+cniBb/CybHwuh2QKwHZ03hJ9h6ks6ZWGj18GjQOIDX3/5C0cfsMy
 MGtY33UzVKnCzA1IIDAGxjuMgTf2e0iOpArJ8JT1GwUkW/ox5AX463sx07+vtAfgnAkc
 j87PetoILferjNOlL6XMx+dLp9e/emJMX+3CmP5k8DKKpRlnkRQg46WqK00OSpd2Q4gv
 chnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704824598; x=1705429398;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IwiYMRRiVitqny+M2/uSTF/IogCQlOZjF3fjjiHBnfg=;
 b=m1aNd6w1bLiicUuPdrHu2bmmHEtkiRwe/zRnNCy/Nblmf7f6wFyyDTIXgjzNdk0LZm
 FRtsPAIsU/+Z1nioXcZpeQHntjgxwChwUIf4/BOoVzqzYIW5IpBRsBmK+q8EpQOeZZaR
 QDmGKyBnCpUTHjUF8P8C3DqqLpryR7s1f4t992OK++bvZ+4/TRH5wej3BY5XsHy/7JjR
 QEnqUrhIAcCTaIqB5YdtEKqNKkxRpdaFtyJhpdxhXO9JED7mlrh77/yK0Tpp3T9s5GP/
 2XjWA2H2I5sh63bDFHMeD3VO0fR0E9VKE9eScx3JipZTZLztmbntyeMe2eB+c96QhR5T
 fFAw==
X-Gm-Message-State: AOJu0Yy/st3zDvVe1nYv7AG0aY1g7fXSt3D+54E2wsxpZnq1aCSM+Pov
 ExlkPnAQdS82dyYoQ/kzJsWRHrVEaCX+WjIO0+JF/tKcxceeLQ==
X-Google-Smtp-Source: AGHT+IHEIR2743EpVRU2bJ5DdlpRvMkc9k+Jut6R9ZUI+r+wwOxB1WnLxr27Syz3Z0kGOSvPNoShdw==
X-Received: by 2002:a05:6512:3b24:b0:50e:55bb:a453 with SMTP id
 f36-20020a0565123b2400b0050e55bba453mr2831787lfv.3.1704824598519; 
 Tue, 09 Jan 2024 10:23:18 -0800 (PST)
Received: from [192.168.69.100] (rsa59-h02-176-184-32-47.dsl.sta.abo.bbox.fr.
 [176.184.32.47]) by smtp.gmail.com with ESMTPSA id
 o15-20020a198c0f000000b0050e7dcc05a5sm425817lfd.102.2024.01.09.10.23.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 10:23:18 -0800 (PST)
Message-ID: <c71a6872-6e67-4384-9d28-b1c2da0bd521@linaro.org>
Date: Tue, 9 Jan 2024 19:23:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/14] hw/arm: Prefer arm_feature(EL2) over
 object_property_find(has_el2)
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Rob Herring <robh@kernel.org>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
References: <20240109180930.90793-1-philmd@linaro.org>
 <20240109180930.90793-11-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240109180930.90793-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
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

On 9/1/24 19:09, Philippe Mathieu-Daudé wrote:
> The "has_el2" property is added to ARMCPU when the
> ARM_FEATURE_EL2 feature is available. Rather than
> checking whether the QOM property is present, directly
> check the feature.
> 
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/vexpress.c  | 3 ++-
>   hw/arm/virt.c      | 2 +-
>   hw/cpu/a15mpcore.c | 6 ++++--
>   3 files changed, 7 insertions(+), 4 deletions(-)


> diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
> index cebfe142cf..1fa079b3b8 100644
> --- a/hw/cpu/a15mpcore.c
> +++ b/hw/cpu/a15mpcore.c
> @@ -73,9 +73,11 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
>               qdev_prop_set_bit(gicdev, "has-security-extensions", true);
>           }
>           /* Similarly for virtualization support */
> -        has_el2 = object_property_find(cpuobj, "has_el2") &&
> +        has_el2 = arm_feature(cpu_env(cpu), ARM_FEATURE_EL2);
> +        if (has_el2) {
>               object_property_get_bool(cpuobj, "has_el2", &error_abort);

Missing to be squashed on top:

-- >8 --
          if (has_el2) {
-            object_property_get_bool(cpuobj, "has_el2", &error_abort);
-            qdev_prop_set_bit(gicdev, "has-virtualization-extensions", 
true);
+            qdev_prop_set_bit(gicdev, "has-virtualization-extensions",
+                              object_property_get_bool(cpuobj, "has_el2",
+                                                       &error_abort));
          }
---

> -        qdev_prop_set_bit(gicdev, "has-virtualization-extensions", has_el2);
> +            qdev_prop_set_bit(gicdev, "has-virtualization-extensions", true);
> +        }
>       }
>   
>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), errp)) {


