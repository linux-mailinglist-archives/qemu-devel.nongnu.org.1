Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3972B8219C2
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 11:30:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKc1Z-0004Uv-Ei; Tue, 02 Jan 2024 05:29:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKc1K-0004UT-JO
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 05:29:17 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKc1I-0001bs-LL
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 05:29:14 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3368ae75082so4850299f8f.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 02:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704191350; x=1704796150; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gZt+jI3yrrtHW+ylSqnHBTIVmmrElsiUaVV6R1l2/6Y=;
 b=rlhTbO3+B7if2+TBseEiuYTGjijRUM1zgG+vqNDFTdKL2T/blczOH5M6nn0jfCKqWz
 xjiKWXs32UKDLuYpnRteGZLKf7NPx56EL9Cvmym+OTPYvAtcHxhBMGS98Ycy/SaMaNJ7
 FA1YsXL8RD5MaR8uapzgXhqw8e3X1UXDurHbAWWvAWxW8qH+fqh/en0QtXqPxd5Z3znc
 9WsA7nZdlltlNCRlu1yJazTyKrdAaqgCSr0xxyonyrWQgJAOw+Fa7mPC/eY1tAApQl+G
 qp5GraHYh0aB4xB5RSNZ1f+7Ad6Ud9kTJkqDz1VReq4i9GEfPU+42eMJrfapNY/bQfzX
 1Smw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704191350; x=1704796150;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gZt+jI3yrrtHW+ylSqnHBTIVmmrElsiUaVV6R1l2/6Y=;
 b=RsMPzEjFjCXOIKkXY7KphDYOdtOYqMn5EEv/mhqRIxmeVYP7+yoLYZEPfjIXZj16Kf
 TtgXMg8aaVVNfYW/eoKnVClvIDAzmS4gvOEScnfB3BW78zLswKhqtZGtokXIUig59TjD
 7pInBq185AhPHkHGNujwhZXs0GmG0nf0PSIViIXF3hf5UTnl8ZWnD8vlNTdV1dqaZPrl
 4JVQJs4Yw1A9wWmZTENbuxtnBiHmUyw0xMJUbwNNvPafUHwGPKC8JMt4kpvfc4URSPcZ
 G3IpZoPPho4EZF0GjHT6Rnf+7i+bjUsrwVB2yZEcevJ4jNMtaUVyi5wI52G9qGaBkJlH
 cUVg==
X-Gm-Message-State: AOJu0Yy+lkqGlzpBwMadBBz+nRU5MbWzGGLoHIRv5zJ2TT5Nft8ZL/n1
 N6eoT34YHgxHzenOGGI/siq2Hkiw5xlqFw==
X-Google-Smtp-Source: AGHT+IHAb3J/DyUzJZ5XQrEKJCwXXjtwAJtsL+ESzB0vCFur9k//lqdpUL+GN3kc0YeflrCbgVv1XQ==
X-Received: by 2002:a05:600c:4f56:b0:40d:85a1:8d0a with SMTP id
 m22-20020a05600c4f5600b0040d85a18d0amr1787566wmq.113.1704191350241; 
 Tue, 02 Jan 2024 02:29:10 -0800 (PST)
Received: from [192.168.69.100] (sal63-h02-176-184-16-71.dsl.sta.abo.bbox.fr.
 [176.184.16.71]) by smtp.gmail.com with ESMTPSA id
 o20-20020a05600c4fd400b0040b37f1079dsm51650250wmq.29.2024.01.02.02.29.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jan 2024 02:29:09 -0800 (PST)
Message-ID: <75843b7e-1460-4ea2-8837-51299a3a232b@linaro.org>
Date: Tue, 2 Jan 2024 11:29:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QEMU-devel][RFC PATCH 1/1] backends/hostmem: qapi/qom: Add an
 ObjectOption for memory-backend-* called HostMemType and its arg 'cxlram'
Content-Language: en-US
To: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hao Xiang <hao.xiang@bytedance.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ben Widawsky <ben.widawsky@intel.com>,
 Gregory Price <gourry.memverge@gmail.com>, Fan Ni <fan.ni@samsung.com>,
 Ira Weiny <ira.weiny@intel.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
Cc: "Ho-Ren (Jack) Chuang" <horenc@vt.edu>, linux-cxl@vger.kernel.org
References: <20240101075315.43167-1-horenchuang@bytedance.com>
 <20240101075315.43167-2-horenchuang@bytedance.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240101075315.43167-2-horenchuang@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Hi Jack,

On 1/1/24 08:53, Ho-Ren (Jack) Chuang wrote:
> Introduce a new configuration option 'host-mem-type=' in the
> '-object memory-backend-ram', allowing users to specify
> from which type of memory to allocate.
> 
> Users can specify 'cxlram' as an argument, and QEMU will then
> automatically locate CXL RAM NUMA nodes and use them as the backend memory.
> For example:
> 	-object memory-backend-ram,id=vmem0,size=19G,host-mem-type=cxlram \
> 	-device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> 	-device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
> 	-device cxl-type3,bus=root_port13,volatile-memdev=vmem0,id=cxl-vmem0 \
> 	-M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=19G,cxl-fmw.0.interleave-granularity=8k \
> 
> In v1, we plan to move most of the implementations to util and break down
> this patch into different smaller patches.
> 
> Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> ---
>   backends/hostmem.c       | 184 +++++++++++++++++++++++++++++++++++++++
>   include/sysemu/hostmem.h |   1 +
>   qapi/common.json         |  19 ++++
>   qapi/qom.json            |   1 +
>   qemu-options.hx          |   2 +-
>   5 files changed, 206 insertions(+), 1 deletion(-)
> 
> diff --git a/backends/hostmem.c b/backends/hostmem.c


> +#define CXL_DEVICE_PATH "/sys/bus/cxl/devices/"
> +#define REGION_PATH_LEN 307
> +#define DAX_REGION_PATH_LEN 563
> +#define DAX_PATH_LEN 819
> +#define TARGET_FILE_PATH_LEN 831

How do you get these numbers?

> diff --git a/qapi/common.json b/qapi/common.json
> index 6fed9cde1a..591fd73291 100644
> --- a/qapi/common.json
> +++ b/qapi/common.json
> @@ -167,6 +167,25 @@
>   { 'enum': 'HostMemPolicy',
>     'data': [ 'default', 'preferred', 'bind', 'interleave' ] }
>   
> +##
> +# @HostMemType:
> +#
> +# Automatically find a backend memory type on host.

This description is not clear (to me).

> +# Can be further extened to support other types such as cxlpmem, hbm.

Typo "extended" although I'm not sure it is helpful to mention it.

> +#
> +# @none: do nothing (default).

"do nothing" is confusing here, I'd drop it.

> +#
> +# @cxlram: a CXL RAM backend on host.
> +#
> +# Note: HostMemType and HostMemPolicy/host-nodes cannot be set at the same
> +# time. HostMemType is used to automatically bind with one kind of
> +# host memory types.
> +#
> +# Since: 8.3

9.0

> +##
> +{ 'enum': 'HostMemType',
> +  'data': [ 'none', 'cxlram' ] }
> +
>   ##
>   # @NetFilterDirection:
>   #
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 95516ba325..fa3bc29708 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -626,6 +626,7 @@
>               '*host-nodes': ['uint16'],
>               '*merge': 'bool',
>               '*policy': 'HostMemPolicy',
> +            '*host-mem-type': 'HostMemType',

Missing documentation in MemoryBackendProperties.

>               '*prealloc': 'bool',
>               '*prealloc-threads': 'uint32',
>               '*prealloc-context': 'str',


