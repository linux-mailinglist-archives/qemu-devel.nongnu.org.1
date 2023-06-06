Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46611723687
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 07:00:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Om1-0003hD-Q2; Tue, 06 Jun 2023 00:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6Olu-0003ge-KI
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 00:58:18 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6Ols-000415-US
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 00:58:18 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3090d3e9c92so5619071f8f.2
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 21:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686027495; x=1688619495;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OOoPiPOLO5Fo4+hZ/WfUOHJjTYIpHVqCk20W2RE8MRE=;
 b=hTtswFGal3f/ULly/6/pKAvliSmjAFZKJYcXSO4JxRfMdpGKqPZDd+k4K6xCchBhDB
 ZZdnavTzv1KdewNx5bIGbCU7C9vZdlLZvB9un/wF+9HbTpUHDjSHMQBMafiSt9yBEgYQ
 Asd9L/HHX/b8mqBTWZIev17u5I8Ls+iJB6/Wi4y1gQUmNGD/m2xQjHA+2UroGyvIJze/
 pD2BGgCnadGg2OAlt+6hdjHCB4wbgVAgVoOmiisA4sFFJzR5KpO66Avh1wX/7pInjfqQ
 PSmk4tMS2Ncpm+Ld0kFlcF9eGY37mqVrnWvHOhg8RjaO4w8ug8NTpZI8Jm+qySDxZO/F
 7URg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686027495; x=1688619495;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OOoPiPOLO5Fo4+hZ/WfUOHJjTYIpHVqCk20W2RE8MRE=;
 b=fgIHcgQn7aPDWs/D1KEwb4Gp0jYq65M1IihF4cx/MMf/++liRj5GjX0kQByh6YvZTc
 Igimb5BYOVSzJKPebbuPllIVsWTmo8/GHqtc4bzOLdZ4JFFNechMKDWFRCVd2oU6efHI
 4O4YgoAuxFhoQSN32+eI63sHoO9XGXsr4xFbd36TX3+YXtZFyXODy6RGSzMv9eyq2N04
 mMZ7z0ojcQ51nEC9tAV012zKkyF0U2DJl8Hxsku8t+/duAMtC+EgXXq+sncEVwmn91sR
 PjOugEtjSZ4oJ6CkgVlq01K3TU78ehU/PzSrk1sX0hiqKqXIbC0GEVTgLA0I9dL3rW5g
 /8xw==
X-Gm-Message-State: AC+VfDwVHu/tkZH7LXCkHEI1GO7onmc7qZityUf6VTj7M3T7ettMP0Bz
 hboLqmZN0hkzcDou3E6uS7Zb4w==
X-Google-Smtp-Source: ACHHUZ4TCH6Xs/uXHGOPWHvXjEtxUAZHEg2xdr0ChEOAFwQU/N9/5H+UagKzRI94P3S3fx+6PQ1T8g==
X-Received: by 2002:a5d:40d2:0:b0:306:3f97:4847 with SMTP id
 b18-20020a5d40d2000000b003063f974847mr897306wrq.65.1686027494953; 
 Mon, 05 Jun 2023 21:58:14 -0700 (PDT)
Received: from [192.168.69.115] (vbo91-h01-176-184-50-104.dsl.sta.abo.bbox.fr.
 [176.184.50.104]) by smtp.gmail.com with ESMTPSA id
 w2-20020adfd4c2000000b0030aeb3731d0sm11335140wrk.98.2023.06.05.21.58.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 21:58:14 -0700 (PDT)
Message-ID: <2022d199-3de9-fd34-11ef-bfb11a62a7e1@linaro.org>
Date: Tue, 6 Jun 2023 06:58:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [RFC v1 2/4] qemu: patch guest SRAT for GPU memory
Content-Language: en-US
To: ankita@nvidia.com, jgg@nvidia.com, alex.williamson@redhat.com
Cc: qemu-devel@nongnu.org, qemu-arm <qemu-arm@nongnu.org>
References: <20230605235005.20649-1-ankita@nvidia.com>
 <20230605235005.20649-3-ankita@nvidia.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230605235005.20649-3-ankita@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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
> The guest VM adds the GPU memory as (upto 8) separate memory-less NUMA
> nodes. ACPI SRAT need to thus insert proximity domains and tag them as
> MEM_AFFINITY_HOTPLUGGABLE. The VM kernel can then parse the SRAT and
> create NUMA nodes.
> 
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> ---
>   hw/arm/virt-acpi-build.c | 54 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 54 insertions(+)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c


>   /*
>    * ACPI spec, Revision 5.1
>    * 5.2.16 System Resource Affinity Table (SRAT)
> @@ -568,6 +620,8 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)

There is a x86 build_srat() equivalent.

So some abstraction in hw/acpi/srat.c is possible.

>       }
>   
> +    build_srat_devmem(table_data);
> +
>       acpi_table_end(linker, &table);
>   }
>   


