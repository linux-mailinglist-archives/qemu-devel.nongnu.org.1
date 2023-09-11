Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF1579AB68
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 22:55:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfnvo-0000wc-G5; Mon, 11 Sep 2023 16:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfnvl-0000oQ-EP
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 16:54:49 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfnve-0001aU-1i
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 16:54:49 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2bcb89b476bso83320811fa.1
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 13:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694465677; x=1695070477; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cu2e3oAVT8yhBsM1m08CVCBwYMVMVJHdz+e7ZXopLWc=;
 b=gZ1rm8qkpCy+xA2XzHmsV8yUiMUyLysvEyKZu8OAkAegZZ/w4vEZbs9LiDQaWUO8Yq
 RMGp/d6aE+1hjRIO2Kl+reBAylTOgDYfMj/lUJcsulXq5B2NWO9orsGPmm/b0Kglw7gi
 6cXGuCpkTb0+iagcofguQKC1PjK7qFwUOW3KxL53zhgcEi0gQXVYUILGQMDDmOpUlkbL
 pmxwaTPDkMxuyscA954LSmoIjAWe5NuFpleUk21ROVyOKR06B/ClhjutDgQAwZ5OQRJN
 aVJJqfdyumLkB2MQecxzH70JB6UKrNkVPPVhutrG/E41Vq7Zwn2WG8TMoB8nXT8A9DKE
 tj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694465677; x=1695070477;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cu2e3oAVT8yhBsM1m08CVCBwYMVMVJHdz+e7ZXopLWc=;
 b=mUPSyoQEuXlkpbH2fPMIM9o2vrxK9rL3p5zBan4gV2CWKDcmmP52LyYU7/4p27/fdH
 plWUb4W4lVjUfpeWhNpjo+efam6dF2sUwgrsZ5Q7JT808FUZ1fNymH/6D2kwTQNP25gk
 WxMkvE0X15AjImXNGkFAdvZdBZtk+ROu5fJfCaCPiYJ8dPEY9/TTKQ7LS73A2omiySpQ
 zJ/auTB3ZY/hUaMaFIRx1EeXNPthKglfETOdc7pEbRd7c8pXsyTAILjhS6H67mw7yb6F
 SXf0cXGXTk3op0SKVLTRnEIiT71GYWaOGKosARLx2nrp+AfFkDW7wO5dSYwChnl8OPLx
 I7Dw==
X-Gm-Message-State: AOJu0YwDYOKkuU9OR8tSzrq7BGP1blB43x4m0kBBZiGt6PCayYu+7o6X
 X3yDbqZ0xO5aBU5maaHJX4XNKg==
X-Google-Smtp-Source: AGHT+IG2+l8OmLm1WVkQFK18YLUh/99hOmBMhNLoJXASxDBAhjh31N+KCAo01iPfT28GhIpFFnTrwg==
X-Received: by 2002:a2e:9e87:0:b0:2bc:ffe5:54a1 with SMTP id
 f7-20020a2e9e87000000b002bcffe554a1mr7994156ljk.32.1694465677181; 
 Mon, 11 Sep 2023 13:54:37 -0700 (PDT)
Received: from [192.168.69.115] (tfy62-h01-176-171-221-76.dsl.sta.abo.bbox.fr.
 [176.171.221.76]) by smtp.gmail.com with ESMTPSA id
 l15-20020a1709066b8f00b0099bca8b9a31sm5767297ejr.100.2023.09.11.13.54.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Sep 2023 13:54:36 -0700 (PDT)
Message-ID: <53c2cf8d-28ba-c866-876b-126714045ea6@linaro.org>
Date: Mon, 11 Sep 2023 22:54:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 01/11] qdev: Add qdev_prop_set_array()
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, berrange@redhat.com, peter.maydell@linaro.org,
 pbonzini@redhat.com
References: <20230908143703.172758-1-kwolf@redhat.com>
 <20230908143703.172758-2-kwolf@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230908143703.172758-2-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 8/9/23 16:36, Kevin Wolf wrote:
> Instead of exposing the ugly hack of how we represent arrays in qdev (a
> static "foo-len" property and after it is set, dynamically created
> "foo[i]" properties) to boards, add an interface that allows setting the
> whole array at once.
> 
> Once all internal users of devices with array properties have been
> converted to use this function, we can change the implementation to move
> away from this hack.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   include/hw/qdev-properties.h |  3 +++
>   hw/core/qdev-properties.c    | 21 +++++++++++++++++++++
>   2 files changed, 24 insertions(+)


> +void qdev_prop_set_array(DeviceState *dev, const char *name, QList *values)
> +{
> +    const QListEntry *entry;
> +    g_autofree char *prop_len = g_strdup_printf("len-%s", name);
> +    uint32_t i = 0;

"unsigned"? Anyway,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +
> +    object_property_set_int(OBJECT(dev), prop_len, qlist_size(values),
> +                            &error_abort);
> +
> +    QLIST_FOREACH_ENTRY(values, entry) {
> +        g_autofree char *prop_idx = g_strdup_printf("%s[%u]", name, i);
> +        object_property_set_qobject(OBJECT(dev), prop_idx, entry->value,
> +                                    &error_abort);
> +        i++;
> +    }
> +
> +    qobject_unref(values);
> +}


