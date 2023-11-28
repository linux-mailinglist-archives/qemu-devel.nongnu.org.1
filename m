Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 560447FB61E
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 10:43:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7ucp-0000TR-15; Tue, 28 Nov 2023 04:43:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7ucm-0000SY-Ga
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 04:43:24 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7uck-000309-Qs
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 04:43:24 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-54bb9024378so223866a12.3
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 01:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701164601; x=1701769401; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X2UmEudICUsl9z+oIELO7zxS+xZLb9OLSjs0VmBtRJM=;
 b=PITx30J0Cpf7KND9octGxKIG5O34FvLO3pcLA+CxSWygYvE0x/1PcyGAIyCophE6l5
 d4RVwXlO2aLANMkMaC+I1uzbpklI/Je6/KnV8y6eFUplZwQlBD3oHwumoaJyXhKtMkb/
 s4XhKQTeeVxVd6HzEyVXtjQ/mhonKa190q191ydacqzTS1CHnIQLl3p/au+LFxqnHtIH
 XusXXoS6AXD8jvkjUlj5CsS5YVLXuX9lxlNBCkfo2QstOFxKNrvZyZV/5V5AvMzWNriD
 eycuxyg8bibVyXt55l4J4YOeLNuxYh1T9ziSUf2vSgnlI6dGLzqITT7ZUH5h79g4j6V9
 3tPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701164601; x=1701769401;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X2UmEudICUsl9z+oIELO7zxS+xZLb9OLSjs0VmBtRJM=;
 b=pFlaQ0hhi7auQw8sBhPDtPZ+m5V4p06KPdtocy5HkXueYtPMZ2qiABK8Rckqu571Ha
 tDDxQxyppU1Bv8Ab1f4ZZLiB1buwA8MRgHHI+fSoxz20lz0uOE7zBMrEKR5he6ECWFZ3
 OGeXW0iz14Mn6oF4bniYkl0XMF6Wcf+D2o4nyAbNT4g1Gzg6Pfb3VhJXxr9PiezJOedB
 K4cZYnwKO1Iz82bMB77Dg1IzlcPzQeL/0uynRvnNbu+kK0Yp2TIOO9BFd/UnXR69AEhq
 lNk2wr7+7bjWItQs2D/AvlLPmWOh9BHmpQ2rQzMPR5HcDt1BaffKYfzYROg+ob3Ma+ZJ
 sZyw==
X-Gm-Message-State: AOJu0YxkjbGbSN4b5MasSaaIAQre7lh1NQdwrYt3hHwQ4eEpmgZxtLYQ
 NpxDcqGxjwyteVA65SuIxv1f3w==
X-Google-Smtp-Source: AGHT+IFUQKPtirytLbJEO+gRu6TxdBopLMQIpRUqxGEIHbIqi4wjsrufPIN4qZn6pwm/OmXH1EGcnA==
X-Received: by 2002:a05:6402:f19:b0:54b:4067:627e with SMTP id
 i25-20020a0564020f1900b0054b4067627emr6556065eda.8.1701164601103; 
 Tue, 28 Nov 2023 01:43:21 -0800 (PST)
Received: from [192.168.69.100] (crb44-h02-176-184-13-61.dsl.sta.abo.bbox.fr.
 [176.184.13.61]) by smtp.gmail.com with ESMTPSA id
 cb6-20020a0564020b6600b0054b63229d66sm2180384edb.66.2023.11.28.01.43.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 01:43:20 -0800 (PST)
Message-ID: <013fb5f5-8281-4f7a-83c8-ac22f845297b@linaro.org>
Date: Tue, 28 Nov 2023 10:43:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/8] machine: Use error handling when CPU type is
 checked
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, richard.henderson@linaro.org,
 quic_llindhol@quicinc.com, b.galvani@gmail.com,
 strahinja.p.jankovic@gmail.com, kfting@nuvoton.com, wuhaotsh@google.com,
 nieklinnenbank@gmail.com, rad@semihalf.com, marcin.juszkiewicz@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, wangyanan55@huawei.com,
 vijai@behindbytes.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, shan.gavin@gmail.com
References: <20231126231210.112820-1-gshan@redhat.com>
 <20231126231210.112820-2-gshan@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231126231210.112820-2-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Gavin,

On 27/11/23 00:12, Gavin Shan wrote:
> QEMU will be terminated if the specified CPU type isn't supported
> in machine_run_board_init(). The list of supported CPU type names
> is tracked by mc->valid_cpu_types.
> 
> The error handling can be used to propagate error messages, to be
> consistent how the errors are handled for other situations in the
> same function.
> 
> No functional change intended.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
> v7: Add 'return' after error_propagate() to avoid calling into
>      mc->init() in the failing case                        (Marcin)
> ---
>   hw/core/machine.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 0c17398141..b3ef325936 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -1394,6 +1394,7 @@ void machine_run_board_init(MachineState *machine, const char *mem_path, Error *
>       MachineClass *machine_class = MACHINE_GET_CLASS(machine);
>       ObjectClass *oc = object_class_by_name(machine->cpu_type);
>       CPUClass *cc;
> +    Error *local_err = NULL;

IIUC the big comment in "include/qapi/error.h", since commit ae7c80a7bd
("error: New macro ERRP_GUARD()") we want to use the new macro instead.

>       /* This checkpoint is required by replay to separate prior clock
>          reading from the other reads, because timer polling functions query
> @@ -1466,15 +1467,17 @@ void machine_run_board_init(MachineState *machine, const char *mem_path, Error *
>   
>           if (!machine_class->valid_cpu_types[i]) {
>               /* The user specified CPU is not valid */
> -            error_report("Invalid CPU type: %s", machine->cpu_type);
> -            error_printf("The valid types are: %s",
> -                         machine_class->valid_cpu_types[0]);
> +            error_setg(&local_err, "Invalid CPU type: %s", machine->cpu_type);
> +            error_append_hint(&local_err, "The valid types are: %s",
> +                              machine_class->valid_cpu_types[0]);
>               for (i = 1; machine_class->valid_cpu_types[i]; i++) {
> -                error_printf(", %s", machine_class->valid_cpu_types[i]);
> +                error_append_hint(&local_err, ", %s",
> +                                  machine_class->valid_cpu_types[i]);
>               }
> -            error_printf("\n");
> +            error_append_hint(&local_err, "\n");
>   
> -            exit(1);
> +            error_propagate(errp, local_err);
> +            return;
>           }
>       }
>   


