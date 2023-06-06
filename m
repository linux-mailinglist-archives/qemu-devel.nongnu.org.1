Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FA1723692
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 07:03:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Oqp-0004sy-48; Tue, 06 Jun 2023 01:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6Oqi-0004sX-39
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 01:03:18 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6Oqf-0005Lx-1v
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 01:03:15 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3f78a32266bso19476685e9.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 22:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686027790; x=1688619790;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QSNW7So8kRC1aFWnIxUF1ZOeH5/v31jrfrDF4m8sR9M=;
 b=uAPG0pdf03I4/8asYLi0Cbk2FL2gDxPhq5JNidqOGKwvJPIQ0QCcDVYbqLG7qQzi93
 j3FXnohcGRa5uYvUuuM9hkJgMmbUh9t8M7EvCn7x3eFQ0BIN5+NNin9tXyNX3z7CofHC
 +L0HjnTddpaeenvBd7lWK8E5+Ntf4PGgDaRgceeGhTrTYyOdmAAgokSzUYrABhpUWf3Q
 8miYXXonqmhs1oYN1ti6Mp6ioDGyd9V3Eo60u+6tG/Vg4o2EHA+N+DG1RlDKPAaIrJyN
 iycI2zSyJZxmMhBxgHpkU9NoIKBjNApEVKmdHZ038Qy4Vl8Hlea1Rnzx9DOn2WaAFKLm
 CpFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686027790; x=1688619790;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QSNW7So8kRC1aFWnIxUF1ZOeH5/v31jrfrDF4m8sR9M=;
 b=W7whFIYZ4giVcFlF+HAuGmEYK1FnQvnZIUO5yO7VZRKWKn/+RF+4L+D4nB/nxO9B1f
 c7MASFjTdm5age2wZF/eAYPAjjHqVHy6ZJkrbJr4kQwK/qUujPtJKNs4uonmd9mjPrsD
 hELkO83qhKUTfPQprg4Vhl7RaY+CtWGqYAxwpb8wHjlv8vd4+OeAGsSdmkG+nZyDqc5q
 wSKuYQBypSwH1AJfinEzaIQxVF0b8VdtnR+0acZlxK9+WyJd+Xthu1DDAxqXA4xowWhG
 2LKEWe1abtuqxcTQeVpjImwh2hVKHmKtGx6eGCWVns6cmt4RnX0Eo95QS6Ox8TMi7HPC
 IH+g==
X-Gm-Message-State: AC+VfDwsWvY0LqFhDOPL6jVdcU3ANmHjCLEx4YR/Q/O3uHO9ltpMPQi4
 nsCbBBqZNs2Jb2ZG1BkUMRtwkg==
X-Google-Smtp-Source: ACHHUZ63nQ9TxDd7CTR7D2jtg0irJxQ2dagimLQggTvebGcDyOOVrcu0bpO2kaNccZQsSlFPEkLfJg==
X-Received: by 2002:a05:600c:2947:b0:3f6:923:9ec with SMTP id
 n7-20020a05600c294700b003f6092309ecmr1341066wmd.25.1686027790553; 
 Mon, 05 Jun 2023 22:03:10 -0700 (PDT)
Received: from [192.168.69.115] (vbo91-h01-176-184-50-104.dsl.sta.abo.bbox.fr.
 [176.184.50.104]) by smtp.gmail.com with ESMTPSA id
 y4-20020adfe6c4000000b00307bc4e39e5sm11338815wrm.117.2023.06.05.22.03.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 22:03:10 -0700 (PDT)
Message-ID: <19e16466-7ca7-d16d-8d11-72d4adc3359c@linaro.org>
Date: Tue, 6 Jun 2023 07:03:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [RFC v1 4/4] qemu: adjust queried bar size to power-of-2
Content-Language: en-US
To: ankita@nvidia.com, jgg@nvidia.com, alex.williamson@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
References: <20230605235005.20649-1-ankita@nvidia.com>
 <20230605235005.20649-5-ankita@nvidia.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230605235005.20649-5-ankita@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/6/23 01:50, ankita@nvidia.com wrote:
> From: Ankit Agrawal <ankita@nvidia.com>
> 
> The GPU device memory is reported to the VM as a BAR. The device memory
> may not be aligned to the power-of-2, but the QEMU expects the PCI BAR to
> be. Align the reported device memory size to the next power-of-2 before
> QEMU does an mmap.
> 
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> ---
>   hw/vfio/common.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 4d01ea3515..bb49200458 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -2061,7 +2061,7 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
>   
>       region->vbasedev = vbasedev;
>       region->flags = info->flags;
> -    region->size = info->size;
> +    region->size = info->size ? pow2ceil(info->size) : info->size;

        region->size = [REAL_]HOST_PAGE_ALIGN(info->size)?

>       region->fd_offset = info->offset;
>       region->nr = index;
>   


