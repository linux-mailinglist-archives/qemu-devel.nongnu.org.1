Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0D77B2995
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 02:32:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm1PW-0003Ju-CP; Thu, 28 Sep 2023 20:31:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qm1PP-0003BJ-8r
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 20:31:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qm1PM-0003nY-8n
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 20:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695947463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1jON6KnKuRGTS+epyAPrMxGaBZT5dsCo52ZyZXffhw8=;
 b=fbiu9UH6i87Yss7C/YWkDZ/s96RK8PmPq0Uuqc0GZ8hJIn91Wtf+PKrSRoEixGeIPKG9fS
 fAVGfh5xcGM6HBqO8mmzULelJ7cVI705hTaoF5zV4TGNrRBNnO8FXs9RemH8GRlS97nVOA
 y4belOteEGgaEX5Wivf9qxQMXoRSUIA=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-sVAYt81zMGeXbkJxojvbwA-1; Thu, 28 Sep 2023 20:31:01 -0400
X-MC-Unique: sVAYt81zMGeXbkJxojvbwA-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-690bcc80694so16127850b3a.3
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 17:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695947460; x=1696552260;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1jON6KnKuRGTS+epyAPrMxGaBZT5dsCo52ZyZXffhw8=;
 b=tim2zejKbCyMnGQ14ep+PZ99pmpbjtXFlsPHaUPtRnarsdQPhUQRFZ4ryl2+7qCJOx
 VwPxuXi1JkdSZfto17Un7SwEhxZ17rND7GgdeqeUO1sIfhvyP/YUjmWqjmCTYzeJjIDc
 +34zlJyAFT/3mxbLaeIIjmdERwvhalUmWZ6iSNBSrGEJMrU63q8tCa+FaJETAnCAxCFU
 rt/MlzCx9bxq4Gh7JZVyptZZjCFTDX87zIKUPk5UIw1WI1bgNDu6FJ4d22uC+U3Y8Ihp
 YEt4z65kcrwt53fy6knpeiI2532DF7xew82moluCbCDecOolWdm2wL744xKULS2ZBkHb
 0dJA==
X-Gm-Message-State: AOJu0Ywz+FrZdSm+e78+L1u5LYjOR/a5Q7o/GLkxhIQ/QJu2U94G/7Zu
 PMA50B/d4iH7529vibJLgDc+n9RYI24MRghVGozXhMX53lFdhkQK3v60sCMrlIT9x47VY7WfXlk
 uyjzVEtuJOW60BpA=
X-Received: by 2002:a05:6a21:3d8d:b0:140:a25:1c1d with SMTP id
 bj13-20020a056a213d8d00b001400a251c1dmr2898201pzc.51.1695947459917; 
 Thu, 28 Sep 2023 17:30:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/AoJoNtvjL+Syf1ojD3Iar2W+VAg/lzv3/BXtJ389dZ1ni6Dl4mRcemUdkGKrJqWjYSGPlw==
X-Received: by 2002:a05:6a21:3d8d:b0:140:a25:1c1d with SMTP id
 bj13-20020a056a213d8d00b001400a251c1dmr2898156pzc.51.1695947459583; 
 Thu, 28 Sep 2023 17:30:59 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 9-20020a17090a018900b002772faee740sm180884pjc.5.2023.09.28.17.30.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Sep 2023 17:30:59 -0700 (PDT)
Message-ID: <4d8980ac-f402-60d4-fe52-787815af8a7d@redhat.com>
Date: Fri, 29 Sep 2023 10:30:45 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC V2 29/37] arm/virt: Update the guest(via GED) about
 CPU hot-(un)plug events
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
 <20230926100436.28284-30-salil.mehta@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230926100436.28284-30-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
> During any vCPU hot-(un)plug, running guest VM needs to be intimated about the
> new vCPU being added or request the deletion of the vCPU which is already part
> of the guest VM. This is done using the ACPI GED event which eventually gets
> demultiplexed to a CPU hotplug event and further to specific hot-(un)plug event
> of a particular vCPU.
> 
> This change adds the ACPI calls to the existing hot-(un)plug hooks to trigger
> ACPI GED events from QEMU to guest VM.
> 
> Co-developed-by: Salil Mehta <salil.mehta@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   hw/arm/virt.c | 33 ++++++++++++++++++++++++++++++---
>   1 file changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index b447e86fb6..6f5ee4a1c6 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -3157,6 +3157,7 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>       VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
>       MachineState *ms = MACHINE(hotplug_dev);
>       CPUState *cs = CPU(dev);
> +    Error *local_err = NULL;
>       CPUArchId *cpu_slot;
>   
>       /* insert the cold/hot-plugged vcpu in the slot */
> @@ -3169,12 +3170,20 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>        * plugged, guest is also notified.
>        */
>       if (vms->acpi_dev) {
> -        /* TODO: update acpi hotplug state. Send cpu hotplug event to guest */
> +        HotplugHandlerClass *hhc;
> +        /* update acpi hotplug state and send cpu hotplug event to guest */
> +        hhc = HOTPLUG_HANDLER_GET_CLASS(vms->acpi_dev);
> +        hhc->plug(HOTPLUG_HANDLER(vms->acpi_dev), dev, &local_err);
> +        if (local_err) {
> +            goto fail;
> +        }
>           /* TODO: register cpu for reset & update F/W info for the next boot */
>       }
>   
>       cs->disabled = false;
>       return;
> +fail:
> +    error_propagate(errp, local_err);
>   }
>   

'fail' tag isn't needed since it's used for once. we can bail early:

     if (local_err) {
        error_propagate(errp, local_err);
        return;
     }

>   static void virt_cpu_unplug_request(HotplugHandler *hotplug_dev,
> @@ -3182,8 +3191,10 @@ static void virt_cpu_unplug_request(HotplugHandler *hotplug_dev,
>   {
>       MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
>       VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
> +    HotplugHandlerClass *hhc;
>       ARMCPU *cpu = ARM_CPU(dev);
>       CPUState *cs = CPU(dev);
> +    Error *local_err = NULL;
>   
>       if (!vms->acpi_dev || !dev->realized) {
>           error_setg(errp, "GED does not exists or device is not realized!");
> @@ -3202,9 +3213,16 @@ static void virt_cpu_unplug_request(HotplugHandler *hotplug_dev,
>           return;
>       }
>   
> -    /* TODO: request cpu hotplug from guest */
> +    /* request cpu hotplug from guest */
> +    hhc = HOTPLUG_HANDLER_GET_CLASS(vms->acpi_dev);
> +    hhc->unplug_request(HOTPLUG_HANDLER(vms->acpi_dev), dev, &local_err);
> +    if (local_err) {
> +        goto fail;
> +    }
>   
>       return;
> +fail:
> +    error_propagate(errp, local_err);
>   }
>   

Same as above, 'fail' tag isn't needed. Besides, 'return' isn't needed.

>   static void virt_cpu_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
> @@ -3212,7 +3230,9 @@ static void virt_cpu_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>   {
>       VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
>       MachineState *ms = MACHINE(hotplug_dev);
> +    HotplugHandlerClass *hhc;
>       CPUState *cs = CPU(dev);
> +    Error *local_err = NULL;
>       CPUArchId *cpu_slot;
>   
>       if (!vms->acpi_dev || !dev->realized) {
> @@ -3222,7 +3242,12 @@ static void virt_cpu_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>   
>       cpu_slot = virt_find_cpu_slot(ms, cs->cpu_index);
>   
> -    /* TODO: update the acpi cpu hotplug state for cpu hot-unplug */
> +    /* update the acpi cpu hotplug state for cpu hot-unplug */
> +    hhc = HOTPLUG_HANDLER_GET_CLASS(vms->acpi_dev);
> +    hhc->unplug(HOTPLUG_HANDLER(vms->acpi_dev), dev, &local_err);
> +    if (local_err) {
> +        goto fail;
> +    }
>   
>       unwire_gic_cpu_irqs(vms, cs);
>       virt_update_gic(vms, cs);
> @@ -3236,6 +3261,8 @@ static void virt_cpu_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>       cs->disabled = true;
>   
>       return;
> +fail:
> +    error_propagate(errp, local_err);
>   }
>   

Same as above.

>   static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,

Thanks,
Gavin


