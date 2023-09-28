Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C62187B1020
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 02:42:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlf5R-0006et-Fp; Wed, 27 Sep 2023 20:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qlf5P-0006eT-PO
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 20:40:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qlf5N-0001o9-R4
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 20:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695861657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fx7kCxpZ9MjvNdOhB1WJA/J0BdYu+k99RFDCkPjREH0=;
 b=Woq5lYoXUvpFkWohpuk6MnCK0iS1wAFke2UtEhF0UeK7sQ2NGrBXimqAacJHlCLalEpg8G
 onVukMK8xhVSeC1MC42W989hv8WRMutYTQ1s+YOhFgCI1P2e4+EETvSRbSr8mzynxc0uNk
 APrHca6fJ8YuQnYfjnteRu2oNH5kEjo=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-H1O1uFNzOlWVcHEq71a6Kw-1; Wed, 27 Sep 2023 20:40:55 -0400
X-MC-Unique: H1O1uFNzOlWVcHEq71a6Kw-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-57cf261194aso14219804a12.3
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 17:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695861654; x=1696466454;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fx7kCxpZ9MjvNdOhB1WJA/J0BdYu+k99RFDCkPjREH0=;
 b=JiRYX/gUQKeNrytcM/4nTNoUHVDDAtoJR+fNWx3d6PXAjRG7/eG+3xWlhpetRaL7e0
 4eZEsYgqr8yqWmHgpgT53PWdbUXcpEgesVeJnk9LCwLmQI2fBkxfasnujHTnc1nLHQnE
 71B9JPq/G1Q1ay30OiMkLfPzvLq3NRYL7sCa8wyI0MjlnkFj9TrGelIaejd2Jmn6WJcZ
 RhSroW0TmOlv3cwjhcFktn4nCeYbO5uK3hm/3puhb4rJzNG8v8vmUadaAxK8zhzb0qPX
 CqpWdvwOmeJm5/f5wGwjn4Wp3GJGDnIs8nbUpLChVN8dJEJWA62PC73RzKwUTrZfRhke
 1Q4g==
X-Gm-Message-State: AOJu0Yy9y/RZOYL1uAHxtts45BUMNe35uoHDelzF8aCSjjYIHU+PAOZo
 8FpwEmF06B8U2QwPp5QqTHx8ffFzaAXcM2rrBXcfSSTk34zg1r2wvZbuvzTwHOfyTZbPbSxIFpq
 KpRdvxE6GdIiVHC8=
X-Received: by 2002:a05:6300:808a:b0:10f:be0:4dce with SMTP id
 ap10-20020a056300808a00b0010f0be04dcemr3466635pzc.8.1695861653863; 
 Wed, 27 Sep 2023 17:40:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKHu4YOTM7pMhJKxWf+81l8lU+ec9IC7z7wp06zmBKmAAKvfp4Jxy8591sYzmgO0mHoPB3rg==
X-Received: by 2002:a05:6300:808a:b0:10f:be0:4dce with SMTP id
 ap10-20020a056300808a00b0010f0be04dcemr3466609pzc.8.1695861653618; 
 Wed, 27 Sep 2023 17:40:53 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 gk6-20020a17090b118600b00263cca08d95sm4484265pjb.55.2023.09.27.17.40.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Sep 2023 17:40:53 -0700 (PDT)
Message-ID: <4fb2eef9-6742-1eeb-721a-b3db04b1be97@redhat.com>
Date: Thu, 28 Sep 2023 10:40:40 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC V2 12/37] hw/acpi: Use qemu_present_cpu() API in ACPI
 CPU hotplug init
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
 <20230926100436.28284-13-salil.mehta@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230926100436.28284-13-salil.mehta@huawei.com>
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

Hi Salil,

On 9/26/23 20:04, Salil Mehta wrote:
> ACPI CPU Hotplug code assumes a virtual CPU is unplugged if the CPUState object
> is absent in the list of ths possible CPUs(CPUArchIdList *possible_cpus)
> maintained on per-machine basis. Use the earlier introduced qemu_present_cpu()
> API to check this state.
> 
> This change should have no bearing on the functionality of any architecture and
> is mere a representational change.
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   hw/acpi/cpu.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> index 45defdc0e2..d5ba37b209 100644
> --- a/hw/acpi/cpu.c
> +++ b/hw/acpi/cpu.c
> @@ -225,7 +225,10 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
>       state->dev_count = id_list->len;
>       state->devs = g_new0(typeof(*state->devs), state->dev_count);
>       for (i = 0; i < id_list->len; i++) {
> -        state->devs[i].cpu =  CPU(id_list->cpus[i].cpu);
> +        struct CPUState *cpu = CPU(id_list->cpus[i].cpu);
> +        if (qemu_present_cpu(cpu)) {
> +            state->devs[i].cpu = cpu;
> +        }
>           state->devs[i].arch_id = id_list->cpus[i].arch_id;
>       }
>       memory_region_init_io(&state->ctrl_reg, owner, &cpu_hotplug_ops, state,

I don't think qemu_present_cpu() is needed because all possible vCPUs are present
for x86 and arm64 at this point? Besides, we have the assumption all hotpluggable
vCPUs are present, looking at James' kernel series where ACPI_HOTPLUG_PRESENT_CPU
exists in linux/drivers/acpi/Kconfig :)

Thanks,
Gavin


