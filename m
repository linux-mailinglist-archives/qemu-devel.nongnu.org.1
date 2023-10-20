Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F127D0C5D
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 11:55:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtmDi-0003Vu-1t; Fri, 20 Oct 2023 05:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtmDY-0003Ka-PU
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 05:55:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtmDX-00039t-1P
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 05:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697795692;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vGSxRR5YJgfZ0gSIKkT8v7VX/vApFn3Jra8KVp93HBM=;
 b=bTq6cPPIfCDs09FgpkktIsE47CWcRSzge0v91KIHoKTDBqtzalZDtWjgiXhrjaAbgQcS60
 WxPVUGX8Q0I+fMIxeHUXaWowMNWwTekLJXM4R9DWtZzTiZWDvMX9ls/uXSz/23dPje2IFG
 YRMr4Am/RUduBIIgcAB+8XG+DiJlg10=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-5fXrEgNEOOm5h2-y-nJDQg-1; Fri, 20 Oct 2023 05:54:51 -0400
X-MC-Unique: 5fXrEgNEOOm5h2-y-nJDQg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-408524e2368so1813515e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 02:54:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697795690; x=1698400490;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vGSxRR5YJgfZ0gSIKkT8v7VX/vApFn3Jra8KVp93HBM=;
 b=xKPcZC9YXOnZ/B+M9z5tV4BF071JVmww+lUInkdzaUdJHp2cdOxBs8pNx5c8giqCS7
 siOE16fJzhHnwwB5WoqOWyzqyKHHPJDXrkca+UpD4vRZBX6v5EmgJLfoDzbWFaoaLhSS
 Ma80BuWmhdfXJlAUK3v5hjupHRgua+HFPXGd+7Ya79PWceWEahmXDNj6gZqjpd+lB8aX
 GggaR1KBk5KsaCs0ellarfRbOopRlXvpvXBqJ2VhGVxDgutxgD789KJiLEyPpgQ3OOjh
 kXkS/8OBU4HqJpAF86QcsWwCXCBMxfbJgj9T+zmx70UiM0SrK3vQDsEylslqjhZNwEGi
 sfFg==
X-Gm-Message-State: AOJu0YzzNeOEZcmTzhzsb0Q5dmZ8RCyCpcIoJHviaHqV1htGSCzB9/Vf
 czMQLm+JBhk3iA4Llr0bSKpT0Loxy+GgV6QdyC6CJ0lQmFECiauf858HYauOXUFyFpYkIeLq19Z
 8+GCl9zdMbV9q7aM=
X-Received: by 2002:a05:600c:154a:b0:406:4573:81d2 with SMTP id
 f10-20020a05600c154a00b00406457381d2mr1011782wmg.39.1697795690027; 
 Fri, 20 Oct 2023 02:54:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/62h5i1qPiOHJa34xRI2T687/pTx/CqWe5zoRK57EVWuwqvLEIVhuCBPIwYn+lWqx2pVXRw==
X-Received: by 2002:a05:600c:154a:b0:406:4573:81d2 with SMTP id
 f10-20020a05600c154a00b00406457381d2mr1011741wmg.39.1697795689619; 
 Fri, 20 Oct 2023 02:54:49 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 c39-20020a05600c4a2700b0040588d85b3asm6354301wmp.15.2023.10.20.02.54.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 02:54:49 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,  Harsh
 Prateek Bora <harshpb@linux.ibm.com>,  David Hildenbrand
 <david@redhat.com>,  Samuel Thibault <samuel.thibault@ens-lyon.org>,  Eric
 Farman <farman@linux.ibm.com>,  qemu-arm@nongnu.org,  qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,  David Gibson
 <david@gibson.dropbear.id.au>,  Corey Minyard <cminyard@mvista.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Peter Xu <peterx@redhat.com>,
 Corey Minyard <minyard@acm.org>,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Halil Pasic <pasic@linux.ibm.com>,
 Leonardo Bras <leobras@redhat.com>,  John Snow <jsnow@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,  Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>,  Ilya Leoshkevich <iii@linux.ibm.com>,
 Jason Wang <jasowang@redhat.com>,  qemu-block@nongnu.org,
 qemu-s390x@nongnu.org,  =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Daniel Henrique
 Barboza <danielhb413@gmail.com>,  Stefan Weil <sw@weilnetz.de>,  Stefan
 Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v2 06/13] migration: Use VMSTATE_INSTANCE_ID_ANY for
 s390 devices
In-Reply-To: <b8b79cb0-1537-b0bb-5c30-1ac2582034cb@linux.ibm.com> (Christian
 Borntraeger's message of "Fri, 20 Oct 2023 11:26:13 +0200")
References: <20231020090731.28701-1-quintela@redhat.com>
 <20231020090731.28701-7-quintela@redhat.com>
 <b8b79cb0-1537-b0bb-5c30-1ac2582034cb@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Fri, 20 Oct 2023 11:54:48 +0200
Message-ID: <87il71zkif.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Christian Borntraeger <borntraeger@linux.ibm.com> wrote:
> Am 20.10.23 um 11:07 schrieb Juan Quintela:
>> Just with make check I can see that we can have more than one of this
>> devices, so use ANY.
>> ok 5 /s390x/device/introspect/abstract-interfaces
>> ...
>> Broken pipe
>> ../../../../../mnt/code/qemu/full/tests/qtest/libqtest.c:195:
>> kill_qemu() tried to terminate QEMU process but encountered exit
>> status 1 (expected 0)
>> Aborted (core dumped)
>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>   hw/s390x/s390-skeys.c    | 3 ++-
>>   hw/s390x/s390-stattrib.c | 3 ++-
>>   2 files changed, 4 insertions(+), 2 deletions(-)
>
> Actually both devices should be the=C5=95e only once - I think.

Reverting the patch (but with the check that we don't add duplicated
entries):

# Testing device 's390-skeys-qemu'
Broken pipe
../../../../../mnt/code/qemu/full/tests/qtest/libqtest.c:194: kill_qemu() t=
ried to terminate QEMU process but encountered exit status 1 (expected 0)
Aborted (core dumped)
$=20

This is device-intraspect-test.

Somehow this function decides that you can hotplug this two s390
devices, if that is not the case, they need to be marked somehow not
hot-plugabble.

static void test_one_device(QTestState *qts, const char *type)
{
    QDict *resp;
    char *help, *escaped;
    GRegex *comma;

    g_test_message("Testing device '%s'", type);

    resp =3D qtest_qmp(qts, "{'execute': 'device-list-properties',"
                          " 'arguments': {'typename': %s}}",
               type);
    qobject_unref(resp);

    comma =3D g_regex_new(",", 0, 0, NULL);
    escaped =3D g_regex_replace_literal(comma, type, -1, 0, ",,", 0, NULL);
    g_regex_unref(comma);

    help =3D qtest_hmp(qts, "device_add \"%s,help\"", escaped);
    g_free(help);
    g_free(escaped);
}

Thanks, Juan.



>
>> diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
>> index 5024faf411..ef089e1967 100644
>> --- a/hw/s390x/s390-skeys.c
>> +++ b/hw/s390x/s390-skeys.c
>> @@ -22,6 +22,7 @@
>>   #include "sysemu/kvm.h"
>>   #include "migration/qemu-file-types.h"
>>   #include "migration/register.h"
>> +#include "migration/vmstate.h"
>>     #define S390_SKEYS_BUFFER_SIZE (128 * KiB)  /* Room for 128k
>> storage keys */
>>   #define S390_SKEYS_SAVE_FLAG_EOS 0x01
>> @@ -457,7 +458,7 @@ static inline void s390_skeys_set_migration_enabled(=
Object *obj, bool value,
>>       ss->migration_enabled =3D value;
>>         if (ss->migration_enabled) {
>> -        register_savevm_live(TYPE_S390_SKEYS, 0, 1,
>> +        register_savevm_live(TYPE_S390_SKEYS, VMSTATE_INSTANCE_ID_ANY, =
1,
>>                                &savevm_s390_storage_keys, ss);
>>       } else {
>>           unregister_savevm(VMSTATE_IF(ss), TYPE_S390_SKEYS, ss);
>> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
>> index 220e845d12..055d382c3c 100644
>> --- a/hw/s390x/s390-stattrib.c
>> +++ b/hw/s390x/s390-stattrib.c
>> @@ -13,6 +13,7 @@
>>   #include "qemu/units.h"
>>   #include "migration/qemu-file.h"
>>   #include "migration/register.h"
>> +#include "migration/vmstate.h"
>>   #include "hw/s390x/storage-attributes.h"
>>   #include "qemu/error-report.h"
>>   #include "exec/ram_addr.h"
>> @@ -380,7 +381,7 @@ static void s390_stattrib_instance_init(Object *obj)
>>   {
>>       S390StAttribState *sas =3D S390_STATTRIB(obj);
>>   -    register_savevm_live(TYPE_S390_STATTRIB, 0, 0,
>> +    register_savevm_live(TYPE_S390_STATTRIB, VMSTATE_INSTANCE_ID_ANY, 0,
>>                            &savevm_s390_stattrib_handlers, sas);
>>         object_property_add_bool(obj, "migration-enabled",


