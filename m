Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AF7724DAB
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 22:07:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6cxW-0000FS-Pd; Tue, 06 Jun 2023 16:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q6cxT-0000Eo-TZ
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 16:07:11 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q6cxS-0006Gd-2b
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 16:07:11 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-558cf19575dso1898578eaf.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 13:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1686082028; x=1688674028;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xKcEu3dv0mY6eAIHQim+WNvLUaEv9ghlQ2om/JEW2MU=;
 b=VXh0jcuB1G6lMtiXp6XmthhnoRLZxLlur/oL5Y9DGgxtDL5FbHlZ6ngGWSa8sCdaRJ
 ET0Bg4PYyZ7rov53xI4YwfjnVnsith2id9leve/gxtqC5nHjHpSMTKI0kcnhfNVPBRBl
 ERrHZ7P+WAbwL6TbrU72kBoGvmm+k9Dm3GkFeccZRGerZ7UkOAbsVrdNwa+NgypWTYlp
 WZfbJszx9AyMY36ToL/xsFGnnFB1ygYH1hPIV9VPEu+LyJqEvwRtwhMCMd8U4Ggo9sbk
 EbhLXf2Bys4I69mB2dSncYc1p1HgqEWqxh+AZ1mEkt7GQzKrvkVhS17ToFB89lt5dteY
 dVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686082028; x=1688674028;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xKcEu3dv0mY6eAIHQim+WNvLUaEv9ghlQ2om/JEW2MU=;
 b=DqE47GRqoxCVUb/49kiN0bQD4xGhtchejdiyf0quCCB1bVn7KXkc8QTo3zae7qb6bR
 LwkHODJNSw6hWL6VjymJLK9Yl9+83d+Z5txkqRjwmgwnY0oAAG7BT8FL1gJuR4PnQ/rH
 aGYMEC+iROrYzzKT1pWI7YS5lYsM09Ddyy1YGH732JNor3J5dfDWojaQXRMG05I+gNHA
 R5yE9zSnup9nWLtl6Cv2B2gTxOl12/j6v5S0WFVoBQGWAPqNooZ0TuhnsgNvrbrDqT4k
 jClYOwe96ablJTwNZsdmd4K9f7rUTqqfVMqlGVU6QflFBmOuXBQ6pHpC+yryZqDbcXaW
 9STQ==
X-Gm-Message-State: AC+VfDxt4AyHW/58t154picNkMTpWeZ1l/VoYhOtqWy1ZUkNwuhlpfJm
 T2lmZQmA5HJZVwNt6VX81SZqZA==
X-Google-Smtp-Source: ACHHUZ7n1H6YwWdRdnBZ8sVGIOfWg+bjVY62c8fZKTSBJPsQB8dr5PgghVHqhcUAzd6aGj2/FBHhMA==
X-Received: by 2002:a4a:da55:0:b0:558:c15c:f62e with SMTP id
 f21-20020a4ada55000000b00558c15cf62emr2121316oou.8.1686082028357; 
 Tue, 06 Jun 2023 13:07:08 -0700 (PDT)
Received: from [192.168.68.107] ([177.170.117.52])
 by smtp.gmail.com with ESMTPSA id
 y21-20020a4ae7d5000000b0055af59b4151sm1621548oov.18.2023.06.06.13.07.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jun 2023 13:07:07 -0700 (PDT)
Message-ID: <34b3ad50-7b36-99c3-134f-0a1897e7cffe@ventanamicro.com>
Date: Tue, 6 Jun 2023 17:07:03 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 02/16] hw/riscv/virt.c: skip 'mmu-type' FDT if satp mode
 not set
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com
References: <20230530194623.272652-1-dbarboza@ventanamicro.com>
 <20230530194623.272652-3-dbarboza@ventanamicro.com>
 <20230606-523ed1960aaa8070f5639237@orel>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230606-523ed1960aaa8070f5639237@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc2c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



On 6/6/23 10:13, Andrew Jones wrote:
> On Tue, May 30, 2023 at 04:46:09PM -0300, Daniel Henrique Barboza wrote:
>> The absence of a satp mode in riscv_host_cpu_init() is causing the
>> following error:
>>
>> $ sudo ./qemu/build/qemu-system-riscv64  -machine virt,accel=kvm \
>>      -m 2G -smp 1  -nographic -snapshot \
>>      -kernel ./guest_imgs/Image \
>>      -initrd ./guest_imgs/rootfs_kvm_riscv64.img \
>>      -append "earlycon=sbi root=/dev/ram rw" \
>>      -cpu host
>> **
>> ERROR:../target/riscv/cpu.c:320:satp_mode_str: code should not be
>> reached
>> Bail out! ERROR:../target/riscv/cpu.c:320:satp_mode_str: code should
>> not be reached
>> Aborted
>>
>> The error is triggered from create_fdt_socket_cpus() in hw/riscv/virt.c.
>> It's trying to get satp_mode_str for a NULL cpu->cfg.satp_mode.map.
>>
>> For this KVM 'cpu' we would need to inherit the satp supported modes
>> from the RISC-V host. At this moment this is not possible because the
>> KVM driver does not support it. And even when it does we can't just let
>> this broken for every other older kernel.
>>
>> Skip the 'mmu-type' FDT node if there's no satp_mode set.
> 
> This seems reasonable, since mmu-type is not a required node, according to
> [1], and there's nothing we can put in it, which would be correct, until
> we can get the information from KVM.
> 
> [1] https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/cpu.yaml
> 
>>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   hw/riscv/virt.c | 14 +++++++-------
>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
>> index 4e3efbee16..8aa907e81f 100644
>> --- a/hw/riscv/virt.c
>> +++ b/hw/riscv/virt.c
>> @@ -243,13 +243,13 @@ static void create_fdt_socket_cpus(RISCVVirtState *s, int socket,
>>               s->soc[socket].hartid_base + cpu);
>>           qemu_fdt_add_subnode(ms->fdt, cpu_name);
>>   
>> -        satp_mode_max = satp_mode_max_from_map(
>> -            s->soc[socket].harts[cpu].cfg.satp_mode.map);
>> -        sv_name = g_strdup_printf("riscv,%s",
>> -                                  satp_mode_str(satp_mode_max, is_32_bit));
>> -        qemu_fdt_setprop_string(ms->fdt, cpu_name, "mmu-type", sv_name);
>> -        g_free(sv_name);
>> -
>> +        if (cpu_ptr->cfg.satp_mode.supported != 0) {
>> +            satp_mode_max = satp_mode_max_from_map(cpu_ptr->cfg.satp_mode.map);
>> +            sv_name = g_strdup_printf("riscv,%s",
>> +                                      satp_mode_str(satp_mode_max, is_32_bit));
>> +            qemu_fdt_setprop_string(ms->fdt, cpu_name, "mmu-type", sv_name);
>> +            g_free(sv_name);
>> +        }
>>   
>>           name = riscv_isa_string(cpu_ptr);
>>           qemu_fdt_setprop_string(ms->fdt, cpu_name, "riscv,isa", name);
>> -- 
>> 2.40.1
>>
>>
> 
> Adding a sentence, like what I wrote above, to the commit message in order
> to provide better justification might be nice, but either way
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks! Commit message amended for v2 as follows:


(....)

Since mmu-type is not a required node, according to [1], skip the
'mmu-type' FDT node if there's no satp_mode set. We'll revisit this
logic when we can get satp information from KVM.

[1] https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/cpu.yaml




Daniel


> 
> Thanks,
> drew

