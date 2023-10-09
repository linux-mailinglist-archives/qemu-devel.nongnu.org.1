Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B68557BDBA9
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 14:23:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qppHr-0004f0-Vr; Mon, 09 Oct 2023 08:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qppHp-0004eQ-57
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 08:23:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qppHm-0002SH-Aj
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 08:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696854176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uEpEKIcndJ+QJ3qnnKHjn6/D4+pUwlcjD6PqX45pKzw=;
 b=ZmHGmrfKvBl6WFu+FibMEwPyrEG06PZjzLO5kjtYj00z6nhDDLatW+pPBvATuK8OSJb94r
 0iXntLBZIb0BAh7J4F1KkxitRxAxkiehZSUTxPGbcSy+DgIhVuyDFTHA/IyKF+7kFbHOFQ
 yNjRdkMNG+BmnADmem6waNvfzz0cg2E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-WWqeVvQtOv-XRJ6e6CTa7w-1; Mon, 09 Oct 2023 08:22:38 -0400
X-MC-Unique: WWqeVvQtOv-XRJ6e6CTa7w-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-326f05ed8f9so3305857f8f.0
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 05:22:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696854157; x=1697458957;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uEpEKIcndJ+QJ3qnnKHjn6/D4+pUwlcjD6PqX45pKzw=;
 b=iseLgllLUh2K7+0SBxAWfKS2+spNBAk4O701we8k8EDA7uvnW+UjDme3xJvYL/rAQx
 DdD8FH+khcuppcvzzORoikV/B8VAxQDmwR97Cs73iYvw+8QCeuRToLYRjNkU9lpL5HKn
 xhRq86H8FKjQNmS2m4xJ4Nc31MPHBF8NlMxHsnU3xfhNNZYSen+2wJu4trZOXyh1Gdh8
 5yXBq5mvgnKz6raNajqgv9SIxdYWovjYbzFdeKAVBoLyV+606blIkTsZcCK3ej6QtFsn
 og6Zg4V135bZ0MhNZU8x32l7SE/QuKuIBMVSfQheEggxrFEzBYTESiH5NwAQR8DXFCa8
 klUQ==
X-Gm-Message-State: AOJu0YwnzaWvD6zN37hDCN+GAXV+tYZGfHKNVqV9wr2TqNybESFXAr6V
 wKhxEPf4MNF1MB+YbDzZ+wxnDZFfDYyWguWyhb7BfQnJ4G58r8NUIs/oA8ZQfTXYz4rQ/jHIIzI
 lRkVzzpJaDCSI4sIpcMXKwDQ=
X-Received: by 2002:a5d:60d1:0:b0:31f:d8ba:c997 with SMTP id
 x17-20020a5d60d1000000b0031fd8bac997mr13335944wrt.41.1696854156816; 
 Mon, 09 Oct 2023 05:22:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5ecHiTMY/BqM+z9AcKw1hAfrydNGiTMnrYlx58wh1wUXNdSm8w8GQUMBsNVAdX1np3G+b5Q==
X-Received: by 2002:a5d:60d1:0:b0:31f:d8ba:c997 with SMTP id
 x17-20020a5d60d1000000b0031fd8bac997mr13335923wrt.41.1696854156395; 
 Mon, 09 Oct 2023 05:22:36 -0700 (PDT)
Received: from ?IPV6:2003:cb:c733:6400:ae10:4bb7:9712:8548?
 (p200300cbc7336400ae104bb797128548.dip0.t-ipconnect.de.
 [2003:cb:c733:6400:ae10:4bb7:9712:8548])
 by smtp.gmail.com with ESMTPSA id
 k7-20020a5d66c7000000b0031fd849e797sm9502071wrw.105.2023.10.09.05.22.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 05:22:35 -0700 (PDT)
Message-ID: <8a80612f-07d3-6302-31f9-232d9ce393a1@redhat.com>
Date: Mon, 9 Oct 2023 14:22:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V3 03/10] hw/acpi: Add ACPI CPU hotplug init stub
Content-Language: en-US
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 philmd@linaro.org, eric.auger@redhat.com, oliver.upton@linux.dev,
 pbonzini@redhat.com, mst@redhat.com, will@kernel.org, gshan@redhat.com,
 rafael@kernel.org, alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, linuxarm@huawei.com
References: <20231009112812.10612-1-salil.mehta@huawei.com>
 <20231009112812.10612-4-salil.mehta@huawei.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20231009112812.10612-4-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 09.10.23 13:28, Salil Mehta wrote:
> ACPI CPU hotplug related initialization should only happen if ACPI_CPU_HOTPLUG
> support has been enabled for particular architecture. Add cpu_hotplug_hw_init()
> stub to avoid compilation break.
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
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

While at it, can we prefix that function with acpi?

-- 
Cheers,

David / dhildenb


