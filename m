Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D33C47A6320
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 14:37:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiZxW-0007ui-JD; Tue, 19 Sep 2023 08:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiZxJ-0007nw-FU
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 08:35:56 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiZx5-0000eY-VR
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 08:35:53 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2bfb12b24e5so89705611fa.0
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 05:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695126938; x=1695731738; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pb+pQ7PwPFI0QG+pBAXO1Xj93Zy9/1Tdve4LBccWQ7I=;
 b=Q+FdbSps7YhueAizPN92vkC4AlhwIYBFwLclmr3TzWdM/7ddk3YiSnpw+QDILuI+J3
 0AkfCMwwZcAHmDxfQa9PPEOrDmTUCeLhhhkLMje44nUQf2wojNqSqDsKw77mnEd+JVKS
 qdF1N/COZ5SL2JzVnyTp2XobPr3S1nqzJ22FYIxt8GY2mtE0n8DXhdnvaWLwXDp18jUO
 Gl4raSJ438YRJLWlE17VuUGTGkp9lF2QJcNmM9tnV3vqvXF0SLNOjef2LzeSGi1NanMx
 ce8wJ+eMk/qE0AFhc0/FNmf8vV/wlg5JWElsHjKLSpz9hcK0KYasFTHA4WmYwgh2gYQz
 Oshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695126938; x=1695731738;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pb+pQ7PwPFI0QG+pBAXO1Xj93Zy9/1Tdve4LBccWQ7I=;
 b=peDYD8GFaBBpHaPdvEpfTrKIGb1+bynJFNIYWlHzZ61FgUs9vDR4uJ0SVUmP5OAugG
 Lh8VTFQDuWp79zUkm9lSHkbH199F4Qb3+7Xljr3K5GMKr1+NFQmaII2iFufIa35fm38Q
 ZjaKsOw6Ko/OJhX9pOcZgeP4y/ZbtGILYuk6rt/ok8vn0S+tqZTCHMjs7L+mXuZUyECP
 u4j1dszOM+g5dSgiV7lBSzx5ZdnUpqUQgzr5yO6CuTOGDkJ+3w23mraqYZvQ1R5/NcHR
 03QrN9BctL9W+RSJCmvdeIaR3LBI7kuI5+zP6hqhqn+VkTzUIlByoow3T9CvoYwOEXjx
 CdaQ==
X-Gm-Message-State: AOJu0YzEaH9eRjUx4kVDZe3MQGk+X4YhU75NSqOi3LJGjal6LnBKE548
 W4vdityJLElrDAPxJhwkG2mESa3MuKB8rr5yTXkDhw==
X-Google-Smtp-Source: AGHT+IEDWtOxi5m+/XpxREONzxjdtypmN1/pxcxCGnRlVTh9IDgFOH0uHwSErBj3V/GXuz6g7yfTnA==
X-Received: by 2002:a2e:88da:0:b0:2bd:10b4:c3e1 with SMTP id
 a26-20020a2e88da000000b002bd10b4c3e1mr10513999ljk.19.1695126937649; 
 Tue, 19 Sep 2023 05:35:37 -0700 (PDT)
Received: from [172.20.41.70] (static-212-193-78-212.thenetworkfactory.nl.
 [212.78.193.212]) by smtp.gmail.com with ESMTPSA id
 f26-20020a170906495a00b0099d45ed589csm7675864ejt.125.2023.09.19.05.35.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Sep 2023 05:35:37 -0700 (PDT)
Message-ID: <06ed6fa4-1891-998c-f962-bf5a635c23fd@linaro.org>
Date: Tue, 19 Sep 2023 14:35:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 00/15] hw: Use QOM alias properties and few QOM/QDev
 cleanups
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Eduardo Habkost <eduardo@habkost.net>
References: <20230203145536.17585-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230203145536.17585-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 3/2/23 15:55, Philippe Mathieu-Daudé wrote:
> Since v1:
> - Addressed Markus & Zoltan review comments
> - Introduce/use qdev_unrealize_and_unref()
> 
> These patches are extracted from a QOM/QDev refactor series,
> so they are preliminary cleanups noticed while working on it:
> 
> - Use correct type when calling qdev_prop_set_xxx()
> - Unify some qdev properties in MIPS models
> - Replace intermediate properties by link properties
> - Remove DEFINE_PROP_DMAADDR() macro which is used one time
> - Use qdev_realize_and_unref() instead of open-coding it
> 
> Philippe Mathieu-Daudé (15):
>    hw/pci/pcie_sriov: Replace fprintf(error_pretty) ->
>      warn_reportf_err()
>    hw/qdev: Introduce qdev_unrealize_and_unref()
>    linux-user/syscall: Do not open-code qdev_unrealize_and_unref()
>    hw/pci/pcie_sriov: Do not open-code qdev_unrealize_and_unref()
>    hw/i386/sgx: Do not open-code qdev_realize_and_unref()
>    hw/ppc/sam460ex: Correctly set MAL properties
>    hw/arm/nrf51: Alias 'flash-size' QOM property in SoC object
>    hw/arm/fsl-imx: Alias 'phy-num' QOM property in SoC object
>    hw/usb/hcd-ohci: Include missing 'sysbus.h' header
>    hw/display/sm501: Embed OHCI QOM child in chipset
>    hw/display/sm501: Alias 'dma-offset' QOM property in chipset object
>    hw/display/sm501: Unify common QOM properties
>    hw/qdev: Remove DEFINE_PROP_DMAADDR() and 'hw/qdev-dma.h'
>    hw/mips: Declare all length properties as unsigned
>    hw/mips/itu: Pass SAAR using QOM link property

Ping for review?

