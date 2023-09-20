Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 251E17A864F
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 16:12:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qixvM-0006X8-LD; Wed, 20 Sep 2023 10:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qixvK-0006Wn-N2
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 10:11:26 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qixvI-00053e-MS
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 10:11:26 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-99c136ee106so927724266b.1
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 07:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695219082; x=1695823882; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Uk4VjSeRm4CMMr+EJwxzGfM2euoWEbiPrYFpHKsT1xk=;
 b=OoAjPEsf/p4CiTg1wleOTkp5b9o1kPW3fHTAhjLj4Z0u1yP6Z1oO6g3HLwEc5C7ICa
 Y0sfso0MmKtMBGxcWhNYWAy17TqjGWRTV0YIodhy3EB63yOMBOI3DD8o5S8kPdtzgOcZ
 +f0ND3vtnWyY2gs9POgOFoPu1nA00gVwyI++Fl+NburFsKSpaR5H8qB0XHAdwzQsxVVP
 fs2dX4eHTR7skrX18MhQsZ5S/V4OGqy+GbTJuYRPFjVKplcNpj+CIBcOXQewVOPyiR0x
 +HOnDDfZRLD2wt+o5B0drQejAjgldSn+R3bNYIBM3FoRxvFIOTyC5MADTTvRrf5P0Z1D
 BylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695219082; x=1695823882;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Uk4VjSeRm4CMMr+EJwxzGfM2euoWEbiPrYFpHKsT1xk=;
 b=BD/kgMbc6a2Bly6HG1kBFeEpXVfZA0k0Sn/8OTojADp3unvmLFwRYEYTTy4z3h+YCq
 zFs6QklwFTZ5XO1fN3ghJE+DpGT9+hPoimX8jPbrDIv0CNTKEoBM2fV8VoyOe+LxGXEt
 SaDjPtBSZi6NM/ckl5x6HYT12a73S7fLevFgYmV7JVsuS4o5+QGDRaCjgQx40dDhJrr+
 sFlgJvx9s/RDDe2Un8T2raeoIopL3mDAc0snvHABR/EP1dJycwMzy3zc8M1gzxGCyTKN
 qs8SU28FYdnzvXtlYwSOOkIiUVfHOBJDlry3CfbUyiF5dIVX+H6/mtvXh3LsftCXiVvQ
 5lbw==
X-Gm-Message-State: AOJu0Yw3Q2mPRvwoioqUBd4p/oliP1oRGipOR/GhgAt/tJ2/on4CIlwY
 ltiPbpHoVqKxREs04bxHMlGOUUr6ilYmDl69wJg=
X-Google-Smtp-Source: AGHT+IHh77kxsYDHxXRBZWxz2jqJTyEF1JffolbyzqFil2P/lQZP9AF6OkbB2HHyHDHg8vWUuOiKGQ==
X-Received: by 2002:a17:907:a0c6:b0:9ad:8d45:6883 with SMTP id
 hw6-20020a170907a0c600b009ad8d456883mr2066587ejc.76.1695219082207; 
 Wed, 20 Sep 2023 07:11:22 -0700 (PDT)
Received: from [172.20.41.70] (static-212-193-78-212.thenetworkfactory.nl.
 [212.78.193.212]) by smtp.gmail.com with ESMTPSA id
 v24-20020a1709060b5800b0098951bb4dc3sm9335699ejg.184.2023.09.20.07.11.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Sep 2023 07:11:21 -0700 (PDT)
Message-ID: <0569dafb-6100-632b-fe2b-94a7dc98ca45@linaro.org>
Date: Wed, 20 Sep 2023 16:11:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/3] hw/mem/cxl_type3: Add missing copyright and
 license notice
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Michael Tsirkin <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>
Cc: linuxarm@huawei.com, Peter Maydell <peter.maydell@linaro.org>,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>,
 Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Warner Losh <imp@bsdimp.com>
References: <20230919101927.1470-1-Jonathan.Cameron@huawei.com>
 <20230919101927.1470-3-Jonathan.Cameron@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230919101927.1470-3-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

Hi Jonathan,

On 19/9/23 12:19, Jonathan Cameron wrote:
> This has been missing from the start. Assume it should match
> with cxl/cxl-component-utils.c as both were part of early
> postings from Ben.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

I haven't suggested this license, I only reported these
files are missing one (so eventually, Reported-by).

> Acked-by: Dave Jiang <dave.jiang@intel.com>
> Acked-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v2:
> - Add similar to cxl_type3_stubs.c
> - Add SPDX tags whilst here.
> - Gathered tags.
> ---
>   hw/mem/cxl_type3.c       | 11 +++++++++++
>   hw/mem/cxl_type3_stubs.c | 10 ++++++++++
>   2 files changed, 21 insertions(+)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index c5855d4e7d..8eb009c628 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1,3 +1,14 @@
> +/*
> + * CXL Type 3 (memory expander) device
> + *
> + * Copyright(C) 2020 Intel Corporation.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2. See the
> + * COPYING file in the top-level directory.
> + *
> + * SPDX-License-Identifier: GPL-v2-only

Too bad this isn't GPL-v2-or-later.


