Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB517121D5
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 10:08:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2SU8-0000zZ-3K; Fri, 26 May 2023 04:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q2SU6-0000yz-7B
 for qemu-devel@nongnu.org; Fri, 26 May 2023 04:07:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q2SU4-0003yp-FV
 for qemu-devel@nongnu.org; Fri, 26 May 2023 04:07:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685088455;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gSuUfRBLWUb0PoeqwthI9WA9PmbRW0xz8BxB1E59LOo=;
 b=Tzfh2nEMZxpgAGv32o1c7KKSuvRmtuijpuqpjYDYZ4Ep8merfSlinBXnlvuUOiQXeaV54J
 uD1yLcUfCIgY5cCayrLebxpYYssG6dn0z0I6EdYInKHm4XjHtwsZj+AomaYq5Wymo3RA3j
 Dvr/fh4qIAXZD80srkTTzPyWBnPnEzw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-62n9x_BcOHGmNP0lVbyK-g-1; Fri, 26 May 2023 04:07:34 -0400
X-MC-Unique: 62n9x_BcOHGmNP0lVbyK-g-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30aa0cc2152so268037f8f.2
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 01:07:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685088453; x=1687680453;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gSuUfRBLWUb0PoeqwthI9WA9PmbRW0xz8BxB1E59LOo=;
 b=FO7qS9p6QQ/KzQU1/0jg5D29tuFWX2CQzTLW5lhH9lZ9wBAxQOTbSfd3yzhozoBNI7
 msdvu0ywb9JcI0iTJgLsB3uxI+enBPPWTfqp2F4O7J0ElDT+e3ruZ1Twd7OY6oGftknA
 Un5FIkJJlkGaMK9KL/sqZbaP8HESw3chwPLIZYXSdPzX6F4XI4WBNPIVlGgod69W5aLn
 L8T+1AXaYNid/rBsy5J1enhY6njC2qTt7eU/V5peRqcd5vqVwg0AMNY03+Udd1PaAq3/
 7a8h37NrUkQJvF6G/lvPsxzeoZ/oy8jIBQqeRZvWqfafIuVriDfqJJckuu6Pu2sqY+Sw
 HShA==
X-Gm-Message-State: AC+VfDx6zGHHigF+fT1/+jIkJushvJ922gseEFRTel1g6QlFtD7fZwAA
 e+HDNudRYpadZILWhx5TSkbKMbImVZym4Tw0bfPplJpJWKfHsqKntPzkn/cbiLT+R0BWsKHDBKB
 VdwBKKdnik8WYEZY=
X-Received: by 2002:a5d:5044:0:b0:309:382e:b046 with SMTP id
 h4-20020a5d5044000000b00309382eb046mr694198wrt.60.1685088453527; 
 Fri, 26 May 2023 01:07:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6hLWhTEkKwJQwn2gP5UPJGKgh1/IGX+yUbZBM1iYKGqetMjStvpbDMvzjY1bMgZwfEMBFSgg==
X-Received: by 2002:a5d:5044:0:b0:309:382e:b046 with SMTP id
 h4-20020a5d5044000000b00309382eb046mr694160wrt.60.1685088453202; 
 Fri, 26 May 2023 01:07:33 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 o12-20020adfcf0c000000b002c71b4d476asm4251964wrj.106.2023.05.26.01.07.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 01:07:32 -0700 (PDT)
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
Subject: Re: [PATCH v2 03/16] migration: Move setup_time to mig_stats
In-Reply-To: <35a04e2de57e02745c18076990ce63fa6f61f5a4.camel@redhat.com>
 ("Leonardo =?utf-8?Q?Br=C3=A1s=22's?= message of "Wed, 24 May 2023 22:18:27
 -0300")
References: <20230515195709.63843-1-quintela@redhat.com>
 <20230515195709.63843-4-quintela@redhat.com>
 <35a04e2de57e02745c18076990ce63fa6f61f5a4.camel@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Fri, 26 May 2023 10:07:31 +0200
Message-ID: <875y8f4it8.fsf@secure.mitica>
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
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
>> It is a time that needs to be cleaned each time cancel migration.
>> Once there create migration_time_since() to calculate how time since a
>> time in the past.
>>=20
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>=20
>> ---
>>=20
>> Rename to migration_time_since (c=C3=A9dric)
>> ---
>>  migration/migration-stats.h | 13 +++++++++++++
>>  migration/migration.h       |  1 -
>>  migration/migration-stats.c |  7 +++++++
>>  migration/migration.c       |  9 ++++-----
>>  4 files changed, 24 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/migration/migration-stats.h b/migration/migration-stats.h
>> index e782f1b0df..21402af9e4 100644
>> --- a/migration/migration-stats.h
>> +++ b/migration/migration-stats.h
>> @@ -75,6 +75,10 @@ typedef struct {
>>       * Number of bytes sent during precopy stage.
>>       */
>>      Stat64 precopy_bytes;
>> +    /*
>> +     * How long has the setup stage took.
>> +     */
>> +    Stat64 setup_time;
>>      /*
>>       * Total number of bytes transferred.
>>       */
>> @@ -87,4 +91,13 @@ typedef struct {
>>=20=20
>>  extern MigrationAtomicStats mig_stats;
>>=20=20
>> +/**
>> + * migration_time_since: Calculate how much time has passed
>> + *
>> + * @stats: migration stats
>> + * @since: reference time since we want to calculate
>> + *
>> + * Returns: Nothing.  The time is stored in val.
>> + */
>> +void migration_time_since(MigrationAtomicStats *stats, int64_t since);
>>  #endif
>> diff --git a/migration/migration.h b/migration/migration.h
>> index 48a46123a0..27aa3b1035 100644
>> --- a/migration/migration.h
>> +++ b/migration/migration.h
>> @@ -316,7 +316,6 @@ struct MigrationState {
>>      int64_t downtime;
>>      int64_t expected_downtime;
>>      bool capabilities[MIGRATION_CAPABILITY__MAX];
>> -    int64_t setup_time;
>>      /*
>>       * Whether guest was running when we enter the completion stage.
>>       * If migration is interrupted by any reason, we need to continue
>> diff --git a/migration/migration-stats.c b/migration/migration-stats.c
>> index 2f2cea965c..3431453c90 100644
>> --- a/migration/migration-stats.c
>> +++ b/migration/migration-stats.c
>> @@ -12,6 +12,13 @@
>>=20=20
>>  #include "qemu/osdep.h"
>>  #include "qemu/stats64.h"
>> +#include "qemu/timer.h"
>>  #include "migration-stats.h"
>>=20=20
>>  MigrationAtomicStats mig_stats;
>> +
>> +void migration_time_since(MigrationAtomicStats *stats, int64_t since)
>> +{
>> +    int64_t now =3D qemu_clock_get_ms(QEMU_CLOCK_HOST);
>> +    stat64_set(&stats->setup_time, now - since);
>> +}
>
> IIUC this calculates a time delta and saves on stats->setup_time, is that=
 right?
>
> It took me some time to understand that, since the function name is
> migration_time_since(), which seems more generic.
>
> Would not be more intuitive to name it migration_setup_time_set() or so?

Dropped this.
Other reviewer commented that this was not a counter, what is right.  So
I left the times for future work (it don't interfere with current
cleanups).


> I could not see MigrationState->setup_time being initialized as 0 in this=
 patch.
> In a quick look in the code I noticed there is no initialization of this =
struct,
> but on qemu_savevm_state() and migrate_prepare() we have:
>
> memset(&mig_stats, 0, sizeof(mig_stats));
>
> I suppose this is enough, right?

Yeap.  All migration_stats() are initialized to zero at the start of
qemu, or when we start a migration.

After a migration, it don't matter if it finished with/without error,
they are there with the right value until we start another migration (in
the case of error, of course).

Later, Juan.


