Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 093847D0CA9
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 12:06:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtmNc-0005Jl-HX; Fri, 20 Oct 2023 06:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qtmNZ-0005Iv-23
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 06:05:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qtmNJ-0006SD-BZ
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 06:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697796297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3yVwzL/QXJsd0uHPz3otM8pRjCF1v+bPC6Qo0f3jrOQ=;
 b=QLkDdj46vlxAcBi/hW76XamjLsarHuInG0sKjWSaXNENNGlcJ9FXTAqmWxhjsK761itA7n
 exKl3lS9j1n7iUK+GIfkH39awwFvTX9+FIhnMWNXz1o0ekgiEHj5lSQnZ2E619Uh9nlTrg
 5AxEZiqZ9/JQPKs52x95pUDuJRt/vWQ=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-7nGqrJQhNHCFR0CuRQeGTA-1; Fri, 20 Oct 2023 06:04:56 -0400
X-MC-Unique: 7nGqrJQhNHCFR0CuRQeGTA-1
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-49dcd87ff41so235631e0c.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 03:04:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697796295; x=1698401095;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3yVwzL/QXJsd0uHPz3otM8pRjCF1v+bPC6Qo0f3jrOQ=;
 b=oXAzG9WRmiOlFpcbqeo3AaiqqCBTfo4F+DJYdjiYKWlarYznb+PRgJsv52nNNrciLC
 DLc1UJaB4KZfm8CABEraYOQgYGbS4OAn5FriShjuNK6dMVRgSFIXUhfUq0caFy22dGmG
 hp+yKcWMvEqtHi3pqQ9X89hdGTmSexeUZ1paRs0SE+RiKKcZPW7oZ1J1lwPK/zc/l/Xp
 z6FpUhQzt4znpCe8fS2ZVBebzB3Pmdu6VMONchUCMI36sYEvmhjh11gJA4Way+YK6ZDQ
 q6KrMqMMzCSC8Cmfyi/5+UomhcApYDShhER0fbicWWYD0/I6J4rzsm55krwyJTREfHa8
 o33Q==
X-Gm-Message-State: AOJu0YyGyJo58H/lC6KIUJ2V9p8CmfVzd6LJYDRcSpw+qUY7GwEG2WBT
 zgpXuEKL73aDrUYyC7cwQi5wKhb6z8E1wojjTsDrN75LJxxYamCdwYsl8H/VrzJvYuacAAwL4NS
 pqp5P+YZh+dOlRXg=
X-Received: by 2002:a05:6122:168b:b0:48d:1fcd:9760 with SMTP id
 11-20020a056122168b00b0048d1fcd9760mr1414742vkl.10.1697796295332; 
 Fri, 20 Oct 2023 03:04:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFE62J8Tgg6qKp7UOEY0VSJf2Qtf6sCRSB6ns3Z7stIW+4BUYUPbGmBsltYT0zRG5lXsK7tQ==
X-Received: by 2002:a05:6122:168b:b0:48d:1fcd:9760 with SMTP id
 11-20020a056122168b00b0048d1fcd9760mr1414718vkl.10.1697796295009; 
 Fri, 20 Oct 2023 03:04:55 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-141.web.vodafone.de.
 [109.43.176.141]) by smtp.gmail.com with ESMTPSA id
 f5-20020ac86ec5000000b004181b41e793sm475860qtv.50.2023.10.20.03.04.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Oct 2023 03:04:54 -0700 (PDT)
Message-ID: <be2d6fa7-9f2b-412f-aff6-eb2ff0a22f35@redhat.com>
Date: Fri, 20 Oct 2023 12:04:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/13] migration: Use VMSTATE_INSTANCE_ID_ANY for s390
 devices
Content-Language: en-US
To: quintela@redhat.com, Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
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
 Ilya Leoshkevich <iii@linux.ibm.com>, Jason Wang <jasowang@redhat.com>,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goat?=
 =?UTF-8?Q?er?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, Stefan Weil
 <sw@weilnetz.de>, Stefan Berger <stefanb@linux.ibm.com>
References: <20231020090731.28701-1-quintela@redhat.com>
 <20231020090731.28701-7-quintela@redhat.com>
 <b8b79cb0-1537-b0bb-5c30-1ac2582034cb@linux.ibm.com>
 <87il71zkif.fsf@secure.mitica>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <87il71zkif.fsf@secure.mitica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 20/10/2023 11.54, Juan Quintela wrote:
> Christian Borntraeger <borntraeger@linux.ibm.com> wrote:
>> Am 20.10.23 um 11:07 schrieb Juan Quintela:
>>> Just with make check I can see that we can have more than one of this
>>> devices, so use ANY.
>>> ok 5 /s390x/device/introspect/abstract-interfaces
>>> ...
>>> Broken pipe
>>> ../../../../../mnt/code/qemu/full/tests/qtest/libqtest.c:195:
>>> kill_qemu() tried to terminate QEMU process but encountered exit
>>> status 1 (expected 0)
>>> Aborted (core dumped)
>>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>> ---
>>>    hw/s390x/s390-skeys.c    | 3 ++-
>>>    hw/s390x/s390-stattrib.c | 3 ++-
>>>    2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> Actually both devices should be theŕe only once - I think.
> 
> Reverting the patch (but with the check that we don't add duplicated
> entries):
> 
> # Testing device 's390-skeys-qemu'
> Broken pipe
> ../../../../../mnt/code/qemu/full/tests/qtest/libqtest.c:194: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)
> Aborted (core dumped)
> $
> 
> This is device-intraspect-test.
> 
> Somehow this function decides that you can hotplug this two s390
> devices, if that is not the case, they need to be marked somehow not
> hot-plugabble.

Sorry, no, it's not hot-plugging what is happening here, it's device 
introspection. That means it should always be possible to create a second 
instance of a device for introspection - it must just not be realized if 
there can be only one instance.

Looking at the code here:

tatic inline void s390_skeys_set_migration_enabled(Object *obj, bool value,
                                             Error **errp)
{
     S390SKeysState *ss = S390_SKEYS(obj);

     /* Prevent double registration of savevm handler */
     if (ss->migration_enabled == value) {
         return;
     }

     ss->migration_enabled = value;

     if (ss->migration_enabled) {
         register_savevm_live(TYPE_S390_SKEYS, 0, 1,
                              &savevm_s390_storage_keys, ss);
     } else {
         unregister_savevm(VMSTATE_IF(ss), TYPE_S390_SKEYS, ss);
     }
}

static void s390_skeys_instance_init(Object *obj)
{
     object_property_add_bool(obj, "migration-enabled",
                              s390_skeys_get_migration_enabled,
                              s390_skeys_set_migration_enabled);
     object_property_set_bool(obj, "migration-enabled", true, NULL);
}

I think the problem is the object_property_set_bool() in the 
_instance_init() function. The setting of the property should maybe rather 
happen during the realization instead?

  Thomas



