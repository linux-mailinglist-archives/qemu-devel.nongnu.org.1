Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1077B0FEE
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 02:26:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qleqx-0000il-OE; Wed, 27 Sep 2023 20:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qleqt-0000iM-Fd
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 20:25:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qleqq-0004Rd-HZ
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 20:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695860755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W0lrm3EL17qSVrOEr5JXHxYGcVXaoW9K1rfvDbK41iw=;
 b=iuJIGhmbjZW3cBwshnq7CPME4PUExBzTVifQoXPnBGpfc3Ky8Tm2Uf15JPznSi/X21Yz9T
 h5CrNd780HTOGJga7tmYyffl7J9QLp6OoUT+Y4TBjn6/5HNEK0nNLNqsfn0izCMrVTdI1P
 zurH/udMp6VmfJ0ofw5Hw23+SmzOjOg=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-o0Peo_9XNoig388022eRGg-1; Wed, 27 Sep 2023 20:25:53 -0400
X-MC-Unique: o0Peo_9XNoig388022eRGg-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5701dbeaf9fso15519715a12.2
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 17:25:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695860752; x=1696465552;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W0lrm3EL17qSVrOEr5JXHxYGcVXaoW9K1rfvDbK41iw=;
 b=Ccvwg+YjzBNWCtlshhYWF3iKkRAXMk2ncpwsgoHz7zITzsEf4H85HEqtOAEBjOIHXI
 H9y57kJAy5v7zhLGO/i51XFEAoH0ZfQITyiBcJJrdfl7B6uJdhz4wCOLRMqBs4X7cU+D
 wrWwyefMVwCykay9VocgzrJ5ou82NCmB2AOo13z/tlv14jU5ZUiAEdlLRUp1LdAk4/L7
 yqW+Xw+veCEuYiLnWo3bk5XMkWX/yRLfrOrXexrSGOsY/thIzu1clRKhAKPBUx47sXuA
 wWOUl2n15nV+7fB8pK10hTdNvZYA8JvlAK8zQANpDKXRkno8Q0KKXzuRGft2UZPrYQOt
 CzFQ==
X-Gm-Message-State: AOJu0Ywz0mqRPS3Dk+kIWqii3sZoaV0qeoPnwtKcIi64+87Mbd+V1k7v
 Sl8XWESN2FXn+1Q4xZ5G3drHSDZvFlDMG0NjEVS0z0U8CBXh4dtJC3mfiwFuik2fdpD8Wla+Qpy
 6MwR+fGY7MBhGZIw=
X-Received: by 2002:a05:6a20:f3a2:b0:12e:4d86:c017 with SMTP id
 qr34-20020a056a20f3a200b0012e4d86c017mr3355380pzb.10.1695860752321; 
 Wed, 27 Sep 2023 17:25:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQU2cJy5HWo81DZOJmHsOKp0ZqaJQ9Brf324RNpTJConwythZVY85pZmI0b2bjbgZMnzK1CQ==
X-Received: by 2002:a05:6a20:f3a2:b0:12e:4d86:c017 with SMTP id
 qr34-20020a056a20f3a200b0012e4d86c017mr3355350pzb.10.1695860752046; 
 Wed, 27 Sep 2023 17:25:52 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 y3-20020a170902864300b001b0358848b0sm13737871plt.161.2023.09.27.17.25.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Sep 2023 17:25:51 -0700 (PDT)
Message-ID: <ce26889c-344a-b09c-a8b4-35904ffff771@redhat.com>
Date: Thu, 28 Sep 2023 10:25:37 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC V2 10/37] arm/acpi: Enable ACPI support for vcpu
 hotplug
Content-Language: en-US
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com, will@kernel.org,
 ardb@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 mst@redhat.com, rafael@kernel.org, borntraeger@linux.ibm.com,
 alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com,
 maobibo@loongson.cn, lixianglai@loongson.cn
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <20230926100436.28284-11-salil.mehta@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230926100436.28284-11-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hi Salil,

On 9/26/23 20:04, Salil Mehta wrote:
> ACPI is required to interface QEMU with the guest. Roughly falls into below
> cases,
> 
> 1. Convey the possible vcpus config at the machine init time to the guest
>     using various DSDT tables like MADT etc.
> 2. Convey vcpu hotplug events to guest(using GED)
> 3. Assist in evaluation of various ACPI methods(like _EVT, _STA, _OST, _EJ0,
>     _MAT etc.)
> 4. Provides ACPI cpu hotplug state and 12 Byte memory mapped cpu hotplug
>     control register interface to the OSPM/guest corresponding to each possible
>     vcpu. The register interface consists of various R/W fields and their
>     handling operations. These are called when ever register fields or memory
>     regions are accessed(i.e. read or written) by OSPM when ever it evaluates
>     various ACPI methods.
> 
> Note: lot of this framework code is inherited from the changes already done for
>        x86 but still some minor changes are required to make it compatible with
>        ARM64.)
> 
> This patch enables the ACPI support for virtual cpu hotplug. ACPI changes
> required will follow in subsequent patches.
> 
> Co-developed-by: Salil Mehta <salil.mehta@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   hw/arm/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 

I assume this patch needs to be moved around to last one, until vCPU hotplug
is supported in the code base.

> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 7e68348440..dae06158cd 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -29,6 +29,7 @@ config ARM_VIRT
>       select ACPI_HW_REDUCED
>       select ACPI_APEI
>       select ACPI_VIOT
> +    select ACPI_CPU_HOTPLUG
>       select VIRTIO_MEM_SUPPORTED
>       select ACPI_CXL
>       select ACPI_HMAT

Thanks,
Gavin


