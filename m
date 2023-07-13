Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD6D752156
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 14:35:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJvWm-0000zh-Ks; Thu, 13 Jul 2023 08:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qJvWk-0000zX-39
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 08:34:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qJvWi-0005VV-BH
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 08:34:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689251671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ru889PnU6EePW+KiYUQ9HktIo2vzu02KCYfTEVGWW8Q=;
 b=f/o1BBPCoUl7PcfMJX8IDv1lFpwAsI0TR7PUuvr1JGvsOwC2GUO/RXvjrJGRPDqcWFuwJt
 BpRhPlb3FrGegSgkuodkG3n7GDThSX9WjuumC0OlHhA+9BRBMpOAg4dewJFrNKwRKcr6WD
 Iscv6ccP8sqFS96hH6K8XKE+pCHMtXQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-e9RGjnjbMcudPT0BJfO6kA-1; Thu, 13 Jul 2023 08:34:29 -0400
X-MC-Unique: e9RGjnjbMcudPT0BJfO6kA-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-263047f46f4so480976a91.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 05:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689251667; x=1691843667;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ru889PnU6EePW+KiYUQ9HktIo2vzu02KCYfTEVGWW8Q=;
 b=lemQGXj7ucqkkKbQ3aM/544+SSgYlavDbtngJTc0yUUMMGkTOkzUzaLKKJfdwjLodv
 hfFogBpzpszQTLmHWTX8yvfuOVhikM8ak8E+zDZZCii0As5W1NCQX1emOfHK0+wZ/IkD
 ax4tp+KlhuoSLdJ64m8lphDujdqAhDAE/bc3lAyqNxnfSf2I8nG/TIwyqz0Zbl6TKGRM
 d+sfU4ZftrOKOwd2ywZEYmHUC6dhDljD9zqZEgZ4h8Uu/peRAyimeWuhP+JNWZpfF885
 xN6OzIZGKeM8QRaUvO9jndpChT0YP4ssfBSVJs0G9WsEzLD/hRBfra1idaRJ8X2KKCZa
 iNYg==
X-Gm-Message-State: ABy/qLaPPHrQT4zCnAdkznrR4rEixh93/Q3jdhZG3J4gosSWUAN+gZ3b
 kSD9noY1XR9nYbeiI3CS+S/NiZw0VdCWcjolxS7P0wJ8UX2xpbZSdC6bASr7py8qYeITu1wnJAJ
 kLWhYyW2CAMywRI0=
X-Received: by 2002:a17:90b:1b4b:b0:262:e697:f367 with SMTP id
 nv11-20020a17090b1b4b00b00262e697f367mr6465120pjb.15.1689251667670; 
 Thu, 13 Jul 2023 05:34:27 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHLn4Z6Tb/7uUfxWQ181ymabPU3aFqNiUf3dnmPnrJBfWp1AqXLdYIX/KwCSYFJYi9lIBBUPQ==
X-Received: by 2002:a17:90b:1b4b:b0:262:e697:f367 with SMTP id
 nv11-20020a17090b1b4b00b00262e697f367mr6465100pjb.15.1689251667325; 
 Thu, 13 Jul 2023 05:34:27 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 l2-20020a17090270c200b001b8307c81c8sm5846498plt.121.2023.07.13.05.34.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jul 2023 05:34:26 -0700 (PDT)
Message-ID: <3a392615-5aca-f384-197f-84beb3086a29@redhat.com>
Date: Thu, 13 Jul 2023 22:34:21 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/3] hw/arm/virt: Use generic CPU invalidation
Content-Language: en-US
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, shan.gavin@gmail.com
References: <20230713054502.410911-1-gshan@redhat.com>
 <CAFEAcA8197FCwfNZrnxfO-87RveOko0Ju-KcTJOEi0vfjVtDKg@mail.gmail.com>
 <2d21e89f-c965-e8f1-3705-dfea8367fc7e@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <2d21e89f-c965-e8f1-3705-dfea8367fc7e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.096, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Peter and Marcin,

On 7/13/23 21:52, Marcin Juszkiewicz wrote:
> W dniu 13.07.2023 o 13:44, Peter Maydell pisze:
> 
>> I see this isn't a change in this patch, but given that
>> what the user specifies is not "cortex-a8-arm-cpu" but
>> "cortex-a8", why do we include the "-arm-cpu" suffix in
>> the error messages? It's not valid syntax to say
>> "-cpu cortex-a8-arm-cpu", so it's a bit misleading...
> 
> Internally those cpu names are "max-{TYPE_ARM_CPU}" and similar for other architectures.
> 
> I like the change but it (IMHO) needs to cut "-{TYPE_*_CPU}" string from names:
> 
> 13:37 marcin@applejack:qemu$ ./build/aarch64-softmmu/qemu-system-aarch64 -M virt -cpu cortex-r5
> qemu-system-aarch64: Invalid CPU type: cortex-r5-arm-cpu
> The valid types are: cortex-a7-arm-cpu, cortex-a15-arm-cpu, cortex-a35-arm-cpu, cortex-a55-arm-cpu, cortex-a72-arm-cpu, cortex-a76-arm-cpu, a64fx-arm-cpu, neoverse-n1-arm-cpu, neoverse-v1-arm-cpu, cortex-a53-arm-cpu, cortex-a57-arm-cpu, host-arm-cpu, max-arm-cpu
> 
> 13:37 marcin@applejack:qemu$ ./build/aarch64-softmmu/qemu-system-aarch64 -M virt -cpu cortex-a57-arm-cpu
> qemu-system-aarch64: unable to find CPU model 'cortex-a57-arm-cpu'
> 

The suffix of CPU types are provided in hw/arm/virt.c::valid_cpu_types in PATCH[2].
In the generic validation, the complete CPU type is used. The error message also
have complete CPU type there.

Peter and Marcin, how about to split the CPU types to two fields, as below? In this
way, the complete CPU type will be used for validation and the 'internal' names will
be used for the error messages.

struct MachineClass {
     const char *valid_cpu_type_suffix;
     const char **valid_cpu_types;
};

hw/arm/virt.c
-------------

static const char *valid_cpu_types[] = {
#ifdef CONFIG_TCG
     "cortex-a7",
     "cortex-a15",
     "cortex-a35",
     "cortex-a55",
     "cortex-a72",
     "cortex-a76",
     "a64fx",
     "neoverse-n1",
     "neoverse-v1",
#endif
     "cortex-a53",
     "cortex-a57",
     "host",
     "max",
     NULL
};

static void virt_machine_class_init(ObjectClass *oc, void *data)
{
     mc->valid_cpu_type_suffix = TYPE_ARM_CPU;
     mc->valid_cpu_types = valid_cpu_types;
}

hw/core/machine.c
-----------------

static void validate_cpu_type(MachineState *machine)
{
     ObjectClass *oc = object_class_by_name(machine->cpu_type), *ret = NULL;
     CPUClass *cc = CPU_CLASS(oc);
     char *cpu_type;
     int i;

     if (!machine->cpu_type || !machine_class->valid_cpu_types) {
         goto out_no_check;
     }

     for (i = 0; machine_class->valid_cpu_types[i]; i++) {
         /* The class name is the combination of prefix + suffix */
         if (machine_class->valid_cpu_type_suffix) {
             cpu_type = g_strdup_printf("%s-%s", machine_class->valid_cpu_types[i], machine_class->valid_cpu_type_suffix);
         } else {
             cpu_type = g_strdup(machine_class->valid_cpu_types[i]);
         }

         ret = object_class_dynamic_cast(oc, cpu_type));
         g_free(cpu_type);
         if (ret) {
             break;
         }
     }

     if (!machine_class->valid_cpu_types[i]) {
         /* The user-specified CPU type is invalid */
         /**** the prefix is used in the error messages ********/
         error_report("Invalid CPU type: %s", machine->cpu_type);
         error_printf("The valid types are: %s",
                      machine_class->valid_cpu_types[0]);
         for (i = 1; machine_class->valid_cpu_types[i]; i++) {
             error_printf(", %s", machine_class->valid_cpu_types[i]);
         }
         error_printf("\n");

         exit(1);
     }

     /* Check if CPU type is deprecated and warn if so */
out_no_check:
     if (cc && cc->deprecation_note) {
         warn_report("CPU model %s is deprecated -- %s",
                     machine->cpu_type, cc->deprecation_note);
     }
}

> 
> I can change sbsa-ref to follow that change but let it be userfriendly.
> 

Yes, sbsa-ref needs an extra patch to use the generic invalidation. I can add
one patch on the top for that in next revision if you agree, Marcin.

Thanks,
Gavin


