Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 578217BF490
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 09:40:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq7Kz-00015X-SA; Tue, 10 Oct 2023 03:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1qq7Kx-00011v-Hq
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 03:39:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1qq7Ku-0001lp-It
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 03:39:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696923563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zXYDsEbd3BNJe+VerGjSV5r0zWLPidrTXCRvYGol8fM=;
 b=Yt01+uQwHdMNQPzWFZpwCulo29V7OzFGKeplcy8JOTnBpGSte0/7i2RCZ4WTjzBOevHuQI
 6bWn1BAvExAaJaqo0nOGWzBpO/+SUF9TCxnBL/o8AtQhL4dhGIhV19gD8G5vdzNOlk6uq8
 dipmHWjDGxyN42CLIP74tEtRgq6EAEU=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-DXooQA8nM3WELO6RPjbdpA-1; Tue, 10 Oct 2023 03:39:21 -0400
X-MC-Unique: DXooQA8nM3WELO6RPjbdpA-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3ae2377058bso1576040b6e.1
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 00:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696923561; x=1697528361;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zXYDsEbd3BNJe+VerGjSV5r0zWLPidrTXCRvYGol8fM=;
 b=g3aoeQxO9Z37Gf8eG9X7535tRRH/IDrIw18XShEZyaNC4IHv9DxVeRc+pwz5UQPHr6
 cVukyqXnHkIukRlW3zg2/sqYRwr6TJomOLhSYv7q5DqusqX9vERsPuVQbb6iybcbmwC2
 pH9wazhbcUUuqIo2OP08aC/wRFgxUqFUIyh9y9Qy6EC63HmRwy5bckyB54tmf2jtpe1P
 tk+v31nvpJl2EEym5wO7g9VlmBzjj9bjIYq009/02DYfABb+Ds3ewLqyNGqBP2NeKX5b
 v60Pf1RGMnMISxlHMgDfF+E3y3DmRn2mutTky/KaIrNOlMVKMNfswwlOL42Spx8EdNxs
 aIwQ==
X-Gm-Message-State: AOJu0YzZ7uzdBhbBynaoSttR5srlleof+/2gTmUAPYybYf7ZvqLlFjJv
 9xQM7SQPH1jDwms184ms/RJUwvWhfuRdqyAwDOH+oTfQ1ZYVFFePEfaReu7ayl49qgyeJ4dFakZ
 5XrzOVVk9H19v8VQ=
X-Received: by 2002:a05:6808:13c5:b0:3ae:24bb:381a with SMTP id
 d5-20020a05680813c500b003ae24bb381amr19596952oiw.3.1696923560895; 
 Tue, 10 Oct 2023 00:39:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+3AS7R5HKKe/RR4KSGYB4qf5PdVkrawmUeh+B4tJIXn3DU11PQyTvM/MMHdRF11LduM70Sw==
X-Received: by 2002:a05:6808:13c5:b0:3ae:24bb:381a with SMTP id
 d5-20020a05680813c500b003ae24bb381amr19596930oiw.3.1696923560443; 
 Tue, 10 Oct 2023 00:39:20 -0700 (PDT)
Received: from [10.66.61.39] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 bt21-20020a632915000000b00583f73b7bcbsm6757001pgb.58.2023.10.10.00.39.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 00:39:19 -0700 (PDT)
Message-ID: <af88682c-aa4b-d457-44bf-fa3bba910d3b@redhat.com>
Date: Tue, 10 Oct 2023 15:39:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V4 03/10] hw/acpi: Add ACPI CPU hotplug init stub
Content-Language: en-US
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com,
 oliver.upton@linux.dev, pbonzini@redhat.com, mst@redhat.com,
 will@kernel.org, gshan@redhat.com, rafael@kernel.org,
 alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, linuxarm@huawei.com
References: <20231009203601.17584-1-salil.mehta@huawei.com>
 <20231009203601.17584-4-salil.mehta@huawei.com>
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <20231009203601.17584-4-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
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



On 10/10/23 04:35, Salil Mehta via wrote:
> ACPI CPU hotplug related initialization should only happen if ACPI_CPU_HOTPLUG
> support has been enabled for particular architecture. Add cpu_hotplug_hw_init()
> stub to avoid compilation break.
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>   hw/acpi/acpi-cpu-hotplug-stub.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/hw/acpi/acpi-cpu-hotplug-stub.c b/hw/acpi/acpi-cpu-hotplug-stub.c
> index 3fc4b14c26..c6c61bb9cd 100644
> --- a/hw/acpi/acpi-cpu-hotplug-stub.c
> +++ b/hw/acpi/acpi-cpu-hotplug-stub.c
> @@ -19,6 +19,12 @@ void legacy_acpi_cpu_hotplug_init(MemoryRegion *parent, Object *owner,
>       return;
>   }
>   
> +void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
> +                         CPUHotplugState *state, hwaddr base_addr)
> +{
> +    return;
> +}
> +
>   void acpi_cpu_ospm_status(CPUHotplugState *cpu_st, ACPIOSTInfoList ***list)
>   {
>       return;

-- 
Shaoqin


