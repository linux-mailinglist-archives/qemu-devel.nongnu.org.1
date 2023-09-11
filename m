Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFFB79AC0C
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 00:42:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfpaG-0005jV-10; Mon, 11 Sep 2023 18:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qfpaE-0005hh-5W
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 18:40:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qfpa9-0006Jd-7E
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 18:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694472036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9jsh/ygEfJhVGAYXcW+fsIqXOFyWRWwqCGx99xPmbqw=;
 b=QmCQlBAVmjbqe30DX9aIafBszMpfa6TdYVbx6GT1REHdpZbyTcq8hXFCHtBaz3STD9sPlP
 x/zQUZY69bvuoFTO03Z1ZhGa9diPHihPcKr9+JWgCAcG/GyM+253lbH0hi9PUxqO3Iz18G
 s5S30DRWls8JoaCy5asVvtpGjAPQg6I=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-tnx2y8NvMbq7kCv5MQNNiw-1; Mon, 11 Sep 2023 18:40:34 -0400
X-MC-Unique: tnx2y8NvMbq7kCv5MQNNiw-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-68fc1bbc95dso2294870b3a.0
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 15:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694472033; x=1695076833;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9jsh/ygEfJhVGAYXcW+fsIqXOFyWRWwqCGx99xPmbqw=;
 b=iDX+zUVjGnDC59ek1AbtUmIzpRWpMcloXMiPEw+qRlh6IheEZgiO7omeaiFldT8hC4
 oI71qlOOhWRQRuznGBAX4IyKcgVp/ELcmEiyLNNCUFqOHxgOCUfGLJ9YqCH6Ch2XbvPr
 DMcgAO4+Pbd+EKiwnF4qcRHa0xDadx7y0MiQSCN6CPvsCsTZuz+NRPzR+BLFdhEkQIuY
 3F6bTNcMca4LHhoYmlG+Hdo4LLxEk9YZrU7fAmCvD9k/iATCv5oWzhNQknZIb4fzhsrp
 rhDEozks6VwbJ2yTa6dDKNGqEHVpTgNmzSRYhvbdsYQIumB81Hmk4ECeV523Znj2dj7P
 EjAA==
X-Gm-Message-State: AOJu0YzCRdLJZtfsCOmtDAplrWsMcbL7MOdFc/6OLTG0toqQr0b6H/v0
 hF7VLzDTtWUiiBAi2wRBSDks3lOOXiGd7z36FEJVCZXZ/bvWvpbEkwsoeWRJyg7oUAhTGUM8dGr
 RGb+6PM1yEojWLkY=
X-Received: by 2002:a05:6a00:14d0:b0:68e:417c:ed5c with SMTP id
 w16-20020a056a0014d000b0068e417ced5cmr10594287pfu.32.1694472033423; 
 Mon, 11 Sep 2023 15:40:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSBz2BVjRoSX+Pf8xjpJuPsosQ4QCNWXlKVdtzmUsHXh1oovOejFUzsEJOTuVMvrO4i8N7ZQ==
X-Received: by 2002:a05:6a00:14d0:b0:68e:417c:ed5c with SMTP id
 w16-20020a056a0014d000b0068e417ced5cmr10594259pfu.32.1694472033042; 
 Mon, 11 Sep 2023 15:40:33 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 z24-20020aa785d8000000b0067aea93af40sm6124067pfn.2.2023.09.11.15.40.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Sep 2023 15:40:31 -0700 (PDT)
Message-ID: <35653f53-a977-02ea-28f6-6fe85b1efd5a@redhat.com>
Date: Tue, 12 Sep 2023 08:40:16 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/4] hw/cpu: Introduce CPUClass::cpu_resolving_type field
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Cc: Chris Wulff <crwulff@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-s390x@nongnu.org,
 Weiwei Li <liweiwei@iscas.ac.cn>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Greg Kurz <groug@kaod.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 qemu-ppc@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marek Vasut <marex@denx.de>, Palmer Dabbelt <palmer@dabbelt.com>,
 Michael Rolnik <mrolnik@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>, Bin Meng <bin.meng@windriver.com>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Song Gao <gaosong@loongson.cn>,
 Stafford Horne <shorne@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Alistair Francis <alistair.francis@wdc.com>, Brian Cain <bcain@quicinc.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Thomas Huth <thuth@redhat.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20230908112235.75914-1-philmd@linaro.org>
 <20230908112235.75914-4-philmd@linaro.org>
 <87cb0174-c652-aa44-be7c-49e78e0a5003@redhat.com>
 <af78b6c9-14e5-3256-9670-c106f4942140@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <af78b6c9-14e5-3256-9670-c106f4942140@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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


On 9/11/23 19:43, Philippe Mathieu-Daudé wrote:
> On 11/9/23 01:28, Gavin Shan wrote:
>> On 9/8/23 21:22, Philippe Mathieu-Daudé wrote:
>>> Add a field to return the QOM type name of a CPU class.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   include/hw/core/cpu.h   | 2 ++
>>>   hw/core/cpu-common.c    | 2 +-
>>>   target/alpha/cpu.c      | 1 +
>>>   target/arm/cpu.c        | 1 +
>>>   target/avr/cpu.c        | 1 +
>>>   target/cris/cpu.c       | 1 +
>>>   target/hexagon/cpu.c    | 1 +
>>>   target/hppa/cpu.c       | 1 +
>>>   target/i386/cpu.c       | 1 +
>>>   target/loongarch/cpu.c  | 1 +
>>>   target/m68k/cpu.c       | 1 +
>>>   target/microblaze/cpu.c | 1 +
>>>   target/mips/cpu.c       | 1 +
>>>   target/nios2/cpu.c      | 1 +
>>>   target/openrisc/cpu.c   | 1 +
>>>   target/ppc/cpu_init.c   | 1 +
>>>   target/riscv/cpu.c      | 1 +
>>>   target/rx/cpu.c         | 1 +
>>>   target/s390x/cpu.c      | 1 +
>>>   target/sh4/cpu.c        | 1 +
>>>   target/sparc/cpu.c      | 1 +
>>>   target/tricore/cpu.c    | 1 +
>>>   target/xtensa/cpu.c     | 1 +
>>>   23 files changed, 24 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
>>> index 129d179937..e469efd409 100644
>>> --- a/include/hw/core/cpu.h
>>> +++ b/include/hw/core/cpu.h
>>> @@ -100,6 +100,7 @@ struct SysemuCPUOps;
>>>   /**
>>>    * CPUClass:
>>> + * @cpu_resolving_type: CPU QOM type name
>>>    * @class_by_name: Callback to map -cpu command line model name to an
>>>    *                 instantiatable CPU type.
>>>    * @parse_features: Callback to parse command line arguments.
>>> @@ -148,6 +149,7 @@ struct CPUClass {
>>>       DeviceClass parent_class;
>>>       /*< public >*/
>>> +    const char *cpu_resolving_type;
>>>       ObjectClass *(*class_by_name)(const char *cpu_model);
>>>       void (*parse_features)(const char *typename, char *str, Error **errp);
>>
>> The question is why not use CPU_RESOLVING_TYPE directly? It seems CPU_RESOLVING_TYPE
>> is exactly what you want here.
> 
> Unfortunately CPU_RESOLVING_TYPE is target-specific, we want
> hw/core/cpu-common.c to be target-agnostic (build once for all
> targets). This is particularly important in the context of
> heterogeneous QEMU, where a single binary will be able to create
> CPUs from different targets.
> 

CPU_RESOLVING_TYPE and CPUClass::cpu_resolving_type is duplicate to
each other. There are two options I can figure out to avoid the
duplication.

(a) move cpu_class_by_name() from hw/core/cpu-common.c to cpu.c, so that
     CPU_RESOLVING_TYPE can be seen. cpu.c::list_cpus() is the example.

(b) remove hw/core/cpu-common.c::cpu_calss_by_name() and squeeze its
     logic to cpu.c::parse_cpu_option() since there are not too much
     users for it. target/arm and target/s390 needs some tweaks so that
     hw/core/cpu-common.c::cpu_calss_by_name() can be removed.

     [gshan@gshan q]$ git grep \ cpu_class_by_name\(
     cpu.c:    oc = cpu_class_by_name(CPU_RESOLVING_TYPE, model_pieces[0]);
     target/arm/arm-qmp-cmds.c:    oc = cpu_class_by_name(TYPE_ARM_CPU, model->name);
     target/s390x/cpu_models_sysemu.c:    oc = cpu_class_by_name(TYPE_S390_CPU, info->name);

When option (b) is taken, this series to have the checks against @oc
in hw/core/cpu-common.c::cpu_calss_by_name() becomes non-sense. Instead,
we need the same (and complete) checks in CPUClass::class_by_name() for
individual targets. Further more, an inline helper can be provided to do
the check in CPUClass::class_by_name() for individual targets.

    include/hw/core/cpu.h

    static inline bool cpu_class_is_valid(ObjectClass *oc, const char *parent)
    {
        if (!object_class_dynamic_cast(oc, parent) ||
            object_class_is_abstract(oc)) {
            return false;
        }

        return true;
    }

Thanks,
Gavin


