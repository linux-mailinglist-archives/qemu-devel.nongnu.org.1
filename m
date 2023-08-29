Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB3C78C7D6
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 16:43:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qazw9-0001OY-DR; Tue, 29 Aug 2023 10:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qazw2-0001NW-Oq
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 10:43:16 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qazvz-0003NC-7A
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 10:43:14 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5007c8308c3so7117281e87.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 07:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693320188; x=1693924988;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ljqmUbca8HfxbkjAgGpG/Z+/cibTftf84UwqjXuV+us=;
 b=XcxBPqDCRvVK/SMZLCJrjLC9eBL6gDRFCNf6O71SOkkPPNO8eHI+W9VagGfce6dr1J
 7fbjEjDpwDqAdtR0Ajb6geP3pG7193lwhWtFJmIAVhpZud57vnUT06CMnoup4mihRslq
 btYTOMSxpRHJHmQnzM0pW8TyMOgqQiMMYlfR/AtFroVjd7ooiK+OVneqvrExyez7sewo
 Ejkdc45T424YegK9DKrG070vs8SfJQdrPRTLStZUGXA4opcjoaBgqDQLtNm8OhNr59lI
 /KtOcGHW0rxqkMZMD+/coOjWEKKieCwXh38IWpXHzyopLl9A5V7FvFzp6LBNBOK7UFuk
 C8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693320188; x=1693924988;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ljqmUbca8HfxbkjAgGpG/Z+/cibTftf84UwqjXuV+us=;
 b=B4cSbIVllEAEnvMlJbhmLslAqSbRnHDrGjYs2lc4pBCTxf3V591wbpynHv0BYtT1nZ
 Ix9ttGuottz2gKrOQm1TtPb2OvTS0+WCCHRZUxjqlyNffDnnUF7AooWwJHsj0OcT9VzF
 AEBN79Fno4soRJMfD+DXetXAd3Gscr8bXWhCMr8j5ORRsOQQMIWYFm0sSG0xrcgBYpAt
 MtZRaqVJEI5/asmkTh4CtoeHjY0Al66SClvAnk6TVEfPbU+7luZyGhtFnKsg0nzbBVxB
 UBsZKabsj/QD9rbdkRHS2RFkjbP7JDFMegFqmILhwxMpkB7ZDKwExTqK1EngkZcZ4twR
 U7tg==
X-Gm-Message-State: AOJu0YxFTLuw/BcpV+csLfbemZCDBHRcPpa8v6itRA/MI8lw/i9r4kPV
 VnEnSHIpecj0gyGvd72R+C4+UQ==
X-Google-Smtp-Source: AGHT+IGB0fvgzuTUBz4U1iOcoTBT5USzSN9LsDT3fxCChLBTfjhElyy6gwvyWtqKC515FpdCGiLKzQ==
X-Received: by 2002:ac2:4bc5:0:b0:500:b64a:ad15 with SMTP id
 o5-20020ac24bc5000000b00500b64aad15mr5399274lfq.52.1693320187992; 
 Tue, 29 Aug 2023 07:43:07 -0700 (PDT)
Received: from [192.168.200.206] (83.11.188.80.ipv4.supernova.orange.pl.
 [83.11.188.80]) by smtp.gmail.com with ESMTPSA id
 b8-20020a170906194800b009920e9a3a73sm6040159eje.115.2023.08.29.07.43.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 07:43:07 -0700 (PDT)
Message-ID: <9af58fd1-bef5-4499-fbbf-35f363bd2ca5@linaro.org>
Date: Tue, 29 Aug 2023 16:43:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PCIe: SLT attribute mismatch: 0xFF020100 instead of 0x20100
Content-Language: pl-PL, en-GB, en-HK
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Gowtham Siddarth <gowtham.siddarth@arm.com>
References: <56aa4acb-d54c-a457-5a32-9258cec1ac96@linaro.org>
 <c3c6bab4-27e6-8812-2dc5-3d22c1ef16a5@linaro.org>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <c3c6bab4-27e6-8812-2dc5-3d22c1ef16a5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

W dniu 29.08.2023 o 15:57, Philippe Mathieu-Daudé pisze:
> On 29/8/23 13:39, Marcin Juszkiewicz wrote:

>> Does someone know where the problem may be? And how to fix it?
> 
> Commit fb23162885 ("pci: initialize pci config headers depending it pci
> header type.") sets PCI_SEC_LATENCY_TIMER writable; it seems to be a
> mistake (and bsa-acs is doing the correct testing).
> 
> Can you try this quick fix?
> 
> -- >8 --
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 881d774fb6..e43aa0fb36 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -894,5 +895,4 @@ static void pci_init_mask_bridge(PCIDevice *d)
>   {
> -    /* PCI_PRIMARY_BUS, PCI_SECONDARY_BUS, PCI_SUBORDINATE_BUS and
> -       PCI_SEC_LETENCY_TIMER */
> -    memset(d->wmask + PCI_PRIMARY_BUS, 0xff, 4);
> +    /* PCI_PRIMARY_BUS, PCI_SECONDARY_BUS, PCI_SUBORDINATE_BUS */
> +    memset(d->wmask + PCI_PRIMARY_BUS, 0xff, 3);

It made test pass:

  822 : Check Type 1 config header rules           : Result:  PASS

