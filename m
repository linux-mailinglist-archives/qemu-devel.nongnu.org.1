Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 999CD740968
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 08:19:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEOWT-0006le-Sc; Wed, 28 Jun 2023 02:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEOWC-0006ft-Un
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 02:19:15 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEOWA-00050a-1t
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 02:19:07 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-98e011f45ffso416396666b.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 23:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687933143; x=1690525143;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BdsLEjlLpivZzWQTVVtKaP9kRkqQsLDxSVqZVisExtI=;
 b=jV3udahy5nxhmEqH7AzSzuNhOMqkEw1ZNlbBRfbP37P3KHYdqdyye6qYjS2uBAeiuh
 RKTB83NVanGqiOlEFs8K8Ex2kk+Ec/IcIP4psqDkbDuINYSfmhGMBnv29oEbI1iH2ICd
 BO+Ucvm+stCk15XQlOVpB1llqo6ovHusuM64eBy/KW9zYaMR4+jo1wtguhyNFoee3gFI
 yoUZcYRgKPlLpd+cH/JlvPJv0D36IhdMXSnBTn9JAiu/rzRnsxF0YuMN30FNk8NRGwlj
 9qtYxDY9B/qOB1oyyDO2pMFW9vxoBDz9qm5ZEKgOiAdN87OKHgdaibo/W82r3WroIf7X
 KfEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687933143; x=1690525143;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BdsLEjlLpivZzWQTVVtKaP9kRkqQsLDxSVqZVisExtI=;
 b=dGsJJc7dlueleh4osqt4cdFEIawga3sgacyW4l7m5R7yykziJ8/HEUKM2bfx0TuPy5
 VmeWp2S+tWXw7Hsnf+NlWZ4xMbBPj7VGrtVc+swPca3Ys6es2TZegQpJVdbd1zXq5pcu
 GyY8LgpMpoVRER0SBHTnftGw0wemi2+rDshawZn/B3Hsa/Yf9my33qXZ3oIJ+eOWwFOc
 G8eVE0LWP3n9URHmxpAatuuwD+DtXLy3T5pGFbduyEL0Pd7EFLzHdLbePtjjQeM9T2XW
 +N9PwH1EK3ewXvf8O5q3zaulVir+LbilGE9G1xspQZ4fQSs9rEVJQqxryW+NUTR/hXZo
 ZDoQ==
X-Gm-Message-State: AC+VfDzdQtUWKiZoo4IoyDzjQ8gK7SV0OIAC8ZtAouneIUCuvxKos8Pl
 yMlZniZRpWNOGGSTCm/JO64FZQ==
X-Google-Smtp-Source: ACHHUZ5erKklfSPbjmsjuFBqT0iH9qge53QKKdN2zaXqEi8+rRh83Gbo6+lT9HdlHnXh7PqTRdwOSQ==
X-Received: by 2002:a17:906:684c:b0:98e:4c96:6e1c with SMTP id
 a12-20020a170906684c00b0098e4c966e1cmr5091095ejs.67.1687933143439; 
 Tue, 27 Jun 2023 23:19:03 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.207.229])
 by smtp.gmail.com with ESMTPSA id
 f25-20020a170906085900b0098e42bef736sm3982695ejd.176.2023.06.27.23.19.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 23:19:02 -0700 (PDT)
Message-ID: <a425c18d-1a98-19ab-657a-040a5b655a59@linaro.org>
Date: Wed, 28 Jun 2023 08:19:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] i386/WHPX: Fix error message when fail to set
 ProcessorCount
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>
Cc: qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20230529124331.412822-1-zhao1.liu@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230529124331.412822-1-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.103,
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

On 29/5/23 14:43, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> 003f230e37d7 ("machine: Tweak the order of topology members in struct
> CpuTopology") changes the meaning of MachineState.smp.cores from "the
> number of cores in one package" to "the number of cores in one die"
> and doesn't fix other uses of MachineState.smp.cores. And because of
> the introduction of cluster, now smp.cores just means "the number of
> cores in one cluster". This clearly does not fit the semantics here.
> 
> And before this error message, WHvSetPartitionProperty() is called to
> set prop.ProcessorCount.
> 
> So the error message should show the prop.ProcessorCount other than
> "cores per cluster" or "cores per package".
> 
> Cc: Sunil Muthuswamy <sunilmut@microsoft.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   target/i386/whpx/whpx-all.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
> index 52af81683c1e..5882bf22d0a1 100644
> --- a/target/i386/whpx/whpx-all.c
> +++ b/target/i386/whpx/whpx-all.c
> @@ -2613,8 +2613,8 @@ static int whpx_accel_init(MachineState *ms)
>           sizeof(WHV_PARTITION_PROPERTY));
>   
>       if (FAILED(hr)) {
> -        error_report("WHPX: Failed to set partition core count to %d,"
> -                     " hr=%08lx", ms->smp.cores, hr);
> +        error_report("WHPX: Failed to set partition processor count to %d,"
> +                     " hr=%08lx", prop.ProcessorCount, hr);

ProcessorCount is UINT32, so '%d' -> '%u'. Otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>           ret = -EINVAL;
>           goto error;
>       }


