Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3951673A1C7
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 15:18:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCKBb-0002Kn-56; Thu, 22 Jun 2023 09:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCKBZ-0002K2-3M
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 09:17:17 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCKBX-0000o6-3p
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 09:17:16 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4f8735ac3e3so6525120e87.2
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 06:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687439832; x=1690031832;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HS5dTigQ5WPP5LDtaopg5+CMkXi9Z7Mxuy3T/1gnsTA=;
 b=YzsZVexYiQUEqS5Ybmn9hnv0ZZ433j+6n2qqvCx7S13FnB/oQhlb+5ql3gaEukKUY8
 uXfm3Jg/tWAzVi/7lQmLUUaZU4t3gjxtHCZEYjXBHFiYoO4YqVouVJxVPfX5PgaQoVqV
 l3frSqV4VCh0kb6FJycpdmsouqJQn2iMwXGBeGOCFZteQWfECzlnpxRLZyJd4IhGyttJ
 8pIenjw5gtfdx5DFfFh13UkAOTchGnBqeqNIHLZLSQjQp/K80OBcES1RZA1W7J48d4N4
 NSphWCPwudJm0vva6hgCwgTNXLfcap1L188c7yTqXnudjOszp8M/9U5LPZPP6ggTMA13
 XTQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687439832; x=1690031832;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HS5dTigQ5WPP5LDtaopg5+CMkXi9Z7Mxuy3T/1gnsTA=;
 b=XUpZdTh3EbZAS42cNKVPc3CWvrS1gF+iwkupRl4JELmzXL2cqX9YGWUjB2fdlCOU2n
 3OnLm51/5eNTo5c7+xG5LTJVeW39DvqxlnL5mX5qeWXCNTCYyodDOHE3fG8T0DB/kp5W
 FZlZQsMk8VnWzYUxCGu9PmITatfokrM+vIA9RQn3OkNVyLuqnexw+tbXyHm1ve/bgCLf
 vaEZsOcSV/56NE8OTKVotzSNebctDk1btjxlxKeR8lelTg8ewDt9dmszHmnmiO4VRY6Q
 k1i29IEFfS+k2H4vfngsCnLlmZonjJzc0Ji17rXWFAa9GxLVhmHO3ExshjNcuw2//fjs
 dWAg==
X-Gm-Message-State: AC+VfDw3qLpT+weHfN2OJwBYJNSaWDBG9UzCnHcYgWbYKhYKfTUgH1Q1
 S8ldmDnth5TY0dlssJrZbCKvf677sORAPGtraFFDQg==
X-Google-Smtp-Source: ACHHUZ4iyLCquy06FwR0//V/JCoM6j9OvW8htZIpqHT7QEZrDblFyhjaKsactnh/XPIGoWPiL1AhWjZad9EUWHe+L1U=
X-Received: by 2002:a05:6512:455:b0:4f6:2e4e:e425 with SMTP id
 y21-20020a056512045500b004f62e4ee425mr7246329lfk.50.1687439830697; Thu, 22
 Jun 2023 06:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230620195054.23929-1-lvivier@redhat.com>
 <20230620195054.23929-2-lvivier@redhat.com>
In-Reply-To: <20230620195054.23929-2-lvivier@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Jun 2023 14:16:59 +0100
Message-ID: <CAFEAcA-XOrY+VJDhv2MVV-d1arSD3twukAY13KfuEuADqF1QHQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] memory: introduce memory_region_init_ram_protected()
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 jasowang@redhat.com, mst@redhat.com, David Hildenbrand <david@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, marcandre.lureau@redhat.com,
 eric.auger@redhat.com, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x133.google.com
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

On Tue, 20 Jun 2023 at 20:51, Laurent Vivier <lvivier@redhat.com> wrote:
>
> Commit 56918a126a ("memory: Add RAM_PROTECTED flag to skip IOMMU mappings")
> has introduced the RAM_PROTECTED flag to denote "protected" memory.
>
> This flags is only used with qemu_ram_alloc_from_fd() for now.
>
> To be able to register memory region with this flag, define
> memory_region_init_ram_protected() and declare the flag as valid in
> qemu_ram_alloc_internal() and qemu_ram_alloc().
>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  include/exec/memory.h | 33 +++++++++++++++++++++++++++++++++
>  softmmu/memory.c      | 33 +++++++++++++++++++++++++++------
>  softmmu/physmem.c     |  4 ++--
>  3 files changed, 62 insertions(+), 8 deletions(-)
>
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 47c2e0221c35..d8760015c381 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -1520,6 +1520,39 @@ void memory_region_init_iommu(void *_iommu_mr,
>                                const char *name,
>                                uint64_t size);
>
> +/**
> + * memory_region_init_ram_protected - Initialize RAM memory region.  Accesses
> + *                                    into the region will modify memory
> + *                                    directly.
> + *
> + * The memory is created with the RAM_PROTECTED flag, for memory that
> + * looks and acts like RAM but inaccessible via normal mechanisms,
> + * including DMA.

This doesn't really tell me why you might want to mark
a region as RAM_PROTECTED. What kind of memory region is
not DMAable to? What are "normal mechanisms" here?
What are the "non-normal mechanisms" that you *can* use on
this memory region?

At the moment we only seem to use RAM_PROTECTED for
the SGX EPC memory backend. The commit message adding
that flag is pretty vague about what it means...

thanks
-- PMM

