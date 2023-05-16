Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A09704A0C
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 12:07:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyra8-0004Kt-90; Tue, 16 May 2023 06:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pyra5-0004KS-2n
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:06:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pyrZy-00041S-OK
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684231609;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HaUwCdMsaOUmwZlcX/eCL6Dp6eUdLrSa7CDc/D6BTPI=;
 b=WEKuyiY9gOX/VDzcIaGCo+tR+bPxiYyxm5W1aQ7mKv+3JDlh4U0pFXfF6sFI8nMybof16S
 PQJFOPxQhUb4+wIBYWJvpzRHJHTbjgu4C17pXRgjPgetw92eGqamayz7B9RM58cxIV4DNp
 GQS2cSvQLyFM0m9UF2StHqeJ2SwwImw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-xyVDqxnnMTawV_FJBKPJMg-1; Tue, 16 May 2023 06:06:48 -0400
X-MC-Unique: xyVDqxnnMTawV_FJBKPJMg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f421cfb4beso40188665e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 03:06:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684231607; x=1686823607;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HaUwCdMsaOUmwZlcX/eCL6Dp6eUdLrSa7CDc/D6BTPI=;
 b=CXPbDootWRhT1DV5tXXwhy7wIsTdmbW5TKtXsmXus2Q3wUxAEzD/nUNpVKMFVfqsA7
 sfE+sJ9meymn6Nt6Y3UJztBxK/V9iJX86Ka7NuKHac4RdQy+qvGYQWfjjf1bb9PTmcN+
 oa7+uzpyPBtltMN1UW4CMqROq1XJ7luDD2NUBVO5eiN2X6hchgPkoGXsxOGg8XUqdG8j
 7jtX3uoIMWNgPXH564yWA/vpPP5S/2+kNcXX0DJmpbERoFdavR7iE2fq40voKVXkzDZz
 OA/Wciom3EbwFLRMGryD1iF+yrGkmRE06fee5kaongxVVUiQ444IQ3pWgULyh543F1xP
 v48g==
X-Gm-Message-State: AC+VfDw+Qp/7pVWIjR7GvxgfQ0xfYgHCr41pz0P4lisR69pbNV6J/1nw
 tt4qK+//b5GqH5uyhqsctqY4U5P37mYf87ClVr0wc1ZAeqdYdT1oOLOmDmr9PhAnZZR2jUUfAO3
 Z8xqUmfzDMEon9KI=
X-Received: by 2002:adf:fb0c:0:b0:309:3573:b66a with SMTP id
 c12-20020adffb0c000000b003093573b66amr935115wrr.50.1684231607255; 
 Tue, 16 May 2023 03:06:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Z+ebd7+Cmxb/odBRsR/5QFz9mh+2fpwv7buNTlHwCWbsuV8T0Hp4QGp5RUR7FgNhr1aUVxQ==
X-Received: by 2002:adf:fb0c:0:b0:309:3573:b66a with SMTP id
 c12-20020adffb0c000000b003093573b66amr935096wrr.50.1684231606904; 
 Tue, 16 May 2023 03:06:46 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 d3-20020adff2c3000000b00307d58b3da9sm2064377wrp.25.2023.05.16.03.06.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 03:06:46 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: David Edmondson <david.edmondson@oracle.com>
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
 Goater <clg@kaod.org>,  Eric Blake <eblake@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH v2 03/16] migration: Move setup_time to mig_stats
In-Reply-To: <m27ct84noj.fsf@oracle.com> (David Edmondson's message of "Tue,
 16 May 2023 10:42:52 +0100")
References: <20230515195709.63843-1-quintela@redhat.com>
 <20230515195709.63843-4-quintela@redhat.com>
 <m27ct84noj.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Tue, 16 May 2023 12:06:45 +0200
Message-ID: <871qjgh9oq.fsf@secure.mitica>
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

David Edmondson <david.edmondson@oracle.com> wrote:
> Juan Quintela <quintela@redhat.com> writes:
>
>> It is a time that needs to be cleaned each time cancel migration.
>> Once there create migration_time_since() to calculate how time since a
>> time in the past.
>>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>
>> ---
>>
>> Rename to migration_time_since (c=C3=A9dric)
>> ---
>>  migration/migration-stats.h | 13 +++++++++++++
>>  migration/migration.h       |  1 -
>>  migration/migration-stats.c |  7 +++++++
>>  migration/migration.c       |  9 ++++-----
>>  4 files changed, 24 insertions(+), 6 deletions(-)
>>
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
>
> Is this really a Stat64? It doesn't appear to need the atomic update
> feature.

What this whole Migration Atomic Counters series try to do is that
everything becomes atomic and then we can use everything everywhere.

Before this series we had (I am simplifying here):

- transferred, precopy_bytes, postcopy_bytes, downtime_bytes -> atomic,
  you can use it anywhere

- qemu_file transferred -> you can only use it from the main migration
  thread

- qemu_file rate_limit -> you can only use it from the main migration
  thread

And we had to update the three counters in every place that we did a
write wehad to update all of them.

You can see the contorsions that we go to to update the rate_limit and
the qemu_file transferred fields.

After the series (you need to get what it is already on the tree, this
series, QEMUFileHooks cleanup, and another serie on my tree waiting for
this to be commited), you got three counters:

- qemu_file: atomic, everytime we do a qemu_file write we update it
- multifd_bytes: atomic, everytime that we do a write in a multifd
  channel, we update it.
- rdma_bytes: atomic, everytime we do a write through RDMA we update it.

And that is it.

Both rate_limit and transferred are derived from these three counters:

- at any point in time migration_transferred_bytes() returns the amount
  of bytes written since the start of the migration:
     qemu_file_bytes + multifd_bytes + rdma_bytes.

- transferred on this period:
       at_start_of_period =3D migration_transferred_bytes().
       trasferred_in_this_period =3D migration_transferred_bytes() - at_sta=
rt_of_period;

- Similar for precopy_bytes, postcopy_bytes and downtime_bytes.  When we
  move from one stage to the next, we store what is the value of the
  previous stage.

The counters that we use to calculate the rate limit are updated around
10 times per second (can be a bit bigger at the end of periods,
iterations, ...)  So performance is not extra critical.

But as we have way less atomic operations (really one per real write),
we don't really care a lot if we do some atomic operations when a normal
operation will do.

I.e. I think we have two options:

- have the remaining counters that are only used in the main migration
  thread not be atomic.  Document them and remember to do the correct
  thing everytime we use it.  If we need to use it in another thread,
  just change it to atomic.

- Make all counters atomic. No need to document anything.  And you can
  call any operation/counter/... in migration-stats.c from anywhere.

I think that the second option is better.  But I can hear reasons from
people that think that the 1st one is better.

Comments?

Later, Juan.


