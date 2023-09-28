Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 891B77B2927
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 01:59:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm0th-0006iI-8B; Thu, 28 Sep 2023 19:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qm0tf-0006i2-6b
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 19:58:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qm0td-00022l-Gv
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 19:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695945496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VX1d3q6Mugy9iSjU/rsXPw/uPvDUi4/RHWQI229dwM8=;
 b=OFj6aPl5eEDTZLk162Zzmll3Zr5BHIl1mkLyCzIZRFDzfu6+NEfTLNS3jBwytno0cVPXpT
 fbCoJhY33+bXBFzDwRh7A3+EONXs9u0h2szBBbm3be/k3AJqq07NT54avvpiSapYE5ONbi
 evGZU5OSTHDarpn5OwClVI36H3U3jqs=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-OHhbKB27MqmdGQBByw2UNQ-1; Thu, 28 Sep 2023 19:58:14 -0400
X-MC-Unique: OHhbKB27MqmdGQBByw2UNQ-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-57cf261194aso15266374a12.3
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 16:58:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695945494; x=1696550294;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VX1d3q6Mugy9iSjU/rsXPw/uPvDUi4/RHWQI229dwM8=;
 b=XDKp3cJ7l/calUTtie44ByNYjHhv2zEvRSP6TELYOGFZb++pPvAVkH2E0fLWbX8lSR
 XWYosyqBW/DY2Gxq7mkwg7Za4JAo0i/zGA9v+9I47hP9Jle+ONheqVdw3J3lYRLaUU4Q
 wc+I2tUqjxo4vNoOwPb53wI8vKq4Yd4qnH+ifVnUzphhjAf8hynorElvLdf7wRgRtlDO
 uiQhUPFtLz6lKbyx+S1TDD/MEeHRcLrVteG1+GCmvUKU/f4kgTvwb8nWGFbxZ+uYCVIu
 WY94aBSO6cPL3kiwgub8fSi9bhFYqJsG5UD4UR9PdqMfVgDOYpF/sfyPt+QQM8qY7IKW
 zGlw==
X-Gm-Message-State: AOJu0Yys9FvrWjvQTejENZkb5c2Ps4aLMTPei+PkmVxNxoRoAgeWKgUY
 PDk6KwfWiOraWBjdN/X0S3usB31lWR8NITRrHDdivQzZJykrKXg04L7Frlflc3X68/dpLYW9oip
 RtiBiRj6hl9+AY8g=
X-Received: by 2002:a05:6a20:8f1d:b0:161:7a0c:3c37 with SMTP id
 b29-20020a056a208f1d00b001617a0c3c37mr2946133pzk.5.1695945493739; 
 Thu, 28 Sep 2023 16:58:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3SSVjGY1dpT+T6jCMPvpHTYsC08M5JC7OVXuaccCgsiAXg/efErQVb+E2zWb3T6FUqL6M8Q==
X-Received: by 2002:a05:6a20:8f1d:b0:161:7a0c:3c37 with SMTP id
 b29-20020a056a208f1d00b001617a0c3c37mr2946120pzk.5.1695945493342; 
 Thu, 28 Sep 2023 16:58:13 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 d24-20020aa78158000000b0068fc2fe4612sm13939445pfn.194.2023.09.28.16.58.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Sep 2023 16:58:12 -0700 (PDT)
Message-ID: <c45acbe4-f454-f6a0-923b-75ca1e790c03@redhat.com>
Date: Fri, 29 Sep 2023 09:57:58 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC V2 23/37] arm/virt: Release objects for *disabled*
 possible vCPUs after init
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
 <20230926100436.28284-24-salil.mehta@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230926100436.28284-24-salil.mehta@huawei.com>
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
> During machvirt_init(), QOM ARMCPU objects are also pre-created along with the
> corresponding KVM vCPUs in the host for all possible vCPUs. This necessary
> because of the architectural constraint, KVM restricts the deferred creation of
> the KVM vCPUs and VGIC initialization/sizing after VM init. Hence, VGIC is
> pre-sized with possible vCPUs.
> 
> After initialization of the machine is complete disabled possible KVM vCPUs are
> then parked at the per-virt-machine list "kvm_parked_vcpus" and we release the
> QOM ARMCPU objects for the disabled vCPUs. These shall be re-created at the time
> when vCPU is hotplugged again. QOM ARMCPU object is then re-attached with
> corresponding parked KVM vCPU.
> 
> Alternatively, we could've never released the QOM CPU objects and kept on
> reusing. This approach might require some modifications of qdevice_add()
> interface to get old ARMCPU object instead of creating a new one for the hotplug
> request.
> 
> Each of the above approaches come with their own pros and cons. This prototype
> uses the 1st approach.(suggestions are welcome!)
> 
> Co-developed-by: Salil Mehta <salil.mehta@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   hw/arm/virt.c | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index f1bee569d5..3b068534a8 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1965,6 +1965,7 @@ static void virt_cpu_post_init(VirtMachineState *vms, MemoryRegion *sysmem)
>   {
>       CPUArchIdList *possible_cpus = vms->parent.possible_cpus;
>       int max_cpus = MACHINE(vms)->smp.max_cpus;
> +    MachineState *ms = MACHINE(vms);
>       bool aarch64, steal_time;
>       CPUState *cpu;
>       int n;
> @@ -2025,6 +2026,37 @@ static void virt_cpu_post_init(VirtMachineState *vms, MemoryRegion *sysmem)
>               }
>           }
>       }
> +
> +    if (kvm_enabled() || tcg_enabled()) {
> +        for (n = 0; n < possible_cpus->len; n++) {
> +            cpu = qemu_get_possible_cpu(n);
> +
> +            /*
> +             * Now, GIC has been sized with possible CPUs and we dont require
> +             * disabled vCPU objects to be represented in the QOM. Release the
> +             * disabled ARMCPU objects earlier used during init for pre-sizing.
> +             *
> +             * We fake to the guest through ACPI about the presence(_STA.PRES=1)
> +             * of these non-existent vCPUs at VMM/qemu and present these as
> +             * disabled vCPUs(_STA.ENA=0) so that they cant be used. These vCPUs
> +             * can be later added to the guest through hotplug exchanges when
> +             * ARMCPU objects are created back again using 'device_add' QMP
> +             * command.
> +             */
> +            /*
> +             * RFC: Question: Other approach could've been to keep them forever
> +             * and release it only once when qemu exits as part of finalize or
> +             * when new vCPU is hotplugged. In the later old could be released
> +             * for the newly created object for the same vCPU?
> +             */
> +            if (!qemu_enabled_cpu(cpu)) {
> +                CPUArchId *cpu_slot;
> +                cpu_slot = virt_find_cpu_slot(ms, cpu->cpu_index);
> +                cpu_slot->cpu = NULL;
> +                object_unref(OBJECT(cpu));
> +            }
> +        }
> +    }
>   }
>   

Needn't we release those CPU instances for hve and qtest? Besides, I think it's
hard for reuse those objects because they're managed by QOM, which is almost
transparent to us, correct?

>   static void virt_cpu_set_properties(Object *cpuobj, const CPUArchId *cpu_slot,

Thanks,
Gavin


