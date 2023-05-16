Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4132170491E
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 11:25:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyqvS-0001hA-9O; Tue, 16 May 2023 05:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pyqvJ-0001dc-5c
 for qemu-devel@nongnu.org; Tue, 16 May 2023 05:24:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pyqvD-00032u-0a
 for qemu-devel@nongnu.org; Tue, 16 May 2023 05:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684229081;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=L7cLN1CPzKkJXBFROj2Ytl4mz0sGYvz/N3yBWh6sYaI=;
 b=YIxQgX+HTFJdEycf1+I2QwXc7OACMcI3qt+hegZzJViRS8L2XIfWZ7L1CSIBHlB6lC1prX
 0dAjo7ofra2hvaISc1zoaqlYxzeMoUX5R9UNob0lYIHFR7Ybe0CoOHvZjFZc6u3So8OYxw
 XPjivC31Jov1lU7SGImi9qs6EFRzGkA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-UYh3Fs5kNI-PGRJpPpw2Sw-1; Tue, 16 May 2023 05:24:39 -0400
X-MC-Unique: UYh3Fs5kNI-PGRJpPpw2Sw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-306489b7585so4870009f8f.3
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 02:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684229079; x=1686821079;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L7cLN1CPzKkJXBFROj2Ytl4mz0sGYvz/N3yBWh6sYaI=;
 b=hcEwmcq2GFFuS8fNv8Xe22iMeFSAtMeppQou23EoAyjeXX/Ab1zfp+OlzhdhDVF8IV
 J8W5N4J/TcWfkcSxVt3ZrpBX4JVJOLEqgGlkVRvVW1JBzn+AJlZMrshpnFb/zt2mnrAI
 X/CNnIFJdo+r3Zqe4xuq/arzxNmVjOrvqbH3vDisBgGFjKBpO/i0IC4eAdj3zbRL01JX
 QXsyfYcsAcoRDQePnujXWFsqOCZRcTHgt7RHur6walz8HI0KWEtcP247n7AtyB/93n3Y
 FWKGB0pvIl8i/o1hK+yBh3WmDf1F9saHaNazmhlDEtSBcVIav2HHjaenrOvwuhZnp1nG
 Kz6g==
X-Gm-Message-State: AC+VfDwABfbNTbxuOuWq6byidbG0KHWrubstjr/kYB4qIiBstevioJiR
 q6TDDN3hfH14ti57oDbMreRE9GyiemTWOT9/NQeCKfbScpYbcRIyHB1TssN6r04CNuEQy2TTFeI
 NCUT9r+jYRcQHxsU=
X-Received: by 2002:a05:6000:c:b0:306:32fa:6737 with SMTP id
 h12-20020a056000000c00b0030632fa6737mr25878969wrx.8.1684229078789; 
 Tue, 16 May 2023 02:24:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7BeHs5PAAu9IMZah+h065ETQAdJoamNSRRZoWOeTOD01tw0zHypC56cjEV33F2AUScc5bn+Q==
X-Received: by 2002:a05:6000:c:b0:306:32fa:6737 with SMTP id
 h12-20020a056000000c00b0030632fa6737mr25878941wrx.8.1684229078431; 
 Tue, 16 May 2023 02:24:38 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 d1-20020a056000114100b003062d815fa6sm1899902wrx.85.2023.05.16.02.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 02:24:37 -0700 (PDT)
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
Subject: Re: [PATCH v2 01/16] migration: Don't use INT64_MAX for unlimited rate
In-Reply-To: <m2fs7w4p0u.fsf@oracle.com> (David Edmondson's message of "Tue,
 16 May 2023 10:13:53 +0100")
References: <20230515195709.63843-1-quintela@redhat.com>
 <20230515195709.63843-2-quintela@redhat.com>
 <m2fs7w4p0u.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Tue, 16 May 2023 11:24:36 +0200
Message-ID: <874jocy6gb.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
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
>> Define and use RATE_LIMIT_MAX instead.
>
> Suggest "RATE_LIMIT_MAX_NONE".

Then even better

RATE_LIMIT_DISABLED?
RATE_LIMIT_NONE?

Using MAX and NONE at the same time looks strange.

>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/migration-stats.h | 6 ++++++
>>  migration/migration.c       | 4 ++--
>>  migration/qemu-file.c       | 6 +++++-
>>  3 files changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/migration/migration-stats.h b/migration/migration-stats.h
>> index cf8a4f0410..e782f1b0df 100644
>> --- a/migration/migration-stats.h
>> +++ b/migration/migration-stats.h
>> @@ -15,6 +15,12 @@
>>  
>>  #include "qemu/stats64.h"
>>  
>> +/*
>> + * If rate_limit_max is 0, there is special code to remove the rate
>> + * limit.
>> + */
>> +#define RATE_LIMIT_MAX 0
>> +
>>  /*
>>   * These are the ram migration statistic counters.  It is loosely
>>   * based on MigrationStats.  We change to Stat64 any counter that
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 039bba4804..c41c7491bb 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -2304,7 +2304,7 @@ static void migration_completion(MigrationState *s)
>>                   * them if migration fails or is cancelled.
>>                   */
>>                  s->block_inactive = !migrate_colo();
>> -                qemu_file_set_rate_limit(s->to_dst_file, INT64_MAX);
>> +                qemu_file_set_rate_limit(s->to_dst_file, RATE_LIMIT_MAX);
>>                  ret = qemu_savevm_state_complete_precopy(s->to_dst_file, false,
>>                                                           s->block_inactive);
>>              }
>> @@ -3048,7 +3048,7 @@ static void *bg_migration_thread(void *opaque)
>>      rcu_register_thread();
>>      object_ref(OBJECT(s));
>>  
>> -    qemu_file_set_rate_limit(s->to_dst_file, INT64_MAX);
>> +    qemu_file_set_rate_limit(s->to_dst_file, RATE_LIMIT_MAX);
>>  
>>      setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
>>      /*
>> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
>> index 597054759d..4bc875b452 100644
>> --- a/migration/qemu-file.c
>> +++ b/migration/qemu-file.c
>> @@ -27,6 +27,7 @@
>>  #include "qemu/error-report.h"
>>  #include "qemu/iov.h"
>>  #include "migration.h"
>> +#include "migration-stats.h"
>>  #include "qemu-file.h"
>>  #include "trace.h"
>>  #include "options.h"
>> @@ -732,7 +733,10 @@ int qemu_file_rate_limit(QEMUFile *f)
>
> Given that qemu_file_rate_limit() is really a boolean, could it be
> declared as such?

I wanted to do on this patch justn $Subject.

You can see that when I move this function to
migration/migration-stats.c already do the type change.

That is patch:

[PATCH v2 05/16] migration: Move rate_limit_max and rate_limit_used to
migration_stats

diff --git a/migration/migration-stats.c b/migration/migration-stats.c
index 3431453c90..1b16edae7d 100644
--- a/migration/migration-stats.c
+++ b/migration/migration-stats.c
@@ -22,3 +23,46 @@ void migration_time_since(MigrationAtomicStats *stats, int64_t since)
     int64_t now = qemu_clock_get_ms(QEMU_CLOCK_HOST);
     stat64_set(&stats->setup_time, now - since);
 }
+
+bool migration_rate_exceeded(QEMUFile *f)
+{
+    if (qemu_file_get_error(f)) {
+        return true;
+    }
+
+    uint64_t rate_limit_used = stat64_get(&mig_stats.rate_limit_used);
+    uint64_t rate_limit_max = stat64_get(&mig_stats.rate_limit_max);
+
+    if (rate_limit_max == RATE_LIMIT_MAX) {
+        return false;
+    }
+    if (rate_limit_max > 0 && rate_limit_used > rate_limit_max) {
+        return true;
+    }
+    return false;
+}

Thanks, Juan.


