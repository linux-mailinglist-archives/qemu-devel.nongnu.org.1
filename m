Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 813097D4E5A
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 12:56:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvF56-00079O-4e; Tue, 24 Oct 2023 06:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvF54-00078z-HU
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 06:56:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvF4z-0002pk-B0
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 06:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698144968;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=WYEN7FH7IqZtZ+7M6b7K6o0KxuZIzcblLf/uIxLwAcE=;
 b=gcnG3ht/WEqyzFlMjiJ/Uwne3VoN/AT2EmUqd+6IlK+bf5d/uDRf/DNH5VuXwkRXM19w1n
 f1MBhhpfwQtcLRhgJjLfFqC44qQ5RyUpXykN4uw4zYti+rrDBi0ZlmVd41Yfs857AuZBWW
 sC2eyi6rNmALmbhAzzfRaoVhCBYVK80=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-TQIkUXuPMhGO8bEVZmOjAQ-1; Tue, 24 Oct 2023 06:55:50 -0400
X-MC-Unique: TQIkUXuPMhGO8bEVZmOjAQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4084e4ce543so26818135e9.3
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 03:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698144950; x=1698749750;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WYEN7FH7IqZtZ+7M6b7K6o0KxuZIzcblLf/uIxLwAcE=;
 b=kNqS1iW+QhsLGj+IabEGujQJDee/nBZvt60+AfA8lkya+vT2hNjJHJmTuxpYMcm5mY
 vUh15/PiMVLKzPzshn8Z929SpkTJRyyae49vbYj9nKk0jhJpDhyrlan5QP8Cfaf03PSD
 Die0koSdqpMCW6kQ/pUuwU8Z0ISPdCAPiHzyZaq+vNX+8lqMrQbXHVqX1YQuLF31S3Cq
 iiHB+iaBUFceTLlY39Cz2uh9RZB3oFZ73KkuGIxKk92S5pukFdScPVLCuhK6/YTABf0i
 h6C3zD0dIXom5fHYHgAr6ufoevoBbAxcRelKSCx8LnvHTZ2Dh8BMQ+mb9N3sxGfQA9rM
 4n4Q==
X-Gm-Message-State: AOJu0YxXK2/gzxuMouPBM6CliDBR5IB/o3+ejNNTJIBvFOUF0OpexJh/
 bEQq6s4Sb2cLIEK9k1XhKPvGhcgPf0SSCJjrY+lCsTYuDuf4qaTumVHKQWAbQl0Z7idK6JW0QwY
 FCQoM0/PA+bQUtcU=
X-Received: by 2002:a05:600c:1992:b0:406:872d:7725 with SMTP id
 t18-20020a05600c199200b00406872d7725mr9307806wmq.1.1698144949638; 
 Tue, 24 Oct 2023 03:55:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/GPJ5jACOHE1fPbPitDMlTg9G/b/icPIKtxw2/Vwn9FNzAJ8mr7lULdgzyuIUF4oHdG1oTg==
X-Received: by 2002:a05:600c:1992:b0:406:872d:7725 with SMTP id
 t18-20020a05600c199200b00406872d7725mr9307790wmq.1.1698144949253; 
 Tue, 24 Oct 2023 03:55:49 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 dk18-20020a0560000b5200b0032dbf6bf7a2sm9729097wrb.97.2023.10.24.03.55.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 03:55:47 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: John Snow <jsnow@redhat.com>,  qemu-devel@nongnu.org,  Peter Maydell
 <peter.maydell@linaro.org>,  Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,  Samuel Thibault
 <samuel.thibault@ens-lyon.org>,  Eric Farman <farman@linux.ibm.com>,
 qemu-arm@nongnu.org,  qemu-ppc@nongnu.org,  Gerd Hoffmann
 <kraxel@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  David Gibson
 <david@gibson.dropbear.id.au>,  Corey Minyard <cminyard@mvista.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Peter Xu <peterx@redhat.com>,
 Corey Minyard <minyard@acm.org>,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Halil Pasic <pasic@linux.ibm.com>,
 Leonardo Bras <leobras@redhat.com>,  Nicholas Piggin <npiggin@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,  Christian Borntraeger
 <borntraeger@linux.ibm.com>,  Ilya Leoshkevich <iii@linux.ibm.com>,  Jason
 Wang <jasowang@redhat.com>,  qemu-block@nongnu.org,
 qemu-s390x@nongnu.org,  =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Daniel Henrique
 Barboza <danielhb413@gmail.com>,  Stefan Weil <sw@weilnetz.de>,  Stefan
 Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v2 03/13] migration: Use vmstate_register_any() for isa-ide
In-Reply-To: <76272c6c-f7b6-4fbd-a457-8cf14048ddca@redhat.com> (Thomas Huth's
 message of "Mon, 23 Oct 2023 08:02:05 +0200")
References: <20231020090731.28701-1-quintela@redhat.com>
 <20231020090731.28701-4-quintela@redhat.com>
 <efef6d37-925c-415e-9a59-85e528eacb7b@redhat.com>
 <871qdpytau.fsf@secure.mitica>
 <76272c6c-f7b6-4fbd-a457-8cf14048ddca@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 24 Oct 2023 12:55:47 +0200
Message-ID: <87o7goz3v0.fsf@secure.mitica>
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
> On 20/10/2023 21.42, Juan Quintela wrote:
>> Thomas Huth <thuth@redhat.com> wrote:
>>> On 20/10/2023 11.07, Juan Quintela wrote:
>>>> Otherwise qom-test fails.
>>>> ok 4 /i386/qom/x-remote
>>>> qemu-system-i386: savevm_state_handler_insert: Detected duplicate SaveStateEntry: id=isa-ide, instance_id=0x0
>>>> Broken pipe
>>>> ../../../../../mnt/code/qemu/full/tests/qtest/libqtest.c:195: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)
>>>> Aborted (core dumped)
>>>> $
>>>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>>>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>>> ---
>>>>    hw/ide/isa.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>> diff --git a/hw/ide/isa.c b/hw/ide/isa.c
>>>> index 95053e026f..ea60c08116 100644
>>>> --- a/hw/ide/isa.c
>>>> +++ b/hw/ide/isa.c
>>>> @@ -73,7 +73,7 @@ static void isa_ide_realizefn(DeviceState *dev, Error **errp)
>>>>        ide_bus_init(&s->bus, sizeof(s->bus), dev, 0, 2);
>>>>        ide_init_ioport(&s->bus, isadev, s->iobase, s->iobase2);
>>>>        ide_bus_init_output_irq(&s->bus, isa_get_irq(isadev, s->irqnum));
>>>> -    vmstate_register(VMSTATE_IF(dev), 0, &vmstate_ide_isa, s);
>>>> +    vmstate_register_any(VMSTATE_IF(dev), &vmstate_ide_isa, s);
>>>>        ide_bus_register_restart_cb(&s->bus);
>>>>    }
>>>
>>> Would it make sense to use another unique ID of the device instead? E.g.:
>>>
>>> diff a/hw/ide/isa.c b/hw/ide/isa.c
>>> --- a/hw/ide/isa.c
>>> +++ b/hw/ide/isa.c
>>> @@ -73,7 +73,9 @@ static void isa_ide_realizefn(DeviceState *dev, Error **errp)
>>>       ide_bus_init(&s->bus, sizeof(s->bus), dev, 0, 2);
>>>       ide_init_ioport(&s->bus, isadev, s->iobase, s->iobase2);
>>>       ide_bus_init_output_irq(&s->bus, isa_get_irq(isadev, s->irqnum));
>>> -    vmstate_register(VMSTATE_IF(dev), 0, &vmstate_ide_isa, s);
>>> +    vmstate_register(VMSTATE_IF(dev),
>>> +                     object_property_get_int(OBJECT(dev), "irq", &error_abort),
>>> +                     &vmstate_ide_isa, s);
>>>       ide_bus_register_restart_cb(&s->bus);
>>>   }
>>>     Thomas
>> Ide is not my part of expertise.
>> But anything that is different for each instantance is going to be good
>> for me.
>
> It's not really my turf either ... ok, so unless the IDE maintainer
> speaks up, I think it's maybe best if you continue with your "_any"
> patch.

Ide maintainer can do your change if he likes it.  It is outside of my
understanding to accept it or not (and furthermore, it breaks migration
if you have only one device, with more than one it is already broken).

Later, Juan.


