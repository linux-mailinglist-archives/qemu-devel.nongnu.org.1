Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC56A7D104E
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 15:11:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtpHn-0003JK-Tb; Fri, 20 Oct 2023 09:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qtpHm-0003Ci-1F
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 09:11:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qtpHj-0007ZL-C8
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 09:11:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697807486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GOysEka5jNdq7RZYbyF2klgLR8lfI6J7Iosb3cg8rng=;
 b=Vo0NzvVpG/bkJPYbc9tgc7SgJf9A1sb4cLxcaiO8TxnQB5+2MXI7H+DKGKzeFwgnNYBZ0G
 biKCM853jpG+h4PS2PfLkA5uLDdq9clmaclYnTcHbJlvYnWpRhBNBVpRQxXpmW8FPSkbwr
 TN2Rh059cQ/gG1H0MvccsF5dvDdcQjI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-DFyVqFx_OTK9AKBlNJB9qg-1; Fri, 20 Oct 2023 09:11:25 -0400
X-MC-Unique: DFyVqFx_OTK9AKBlNJB9qg-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-41bef8f8d94so8090071cf.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 06:11:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697807484; x=1698412284;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GOysEka5jNdq7RZYbyF2klgLR8lfI6J7Iosb3cg8rng=;
 b=W97FwJ5FffwnjALiIYpwozZ4BMg8yyMPOQERZb/sgI0CxaUCcSkf490ctrIYJ4ytn8
 g4F3rJqs85fHkX9pPA3LUzLwdQO7He+7cKE4kCWLBPR0+ks4iUWURdP9XTpq0XZKYDka
 cWM8GM8ZpzjlgoTZSPoO/o1fWjov2gi20AmQQvgYDOCLJvGR44ekIMfPbw+Rlj1S89G1
 xZ2nnMQq2zqSJxpVCl61JenYjW3XUB2a4nGlXyJ63PQWKwg26ej924LWe0ouDTtIr4P3
 iVhxX+zZmvO18D/h3Zz8zqwphseLld1qYOovNz2he/Oe3gsnPZXlWr/fKN7TgX4DhvWV
 Syqg==
X-Gm-Message-State: AOJu0YzaDB4O8mW3yMpDuA5c/ylJVtK5rwa+ZjoOp5CC0j+T2jx+C0ex
 8yX37LHAUjsGcOs6sV57dUbeqVCucpENRuF/3wO0ipf/K5RCcTaHbaa7nYORqRg3yh35GV89zQ6
 KYhSn15OCCTLDjKE=
X-Received: by 2002:ac8:5886:0:b0:412:2dd3:e108 with SMTP id
 t6-20020ac85886000000b004122dd3e108mr1364530qta.9.1697807484495; 
 Fri, 20 Oct 2023 06:11:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvOzEXyqIZaqHTV0atWic6UcCPbnGncMpWUZ4bcX7pxx9y6RD/F0qmtNy3ypoLfwjB+4rQOg==
X-Received: by 2002:ac8:5886:0:b0:412:2dd3:e108 with SMTP id
 t6-20020ac85886000000b004122dd3e108mr1364470qta.9.1697807484042; 
 Fri, 20 Oct 2023 06:11:24 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-141.web.vodafone.de.
 [109.43.176.141]) by smtp.gmail.com with ESMTPSA id
 g7-20020ac87d07000000b00417dd1dd0adsm577674qtb.87.2023.10.20.06.11.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Oct 2023 06:11:23 -0700 (PDT)
Message-ID: <feadc57e-1587-4daa-9f2c-d8eba79125dd@redhat.com>
Date: Fri, 20 Oct 2023 15:11:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/13] migration: Use vmstate_register_any() for
 ipmi-bt*
Content-Language: en-US
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Eric Farman <farman@linux.ibm.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, David Gibson <david@gibson.dropbear.id.au>,
 Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Xu <peterx@redhat.com>, Corey Minyard <minyard@acm.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Leonardo Bras <leobras@redhat.com>,
 John Snow <jsnow@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Jason Wang <jasowang@redhat.com>,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goat?=
 =?UTF-8?Q?er?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, Stefan Weil
 <sw@weilnetz.de>, Stefan Berger <stefanb@linux.ibm.com>
References: <20231020090731.28701-1-quintela@redhat.com>
 <20231020090731.28701-5-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20231020090731.28701-5-quintela@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 20/10/2023 11.07, Juan Quintela wrote:
> Otherwise device-introspection-test fails.
> 
> $ ./tests/qtest/device-introspect-test
> ...
> Broken pipe
> ../../../../../mnt/code/qemu/full/tests/qtest/libqtest.c:195: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)
> Aborted (core dumped)
> 
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>   hw/ipmi/ipmi_bmc_extern.c | 2 +-
>   hw/ipmi/ipmi_bmc_sim.c    | 2 +-
>   hw/ipmi/isa_ipmi_bt.c     | 2 +-
>   hw/ipmi/isa_ipmi_kcs.c    | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
> index e232d35ba2..324a2c8835 100644
> --- a/hw/ipmi/ipmi_bmc_extern.c
> +++ b/hw/ipmi/ipmi_bmc_extern.c
> @@ -504,7 +504,7 @@ static void ipmi_bmc_extern_init(Object *obj)
>       IPMIBmcExtern *ibe = IPMI_BMC_EXTERN(obj);
>   
>       ibe->extern_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, extern_timeout, ibe);
> -    vmstate_register(NULL, 0, &vmstate_ipmi_bmc_extern, ibe);
> +    vmstate_register_any(NULL, &vmstate_ipmi_bmc_extern, ibe);
>   }

This is an instance_init() function. We shouldn't register vmstate (and 
timer) here, but do it in the realize() function instead.

>   
>   static void ipmi_bmc_extern_finalize(Object *obj)
> diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
> index 905e091094..404db5d5bc 100644
> --- a/hw/ipmi/ipmi_bmc_sim.c
> +++ b/hw/ipmi/ipmi_bmc_sim.c
> @@ -2188,7 +2188,7 @@ static void ipmi_sim_realize(DeviceState *dev, Error **errp)
>   
>       ibs->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, ipmi_timeout, ibs);
>   
> -    vmstate_register(NULL, 0, &vmstate_ipmi_sim, ibs);
> +    vmstate_register_any(NULL, &vmstate_ipmi_sim, ibs);
>   }

Now here it's been done in the realize() function already ... did this 
really cause trouble for you?
Anyway, I wonder why the first parameter is NULL here ... shouldn't this 
point to dev instead?

>   static Property ipmi_sim_properties[] = {
> diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
> index a83e7243d6..afb76b548a 100644
> --- a/hw/ipmi/isa_ipmi_bt.c
> +++ b/hw/ipmi/isa_ipmi_bt.c
> @@ -125,7 +125,7 @@ static void isa_ipmi_bt_init(Object *obj)
>   
>       ipmi_bmc_find_and_link(obj, (Object **) &iib->bt.bmc);
>   
> -    vmstate_register(NULL, 0, &vmstate_ISAIPMIBTDevice, iib);
> +    vmstate_register_any(NULL, &vmstate_ISAIPMIBTDevice, iib);
>   }

It's an instance_init() function again. This should be done in the realize() 
instead.

>   static void *isa_ipmi_bt_get_backend_data(IPMIInterface *ii)
> diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
> index b2ed70b9da..5ab63b2fcf 100644
> --- a/hw/ipmi/isa_ipmi_kcs.c
> +++ b/hw/ipmi/isa_ipmi_kcs.c
> @@ -132,7 +132,7 @@ static void isa_ipmi_kcs_init(Object *obj)
>        * IPMI device, so receive it, but transmit a different
>        * version.
>        */
> -    vmstate_register(NULL, 0, &vmstate_ISAIPMIKCSDevice, iik);
> +    vmstate_register_any(NULL, &vmstate_ISAIPMIKCSDevice, iik);
>   }

Dito, this should be moved to realize().

  Thomas


