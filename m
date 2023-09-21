Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B84E27A91D4
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 08:56:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjDbb-0007G8-Ky; Thu, 21 Sep 2023 02:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qjDbZ-0007G0-QU
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 02:56:05 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qjDbV-0006rR-0H
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 02:56:05 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-690bc3f82a7so558600b3a.0
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 23:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1695279358; x=1695884158;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W/G3kjb/Y61pF2Hbc4e9oaT8JzU8Fx0SHbDl2+jHCIg=;
 b=3B/xR+NwWefr+n0DgCd0YMiM8Nw4amZMCp3l40XbckiCHiiSY+fZu0RuM2YjL2UrSH
 hFSDgEPr0kfh87kVFXEBU0RaVVOKHz4aSxSGWlM2+hxfHAklAgDGgYuucIEx5DOm4XdW
 mwoNVX53CfvFDW2HMyCkRh06vosmlXP3n7VD/SQPyQgN0+wvw8p1pDA1bgCkapgC4yLR
 8MEhJiMPQZM8GMT5lfkc8e7SzjuWWPxmUp/QXTG1oVDjbkfY4pB7usOTQUtkoMzYWHYq
 sKvHSWu1Dy0ADLv5332mXGICtDoFXTk19JlZNRITbArhBf3pabLWc5PclCD5Uah8FV++
 ByHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695279358; x=1695884158;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W/G3kjb/Y61pF2Hbc4e9oaT8JzU8Fx0SHbDl2+jHCIg=;
 b=sAaSUjGlpSRanGmBtiIrbFbQ24pFkleYT1c4JSLhVK5uK2HxrzHjI1Ubdwub+5ZBVe
 RT4XrvoF8NRN4sc7/OJn4PkhSSRD4/JuD5O9s+ii+YiV3LMYaGKIw0IpSCf0tHgL/JxY
 30jpIGrtnPZr8Is9EFDRvOkBOakfDHzE5UD2JF8U9kH675AlIDkaD5ZkTyrxBDR80Xr7
 W9RcraxmM6NWrFPjdNdv43AJesytruFrX0xU/T3QjGcXBRpKXLOyMJEi7z7BHGRYTx+x
 5LUq1GaP7FiN9l9/Tp/SZH4nruLTMKiDKpQAko/oNFNyfaYd1cvdbSuT3oP0J7TD/byw
 I9fg==
X-Gm-Message-State: AOJu0Yx/CU+uqZsEDiKKo5YT7byeXXGe8SCTbPrlaL7MQKQmr+Xu2+0C
 It71cQT3OOk0hHieBFmKNbYs4Js/mOTCF6m7Who=
X-Google-Smtp-Source: AGHT+IEpNrD7oMwyc1/87Q7fgvMg/uHgKqb09i0+TX2T77YQ5ecdFj/lgRmt6WcJjXQVlogUapWuHg==
X-Received: by 2002:a05:6a00:15d0:b0:68e:3bc8:17d1 with SMTP id
 o16-20020a056a0015d000b0068e3bc817d1mr5817537pfu.29.1695279357980; 
 Wed, 20 Sep 2023 23:55:57 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 d17-20020aa78e51000000b0068ff267f092sm594530pfr.216.2023.09.20.23.55.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Sep 2023 23:55:57 -0700 (PDT)
Message-ID: <601594f5-eb8b-4c8f-8ab8-6b5df684a114@daynix.com>
Date: Thu, 21 Sep 2023 15:55:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amd_iommu: Fix APIC address check
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230909162355.384982-1-akihiko.odaki@daynix.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230909162355.384982-1-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::432;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MISSING_HEADERS=1.021, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On 2023/09/10 1:23, Akihiko Odaki wrote:
> An MSI from I/O APIC may not exactly equal to APIC_DEFAULT_ADDRESS. In
> fact, Windows 17763.3650 configures I/O APIC to set the dest_mode bit.
> Check only the 12 bits that are known to be fixed for I/O APIC-generated
> MSIs.
> 
> Fixes: 577c470f43 ("x86_iommu/amd: Prepare for interrupt remap support")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   hw/i386/amd_iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 4655cd801f..3ac0d0098d 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -1268,7 +1268,7 @@ static int amdvi_int_remap_msi(AMDVIState *iommu,
>           return -AMDVI_IR_ERR;
>       }
>   
> -    if ((origin->address & AMDVI_MSI_ADDR_LO_MASK) != APIC_DEFAULT_ADDRESS) {
> +    if ((origin->address & 0xfff00000) != APIC_DEFAULT_ADDRESS) {
>           trace_amdvi_err("MSI is not from IOAPIC.");
>           return -AMDVI_IR_ERR;
>       }

Hi, can anyone interested in x86 review this?

Regards,
Akihiko Odaki

