Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F02C5797263
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 14:41:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEK9-0004mj-IT; Thu, 07 Sep 2023 08:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeEK2-0004f9-Re
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 08:41:24 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeEJz-0003sm-Vx
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 08:41:22 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9a645e54806so111107366b.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 05:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694090478; x=1694695278; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j8vikMzN1ZOFRuwLydXCyr5zoPLYWoyrQdvkTeY97zE=;
 b=zd+vKA2224QBZwq9h42aaKZuWb7CoCAxeSfRRH/yjvCV2mOIq4xCTrB/bevdp2DS6V
 5rivK5lG2A0I2QIrSvrSiXohaqYpEacOfPxkSkHiNGwrmt+nUuRzd+uDk8lDImfhYrfP
 N6ynTo6b6iZ+GMvMMWxucsHF353XtStHzvYu2cghG6wCnpHl87qytcJhg3HwNd0Do9si
 MKASMFopl4rAv5ozRgM+wn9Xj1zOgiwnhRkTpVTZvJ/10bUw5xnC9qUvQ64ved+uVNhf
 VG64OjKOg4bWM87dGW1p5d/RltHuhPbV17o5pvYutgCYFv8KkQKyuTdwzZk6Zlm2YUG0
 u+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694090478; x=1694695278;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j8vikMzN1ZOFRuwLydXCyr5zoPLYWoyrQdvkTeY97zE=;
 b=j5CgPee+Pelxdn7/0sQBKJtOkZa/bpXm93oiBVmZEL/uFTcFn+/qya299CuOO+Q1fh
 ZBN/RKHGnSodmBGU5b6erKih1vLlFNwyF6/GnyIYPs0/Kn7n1G7rlye/dIxoCZ9Ztf6s
 +72mnHMxsUbdGZo0iyLcNVqmKotpaomJSKgdTrN2AlWgkj3ZNyOYVNNooTK/tRlgQiNI
 S2gezo/PKMTm3t6NQsSFvRD1IPYP54jBGxgnO4CwEHxiZDrkXBZ5xp8Zq7j6ikPtk+2A
 3b2QdFhrH2UGCN2vDToTbuhkSfSBkncBtBIsGHSfS3QQYlnYKePiV0VxwdngRv+lB6S9
 LCpA==
X-Gm-Message-State: AOJu0YxCLD8yo9p20zk+uK3MpQL2Uafmor+xloxDs7EywpyEjgzbeLS9
 Kj56oL/AdzyOX8WneJExu87viQ==
X-Google-Smtp-Source: AGHT+IHzDXtRiIEfeIaPNV+9ZTWkp3nFn3ZyrICqte9OR/wa4BrHv8nzKaKazub5LYTl/1tFLcKqtA==
X-Received: by 2002:a17:906:30cd:b0:99d:ec81:df58 with SMTP id
 b13-20020a17090630cd00b0099dec81df58mr4257759ejb.19.1694090478309; 
 Thu, 07 Sep 2023 05:41:18 -0700 (PDT)
Received: from [192.168.69.115] (176-131-222-226.abo.bbox.fr.
 [176.131.222.226]) by smtp.gmail.com with ESMTPSA id
 g2-20020a1709064e4200b009a5f7fb51d1sm10236509ejw.40.2023.09.07.05.41.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Sep 2023 05:41:17 -0700 (PDT)
Message-ID: <b7b7ca18-ec98-d402-9ebd-6ebaf49f7243@linaro.org>
Date: Thu, 7 Sep 2023 14:41:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2 3/3] hw/cxl: Support 4 HDM decoders at all levels of
 topology
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Michael Tsirkin <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>,
 linux-cxl@vger.kernel.org
Cc: linuxarm@huawei.com
References: <20230907113543.19760-1-Jonathan.Cameron@huawei.com>
 <20230907113543.19760-4-Jonathan.Cameron@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230907113543.19760-4-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

On 7/9/23 13:35, Jonathan Cameron wrote:
> Support these decoders in CXL host bridges (pxb-cxl), CXL Switch USP
> and CXL Type 3 end points.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   include/hw/cxl/cxl_component.h |  10 ++++
>   hw/cxl/cxl-component-utils.c   |  27 +++++----
>   hw/cxl/cxl-host.c              |  65 ++++++++++++++-------
>   hw/mem/cxl_type3.c             | 100 +++++++++++++++++++++++----------
>   4 files changed, 140 insertions(+), 62 deletions(-)

If you ever have to respin, please split the 'hdm_inc' introduction
in a preliminary patch, to reduce the number of changes and the
probability of missing a bug.

