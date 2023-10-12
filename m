Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D56697C616A
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 02:08:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqjFe-0007Gh-Pe; Wed, 11 Oct 2023 20:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qqjFc-0007GY-Av
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 20:08:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qqjFa-0001Dg-RY
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 20:08:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697069249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hUf8E+eMs0QyN33MJTQzm2FGUE5kLHOwk8wWC8IMkGM=;
 b=hvpZqIKImnVKbGwzEPo4aK8f8lBWXZVDzfbGsrRby8S00ujv1WzJlgEFaYoKm8PbRnf3Vq
 /K42bUYJb2S+JY3r02QgRuINa9xb4sOwxFZAao8BqfElXYKUi82E5SCc0yFQ8RxrKjzjzx
 I0l4xj4jwB/kOvGtgka7XWPAzqoyXL8=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-rTLW1PSLNoSQWMpyxouYwA-1; Wed, 11 Oct 2023 20:07:27 -0400
X-MC-Unique: rTLW1PSLNoSQWMpyxouYwA-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1c9b1ce8e82so3373005ad.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 17:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697069246; x=1697674046;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hUf8E+eMs0QyN33MJTQzm2FGUE5kLHOwk8wWC8IMkGM=;
 b=urWWdPjgCWLHpWNY1TdwuOYmp3XPoSdSRscE9qkOA7eSC9LaYxrI4HFWZHKitOPC9m
 NlgabwZCG89r8iVQ0joWI3Tx4nDyA2WMr2IZ/Q9SqckaQLZ2413ZQAQa+5nOCp91njPX
 OtllCSF0ZL2BHuFkrohgIW1WHLld248+v2sKET7i0s1hb0/HQc4QN27rwurHjJOZFQZp
 aO0Tuar7ceAx2WE6PyEl6T17fY9Vs8k6HByhTbPnWQta323lTEFHp+fq0BRL9i4ZpL23
 0YPxZ9/X8GpqVYrpnXaiTQbw5IrxnBm7AOLjA10BaF+w58Ya5gXEn571728DED6e2tLZ
 Fy2w==
X-Gm-Message-State: AOJu0Yyx80kV1GpZugDOLtPTUtSHEAghy+9Ny6+y2pCXLrxl70r80sCH
 WnfkTeNcpE7kWJ/LnDC6WgeRePzQculzczCpOuWkxNuixfslDJ/QRnq3sl09DqnU4QhElE/i3WD
 ZQItgmTxwljM4XzE=
X-Received: by 2002:a17:902:d508:b0:1c8:77f2:7d03 with SMTP id
 b8-20020a170902d50800b001c877f27d03mr26336796plg.45.1697069246382; 
 Wed, 11 Oct 2023 17:07:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGP0yveQ81B690MOF/DcMKuj+gHdqdeuhYlWVGx2TZNOYkbC1tBmzG7bal2C6SdmzCbmpETgg==
X-Received: by 2002:a17:902:d508:b0:1c8:77f2:7d03 with SMTP id
 b8-20020a170902d50800b001c877f27d03mr26336765plg.45.1697069246113; 
 Wed, 11 Oct 2023 17:07:26 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15?
 ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
 by smtp.gmail.com with ESMTPSA id
 iy3-20020a170903130300b001bf11cf2e21sm450493plb.210.2023.10.11.17.07.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 17:07:25 -0700 (PDT)
Message-ID: <ca79ed5f-b807-10eb-8f79-c2def1ab028f@redhat.com>
Date: Thu, 12 Oct 2023 10:07:12 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V5 9/9] gdbstub: Add helper function to unregister GDB
 register space
Content-Language: en-US
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com,
 oliver.upton@linux.dev, pbonzini@redhat.com, mst@redhat.com,
 will@kernel.org, rafael@kernel.org, alex.bennee@linaro.org,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 karl.heubaum@oracle.com, miguel.luis@oracle.com, salil.mehta@opnsrc.net,
 zhukeqian1@huawei.com, wangxiongfeng2@huawei.com, wangyanan55@huawei.com,
 jiakernel2@gmail.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 linuxarm@huawei.com
References: <20231011194355.15628-1-salil.mehta@huawei.com>
 <20231011194355.15628-10-salil.mehta@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231011194355.15628-10-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
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

Hi Salil,

On 10/12/23 05:43, Salil Mehta wrote:
> Add common function to help unregister the GDB Register Space. This shall be
> done in context to the CPU unrealization.
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> ---
>   gdbstub/gdbstub.c      | 15 +++++++++++++++
>   include/exec/gdbstub.h |  5 +++++
>   2 files changed, 20 insertions(+)
> 

With the following nits addressed:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index 349d348c7b..97b89e2d00 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -491,6 +491,21 @@ void gdb_register_coprocessor(CPUState *cpu,
>       }
>   }
>   
> +void gdb_unregister_coprocessor_all(CPUState *cpu)
> +{
> +    GDBRegisterState *s, *p;
> +
> +    p = cpu->gdb_regs;
> +    while (p) {
> +        s = p;
> +        p = p->next;
> +        /* s->xml is static const char so isn't freed */
> +        g_free(s);
> +    }
> +    cpu->gdb_regs = NULL;

        cpu->base_reg = 0;
        cpu->num_regs = 0;

> +    cpu->gdb_num_g_regs = 0;
> +}
> +
>   static void gdb_process_breakpoint_remove_all(GDBProcess *p)
>   {
>       CPUState *cpu = gdb_get_first_cpu_in_process(p);
> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
> index 16a139043f..7d1368d377 100644
> --- a/include/exec/gdbstub.h
> +++ b/include/exec/gdbstub.h
> @@ -27,6 +27,11 @@ typedef int (*gdb_set_reg_cb)(CPUArchState *env, uint8_t *buf, int reg);
>   void gdb_register_coprocessor(CPUState *cpu,
>                                 gdb_get_reg_cb get_reg, gdb_set_reg_cb set_reg,
>                                 int num_regs, const char *xml, int g_pos);
> +/**
> + * gdb_unregister_coprocessor_all() - unregisters supplemental set of registers
> + * @cpu - the CPU associated with registers
> + */
> +void gdb_unregister_coprocessor_all(CPUState *cpu);
>   
>   /**
>    * gdbserver_start: start the gdb server

Thanks,
Gavin


