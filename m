Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDA87F5BDD
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 11:06:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r66aa-0005Pm-O3; Thu, 23 Nov 2023 05:05:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r66aY-0005PI-SC
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 05:05:38 -0500
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r66aX-0007fq-4u
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 05:05:38 -0500
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2c8880fbb33so9235281fa.0
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 02:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700733935; x=1701338735; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+T5Y/auqp6b4DpeDjmSNt124oX3D9sR/8/ZhQczu7Xw=;
 b=Zft4hBq9XP64HCWKj32Ip7NEtMVi4loztbsPfVi61lWJPpLCZpU4wj/EJXUIN4NFZa
 BTx/f8RfEZRWianHonccfVPJWGK9cJIOBQ2DsNTbhlYykliJJ/d1ZoZYGtKndH2TkJwZ
 HnZVbuIpRqdx6uTscYni0Kb+tMYOHbq5e1TQ+Gx6jQCIvixRvwqFHsKFQ6WWuAD2VJsM
 bFYbFhciHYD1+XXYYKB9GzltaK14TU3VSOBfCuSecrZRzjhJYvKwiuJ8l4sDilNQJVvy
 DvDwDmBntAuVB45c2dwkapmSMahLvzFhXHyAMVOxncBds2kO8rWfEGxZOdFxE6TavM9Z
 OukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700733935; x=1701338735;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+T5Y/auqp6b4DpeDjmSNt124oX3D9sR/8/ZhQczu7Xw=;
 b=DMLe1ErRHu9Yoo4QcJjsZrGSLiNKWLB3UNDEwf7Wq8QAm6mhvNAVWhI+1BAe28eZ7J
 fnowWAIHWb5PGbllub6S7vMKjqtO9aUkTTSe3/npAgaPxcN8KZ0Sm5FCyWonDAoGADnQ
 iJeRxUSbCLjn3tC4VGVZwLOGccEb3fdsMC6aj4dRlgasdrsz3KmmlfZbjjpijthbj6Ft
 ivGRRJotR7VlD7A491S6cKz8HtGyR3x+XXDNumw9M7oBtRQw2yw7bV9wewip/2aelx0J
 V8I6iZOlyNDBExxIxnJHcDI9teBTFODvTDq3IAp17vunwLJmGm+cDy99N1N2nkh/DMes
 ekCw==
X-Gm-Message-State: AOJu0YzLO9T2wzNWXvgg0zGTiG0hFMDHmKX52H7nMAo5WJnK6pEI5oUV
 Q3lXhwAK1Y5dE/5fyZaFkW9whw==
X-Google-Smtp-Source: AGHT+IG1spkbk5ZOw+bFxvPmTtfCcXV2gWnZ57Dx/R2GqKXyABIn5n9IWD607A83+ZAnbpNJRrInbg==
X-Received: by 2002:a2e:8694:0:b0:2c8:76a1:51a5 with SMTP id
 l20-20020a2e8694000000b002c876a151a5mr3232798lji.45.1700733934431; 
 Thu, 23 Nov 2023 02:05:34 -0800 (PST)
Received: from [192.168.69.100] ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 j14-20020a05600c190e00b0040b3525428bsm1457375wmq.2.2023.11.23.02.05.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Nov 2023 02:05:33 -0800 (PST)
Message-ID: <6171dd28-05aa-402a-a0f7-48c02082efd9@linaro.org>
Date: Thu, 23 Nov 2023 11:05:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-8.2] pcie_sriov: Remove g_new assertion
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
References: <20231123075630.12057-1-akihiko.odaki@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231123075630.12057-1-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x235.google.com
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

On 23/11/23 08:56, Akihiko Odaki wrote:
> g_new() aborts if the allocation fails so it returns NULL only if the
> requested allocation size is zero. register_vfs() makes such an
> allocation if NumVFs is zero so it should not assert that g_new()
> returns a non-NULL value.
> 
> Fixes: 7c0fa8dff8 ("pcie: Add support for Single Root I/O Virtualization (SR/IOV)")
> Buglink: https://issues.redhat.com/browse/RHEL-17209
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   hw/pci/pcie_sriov.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
> index 5ef8950940..a1fe65f5d8 100644
> --- a/hw/pci/pcie_sriov.c
> +++ b/hw/pci/pcie_sriov.c
> @@ -178,7 +178,6 @@ static void register_vfs(PCIDevice *dev)
>       num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
>   
>       dev->exp.sriov_pf.vf = g_new(PCIDevice *, num_vfs);
> -    assert(dev->exp.sriov_pf.vf);
>   
>       trace_sriov_register_vfs(dev->name, PCI_SLOT(dev->devfn),
>                                PCI_FUNC(dev->devfn), num_vfs);

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


