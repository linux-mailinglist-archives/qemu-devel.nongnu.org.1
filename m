Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F1F72E36D
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 14:56:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q93Z1-0004CK-9g; Tue, 13 Jun 2023 08:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q93Yy-00046e-Q0
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 08:55:56 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q93Yw-0003En-SQ
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 08:55:56 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9786c67ec32so883543366b.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 05:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686660953; x=1689252953;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GHLGXrBgmW8QHDanJof2CL+YlxqeoYzn6GuPTuKx+38=;
 b=mwKgBSdDBGD7rp+L0TLMImRgO+sWAN1Il+Azf+WpthY+O/d9tkIXW1eMXB3DT61B7T
 jOOdMXMWdO6OIzc4wkW7HezrC3xzD0ZbSURpqDAkAbbxHANVQKi2/+VSsLJm9Rfg6F0S
 Gq3AlUTiRGnStVC34wzQUABQFxZKoLY8kvisBKyTqUq3rBMk7NxfCN6NbQ/l0Ax6Bt5X
 em19h1VpEuMG8PosC/1TPAIf+JXcWJQOkBOmmczg6lxGcaEq1if0zFjh6sKFAamJkGu4
 t4ERnv1BzN6JHTrd8ocqbhpR6t4dqEG5G/bgssF2K8UB/aiiWI0snVw4PdnR4RuuER3F
 e0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686660953; x=1689252953;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GHLGXrBgmW8QHDanJof2CL+YlxqeoYzn6GuPTuKx+38=;
 b=BuFpLAAwxpCVEbRA+O5eHTZzTgdavbvt8iinlwo2JC37zdTjOWXX6xnsomDcfTIxKS
 xH8Dpv++FhDh0bYPIOqlg3mcwYAwOl/UCfKIp0ek0j88nVk5+aJvw8IZZfP/0K5RcXAw
 EI1svD6jiQhhbSsWyWcQeQcsnj7xY8jF3Ui/TyZx1WQn3uDan8Kv/WwvPUEF8uxGKH7i
 K/zRl6BhAMK0t4p/KLvygyeH77uvle8RG2088l1kqTel1ms6xpVji60Z7MeaK4fYFFLB
 PwbJ0ezVWa5CkcR/rL+L7x+GxP3aFH1Qh23nTaSptA53MlNM9mHmjnIKhswrriCY7+hn
 kuvw==
X-Gm-Message-State: AC+VfDzn0ou4rom3z2oktnLLtlfPnaBA9Igpj1b0tTVCCPGRopMFDs4G
 kJFwf/eXLXU0lbO148u3UqtEYg==
X-Google-Smtp-Source: ACHHUZ5bZDt08o+fGcjEPsGwwcm8HZnCNoOURKvJ+GKlkwLe4UMZcz71JYde70u1iQP9iivvq1Osiw==
X-Received: by 2002:a17:907:94ca:b0:979:dad9:4e9 with SMTP id
 dn10-20020a17090794ca00b00979dad904e9mr12052251ejc.50.1686660953271; 
 Tue, 13 Jun 2023 05:55:53 -0700 (PDT)
Received: from [10.200.8.212] ([213.235.133.109])
 by smtp.gmail.com with ESMTPSA id
 z6-20020a1709060ac600b009745ecf5438sm6590661ejf.193.2023.06.13.05.55.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 05:55:52 -0700 (PDT)
Message-ID: <7565da8d-a7ad-ba02-9a59-9a441da2d988@linaro.org>
Date: Tue, 13 Jun 2023 14:55:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH] hw/loongarch: Supplement cpu topology arguments
Content-Language: en-US
To: Tianrui Zhao <zhaotianrui@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com,
 alex.bennee@linaro.org, maobibo@loongson.cn, yangxiaojuan@loongson.cn,
 gaosong@loongson.cn
References: <20230613123251.2471878-1-zhaotianrui@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230613123251.2471878-1-zhaotianrui@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
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

On 13/6/23 14:32, Tianrui Zhao wrote:
> Supplement LoongArch cpu topology arguments, including support socket
> and threads per core.
> 
> Base-on:
> https://patchew.org/QEMU/20230613122613.2471743-1-zhaotianrui@loongson.cn/

^ FYI this tag ...

> Signed-off-by: Song Gao <gaosong@loongson.cn>
> Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
> ---

... goes here after the '---' separator, because it is only helpful when
testing/merging the patch. Once it is committed, this become irrelevant.
(Everything after the '---' separator is normally stripped when applying
patches).

>   hw/loongarch/acpi-build.c | 4 ++++
>   hw/loongarch/virt.c       | 9 ++++++++-
>   2 files changed, 12 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


