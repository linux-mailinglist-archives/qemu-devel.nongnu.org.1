Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CFF7D1679
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 21:43:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtvOL-0000xa-MA; Fri, 20 Oct 2023 15:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtvOJ-0000wx-8j
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 15:42:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtvOH-0008Ia-MV
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 15:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697830957;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=v48IUSneCiRncr9ecoZFXzb9Et9iUGjrOJ+H4dvshHg=;
 b=f269nDCwpePKctXydBDwVq+ddyk4EdqSXnRoryVzTW8h/JOWYZeaPExQiq/KixNZyQ0pmf
 dzhxHhh8guatCLq2mFJKrdIsng0nUcXcljS/4IoYXp5J5zlPilKGpnKDpVtLWtBzlfMQQL
 +DY/6ITtk4nDs5wnp6yjc/8vyBTzVeo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-N4vlMGlBPNCN3zYVx6S0jQ-1; Fri, 20 Oct 2023 15:42:35 -0400
X-MC-Unique: N4vlMGlBPNCN3zYVx6S0jQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-407d3e55927so7147935e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 12:42:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697830954; x=1698435754;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v48IUSneCiRncr9ecoZFXzb9Et9iUGjrOJ+H4dvshHg=;
 b=UP4rWNeLD/I2uZAfVXWxPHj4ZveeZgFadXkJ8v6q76I+6t3ulFJFrAXNePeOX9YxKP
 BhDev01yv5LgayjiLFOrig2qi6cDE3H/mtpcEeYkMDo6Jo4KpcIvvnxFrSeOXpnOErK3
 xuzqWQVbRDsYl4chQ7r3UiyeyjEY+/dYeC5PTuC2you8zsLK74CTDpoPS4EB680Ho9xt
 YQt1zkJNvM92dun2BUOF5UgOyQVcOAig1l2ZeOrFq9qOyPiqI8G6nlC3Xl5wOmn9YPvc
 Lxl3P0YA4uE3h2jpnt484J+Fxn8Zzcf5KFjD1PY7M4xvAqTUUlpuloHI7lZsuiDBURZj
 Gfww==
X-Gm-Message-State: AOJu0YwqVgy6/ymIAGMrk6hPaJv2lklGPdpqbNpY7V2su3DHrPX0DhCQ
 VOvgT4uqSVWcSDlWeQ3lsfvWFseJVSpNzrcEKyy7qc9qAGD5q8r8br/IMw1FxhLDVdH4Jr/jqyC
 ijSVUt0tkAq0eaaM=
X-Received: by 2002:a05:600c:4f12:b0:405:36d7:4582 with SMTP id
 l18-20020a05600c4f1200b0040536d74582mr2070951wmq.15.1697830954312; 
 Fri, 20 Oct 2023 12:42:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUX+oFhI4GJ64RWQiqG1Up4a1JjODbq62RUNQj4YOo+/5zneio2+gZr/TKkFWLf9rEvTo37A==
X-Received: by 2002:a05:600c:4f12:b0:405:36d7:4582 with SMTP id
 l18-20020a05600c4f1200b0040536d74582mr2070918wmq.15.1697830953954; 
 Fri, 20 Oct 2023 12:42:33 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 m16-20020a7bca50000000b00405d9a950a2sm7546702wml.28.2023.10.20.12.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 12:42:33 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,  Harsh
 Prateek Bora <harshpb@linux.ibm.com>,  David Hildenbrand
 <david@redhat.com>,  Samuel Thibault <samuel.thibault@ens-lyon.org>,  Eric
 Farman <farman@linux.ibm.com>,  qemu-arm@nongnu.org,  qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,  Fabiano Rosas <farosas@suse.de>,
 David Gibson <david@gibson.dropbear.id.au>,  Corey Minyard
 <cminyard@mvista.com>,  "Michael S. Tsirkin" <mst@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Corey Minyard <minyard@acm.org>,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Halil Pasic <pasic@linux.ibm.com>,
 Leonardo Bras <leobras@redhat.com>,  John Snow <jsnow@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,  Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>,  Christian Borntraeger
 <borntraeger@linux.ibm.com>,  Ilya Leoshkevich <iii@linux.ibm.com>,  Jason
 Wang <jasowang@redhat.com>,  qemu-block@nongnu.org,
 qemu-s390x@nongnu.org,  =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Daniel Henrique
 Barboza <danielhb413@gmail.com>,  Stefan Weil <sw@weilnetz.de>,  Stefan
 Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v2 03/13] migration: Use vmstate_register_any() for isa-ide
In-Reply-To: <efef6d37-925c-415e-9a59-85e528eacb7b@redhat.com> (Thomas Huth's
 message of "Fri, 20 Oct 2023 16:12:44 +0200")
References: <20231020090731.28701-1-quintela@redhat.com>
 <20231020090731.28701-4-quintela@redhat.com>
 <efef6d37-925c-415e-9a59-85e528eacb7b@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Fri, 20 Oct 2023 21:42:33 +0200
Message-ID: <871qdpytau.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Thomas Huth <thuth@redhat.com> wrote:
> On 20/10/2023 11.07, Juan Quintela wrote:
>> Otherwise qom-test fails.
>> ok 4 /i386/qom/x-remote
>> qemu-system-i386: savevm_state_handler_insert: Detected duplicate SaveStateEntry: id=isa-ide, instance_id=0x0
>> Broken pipe
>> ../../../../../mnt/code/qemu/full/tests/qtest/libqtest.c:195: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)
>> Aborted (core dumped)
>> $
>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>   hw/ide/isa.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> diff --git a/hw/ide/isa.c b/hw/ide/isa.c
>> index 95053e026f..ea60c08116 100644
>> --- a/hw/ide/isa.c
>> +++ b/hw/ide/isa.c
>> @@ -73,7 +73,7 @@ static void isa_ide_realizefn(DeviceState *dev, Error **errp)
>>       ide_bus_init(&s->bus, sizeof(s->bus), dev, 0, 2);
>>       ide_init_ioport(&s->bus, isadev, s->iobase, s->iobase2);
>>       ide_bus_init_output_irq(&s->bus, isa_get_irq(isadev, s->irqnum));
>> -    vmstate_register(VMSTATE_IF(dev), 0, &vmstate_ide_isa, s);
>> +    vmstate_register_any(VMSTATE_IF(dev), &vmstate_ide_isa, s);
>>       ide_bus_register_restart_cb(&s->bus);
>>   }
>
> Would it make sense to use another unique ID of the device instead? E.g.:
>
> diff a/hw/ide/isa.c b/hw/ide/isa.c
> --- a/hw/ide/isa.c
> +++ b/hw/ide/isa.c
> @@ -73,7 +73,9 @@ static void isa_ide_realizefn(DeviceState *dev, Error **errp)
>      ide_bus_init(&s->bus, sizeof(s->bus), dev, 0, 2);
>      ide_init_ioport(&s->bus, isadev, s->iobase, s->iobase2);
>      ide_bus_init_output_irq(&s->bus, isa_get_irq(isadev, s->irqnum));
> -    vmstate_register(VMSTATE_IF(dev), 0, &vmstate_ide_isa, s);
> +    vmstate_register(VMSTATE_IF(dev),
> +                     object_property_get_int(OBJECT(dev), "irq", &error_abort),
> +                     &vmstate_ide_isa, s);
>      ide_bus_register_restart_cb(&s->bus);
>  }
>    Thomas

Ide is not my part of expertise.
But anything that is different for each instantance is going to be good
for me.

The whole point of this series is to be able to test that there are no
duplicates.  Duplicates are one error when we do real migration.  How we
reach the goal of no duplicates doesn't matter to me.

Later, Juan.


