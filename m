Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB39778C351
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 13:31:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qawv2-0003bB-Go; Tue, 29 Aug 2023 07:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qawuu-0003ZM-Fp
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 07:29:52 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qawuq-0004k1-0c
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 07:29:52 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4018af1038cso40362955e9.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 04:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693308586; x=1693913386;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9MksNfXoeieEr4wSGNuSO6rtZ9kgqhOEcMMHWPrH2Ug=;
 b=vhktvdlf3gpP3WGHTnTyGLNwdcH4/m/ezR4VRwclOdzIzzw4jG4oOSL0C/PZCmsFe4
 IegmBFDSBOjbQNppu63hNCxS2mko3gtRZgI3wvWopDYrnUxCV4+0zqqj9OB9eeRSvQYm
 xplraz8PIMD+mWXcezjyaAyEQvgqRbr22rvoudMlQ8pXVW1GHctqEu7mVrTgVxb8VBbw
 rYUDL2Pqc6vkOF67MTnjBCpp2xlb9/S7Rc53XSaEWT+33bjmYzqH565LEnsNUkw/a+qQ
 FzSdTjDlIdD+8VrcKMRzEfjetvP9tIFc3sprypLPb6fOSOrUXrM5YFedFuctO2Z0EUub
 U0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693308586; x=1693913386;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9MksNfXoeieEr4wSGNuSO6rtZ9kgqhOEcMMHWPrH2Ug=;
 b=epzkW2GCdiM7YlYaLfSt2Ge1QJiIpO17b6SaySulVtZ6qGPkTyHZGY5hvKg/AGuJc6
 DmxGdc1XXraIVpJr/zlTz24/c4EyEfNonDKthWhbAeJXSZ1hcscfVGZ40gcXOsfebp58
 VW2UaiE0EeKmEjf+ggVA5rboaGs/Sgno1zUMScZURnrtbsudaJmTabIwifeWfKZ+/w/i
 R+7wVs0Er6GxVyxXyM7LTVi5E2a6NlCURHnk17GuMYRBfHWZUCjF8nCxPBCn2sqW872y
 gqBeLk+AhZoeXfzVaK+9AYaCfthQBLh6UyWzPcElc1ZJkDbRymaeNr35JFOMlINUwnug
 AsZA==
X-Gm-Message-State: AOJu0YxfhGMpxL3O7VjIy39hk01KFc0X8DGyZ3Zyx/MUrYMe5Nh0HKg+
 K7/6nc9suyUE3Vuwr7QzA8c7tg==
X-Google-Smtp-Source: AGHT+IFKuINnZBnGh1wSq4dDXu5XQQlOLc2yIrqu5muMzFDM7T+3oxSy69D7t1K2xrbmoyTrrZR65g==
X-Received: by 2002:a05:600c:144:b0:401:bf89:b013 with SMTP id
 w4-20020a05600c014400b00401bf89b013mr7205306wmm.19.1693308585895; 
 Tue, 29 Aug 2023 04:29:45 -0700 (PDT)
Received: from [192.168.69.115] (sml13-h01-176-184-15-56.dsl.sta.abo.bbox.fr.
 [176.184.15.56]) by smtp.gmail.com with ESMTPSA id
 q20-20020a7bce94000000b003fedcd02e2asm13682512wmj.35.2023.08.29.04.29.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 04:29:45 -0700 (PDT)
Message-ID: <c16efe25-5559-fb0e-a89a-e9b7ffd1561b@linaro.org>
Date: Tue, 29 Aug 2023 13:29:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v3 11/11] machine: Improve error message when using
 default RAM backend id
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: ThinerLogoer <logoerthiner1@163.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Daniel_P=2eBerrang=c3=a9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, Greg Kurz <groug@kaod.org>,
 Eric Blake <eblake@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20230823153412.832081-1-david@redhat.com>
 <20230823153412.832081-12-david@redhat.com>
 <209b4b8c.54bc.18a2b7b6f53.Coremail.logoerthiner1@163.com>
 <e81b5069-e49a-cfb4-bea9-3c7ab6a358ca@redhat.com>
 <87msyfo5b0.fsf@pond.sub.org>
 <bd8f7f13-b982-6cf6-1ef7-16b4738b94ac@redhat.com>
 <87sf87momv.fsf@pond.sub.org>
 <d87ac218-0051-ad91-5867-d1bec9f4fda4@redhat.com>
 <78fd367f-740a-4b37-0faf-dd0cabae4bd6@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <78fd367f-740a-4b37-0faf-dd0cabae4bd6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 25/8/23 12:10, David Hildenbrand wrote:
> On 25.08.23 11:59, David Hildenbrand wrote:
>> On 25.08.23 11:56, Markus Armbruster wrote:
>>> David Hildenbrand <david@redhat.com> writes:
>>>
>>>> On 25.08.23 11:10, Markus Armbruster wrote:
>>>>> David Hildenbrand <david@redhat.com> writes:
>>>>>
>>>>>> On 25.08.23 08:57, ThinerLogoer wrote:
>>>>>>> Hello,
>>>>>>>
>>>>>>> At 2023-08-23 23:34:11, "David Hildenbrand" <david@redhat.com> 
>>>>>>> wrote:
>>>>>>>> For migration purposes, users might want to reuse the default RAM
>>>>>>>> backend id, but specify a different memory backend.
>>>>>>>>
>>>>>>>> For example, to reuse "pc.ram" on q35, one has to set
>>>>>>>>        -machine q35,memory-backend=pc.ram
>>>>>>>> Only then, can a memory backend with the id "pc.ram" be created
>>>>>>>> manually.
>>>>>>>>
>>>>>>>> Let's improve the error message.
>>>>>>>>
>>>>>>>> Unfortuantely, we cannot use error_append_hint(), because the 
>>>>>>>> caller
>>>>>>>> passes &error_fatal.
>>>>>>>>
>>>>>>>> Suggested-by: ThinerLogoer <logoerthiner1@163.com>
>>>>>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>>>>>> ---
>>>>>>>> hw/core/machine.c | 4 +++-
>>>>>>>> 1 file changed, 3 insertions(+), 1 deletion(-)


> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index f0d35c6401..09f40c7f07 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -1352,6 +1352,7 @@ out:
> 
>   void machine_run_board_init(MachineState *machine, const char 
> *mem_path, Error **errp)
>   {
> +    ERRP_GUARD();
>       MachineClass *machine_class = MACHINE_GET_CLASS(machine);
>       ObjectClass *oc = object_class_by_name(machine->cpu_type);
>       CPUClass *cc;
> @@ -1380,9 +1381,13 @@ void machine_run_board_init(MachineState 
> *machine, const char *mem_path, Error *
>                  numa_uses_legacy_mem()) {
>           if (object_property_find(object_get_objects_root(),
>                                    machine_class->default_ram_id)) {
> -            error_setg(errp, "object name '%s' is reserved for the 
> default"
> -                " RAM backend, it can't be used for any other purposes."
> -                " Change the object's 'id' to something else",
> +            error_setg(errp, "object's id '%s' is reserved for the 
> default"
> +                " RAM backend, it can't be used for any other purposes",
> +                machine_class->default_ram_id);
> +            error_append_hint(errp,
> +                "Change the object's 'id' to something else or disable"
> +                " automatic creation of the default RAM backend by 
> setting"
> +                " 'memory-backend=%s' with '-machine'.\n",
>                   machine_class->default_ram_id);
>               return;
>           }

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



