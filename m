Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A62BD7B5F51
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 05:18:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnVuJ-0001D3-6D; Mon, 02 Oct 2023 23:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qnVuH-0001Cg-55
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 23:17:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qnVuF-0005it-5Y
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 23:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696303025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=co6wypmiQw2a5aSWkvn2QUY7MVsGOjPIrOjbZiaS4so=;
 b=VbBrHi48MEn/D2CHwG94PdrBN/ePrFOX+1QaZ46gSv+G2+r3Lfqw6GMHPj5S2pCthCfzXt
 PU1FhKut4375iQsFn9UoNqzMp8wqKuzyw2uljNK9yLjR4M6lyp7hfoiJxM5iwx6RvnQmzA
 T2iV6RDin1PrR9lJU6OOxEgPfXuzirg=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-bErvY_nEPe6Uh8Rkd_SIlw-1; Mon, 02 Oct 2023 23:17:04 -0400
X-MC-Unique: bErvY_nEPe6Uh8Rkd_SIlw-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-69341821b3bso381781b3a.1
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 20:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696303023; x=1696907823;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=co6wypmiQw2a5aSWkvn2QUY7MVsGOjPIrOjbZiaS4so=;
 b=W/TxpgoAnxnWmnQa2c4OTRUxScD4mU4tbMvqE1an+08BMZo2UKoN8vnnXU3LwIShR6
 6eh4AWW1AaT698zl/LizzV7hkWJaFsa2rNn42iA2w6hvspovAnK+zpisJcWQEHHq711C
 cXHC0aEnOo6v7WGVgeWzMyaJFHllTZx6wYtjw3ZeibkICNY9i+TyX9lGr56i0PiJy8JR
 xmgM580A2oPss+UIOZKdEfK3kGz/STQh6Se6LD25ajcrntl5/ycBpJ7gGu3LSnA2Hc4A
 cefABDgNTe64O1PZ38lLzIYa9QlRNaneAh/XPdsS+XDNiVPcDA9wN08XYv1g1DXzDY+6
 QPWw==
X-Gm-Message-State: AOJu0Yzu0qH/aysda5yYjaVbTavYRfvLL6Ix+YqveX5kzgLQPUnPd/Fu
 N3gexR/UA7WLEVm+VNvqtpOkYWe+gEJvtJ2JGAye5t0tqTuiN4Cw8ho0K7S6JbQwuoFxiEOwqXc
 BO2jO13sn3Wlk1sI=
X-Received: by 2002:a05:6a20:8f02:b0:140:730b:4b3f with SMTP id
 b2-20020a056a208f0200b00140730b4b3fmr15614155pzk.1.1696303022868; 
 Mon, 02 Oct 2023 20:17:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPR9nXy+O1UzaAJOkeLSG6ZF5Woxhnpp+Gm7Ak2pc9UgG3ax0DtZ1gofQzwR0H+9/ihCEvUw==
X-Received: by 2002:a05:6a20:8f02:b0:140:730b:4b3f with SMTP id
 b2-20020a056a208f0200b00140730b4b3fmr15614106pzk.1.1696303022448; 
 Mon, 02 Oct 2023 20:17:02 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 h14-20020a170902f7ce00b001b9f7bc3e77sm218209plw.189.2023.10.02.20.16.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 20:17:02 -0700 (PDT)
Message-ID: <1b018c9e-fde4-e486-b853-1d516db2d2b2@redhat.com>
Date: Tue, 3 Oct 2023 13:16:49 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V2 09/10] gdbstub: Add helper function to unregister GDB
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
References: <20230930001933.2660-1-salil.mehta@huawei.com>
 <20230930001933.2660-10-salil.mehta@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230930001933.2660-10-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.321, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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


On 9/30/23 10:19, Salil Mehta wrote:
> Add common function to help unregister the GDB Register Space. This shall be
> done in context to the CPU unrealization.
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   gdbstub/gdbstub.c      | 14 ++++++++++++++
>   include/exec/gdbstub.h |  5 +++++
>   2 files changed, 19 insertions(+)
> 

With the following nits addressed:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index 349d348c7b..89ac0edfea 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -491,6 +491,20 @@ void gdb_register_coprocessor(CPUState *cpu,
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
                                      ^^^
                                      string so that it needn't be freed
> +        g_free(s);
> +    }
> +    cpu->gdb_regs = NULL;
> +}
> +

For consistency, CPUState::gdb_num_regs and CPUState::gdb_num_g_regs
need to be updated accordingly, even the CPU instance will be destroyed
shortly.

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


