Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FB4712203
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 10:19:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2SdO-0005M9-OV; Fri, 26 May 2023 04:17:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q2SdN-0005LT-A1
 for qemu-devel@nongnu.org; Fri, 26 May 2023 04:17:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q2SdL-0005u7-ND
 for qemu-devel@nongnu.org; Fri, 26 May 2023 04:17:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685089030;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qDraUE906Pb5HBgNrFLwxwnWt28FmktIRevbvXeRxbM=;
 b=ZYsQZYpK3JUkB+7e23Zrn/5+58RfnlIzBMcYOyJswvHegl9gVBk7defsMPQwe5JzWI17ZE
 zR/HpRPZbp11KFdac2a5bHoM1XvYsax5mSUlQtTYSH+18WZKy7UTF0yWbruqiGkn/QbO5B
 5meaPmLyTaTIZa6+L/YSvA3OmUGGDag=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-2YjO5laONk6ZBOK-2sZSTQ-1; Fri, 26 May 2023 04:17:07 -0400
X-MC-Unique: 2YjO5laONk6ZBOK-2sZSTQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f604260ef3so3310175e9.3
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 01:17:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685089026; x=1687681026;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qDraUE906Pb5HBgNrFLwxwnWt28FmktIRevbvXeRxbM=;
 b=gXlvWJqOBZMv1I7ONjYtl00t0Zhe0YOlcY1oxmELC/Q9YuWFZifAUyAFp1b/qd0nw2
 4l6vNKskpmkgjGR6Z+8hXWQjW0eIQwqOjWBqGT1nFbYkJ1JJReyZ+qYn22oIBBfoSVz2
 veIjQUJU2goJy6XLvtYPbjdNA0i46I3yfXZcs47mrPA041kYP7M3R6Rocqq7iLnt7raj
 B6NxVR99e+Zs0SrYdPb218lY9xVNapP7ZpTfHup/kTjwaqpNSn+Tv5THNpqljrBQ1mMp
 fjJYrwc29XoFwYIDX4P3v9jqCl0wbxl+QwRJJSsEyQyzEECbavpCh3bpp9yg5eYbRKdN
 KSUw==
X-Gm-Message-State: AC+VfDxOSiS2v0sHsr/Efpo1YqxZvjRKngnEfxaMFcuut1g4wl4Zr5gx
 n6vjyQzzL9Qbc/065bHvYYVYSsbR3xOG+Z1zCqNn6nt7K82M5fVEdkgMtRRY3giUOQzQ22l3DeJ
 pg7bQu4l3Eo1f3KQ=
X-Received: by 2002:a7b:c388:0:b0:3f4:253b:92a9 with SMTP id
 s8-20020a7bc388000000b003f4253b92a9mr824463wmj.30.1685089026432; 
 Fri, 26 May 2023 01:17:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5mW49x1DqXSgbodsWnjbzxkSfB9UIxc+gYY5PtMvH1GpeMp2uwSj2ySsjTs91g+okSoAX6/w==
X-Received: by 2002:a7b:c388:0:b0:3f4:253b:92a9 with SMTP id
 s8-20020a7bc388000000b003f4253b92a9mr824448wmj.30.1685089026107; 
 Fri, 26 May 2023 01:17:06 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 k15-20020a05600c0b4f00b003f611b2aedesm4372016wmr.38.2023.05.26.01.17.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 01:17:05 -0700 (PDT)
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
Subject: Re: [PATCH v2 08/16] migration: Use migration_transferred_bytes()
 to calculate rate_limit
In-Reply-To: <6f0660992a1bab629c52f5c3a869e730e299a0e8.camel@redhat.com>
 ("Leonardo =?utf-8?Q?Br=C3=A1s=22's?= message of "Thu, 25 May 2023 03:50:09
 -0300")
References: <20230515195709.63843-1-quintela@redhat.com>
 <20230515195709.63843-9-quintela@redhat.com>
 <6f0660992a1bab629c52f5c3a869e730e299a0e8.camel@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Fri, 26 May 2023 10:17:04 +0200
Message-ID: <87wn0v33sv.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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
> On Mon, 2023-05-15 at 21:57 +0200, Juan Quintela wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  migration/migration-stats.h | 8 +++++++-
>>  migration/migration-stats.c | 7 +++++--
>>  migration/migration.c       | 2 +-
>>  3 files changed, 13 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/migration/migration-stats.h b/migration/migration-stats.h
>> index 91fda378d3..f1465c2ebe 100644
>> --- a/migration/migration-stats.h
>> +++ b/migration/migration-stats.h
>> @@ -81,6 +81,10 @@ typedef struct {
>>       * Number of bytes sent during precopy stage.
>>       */
>>      Stat64 precopy_bytes;
>> +    /*
>> +     * Amount of transferred data at the start of current cycle.
>> +     */
>> +    Stat64 rate_limit_start;
>>      /*
>>       * Maximum amount of data we can send in a cycle.
>>       */
>> @@ -136,8 +140,10 @@ uint64_t migration_rate_get(void);
>>   * migration_rate_reset: Reset the rate limit counter.
>>   *
>>   * This is called when we know we start a new transfer cycle.
>> + *
>> + * @f: QEMUFile used for main migration channel
>>   */
>> -void migration_rate_reset(void);
>> +void migration_rate_reset(QEMUFile *f);
>>=20=20
>>  /**
>>   * migration_rate_set: Set the maximum amount that can be transferred.
>> diff --git a/migration/migration-stats.c b/migration/migration-stats.c
>> index 301392d208..da2bb69a15 100644
>> --- a/migration/migration-stats.c
>> +++ b/migration/migration-stats.c
>> @@ -31,7 +31,9 @@ bool migration_rate_exceeded(QEMUFile *f)
>>          return true;
>>      }
>>=20=20
>> -    uint64_t rate_limit_used =3D stat64_get(&mig_stats.rate_limit_used);
>> +    uint64_t rate_limit_start =3D stat64_get(&mig_stats.rate_limit_star=
t);
>> +    uint64_t rate_limit_current =3D migration_transferred_bytes(f);
>> +    uint64_t rate_limit_used =3D rate_limit_current - rate_limit_start;
>>      uint64_t rate_limit_max =3D stat64_get(&mig_stats.rate_limit_max);
>
> So, IIUC, instead of updating mig_stats.rate_limit_used every time data i=
s sent,
> the idea is to 'reset' it to migration_transferred_bytes() at the beginni=
ng of a
> cycle, and read migration_transferred_bytes() again for checking if the l=
imit
> was not crossed.
>
> Its a nice change since there is no need to update 2 counters, when 1 is =
enough.
>
> I think it would look nicer if squashed with 9/16, though. It would make =
it more
> clear this is being added to replace migration_rate_account() strategy.
>
> What do you think?

Already in tree.

Done this way because on my tree there was an intermediate patch that
did something like:


    uint64_t rate_limit_used =3D stat64_get(&mig_stats.rate_limit_used);
    uint64_t rate_limit_start =3D stat64_get(&mig_stats.rate_limit_start);
    uint64_t rate_limit_current =3D migration_transferred_bytes(f);
    uint64_t rate_limit_used_new =3D rate_limit_current - rate_limit_start;

    if (rate_limit_used_new !=3D rate_limit_used) {
        printf("rate_limit old %lu new %lu\n", ...);
    }

So I was sure that the counter that I was replacing had the same value
that the new one.

This is the reason why I fixed transferred atomic in the previous patch,
not because it mattered on the big scheme of things (migration_test was
missing something like 100KB for the normal stage when I started, that
for calculations don't matter).  But to check if I was doing the things
right it mattered.  With that patch my replacement counter was exact,
and none of the if's triggered.

Except for the device transffer stages, there I missed something like
900KB, but it made no sense to go all over the tree to fix a counter
that I was going to remove later.

Regards, Juan.


