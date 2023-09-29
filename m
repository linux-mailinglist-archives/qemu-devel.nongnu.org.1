Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6E37B2AED
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 06:25:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm52V-0006wf-Ir; Fri, 29 Sep 2023 00:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qm52T-0006wI-U9
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 00:23:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qm52S-00049r-1b
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 00:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695961418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dzhL7jilBDvHg4CP/rvpSpnkZqN+PsVSUYT8fj0BnkU=;
 b=GVXqpfvCq+g/qCZAkbL78paxe/L8xt1hqS06zz9ZHxRnohc6G/q9x8GM9Ttcbz9RBJNR+A
 etomDxLS5yKxBCxVdlW7Hd3FE2tmVhfSjOd3j4wC6+DJByKrl/TaQoqfCMeMDHd/NhDW8j
 gHPwqfubrnMs5imRQvkfIDcGNG00Ink=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-GyS4yhuYPq6mH8tsPtoXog-1; Fri, 29 Sep 2023 00:23:37 -0400
X-MC-Unique: GyS4yhuYPq6mH8tsPtoXog-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-573fdb618eeso17829187a12.0
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 21:23:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695961415; x=1696566215;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dzhL7jilBDvHg4CP/rvpSpnkZqN+PsVSUYT8fj0BnkU=;
 b=IEaOZ9xczNoEAiGAuU04m5FBSlJSI0TcHZjOmQ+Bt1TkeMQ1pQLblCmHjP1abpk2Jx
 KCVoF6zAXIyXDRSi14OVh3mKhTY+aPnfMVWTXYeCOcY78gXEpeEO4Mfeb2kED106/G2X
 0eVv62c1UI/wS71y67nr8RdPcDoz7Bmo5nTr2hqIoWNA/8saFnv+kAA+008S6O7K3SEv
 /Q7AIgBgz0gxyBwqrhfF9HiKjcMpHocTkSkhM0vtOc4EkA8Wcso9ZqmFB17dfYTq52fA
 UO9JEiTgrcIoVJfcbn5GpU/NnqzCQKXmPLvg5nrWKl17pud2Dc8Ym2HuIzNCAKebEEnY
 JKxA==
X-Gm-Message-State: AOJu0YyaBtHe1W+x5cCHIByMnh1Gb1bWnX2qCP6wtKEP469oognbQ3XM
 y6uSkJSYrIq+tNrM1stcIMZdCJAt2Fs9kM2X84RPpqDkoX8nsWKCa++Y/1NltE9W1J2FMb/HzjA
 32VLh68pgO+mn6I8=
X-Received: by 2002:a05:6a20:1604:b0:14c:d494:77c5 with SMTP id
 l4-20020a056a20160400b0014cd49477c5mr3490155pzj.13.1695961415660; 
 Thu, 28 Sep 2023 21:23:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEptO08s8w01BgFofN3aVKBAy2B/W24PBc7JiNi9wyWYMy+ZayJNF6uGJc2BglOSe4HT2b+FQ==
X-Received: by 2002:a05:6a20:1604:b0:14c:d494:77c5 with SMTP id
 l4-20020a056a20160400b0014cd49477c5mr3490145pzj.13.1695961415398; 
 Thu, 28 Sep 2023 21:23:35 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 p7-20020a170902e74700b001bf6ea340b3sm15851672plf.116.2023.09.28.21.23.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Sep 2023 21:23:34 -0700 (PDT)
Message-ID: <ddbc526e-bba3-6b93-753f-6ba3de183755@redhat.com>
Date: Fri, 29 Sep 2023 14:23:21 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC V2 35/37] hw/arm: Support hotplug capability check
 using _OSC method
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
 <20230926103654.34424-1-salil.mehta@huawei.com>
 <20230926103654.34424-4-salil.mehta@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230926103654.34424-4-salil.mehta@huawei.com>
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

On 9/26/23 20:36, Salil Mehta wrote:
> Physical CPU hotplug results in (un)setting of ACPI _STA.Present bit. AARCH64
> platforms do not support physical CPU hotplug. Virtual CPU hotplug support being
> implemented toggles ACPI _STA.Enabled Bit to achieve hotplug functionality. This
> is not same as physical CPU hotplug support.
> 
> In future, if ARM architecture supports physical CPU hotplug then the current
> design of virtual CPU hotplug can be used unchanged. Hence, there is a need for
> firmware/VMM/Qemu to support evaluation of platform wide capabilitiy related to
> the *type* of CPU hotplug support present on the platform. OSPM might need this
> during boot time to correctly initialize the CPUs and other related components
> in the kernel.
> 
> NOTE: This implementation will be improved to add the support of *query* in the
> subsequent versions. This is very minimal support to assist kernel.
> 
> ASL for the implemented _OSC method:
> 
> Method (_OSC, 4, NotSerialized)  // _OSC: Operating System Capabilities
> {
>      CreateDWordField (Arg3, Zero, CDW1)
>      If ((Arg0 == ToUUID ("0811b06e-4a27-44f9-8d60-3cbbc22e7b48") /* Platform-wide Capabilities */))
>      {
>          CreateDWordField (Arg3, 0x04, CDW2)
>          Local0 = CDW2 /* \_SB_._OSC.CDW2 */
>          If ((Arg1 != One))
>          {
>              CDW1 |= 0x08
>          }
> 
>          Local0 &= 0x00800000
>          If ((CDW2 != Local0))
>          {
>              CDW1 |= 0x10
>          }
> 
>          CDW2 = Local0
>      }
>      Else
>      {
>          CDW1 |= 0x04
>      }
> 
>      Return (Arg3)
> }
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   hw/arm/virt-acpi-build.c | 52 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 52 insertions(+)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index cbccd2ca2d..377450dd16 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -861,6 +861,55 @@ static void build_fadt_rev6(GArray *table_data, BIOSLinker *linker,
>       build_fadt(table_data, linker, &fadt, vms->oem_id, vms->oem_table_id);
>   }
>   
> +static void build_virt_osc_method(Aml *scope, VirtMachineState *vms)
> +{
> +    Aml *if_uuid, *else_uuid, *if_rev, *if_caps_masked, *method;
> +    Aml *a_cdw1 = aml_name("CDW1");
> +    Aml *a_cdw2 = aml_local(0);
> +
> +    method = aml_method("_OSC", 4, AML_NOTSERIALIZED);
> +    aml_append(method, aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
> +
> +    /* match UUID */
> +    if_uuid = aml_if(aml_equal(
> +        aml_arg(0), aml_touuid("0811B06E-4A27-44F9-8D60-3CBBC22E7B48")));
> +
> +    aml_append(if_uuid, aml_create_dword_field(aml_arg(3), aml_int(4), "CDW2"));
> +    aml_append(if_uuid, aml_store(aml_name("CDW2"), a_cdw2));
> +
> +    /* check unknown revision in arg(1) */
> +    if_rev = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(1))));
> +    /* set revision error bits,  DWORD1 Bit[3] */
> +    aml_append(if_rev, aml_or(a_cdw1, aml_int(0x08), a_cdw1));
> +    aml_append(if_uuid, if_rev);
> +
> +    /*
> +     * check support for vCPU hotplug type(=enabled) platform-wide capability
> +     * in DWORD2 as sepcified in the below ACPI Specification ECR,
> +     *  # https://bugzilla.tianocore.org/show_bug.cgi?id=4481
> +     */
> +    if (vms->acpi_dev) {
> +        aml_append(if_uuid, aml_and(a_cdw2, aml_int(0x800000), a_cdw2));
> +        /* check if OSPM specified hotplug capability bits were masked */
> +        if_caps_masked = aml_if(aml_lnot(aml_equal(aml_name("CDW2"), a_cdw2)));
> +        aml_append(if_caps_masked, aml_or(a_cdw1, aml_int(0x10), a_cdw1));
> +        aml_append(if_uuid, if_caps_masked);
> +    }
> +    aml_append(if_uuid, aml_store(a_cdw2, aml_name("CDW2")));
> +
> +    aml_append(method, if_uuid);
> +    else_uuid = aml_else();
> +
> +    /* set unrecognized UUID error bits, DWORD1 Bit[2] */
> +    aml_append(else_uuid, aml_or(a_cdw1, aml_int(4), a_cdw1));
> +    aml_append(method, else_uuid);
> +
> +    aml_append(method, aml_return(aml_arg(3)));
> +    aml_append(scope, method);
> +
> +    return;
> +}
> +

The check on vms->acpi_dev seems not enough. We may still need to check
mc->has_hotpluggable_cpus and vms->gic_version etc. Besides, the "return"
at end of the function isn't needed.

>   /* DSDT */
>   static void
>   build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> @@ -894,6 +943,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>       } else {
>           acpi_dsdt_add_cpus(scope, vms);
>       }
> +
> +    build_virt_osc_method(scope, vms);
> +
>       acpi_dsdt_add_uart(scope, &memmap[VIRT_UART],
>                          (irqmap[VIRT_UART] + ARM_SPI_BASE));
>       if (vmc->acpi_expose_flash) {

Thanks,
Gavin


