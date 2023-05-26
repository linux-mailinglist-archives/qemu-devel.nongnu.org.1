Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A97D47121CD
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 10:05:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2SRG-0006yy-Ee; Fri, 26 May 2023 04:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q2SRD-0006yX-5W
 for qemu-devel@nongnu.org; Fri, 26 May 2023 04:04:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q2SRA-0003Ax-8J
 for qemu-devel@nongnu.org; Fri, 26 May 2023 04:04:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685088275;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EczcoLF+LssPP4M//aMirOcVJVFprv8Jv5ixRGdJIFQ=;
 b=ZrB5BiKOBfl81uYd0WcGUP5RnBXa659sA7IUVoVmllesDMzIkdLuXn9VM+9D6PtrTM3cg0
 e/61xsN32AbuvBNjJOCIIznXdarlhgLbNdk06Bw2vxQZxiXmRFGE8j6pm0LWTc0JaDYduu
 mC45uF8mBmLoT9bBnDnQMh/eqJizWu4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-BIfJOldRMX-2q8ml6XvUgw-1; Fri, 26 May 2023 04:04:33 -0400
X-MC-Unique: BIfJOldRMX-2q8ml6XvUgw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f60a4470cdso2039395e9.2
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 01:04:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685088273; x=1687680273;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EczcoLF+LssPP4M//aMirOcVJVFprv8Jv5ixRGdJIFQ=;
 b=Cn7xHnpiVyBP9pV5SNoEMOPM8Zbg9pdQCYubvN6nDV7qcA9fu+Q1znOeAU9qoYDlXr
 JIxmYaMKz+FWUQZJl2/Z3vr8qYzmsE/kaI8ojabAfn5qxO6Vzh51NUsGc6AIum+kfwkF
 7+wjIlXkqG+YjxvG1Zk+rWKQ0NbVI6DNdSeeATXnC+vqKlrmMmE96RIpo8Rfie5rV7Ic
 EnWWyAR9tydpfXczy0W1ppm3XPCcVasrkr0XInbHIz2ZoCLF7abTDJvazcOrC1epOQct
 zFmE7LEaFaf9YOcN2hI+ficBhzEJuz6Hzc0KPakrgD4BcRg0z6Prp8BxVWHcdMhc4xrf
 Knig==
X-Gm-Message-State: AC+VfDw/2XO5pmzFcd9yTqZBcGkGKTchsxTQzzmHPerfT7DRBP74VnVc
 hGOshavsEEXerzc2Xr+zopxi6ezVQDDK87l71EmeAQ6kqpC2W1ihLaxtfKcNKZLcPQ9g1wUs3L8
 NLMUFOMimJjim8C0=
X-Received: by 2002:a05:600c:2316:b0:3f6:15c:96fc with SMTP id
 22-20020a05600c231600b003f6015c96fcmr766561wmo.17.1685088272826; 
 Fri, 26 May 2023 01:04:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4rMWwrBf47jqD8j5mQ5QSjZZCjaOdON4ex50X/7HtJNzXROpp2EKFOxwgG+5wRJJe5THO8Cg==
X-Received: by 2002:a05:600c:2316:b0:3f6:15c:96fc with SMTP id
 22-20020a05600c231600b003f6015c96fcmr766531wmo.17.1685088272509; 
 Fri, 26 May 2023 01:04:32 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 d8-20020adffd88000000b003012030a0c6sm4251968wrr.18.2023.05.26.01.04.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 01:04:31 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Leonardo =?utf-8?Q?Br=C3=A1s?= <leobras@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Greg Kurz
 <groug@kaod.org>,  qemu-s390x@nongnu.org,  Fam Zheng <fam@euphon.net>,
 Ilya Leoshkevich <iii@linux.ibm.com>,  Halil Pasic <pasic@linux.ibm.com>,
 John Snow <jsnow@redhat.com>,  qemu-ppc@nongnu.org,  Daniel Henrique
 Barboza <danielhb413@gmail.com>,  Harsh Prateek Bora
 <harshpb@linux.ibm.com>,  Christian Borntraeger
 <borntraeger@linux.ibm.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  David Gibson
 <david@gibson.dropbear.id.au>,  David Hildenbrand <david@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,  Eric Farman
 <farman@linux.ibm.com>,  qemu-block@nongnu.org,  =?utf-8?Q?C=C3=A9dric?= Le
 Goater <clg@kaod.org>,  Eric Blake <eblake@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>
Subject: Re: [PATCH v2 02/16] migration: Correct transferred bytes value
In-Reply-To: <1e3a3735a5ba81abb562e8f6c21ab33f38992af5.camel@redhat.com>
 ("Leonardo =?utf-8?Q?Br=C3=A1s=22's?= message of "Mon, 22 May 2023 23:15:16
 -0300")
References: <20230515195709.63843-1-quintela@redhat.com>
 <20230515195709.63843-3-quintela@redhat.com>
 <1e3a3735a5ba81abb562e8f6c21ab33f38992af5.camel@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Fri, 26 May 2023 10:04:31 +0200
Message-ID: <87a5xr4iy8.fsf@secure.mitica>
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Leonardo Br=C3=A1s <leobras@redhat.com> wrote:
> On Mon, 2023-05-15 at 21:56 +0200, Juan Quintela wrote:
>> We forget several places to add to trasferred amount of data.  With
>> this fixes I get:
>>=20
>>    qemu_file_transferred() + multifd_bytes =3D=3D transferred
>>=20
>> The only place whrer this is not true is during devices sending.  But
>> going all through the full tree searching for devices that use
>> QEMUFile directly is a bit too much.
>>=20
>> Multifd, precopy and xbzrle work as expected. Postocpy still misses 35
>> bytes, but searching for them is getting complicated, so I stop here.
>>=20
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/ram.c       | 14 ++++++++++++++
>>  migration/savevm.c    | 19 +++++++++++++++++--
>>  migration/vmstate.c   |  3 +++
>>  migration/meson.build |  2 +-
>>  4 files changed, 35 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/migration/ram.c b/migration/ram.c
>> index f69d8d42b0..fd5a8db0f8 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -337,6 +337,7 @@ int64_t ramblock_recv_bitmap_send(QEMUFile *file,
>>=20=20
>>      g_free(le_bitmap);
>>=20=20
>> +    stat64_add(&mig_stats.transferred, 8 + size + 8);
>>      if (qemu_file_get_error(file)) {
>>          return qemu_file_get_error(file);
>>      }
>> @@ -1392,6 +1393,7 @@ static int find_dirty_block(RAMState *rs, PageSear=
chStatus *pss)
>>                      return ret;
>>                  }
>>                  qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
>> +                stat64_add(&mig_stats.transferred, 8);
>>                  qemu_fflush(f);
>>              }
>>              /*
>> @@ -3020,6 +3022,7 @@ static int ram_save_setup(QEMUFile *f, void *opaqu=
e)
>>      RAMState **rsp =3D opaque;
>>      RAMBlock *block;
>>      int ret;
>> +    size_t size =3D 0;
>>=20=20
>>      if (compress_threads_save_setup()) {
>>          return -1;
>> @@ -3038,16 +3041,20 @@ static int ram_save_setup(QEMUFile *f, void *opa=
que)
>>          qemu_put_be64(f, ram_bytes_total_with_ignored()
>>                           | RAM_SAVE_FLAG_MEM_SIZE);
>>=20=20
>> +        size +=3D 8;
>>          RAMBLOCK_FOREACH_MIGRATABLE(block) {
>>              qemu_put_byte(f, strlen(block->idstr));
>>              qemu_put_buffer(f, (uint8_t *)block->idstr, strlen(block->i=
dstr));
>>              qemu_put_be64(f, block->used_length);
>> +            size +=3D 1 + strlen(block->idstr) + 8;
>
> I was thinking some of them would look better with sizeof()s instead of g=
iven
> literal number, such as:
>
> size +=3D sizeof(Byte) + strlen(block->idstr) + sizeof(block->used_length=
);
>
> Maybe too much?

I dropped this patch for two reasons:

- reviewers gave me a bad time with it O:-)
- it was there only so if anyone was meassuring that new counters are
  the same that old counters.

But as I have already checked that, we don't need it.

I drop it on the next round that I send.
> Maybe, it would be nice to have qemu_put_* to return the value, and in th=
is
> case:
>
> size +=3D qemu_put_be64(...)
>
> What do you think?

Even more important than that is to return an error value, but that
is a very long project.

See on my next series that qemu_fflush() return errors, so code gets
simplifed:

qemu_fflush(file);
if (qemu_file_get_error(file)) {
    handle error;
}

to:

qemu_fflush(file);
if (qemu_file_get_error(file)) {
    handle error;
}

We need to do basically all qemu_put_*() and qemu_get_*() functions, but
it is a step on the right direction.

Later, Juan.


